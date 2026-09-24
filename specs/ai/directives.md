# AI Development Directives

This living specification records Ethan's accepted, durable instructions for configured AI capabilities. A directive describes required intent independently of the skill, system instruction, tool, extension, MCP server, or other asset that currently realizes it.

Git records when a directive changed. This specification owns its current accepted meaning. An explicitly requested experiment remains in a [trial](evolution.md) until it is adopted. Accepted requirements may be implemented directly without a trial.

## Commit completed work by default

**Intent:** Agents commit completed, verified changes without requiring a separate commit request.

Required behavior:

- After completing and verifying a requested change, commit only the files belonging to that change unless Ethan asks not to commit.
- Do not commit incomplete work or changes whose scope is ambiguous. Report why a commit was not made.
- Use the commit skill for staging and commit-message procedure.
- This default does not authorize pushing or expand a delegated agent's authority to commit.

Current realization:

- [`static/ai/AGENTS.md`](../../static/ai/AGENTS.md)
- [`static/ai/skills/techniques/commit/SKILL.md`](../../static/ai/skills/techniques/commit/SKILL.md)

**Origin:** Ethan request to make completed work commit by default, without a trial.

## Explicit push consent

**Intent:** Agents push changes only when Ethan explicitly requests it.

Required behavior:

- A request to commit does not imply permission to push.
- An agent or workflow that can push must state and preserve this boundary.
- Broader delivery language does not silently grant push permission.

Current realization:

- [`static/ai/skills/techniques/commit/SKILL.md`](../../static/ai/skills/techniques/commit/SKILL.md)

**Origin:** Ethan request, implemented in Git commit `0ab680ec82878fb1ec40029a0232916bdfb7bdbb`.

## Consequential decisions require direction

**Intent:** Routine execution should remain unblocked without allowing agents to consume unresolved product or architecture decisions.

Required behavior:

- Agents proceed independently when established context makes the intended outcome clear.
- Reversibility alone does not make a decision routine.
- Agents request direction when multiple responsible choices would materially affect product intent, architecture, security, privacy, or maintainability.
- Irreversible external actions require confirmation.

Current realization:

- [AI-assisted development specification](spec.md#explicit-decisions)
- [`principle-never-block-on-the-human`](../../static/ai/skills/engineering-principles/principles/principle-never-block-on-the-human/SKILL.md)

**Origin:** Ethan request, implemented in Git commit `0ab680ec82878fb1ec40029a0232916bdfb7bdbb`.

## Scope-sensitive `wait what` clarification

**Intent:** Ethan can request a simpler replacement explanation without explicit skill invocation or loss of surrounding workflow state.

Required behavior:

- A standalone `wait what` re-pitches the complete preceding assistant response.
- A numbered, quoted, or named reference re-pitches that complete target while preserving unaffected answers and decisions.
- The replacement explanation preserves the target's meaning, uses a simpler conceptual order, and does not append detail or defend the previous explanation.
- The target remains unresolved, and dependent work does not advance until Ethan responds.
- Discussion of the phrase or capability does not activate clarification behavior.

Current realization:

- [`static/ai/skills/wait-what/SKILL.md`](../../static/ai/skills/wait-what/SKILL.md)

**Origin:** [Inline `wait what` trigger trial](trials/wait-what-inline-trigger.md), adopted 2026-09-15.

## Bounded nested delegation through `delegate`

**Intent:** A global coordinator can hand a bounded project task to `delegate`, which may then use one further layer of specialist subagents without requesting separate permission.

Required behavior:

- Only `delegate` may initiate nested delegation; other child roles do not gain the `subagent` tool.
- The maximum chain is parent → delegate → specialist. The specialist cannot spawn another child, and `delegate` does not spawn another `delegate`.
- A delegate may decide whether a specialist is worth the handoff under its assigned task and applicable project instructions. No separate parent approval or explicit fanout instruction is required.
- The delegate remains responsible for the bounded project task, child evidence, and synthesis. The root parent retains consequential decisions and final acceptance. Nested delegation does not expand task scope, mutation authority, or permission to commit, push, publish, or deploy.

Current realization:

- [`static/ai/agents/delegate.md`](../../static/ai/agents/delegate.md)
- [`modules/home/development/pi.nix`](../../modules/home/development/pi.nix)

**Origin:** Ethan request, 2026-09-22.

## Maintaining directives

Record the accepted outcome of a successful trial here when the behavior is durable but does not warrant a dedicated capability specification. When a directive develops substantial scope, interactions, or independent requirements, move its meaning to a focused specification and leave a concise pointer here.

Changing runtime assets does not amend a directive. Amend this specification first when accepted intent changes, then reconcile its realizations and direct dependents.

## Sources

These directives refine the [AI-assisted development specification](spec.md) and follow the lifecycle defined by the [AI asset evolution specification](evolution.md). They are constrained by [PR-009](../constitution.md#pr-009--nix-owns-configuration-behavior) of the project constitution.
