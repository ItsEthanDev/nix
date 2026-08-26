---
name: project-documentation
description: Establish and maintain a repository's documentation system. Use when choosing, creating, reorganizing, or reconciling durable artifacts such as READMEs, governance, specifications, plans, tasks, research, ADRs, and contracts, or when resolving domain terminology, distinguishing context boundaries, or stress-testing domain concepts.
---

# Project Documentation

Give every durable semantic claim one authoritative owner, predictable location, and explicit relationships to dependent artifacts.

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
- Domain terminology, context boundaries, `CONTEXT.md`, or `CONTEXT-MAP.md` → [DOMAIN-CONTEXT.md](DOMAIN-CONTEXT.md)
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
| Intended proof of delivered behavior | Verification strategy | Implementation plan |
| Executable proof of delivered behavior | Verification check | Tests and checks |
| Observed verification outcome | Verification result | CI record or durable verification report |
| Agent-specific operating instructions | Agent instructions | `AGENTS.md`, `CLAUDE.md`, or harness equivalent |

Put each durable semantic claim in one authoritative owner. Other artifacts reference that owner or identify their local text as a derived projection. A downstream artifact may own a more precise representation while preserving upstream semantics; it must not introduce externally observable behavior, relax an upstream obligation, or silently contradict an upstream decision. Revise the canonical upstream owner first when semantics must change.

## Maintain the system

1. Discover applicable instructions, documentation indexes, existing artifact paths, and local formats before choosing a destination.
2. Identify the logical owner of each semantic claim being added or changed.
3. Update the smallest set of canonical artifacts that fully records the change.
4. Search for changed identifiers, paths, and headings, then reconcile the direct dependents identified through the rules in [ARTIFACT-MODEL.md](ARTIFACT-MODEL.md).
5. Check that source references resolve, identifiers remain stable, placeholders match lifecycle state, and no dependent artifact contradicts its sources.

## Completion criteria

Documentation maintenance is complete when:

- Every changed durable semantic claim has one authoritative owner, and each derived projection identifies that source.
- Artifact paths and formats follow the selected authority order.
- Required sections satisfy the applicable artifact guidance.
- References and stable identifiers resolve without duplication or reuse.
- Directly dependent artifacts agree with changed owners.
- The artifact set is no more complex than the work requires; especially small work may omit standard artifacts when another established owner preserves the necessary information and traceability.
- Optional supporting artifacts exist only when separating their contents improves ownership, comprehension, reuse, or verification.
