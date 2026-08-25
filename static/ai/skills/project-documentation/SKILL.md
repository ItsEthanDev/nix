---
name: project-documentation
description: Establish and maintain a repository's documentation system. Use when choosing, creating, reorganizing, or reconciling READMEs, governance documents, specifications, plans, task lists, research, domain context, ADRs, contracts, and related durable artifacts.
---

# Project Documentation

Give every durable project fact one canonical owner, predictable location, and explicit relationships to dependent artifacts.

## Apply conventions in order

When selecting or organizing documentation:

1. Follow the user's explicit request.
2. Follow established repository conventions.
3. Use the fallback conventions below.

Surface rather than silently resolve a material conflict between those authorities. Treat logical artifact roles separately from filenames: an established `docs/principles.md` can own project governance even when the fallback path below is `specs/constitution.md`.

## Select the artifact guidance

Load only the references relevant to the request:

- Repository orientation, README, project governance, constitution, or agent instructions → [PROJECT-DOCUMENTATION.md](PROJECT-DOCUMENTATION.md)
- Feature specifications, plans, tasks, research, data models, contracts, quickstarts, or requirements checklists → [FEATURE-ARTIFACTS.md](FEATURE-ARTIFACTS.md)
- Canonical domain vocabulary, `CONTEXT.md`, or `CONTEXT-MAP.md` → [DOMAIN-CONTEXT.md](DOMAIN-CONTEXT.md)
- Architectural decision records or durable technical rationale → [DECISION-RECORDS.md](DECISION-RECORDS.md)

Read [ARTIFACT-MODEL.md](ARTIFACT-MODEL.md) when introducing a documentation convention, assigning identifiers or statuses, changing artifact ownership, or reconciling multiple artifacts.

## Canonical ownership

Use these logical owners unless the repository establishes a more specific one:

| Information | Canonical role | Fallback artifact |
| --- | --- | --- |
| Repository purpose, setup, navigation, and common use | Project overview | `README.md` |
| Durable project rules and decision constraints | Project governance | `specs/constitution.md` when consolidation is needed |
| Canonical domain vocabulary | Domain context | `CONTEXT.md` or context-local equivalent |
| Consequential technical decision and durable rationale | Decision record | `docs/adr/NNNN-slug.md` |
| Desired feature behavior, scope, and value | Feature specification | `specs/NNN-feature-name/spec.md` |
| Technical approach and verification strategy | Implementation plan | `specs/NNN-feature-name/plan.md` |
| Execution order, dependencies, and progress | Task list | `specs/NNN-feature-name/tasks.md` |
| Evidence used to resolve technical unknowns | Planning research | `specs/NNN-feature-name/research.md` |
| Substantial technical data design | Technical data model | `specs/NNN-feature-name/data-model.md` |
| Externally meaningful interface or protocol | Contract | `specs/NNN-feature-name/contracts/` |
| Integrated validation procedure | Validation scenario | `specs/NNN-feature-name/quickstart.md` |
| Observable proof of delivered behavior | Verification evidence | Tests, checks, and recorded results |
| Agent-specific operating instructions | Agent instructions | `AGENTS.md`, `CLAUDE.md`, or harness equivalent |

Put each fact in one canonical owner. Other artifacts reference that owner instead of copying it. A downstream artifact may add implementation precision while preserving upstream semantics; it must not introduce externally observable behavior, relax an upstream obligation, or silently contradict an upstream decision. Revise the canonical upstream owner first when semantics must change.

## Maintain the system

1. Discover applicable instructions, documentation indexes, existing artifact paths, and local formats before choosing a destination.
2. Identify the logical owner of each fact being added or changed.
3. Update the smallest set of canonical artifacts that fully records the change.
4. Reconcile direct dependents using the change rules in [ARTIFACT-MODEL.md](ARTIFACT-MODEL.md).
5. Check that references resolve, identifiers remain stable, placeholders match lifecycle state, and no dependent artifact contradicts its sources.

## Completion criteria

Documentation maintenance is complete when:

- Every changed durable fact has one canonical owner.
- Artifact paths and formats follow the selected authority order.
- Required sections satisfy the applicable artifact guidance.
- References and stable identifiers resolve without duplication or reuse.
- Directly dependent artifacts agree with changed owners.
- Optional artifacts exist only when separating their contents improves ownership, comprehension, reuse, or verification.
