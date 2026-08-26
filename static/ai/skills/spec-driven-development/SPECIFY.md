# Specify

Elicit and accept what should change and why without choosing how to implement it.

Before creating or changing the specification, load the `project-documentation` feature-specification guidance and follow its location, format, normative language, identifier, status, and readiness rules.

## Process

1. **Establish context.** Read applicable project governance, project documentation, domain context, related behavior, earlier specifications, and relevant current behavior. Use established project terminology.
2. **Ensure domain ownership.** Load the `project-documentation` domain-context guidance. Use the applicable existing `CONTEXT.md` or context map. When none exists, create the canonical `CONTEXT.md` alongside specification work unless the feature introduces no project-specific domain concepts. Record resolved terminology there rather than in the specification, and follow `project-documentation` for its location rather than assuming the feature directory owns it.
3. **Bound the problem.** Identify the problem, desired outcome, affected actors, in-scope behavior, and explicit non-goals.
4. **Elicit independent value.** Describe independently valuable user stories with the `US-###` identifiers defined by `project-documentation` and observable acceptance scenarios. Prioritize them according to user value rather than implementation convenience.
5. **Specify behavior.** Record externally meaningful obligations, constraints, edge cases, and failure behavior using the specification conventions from `project-documentation`. Reference rather than duplicate durable project rules.
6. **Define meaningful outcomes.** Record measurable, technology-independent success criteria only when they represent genuine product or operational requirements.
7. **Resolve uncertainty.** Make responsible reversible assumptions explicit. Ask focused questions when different answers materially change scope, security, privacy, data handling, or user-visible behavior.
8. **Review quality.** Check every accepted behavior for unambiguous observable acceptance, consistency with project rules, and freedom from technical design. Route technical choices to planning.
9. **Resolve the transition.** Present unresolved decisions and a concise summary. When the specification satisfies its readiness criteria, keep it `Draft`, report the phase handoff, and request approval before planning. Treat an explicit direction to proceed to planning as approval. For an explicitly autonomous request, transition the ready specification to `Accepted` without pausing. Otherwise transition it only after approval. A material behavioral revision to an accepted specification returns it to `Draft` and requires renewed approval; editorial changes that preserve semantics do not invalidate acceptance.

## Completion criteria

Specify is ready for approval when:

- Scope, non-goals, assumptions, and externally meaningful behavior are explicit.
- Every proposed obligation has observable acceptance and every meaningful outcome can be evaluated without prescribing implementation.
- Consequential product questions are resolved or explicitly block planning.
- Applicable project rules are referenced without duplication.
- Technical choices remain open for planning.
- The specification role is stored in its canonical owner outside conversation history; a fallback `spec.md` is created only when needed.
- Applicable project-specific terminology is stored in its canonical domain context.

The phase may hand off a ready `Draft` while awaiting approval. Specify is complete, and planning may begin, only when the specification is `Accepted` through user approval or an explicitly autonomous request.
