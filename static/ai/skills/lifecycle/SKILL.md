---
name: lifecycle
description: Run the constitute, specify, plan, and implement stages of spec-driven development, or a requested stage. Coordinate decisions and transitions while using project-documentation for artifact ownership and reconciliation.
---

# Development Lifecycle

Run the requested stage, or choose the stage that owns the decision: durable project rules → [constitute](references/constitute.md); intended behavior → [specify](references/specify.md); approach and verification → [plan](references/plan.md); delivery → [implement](references/implement.md). For a requested full workflow, proceed in that order, returning to an earlier stage when discoveries change its decisions. Load only relevant stage references and `project-documentation` when maintaining artifacts. Stages are work, not required files.

A user request or joint conversation that establishes a target is sufficient direction to record it; do not demand a second approval of the user's own decision. If the agent proposes a material change of target based on a discovery or recommendation, present it and get user direction before adopting it. Ask when conflicting artifacts leave consequential intent unclear. Pause for other consequential unresolved choices; do not add approval gates merely because a phase ended. Respect stricter repository governance and explicit user-requested gates.

After a material change, reconcile affected artifacts under `project-documentation` before proceeding. Describe what target or design changed, what remains unresolved, and what was verified at a handoff. Do not create a persistent handoff file unless it has an established owner or the user requests one.
