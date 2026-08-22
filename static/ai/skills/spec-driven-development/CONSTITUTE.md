# Constitute

Establish the durable rules that govern later specifications, plans, and implementations. This is a project-level phase; do not repeat it for every feature.

## Process

1. **Discover existing authority.** Read applicable agent instructions, the root README, documentation indexes, domain context, ADRs, build configuration, and quality-tool configuration. List the existing owners of project intent, terminology, architecture, testing, and agent behavior.
2. **Separate facts from proposed rules.** Classify each candidate principle as existing policy, verified current behavior, a proposed constraint, or an unresolved choice. Current implementation does not become policy merely because it exists.
3. **Elicit only consequential choices.** Surface conflicts and ask about decisions that constrain many future changes, such as supported platforms, architectural limits, security obligations, testing expectations, and quality gates. Prefer observed project conventions for reversible details.
4. **Stress-test each principle.** State the behavior it requires, how later work can check compliance, and one realistic case where the principle could become costly or ambiguous. Remove slogans that do not change a decision.
5. **Update canonical owners.** Put each accepted rule in the existing artifact that owns its meaning. Create one minimal governance artifact only when no suitable owner exists. Keep agent-only instructions separate from human-facing project facts.
6. **Report the constitution map.** Summarize each principle, its canonical file, its verification signal, and any unresolved conflict.

## Completion criteria

Constitute is complete when:

- Every accepted principle is actionable and has one canonical owner.
- Existing conflicting guidance is reconciled or explicitly unresolved.
- Later phases can locate the project rules without relying on conversation history.
- No duplicate rules artifact was created unnecessarily.
