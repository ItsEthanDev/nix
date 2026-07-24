# Design Guidance

## Purpose

Design documentation explains the technical shape selected to satisfy confirmed
intent. It may describe target architecture, verified current architecture, or
both. Label the distinction only while it matters.

Design adds information beyond requirements. Requirements own externally
meaningful obligations; design owns the technical decisions, boundaries, and
contracts used to satisfy them.

## Ownership

Use design documentation when a reader needs to understand or safely change:

- System boundaries, responsibilities, dependencies, or component interactions.
- User, system, component, or module interfaces and their contracts.
- Data ownership, shape, constraints, lifecycle, storage, or flow.
- Significant state transitions, algorithms, security controls, or operational
  behavior.
- Deployment shape, integration behavior, failure handling, or quality-attribute
  allocation.
- A consequential technical decision, trade-off, migration, limitation, or risk.

Routine file and function structure need no prose when code already communicates
it clearly. Normative behavior remains in requirements, domain definitions remain
in `CONTEXT.md`, work progress remains in tickets, and a qualifying ADR owns the
historical reason for a consequential architectural trade-off.

## Writing

- Trace the design to confirmed intent with links rather than restating the
  requirements.
- Describe responsibilities and contracts instead of inventorying every file or
  function.
- Make ownership, boundaries, dependencies, interfaces, data flow, failure
  behavior, and relevant quality constraints explicit.
- For an interface, document what callers need to use it correctly: operations,
  inputs, outputs, invariants, errors, configuration, side effects, ordering,
  timing, and performance where relevant.
- Distinguish accepted design, current implementation, proposals, migrations,
  and open questions when more than one exists.
- State meaningful alternatives, consequences, risks, and limitations without
  manufacturing rationale the user did not provide.
- Use canonical domain language and link qualifying decisions to their ADRs.

When a diagram meets the skill's clarity threshold, keep it focused on one
question and store it beside the design it explains unless the project has an
established diagram location.

## Structure

A small design can be a section in an existing document. Add a focused file or
directory when the design needs independent navigation, ownership, or review.
Create an index, assumptions file, diagram directory, or stable ID scheme only
when each solves a current need.

If current and target designs differ, account for the implementation gap in
tickets. When they converge, remove obsolete migration language and state labels
that no longer add meaning.

## Completion Check

- Every design statement is confirmed, verified as current, or explicitly
  proposed or uncertain.
- Requirements and design remain distinct and linked where useful.
- Boundaries, ownership, interfaces, data, interactions, and failure behavior
  are clear at the level needed to implement or safely change the system.
- Rationale is present only when known and useful.
- Diagrams and structure earn their maintenance cost.
- Current implementation, target design, and work-state agree or their gap is
  explicitly accounted for.
