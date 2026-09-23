# Trial: Direct and concrete model output

- **Status:** Trialing
- **Created:** 2026-09-22
- **Implemented:** 2026-09-22
- **Activated:** 2026-09-22
- **Review condition:** Observe at least twelve substantive responses across at least four response categories and three Pi sessions
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

Normal model output can be harder to read than its content requires. Recurring causes include unsupported trailing claims, vague attribution, stock AI vocabulary, ornate substitutes for simple verbs, forced rhetorical patterns, decorative punctuation, excessive emphasis, chatbot pleasantries, filler, hedging, generic conclusions, vague product language, dense sentences, inconsistent terminology, and compressed fragments.

Plain-language guidance can also remove useful jargon. Established technical terms often express a concept more precisely and briefly than an improvised plain-language substitute. The problem is unexplained or unnecessary jargon, not jargon itself.

The configured writing skill already guides durable technical prose, but ordinary explanations, summaries, recommendations, and questions do not always activate that skill. The proposed behavior therefore belongs in the always-loaded global agent instructions while it is evaluated.

## Hypothesis

If the global agent instructions require direct, concrete prose and calibrated use of technical terms, model responses will become easier to read without losing precision. Briefly defining an uncommon term on first use will create a learning opportunity without requiring a persistent vocabulary model. A concise instruction block will affect ordinary responses while avoiding the context cost and mechanical behavior of a large phrase blacklist.

## Affected assets

- **Kind:** Global agent instructions
- **Runtime path:** `static/ai/AGENTS.md`
- **Interacting capability:** `static/ai/skills/writing/human-writing.md`

The global instructions own behavior that should apply to ordinary model output. The writing skill continues to own document-specific structure and editing guidance. The first revision does not change the writing skill so the effect of the always-loaded instruction can be observed separately.

## Intended behavior

- Lead with the answer, action, or decision the reader needs.
- Prefer concrete facts, actions, mechanisms, constraints, examples, and measurements over promotional or generic descriptions.
- Name the source of an attributed claim instead of referring vaguely to experts, reports, or critics.
- Use one consistent term for each concept.
- Use an established technical term when it is more precise than a plain substitute.
- Briefly define an uncommon term on first use unless the current conversation has established it.
- Prefer direct sentences, active voice when the actor matters, and complete prose that does not require the reader to decode fragments or backtrack.
- Avoid forced rhetorical patterns, decorative punctuation, excessive emphasis, chatbot pleasantries, filler, unnecessary hedging, and generic conclusions.
- End when the requested answer is complete.

## Scope

The behavior applies to conversational prose and durable prose produced by the agent. It does not alter literal text that must remain exact, including code, commands, paths, symbols, copied quotations, protocol values, generated output, and externally defined names.

Explicit user requests, established artifact conventions, and required templates take precedence over these defaults.

## Non-goals

This trial does not:

- remove precise technical vocabulary;
- maintain a persistent record of terms Ethan understands;
- require definitions for familiar terms or terms already established in the conversation;
- prohibit passive voice when the actor is unknown or irrelevant;
- require complete sentences in headings, table cells, labels, or other structures where fragments are conventional;
- treat a mechanical word count as proof of readability;
- change the writing skill during the first revision; or
- override a requested voice, quotation style, or exact source text.

## Failure conditions

Record an event as a failure when the instructions:

- make prose choppy, monotonous, or harder to scan;
- remove or replace a precise technical term with a less accurate phrase;
- change technical meaning to avoid a word or construction;
- define familiar terms so often that the response becomes patronizing or distracting;
- define jargon with unexplained jargon;
- produce awkward synonyms to avoid stock vocabulary;
- prevent useful technical notation or exact text;
- cause a response to violate the established style of its artifact;
- increase length without adding information; or
- improve mechanical pattern counts without improving readability.

Also record repeated output that retains the targeted problems, including vague attribution, unsupported claims, terminology cycling, rhetorical padding, decorative punctuation, excessive boldface, chatbot phrases, filler, and compressed prose.

## Baseline

The baseline is the accepted global instruction set before this trial. It contains delegation guidance but no general output-style instruction. Ethan identified the targeted patterns from normal model use and supplied representative examples on 2026-09-22.

The first implementation will use a short behavior-oriented instruction block rather than copying the full diagnostic list into always-loaded context. The supplied examples remain evaluation cues for identifying whether the broader instructions change the intended behavior.

## Evaluation

### Observation period

Observe at least twelve substantive responses across at least three Pi sessions. Include at least two responses from each of four categories:

- technical explanation;
- recommendation or tradeoff discussion;
- implementation, diagnosis, or verification summary; and
- durable prose drafted for a repository artifact.

A response is substantive when it contains enough original prose to expose style choices. Short acknowledgments, tool-status updates, copied text, and exact command output do not count.

For each event, record:

| Field | Evidence to record |
| --- | --- |
| Identity | Date, Pi session path or ID, and response entry |
| Category | Explanation, recommendation, summary, durable prose, or another justified category |
| Readability | Whether Ethan could read it without backtracking or requesting a style rewrite |
| Concrete content | Any vague project-specific claim, unsupported consequence, or generic conclusion |
| Terminology | Inconsistent names, avoided technical terms, missing definitions, or excessive definitions |
| Language | Stock phrasing, filler, hedging, ornate substitutes, or forced rhetorical patterns |
| Structure | Dense sentences, compressed fragments, decorative punctuation, or excessive emphasis |
| Meaning | Any loss of precision or changed technical meaning attributable to the trial |
| User feedback | Specific correction, preference, or learning benefit when one occurred |

Mechanical searches for listed words or punctuation may help find candidates. They do not determine whether an event passes because context decides whether a term or construction is useful.

### Measures

- **Readable response rate:** observed responses that require no backtracking or style rewrite divided by all observed responses.
- **Concrete response rate:** observed responses without a vague project-specific claim, unsupported consequence, or generic conclusion divided by all observed responses.
- **Terminology failure count:** inconsistent terms, imprecise substitutions, missing useful definitions, and excessive definitions.
- **Target-pattern count:** contextual occurrences of the recurring language, structure, and communication problems identified in this trial.
- **Meaning failures:** responses whose accuracy or precision worsened because of the instructions.
- **User preference:** Ethan's preference for the trial style over the pre-trial experience at review.

### Adoption criteria

Adopt the behavior when:

- at least ten of the twelve observed responses need no readability correction;
- at least ten of the twelve contain no vague or generic project-specific claim;
- no response loses technical meaning or replaces a precise term with a less accurate phrase;
- jargon definitions are brief and useful when needed, without a repeated pattern of unnecessary definitions;
- no targeted style failure repeats in the final five observations; and
- Ethan prefers the trial output to the pre-trial experience.

Revise when the output is generally easier to read but one or more instructions cause a repeated, bounded problem. Reject when the instructions reduce precision, consistently produce choppy prose, or do not materially improve readability. Mark the trial `Inconclusive` when too few substantive responses occur or the observations do not cover the required categories.

## Revision anchors

- **Baseline revision:** `d87f179270a354538f2aa6af56c8a0d8fa93f88a`
- **Trial definition revision:** `084e528fe03f1080075e3ab1d71eebf94badcf57`
- **Implementation revisions:**
  - `f1cef79a0d6ec72159016b9e544ccb7d5ccac4de` — add direct and concrete writing defaults to the global agent instructions
- **Outcome revision:** Not started

## Activation evidence

- **Activated:** 2026-09-22 on `turing`
- **Command:** `sudo nixos-rebuild switch --flake .#turing`
- **System generation:** `/nix/store/6lvi4vvykbhlmnymc7kgdjwbkwjj961d-nixos-system-turing-26.11.20260922.6774f7b`
- **Managed instruction:** `/nix/store/zm2r6777695xkw7zg1sbj4n2xjsn7qja-hm_AGENTS.md`
- **Verification:** The managed instruction matches `static/ai/AGENTS.md`, contains the trial section, and system and user failed-unit checks returned no failures.

Observation events begin after this activation. Existing Pi processes must run `/reload` or restart before their behavior counts toward the trial.

## Rollback

Revert the runtime revision while preserving this trial and its evidence:

```sh
git revert f1cef79a0d6ec72159016b9e544ccb7d5ccac4de
```

If later work prevents a clean revert, restore `static/ai/AGENTS.md` from `d87f179270a354538f2aa6af56c8a0d8fa93f88a`, then reconcile later instructions explicitly.

## Outcome

No outcome has been recorded. The trial remains `Trialing` until its observation period supports adoption, revision, rejection, or an inconclusive result.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md), refines adaptable assistance and economical changes in the [AI-Assisted Development specification](../spec.md), and interacts with the configured [human-writing guidance](../../../static/ai/skills/writing/human-writing.md). It preserves canonical ownership and direct-evidence requirements from [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior) and [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence).
