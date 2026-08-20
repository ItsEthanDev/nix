# Plan

Turn an accepted specification into a technical approach, verification strategy, and executable task sequence. Use the project's existing format; otherwise start from [templates/plan.md](templates/plan.md) and, for non-trivial work, [templates/tasks.md](templates/tasks.md).

## Process

1. **Validate the input.** Read the accepted specification and constituted rules. Stop or return to specify if behavior remains ambiguous enough to change the design.
2. **Inspect the implementation context.** Read the affected modules, interfaces, tests, configuration, and relevant ADRs. Record real paths and commands; do not plan against guessed structure.
3. **Design the smallest sufficient change.** Identify affected interfaces, data, dependencies, migrations, and operational risks. Prefer extending existing seams over introducing speculative layers.
4. **Plan verification first.** Map every `FR-###` and each buildable `SC-###` to evidence at an appropriate public interface. Name the automated tests, static checks, builds, and manual checks that will prove the requirement or outcome. Load the `tdd` skill when the work is test-first and the `codebase-design` skill when test seams or interfaces are in question.
5. **Create vertical slices.** Break the work into dependency-ordered slices that each deliver and verify observable behavior. Use Setup and Foundational phases only for shared prerequisites, then organize feature work by user story in priority order. For non-trivial work, record tasks as `T###`, mark safe parallel work with `[P]`, associate story tasks with `[US#]`, and include an exact file path in each description.
6. **Analyze consistency read-only.** Before implementation, check that:
   - Every accepted requirement maps to planned changes and evidence.
   - Every task maps to a requirement, necessary scaffold, or documented delivery concern.
   - Task dependencies and parallel markers do not conflict.
   - The plan complies with constituted rules.
   - Terminology and technical decisions are consistent across artifacts.
7. **Resolve the gate.** Fix findings in the artifact that owns them. Obtain approval before implementation unless the user explicitly requested autonomous progression and no consequential architecture decision remains.

## Completion criteria

Plan is complete when:

- The design references the real codebase and names concrete affected paths.
- Every requirement maps to implementation work and direct verification evidence.
- Work is ordered into small, independently verifiable vertical slices.
- Risks, migrations, rollback needs, and unresolved technical decisions are explicit when applicable.
- A read-only consistency pass finds no blocking gap or contradiction.
