---
name: project-documentation
description: Organize and reconcile project documentation, including feature specs, plans, tasks, contracts, domain context, decision records, and READMEs. Use when choosing an artifact owner or maintaining related artifacts after a change.
---

# Project Documentation

1. Read the user's direction, repository instructions, and existing owners before choosing an artifact. Follow explicit direction, established conventions, then the fallbacks here. Surface conflicts with project governance.
2. Identify what each changed claim means and where it belongs: intended behavior in a feature spec, technical approach in a plan, work state in tasks, exact interface agreement in a contract, vocabulary in domain context, durable rationale in an ADR, orientation in a README, and executable detail in code, schemas, or configuration.
3. Load only the references whose decisions the task needs:
   - Writing or changing a feature target, approach, or task list: [feature artifacts](FEATURE-ARTIFACTS.md).
   - Defining or changing an interface another component or consumer relies on: [contracts](CONTRACTS.md).
   - Naming a domain concept or locating its context: [domain context](DOMAIN-CONTEXT.md).
   - Recording or changing a consequential decision's lasting rationale: [decision records](DECISION-RECORDS.md).
   - Updating a README, human-facing guide, or project rule: [README and governance](PROJECT-DOCUMENTATION.md).
   - Choosing between competing owners, routing operational or declarative details, or reconciling multiple artifacts: [artifact model](ARTIFACT-MODEL.md).
4. Update the owner of each accepted change and reconcile affected dependents. A change may start anywhere, but downstream edits do not silently redefine the target. When a disagreement about intent is not completely obvious from established authority, state both claims and ask the user which is correct. Fix unambiguous stale references directly.
5. Check that paths and IDs resolve, affected artifacts agree, and no unnecessary file or obsolete task remains. Report any unresolved conflict.

Use `specs/<feature-name>/spec.md`, `plan.md`, and `tasks.md` as familiar fallbacks, not mandatory ceremony. Keep specifications current-target rather than historical; use Git for earlier versions. User-designated operational values belong in their operating owner, not in a static spec. Declarative artifacts may own concrete details; prose owns distinct intent and constraints. This technique does not impose development phases or approval pauses.
