---
name: spec-driven-development
description: Run a four-phase delivery workflow that constitutes durable project rules, specifies desired behavior, plans technical work, and implements verified slices. Use when the user requests this workflow or one of its phases.
---

# Spec-Driven Development

Run four public phases:

```text
constitute → specify → plan → implement
```

This skill owns phase selection, sequencing, gates, and execution. The `project-documentation` skill owns artifact roles, locations, formats, identifiers, lifecycle, and reconciliation. Load it whenever a phase creates or changes durable documentation; do not recreate its conventions here.

## Select the phase

1. Use the phase named by the user.
2. Otherwise inspect the request and current artifacts:
   - Establish or change durable project constraints → [CONSTITUTE.md](CONSTITUTE.md)
   - Define desired behavior, scope, requirements, or acceptance → [SPECIFY.md](SPECIFY.md)
   - Choose a technical approach, verification strategy, or execution sequence for accepted behavior → [PLAN.md](PLAN.md)
   - Deliver accepted work in verified slices → [IMPLEMENT.md](IMPLEMENT.md)
3. Route to the earliest missing prerequisite when downstream work cannot proceed responsibly.
4. Load only the selected phase. Load another phase only when a discovered change belongs there.

Constitute a project when its durable rules change; do not repeat it for every feature. Clarification belongs to specify, technical investigation and task derivation belong to plan, and execution and convergence belong to implement.

## Cross phase transitions

When the user requests the complete workflow, run the phases in order. Pause before crossing a phase gate when a consequential product or architecture decision remains unresolved or the user requested approval. For an explicitly autonomous run, continue through resolved transitions, record responsible assumptions, and stop only for decisions that cannot be inferred responsibly or reversed cheaply.

Route discoveries to the phase that owns the decision:

- Changed durable project rule → constitute.
- Changed desired behavior or scope → specify.
- Changed technical approach, verification strategy, or execution design → plan.
- Changed code or observed delivery state within accepted intent and design → implement.

After a material upstream change, use `project-documentation` to reconcile affected artifacts before resuming downstream work. The workflow is complete when delivered behavior has direct evidence for every accepted requirement and the documentation system describes that same behavior without contradiction.
