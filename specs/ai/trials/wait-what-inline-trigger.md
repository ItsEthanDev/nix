# Trial: Inline `wait what` trigger

- **Status:** Ready
- **Created:** 2026-09-01
- **Implemented:** 2026-09-01
- **Activated:** Not started
- **Earliest review:** One week after activation
- **Review condition:** At least one week of use and five genuine clarification opportunities after activation
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

The `wait-what` skill is available only through explicit user invocation. Ethan rarely invokes it because clarification is often needed for one part of a larger interaction rather than for an entire response.

During a grilling round, for example, Ethan may answer several questions while marking one question with `wait what`. The desired interaction preserves the other answers and re-explains only the marked question.

## Hypothesis

Making `wait what` available as an automatic, scope-sensitive clarification trigger will make the capability easier to use without disrupting the surrounding workflow or activating when the phrase is merely being discussed.

## Affected assets

- **Kind:** Skill
- **Capability specification:** None currently
- **Runtime path:** [`static/ai/skills/wait-what/SKILL.md`](../../../static/ai/skills/wait-what/SKILL.md)
- **Interacting capability:** [`static/ai/skills/grilling/SKILL.md`](../../../static/ai/skills/grilling/SKILL.md)

The trial may change only `static/ai/skills/wait-what/SKILL.md` initially. A change to `grilling` requires evidence that scoped clarification cannot preserve its design tree through the `wait-what` skill alone.

## Intended behavior

- When Ethan uses `wait what` as a clarification request, the agent recognizes it without explicit `/skill:wait-what` invocation.
- A numbered `wait what` answer targets the corresponding numbered question.
- A standalone `wait what` targets the immediately preceding claim, question, or bounded section that reasonably prompted it.
- The agent provides enough context to make the target understandable, uses clear language, and preserves established project terminology.
- When the phrase marks one item in a larger response, the agent re-explains only that item unless understanding it requires a narrowly identified dependency.
- The agent does not activate clarification behavior when Ethan is discussing the phrase, the skill, or this trial rather than requesting clarification.

### Grilling interaction

Given answers such as:

```text
1. my answer
2. my answer
3. my answer
4. wait what
5. my answer
```

The agent:

- records answers 1, 2, 3, and 5;
- leaves question 4 unresolved;
- re-explains only question 4;
- preserves the grilling design tree and does not treat question 4 as answered; and
- waits for the revised answer before advancing branches that depend on question 4.

## Non-goals

This trial does not:

- guarantee deterministic model invocation before evidence shows whether skill discovery is sufficient;
- introduce a Pi extension or other message interceptor;
- make `wait what` a request to restart or summarize the entire conversation;
- change the grilling question format or decision-tree model; or
- require clarification when the intended target cannot be identified responsibly.

## Failure conditions

Record an event as a failure when:

- the trigger is used as a clarification request but ignored;
- discussion of the phrase causes unwanted activation;
- the agent targets the wrong item;
- the agent re-explains the whole response when one item was marked;
- unrelated answers or workflow state are discarded;
- a marked grilling question is treated as answered; or
- the clarification adds substantial unrelated content without making the target easier to answer.

## Evaluation

For each genuine opportunity, record:

| Date | Context | Trigger used | Trigger recognized | Correct target | State preserved | Proceeded next turn | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |

No observations have been recorded yet.

### Measures

- **Trigger recall:** Recognized clarification triggers divided by clarification triggers used.
- **Trigger precision:** Intended clarification activations divided by all observed activations.
- **Target precision:** Recognized triggers that selected only the intended target.
- **State preservation:** Recognized triggers that retained unaffected answers and workflow state.
- **Next-turn resolution:** Events after which Ethan could answer or proceed without another re-explanation.
- **Practical usage:** Genuine opportunities in which the inline trigger was used instead of explicit skill invocation or abandoning clarification.

### Adoption criteria

Evaluate the trial only after its review condition is satisfied. Adopt the behavior when:

- at least four of five clarification triggers are recognized;
- every recognized trigger selects the correct target;
- every recognized trigger preserves unaffected state;
- no false activation is observed while discussing the phrase or skill; and
- at least three events allow Ethan to proceed on the next turn.

Revise rather than adopt when invocation is useful but target selection or workflow preservation fails. Reject the behavior when false activation or disruption outweighs improved access. Mark the result `Inconclusive` when fewer than five genuine opportunities occur.

## Revision anchors

- **Baseline revision:** `0ab680ec82878fb1ec40029a0232916bdfb7bdbb`
- **Trial definition revision:** `24d58e0dd0394f21879d85e8882ed0bcdfebef1d`
- **Implementation revision:** `a0ee2fc7e4ae40d121ca6e2a5265c4487c4bce7a`
- **Outcome revision:** Not started
- **Implementation path:** `static/ai/skills/wait-what/SKILL.md`

The baseline revision contains the accepted runtime skill before this trial. The implementation revision changes only the runtime path listed above.

## Rollback

Before dependent work builds on the trial, revert its atomic implementation commit:

```sh
git revert <implementation-revision>
```

If later work prevents a clean revert, restore the affected runtime path from the baseline and commit the reconciliation:

```sh
git restore --source=0ab680ec82878fb1ec40029a0232916bdfb7bdbb -- \
  static/ai/skills/wait-what/SKILL.md
```

Rollback must preserve this trial artifact and record the rejected or revised outcome.

## Outcome

No outcome has been recorded. The trial remains `Ready` until the configured skill is deployed and activation evidence is recorded.

## Sources

This trial follows the [AI asset evolution specification](../evolution.md) and is constrained by the [AI-assisted development specification](../spec.md) and applicable [AI development directives](../directives.md).
