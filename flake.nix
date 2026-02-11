{
  description = "It's Ethan's configuration flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs = {
    home-manager,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    overlays = [
      (import ./overlays/opencode.nix)
    ];
  in {
    darwinConfigurations = {
      newton = nix-darwin.lib.darwinSystem {
        modules = [
          {nixpkgs.overlays = overlays;}
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
                  ./modules/home/lazygit
                  ./modules/home/nvim
                  ./modules/home/opencode
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
          {nixpkgs.overlays = overlays;}
          ./systems/x86_64-linux/turing
          ./modules/nixos/audio
          ./modules/nixos/bluetooth
          ./modules/nixos/catppuccin
          ./modules/nixos/boot
          ./modules/nixos/flatpak
          ./modules/nixos/font
          ./modules/nixos/gaming
          ./modules/nixos/hyprland
          ./modules/nixos/llama
          ./modules/nixos/locale
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
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.ethan = {
                imports = [
                  ./homes/x86_64-linux/turing
                  ./modules/home/banana-cursor
                  ./modules/home/btop
                  ./modules/home/catppuccin
                  ./modules/home/cli
                  ./modules/home/direnv
                  ./modules/home/discord
                  ./modules/home/easy-effects
                  ./modules/home/fish
                  ./modules/home/ghostty
                  ./modules/home/git
                  ./modules/home/hyprland
                  ./modules/home/gtk
                  ./modules/home/javascript
                  ./modules/home/lazygit
                  ./modules/home/mangohud
                  ./modules/home/nvim
                  ./modules/home/ollama
                  ./modules/home/opencode
                  ./modules/home/ssh
                  ./modules/home/starship
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

    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        js = import ./shells/js.nix {inherit pkgs;};
        lua = import ./shells/lua.nix {inherit pkgs;};
        python = import ./shells/python.nix {inherit pkgs;};
        rust = import ./shells/rust.nix {inherit pkgs;};
      }
    );
  };
}
