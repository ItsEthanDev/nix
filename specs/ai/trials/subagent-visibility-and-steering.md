# Trial: Controlled subagent delegation

- **Status:** Trialing
- **Created:** 2026-09-12
- **Revised:** 2026-09-22
- **Review condition:** Complete the runtime setup gate, then observe at least three genuine events per agent, including the completed Terra/medium `worker` baseline, five `worker` events at GPT-6 Luna/xhigh, five parent-initiated delegations across at least three roles, and two steering attempts across the roster
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem and hypothesis

The environment needs subagents that remain visible and steerable while allowing a strong Sol parent to route bounded work to models selected for the task. Upstream built-in agents encode roles and prompts that Ethan has not chosen, so they would compete with deliberate custom routing and make evaluation ambiguous.

A five-agent roster should separate common delegation shapes without replacing the parent as decision-maker:

- GPT-6 Luna handles fast local reconnaissance and external research.
- GPT-6 Luna at xhigh implements approved, well-scoped work.
- GPT-6 Sol independently reviews consequential work.
- A parent-matching delegate handles bounded tasks that fit no specialist.

This separation should preserve the parent's context window, reduce use of the stronger parent model for work a faster or less expensive specialist can perform well, and reduce elapsed time through appropriate concurrency while preserving project rules, explicit decisions, direct verification, and parent-owned synthesis. The parent should initiate delegation without waiting for an explicit request when those benefits, specialization, or independent evidence are likely to justify handoff and reconciliation overhead. Applicable children should use the configured skill catalog through progressive disclosure without expanding their task, tools, or authority. The narrow `scout` role should avoid skill context that could broaden reconnaissance.

## Affected assets

- **Kind:** Pi extension, parent-model defaults, and global custom agents
- **Runtime paths:**
  - [`modules/home/development/pi.nix`](../../../modules/home/development/pi.nix)
  - [`static/ai/AGENTS.md`](../../../static/ai/AGENTS.md)
  - [`static/ai/agents/scout.md`](../../../static/ai/agents/scout.md)
  - [`static/ai/agents/researcher.md`](../../../static/ai/agents/researcher.md)
  - [`static/ai/agents/worker.md`](../../../static/ai/agents/worker.md)
  - [`static/ai/agents/reviewer.md`](../../../static/ai/agents/reviewer.md)
  - [`static/ai/agents/delegate.md`](../../../static/ai/agents/delegate.md)

The extension remains `npm:pi-subagents` with all bundled agents disabled. The five managed files define the complete advertised roster.

## Agent contracts

| Agent | Model and thinking | Context and prompt | Tools and extensions | Task boundary |
| --- | --- | --- | --- | --- |
| `scout` | GPT-6 Luna/low | Fresh, replacement prompt, project context, no inherited skills | Read-only tools plus inspection-only Bash | Locate and trace local code; return compressed evidence for another agent |
| `researcher` | GPT-6 Luna/medium | Fresh, replacement prompt, project context | Read and `pi-web-access` research tools | Gather and validate external evidence using its contained method; do not make the parent decision |
| `worker` | GPT-6 Luna/xhigh | Fresh, replacement prompt, project context | Read, shell, edit, write, and supervisor coordination | Act as the sole writer for a well-defined, independently verifiable code, test, or configuration change of moderate scope; exclude durable prose |
| `reviewer` | GPT-6 Sol/high | Fresh, replacement prompt, project context | Read-only tools plus inspection-only Bash | Load `development-review` and inspect an explicitly authorized target under that skill's contract |
| `delegate` | Parent model; thinking selected at launch | Fresh by default, appended Pi prompt, project and global context | Parent-like default tools and extensions | Handle bounded work only when no specialist has a better contract |

All agents except `scout` inherit the configured skills catalog. Skills may refine execution but do not expand the assigned task, tool access, write authority, or completion criteria. `reviewer` must load `development-review`; `researcher` retains a contained method until a canonical research skill exists.

GPT-6 Sol remains the default parent model and starts at medium thinking. Ethan or the parent may raise the parent to high for architecture, substantial planning, ambiguous product work, or synthesis of conflicting evidence. Max remains an explicit exceptional escalation.

## Routing rules

- Treat delegation as authorized by default, but not required by default; do not require an explicit delegation request when the expected benefit justifies the overhead.
- Before starting tool-heavy or context-heavy work, check whether an advertised specialist can reliably perform a bounded part while preserving parent context, reducing model cost or latency, enabling concurrency, or providing independent evidence.
- Give the child a self-contained objective, clear boundaries, acceptance criteria, and a compact expected result.
- Keep user intent, consequential decisions, decomposition, orchestration, synthesis, and final acceptance with the parent.
- Prefer the narrowest specialist whose contract fits the task.
- Use `delegate` only for bounded work that does not fit `scout`, `researcher`, `worker`, or `reviewer`.
- Route work to `reviewer` only when the user explicitly requested review or an authoritative artifact scheduled it, and include that authority in the assignment.
- Route implementation to `worker` as the smallest coherent, independently verifiable code, test, or configuration unit after the parent resolves scope and consequential decisions. Keep durable prose, trivial local edits, decomposition, ambiguous work, and final integration with the parent.
- Work directly in the parent when the task is conversational, trivial, a small known lookup or edit, tightly dependent on parent-held context, or cheaper to complete than to hand off and reconcile.
- Do not delegate merely because a specialist exists or because the task is long.
- Give fresh-context agents a cold-start-complete task containing the goal, target, authority, relevant context, success criteria, validation, output shape, and stop conditions.
- Keep one writer in a working tree. Parallelize read-only work unless filesystem isolation makes multiple writers safe.
- Use a fork only when accumulated conversation state is essential and impractical to summarize safely.

## Intended behavior

- Pi loads the `npm:pi-subagents` extension without its packaged prompts or skills and advertises exactly the five managed custom agents.
- The parent uses the active tool contract for routine delegation and loads only a targeted guide when an advanced operation requires more detail.
- No bundled agent remains enabled.
- Each specialist resolves to its configured model and thinking level.
- `delegate` resolves to the active parent model and does not displace a matching specialist.
- Agents preserve applicable project instructions; every agent except `scout` can discover configured skills progressively.
- Research runs load `pi-web-access` in the child and fail clearly rather than silently continuing without required tools.
- Read-only agents do not modify project files.
- `worker` does not make unresolved consequential decisions or author durable human- or agent-facing prose. It reports validation evidence and identifies direct documentation obligations created by its implementation without auditing documentation broadly.
- Running work remains inspectable, steerable, and stoppable.
- The parent recognizes and initiates useful delegation opportunities without requiring Ethan to name an agent or request delegation.

## Non-goals

This trial does not:

- require delegation when its expected benefit does not justify its overhead;
- enable nested delegation;
- evaluate missions, schedules, watchdog behavior, external runners, or autonomous multi-agent programs;
- create separate planner, oracle, security, documentation, or domain-specialist agents;
- claim that benchmark rankings predict local outcomes; or
- make GPT-6 Luna/xhigh the permanent worker model before comparison evidence exists.

## Failure conditions

Record an event as a failure when:

- the requested agent, model, thinking level, skills catalog, or required tools are unavailable;
- a bundled or unexpected custom agent appears;
- the parent routes work to `delegate` when a specialist clearly fits;
- the parent misses a clear delegation opportunity that would preserve substantial parent context, use a faster or less expensive capable specialist, reduce elapsed time through concurrency, or provide valuable independent evidence at acceptable handoff cost;
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
4. Confirm the parent starts with `openai-codex/gpt-6-sol` at medium thinking and the configured model set includes it.
5. Launch one minimal task per agent and confirm its tools, context, applicable skill behavior, output behavior, and read/write boundary.

Configuration evaluation proves generated settings and managed files but does not replace these runtime checks.

### Event evidence

Ethan reports at least five successful implementation events with the `worker` at Terra/medium. This completes the planned suitability baseline for implementation work. Event-level details were not recorded here, so the baseline does not establish comparative latency, usage, or correction rates.

Record genuine events in this table:

| Date | Agent | Task shape | Correct route | Adequate result | Parent correction | Parent-context effect | Skills loaded and relevant | Elapsed/usage note | Steering | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Complete at least three events per agent and at least five parent-initiated delegations across three or more roles. Record at least five `worker` events at GPT-6 Luna/xhigh and compare them with the reported Terra/medium baseline on representative tasks. Comparison runs should use similar task size, acceptance criteria, and verification; they do not need to repeat identical production changes. Do not claim comparative latency, usage, or correction improvements without event-level evidence.

Adopt an agent when every event preserves its authority boundary and project rules, at least 80% of its events produce an adequate result without rerunning the task on a stronger model, and remaining handoff and correction cost does not erase the expected parent-context, speed, or usage benefit. Adopt visibility and steering when every conversation is inspectable and both steering attempts are effective. Revise or remove a role that overlaps another role, attracts incorrect routing, or repeatedly requires parent repair.

## Revision history

### Initial variation — `@tintinweb/pi-subagents`

The initial variation replaced `pi-spawn` with `@tintinweb/pi-subagents`, retained its parent-inheriting `general-purpose` agent, and disabled its `Explore` and `Plan` agents through managed override files. It focused on conversation visibility and steering without custom agent behavior.

### Empty-catalog variation — `pi-subagents`

The first `pi-subagents` variation disabled every bundled agent and exposed no custom agent. It established the extension boundary before local roles were defined.

### Model-tier roster

The 2026-09-15 revision defines the five-agent roster, parent thinking default, routing rules, failure conditions, and event-level evaluation. Same-day refinements removed post-launch routing text from `delegate`, excluded skills from `scout`, made `reviewer` defer to `development-review`, tightened the parent-owned scope contract for `worker`, and reserved durable prose for the parent while requiring the worker to report direct documentation obligations. The 2026-09-16 revision authorizes the parent to initiate delegation and makes preservation of parent context, model economy, and elapsed time the primary benefits weighed against handoff and reconciliation overhead. It also adds parent-initiated events and parent-context effects to the evaluation. The 2026-09-17 revision continues excluding the package's prompts and now excludes its skills while retaining the extension and complete advertised roster. In one observed parent run, loading the `pi-subagents` skill and its four required references increased context from 31,703 to 57,307 tokens before child launch; routine delegation now relies on the active tool contract, with targeted guides reserved for advanced operations. Evidence from an earlier variation remains attributable only to that variation.

### Current variation — GPT-6 roster

The 2026-09-22 revision moves `scout` and `researcher` to GPT-6 Luna, `reviewer` and the parent default to GPT-6 Sol, and `worker` from the successful Terra/medium baseline to GPT-6 Luna/xhigh. The role boundaries remain unchanged. The worker comparison now evaluates whether the GPT-6 variation preserves implementation success while improving the parent-context, latency, usage, or correction-cost outcomes already owned by this trial.

## Revision anchors

- **Baseline revision:** `db8350f5e2b4d6f3887f5a2135ac367d8ad2f575`
- **Empty-catalog trial definition:** `493d03892b88437bba0b2263bd6d92ea9697784c`
- **Empty-catalog implementation:** `5406001f862797622cec90224d279d59b6dbd67d`
- **Empty-catalog anchor record:** `2e96bd22dfde3f08da1161d8769797ce0ff053b9`
- **Roster trial definitions:** `e146ae498ba28a23846c190e19e7d62751de7812`, `84406984cc35e170041a9dfcb1af29009c37ae2b`, `68468c1f4a528e1ead11fad77a75af24cecc425d`
- **Roster implementation revisions:** `34b5997a719efa375d81a1915a53dddf16046b06`, `7f6a3e26606fd96143886a97b0cd78d7435426fb`, `6f859f1248fef6bb8af197f72711e1ddb27d62e8`
- **Outcome revision:** Not started

## Rollback

Remove the five managed agent files and their Home Manager declarations, then remove `defaultThinkingLevel` if the parent default must also return to its prior behavior. Keep `npm:pi-subagents` with `subagents.disableBuiltins = true` to return to the empty-catalog variation. Preserve this trial and record the outcome.

## Outcome

Roster observation begins after the revised Home Manager configuration is deployed and the runtime setup gate passes.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md) and is constrained by the [AI-assisted development specification](../spec.md), the [project constitution](../../constitution.md), and applicable [AI development directives](../directives.md). Package behavior is derived from the installed extension configuration and the [`pi-subagents` package documentation](https://pi.dev/packages/pi-subagents); the trial owns the local hypothesis, role contracts, and evaluation criteria.
