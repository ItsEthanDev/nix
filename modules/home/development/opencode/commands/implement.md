---
description: Implement selected tickets through TDD, local commits, and final integration verification.
agent: build
---

# Implement Tickets

Load the `documentation` and `tdd` skills before changing the project. Implement the selected tickets completely or update each ticket to explain why it could not be completed.

## Input

Selection: $ARGUMENTS

Accept one ticket, several ticket IDs or paths, or `all`:

- `/implement TKT-001`
- `/implement TKT-001 TKT-004 TKT-006`
- `/implement all`

`all` means every non-terminal ticket in the active ticket roadmap. When the arguments and current conversation do not identify the intended selection unambiguously, ask the user which tickets to include and wait before proceeding.

The selected ticket list is the session boundary. Include an additional dependency only with the user's approval. Keep remote version-control state unchanged: do not push, pull, fetch, or otherwise interact with a remote.

## 1. Prepare The Session

Read the selected tickets, their direct dependencies, linked specification, applicable domain glossary and ADRs, current implementation, project instructions, and established test and typecheck commands.

Order selected tickets by their dependency graph and create a session task list. Check whether any incomplete dependency falls outside the selected scope. When this is visible before implementation, ask whether to include that dependency or leave the selected ticket blocked.

Front-load foreseeable questions before work begins. This includes ticket selection, dependency scope, test seams not already confirmed by canonical documentation, likely new dependencies or tools, consequential implementation choices not settled by design, and missing test or typecheck commands. Ask focused questions and provide recommended answers with their main trade-offs.

Identify the fixed project state before making any change:

- In Git, record the current branch, `git rev-parse HEAD` as the base SHA, and the initial worktree status.
- If the Git worktree contains pre-existing changes that prevent safe ticket commits or make the review boundary ambiguous, show them and ask how the user wants to establish or qualify the baseline. Preserve unrelated changes and never stage them without explicit approval.
- With another version-control system, record its equivalent immutable revision.
- Without an immutable revision, ask the user how to establish a reviewable fixed point before implementation.

Determine the narrow focused-test command, typecheck command, and final full-suite command from project documentation and configuration. Treat explicitly approved test seams as pre-agreed; otherwise present the proposed public seams for the selected tickets and obtain confirmation before writing tests.

This step is complete when the selected queue, dependency scope, test seams, verification commands, commit strategy, and review baseline are explicit.

## 2. Execute The Queue

Continue until every selected ticket is `complete`, `needs-evaluation`, `needs-info`, or `blocked`. A blocked ticket does not stop independent tickets later in the queue.

For each ticket whose selected dependencies permit work:

1. Mark it `in-progress` and read its outcome, specification, acceptance criteria, verification, and affected canonical documentation.
2. Use the documentation skill throughout. Update durable documentation as confirmed behavior, design, domain language, setup, or current usage changes. If implementation reveals unaccounted drift or an unresolved target-state decision, preserve the uncertainty instead of guessing.
3. Follow the TDD skill in vertical slices. Run the narrowest relevant test file to establish red, after each green change, and after refactoring. Keep expected values independent from implementation and test through approved public seams.
4. Run typechecking after meaningful green or refactoring slices and again before closing the ticket. Resolve attributable type errors before proceeding.
5. Run the ticket's remaining focused verification. Reserve the full test suite for the final integration gate.
6. Update the ticket to reflect the outcome: `complete` when all acceptance is objectively satisfied, `needs-evaluation` when named human judgment remains, `needs-info` when a user decision is required, or `blocked` when an incomplete dependency or external condition prevents completion.
7. In Git, inspect the working tree and staged diff, stage only changes belonging to this ticket, and create descriptive local commits that follow project convention and identify the ticket. Every ticket that reaches `complete` or `needs-evaluation` must have at least one commit; use additional coherent commits when they improve reviewability. Include the ticket state and its related documentation in the appropriate ticket commit. Let hooks run normally and create follow-up commits rather than amending earlier commits.

Commit only independently valid work. If a blocker appears after partial implementation, retain and commit partial work only when it is useful, verified, and accurately documented in the ticket; otherwise remove only the incomplete changes introduced for that ticket while preserving pre-existing work.

## Blocker Policy

When a blocker is discovered during implementation, do not interrupt the remaining queue:

- Record the exact blocker and any deferred question in the affected ticket.
- Use `needs-info` for a user decision and `blocked` for an incomplete dependency or external condition.
- Add or update a canonical open question only when the uncertainty belongs outside ticket work-state.
- Propagate the blocker to selected dependents whose work it genuinely gates.
- Continue with every independent selected ticket that can still make progress.
- Keep newly discovered out-of-scope dependencies outside the session unless the user approves expanding the selection.

Back-load questions discovered during implementation. Do not prompt the user mid-queue for a ticket-specific blocker; collect deferred questions by ticket and present them after all independent work and final verification are exhausted.

This step is complete when no selected ticket remains pending or `in-progress` and every incomplete ticket records the state and reason that stopped it.

## 3. Run The Integration Gate

After the selected queue reaches terminal session states, run typechecking and the full test suite as the final integration gate. Do not use the full suite as the routine inner loop.

If the final gate fails, identify whether each failure is attributable to selected work, a documented pre-existing condition, or an unrelated project change. Fix attributable failures without user input when the required behavior is already confirmed, rerun focused checks, and rerun the final gate. When a failure requires a user decision or unavailable dependency, update affected ticket states and defer the question.

Commit integration fixes locally with the applicable ticket IDs. Commit final ticket or documentation state updates as needed. Inspect the final worktree and keep unrelated pre-existing changes uncommitted and clearly identified.

This step is complete when the final typecheck and full-suite results are recorded and every selected ticket status reflects those results.

## 4. Report The Session

Continue generation through this report without waiting for additional prompting. In the final response provide:

- The starting fixed point and ending revision. In Git, include the base SHA, final HEAD SHA, branch, and review range `<base>..<final>`.
- Each selected ticket's final status and associated commit SHA or SHAs.
- Focused tests, typechecking, and full-suite commands run with their results.
- Documentation updated during implementation.
- Any pre-existing or remaining worktree changes outside the commits.
- Deferred questions and blockers grouped by ticket, after all completed work is reported.

If deferred questions exist, ask them at the end of the implementation report. The session is complete when every selected ticket was completed or records why it was not, all implementation-session work that is safe to retain is committed, the integration gate is recorded, and the review boundary is explicit.
