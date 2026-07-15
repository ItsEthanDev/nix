# Design Guidance

## Goal

Clearly define the system's architecture, modules, components, interfaces, and
data, including data shape. Explain the decisions, boundaries, and trade-offs
needed to implement and change the system while tracing them to confirmed
requirements or user intent.

Design documentation must add information beyond the requirement. It explains
how the system will satisfy intent and why consequential choices were made.

## When To Update

Update design documentation when the user confirms or implementation changes:

- System boundaries, responsibilities, dependencies, or component interactions.
- External or internal interfaces and contracts.
- Data ownership, schema, lifecycle, or flow.
- Significant algorithms, state transitions, security controls, or operational
  behavior.
- A consequential decision, rejected alternative, trade-off, or known limitation.
- Domain boundaries or relationships between bounded contexts.

Do not wait for a separate documentation request. Do not document routine code
structure unless it helps a future reader reason about or safely change the
system.

## Design Levels

- **Interface design:** Interactions between the system and users, devices, or
  other systems, including events, messages, formats, errors, ordering, and
  timing.
- **Architectural design:** Major components, responsibilities, boundaries,
  dependencies, interactions, and allocation of quality constraints.
- **Detailed design:** Internal states, algorithms, data structures, processing,
  and collaboration within a component when those details are consequential.

Use only the levels needed for the decision. A small change may need one focused
section rather than separate documents for every level.

Across the applicable levels, make these concepts clear:

- **Architecture:** The system's overall structure, boundaries, major patterns,
  deployment context, and interactions.
- **Modules:** Cohesive implementation units, their responsibilities, and their
  dependencies.
- **Components:** Runtime or deployable building blocks, their ownership, and how
  they collaborate.
- **Interfaces:** Contracts between users, systems, components, or modules,
  including inputs, outputs, errors, ordering, and timing.
- **Data:** Ownership, shape, constraints, lifecycle, storage, access, and flow.

Use the project's terminology when it defines modules or components differently.
Do not force a distinction that the project does not use, but make the relevant
boundaries and responsibilities unambiguous.

## Writing Rules

- Link to requirements or quote only the short context needed to understand the
  decision; do not restate requirements as design.
- Use canonical language from the applicable `CONTEXT.md`. Resolve conflicting or
  overloaded terms with the user and update the glossary inline using
  [context guidance](context.md).
- Distinguish the current design from a proposal or migration target.
- Describe responsibilities and contracts rather than listing every file or
  function.
- Explain rationale and trade-offs for decisions that are expensive to reverse or
  surprising to a maintainer.
- Record assumptions, unresolved decisions, risks, and known limitations
  explicitly.
- Keep diagrams focused on a question the text needs to answer. Store editable
  source under `design/diagrams/` and link it with a relative path. Use the user's
  preferred format or established convention; otherwise prefer Mermaid.
- Keep details synchronized with implementation. Follow the drift workflow in
  [`SKILL.md`](SKILL.md) when they disagree.
- Offer an ADR only for a hard-to-reverse, non-obvious decision produced by a real
  trade-off. Follow [ADR guidance](adr.md), and link the current design to the ADR
  rather than duplicating its full rationale.

## Collaboration

Confirm intent before committing undocumented choices to design. A formal
requirements file is not required for every small change, but the relevant user
intent must be known.

For a meaningful unresolved decision, present the viable options, recommend one,
and explain the primary trade-off. Ask one focused question at a time. Record the
user's answer as the decision and remove any assumption it resolves.

After editing, ask the user to verify that the documented decisions and
trade-offs reflect their intent.

## Suggested Content

Include only what helps explain the design:

- Context and scope.
- Linked requirements, constraints, or confirmed user intent.
- The decision or proposed design.
- Boundaries and responsibilities.
- Interfaces, data, control flow, and failure behavior.
- Quality attributes and operational concerns.
- Alternatives considered and the decisive trade-off.
- Links to applicable ADRs for consequential decision rationale.
- Consequences, risks, migration, and open questions.

Every design directory must also contain:

- `README.md`, which indexes the design artifacts and gives a suggested reading
  order.
- `assumptions.md`, which records design assumptions and open questions.

Give each design assumption a stable ID. Follow the project's established scheme
or use `ASM-DES-001`, incrementing the numeric suffix. Preserve IDs when wording
changes and record when an assumption is confirmed, rejected, or superseded.

## Completion Check

- Every design statement is supported by confirmed intent or labeled as proposed.
- Requirements and design are clearly separated and linked where useful.
- Design terminology matches the applicable context documentation.
- Boundaries, ownership, interfaces, data flow, and failure behavior are clear at
  the necessary level.
- Architecture, modules, components, interfaces, and data shapes are defined at
  the level needed to implement and safely change the system.
- Consequential decisions include a brief rationale or link to an ADR that owns
  the full trade-off.
- Qualifying architectural decisions have been offered as ADRs, and current design
  links to accepted ADRs where useful.
- Design assumptions have stable, unique IDs and visible resolution status.
- The stage README indexes current artifacts in a suggested reading order.
- Diagrams are stored under `design/diagrams/` in the preferred or established
  format.
- Current implementation and current-state documentation agree, or unresolved
  drift has been raised with the user.
- Stale alternatives, diagrams, links, and implementation details are removed or
  explicitly historical.
