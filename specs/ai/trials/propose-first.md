# Trial: Propose before implementing

- **Status:** Proposed
- **Created:** 2026-09-23
- **Review condition:** Observe at least five genuine requests, including the shorthand and a natural-language request, across at least two kinds of work
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem and hypothesis

A request to explain a solution before changing anything needs a clear pause before implementation, without preventing inspection or forcing a full planning workflow. A top-level, model-invoked `propose-first` technique should recognize both the shorthand and equivalent requests, produce a useful bounded proposal with the next actions assigned clearly, and wait for approval of that approach before implementing it.

## Affected asset and scope

- **Kind:** Model-invoked Pi skill, also callable as `/skill:propose-first`.
- **Runtime path:** [`static/ai/skills/propose-first/SKILL.md`](../../../static/ai/skills/propose-first/SKILL.md).
- **Discovery:** The existing `static/ai/skills` Pi settings entry discovers the new skill; no Nix setting change is planned.

This trial changes only that runtime path. It does not impose an approval gate on requests that do not ask for a proposal first.

## Intended behavior

- Activate for `propose first`, an explicit skill invocation, or a request to explain a recommended solution before making the change. Discussion *about* this technique does not activate it.
- Investigate as needed before proposing, including reading, inspection, and checks. The skill adds a pause before implementation, not before investigation. Existing authorization and safety rules still govern other actions.
- Explain the problem as understood and recommend a proportionate approach, including only material uncertainty or alternatives that affect a decision.
- Identify what the user needs to tell or decide, what the user needs to do outside the agent's reach, and what the agent can do and verify after approval. Omit empty categories; avoid requesting secrets in chat.
- Wait for approval of the bounded approach before implementing. A supplied fact or follow-up question alone does not grant approval. If a reported observation changes the proposed approach, revise the proposal before asking for approval.
- Approval of the proposal does not authorize pushing, deployment, or unrelated external actions.

## Interactions and non-goals

The [AI collaboration specification](../spec.md) owns the normal threshold for consequential decisions. This technique creates an additional, request-specific pause without changing that threshold for other work. Project rules and existing external-action permissions still apply. Lifecycle skills own phase transitions; problem-solving playbooks own their own strategies. This skill does not prescribe either.

The skill should not block harmless investigation, demand a fixed response template, invent questions to fill categories, or turn a small recommendation into an exhaustive plan.

## Failure conditions and evaluation

Record a failure when the agent implements before receiving approval, treats a supplied fact or follow-up question as approval, activates for an ordinary implementation request or discussion about the skill, blocks investigation solely because of this skill, asks for a secret in chat, or treats approval as permission for an unrelated external action. Also record when the proposal lacks a decision-ready recommendation or creates unnecessary explanation and questions.

| Date | Request type | Relevant activation | Investigation allowed | Proposal useful | Pause respected | Follow-up handled | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |

Adopt when at least five genuine opportunities include both shorthand and natural-language activation, no request crosses the implementation or external-action boundaries, and the proposals provide a useful next decision without excessive interruption. Revise if triggers or proposal shape need adjustment. Reject if false activation or friction outweighs the value. Mark `Inconclusive` if there are too few genuine opportunities.

## Verification plan

Validate skill discovery and frontmatter through Pi, inspect representative shorthand, natural-language, and non-trigger prompts, and check that the new source is included in the configured Nix skill tree. These checks do not count as genuine trial events.

## Revision anchors

- **Baseline revision:** `b309c6ce5c607cbf8b49440fa6405af184845253`
- **Trial definition revision:** Pending definition commit
- **Implementation revision:** Pending
- **Outcome revision:** Not started

## Rollback

Remove `static/ai/skills/propose-first/SKILL.md` and preserve this trial and its evidence. Reconcile any later dependent instructions if necessary.

## Outcome

No runtime behavior has changed. Observation begins after the new skill is available through the configured environment.

## Sources

The candidate was captured in the Studio inbox as `inbox/2026-09-23-propose-before-implementing.md`, with follow-up decisions on 2026-09-23. This trial follows [AI Asset Evolution](../evolution.md) and is constrained by the [AI collaboration specification](../spec.md), [AI development directives](../directives.md), and [project constitution](../../constitution.md).
