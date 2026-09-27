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

## Familiar fallbacks without ceremony

Where the repository has no established convention, place feature artifacts under `specs/<feature-name>/`, using `spec.md` for intended behavior, `plan.md` for technical approach and verification, and `tasks.md` for remaining and verified work. These are conventional places to look, not required files for every change. Create only artifacts that carry distinct information. Keep small starter templates for familiar navigation; omit sections that do not serve the work.

Use `MUST`, `SHOULD`, and `MAY` for normative obligations so required, expected-with-exceptions, and permitted behavior are distinguishable. State when an exception to `SHOULD` is allowed. Use stories, scenarios, and measurable outcomes when they make the behavior clearer, not as required sections. Give individually discussable requirements and tasks stable IDs for precise references in chat and between artifacts; add separate story or outcome ID categories only when they help. Do not renumber IDs merely to tidy presentation or reuse an ID for a different meaning.

A task list is a current execution checklist, not a permanent work log. Remove obsolete tasks, including completed ones, when their results no longer serve the current target. Retain completed tasks whose verified results remain applicable; add remaining work when a changed target requires more. Do not erase an unresolved gap to make the list look complete. Preserve history in Git and consequential rationale in its appropriate owner, not in stale checklist entries. Evidence lives in tests, CI, or a delivery report when those suffice; do not require a duplicate results table.

Create a `CONTEXT.md` early when the first consequential project-specific term or context boundary needs a durable definition, including during specification. Do not create one merely because a project started, and do not postpone it until a large glossary or terminology conflict accumulates. Use a context map only for genuinely distinct contexts. Keep domain vocabulary separate from feature requirements and implementation decisions.

## Interface contracts and other owners

Define a contract when another component or consumer needs a stable observable agreement without depending on internals. This includes service APIs, events, plugin and library interfaces, automation-facing CLIs, and exchanged formats. A human-only CLI may need usage documentation without a separate contract artifact. Record inputs and outputs, relevant behavior and failure cases, compatibility, and verification at a level proportionate to the interface. A schema alone may not express retries or side effects.

The interface provider normally owns the authoritative contract and agrees consequential changes with affected consumers. A feature-local `contracts/` can draft a new interface; established cross-feature interfaces need one durable owner, which may be a repository-level `contracts/`. Consumers reference an agreed version or pin a read-only copy when working across repositories. Provider and consumer checks should verify behavior, not only data shape. Changes discovered during implementation flow back to the owning agreement and its affected users; published versions may have to remain available while consumers migrate.

The README owns orientation and navigation. Governance owns durable project constraints. Domain context owns vocabulary and boundaries. Plans own selected technical approaches; tasks own execution state; tests own executable assertions. An ADR preserves consequential rationale that must outlive a plan, including superseded decisions when that history is needed. Keep these logical roles distinct even when a project uses different filenames or fewer artifacts.

## Boundaries and completion

The technique owns artifact selection, ownership, conventions, and reconciliation. It does not prescribe lifecycle phases, approval pauses, or a universal repository layout. Use an existing clear owner instead of adding a competing one. A documentation change is complete when the changed claims have clear owners, affected direct dependents agree, references resolve, and remaining conflicts are reported rather than guessed.

## Sources

This specification refines the [AI-assisted development specification](../spec.md) and is constrained by [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior) and [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence).
