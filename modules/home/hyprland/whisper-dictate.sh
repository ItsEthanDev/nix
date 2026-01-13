#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
if [[ ! -d "$state_dir" ]]; then
  state_dir="/tmp"
fi

pid_file="$state_dir/whisper-dictate.pid"
audio_file="$state_dir/whisper-dictate.wav"
log_file="$state_dir/whisper-dictate.log"

log() {
  echo "$(date +"%F %T") $*" >>"$log_file"
}

pick_recorder() {
  if command -v pw-record >/dev/null 2>&1; then
    echo "pw-record"
  else
    echo "ffmpeg"
  fi
}

start_recording() {
  rm -f "$audio_file" "$log_file"
  pkill -f "$audio_file" 2>/dev/null || true
  recorder="$(pick_recorder)"
  log "State dir: $state_dir"
  log "Recorder: $recorder"

  if [[ "$recorder" == "pw-record" ]]; then
    pw-record --rate 16000 --channels 1 "$audio_file" >>"$log_file" 2>&1 &
  else
    source_name="default"
    if command -v pactl >/dev/null 2>&1; then
      source_name="$(pactl get-default-source 2>/dev/null || true)"
      if [[ -z "$source_name" ]]; then
        source_name="default"
      fi
      {
        echo "Using source: $source_name"
        pactl info
        pactl list short sources
      } >>"$log_file" 2>&1
    elif command -v wpctl >/dev/null 2>&1; then
      default_source_id="$(wpctl get-default-source 2>/dev/null | tr -d '\n')"
      if [[ -n "$default_source_id" ]]; then
        source_name="$(wpctl inspect "$default_source_id" 2>/dev/null | awk -F '"' '/node.name/ {print $2; exit}')"
      fi
      if [[ -z "$source_name" ]]; then
        source_name="default"
      fi
      {
        echo "Using source from wpctl: $source_name"
        wpctl status
        wpctl inspect "$default_source_id"
      } >>"$log_file" 2>&1
    else
      echo "pactl/wpctl not found; using default source" >>"$log_file"
    fi
    ffmpeg -nostdin -y -f pulse -i "$source_name" -ac 1 -ar 16000 "$audio_file" >>"$log_file" 2>&1 &
  fi

  echo $! >"$pid_file"
  sleep 0.2
  if ! kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    notify-send "Dictation failed" "Recorder failed to start (see $log_file)"
    rm -f "$pid_file"
    return
  fi
  notify-send "Dictation started" "Press the hotkey to stop"
}

wait_for_exit() {
  local pid="$1"
  for _ in {1..40}; do
    if kill -0 "$pid" 2>/dev/null; then
      sleep 0.1
    else
      return 0
    fi
  done
  return 1
}

wait_for_audio() {
  for _ in {1..40}; do
    if [[ -s "$audio_file" ]]; then
      return 0
    fi
    sleep 0.1
  done
  return 1
}

stop_recording() {
  local pid=""
  if [[ -f "$pid_file" ]]; then
    pid="$(cat "$pid_file")"
  fi
  log "Stopping; pid: ${pid:-none}"

  if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
    kill -INT "$pid" 2>/dev/null || true
    wait_for_exit "$pid" || true
  else
    pkill -f "$audio_file" 2>/dev/null || true
  fi

  rm -f "$pid_file"
  wait_for_audio || true
  ls -l "$audio_file" >>"$log_file" 2>&1 || true

  if [[ ! -s "$audio_file" ]]; then
    notify-send "Dictation failed" "No audio captured (see $log_file)"
    return
  fi

  notify-send "Dictation stopped" "Transcribing…"
  whisper "$audio_file" --model base --output_format txt --output_dir "$state_dir" --fp16 False >>"$log_file" 2>&1
  local transcript="${audio_file%.*}.txt"
  local alt_transcript="${audio_file}.txt"
  if [[ -f "$transcript" ]]; then
    wl-copy <"$transcript"
    notify-send "Dictation copied" "Text sent to clipboard"
  elif [[ -f "$alt_transcript" ]]; then
    wl-copy <"$alt_transcript"
    notify-send "Dictation copied" "Text sent to clipboard"
  else
    notify-send "Dictation failed" "No transcription produced (see $log_file)"
  fi
}

if [[ -f "$pid_file" ]]; then
  if kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    stop_recording
    exit 0
  fi
  rm -f "$pid_file"
fi

start_recording
