---
description: Turn the gap between current and target state into an approved ticket roadmap.
agent: build
---

# Ticket Roadmap

Load the `documentation` skill and its ticket guidance. Turn the gap between the project's verified current state and confirmed target state into a dependency-ordered roadmap of session-sized, independently verifiable tickets.

`$ARGUMENTS` optionally narrows the scope. When empty, use the scope established by the current conversation and canonical specification.

The command is interactive. Review candidate tickets with the user before writing ticket files. Keep implementation and target-state documentation unchanged.

## 1. Establish The Gap

Read the applicable project instructions, specification, domain glossary, ADRs, existing ticket documentation, and relevant implementation and tests.

Treat canonical specification as target state and implementation as evidence of current state. Account for existing active and completed tickets so the roadmap does not duplicate work.

When target intent, current behavior, or scope is unclear enough to change the roadmap, ask one focused question, provide a recommended answer and its main trade-off, and wait for the user's decision.

This step is complete when the current-to-target gap and any uncovered specification scope are explicit.

## 2. Draft The Candidate Roadmap

Privately draft the complete roadmap before presenting individual tickets. Use provisional identifiers such as `P1`, `P2`, and `P3`; assign persistent ticket IDs only after approval.

Prefer vertical slices that make end-to-end behavior work. Each candidate must:

- Be completable in one agent session.
- Produce an independently verifiable outcome.
- Link to confirmed target-state intent.
- Include only direct dependencies that genuinely gate starting or completing it.
- Avoid depending on a ticket merely because that ticket is earlier in a preferred execution order.
- Preserve a directed acyclic dependency graph.
- Cover a distinct part of the current-to-target gap without duplicating another ticket.

Look for opportunities to make the change easy before making the easy change. Use a separate behavior-preserving prefactor candidate only when it is independently verifiable and directly enables a named successor; avoid generic cleanup tickets.

The candidate set must cover the full scoped specification or explicitly identify the remaining coverage gap.

This step is complete when every scoped target behavior is covered by a candidate or a named gap and every dependency has a concrete gating reason.

## 3. Review Tickets One At A Time

Present one candidate at a time in dependency order. Show exactly:

```text
Title: {short descriptive name}
Blocked by: {provisional identifiers and titles, or None}
What it delivers: {the end-to-end behavior or independently verifiable enabling outcome this ticket makes work}
```

For the displayed candidate, ask these questions one at a time and wait for each answer before asking the next:

1. **Does the granularity feel right?** Offer `right`, `too coarse`, and `too fine`, and recommend one with a brief reason.
2. **Are the blocking edges correct?** Ask whether every listed dependency genuinely gates this ticket and whether a necessary direct blocker is missing. Provide your recommendation.
3. **Should any tickets be merged or split further?** Name any merge or split you recommend and why.

Apply the user's answers immediately. After a split, merge, reordered boundary, or changed dependency, recompute the complete candidate graph and re-review every affected candidate in its latest form. Keep unaffected approvals unless the revision changes their outcome or dependencies.

Do not advance past a candidate until the user has answered all three questions for its current form.

After every candidate has passed review, present a concise roadmap summary in dependency order and ask one final question: **Do you approve this complete ticket breakdown?**

If the user does not approve, ask one focused question at a time, revise the roadmap, re-review affected candidates, and request final approval again. Continue until the user explicitly approves the complete breakdown.

This step is complete only after explicit approval of the full candidate set and dependency graph.

## 4. Publish Approved Tickets

After approval, follow the project's established ticket conventions. Otherwise use the documentation skill's Markdown ticket layout under `docs/tickets/`.

Assign the next available stable ticket IDs without changing existing IDs. For each approved candidate:

- Use the approved title.
- Store direct blockers in `depends-on`; derive reverse `blocks` relationships in the index.
- Use the approved `What it delivers` statement as the ticket outcome.
- Link the applicable specification and constraints.
- Bound the scope to the approved session-sized outcome.
- Add observable acceptance criteria and a concrete verification method for each criterion.
- Set `ready` only when the ready gate is satisfied, `blocked` when an incomplete dependency or external condition gates it, and `needs-info` when a user decision remains.

Update the ticket index with the active queue, dependency-aware execution order, intended specification coverage, and any known gap. Do not publish unapproved candidates or silently change approved titles, outcomes, or dependencies while expanding their implementation detail.

## 5. Verify The Roadmap

Check that:

- Every published ticket matches its approved title, blockers, and delivered outcome.
- Every ticket is session-sized and independently verifiable.
- Every dependency is direct, necessary, and acyclic.
- Every scoped target behavior is covered exactly once or named as a gap.
- Every ticket contains enough durable context to execute without the originating conversation.
- Ticket state reflects the work that actually remains.
- The index and ticket files agree.

The complete output of this command is approved ticket documentation. Summarize the published roadmap and any explicit coverage gap, then stop before implementation.
