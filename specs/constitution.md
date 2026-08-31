# Project Constitution

- **Status:** Ratified
- **Version:** 1.0.0
- **Ratified:** 2026-08-31
- **Last amended:** 2026-08-31

This constitution is the canonical owner of the durable rules that govern this repository. It constrains how configuration is designed, composed, documented, and verified without specifying which systems, programs, or preferences the configuration must contain.

## PR-001 — Flake-native interfaces

Supported repository interfaces MUST be exposed through flake outputs. Evaluation and development workflows MUST assume flakes and `nix-command`; deployment tools MAY use other executables when they consume flake outputs. The project MUST NOT maintain or test compatibility with channels, `NIX_PATH`, legacy `nix-shell` workflows, or non-flake entry points. Incidental compatibility carries no stability guarantee.

**Compliance signal:** Supported commands and checks address flake outputs, and no documented workflow or compatibility check requires a non-flake entry point.

## PR-002 — Explicit ownership and composition

`flake.nix` MUST be the composition root: it owns inputs, exposed outputs, and the assembly of complete configurations. `systems/` MUST own deployment-specific NixOS and nix-darwin configuration, `homes/` MUST own deployment-specific Home Manager configuration, and `modules/` MUST contain reusable Nix modules rather than deployment-specific choices. A system or home configuration MAY use private files for internal organization without making those files independent interfaces.

**Compliance signal:** Every configuration decision has one evident owning layer, and cross-layer assembly occurs in `flake.nix` rather than in private configuration fragments.

## PR-003 — Directed and separable configuration layers

System and home configurations MUST NOT import or inspect each other. Reusable modules and helpers MUST NOT depend on deployment-specific callers. Shared context MUST pass through explicit arguments, repository helpers, or an appropriate module interface.

`flake.nix` MAY integrate a Home Manager configuration into a NixOS or nix-darwin configuration so their generations change and roll back together. A home configuration MUST remain identifiable as a Home Manager configuration that can be composed differently when desired, but the repository is not required to expose or continuously verify a standalone deployment for every home.

**Compliance signal:** Dependency inspection shows no imports from `systems/` to `homes/`, from `homes/` to `systems/`, or from reusable code back to either caller; any integrated system-and-home deployment is wired at the composition root.

## PR-004 — Abstractions must earn their place

Repository abstractions MUST provide leverage or locality by hiding meaningful decisions, coordinating coherent behavior, validating invariants, adapting across contexts, or preventing complexity from spreading to callers. An abstraction MUST NOT exist only for speculative reuse, naming, pass-through indirection, or file-size reduction.

A reusable Nix module earns its place when its interface is materially simpler than the policy and behavior it owns. Reuse alone is insufficient. One-caller configuration that mostly forwards upstream options SHOULD remain in its owning system or home, even when that leaves modest duplication. Deleting a justified module should cause meaningful complexity to reappear in its callers.

**Compliance signal:** Each introduced or retained abstraction can identify the complexity hidden behind its interface, and removing a shallow abstraction reduces rather than redistributes reader work.

## PR-005 — Nix modules expose small, explicit interfaces

A public behavior-producing Nix module MUST remain inert until selected through a primary `enable` option. Modules that only declare options or provide structural plumbing MAY be naturally inert without such an option. Private implementation fragments MUST remain behind their owning module's interface.

Public options MUST represent genuine caller inputs and MUST NOT mirror upstream options merely for convenience. Enabling one public repository module MUST NOT implicitly enable another public repository module. A module MAY coordinate upstream facilities as private implementation and MAY provide optional integration when callers independently select both repository capabilities.

**Compliance signal:** Evaluating an unselected module adds no behavior; its public options are necessary to use the capability; and module imports and definitions preserve independent selection of public capabilities.

## PR-006 — Defaults remain overridable without weakening invariants

Modules MUST use default-priority definitions for owned, overridable choices when the affected option's merge semantics preserve the intended result. Additive collections MUST remain at a priority that preserves composition. Stronger priorities MUST have a specific ownership or conflict-resolution reason.

Callers MAY override a module's policy defaults but MUST NOT be able to make the module silently violate its interface. Modules MUST use types and assertions to reject missing prerequisites, incompatible selections, unsupported contexts, and overrides that would otherwise evaluate successfully while producing materially unintended behavior. Assertions MUST NOT duplicate conditions already made unrepresentable by the option type system. Genuinely optional integrations MAY degrade conditionally.

**Compliance signal:** Definition priorities preserve intended overrides and merges, and evaluation fails clearly for invalid required conditions while optional integrations remain optional.

## PR-007 — Managed state is declarative and reproducible

Managed configuration MUST be represented declaratively in the repository and evaluate from repository content plus declared, locked flake inputs. Supported outputs MUST NOT depend on undeclared ambient files, environment variables, evaluator state, or ambient machine identity. Deployment-specific context MUST be declared explicitly.

When a required lifecycle operation cannot be expressed as declarative state, it MUST be explicit, idempotent, and owned by the capability that requires it.

**Compliance signal:** A clean evaluation uses only declared inputs, and repeated activation converges without accumulating unintended state or requiring undocumented manual mutation.

## PR-008 — Plaintext secrets stay outside the repository

Plaintext secrets MUST NOT appear in tracked repository content. Configuration MAY declare how external or encrypted secret material is located and consumed, but it MUST NOT embed the recovered value.

**Compliance signal:** Repository inspection finds no tracked plaintext credentials or secret values, and secret-dependent configuration refers to material supplied outside plaintext source control.

## PR-009 — Nix owns configuration behavior

Declarative Nix configuration is the canonical owner of configuration behavior. Prose MUST NOT duplicate host inventories, package selections, keybindings, application preferences, or other facts that the configuration already expresses adequately.

A separate specification SHOULD exist only when important intent, interactions, or acceptance criteria are not adequately expressed by the Nix configuration. Such a specification MUST own those additional semantics rather than restating configuration syntax.

**Compliance signal:** Behavioral claims resolve to Nix or to a focused specification with distinct semantic value; removing prose that mirrors Nix does not remove unique project intent.

## PR-010 — Changes require direct evidence

Every change MUST provide evidence appropriate to the interface it affects. Nix changes MUST be formatted and the affected flake outputs MUST be evaluated or checked when the available environment can do so. Changes whose behavior evaluation cannot prove MUST use a targeted behavioral check. Documentation claims, paths, and commands MUST be checked against their canonical sources.

A limitation in the available environment MUST be reported with the unverified surface; it MUST NOT be presented as successful verification.

**Compliance signal:** The change record identifies the checks performed and their results, or states the exact verification that remains blocked and why.

## Governance

- A feature, host, plan, or agent instruction MUST NOT waive a constitutional principle. A conflict requires redesign or a constitutional amendment.
- An amendment MUST update the version and amendment date and MUST reconcile dependent specifications, plans, instructions, documentation, and checks.
- A major version removes or incompatibly redefines a principle.
- A minor version adds a principle or materially strengthens an obligation.
- A patch version clarifies wording without changing an obligation.
- Stable principle identifiers MUST NOT be renumbered or reused for different obligations.
- Ratification changes this document to version `1.0.0`, records the ratification date, and makes the accepted text authoritative for downstream work.
