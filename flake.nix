{
  description = "It's Ethan's configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    zapp.url = "github:zsa/zapp";
  };

  outputs = {
    self,
    home-manager,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
  in {
    lib = import ./lib {
      inherit (nixpkgs) lib;
      inherit inputs;
    };

    overlays = import ./overlays {
      inherit self;
      inherit inputs;
      inherit (nixpkgs) lib;
    };

    packages = self.lib.forAllSystems (
      system:
        import ./packages {
          pkgs = pkgsFor system;
        }
    );

    devShells = self.lib.forAllSystems (
      system:
        import ./shells {
          pkgs = pkgsFor system;
        }
    );

    darwinConfigurations = {
      newton = nix-darwin.lib.darwinSystem {
        modules = [
          {nixpkgs.overlays = [self.overlays.default];}
          ./systems/aarch64-darwin/newton
          ./modules/darwin/aerospace
          ./modules/darwin/fish
          ./modules/darwin/ghostty
          ./modules/darwin/homebrew
          ./modules/darwin/network
          ./modules/darwin/nix
          ./modules/darwin/settings
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.ethan = {
                imports = [
                  ./homes/aarch64-darwin/newton
                  ./modules/home/catppuccin
                  ./modules/home/cli
                  ./modules/home/fish
                  ./modules/home/ghostty
                  ./modules/home/git
                  ./modules/home/javascript
                  ./modules/home/nixvim
                  ./modules/home/opencode
                  ./modules/home/rust
                  ./modules/home/ssh
                  ./modules/home/starship
                  ./modules/home/zellij
                  ./modules/home/zsh
                ];
              };
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      turing = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {nixpkgs.overlays = [self.overlays.default];}
          ./systems/x86_64-linux/turing
          ./modules/nixos/1password
          ./modules/nixos/audio
          ./modules/nixos/bluetooth
          ./modules/nixos/catppuccin
          ./modules/nixos/boot
          ./modules/nixos/flatpak
          ./modules/nixos/font
          ./modules/nixos/hyprland
          ./modules/nixos/kde-connect
          ./modules/nixos/llama
          ./modules/nixos/locale
          ./modules/nixos/localsend
          ./modules/nixos/network
          ./modules/nixos/nix
          ./modules/nixos/ssh
          ./modules/nixos/sunshine
          ./modules/nixos/tailscale
          ./modules/nixos/user
          ./modules/nixos/wayland
          ./modules/nixos/zen
          ./modules/nixos/zsa
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.ethan = {
                imports = [
                  ./homes/x86_64-linux/turing
                  ./modules/home
                  ./modules/home/banana-cursor
                  ./modules/home/catppuccin
                  ./modules/home/cli
                  ./modules/home/discord
                  ./modules/home/easy-effects
                  ./modules/home/fish
                  ./modules/home/ghostty
                  ./modules/home/git
                  ./modules/home/hyprland
                  ./modules/home/gtk
                  ./modules/home/javascript
                  ./modules/home/mangohud
                  ./modules/home/mpd
                  ./modules/home/nixvim
                  ./modules/home/obsidian
                  ./modules/home/ollama
                  ./modules/home/opencode
                  ./modules/home/rust
                  ./modules/home/ssh
                  ./modules/home/starship
                  ./modules/home/stopwatch
                  ./modules/home/walker
                  ./modules/home/waybar
                  ./modules/home/zellij
                  ./modules/home/zsh
                ];
              };
            };
          }
        ];
      };
    };
  };
}
