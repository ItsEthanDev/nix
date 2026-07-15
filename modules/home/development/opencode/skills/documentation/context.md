# Context Guidance

## Goal

Actively build and sharpen the project's domain model and ubiquitous language.
Choose precise terms, challenge ambiguity, test boundaries with concrete
scenarios, and capture resolved language as soon as it becomes clear.

Merely reading `CONTEXT.md` to use established vocabulary is a normal
documentation habit. Apply this active process when changing or clarifying the
domain model.

## File Structure

Most repositories have one context and one root glossary:

```text
/
|-- CONTEXT.md
|-- docs/
|   `-- adr/
`-- src/
```

If a root `CONTEXT-MAP.md` exists, the repository has multiple bounded contexts.
The map identifies where each context lives and how the contexts relate:

```text
/
|-- CONTEXT-MAP.md
|-- docs/
|   `-- adr/                     # System-wide decisions
`-- src/
    |-- ordering/
    |   |-- CONTEXT.md
    |   `-- docs/adr/            # Ordering-specific decisions
    `-- billing/
        |-- CONTEXT.md
        `-- docs/adr/            # Billing-specific decisions
```

Create context files lazily. If neither file exists, create a root `CONTEXT.md`
when the first domain term is resolved. If `CONTEXT-MAP.md` exists, read it to
locate the applicable context. If only a root `CONTEXT.md` exists, treat the
repository as a single context.

For a multi-context repository, infer which context owns the current topic. Ask
the user when ownership is unclear.

## During The Session

### Challenge The Glossary

When the user uses a term that conflicts with established language, call it out
immediately and ask which meaning is intended. For example: "The glossary defines
`cancellation` as X, but this use appears to mean Y. Which meaning should be
canonical?"

### Sharpen Fuzzy Language

When the user uses a vague or overloaded term, propose a precise canonical term.
For example: "Does `account` mean Customer or User? The model treats those as
different concepts."

### Discuss Concrete Scenarios

When exploring domain relationships, stress-test them with specific scenarios.
Invent normal, boundary, alternate, and failure cases that force distinctions
between concepts and clarify context boundaries.

### Cross-Reference The Implementation

When the user describes how the domain works, inspect the implementation for
agreement. Surface contradictions between the stated model, glossary, and code.
Do not silently treat current code as intended domain behavior; use the drift
workflow in [`SKILL.md`](SKILL.md).

### Update The Context Inline

When a term is resolved, update the applicable `CONTEXT.md` immediately rather
than batching glossary changes until the end. Ask the user to review whether the
term and avoided synonyms capture their intended language.

`CONTEXT.md` is a glossary. It must remain free of implementation details,
requirements, scratch notes, and implementation decisions. Link to those
canonical artifacts when a relationship is useful.

## CONTEXT.md Format

```markdown
# {Context Name}

{One or two sentences describing what this context is and why it exists.}

## Language

**Order**:
{A one- or two-sentence definition of the term.}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account
```

Rules:

- Be opinionated. When multiple words describe one concept, choose the best term
  and list the alternatives under `_Avoid_`.
- Keep definitions to one or two sentences. Define what the concept is, not what
  the software does with it.
- Include only terms specific to the project's domain. General programming
  concepts such as timeouts, error types, and utility patterns do not belong.
- Group terms under subheadings when natural clusters emerge. Keep a flat list
  when all terms form one cohesive area.
- Use the canonical terms consistently in requirements, design, ADRs, interfaces,
  and user-facing documentation.

## CONTEXT-MAP.md Format

For multiple bounded contexts, the root map lists each context, its location, and
its relationships:

```markdown
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) - receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) - generates invoices and processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md) - manages warehouse picking and shipping

## Relationships

- **Ordering -> Fulfillment**: Ordering emits `OrderPlaced`; Fulfillment consumes it to start picking.
- **Fulfillment -> Billing**: Fulfillment emits `ShipmentDispatched`; Billing consumes it to generate invoices.
- **Ordering <-> Billing**: The contexts share `CustomerId` and `Money` types.
```

Keep relationship descriptions concrete about direction, exchanged information,
and ownership. Do not turn the context map into a full integration design; link
to design documents or ADRs for technical details and rationale.

## Completion Check

- Every added term is domain-specific and confirmed by the user or a canonical
  source.
- Definitions are concise, non-circular, and free of implementation details.
- Synonyms and overloaded alternatives are explicitly avoided where useful.
- Context ownership and relationships are clear.
- Requirements, design, ADRs, and implementation use the canonical language, or
  any drift has been raised with the user.
- New or changed terms were captured when resolved and presented for user review.
