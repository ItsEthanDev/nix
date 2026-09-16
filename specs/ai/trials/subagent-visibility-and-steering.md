# Trial: Controlled subagent delegation

- **Status:** Trialing
- **Created:** 2026-09-12
- **Revised:** 2026-09-15
- **Review condition:** Complete the runtime setup gate, then observe at least three genuine events per agent, including five `worker` events at Terra/medium and two steering attempts across the roster
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem and hypothesis

The environment needs subagents that remain visible and steerable while allowing a strong Sol parent to route bounded work to models selected for the task. Upstream built-in agents encode roles and prompts that Ethan has not chosen, so they would compete with deliberate custom routing and make evaluation ambiguous.

A five-agent roster should separate common delegation shapes without replacing the parent as decision-maker:

- Luna handles fast local reconnaissance and external research.
- Terra implements approved, well-scoped work.
- Sol independently reviews consequential work.
- A parent-matching delegate handles bounded tasks that fit no specialist.

This separation should improve speed and model usage while preserving project rules, explicit decisions, direct verification, and parent-owned synthesis. Making the configured skill catalog available to every child should preserve progressive disclosure without expanding a child's task, tools, or authority.

## Affected assets

- **Kind:** Pi extension, parent-model defaults, and global custom agents
- **Runtime paths:**
  - [`modules/home/development/pi.nix`](../../../modules/home/development/pi.nix)
  - [`static/ai/agents/scout.md`](../../../static/ai/agents/scout.md)
  - [`static/ai/agents/researcher.md`](../../../static/ai/agents/researcher.md)
  - [`static/ai/agents/worker.md`](../../../static/ai/agents/worker.md)
  - [`static/ai/agents/reviewer.md`](../../../static/ai/agents/reviewer.md)
  - [`static/ai/agents/delegate.md`](../../../static/ai/agents/delegate.md)

The extension remains `npm:pi-subagents` with all bundled agents disabled. The five managed files define the complete advertised roster.

## Agent contracts

| Agent | Model and thinking | Context and prompt | Tools and extensions | Task boundary |
| --- | --- | --- | --- | --- |
| `scout` | Luna/low | Fresh, replacement prompt, project context | Read-only tools plus inspection-only Bash | Locate and trace local code; return compressed evidence for another agent |
| `researcher` | Luna/medium | Fresh, replacement prompt, project context | Read and `pi-web-access` research tools | Gather and validate external evidence; do not make the parent decision |
| `worker` | Terra/medium | Fresh, replacement prompt, project context | Read, shell, edit, write, and supervisor coordination | Act as the sole writer for an approved, bounded implementation |
| `reviewer` | Sol/high | Fresh, replacement prompt, project context | Read-only tools plus inspection-only Bash | Independently inspect an explicit target and report evidence-backed findings |
| `delegate` | Parent model; thinking selected at launch | Fresh by default, appended Pi prompt, project and global context | Parent-like default tools and extensions | Handle bounded work only when no specialist has a better contract |

Every agent inherits the configured skills catalog. Skills may refine execution but do not expand the assigned task, tool access, write authority, or completion criteria.

Sol remains the default parent model and starts at medium thinking. Ethan or the parent may raise the parent to high for architecture, substantial planning, ambiguous product work, or synthesis of conflicting evidence. Max remains an explicit exceptional escalation.

## Routing rules

- Keep task framing, consequential decisions, orchestration, and synthesis with the parent.
- Prefer the narrowest specialist whose contract fits the task.
- Use `delegate` only for bounded work that does not fit `scout`, `researcher`, `worker`, or `reviewer`.
- Work directly in the parent when delegation overhead exceeds the evidence, specialization, parallelism, or context-isolation benefit.
- Give fresh-context agents a cold-start-complete task containing the goal, target, authority, relevant context, success criteria, validation, output shape, and stop conditions.
- Keep one writer in a working tree. Parallelize read-only work unless filesystem isolation makes multiple writers safe.
- Use a fork only when accumulated conversation state is essential and impractical to summarize safely.

## Intended behavior

- Pi loads `npm:pi-subagents` and advertises exactly the five managed custom agents.
- No bundled agent remains enabled.
- Each specialist resolves to its configured model and thinking level.
- `delegate` resolves to the active parent model and does not displace a matching specialist.
- Agents preserve applicable project instructions and can discover every configured skill progressively.
- Research runs load `pi-web-access` in the child and fail clearly rather than silently continuing without required tools.
- Read-only agents do not modify project files.
- `worker` does not make unresolved consequential decisions and reports validation evidence.
- Running work remains inspectable, steerable, and stoppable.

## Non-goals

This trial does not:

- authorize delegation without user or project authority;
- enable nested delegation;
- evaluate missions, schedules, watchdog behavior, external runners, or autonomous multi-agent programs;
- create separate planner, oracle, security, documentation, or domain-specialist agents;
- claim that benchmark rankings predict local outcomes; or
- make Terra the permanent worker model before comparison evidence exists.

## Failure conditions

Record an event as a failure when:

- the requested agent, model, thinking level, skills catalog, or required tools are unavailable;
- a bundled or unexpected custom agent appears;
- the parent routes work to `delegate` when a specialist clearly fits;
- delegation costs more time or parent correction than doing the bounded task directly would reasonably require;
- an agent broadens scope, violates its read/write boundary, or consumes an unresolved consequential decision;
- a loaded skill causes irrelevant process, scope drift, or conflicting behavior;
- a result lacks the evidence or validation required by its contract;
- conversation inspection omits material activity;
- steering does not affect a running child after its current tool operation; or
- extension behavior conflicts with repository instructions, configured skills, or active tool restrictions.

## Evaluation

### Runtime setup gate

After deployment:

1. Run `/subagents-doctor` and confirm the extension reports a healthy installation.
2. Inspect the agent list and confirm that exactly `scout`, `researcher`, `worker`, `reviewer`, and `delegate` are advertised.
3. Run `/subagents-models` and confirm each specialist's effective model and thinking level.
4. Confirm the parent starts with `openai-codex/gpt-5.6-sol` at medium thinking and retains the configured model set.
5. Launch one minimal task per agent and confirm its tools, context, skill catalog, output behavior, and read/write boundary.

Configuration evaluation proves generated settings and managed files but does not replace these runtime checks.

### Event evidence

Record genuine events in this table:

| Date | Agent | Task shape | Correct route | Adequate result | Parent correction | Skills loaded and relevant | Elapsed/usage note | Steering | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Complete at least three events per agent. Record at least five `worker` events at Terra/medium before comparing explicit Terra/high and Luna/max runs on representative tasks. Comparison runs should use similar task size, acceptance criteria, and verification; they do not need to repeat identical production changes.

Adopt an agent when every event preserves its authority boundary and project rules, at least 80% of its events produce an adequate result without rerunning the task on a stronger model, and remaining correction cost does not erase the expected speed or usage benefit. Adopt visibility and steering when every conversation is inspectable and both steering attempts are effective. Revise or remove a role that overlaps another role, attracts incorrect routing, or repeatedly requires parent repair.

## Revision history

### Initial variation — `@tintinweb/pi-subagents`

The initial variation replaced `pi-spawn` with `@tintinweb/pi-subagents`, retained its parent-inheriting `general-purpose` agent, and disabled its `Explore` and `Plan` agents through managed override files. It focused on conversation visibility and steering without custom agent behavior.

### Empty-catalog variation — `pi-subagents`

The first `pi-subagents` variation disabled every bundled agent and exposed no custom agent. It established the extension boundary before local roles were defined.

### Current variation — model-tier roster

The 2026-09-15 revision defines the five-agent roster, parent thinking default, routing rules, failure conditions, and event-level evaluation. Evidence from an earlier variation remains attributable only to that variation.

## Revision anchors

- **Baseline revision:** `db8350f5e2b4d6f3887f5a2135ac367d8ad2f575`
- **Empty-catalog trial definition:** `493d03892b88437bba0b2263bd6d92ea9697784c`
- **Empty-catalog implementation:** `5406001f862797622cec90224d279d59b6dbd67d`
- **Empty-catalog anchor record:** `2e96bd22dfde3f08da1161d8769797ce0ff053b9`
- **Roster trial definition:** Pending commit
- **Roster implementation revisions:** Pending commit
- **Outcome revision:** Not started

## Rollback

Remove the five managed agent files and their Home Manager declarations, then remove `defaultThinkingLevel` if the parent default must also return to its prior behavior. Keep `npm:pi-subagents` with `subagents.disableBuiltins = true` to return to the empty-catalog variation. Preserve this trial and record the outcome.

## Outcome

Roster observation begins after the revised Home Manager configuration is deployed and the runtime setup gate passes.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md) and is constrained by the [AI-assisted development specification](../spec.md), the [project constitution](../../constitution.md), and applicable [AI development directives](../directives.md). Package behavior is derived from the installed extension configuration and the [`pi-subagents` package documentation](https://pi.dev/packages/pi-subagents); the trial owns the local hypothesis, role contracts, and evaluation criteria.
