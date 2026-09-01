# AI Asset Evolution

This living specification defines how experimental changes to configured AI assets are proposed, implemented, evaluated, and resolved. It applies to skills, system instructions, MCP servers, tools, extensions, prompt templates, agent configuration, and combinations of those assets.

The goal is to distinguish inherited or experimental behavior from Ethan's accepted intent while allowing the environment to evolve through use.

## Ownership model

- [`spec.md`](spec.md) owns the overall AI collaboration model.
- [`directives.md`](directives.md) owns accepted, durable instructions that implementations must preserve.
- Capability specifications such as those under [`skills/`](skills/) own substantial design intent for one capability.
- A trial under [`trials/`](trials/) owns a provisional hypothesis, intended behavior, evaluation method, evidence, and outcome.
- Runtime assets own task-specific implementation.
- Git owns chronological history; specifications own current accepted meaning.

A trial does not become a durable directive merely because its implementation exists. Adopt its accepted meaning explicitly after evaluation.

## When to run a trial

Use a trial when the value or effect of a proposed behavior must be learned through real use, especially when changing automatic invocation, agent autonomy, interaction style, context loading, or coordination between capabilities.

A directly verifiable correction or an already accepted requirement does not need a trial. Implement it against its canonical directive or capability specification and provide direct evidence.

## Trial lifecycle

- **Proposed:** The hypothesis, scope, evaluation, and baseline are recorded; runtime behavior has not changed.
- **Ready:** The implementation revision is recorded, but the behavior has not yet been activated in its real environment.
- **Trialing:** Activation is recorded and the behavior is available for observation.
- **Adopted:** Evidence supports retaining the behavior, and its durable meaning has been promoted to a directive or capability specification.
- **Revised:** Evidence supports another bounded variation; record the new hypothesis and revision anchors without rewriting the prior result.
- **Rejected:** Evidence does not support retaining the behavior, and the implementation has been reverted or otherwise removed.
- **Inconclusive:** The review condition was reached without enough evidence for adoption or rejection.

A status changes how the artifact may be used, so every trial records one. A trial may return from `Inconclusive` to `Trialing` when its observation period continues without changing the hypothesis. When implementation and activation are the same operation, a trial may move directly from `Proposed` to `Trialing`.

## Define a trial

Before changing runtime behavior, record:

- The problem and hypothesis.
- The affected asset kinds and exact paths.
- Intended behavior, scope, and non-goals.
- Relevant interaction with other workflows or capabilities.
- Observable failure conditions.
- The observation period or minimum event count.
- Evaluation measures and adoption criteria.
- The baseline revision and anticipated rollback scope.

Commit the trial definition separately from its runtime implementation. This preserves the rationale and evaluation record when the implementation is reverted.

## Revision anchors

Record full Git commit hashes for:

- **Baseline revision:** A commit containing the last accepted version of every affected runtime path before implementation.
- **Trial definition revision:** The commit that establishes the proposed trial.
- **Implementation revision:** The atomic commit that activates the experimental behavior.
- **Outcome revision:** The commit that adopts, revises, or removes the behavior and records the result.

Record every runtime path changed by the implementation. Keep one trial's runtime changes in an atomic commit without unrelated edits. Because the implementation hash cannot be recorded until that commit exists, add it to the trial artifact in a subsequent documentation commit.

When activation requires deployment or another operation after implementation, record the activation date and evidence before starting the observation period. Review dates and usage counts begin at activation, not at the implementation commit.

Prefer reverting the atomic implementation commit while no later work depends on it:

```sh
git revert <implementation-revision>
```

When later work has become coupled to the trial, restore only the affected paths from the baseline and reconcile dependents explicitly:

```sh
git restore --source=<baseline-revision> -- <affected-paths>
```

Rollback preserves the trial artifact and its evidence. It does not erase the rejected experiment from history.

## Gather evidence

Evaluate events rather than relying only on elapsed time or general impressions. Record enough context to answer the trial's predetermined questions without storing an entire conversation when a concise observation is sufficient.

Useful measures include:

- Whether the intended trigger was recognized.
- Whether irrelevant contexts caused false activation.
- Whether the correct target or scope was selected.
- Whether unaffected workflow state was preserved.
- Whether the user could proceed after the behavior ran.
- Whether the capability was used when a genuine opportunity occurred.
- Whether the behavior introduced interruption, confusion, or excess output.

Time-based review dates are reminders, not sufficient evidence. Mark a trial `Inconclusive` when too few genuine opportunities occurred.

## Resolve a trial

At review:

1. Compare observations with the recorded adoption criteria.
2. Record the finding and any material limitations.
3. Adopt, revise, reject, or mark the trial inconclusive.
4. Promote adopted meaning into [`directives.md`](directives.md) or the capability specification that should own it.
5. Reconcile runtime assets and direct dependents.
6. Record the outcome revision after the resolving commit exists.

Do not leave accepted intent owned only by a completed trial. The trial preserves evidence for the decision; the directive or capability specification owns the resulting durable behavior.

## Imported assets

An upstream update does not override accepted directives or capability specifications. Before replacing or substantially updating an imported asset:

1. Identify the applicable directives, capability specifications, and active trials.
2. Separate the upstream import from reconciliation of accepted local intent.
3. Preserve or deliberately amend each accepted obligation in its canonical owner.
4. Treat uncertain upstream behavior as a new trial when real use is required to judge it.

Upstream provenance may be recorded when a concrete update workflow requires it; this specification does not require a source manifest.

## Sources

This specification refines the [AI-assisted development specification](spec.md), follows the ownership model in the [project-documentation capability specification](skills/project-documentation.md), and is constrained by [PR-009](../constitution.md#pr-009--nix-owns-configuration-behavior) and [PR-010](../constitution.md#pr-010--changes-require-direct-evidence) of the project constitution.
