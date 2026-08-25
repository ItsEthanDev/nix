# Constitute

Establish or amend the durable rules that govern later specifications, plans, and implementations. This is a project-level phase, not a feature ceremony.

Before changing durable governance, load the `project-documentation` project-governance guidance and follow its classification, canonical-location, format, identifier, and readiness rules.

## Process

1. **Discover authority.** Read applicable instructions, project overviews, documentation indexes, governance, domain context, ADRs, build configuration, and quality tooling. Identify the existing owners of project intent, terminology, architecture, testing, and agent behavior.
2. **Classify candidates.** Apply the project-governance boundary from `project-documentation`. Distinguish existing policy, verified current behavior, proposed durable rule, feature behavior, technical decision, execution detail, and unresolved choice. Do not promote current implementation to policy without an explicit decision.
3. **Elicit consequential choices.** Surface conflicts and ask only about choices that constrain future work, such as supported platforms, architectural limits, security obligations, testing expectations, and quality gates. Infer reversible details from established conventions.
4. **Stress-test proposed rules.** For each candidate, state the behavior it requires, the compliance signal later work must provide, and one realistic case where it could become costly or ambiguous. Remove slogans that do not change a decision.
5. **Record accepted rules.** Update the canonical governance owners using `project-documentation`. Keep agent-only instructions in their own owner and reference existing rules rather than creating a parallel constitution.
6. **Report the result.** Summarize each accepted or amended rule, canonical owner, compliance signal, and unresolved conflict.

## Completion criteria

Constitute is complete when:

- Every accepted rule has been deliberately classified as durable project governance.
- Every accepted rule is actionable, has one canonical owner, and names a compliance signal.
- Feature behavior, transient implementation details, and accidental current behavior remain in their proper owners.
- Conflicting guidance is reconciled or explicitly unresolved.
- Later phases can find applicable rules without conversation history.
