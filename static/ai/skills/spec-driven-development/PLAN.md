# Plan

Turn an accepted specification into a technical approach, verification strategy, and executable sequence.

Before creating planning artifacts, load the applicable `project-documentation` guidance and follow its location, format, identifier, relationship, and readiness rules.

## Process

1. **Validate the input.** Read the accepted specification and applicable project rules. Return to specify when ambiguity could materially change the design.
2. **Inspect implementation context.** Read affected modules, interfaces, tests, configuration, relevant ADRs, and real project commands. Do not plan against guessed structure.
3. **Resolve consequential unknowns.** Identify technical, performance, cost, operational, and organizational unknowns that could change the design. Investigate them using repository evidence, authoritative documentation, focused experiments or benchmarks, and established constraints. Record substantial evidence using the research owner defined by `project-documentation`. Return upstream when findings change behavior or durable policy.
4. **Design the smallest sufficient change.** Identify affected interfaces, data, dependencies, migrations, rollout and rollback needs, and operational risks. Prefer existing seams over speculative layers.
5. **Plan verification first.** Map every accepted requirement and buildable success criterion to direct evidence at an appropriate public interface. Name exact automated checks and manual procedures. Load `tdd` for test-first work and `codebase-design` when interfaces or test seams are in question.
6. **Derive vertical slices.** Break the design into dependency-ordered slices that each deliver and verify observable behavior. Introduce setup or shared foundational work only when it is a genuine prerequisite. Derive the task list from the accepted specification and plan.
7. **Analyze consistency read-only.** Before implementation, check that every accepted requirement has planned work and evidence, every task has an upstream justification, ordering and parallel claims agree with dependencies, project rules are satisfied, and no plan or task invents user-visible behavior.
8. **Repair the owner.** Fix each finding in the artifact that canonically owns it, then rerun the consistency analysis.
9. **Resolve the gate.** Obtain acceptance before implementation unless the user requested autonomous progression and no consequential architecture decision remains.

## Completion criteria

Plan is complete when:

- The design references the real codebase and commands.
- Consequential unknowns are resolved with traceable evidence or explicitly block implementation.
- Every accepted requirement maps to a technical change, direct evidence, and executable work.
- Work is ordered into small independently verifiable slices.
- Risks, migrations, rollout, rollback, and unresolved technical choices are explicit when applicable.
- A read-only consistency pass finds no blocking gap or contradiction.
- Planning artifacts satisfy the readiness criteria from `project-documentation`.
