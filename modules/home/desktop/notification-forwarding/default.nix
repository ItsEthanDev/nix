{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.notificationForwarding;
  python = pkgs.python3.withPackages (pythonPackages: [pythonPackages.dbus-next]);
  forwarder = pkgs.writeTextFile {
    name = "notification-forwarding";
    destination = "/bin/notification-forwarding";
    executable = true;
    text = ''
      #!${python}/bin/python3
      import asyncio
      import json
      import re
      import stat
      import sys
      import urllib.request
      from pathlib import Path

      from dbus_next import Message, MessageType
      from dbus_next.aio import MessageBus

      TOPIC_FILE = Path(${builtins.toJSON cfg.topicFile})
      TOPIC_PATTERN = re.compile(r"[-_A-Za-z0-9]{1,64}")
      NTFY_URL = "https://ntfy.sh/"


      def read_topic():
          try:
              mode = stat.S_IMODE(TOPIC_FILE.stat().st_mode)
              if mode & 0o077:
                  raise ValueError(f"{TOPIC_FILE} must not be accessible by group or others")
              topic = TOPIC_FILE.read_text(encoding="utf-8").strip()
          except OSError as error:
              raise RuntimeError(f"cannot read ntfy topic from {TOPIC_FILE}: {error}") from error

          if not TOPIC_PATTERN.fullmatch(topic):
              raise ValueError("ntfy topic must contain 1-64 letters, numbers, underscores, or dashes")
          return topic


      def publish(topic, app_name, summary):
          payload = json.dumps({
              "topic": topic,
              "title": app_name or "Desktop",
              "message": summary or "Desktop notification",
          }).encode("utf-8")
          request = urllib.request.Request(
              NTFY_URL,
              data=payload,
              headers={"Content-Type": "application/json", "User-Agent": "notification-forwarding"},
              method="POST",
          )
          with urllib.request.urlopen(request, timeout=10) as response:
              response.read()


      async def main():
          topic = read_topic()
          bus = await MessageBus().connect()
          tasks = set()

          def handle_message(message):
              if (
                  message.message_type != MessageType.METHOD_CALL
                  or message.interface != "org.freedesktop.Notifications"
                  or message.member != "Notify"
                  or len(message.body) != 8
              ):
                  return False

              app_name, _, _, summary, _, _, _, _ = message.body

              async def send():
                  try:
                      await asyncio.to_thread(publish, topic, app_name, summary)
                  except Exception as error:
                      print(f"notification-forwarding: ntfy request failed: {error}", file=sys.stderr)

              task = asyncio.create_task(send())
              tasks.add(task)
              task.add_done_callback(tasks.discard)
              return False

          bus.add_message_handler(handle_message)
          reply = await bus.call(Message(
              destination="org.freedesktop.DBus",
              path="/org/freedesktop/DBus",
              interface="org.freedesktop.DBus.Monitoring",
              member="BecomeMonitor",
              signature="asu",
              body=[["type='method_call',interface='org.freedesktop.Notifications',member='Notify'"], 0],
          ))
          if reply.message_type == MessageType.ERROR:
              raise RuntimeError(f"could not monitor desktop notifications: {reply.error_name}")

          await bus.wait_for_disconnect()


      if __name__ == "__main__":
          try:
              asyncio.run(main())
          except Exception as error:
              print(f"notification-forwarding: {error}", file=sys.stderr)
              raise SystemExit(1)
    '';
  };
in {
  options.my.desktop.notificationForwarding = {
    enable = lib.mkEnableOption "forwarding desktop notification titles to ntfy while the session is locked";
    topicFile = lib.mkOption {
      type = lib.types.str;
      default = "${config.xdg.configHome}/notification-forwarding/ntfy-topic";
      description = "Runtime path to a private file containing the ntfy topic name.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "Desktop notification forwarding requires Linux.";
      }
      {
        assertion = config.my.graphics.enable;
        message = "Desktop notification forwarding requires the graphical environment.";
      }
    ];

    home.activation.initializeNotificationForwardingTopic = lib.hm.dag.entryAfter ["writeBoundary"] ''
      topic_file=${lib.escapeShellArg cfg.topicFile}
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

    programs.noctalia.settings.hooks = {
      session_locked = "systemctl --user start notification-forwarding.service";
      session_unlocked = "systemctl --user stop notification-forwarding.service";
    };

    systemd.user.services.notification-forwarding = {
      Unit.Description = "Forward desktop notification titles to ntfy";
      Service.ExecStart = lib.getExe forwarder;
    };
  };
}
