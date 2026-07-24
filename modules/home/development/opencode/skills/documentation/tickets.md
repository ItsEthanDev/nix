# Ticket Documentation Guidance

## Purpose

Ticket documentation owns work-state: the implementation work, dependencies,
blockers, and evaluation needed to move current behavior toward target-state
intent. When separate requirements or design documentation exists, tickets link
to it rather than taking over its ownership. A simple project may keep the
confirmed outcome and acceptance context only in its tickets when a separate
specification would add no value.

A persistent ticket must be bounded to one agent session and independently
verifiable. When a full specification exists, the ticket set should state whether
the active queue covers it and identify any known gap. Otherwise, state the
queue's intended scope.

## Default Layout

Follow project convention first. Otherwise use Markdown with one file per ticket:

```text
docs/tickets/
|-- README.md
|-- TKT-001-establish-test-seam.md
|-- TKT-002-add-checkout.md
`-- archive/
```

`docs/tickets/README.md` owns ticket conventions, the active queue, useful
execution order, and its intended or known specification coverage. Create
`archive/` when the first terminal ticket is retained.

Use `TKT-NNN-short-slug.md` when no ID convention exists. IDs remain stable when
titles or state change.

## Ticket Format

Store only mutable state and direct dependencies in frontmatter:

```markdown
---
status: ready
depends-on:
  - TKT-001
---

# TKT-002: Add checkout

## Outcome

{The bounded result this ticket must produce.}

## Specification

- [Checkout requirement](../requirements/checkout.md#checkout)

## Scope

{Included work and any exclusion needed to keep the ticket session-sized.}

## Acceptance

- {Observable criterion.}

## Verification

- {Command, inspection, or named human evaluation that proves the criterion.}
```

Add notes, blockers, open questions, or evaluation instructions only when the
ticket needs them. The outcome states the end condition, not a vague activity.
Specification links or confirmed acceptance context provide enough durable
information to execute the ticket without the originating conversation.

Record only direct `depends-on` IDs in ticket files. Derive reverse `blocks`
relationships in the index rather than maintaining both directions. Describe an
external blocker in the ticket body.

## States

- `needs-info`: A user decision is required before the ticket can become ready.
- `blocked`: A ticket dependency or non-user condition prevents implementation.
- `ready`: The ticket satisfies the ready gate below.
- `in-progress`: An agent or person has claimed and is implementing the ticket.
- `needs-evaluation`: Implementation checks pass, but a named human judgment is
  still required.
- `complete`: Every acceptance criterion has been satisfied and no action remains.
- `cancelled`: The outcome is intentionally no longer being pursued.

Move directly from `in-progress` to `complete` when all acceptance is objectively
verified. Use `needs-evaluation` only for a real human acceptance criterion. A
rejected evaluation returns the ticket to the state implied by the remaining
work.

## Ready Gate

A ticket is `ready` only when:

- Its outcome is achievable in one agent session.
- Its confirmed target source and relevant constraints are linked or quoted.
- Direct ticket dependencies are complete and external blockers are absent.
- No unresolved user decision remains.
- Scope and exclusions prevent hidden follow-on work.
- Every acceptance criterion has concrete evidence: an automated command,
  observable inspection, or explicit human evaluation.

Automation is preferred when practical, not mandatory. A behavior-preserving
prefactor ticket must be independently verifiable and name the successor it
unblocks; generic cleanup is not a prefactor.

## Completion And Archive

Before marking a ticket complete, update any durable requirements, design,
README, domain language, or ADR knowledge revealed by the work. Ticket history
must not become the only owner of enduring project knowledge.

Archive `complete` and `cancelled` tickets after their durable information has
moved to canonical documentation. Keep the active README focused on non-terminal
work and link to the archive when historical traceability is useful.

## Completion Check

- The ticket is session-sized and independently verifiable.
- Outcome, scope, acceptance, and evidence agree.
- Dependencies have one source of truth.
- Status reflects the work that actually remains.
- The active queue states its known coverage of the target specification.
- Terminal tickets leave no durable knowledge stranded in work-state.
