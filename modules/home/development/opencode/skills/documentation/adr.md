# ADR Guidance

## Purpose

An architecture decision record preserves that a consequential technical choice
was made and why, so a future reader does not unknowingly reverse it or reopen the
same trade-off without its context.

Current design documentation owns how the system is structured. An ADR owns why
a qualifying decision was made and remains as historical context when the design
later changes.

## Qualification

Capture an ADR only when all three conditions are true:

1. **Hard to reverse:** Changing the decision later has meaningful cost.
2. **Surprising without context:** A future maintainer is likely to question or
   accidentally undo it.
3. **A real trade-off:** Genuine alternatives existed and the selection has a
   confirmed reason.

If any condition is absent, keep the information in current design when it is
useful or omit it. Do not create an ADR merely because a decision occurred.

Qualifying subjects may include architectural shape, cross-context integration,
technology with meaningful lock-in, ownership boundaries, a consequential
interface or seam, an externally imposed architectural constraint, or a
deliberate deviation from the obvious design.

## Location And Numbering

Create the ADR directory just in time for the first qualifying decision.
System-wide ADRs usually live in `docs/adr/`. A project with bounded contexts may
keep context-specific ADRs in that context's `docs/adr/` and cross-context
decisions at the root.

Follow established naming first. Otherwise scan the target directory for the
highest number and use `NNNN-short-slug.md` with the next number, such as
`0003-domain-events-for-billing.md`.

## Format

Keep the record as short as the decision allows:

```markdown
# {Short decision title}

{One to three sentences stating the context, selected option, and decisive reason.}
```

Add only sections that preserve useful information:

- Status such as `proposed`, `accepted`, `deprecated`, or `superseded by
  ADR-NNNN` when lifecycle matters.
- Considered options when a rejected alternative is likely to be raised again.
- Consequences when non-obvious downstream effects must remain visible.

When a decision is superseded, preserve the old ADR and point it to its
replacement. Link current design to the accepted ADR where its rationale helps;
do not duplicate the full trade-off.

## Completion Check

- The decision satisfies all three qualification conditions.
- The selected option and decisive reason come from confirmed intent.
- The ADR is in the correct scope and follows project naming.
- The record states context, decision, and reason without template filler.
- Optional sections earn their maintenance cost.
- Superseded decisions remain discoverable and current design links to relevant
  rationale.
