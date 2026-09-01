# Ethan's Nix Configuration

This repository is the source of truth for Ethan's NixOS, nix-darwin, and Home Manager environments. It uses a flake to compose system and home configurations and expose reusable modules, overlays, packages, development shells, and library helpers.

Project-wide design and maintenance rules live in the [project constitution](specs/constitution.md). This README describes the repository as it exists; it does not define governance.

## Prerequisites

Use Nix with the `flakes` and `nix-command` features enabled. Deployments also require the rebuild tool for the target platform.

## Deploy a configuration

Run the applicable command from the repository root:

```sh
sudo nixos-rebuild switch --flake .#turing
darwin-rebuild switch --flake .#newton
```

Home Manager is composed into these system configurations, so system and home generations change and roll back together.

## Flake outputs

- `nixosConfigurations.<host>` contains composed NixOS configurations.
- `darwinConfigurations.<host>` contains composed nix-darwin configurations.
- `nixosModules`, `darwinModules`, and `homeManagerModules` expose reusable modules.
- `overlays` exposes named overlays and their default composition.
- `packages.<system>` exposes repository packages.
- `devShells.<system>` exposes language-specific development shells.
- `lib` exposes helpers used to construct flake outputs.

## Repository map

| Path | Purpose |
| --- | --- |
| `flake.nix` | Declares inputs, outputs, and configuration composition. |
| `systems/` | Deployment-specific NixOS and nix-darwin configuration. |
| `homes/` | Deployment-specific Home Manager configuration. |
| `modules/` | Reusable NixOS, nix-darwin, and Home Manager modules. |
| `lib/` | Helpers used to construct flake outputs. |
| `overlays/` | Named nixpkgs overlays and their default composition. |
| `packages/` | Packages exposed by the flake. |
| `shells/` | Development shells exposed by the flake. |
| `static/` | Non-secret static assets consumed by configuration. |
| `specs/` | Canonical project governance and living specifications. |

## Documentation

- [Specification index and conventions](specs/README.md) — organization and maintenance of living specifications.
- [Project constitution](specs/constitution.md) — canonical repository governance.
- [Global keybindings](specs/keybinds.md) — intended Linux interaction model.
- [AI-assisted development](specs/ai/spec.md) — desired collaboration model for configured agent assets.
- [Agent instructions](AGENTS.md) — repository procedures for coding agents.

## Sources

This repository description is a derived projection of [PR-001 through PR-003 and PR-009](specs/constitution.md). The constitution remains authoritative if this README disagrees with it.
