# Requirements Guidance

## Purpose

Requirements are target-state documentation. They record confirmed, externally meaningful obligations so a reader can determine what the completed project must do and how satisfaction can be observed without prescribing unnecessary implementation details.

## Ownership

Requirements may own:

- Functional behavior and capabilities.
- Measurable quality attributes and operational constraints.
- Rules imposed by the problem domain.
- Explicit scope and exclusions.
- Acceptance intent and externally observable scenarios.

Definitions of domain terms belong in `CONTEXT.md`. Architecture, module boundaries, interfaces, data shape, and implementation choices belong in design unless the user confirms one as a mandatory externally imposed constraint. Implementation progress belongs in tickets.

## Writing

- Derive every obligation from confirmed user intent or an existing canonical source.
- Write one obligation at a time with a precise actor, condition, behavior, limit, and outcome where applicable.
- Make acceptance observable or measurable. Replace undefined terms such as `fast`, `easy`, or `user-friendly` with the actual criterion.
- Describe what is required rather than how to implement it.
- Keep confirmed requirements separate from assumptions, questions, rejected ideas, and source material.
- Use the canonical domain language from the applicable `CONTEXT.md`.

Use cases are optional. Add one when an actor, precondition, trigger, main flow, alternate or failure flow, and outcome communicate behavior more clearly than an atomic statement alone.

Acceptance criteria are evidence of satisfaction, not an implementation plan. Cover meaningful success, boundary, alternate, and failure behavior.

## Structure

Follow the project's established format. A small project may keep requirements as a section in `docs/README.md` or one focused file. Split artifacts only when that makes ownership or navigation clearer.

Stable IDs are optional until tickets, tests, compliance, or cross-document links need durable traceability. When an ID is useful and no convention exists, use a simple scheme such as:

```markdown
### REQ-001: Checkout a valid cart

**Requirement:** A customer shall be able to checkout a valid cart.

**Acceptance:** Given a valid cart, when the customer checks out, then an order is created and its identifier is returned.
```

Preserve established IDs when wording changes. Co-locate a short assumptions or open-questions section with the relevant requirements; split it only when it needs an independent lifecycle.

## Completion Check

- Every requirement represents confirmed target-state intent.
- Each obligation is unambiguous and independently observable.
- Requirements do not silently prescribe design.
- Acceptance covers the behavior that matters without inventing scope.
- Domain terminology is canonical.
- Uncertainty and source material are visibly non-normative.
- Structure and IDs exist only where they provide useful navigation or traceability.
