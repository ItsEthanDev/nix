# Trial: Controlled subagent delegation

- **Status:** Trialing
- **Created:** 2026-09-12
- **Revised:** 2026-09-15
- **Review condition:** Complete the setup gate, then evaluate five genuine delegation events after a later revision introduces custom agents
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem and hypothesis

The environment needs subagents that remain visible and steerable while allowing the Sol parent to route bounded work to models selected for the task. Upstream built-in agents encode roles and prompts that Ethan has not chosen, so they would compete with deliberate custom routing and make evaluation ambiguous.

Replacing `pi-spawn` with `pi-subagents` and disabling every built-in agent should establish a blank, observable delegation platform. A later trial revision can define custom agents, model assignments, and routing criteria before those agents are activated. This staged approach should preserve explicit control over agent behavior while creating a path to faster or more economical delegation and exceptional escalation to a stronger model.

## Affected assets

- **Kind:** Pi extension and subagent configuration
- **Current runtime path:** [`modules/home/development/pi.nix`](../../../modules/home/development/pi.nix)
- **Future runtime paths:** Not yet defined

This revision installs `npm:pi-subagents`, sets `subagents.disableBuiltins` to `true`, and removes the package-specific override files used by the preceding variation. It does not configure a custom agent.

## Staged activation

### Stage 1 — Empty agent catalog

The current implementation establishes and verifies the extension boundary:

- `pi-subagents` is the only configured subagent extension.
- Every agent bundled with the extension is disabled.
- No repository-managed custom agent is present.
- Sol remains the default parent model, and the existing enabled model set remains unchanged.

### Stage 2 — Model-tier routing

Before adding custom agents, revise this trial again to record:

- each agent's task boundary;
- its model and thinking-level policy;
- its prompt, project-context, skill, extension, and tool inheritance;
- routing guidance exposed to the parent;
- failure conditions and event-level evaluation measures; and
- every new runtime path and its rollback scope.

Stage 2 implementation must not precede that revision.

## Intended behavior

During Stage 1:

- Pi loads the `pi-subagents` extension successfully.
- The extension exposes no built-in or custom agent for delegation.
- The extension does not change the parent's configured model or enabled model set.
- No obsolete `@tintinweb/pi-subagents` agent override remains in managed state.

After Stage 2 is specified and implemented:

- Sol remains responsible for task framing, consequential decisions, and synthesis.
- Custom agents represent deliberate task boundaries rather than aliases that merely rename models.
- Lower-cost or faster models handle bounded work only when their agent contract makes that work suitable.
- A stronger model is available only through an agent contract that justifies escalation.
- Running work remains inspectable and steerable.

## Non-goals

Stage 1 does not:

- create or advertise any custom agent;
- assign Luna, Terra, Sol, or Astra to a child role;
- authorize automatic delegation;
- evaluate workflows, missions, schedules, watchdog behavior, external runners, worktree isolation, or nested delegation; or
- adopt the extension's bundled agent roles or recommended workflow as local intent.

## Failure conditions

The current stage fails when:

- Pi cannot load `npm:pi-subagents`;
- any bundled agent remains available;
- any custom agent is discovered from the managed configuration;
- the package changes the parent model or enabled model set;
- the previous subagent package or its override files remain configured; or
- extension behavior conflicts with repository instructions, configured skills, or active tool restrictions.

After Stage 2 begins, its revision must add failures for incorrect routing, inadequate results, excess correction work, visibility, steering, latency, and model usage before delegation evidence is gathered.

## Evaluation

### Stage 1 setup gate

After deployment:

1. Run `/subagents-doctor` and confirm the extension reports a healthy installation.
2. Inspect the extension's agent list and confirm that it contains no enabled built-in or custom agent.
3. Inspect the effective model mapping and confirm that no child role is configured.
4. Confirm the parent still uses `openai-codex/gpt-5.6-sol` and the configured enabled model set is unchanged.

Stage 1 passes only when all four checks pass. Configuration evaluation before deployment proves the generated settings but does not replace these runtime checks.

### Stage 2 delegation events

The five-event observation period begins only after the Stage 2 revision and implementation are complete. At least two events must include a steering attempt. The Stage 2 revision will define the event table and adoption thresholds; observations from the preceding package variation do not count toward those thresholds.

## Revision history

### Initial variation — `@tintinweb/pi-subagents`

The initial variation replaced `pi-spawn` with `@tintinweb/pi-subagents`, retained its parent-inheriting `general-purpose` agent, and disabled its `Explore` and `Plan` agents through managed override files. It focused on conversation visibility and steering without custom agent behavior.

### Current variation — `pi-subagents`

The 2026-09-15 revision replaces that package with `pi-subagents` and begins from an empty agent catalog. It broadens the hypothesis from visibility alone to deliberate model-tier delegation, while deferring every custom role until its contract and evaluation criteria are recorded.

Evidence from one variation must remain attributed to that variation. Do not combine their events when resolving the trial.

## Revision anchors

- **Baseline revision:** `db8350f5e2b4d6f3887f5a2135ac367d8ad2f575`
- **Trial definition revision:** Pending commit
- **Implementation revisions:** Pending commit
- **Outcome revision:** Not started

The baseline contains the `pi-spawn` configuration before either trial variation. The initial variation was not assigned completed revision anchors before this revision. Record the revised trial definition and its implementation separately before treating the current anchors as complete.

## Rollback

Restore `npm:pi-spawn` in `modules/home/development/pi.nix`, remove `subagents.disableBuiltins`, and remove any custom agent assets added by a later revision. Preserve this trial and record the outcome.

## Outcome

Stage 1 observation begins after the revised Home Manager configuration is deployed. Stage 2 has not been specified or implemented.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md) and is constrained by the [AI-assisted development specification](../spec.md), the [project constitution](../../constitution.md), and applicable [AI development directives](../directives.md). Package behavior is derived from the installed extension configuration and the [`pi-subagents` package documentation](https://pi.dev/packages/pi-subagents); the trial owns only the local hypothesis and evaluation criteria.
