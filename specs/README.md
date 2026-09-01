# Specifications

Specifications are living, authoritative descriptions of intent, interactions, and acceptance boundaries that declarative configuration or implementation assets do not express adequately. Amend the owning specification when that intent changes, then reconcile its implementation and direct dependents.

Use a flat `specs/<category>.md` file by default. Introduce a category directory only when plans, research, contracts, or other supporting artifacts improve ownership or comprehension. Apply structures, lifecycle metadata, normative terms, user stories, and stable identifiers only when they make a specification clearer or provide needed traceability.

Current specifications:

- [AI-assisted development](ai/spec.md)
  - [Durable AI development directives](ai/directives.md)
  - [AI asset evolution and trials](ai/evolution.md)
  - Capability specifications under [`ai/skills/`](ai/skills/)
- [Global keybindings](keybinds.md)

Repository governance remains canonical in the [project constitution](constitution.md), especially [PR-009](constitution.md#pr-009--nix-owns-configuration-behavior).
