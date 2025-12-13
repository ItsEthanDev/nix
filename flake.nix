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

  outputs =
    {
      home-manager,
      nix-darwin,
      nixpkgs,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      darwinConfigurations."newton" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/newton/configuration.nix
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.ethan = {
              imports = [
                ./hosts/newton/home.nix
                ./modules/home
              ];
            };
          }
        ];
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          js = import ./shells/js.nix { inherit pkgs; };
          lua = import ./shells/lua.nix { inherit pkgs; };
          python = import ./shells/python.nix { inherit pkgs; };
          rust = import ./shells/rust.nix { inherit pkgs; };
        }
      );
    };
}
