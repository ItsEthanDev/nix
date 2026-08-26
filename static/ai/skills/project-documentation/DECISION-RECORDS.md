# Decision Records

An ADR preserves the rationale for a consequential technical or domain-boundary decision that must remain understandable after its originating plan or conversation is gone. It does not supersede project governance. It may record a governance exception only when the governing policy explicitly authorizes that exception mechanism; the policy supplies the authority, while the ADR records its scope and rationale.

## When to create one

Create or offer an ADR only when all three conditions hold:

1. **Hard to reverse:** changing the decision later has meaningful cost.
2. **Surprising without context:** a future maintainer is likely to question or undo it.
3. **A real trade-off:** viable alternatives existed and the choice depended on specific reasons.

Typical candidates include architectural shape, integration patterns between contexts, high-lock-in technology choices, ownership boundaries, deliberate deviations from an obvious approach, and constraints not visible in code. Skip easy-to-reverse choices, obvious conclusions, and implementation details already explained by the plan or code.

## Location and identifiers

Follow the repository's established decision-record convention. Otherwise use `docs/adr/NNNN-kebab-case-title.md`, scanning the directory for the highest number and incrementing it. Put context-specific ADRs beside that context when the repository uses multiple contexts; keep system-wide decisions in the root ADR directory. Create the directory lazily.

## Format

Start from [templates/adr.md](templates/adr.md). The required content is a short title and enough prose to state the context, decision, and reason. Add status, considered options, or consequences only when they change how the record is understood or maintained.

When a decision changes, preserve history. Mark the old ADR `Deprecated` or `Superseded by ADR-NNNN` and link the replacement; do not rewrite an accepted historical decision to imply the new choice was always in force.

An ADR is ready when the decision and its reason are explicit, its scope is clear, links to related plans or decisions resolve, and non-obvious consequences needed for responsible use are recorded.
