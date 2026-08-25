---
name: spec-driven-development
description: "Run a four-phase spec-driven development workflow: constitute project constraints, specify behavior, plan technical work, and implement in verified slices. Use when establishing project governance, writing a feature specification, turning an approved specification into a plan, or implementing work from spec artifacts."
---

# Spec-Driven Development

Use four public phases:

```text
constitute → specify → plan → implement
```

The phases are a small interface, not four equally frequent ceremonies. Constitute a project when its durable rules change; run the other phases for each feature. Clarification belongs to specify, task breakdown and consistency analysis belong to plan, and execution and convergence belong to implement.

## Select the phase

1. Use the phase named by the user.
2. Otherwise inspect the request and existing artifacts:
   - Durable project principles, constraints, terminology, or documentation ownership → [CONSTITUTE.md](CONSTITUTE.md)
   - Desired behavior, scope, requirements, or acceptance criteria → [SPECIFY.md](SPECIFY.md)
   - Technical design, verification strategy, sequencing, or tasks for an accepted spec → [PLAN.md](PLAN.md)
   - Code changes from an accepted plan → [IMPLEMENT.md](IMPLEMENT.md)
3. If prerequisites are missing, route to the earliest missing phase. Do not invent downstream artifacts to compensate.
4. Load only the selected phase reference. Load another phase only when a discovered change belongs there.

When the user asks for the complete workflow, run the phases in order. Pause at a phase transition when a consequential product or architecture decision remains unresolved or when the user requested approval gates. For an explicitly autonomous run, proceed through resolved transitions, record assumptions, and stop only for decisions that cannot be reversed cheaply or inferred responsibly.

## Preserve artifact ownership

Discover project conventions before choosing files. Read applicable instruction files, project documentation, domain context, ADRs, and existing spec directories. Use established paths and formats. Load [reference/spec-kit.md](reference/spec-kit.md) when a new project has no specification convention or when the existing project already uses Spec Kit conventions. Use it as the fallback for new projects and as alignment guidance for continuing Spec Kit–style work.

Keep each kind of knowledge in one canonical owner:

| Knowledge | Owner |
| --- | --- |
| Durable project principles and constraints | Existing project governance or documentation |
| Domain terminology | Existing domain context or glossary |
| Desired feature behavior and scope | Feature specification |
| Technical approach and verification strategy | Implementation plan |
| Execution order and progress | Task list |
| Consequential technical rationale | ADR, when the project uses them |
| Proof of behavior | Tests and verification results |

Do not create a second rules file merely to satisfy this workflow. When no suitable owner exists, create the smallest artifact that the project can maintain and link to it instead of duplicating its contents.

## Maintain traceability

Give each functional requirement a stable `FR-###` ID and each measurable success criterion a stable `SC-###` ID. Carry those IDs into plan sections, tasks, and final verification. Reference each applicable project rule by stable ID when its canonical owner provides one; otherwise use its canonical path and heading. Do not invent a parallel ID scheme for rules distributed across existing documentation. A downstream artifact may refine an upstream decision but must not duplicate or silently contradict it.

Route discoveries back to their owner:

- Changed behavior or scope → revise the specification.
- Changed technical approach → revise the plan and create an ADR only for a consequential, surprising trade-off.
- Changed sequence or progress → revise the task list.
- Changed durable project rule → return to constitute.

The workflow is complete when the implementation has direct evidence for every accepted requirement and all artifacts describe the same delivered behavior.
