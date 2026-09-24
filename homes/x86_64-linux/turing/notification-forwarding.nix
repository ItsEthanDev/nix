{
  config,
  lib,
  pkgs,
  ...
}: let
  topicFile = "${config.xdg.configHome}/notification-forwarding/ntfy-topic";
  piIntegration = pkgs.runCommand "herdr-pi-agent-state.ts" {nativeBuildInputs = [pkgs.python3];} ''
    python3 - ${pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/herdrdev/herdr/v0.9.1/src/integration/assets/pi/herdr-agent-state.ts";
      sha256 = "1r51mjp8icj2lhq2ah61s91zw9cdz6qh6wh23bwvnxdl6bbp4lic";
    }} "$out" <<'PY'
    import sys
    from pathlib import Path

    source = Path(sys.argv[1]).read_text()
    # The upstream integration reports idle at agent_settled even when Pi has
    # handed work to asynchronous subagents. Keep Herdr working until they finish.
    old = '  let agentActive = false;\n  let blockedCount = 0;'
    new = '  let agentActive = false;\n  let busy = false;\n  let awaitingParent = false;\n  let resumedWhileBusy = false;\n  let blockedCount = 0;'
    assert source.count(old) == 1
    source = source.replace(old, new)
    old = '    if (agentActive) {\n      return { state: "working" as const, message: undefined };\n    }'
    new = '    if (agentActive || busy || awaitingParent) {\n      return { state: "working" as const, message: undefined };\n    }'
    assert source.count(old) == 1
    source = source.replace(old, new)
    old = '  pi.events.on("herdr:blocked", (data) => {'
    new = ('  pi.events.on("herdr:busy", (data) => {\n'
           '    if (!rootSession) return;\n'
           '    busy = data?.active === true;\n'
           '    if (busy) {\n'
           '      awaitingParent = true;\n'
           '      resumedWhileBusy = false;\n'
           '    } else if (agentActive && resumedWhileBusy) {\n'
           '      awaitingParent = false;\n'
           '    }\n'
           '    publishState();\n'
           '  });\n\n'
           '  pi.events.on("herdr:blocked", (data) => {')
    assert source.count(old) == 1
    source = source.replace(old, new)
    old = '    agentActive = true;\n    publishState();'
    new = ('    agentActive = true;\n'
           '    if (awaitingParent) {\n'
           '      resumedWhileBusy = busy;\n'
           '      if (!busy) awaitingParent = false;\n'
           '    }\n'
           '    publishState();')
    assert source.count(old) == 1
    source = source.replace(old, new)
    old = '    agentActive = false;\n    publishState();'
    new = ('    agentActive = false;\n'
           '    if (busy) resumedWhileBusy = false;\n'
           '    publishState();')
    assert source.count(old) == 1
    source = source.replace(old, new)
    Path(sys.argv[2]).write_text(source)
    PY
  '';
  handler = pkgs.writeTextFile {
    name = "herdr-agent-notification";
    destination = "/bin/herdr-agent-notification";
    executable = true;
    text = ''
      #!${pkgs.python3}/bin/python3
      import fcntl
      import json
      import os
      import re
      import stat
      import subprocess
      import sys
      import tempfile
      import time
      import urllib.request
      from pathlib import Path

      TOPIC_FILE = Path(${builtins.toJSON topicFile})
      TOPIC_PATTERN = re.compile(r"[-_A-Za-z0-9]{1,64}")
      NTFY_URL = "https://ntfy.sh/"


      def read_topic():
          mode = stat.S_IMODE(TOPIC_FILE.stat().st_mode)
          if mode & 0o077:
              raise ValueError("ntfy topic must not be accessible by group or others")
          topic = TOPIC_FILE.read_text(encoding="utf-8").strip()
          if not TOPIC_PATTERN.fullmatch(topic):
              raise ValueError("invalid ntfy topic")
          return topic


      def publish(title, location):
          payload = json.dumps({
              "topic": read_topic(),
              "title": title,
              "message": location,
          }).encode("utf-8")
          request = urllib.request.Request(
              os.environ.get("HERDR_NOTIFICATION_URL", NTFY_URL),
              data=payload,
              headers={"Content-Type": "application/json", "User-Agent": "herdr-agent-notification"},
              method="POST",
          )
          with urllib.request.urlopen(request, timeout=10) as response:
              response.read()


      def main():
          systemctl, notify_send, herdr = sys.argv[1:]
          event = json.loads(os.environ["HERDR_PLUGIN_EVENT_JSON"])
          data = event.get("data", event)
          pane_id = data["pane_id"]
          agent = data.get("agent")
          status = data["agent_status"]
          if status not in {"idle", "working", "blocked", "done", "unknown"}:
              raise ValueError("invalid agent status")
          state_dir = Path(os.environ["HERDR_PLUGIN_STATE_DIR"])
          state_dir.mkdir(mode=0o700, parents=True, exist_ok=True)
          context = json.loads(os.environ.get("HERDR_PLUGIN_CONTEXT_JSON", "{}"))

          with (state_dir / "agent-status.lock").open("a+") as lock:
              os.fchmod(lock.fileno(), 0o600)
              fcntl.flock(lock, fcntl.LOCK_EX)
              state_path = state_dir / "agent-status.json"
              try:
                  state = json.loads(state_path.read_text(encoding="utf-8"))
              except FileNotFoundError:
                  state = {}
              previous = state.get(pane_id, {})
              was_working = previous.get("agent") == agent and previous.get("status") == "working"
              message = None
              if was_working and status in {"idle", "done"}:
                  message = "finished"
              elif was_working and status == "blocked":
                  message = "needs input"
              generation = previous.get("generation", 0) + 1
              state[pane_id] = {"agent": agent, "status": status, "generation": generation}
              with tempfile.NamedTemporaryFile(mode="w", dir=state_dir, delete=False) as tmp:
                  json.dump(state, tmp)
                  tmp.write("\n")
                  temp_path = Path(tmp.name)
              temp_path.chmod(0o600)
              temp_path.replace(state_path)

          if message is None or agent is None:
              return
          if message == "finished":
              time.sleep(2)
          # A resumed parent or another pane occupant cancels an earlier finish.
          if json.loads(state_path.read_text(encoding="utf-8")).get(pane_id, {}).get("generation") != generation:
              return
          info = json.loads(subprocess.check_output([herdr, "agent", "get", pane_id], timeout=5))["result"]["agent"]
          if info.get("agent") != agent or info.get("agent_status") not in ({"idle", "done"} if message == "finished" else {"blocked"}):
              return
          workspace = context.get("workspace_label") or data.get("workspace_id") or "workspace"
          tab = context.get("tab_label")
          location = f"{workspace} · {tab}" if tab and not str(tab).isdigit() else str(workspace)
          title = f"{agent} {message}"
          locked = subprocess.run(
              [systemctl, "--user", "is-active", "--quiet", "herdr-notifications-locked.service"],
              check=False,
          ).returncode == 0
          if locked:
              publish(title, location)
          else:
              subprocess.run([notify_send, "--", title, location], check=True)


      if __name__ == "__main__":
          try:
              main()
          except Exception as error:
              print(f"herdr-agent-notification: {error}", file=sys.stderr)
              raise SystemExit(1)
    '';
  };
  herdrPlugin = pkgs.writeTextDir "herdr-plugin.toml" ''
    id = "local.locked-agent-notifications"
    name = "Agent notifications"
    version = "2.0.0"
    min_herdr_version = "0.7.0"
    description = "Notify when a Herdr agent finishes or needs input."
    platforms = ["linux"]

    [[events]]
    on = "pane.agent_status_changed"
    command = ["${lib.getExe handler}", "${lib.getExe' pkgs.systemd "systemctl"}", "${lib.getExe' pkgs.libnotify "notify-send"}", "${lib.getExe config.programs.herdr.package}"]
  '';
in {
  home.file.".pi/agent/extensions/herdr-agent-state.ts".source = piIntegration;

  home.activation = {
    initializeNotificationForwardingTopic = lib.hm.dag.entryAfter ["writeBoundary"] ''
      topic_file=${lib.escapeShellArg topicFile}
      topic_dir="$(${lib.getExe' pkgs.coreutils "dirname"} "$topic_file")"
      ${lib.getExe' pkgs.coreutils "install"} -d -m 0700 "$topic_dir"
      ${lib.getExe' pkgs.coreutils "chmod"} 0700 "$topic_dir"
      if [[ ! -e "$topic_file" ]]; then
        umask 077
        topic="$(${lib.getExe' pkgs.coreutils "tr"} -d - </proc/sys/kernel/random/uuid)$(${lib.getExe' pkgs.coreutils "tr"} -d - </proc/sys/kernel/random/uuid)"
        printf '%s\n' "$topic" > "$topic_file"
      fi
      ${lib.getExe' pkgs.coreutils "chmod"} 0600 "$topic_file"
    '';
    reconcileNotificationForwardingHerdrPlugin = lib.hm.dag.entryAfter ["linkGeneration"] ''
      ${lib.getExe config.programs.herdr.package} plugin link ${lib.escapeShellArg "${config.xdg.configHome}/herdr/managed-plugins/locked-agent-notifications"} --enabled >/dev/null
    '';
  };

  programs.herdr.settings.ui.toast.delivery = "off";
  programs.noctalia.settings.hooks = {
    session_locked = "systemctl --user start herdr-notifications-locked.service";
    session_unlocked = "systemctl --user stop herdr-notifications-locked.service";
  };

  systemd.user.services.herdr-notifications-locked = {
    Unit.Description = "Screen locked for Herdr phone notifications";
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe' pkgs.coreutils "true";
      RemainAfterExit = true;
    };
  };

  xdg.configFile."herdr/managed-plugins/locked-agent-notifications".source = herdrPlugin;
}
