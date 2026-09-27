# Project Documentation

This living supporting specification refines the [AI-assisted development specification](../spec.md). It owns the desired behavior of the workflow-independent `project-documentation` technique. The runtime skill owns the procedure. The [lifecycle skill](../../../static/ai/skills/lifecycle/SKILL.md) owns development phases and transition gates, not documentation conventions.

## Purpose and authority

Make project intent easy to find across repositories without making every change generate a full document set. Apply the user's explicit direction, then established repository conventions, then the technique's fallbacks. Surface material conflicts with higher authority rather than silently choosing a convention.

Each durable claim has one authoritative owner. Other artifacts may reference it or summarize it for a reader, but must not silently change its meaning. The owner is determined by the claim, not by the filename: an existing RFC or issue may own a feature target, and a schema may own exact interface fields. Implementation and configuration are evidence of current behavior, not automatic proof of intended policy.

When artifacts disagree and the correct intent is not completely obvious from established authority, show the conflicting claims and ask the user which is intended. Do not select the newest artifact or infer a consequential decision from implementation. Resolve mechanical drift directly when the authority is unambiguous.

## Living, spec-anchored feature model

A feature specification describes the **current intended target**, not a history of decisions and not necessarily the behavior already delivered. Edit it when the target changes. Remove obsolete behavior rather than retaining deprecated-feature sections; Git preserves earlier revisions. Keep historical rationale elsewhere only when it matters, such as in a decision record. A feature directory groups one outcome that can be specified and verified coherently. Split outcomes when they can be accepted, changed, or delivered independently and combining them obscures decisions; do not split by implementation layer, sprint, release, or MVP stage.

Use **flow-back** persistence: a change may start in the specification, plan, tasks, contract, or implementation. Reconcile its consequences across the affected artifacts before declaring the work complete. Editing a downstream artifact never grants it authority to silently redefine intended behavior. If the user requested or agreed to a target change in the current conversation, recording it needs no second approval. If an agent proposes a material target change based on discovery or recommendation, the active workflow must obtain user direction before adopting it.

A user may designate a choice as **operational**: its current value is meant to vary during regular operation, so do not freeze that value or enumerate its instances in the feature specification. Identify where it is maintained and document durable constraints on changing it only when those constraints are intended. Such a designation does not bypass authorization, security, audit, or repository governance. Ask whether the value or its governing rule is flexible when that distinction matters and is unclear.

A user may designate a schema, configuration, or other declarative artifact as owner of its concrete details. Reference it rather than copying its declarations into prose. The feature specification owns the intended capability, behavioral boundaries, and constraints that the declaration does not express. A declared field or tool list can change without a prose edit only if it does not change an accepted user-visible, security, or consumer obligation; otherwise reconcile the relevant specification or contract. Protect external interface agreements even when their authoritative representation lives beside code.

## Bootstrapping or migrating an existing project

The technique must support projects with no documentation and projects with legacy artifacts. Inspect applicable instructions, code, tests, configuration, and existing docs to distinguish observed behavior from accepted intent. Use these sources to map actual capabilities and plausible feature boundaries, but do not treat implementation or historical prose as automatic authority over the current target. Ask the owner focused, batched questions where purpose, scope, intended behavior, or consequential design remains uncertain; record the answers in the appropriate owner without requiring a second approval. Proceed with independently clear work while leaving unresolved semantic changes untouched.

Create useful, current artifacts rather than populating every conventional filename or speculating from code. Preserve uniquely useful information from legacy docs, repair direct references, and remove obsolete copies only when ownership and intent are clear. A coherent final structure need not pretend the decisions or artifacts were present from the start. Explain what was observed, what the owner established, what was verified, and what remains uncertain. Apply the existing human-documentation and operational-evidence boundaries when setting up a project from scratch.

## Familiar fallbacks without ceremony

Where the repository has no established convention, place feature artifacts under `specs/<feature-name>/`, using `spec.md` for intended behavior, `plan.md` for technical approach and verification, and `tasks.md` for remaining and verified work. These are conventional places to look, not required files for every change. Create only artifacts that carry distinct information. Keep small starter templates for familiar navigation; omit sections that do not serve the work.

Use `MUST`, `SHOULD`, and `MAY` for normative obligations so required, expected-with-exceptions, and permitted behavior are distinguishable. State when an exception to `SHOULD` is allowed. Use stories, scenarios, and measurable outcomes when they make the behavior clearer, not as required sections. Give individually discussable requirements and tasks stable IDs for precise references in chat and between artifacts; add separate story or outcome ID categories only when they help. Do not renumber IDs merely to tidy presentation or reuse an ID for a different meaning.

A task list is a current execution checklist, not a permanent work log. Remove obsolete tasks, including completed ones, when their results no longer serve the current target. Retain completed tasks whose verified results remain applicable; add remaining work when a changed target requires more. Do not erase an unresolved gap to make the list look complete. Preserve history in Git and consequential rationale in its appropriate owner, not in stale checklist entries. Evidence lives in tests, CI, or a delivery report when those suffice; do not require a duplicate results table.

Create a `CONTEXT.md` early when the first consequential project-specific term or context boundary needs a durable definition, including during specification. Do not create one merely because a project started, and do not postpone it until a large glossary or terminology conflict accumulates. Use a context map only for genuinely distinct contexts. Keep domain vocabulary separate from feature requirements and implementation decisions.

## Human orientation and operational dependencies

Human-facing documentation is optional. When it is useful, the root README gives a coworker a short path to the project's purpose, the common way to get started, and deeper references. Keep the core readable quickly; move detailed procedures and lookup material into linked guides only when they improve navigation. Follow established repository locations; absent a convention, keep short setup instructions in the README and use `docs/setup.md` when they need their own page.

Setup guidance should let an authorized coworker start from a clean checkout, obtain required access through the approved channel, follow verified steps, and recognize a working result without relying on the original author. Do not include credentials or secret values. Avoid copying commands and declarations already owned elsewhere unless the local steps need them, and verify the commands in the environment that supports them.

Document operational dependencies when they help a coworker operate or revisit the project. Distinguish existing deployments from integrations or external configuration the project requires. A brief README pointer may suffice; for substantial detail use the repository's established owner or a linked `docs/operations.md`. Identify the environment and where to inspect it, the externally maintained configuration needed for the application to function, how authorized people obtain or manage access, and a safe way to verify the connection when known. Point to repository-owned configuration rather than repeating its declarations. Name no particular provider as a default.

Deployment configuration describes intent, not proof that an environment is currently running. Report live-state claims only from a suitable operational source, with a source and verification date; mark unknown or unverified state explicitly. Code alone does not prove an external integration is configured. Documentation work does not authorize deployment, changing external configuration, or accessing credentials. Avoid secret values and sensitive operational details in tracked prose. Reconcile human guides when their own claims change or their sources change; do not make a prose inventory another editable source of truth.

## Interface contracts and other owners

Define a contract when another component or consumer needs a stable observable agreement without depending on internals. This includes service APIs, events, plugin and library interfaces, automation-facing CLIs, and exchanged formats. A human-only CLI may need usage documentation without a separate contract artifact. Record inputs and outputs, relevant behavior and failure cases, compatibility, and verification at a level proportionate to the interface. A schema alone may not express retries or side effects.

The interface provider normally owns the authoritative contract and agrees consequential changes with affected consumers. A feature-local `contracts/` can draft a new interface; established cross-feature interfaces need one durable owner, which may be a repository-level `contracts/`. Consumers reference an agreed version or pin a read-only copy when working across repositories. Provider and consumer checks should verify behavior, not only data shape. Changes discovered during implementation flow back to the owning agreement and its affected users; published versions may have to remain available while consumers migrate.

The README owns orientation and navigation. Governance owns durable project constraints. Domain context owns vocabulary and boundaries. Plans own selected technical approaches; tasks own execution state; tests own executable assertions. An ADR preserves consequential rationale that must outlive a plan, including superseded decisions when that history is needed. Keep these logical roles distinct even when a project uses different filenames or fewer artifacts.

## Boundaries and completion

The technique owns artifact selection, ownership, conventions, and reconciliation. It does not prescribe lifecycle phases, approval pauses, or a universal repository layout. Use an existing clear owner instead of adding a competing one. A documentation change is complete when the changed claims have clear owners, affected direct dependents agree, references resolve, and remaining conflicts are reported rather than guessed.

## Sources

This specification refines the [AI-assisted development specification](../spec.md) and is constrained by [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior) and [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence).
