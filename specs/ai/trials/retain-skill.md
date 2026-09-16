# Trial: Retain durable learning candidates

- **Status:** Proposed
- **Created:** 2026-09-15
- **Review condition:** Observe at least five genuine invocations across at least three useful work boundaries, including at least one invocation that returns no candidates
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem and hypothesis

Useful project knowledge, personal working preferences, and cross-project practices can emerge during normal collaboration without reaching a durable owner. Automatically storing conversational details would preserve noise, create uncertain authority, and remove Ethan's control over what becomes memory. A conventional retrospective would also be too broad and interruptive because it tends to summarize work, review quality, and generate action items.

A manually invoked `retain` skill should provide a low-friction curation boundary. It should use only the context already available, surface no more than three high-value durable capture candidates, and leave every persistence decision to Ethan. Strict admission criteria and an explicitly valid empty result should make the output useful without turning each boundary into another review phase.

## Affected asset

- **Kind:** Human-invoked Pi skill
- **Runtime path:** [`static/ai/skills/retain/SKILL.md`](../../../static/ai/skills/retain/SKILL.md)
- **Discovery:** The existing `static/ai/skills` Pi settings entry discovers the new skill recursively; no Nix configuration change is required.

## Intended behavior

- `/skill:retain` examines the current conversation and already-loaded context without calling tools or rereading project artifacts.
- It considers one broad class of output: durable capture candidates.
- Optional scope labels distinguish where a candidate applies:
  - **Project:** a project-specific fact, decision, constraint, convention, or vocabulary item;
  - **Personal:** an explicit or strongly established preference about how Ethan works; or
  - **Reusable:** knowledge, a technique, a pitfall, or a procedure that can help across projects.
- Labels are tags, not quotas. The skill does not manufacture one candidate per scope.
- Every reported candidate is durable, specific, novel relative to the available context, high-confidence, worth maintaining, and routable to a broad canonical owner.
- The skill returns at most three candidates in descending value, with each candidate occupying one concise bullet.
- When nothing clearly qualifies, it returns `No durable learnings to capture.`
- The skill does not write, update, or otherwise persist a candidate. Ethan decides whether to reject it or promote it through the appropriate documentation or configuration workflow.

Useful boundaries include completed planning, a completed implementation slice, the end of a larger task, before conversation compaction, and the end of a working session. Invocation remains Ethan's choice rather than an automatic boundary hook.

## Interactions

- `retain` extracts possible durable knowledge; [`project-documentation`](../../../static/ai/skills/project-documentation/SKILL.md) selects and updates canonical project artifacts after Ethan accepts a project candidate.
- Personal candidates may later update [`preferences`](../../../static/ai/skills/preferences/SKILL.md), agent instructions, or another applicable capability, but `retain` does not perform that update.
- Reusable candidates may later revise a skill, template, or tool through its normal evolution workflow.
- [`handoff`](../../../static/ai/skills/handoff/SKILL.md) preserves transient continuation context for another session. `retain` does not duplicate handoff state, work summaries, open tasks, or resume instructions.

## Non-goals

This trial does not:

- create autonomous or hidden memory;
- search the repository to prove that a candidate is absent;
- summarize completed work or the conversation;
- review implementation, planning, agent performance, or process quality;
- produce action items, unresolved-task lists, or a handoff;
- infer a personal preference from one incidental choice;
- retain generic advice, routine technical facts, temporary state, or speculative conclusions; or
- automatically modify documentation, code, instructions, skills, or configuration.

## Failure conditions

Record an invocation as a failure when:

- the skill calls a tool or rereads an artifact without an explicit user request to do so;
- output becomes a work summary, review, handoff, or action list;
- more than three candidates are returned;
- labels are treated as required sections and weak candidates are added to fill them;
- a candidate is ephemeral, generic, speculative, already known to be recorded, or based on a weak preference inference;
- a candidate lacks a plausible durable owner;
- the skill writes or updates an artifact rather than leaving curation to Ethan;
- an empty result would have been more useful than the reported candidates; or
- the response is long enough to materially interrupt continuation of the primary work.

## Evaluation

Record genuine invocations in this table:

| Date | Boundary | Candidate count | Scopes | Useful candidates | Empty appropriate | No tools or writes | Low friction | Notes |
| --- | --- | ---: | --- | ---: | --- | --- | --- | --- |

Adopt the capability when:

- all invocations respect the three-candidate cap and perform no tools or writes;
- at least 80% of reported candidates are judged genuinely durable, specific, and worth routing;
- no scope is filled merely to satisfy the output shape;
- every empty result is acceptable and at least one genuine invocation correctly returns no candidates; and
- Ethan judges the output brief enough to use at normal work boundaries without delaying continuation.

Revise when the capability is useful but candidate quality, scope labels, admission criteria, output shape, or invocation boundaries need adjustment. Reject it when weak suggestions or interruption cost outweigh the value of occasionally capturing durable knowledge.

## Revision anchors

- **Baseline revision:** `30dd14de4fdfb2cb0830bd22e056f55a7f9f0964`
- **Trial definition revision:** Pending commit
- **Implementation revision:** Pending commit
- **Outcome revision:** Not started

## Rollback

Remove `static/ai/skills/retain/SKILL.md` to return to the baseline runtime. Preserve this trial and record the rejected or revised outcome.

## Outcome

Observation has not started.

## Sources

This trial records Ethan's requested curated-memory workflow and follows the [AI Asset Evolution specification](../evolution.md). It is constrained by the [AI-assisted development specification](../spec.md), applicable [AI development directives](../directives.md), and the [project constitution](../../constitution.md).
