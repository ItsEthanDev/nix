# Specify

Elicit and accept what should change and why without choosing how to implement it.

Before creating or changing the specification, load the `project-documentation` feature-specification guidance and follow its location, format, normative language, identifier, status, and readiness rules.

## Process

1. **Establish context.** Read applicable project governance, project documentation, domain context, related behavior, earlier specifications, and relevant current behavior. Use established project terminology.
2. **Bound the problem.** Identify the problem, desired outcome, affected actors, in-scope behavior, and explicit non-goals.
3. **Elicit independent value.** Describe independently valuable user stories with the `US-###` identifiers defined by `project-documentation` and observable acceptance scenarios. Prioritize them according to user value rather than implementation convenience.
4. **Specify behavior.** Record externally meaningful obligations, constraints, edge cases, and failure behavior using the specification conventions from `project-documentation`. Reference rather than duplicate durable project rules.
5. **Define meaningful outcomes.** Record measurable, technology-independent success criteria only when they represent genuine product or operational requirements.
6. **Resolve uncertainty.** Make responsible reversible assumptions explicit. Ask focused questions when different answers materially change scope, security, privacy, data handling, or user-visible behavior.
7. **Review quality.** Check every accepted behavior for unambiguous observable acceptance, consistency with project rules, and freedom from technical design. Route technical choices to planning.
8. **Resolve the transition.** Present unresolved decisions and a concise summary. When the specification satisfies its readiness criteria, record the lifecycle transition required for planning. Pause before planning only when a consequential product decision remains unresolved or the user requested an approval gate; otherwise finish the requested phase or continue the requested workflow.

## Completion criteria

Specify is complete when:

- Scope, non-goals, assumptions, and externally meaningful behavior are explicit.
- Every accepted obligation has observable acceptance and every meaningful outcome can be evaluated without prescribing implementation.
- Consequential product questions are resolved or explicitly block planning.
- Applicable project rules are referenced without duplication.
- Technical choices remain open for planning.
- The specification satisfies the readiness criteria from `project-documentation` and is stored outside conversation history.
