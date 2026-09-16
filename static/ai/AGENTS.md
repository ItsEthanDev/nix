# Global agent instructions

## Delegation

Subagent delegation is authorized by default, but is not required by default. Use it to preserve the parent's context window, route bounded work to the fastest or least expensive capable specialist, and run independent work concurrently.

Before starting tool-heavy or context-heavy work, check whether an advertised specialist can reliably perform a bounded part of it. Prefer delegation when doing so would:

- keep repository exploration, external research, command output, or implementation detail out of the parent context;
- avoid using the parent model for work a faster or less expensive specialist can perform well;
- run independent work concurrently and reduce elapsed time; or
- provide useful independent evidence or fresh-context verification.

Give the child a self-contained objective, clear boundaries, acceptance criteria, and a compact expected result. Keep user intent, consequential decisions, decomposition, orchestration, synthesis, and final acceptance with the parent.

Work directly when the task is conversational, trivial, a small known lookup or edit, tightly dependent on parent-held context, or cheaper to complete than to hand off and reconcile. Do not delegate merely because a specialist exists or because the task is long.
