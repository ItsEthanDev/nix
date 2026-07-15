# Requirements Guidance

## Goal

Record confirmed, externally meaningful obligations so humans and agents can
decide what to build and how to verify it without prescribing unnecessary
implementation details.

## When To Update

Update requirements whenever the user confirms or changes expected behavior,
quality attributes, constraints, domain rules, scope, or acceptance intent. Do
not wait for the user to request documentation separately.

Implementation behavior alone does not establish a requirement. If it conflicts
with documented or newly stated intent, follow the drift workflow in
[`SKILL.md`](SKILL.md).

## Requirement Types

- **Functional:** Observable behavior or capability the system must provide.
- **Non-functional:** A measurable quality, performance target, operational
  property, or technical constraint.
- **Domain:** A rule, standard, or obligation imposed by the problem domain. Keep
  domain term definitions in the applicable `CONTEXT.md` and use those canonical
  terms here.

A design choice belongs in requirements only when the user confirms it as a
mandatory constraint. Otherwise, record it in design documentation.

## Writing Rules

- Write each requirement as one obligation.
- Use precise actors, conditions, behavior, limits, and outcomes.
- Make acceptance observable or measurable.
- Use `must` or `shall` for obligations. Avoid ambiguous `should`, `fast`,
  `easy`, or `user-friendly` unless defined by measurable criteria.
- State what is required, not how to implement it.
- Link each requirement to acceptance or validation intent when useful.
- Keep confirmed requirements separate from assumptions, open questions,
  rejected ideas, and out-of-scope behavior.
- Never invent a requirement to fill a perceived gap.
- Use the ubiquitous language in the applicable `CONTEXT.md`. When requirement
  wording conflicts with or exposes a gap in the glossary, resolve the term with
  the user and update the context inline using [context guidance](context.md).

## Collaboration

Use explicit user instructions directly. When a requirement is incomplete, ask
one question about the highest-impact ambiguity. Recommend concrete wording and
briefly explain the trade-off. Do not create a complete specification from
guesses.

After editing, ask the user to verify that the obligations and scope capture
their intent.

## Suggested Format

Follow the existing project format. If none exists, a requirement can use:

```markdown
### REQ-FUNC-001

**Requirement:** The system shall ...

**Acceptance:** Given ..., when ..., then ...
```

Add rationale, source, or dependencies only when they improve understanding or
traceability. Preserve existing IDs. Agree with the user before introducing a
new ID scheme across an established project.

## Use Cases And Acceptance

Use cases describe externally observable scenarios: actor, preconditions,
trigger, main flow, alternate or failure flows, and outcome. Add one only when a
scenario communicates behavior more clearly than atomic requirements alone.

Acceptance criteria define observable evidence that an obligation is satisfied.
Cover important success, boundary, alternate, and failure behavior without
turning acceptance criteria into an implementation plan.

Requirements stage artifacts include:

| File | Owns |
| --- | --- |
| `README.md` | Directory index, artifact status, and suggested reading order |
| `requirements.md` | Atomic functional, non-functional, and domain obligations |
| `use-cases.md` | Actor scenarios, flows, and outcomes |
| `acceptance.md` | Acceptance criteria and validation intent |
| `assumptions.md` | Unconfirmed information and open questions |
| `diagrams/` | Requirements diagram source |

Every requirements directory must include `README.md` and `assumptions.md`. Other
artifacts remain optional; use the smallest structure that keeps the project
clear.

Give each requirements assumption a stable ID. Follow the project's established
scheme or use `ASM-REQ-001`, incrementing the numeric suffix. Preserve IDs when
wording changes and record when an assumption is confirmed, rejected, or
superseded.

Place requirements diagrams in `requirements/diagrams/`. Use the user's preferred
format or the established project convention. Prefer Mermaid when neither defines
a format.

## Completion Check

- Every requirement comes from confirmed intent.
- Each requirement is atomic, unambiguous, and testable.
- Requirements describe obligations rather than design preferences.
- Domain terminology matches the applicable context documentation.
- Acceptance intent covers meaningful success and failure behavior.
- Assumptions and open questions are visibly non-normative.
- Requirements assumptions have stable, unique IDs and visible resolution status.
- Stable IDs and relative links resolve correctly.
- The stage README indexes current artifacts in a suggested reading order.
- Diagrams are stored under `requirements/diagrams/` in the preferred or
  established format.
- Superseded requirements are removed or explicitly marked according to project
  convention.
