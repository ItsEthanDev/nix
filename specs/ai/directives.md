# AI Development Directives

This living specification records Ethan's accepted, durable instructions for configured AI capabilities. A directive describes required intent independently of the skill, system instruction, tool, extension, MCP server, or other asset that currently realizes it.

Git records when a directive changed. This specification owns its current accepted meaning. Proposed behavior remains in a [trial](evolution.md) until it is adopted.

## Explicit push consent

**Intent:** Agents push changes only when Ethan explicitly requests it.

Required behavior:

- A request to commit does not imply permission to push.
- An agent or workflow that can push must state and preserve this boundary.
- Broader delivery language does not silently grant push permission.

Current realization:

- [`static/ai/skills/commit/SKILL.md`](../../static/ai/skills/commit/SKILL.md)

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

## Maintaining directives

Record the accepted outcome of a successful trial here when the behavior is durable but does not warrant a dedicated capability specification. When a directive develops substantial scope, interactions, or independent requirements, move its meaning to a focused specification and leave a concise pointer here.

Changing runtime assets does not amend a directive. Amend this specification first when accepted intent changes, then reconcile its realizations and direct dependents.

## Sources

These directives refine the [AI-assisted development specification](spec.md) and follow the lifecycle defined by the [AI asset evolution specification](evolution.md). They are constrained by [PR-009](../constitution.md#pr-009--nix-owns-configuration-behavior) of the project constitution.
