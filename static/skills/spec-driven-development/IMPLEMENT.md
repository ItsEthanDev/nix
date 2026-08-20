# Implement

Execute an accepted plan in small, verified vertical slices, then prove that the delivered behavior converges with the specification.

## Process

1. **Load the current state.** Read the specification, plan, task list, constituted rules, and relevant source and tests. Identify the next unblocked slice and its `FR-###`, `SC-###`, and `US#` references.
2. **Establish the proof.** Run the planned verification before editing. For a test-first slice, load the `tdd` skill and observe the focused test fail for the missing behavior. Otherwise record the direct baseline that can distinguish success from failure.
3. **Implement one slice.** Make the smallest change that satisfies the selected requirements. Do not begin unrelated slices or speculative cleanup.
4. **Verify the slice.** Run its focused checks and inspect the actual behavior. Then run affected broader checks needed to detect regressions. Record commands and outcomes.
5. **Reconcile discoveries.** When implementation invalidates an assumption, update the owning artifact before continuing: behavior in the spec, technical approach in the plan, and ordering or progress in the task list. Ask only when the decision is consequential and cannot be inferred responsibly.
6. **Record progress.** Mark a task complete only after its verification succeeds. Preserve its functional-requirement, success-criterion, and user-story references in the task state or completion report so evidence remains traceable.
7. **Repeat by dependency order.** Start the next unblocked slice only after the current slice is complete. Keep each run small enough that the agent can reread its source artifacts instead of relying on conversation memory.
8. **Converge.** After all planned slices, compare the implementation directly with every accepted requirement and constituted rule. If a gap exists, append a concrete convergence task without rewriting completed task history, implement it, and repeat the convergence check.
9. **Finish cleanly.** Run the complete relevant test, build, lint, and format commands; inspect the diff; remove temporary instrumentation; and report requirement-to-evidence results plus any accepted deviation.

## Completion criteria

Implement is complete when:

- Every accepted functional requirement and buildable success criterion has direct passing evidence.
- Focused and relevant regression checks pass.
- The specification, plan, task state, and implementation agree.
- No temporary debugging artifact or unrecorded deviation remains.
- The final report names the verification commands and outcomes.
