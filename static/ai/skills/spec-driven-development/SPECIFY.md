# Specify

Define what should change and why without prescribing implementation. Use the project's existing format; otherwise start from [templates/spec.md](templates/spec.md).

## Process

1. **Establish context.** Read the applicable constituted rules, project documentation, domain context, related behavior, and earlier specifications. Use established project terminology. Record applicable project constraints by stable ID when their canonical owner provides one; otherwise reference the canonical path and heading.
2. **Bound the problem.** Record the problem, desired outcome, affected actors, in-scope behavior, and explicit non-goals.
3. **Describe independent user stories.** Assign priorities such as `P1`, `P2`, and `P3`. For each story, state its value, independent test, and observable Given/When/Then acceptance scenarios.
4. **Write testable requirements.** Assign stable `FR-###` IDs to functional requirements. Describe externally meaningful behavior, constraints, edge cases, and failure behavior. Reference rather than duplicate a project invariant; add a feature requirement only when it refines that invariant into observable behavior for this feature. Keep technical design out of the specification.
5. **Define success criteria.** Assign stable `SC-###` IDs to measurable, technology-independent outcomes. Do not invent metrics that do not represent a real product or operational requirement.
6. **Record assumptions and questions.** Make reasonable, reversible defaults explicit. Ask focused questions only when different answers materially change scope, security, data handling, or user-visible behavior.
7. **Check specification quality.** Verify that every functional requirement is unambiguous, observable, consistent with constituted rules, and covered by at least one acceptance scenario. Verify that each success criterion can be evaluated without prescribing the implementation. Remove duplicated constitutional language and route technical mechanisms to the plan.
8. **Resolve the gate.** Present unresolved decisions and a concise specification summary. Obtain approval before planning unless the user explicitly requested autonomous progression and no consequential uncertainty remains.

## Completion criteria

Specify is complete when:

- Scope and non-goals are explicit.
- Every accepted behavior has a stable `FR-###` ID and observable acceptance condition, and every meaningful outcome has an `SC-###` ID.
- Assumptions are visible and consequential questions are resolved or block progression.
- Applicable project constraints are referenced, and feature-specific refinements are distinguishable from project invariants.
- The specification contains what and why, while technical choices remain for planning.
- The accepted specification is stored in a project artifact rather than only in conversation.
