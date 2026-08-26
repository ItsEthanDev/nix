# Implement

Execute an accepted technical design in small verified slices, then prove that delivered behavior converges with accepted intent.

Use the `project-documentation` skill when reading or reconciling artifact ownership, identifiers, lifecycle, or task state. Do not redefine artifact conventions during execution.

## Process

1. **Load current state.** Read accepted behavior, technical design, execution state, applicable project rules, and relevant source and tests from their canonical owners. Select the next unblocked task or slice and identify each applicable `US-###`, `FR-###`, and `SC-###` reference. When it has no requirement or outcome reference, confirm that it is a justified scaffold or delivery-administration task before proceeding.
2. **Establish proof.** Run the planned focused verification before editing. For a test-first slice, load `tdd` and observe the focused test fail for the missing behavior. Otherwise record a direct baseline that distinguishes success from failure.
3. **Implement one slice.** Make the smallest change that satisfies the selected requirements. Do not begin unrelated slices or speculative cleanup.
4. **Verify the slice.** Run focused checks and inspect actual behavior, then run the broader affected checks needed to detect regressions. Record commands and outcomes.
5. **Reconcile discoveries.** When implementation invalidates an assumption, return to constitute for durable rules, specify for behavior or scope, and plan for technical approach or sequencing. Update the canonical owner before continuing.
6. **Record progress.** Mark a task complete only after its verification succeeds. When no separate task owner exists, record only the execution state needed by the canonical planning owner or final handoff. Preserve traceability from delivery work through requirement to evidence; justified scaffold and delivery-administration work may reference its upstream plan instead of a requirement.
7. **Repeat by dependency.** Start the next unblocked slice only after the current slice is complete. Keep each run small enough to reread source artifacts rather than relying on conversation memory.
8. **Converge.** Compare delivered behavior directly with every accepted requirement and applicable project rule. Add and execute concrete convergence work for each gap in the task owner when one exists, otherwise in the canonical planning owner. Do not rewrite completed history to conceal a gap.
9. **Finish cleanly.** Run complete relevant test, build, lint, and format commands; inspect the diff; remove temporary instrumentation; and record requirement-to-evidence results plus accepted deviations in the verification-result owner selected by `project-documentation`. When lifecycle metadata is in use and convergence is complete, mark the specification `Implemented` and the plan `Completed`. Do not advance either status while an accepted requirement, planned task, or required verification remains incomplete.

## Completion criteria

Implement is complete when:

- Every accepted requirement and buildable success criterion has direct passing evidence.
- Focused and relevant regression checks pass.
- Delivered behavior, documentation, and execution state agree, and lifecycle states reflect that convergence when used.
- No temporary debugging artifact or unrecorded deviation remains.
- The selected verification-result owner records verification commands and outcomes.
