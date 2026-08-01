# Ethan's Nix Configuration

This repository is the source of truth for Ethan's NixOS, nix-darwin, and Home
Manager environments. The flake assembles host configurations and exposes the
repository's reusable modules, overlays, packages, development shells, and
library helpers.

The organization and module design rules are documented in
[`docs/README.md`](docs/README.md). The target Linux global keybinding strategy
is documented in [`docs/keybinds.md`](docs/keybinds.md).

## Flake Outputs

- `nixosConfigurations.<host>` contains complete NixOS host configurations.
- `darwinConfigurations.<host>` contains complete nix-darwin host configurations.
- `homeConfigurations."<user>@<host>"` contains standalone Home Manager
  configurations. The same home configurations are also integrated into their
  corresponding system configurations.
- `nixosModules`, `darwinModules`, and `homeManagerModules` each expose a
  `default` aggregate and named top-level module groups.
- `overlays` exposes named overlays and a composed `default` overlay.
- `packages.<system>` exposes packages built by this repository.
- `devShells.<system>` exposes language-specific development shells.
- `lib` exposes helpers used to construct the other outputs.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `flake.nix` | Declares inputs, outputs, and host assembly. |
| `systems/<system>/<host>/` | Host-specific NixOS or nix-darwin configuration. |
| `homes/<system>/<host>/` | Host-specific Home Manager configuration for the primary user. |
| `modules/nixos/` | Reusable NixOS modules. |
| `modules/darwin/` | Reusable nix-darwin modules. |
| `modules/home/` | Reusable Home Manager modules. |
| `lib/` | Flake and repository helper functions. |
| `overlays/` | Named nixpkgs overlays and their default composition. |
| `packages/` | Packages exposed by the flake. |
| `shells/` | Development shell definitions. |
| `static/` | Non-secret static assets referenced by configuration. |
| `docs/` | Target-state repository and interaction design guidance. |

## Deployment

Run the appropriate command from the repository root:

```sh
sudo nixos-rebuild switch --flake .#turing
darwin-rebuild switch --flake .#newton
home-manager switch --flake '.#ethan@turing'
```
