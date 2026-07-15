# ADR Guidance

## Goal

Record that a consequential architectural decision was made and why. Preserve
the trade-off that led to the choice so a future reader does not unknowingly
reverse a deliberate decision.

Keep ADRs exceptionally brief. An ADR may be a single paragraph; its value comes
from the decision and rationale, not from filling out a template.

## When To Offer An ADR

Offer an ADR only when all three conditions are true:

1. **Hard to reverse:** Changing the decision later would have meaningful cost.
2. **Surprising without context:** A future reader is likely to wonder why the
   system was built this way.
3. **The result of a real trade-off:** Genuine alternatives existed and one was
   chosen for specific reasons.

If any condition is absent, skip the ADR. Easy-to-reverse choices can simply be
reversed, obvious choices need no special explanation, and choices without a real
alternative have no trade-off to preserve.

## Decisions That Qualify

- **Architectural shape:** A monorepo, event sourcing, or a separately projected
  read model.
- **Integration patterns between contexts:** Domain events instead of synchronous
  HTTP between Ordering and Billing.
- **Technology choices with meaningful lock-in:** A database, message bus,
  identity provider, or deployment target that would be expensive to replace,
  not every library.
- **Boundary and scope decisions:** One context owns Customer data and other
  contexts reference it only by ID. Explicit exclusions can be as important as
  included responsibilities.
- **Deliberate deviations from the obvious path:** Manual SQL instead of an ORM
  for a specific reason. These records prevent a future maintainer from
  "correcting" an intentional choice.
- **Constraints not visible in code:** A compliance restriction on cloud vendors
  or a latency limit imposed by a partner contract. Keep the normative constraint
  in requirements and use the ADR to preserve its architectural consequence and
  trade-off.
- **Non-obvious rejected alternatives:** A subtle reason REST was selected over
  GraphQL that would otherwise be debated again later.

## Location And Numbering

System-wide ADRs live in `docs/adr/`:

```text
docs/adr/
|-- 0001-event-sourced-orders.md
`-- 0002-postgres-for-write-model.md
```

In a multi-context repository, context-specific ADRs live in that context's
`docs/adr/` directory. Keep cross-context or system-wide decisions in the root
`docs/adr/`.

Create an ADR directory lazily when the first qualifying decision is confirmed.
Before naming a new ADR, scan the target directory for its highest existing
number and increment it. Use `NNNN-short-slug.md`, such as
`0003-domain-events-for-billing.md`.

## Collaboration Workflow

1. Identify the decision, alternatives, and decisive trade-off while discussing
   design with the user.
2. Check all three qualification conditions. Do not propose an ADR merely because
   a decision exists.
3. Offer to capture the ADR and confirm the selected option and rationale with the
   user.
4. Write the shortest record that would prevent a future reader from reopening or
   accidentally undoing the decision for lack of context.
5. Link current design documentation to the ADR instead of duplicating its full
   rationale.

ADRs preserve why a decision was made. Current-state design documentation owns
how the system is structured now. When an ADR is deprecated or superseded, keep
it as historical context and use status metadata to point to the newer decision.

## Format

```markdown
# {Short title of the decision}

{One to three sentences stating the context, decision, and reason.}
```

That is sufficient for most decisions.

## Optional Sections

Add these only when they provide genuine value:

- **Status frontmatter:** `proposed`, `accepted`, `deprecated`, or
  `superseded by ADR-NNNN`, when decisions may be revisited.
- **Considered Options:** When rejected alternatives are worth remembering.
- **Consequences:** When non-obvious downstream effects must be explicit.

Most ADRs should not need these sections.

## Completion Check

- The decision satisfies all three ADR qualification conditions.
- The user confirmed the selected option and decisive rationale.
- The ADR is in the correct system-wide or context-specific directory.
- Its number is the next available number in that directory.
- The record states the context, decision, and reason without template filler.
- Optional sections contain information worth preserving.
- Current design links to the ADR where the rationale matters.
- Superseded decisions remain discoverable and point to their replacement.
