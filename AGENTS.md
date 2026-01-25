# AGENTS.md

## Repository purpose
- Personal Nix flake repository for configuring machines and user environments.
- Source of truth for NixOS, macOS (nix-darwin), and Home Manager setups.
- Works primarily through Nix modules and flake outputs.

## Directory overview
- Root contains the flake entry (`flake.nix`) and flake lock (`flake.lock`).
- Configuration is organized by platform and layer (system vs. user).
- Supporting directories group reusable modules, overlays, and dev shells.
- This repo is Nix-first: changes are expressed in `.nix` files.

## Structure (high level)
- `systems/` holds host-specific system configurations.
- `homes/` holds host-specific user configurations.
- `modules/` contains reusable Nix modules grouped by platform.
- `shells/` contains development shell definitions for tooling.
- `overlays/` contains nixpkgs overlays.
- `static/` contains static assets used by configuration.

## Editing guidelines
- Prefer small, focused changes; keep diffs minimal.
- Follow existing formatting and indentation (two spaces, no tabs).
- Keep module files declarative and side-effect free.
- Avoid adding comments unless the user requests them.
- Do not introduce unrelated refactors.

## Nix style
- Use `let ... in` blocks when reuse improves clarity.
- Keep attribute sets sorted when reasonable.
- Use `inherit` for passing through values rather than repeating names.
- Avoid unnecessary string interpolation.
- Use `with pkgs;` sparingly and only for short lists.

## Imports and module patterns
- Keep `imports = [ ... ];` aligned and grouped by purpose.
- Avoid deeply nested logic in modules; split into smaller modules when needed.
- Use `specialArgs` for passing inputs instead of global references.
- Prefer `config`/`options` separation when authoring new modules.

## Naming conventions
- Use lowercase, dash-separated attribute names when defining options.
- Hostnames and user names should match the existing directory layout.
- Keep module file names descriptive and consistent.

## Formatting
- Use Alejandra for Nix formatting when available.
- Maintain 2-space indentation.
- Keep lists and attribute sets trailing commas consistent with existing style.

## Common commands
- Build the system: `nixos-rebuild build --flake ~/nix#<hostname>`

## Agent guidance
- Read relevant `.nix` files before editing.
- Don’t create new files unless requested.
- Keep changes within the existing structure.
- Don’t assume missing directories or modules.
- Ask questions when host or user names are unclear.
