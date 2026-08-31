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
      imports = [inputs.stylix.homeModules.stylix];
      my = {
        desktop.notificationForwarding = {
          enable = true;
          topicFile = "/build/module-contracts-notification/ntfy-topic";
        };
        graphics.enable = true;
      };
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
  assert !overriddenDevelopment.config.programs.nixvim.opts.number;
  assert !overriddenTerminal.config.programs.fish.enable;
    pkgs.runCommand "module-contracts" {} ''
      ${notificationActivation}
      first_topic="$(< /build/module-contracts-notification/ntfy-topic)"
      [[ "$first_topic" =~ ^[0-9a-f]{64}$ ]]
      [[ "$(stat -c '%a' /build/module-contracts-notification)" == 700 ]]
      [[ "$(stat -c '%a' /build/module-contracts-notification/ntfy-topic)" == 600 ]]

      ${notificationActivation}
      [[ "$(< /build/module-contracts-notification/ntfy-topic)" == "$first_topic" ]]

      touch "$out"
    ''
