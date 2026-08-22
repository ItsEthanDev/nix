# Plan

Turn an accepted specification into a technical approach, verification strategy, and executable task sequence. Use the project's existing format; otherwise start from [templates/plan.md](templates/plan.md) and, for non-trivial work, [templates/tasks.md](templates/tasks.md).

## Process

1. **Validate the input.** Read the accepted specification and constituted rules. Stop or return to specify if behavior remains ambiguous enough to change the design.
2. **Inspect the implementation context.** Read the affected modules, interfaces, tests, configuration, and relevant ADRs. Record real paths and commands; do not plan against guessed structure.
3. **Resolve consequential unknowns.** List the technical, performance, cost, operational, and organizational unknowns that could change the design. Investigate them using repository evidence, authoritative documentation, focused experiments or benchmarks, and established organizational constraints as applicable. Record each question, viable options, evidence and sources, confidence, and design implication in the plan; use the project's existing research artifact or `research.md` only when the findings are substantial. Return to specify when a finding changes behavior or scope, and to constitute when it changes a durable project rule. This step is complete when each consequential unknown is resolved or named as a blocker.
4. **Design the smallest sufficient change.** Identify affected interfaces, data, dependencies, migrations, and operational risks. Prefer extending existing seams over introducing speculative layers.
5. **Plan verification first.** Map every `FR-###` and each buildable `SC-###` to evidence at an appropriate public interface. Name the automated tests, static checks, builds, and manual checks that will prove the requirement or outcome. Load the `tdd` skill when the work is test-first and the `codebase-design` skill when test seams or interfaces are in question.
6. **Create vertical slices.** Break the work into dependency-ordered slices that each deliver and verify observable behavior. Use Setup and Foundational phases only for shared prerequisites, then organize feature work by user story in priority order. For non-trivial work, record tasks as `T###`, mark safe parallel work with `[P]`, associate story tasks with `[US#]`, and include an exact file path in each description.
7. **Analyze consistency read-only.** Before implementation, check that:
   - Every accepted requirement maps to planned changes and evidence.
   - Every task maps to a requirement, necessary scaffold, or documented delivery concern.
   - Task dependencies and parallel markers do not conflict.
   - The plan complies with constituted rules.
   - Terminology and technical decisions are consistent across artifacts.
8. **Resolve the gate.** Fix findings in the artifact that owns them. Obtain approval before implementation unless the user explicitly requested autonomous progression and no consequential architecture decision remains.

## Completion criteria

Plan is complete when:

- The design references the real codebase and names concrete affected paths.
- Consequential unknowns are resolved with traceable evidence or explicitly block implementation.
- Every requirement maps to implementation work and direct verification evidence.
- Work is ordered into small, independently verifiable vertical slices.
- Risks, migrations, rollback needs, and unresolved technical decisions are explicit when applicable.
- A read-only consistency pass finds no blocking gap or contradiction.
