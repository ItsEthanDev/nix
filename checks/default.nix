{
  darwinModules,
  home-manager,
  homeManagerModules,
  inputs,
  nixosModules,
  nixpkgs,
  pkgs,
}: let
  inherit (nixpkgs) lib;

  mkNixos = modules:
    lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [nixosModules.default] ++ modules;
    };

  mkDarwin = modules:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules =
        [
          darwinModules.default
          {nixpkgs.hostPlatform = "aarch64-darwin";}
        ]
        ++ modules;
    };

  homeBase = {
    home = {
      username = "test";
      homeDirectory = "/home/test";
      stateVersion = "25.05";
    };
  };

  mkHome = modules:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      modules = [homeManagerModules.default homeBase] ++ modules;
    };

  disabledNixos = mkNixos [];
  invalidSsh = mkNixos [
    {
      my.remote.ssh = {
        enable = true;
        user = "test";
      };
    }
  ];
  overriddenGaming = mkNixos [
    {
      my.gaming.enable = true;
      programs.steam.enable = false;
    }
  ];

  disabledDarwin = mkDarwin [];
  overriddenAerospace = mkDarwin [
    {
      my.aerospace.enable = true;
      services.aerospace.settings.mode.main.binding."cmd-f" = "layout floating tiling";
    }
  ];

  disabledHome = mkHome [];
  enabledNotificationForwarding = mkHome [
    {
      imports = [
        ../homes/x86_64-linux/turing/notification-forwarding.nix
        inputs.stylix.homeModules.stylix
      ];
      my.graphics.enable = true;
      programs.herdr.enable = true;
      xdg.configHome = "/build/module-contracts-notification";
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
      };
    }
  ];
  overriddenDevelopment = mkHome [
    {
      my.development = {
        enable = true;
        git = {
          email = "test@example.com";
          name = "Test User";
        };
      };
      programs.nixvim.opts.number = false;
    }
  ];
  overriddenTerminal = mkHome [
    {
      my.terminal.enable = true;
      programs.fish.enable = false;
    }
  ];

  findAssertion = message: assertions:
    lib.findFirst (candidate: candidate.message == message) null assertions;

  notificationActivation = enabledNotificationForwarding.config.home.activation.initializeNotificationForwardingTopic.data;
  notificationTopicDirectory = "/build/module-contracts-notification/notification-forwarding";
  notificationTopicFile = "${notificationTopicDirectory}/ntfy-topic";
  notificationHerdrPlugin = enabledNotificationForwarding.config.xdg.configFile."herdr/managed-plugins/locked-agent-notifications".source;
  notificationPiIntegration = enabledNotificationForwarding.config.home.file.".pi/agent/extensions/herdr-agent-state.ts".source;
  notificationFakeSystemctl = pkgs.writeShellScript "notification-fake-systemctl" ''
    [[ "''${LOCKED:-0}" == 1 ]]
  '';
  notificationFakeNotify = pkgs.writeShellScript "notification-fake-notify" ''
    printf '%s\n' "$*" >> "$NOTIFICATIONS"
  '';
  notificationFakeHerdr = pkgs.writeShellScript "notification-fake-herdr" ''
    printf '{"result":{"agent":{"agent":"pi","agent_status":"%s"}}}\n' "$CURRENT_STATUS"
  '';
  sshAssertion =
    findAssertion
    "my.remote.ssh.user and my.remote.ssh.keyDirectory must be set together."
    invalidSsh.config.assertions;
in
  assert !disabledNixos.config.services.openssh.enable;
  assert !disabledNixos.config.programs.steam.enable;
  assert sshAssertion != null && !sshAssertion.assertion;
  assert !overriddenGaming.config.programs.steam.enable;
  assert !disabledDarwin.config.services.aerospace.enable;
  assert overriddenAerospace.config.services.aerospace.settings.mode.main.binding."cmd-f" == "layout floating tiling";
  assert !disabledHome.config.programs.fish.enable;
  assert !disabledHome.config.programs.git.enable;
  assert !disabledHome.config.programs.nixvim.enable;
  assert enabledNotificationForwarding.config.home.activation ? initializeNotificationForwardingTopic;
  assert enabledNotificationForwarding.config.home.activation ? reconcileNotificationForwardingHerdrPlugin;
  assert enabledNotificationForwarding.config.systemd.user.services.herdr-notifications-locked.Service.Type == "oneshot";
  assert enabledNotificationForwarding.config.programs.herdr.settings.ui.toast.delivery == "off";
  assert !overriddenDevelopment.config.programs.nixvim.opts.number;
  assert !overriddenTerminal.config.programs.fish.enable;
    pkgs.runCommand "module-contracts" {} ''
      ${notificationActivation}
      first_topic="$(< ${notificationTopicFile})"
      [[ "$first_topic" =~ ^[0-9a-f]{64}$ ]]
      [[ "$(stat -c '%a' ${notificationTopicDirectory})" == 700 ]]
      [[ "$(stat -c '%a' ${notificationTopicFile})" == 600 ]]

      ${notificationActivation}
      [[ "$(< ${notificationTopicFile})" == "$first_topic" ]]

      handler="$(${lib.getExe pkgs.python3} -c 'import sys, tomllib; print(tomllib.load(open(sys.argv[1], "rb"))["events"][0]["command"][0])' ${notificationHerdrPlugin}/herdr-plugin.toml)"
      state_dir="$TMPDIR/plugin-state"
      notifications="$TMPDIR/notifications"
      fake_systemctl=${notificationFakeSystemctl}
      fake_notify=${notificationFakeNotify}
      fake_herdr=${notificationFakeHerdr}

      run_event() {
        status="$1"
        CURRENT_STATUS="''${2:-$status}" \
        LOCKED=0 \
        NOTIFICATIONS="$notifications" \
        HERDR_PLUGIN_STATE_DIR="$state_dir" \
        HERDR_PLUGIN_CONTEXT_JSON='{"workspace_label":"nix","tab_label":"agent"}' \
        HERDR_PLUGIN_EVENT_JSON="$(${lib.getExe pkgs.jq} -nc --arg status "$status" '{data: {type: "pane_agent_status_changed", pane_id: "w1:p1", workspace_id: "w1", agent: "pi", agent_status: $status}}')" \
          "$handler" "$fake_systemctl" "$fake_notify" "$fake_herdr"
      }

      run_event idle
      [[ ! -e "$notifications" ]]
      run_event working
      run_event idle working # A superseded status is not actionable.
      [[ ! -e "$notifications" ]]
      run_event working
      run_event idle
      [[ "$(wc -l < "$notifications")" == 1 ]]
      grep -q 'pi finished.*nix · agent' "$notifications"
      run_event idle
      [[ "$(wc -l < "$notifications")" == 1 ]]
      run_event working
      run_event blocked
      [[ "$(wc -l < "$notifications")" == 2 ]]
      grep -q 'pi needs input' "$notifications"
      run_event idle # No duplicate after the block is resolved.
      [[ "$(wc -l < "$notifications")" == 2 ]]
      run_event working
      run_event done
      run_event idle
      [[ "$(wc -l < "$notifications")" == 3 ]]
      run_event working
      run_event unknown
      run_event idle
      [[ "$(wc -l < "$notifications")" == 3 ]]

      run_event working
      run_event idle &
      first_finish=$!
      ${lib.getExe' pkgs.coreutils "sleep"} 0.5
      run_event working
      run_event idle
      wait "$first_finish"
      [[ "$(wc -l < "$notifications")" == 4 ]]

      ${lib.getExe pkgs.nodejs} --input-type=module <<'JS'
      import net from 'node:net';
      import { mkdtempSync } from 'node:fs';
      import { tmpdir } from 'node:os';
      import path from 'node:path';
      const socket = path.join(mkdtempSync(path.join(tmpdir(), 'herdr-pi-')), 'socket');
      const reports = [];
      const server = net.createServer(client => client.on('data', bytes => {
        for (const line of bytes.toString().trim().split('\n')) {
          const request = JSON.parse(line);
          if (request.method === 'pane.report_agent') reports.push(request.params.state);
        }
        client.write('{}\n');
      }));
      await new Promise(resolve => server.listen(socket, resolve));
      process.env.HERDR_ENV = '1';
      process.env.HERDR_PANE_ID = 'w1:p1';
      process.env.HERDR_SOCKET_PATH = socket;
      const { default: install } = await import('${notificationPiIntegration}');
      const hooks = new Map();
      const events = new Map();
      install({ on: (name, hook) => hooks.set(name, hook), events: { on: (name, hook) => events.set(name, hook) } });
      const ctx = { mode: 'tui', isIdle: () => true, sessionManager: { getSessionId: () => 'test' } };
      await hooks.get('session_start')({}, ctx);
      hooks.get('agent_start')({}, ctx);
      await new Promise(resolve => setTimeout(resolve, 80));
      events.get('herdr:busy')({ active: true });
      hooks.get('agent_settled')({}, ctx);
      await new Promise(resolve => setTimeout(resolve, 80));
      if (reports.at(-1) !== 'working') throw Error('parent became idle while subagents were active');
      events.get('herdr:busy')({ active: false });
      await new Promise(resolve => setTimeout(resolve, 80));
      if (reports.at(-1) !== 'working') throw Error('parent became idle before synthesizing the subagent result');
      hooks.get('agent_start')({}, ctx);
      hooks.get('agent_settled')({}, ctx);
      await new Promise(resolve => setTimeout(resolve, 80));
      if (reports.at(-1) !== 'idle') throw Error('parent did not become idle after its final turn');
      server.close();
      JS

      touch "$out"
    ''
