# Domain Language Guidance

## Purpose

`CONTEXT.md` is the canonical glossary for a project's domain model and
ubiquitous language. It defines what domain-specific terms mean and which
alternatives to avoid so conversation, specification, design, code, and tests use
the same language.

It is a glossary, not a specification, implementation guide, scratch pad, or
decision log. Keep requirements, technical choices, and work-state in their own
canonical artifacts and link them only when useful.

## Create Just In Time

Most repositories need at most one root `CONTEXT.md`. Create it promptly when a
resolved vocabulary distinction will improve current or future work. Do not
create an empty glossary or fill one with general programming terms.

Use a root `CONTEXT-MAP.md` only when the project has multiple bounded contexts.
It locates each context and describes their relationships. Each bounded context
then owns its local `CONTEXT.md` and may own context-specific ADRs.

```text
/
|-- CONTEXT-MAP.md
|-- docs/
|   `-- adr/                     # System-wide decisions
`-- src/
    |-- ordering/
    |   |-- CONTEXT.md
    |   `-- docs/adr/            # Ordering decisions
    `-- billing/
        |-- CONTEXT.md
        `-- docs/adr/            # Billing decisions
```

## Maintain The Language

When domain language is introduced or changed:

- Challenge a term that conflicts with the established glossary.
- Sharpen vague or overloaded words by proposing one precise canonical term.
- Test relationships with concrete normal, boundary, alternate, and failure
  scenarios when the distinction is unclear.
- Inspect implementation when it can reveal current usage, but do not treat that
  usage as intended language when it conflicts with confirmed intent.
- Update the applicable glossary as soon as the user or a canonical source
  resolves the term.

If context ownership is unclear, ask the user one focused question and recommend
the most likely owner. Apply the documentation drift process when the glossary,
other documentation, and implementation disagree.

## CONTEXT.md Format

```markdown
# {Context Name}

{One or two sentences describing the context and why it exists.}

## Language

**Order**:
{A one- or two-sentence definition.}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request
```

Choose one term for each concept and list misleading or competing synonyms under
`_Avoid_` when that prevents ambiguity. Keep definitions concise, non-circular,
and free of implementation details. Include only domain-specific concepts. Group
terms under subheadings when natural clusters emerge; otherwise keep one flat
language list.

## CONTEXT-MAP.md Format

```markdown
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) - receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) - generates invoices and processes payments

## Relationships

- **Ordering -> Billing**: Ordering provides confirmed order details; Billing owns invoicing.
- **Ordering <-> Billing**: The contexts share `CustomerId` and `Money` value formats.
```

Keep each relationship concrete about direction, exchanged information, and
ownership. Technical protocol and integration rationale belong in design and
ADRs.

## Completion Check

- Every term is domain-specific and confirmed.
- Each concept has one canonical name and a concise definition.
- Avoided alternatives expose ambiguity rather than listing harmless synonyms.
- Context ownership and cross-context relationships are clear where applicable.
- Other documentation and implementation use the canonical language, or drift
  has been raised.
