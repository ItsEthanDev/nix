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
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
  in {
    darwinConfigurations = {
      newton = nix-darwin.lib.darwinSystem {
        modules = [
          ./systems/aarch64-darwin/newton
          ./modules/darwin/aerospace
          ./modules/darwin/ghostty
          ./modules/darwin/homebrew
          ./modules/darwin/network
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
                  ./hosts/newton/home.nix
                  ./modules/home
                ];
              };
            };
          }
        ];
      };
    };

    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        js = import ./shells/js.nix {inherit pkgs;};
        lua = import ./shells/lua.nix {inherit pkgs;};
        python = import ./shells/python.nix {inherit pkgs;};
        rust = import ./shells/rust.nix {inherit pkgs;};
      }
    );
  };
}
