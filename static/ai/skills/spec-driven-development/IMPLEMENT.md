# Implement

Execute an accepted plan in small verified slices, then prove that delivered behavior converges with accepted intent.

Use the `project-documentation` skill when reading or reconciling artifact ownership, identifiers, lifecycle, or task state. Do not redefine artifact conventions during execution.

## Process

1. **Load current state.** Read accepted behavior, technical design, execution state, applicable project rules, and relevant source and tests. Select the next unblocked slice and identify the requirements and stories it serves.
2. **Establish proof.** Run the planned focused verification before editing. For a test-first slice, load `tdd` and observe the focused test fail for the missing behavior. Otherwise record a direct baseline that distinguishes success from failure.
3. **Implement one slice.** Make the smallest change that satisfies the selected requirements. Do not begin unrelated slices or speculative cleanup.
4. **Verify the slice.** Run focused checks and inspect actual behavior, then run the broader affected checks needed to detect regressions. Record commands and outcomes.
5. **Reconcile discoveries.** When implementation invalidates an assumption, return to constitute for durable rules, specify for behavior or scope, and plan for technical approach or sequencing. Update the canonical owner before continuing.
6. **Record progress.** Mark work complete only after its verification succeeds. Preserve traceability from task through requirement to evidence.
7. **Repeat by dependency.** Start the next unblocked slice only after the current slice is complete. Keep each run small enough to reread source artifacts rather than relying on conversation memory.
8. **Converge.** Compare delivered behavior directly with every accepted requirement and applicable project rule. Add and execute concrete convergence work for each gap without rewriting completed history to conceal it.
9. **Finish cleanly.** Run complete relevant test, build, lint, and format commands; inspect the diff; remove temporary instrumentation; reconcile artifact status; and report requirement-to-evidence results plus accepted deviations.

## Completion criteria

Implement is complete when:

- Every accepted requirement and buildable success criterion has direct passing evidence.
- Focused and relevant regression checks pass.
- Delivered behavior, documentation, and execution state agree.
- No temporary debugging artifact or unrecorded deviation remains.
- The final report names verification commands and outcomes.
