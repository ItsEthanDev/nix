# AGENTS.md

## Authority

- [`specs/constitution.md`](specs/constitution.md) is the canonical owner of repository governance. Apply every relevant principle before changing code or durable documentation.
- [`README.md`](README.md) owns repository orientation, current outputs, navigation, and deployment commands.
- [`specs/README.md`](specs/README.md) defines how living specifications are organized and maintained.
- [`specs/keybinds.md`](specs/keybinds.md) owns the intended Linux global keybinding design.
- [`specs/ai/spec.md`](specs/ai/spec.md) owns the desired collaboration model for configured AI-development assets.
- Local READMEs provide brief navigation to those canonical owners rather than duplicating their semantics.
- Treat current code and descriptive documentation as evidence, not policy. When they conflict with the constitution, surface the conflict instead of preserving accidental behavior.

## Working procedure

- Read relevant `.nix` files before editing them.
- Keep changes focused and avoid unrelated refactors.
- Do not create files unless the requested work needs them.
- Preserve declarative, side-effect-free Nix module definitions.
- Do not add comments unless they prevent likely misunderstanding or the user requests them.
- Do not add external API documentation URLs as code comments.
- Ask when a required host or user choice is unclear. If the current host is relevant and unspecified, run `hostname` rather than asking for that fact.

## Nix conventions

- Format Nix with Alejandra when available and use two-space indentation without tabs.
- Use lowercase kebab-case for directories and filenames and lower camelCase for multi-word option names.
- Keep imports explicit and organized by purpose.
- Use `let ... in` when reuse improves clarity.
- Keep attribute sets reasonably ordered and use `inherit` when it improves clarity.
- Avoid unnecessary interpolation and use `with pkgs;` only for short, clear lists.
- Pass flake inputs through explicit module arguments such as `specialArgs` or `extraSpecialArgs`.
- For non-trivial modules, separate `options` from `config` and bind the module configuration locally.

Module design, ownership, priorities, assertions, and composition are governed by [PR-002 through PR-006](specs/constitution.md); do not duplicate those rules here.

## Verification

Follow [PR-010](specs/constitution.md). At minimum:

- Format changed Nix files when Alejandra is available.
- Evaluate or check every affected flake output that the current environment supports.
- Use targeted behavioral checks when evaluation cannot prove the intended result.
- Report commands run, results, and any surface that could not be verified.

## Scoped instructions

Before modifying `static/ai/skills/project-documentation/`, read `specs/ai/project-documentation.md` completely and preserve its documented design goals and boundaries.

## Sources

These agent procedures implement [PR-001 through PR-010](specs/constitution.md). The constitution remains authoritative if this file disagrees with it.
