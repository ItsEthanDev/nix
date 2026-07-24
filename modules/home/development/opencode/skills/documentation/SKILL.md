---
name: documentation
description: Documentation maintenance for durable project knowledge. Use proactively when work changes project intent or current behavior, terminology, architecture, setup, ticket state, or documentation conventions; when documentation drifts from implementation; or when another skill needs artifact ownership or writing guidance.
---

# Documentation

Keep documentation living: update it as part of the work that changes project knowledge. Keep each meaning in one canonical owner, grow structure just in time, and surface drift instead of guessing which conflicting claim is correct.

## Priority

Apply guidance in this order:

1. The user's current request.
2. Existing project documentation, using its declared hierarchy and artifact ownership.
3. Established project convention.
4. This skill's defaults.

Applicable `AGENTS.md` files own agent-specific instructions, not product facts. When existing documents conflict, use a project-defined authority rule if one exists. Otherwise, use the canonical owner for the subject and treat unresolved conflicts as drift. No filename, modification time, or document type wins every conflict.

## 1. Establish Authority

Read applicable `AGENTS.md` files, the root `README.md`, `docs/README.md`, and the documents relevant to the work when they exist. Follow their terminology, structure, scope, and collaboration rules. Inspect implementation and tests when needed to verify current behavior; do not ask the user for facts available in the project.

Treat confirmed documentation as intent and implementation as evidence of current behavior. Neither silently overrides the other.

This step is complete when the applicable owners and any conflicting claims are known.

## 2. Classify Knowledge

Classify durable information before writing it:

- **Confirmed intent:** A user decision or claim from its canonical target-state owner.
- **Verified fact:** Current behavior demonstrated by implementation, tests, or another authoritative source.
- **Work-state:** Progress, dependencies, blockers, or evaluation state on the path from current behavior to confirmed intent.
- **Uncertainty:** An assumption or open question that still needs confirmation.
- **Source material:** Non-normative input such as a prototype, image, PDF, or research artifact.

Use target-state, current-state, and work-state labels only when a real distinction exists. A specification may change when intent changes, but it does not track implementation progress. Verified behavior may be documented as a current fact, but it does not become a requirement merely because the code does it. Source material becomes normative only when the user or a canonical artifact adopts it.

Never turn an inference, suggestion, implementation accident, or source artifact into a requirement or decision. Co-locate a small assumption or open question with its subject; split it into a dedicated file and add stable IDs only when volume, sharing, or traceability makes that useful.

When a meaningful choice remains, call out anything surprising, recommend an answer with its main trade-off, and ask one focused question. Do not draft a large body of guessed documentation for the user to correct afterward.

This step is complete when every proposed statement has a known source and classification.

## 3. Update The Canonical Owner

When the user confirms a durable change and applicable documentation exists, update its canonical owner before implementation and reconcile it after verification. Do not wait for a separate documentation request.

Make the smallest change that preserves the knowledge. Use just-in-time structure: create a root `README.md` by default when initializing documentation, then create other artifacts promptly when each has useful content to own. If an unrelated task encounters a project without a root README, offer to initialize one once without blocking the task. Record a durable opt-out in `AGENTS.md` so future agents do not keep asking.

| Knowledge                                                                                | Usual canonical owner                           |
| ---------------------------------------------------------------------------------------- | ----------------------------------------------- |
| Project purpose, status, setup, current usage, and navigation                            | Root `README.md`                                |
| Documentation map, ownership, conventions, and maintenance                               | `docs/README.md`                                |
| A nested documentation area's index, reading order, or local rules                       | Applicable `docs/**/README.md`                  |
| Domain vocabulary and bounded-context meaning                                            | Applicable `CONTEXT.md`                         |
| Expected behavior, obligations, constraints, and acceptance intent                       | Requirements documentation                      |
| Architecture, interfaces, data, modules, and technical decisions                         | Design documentation                            |
| Why a consequential architectural trade-off was selected                                 | Applicable ADR                                  |
| Agent-only workflow, local gotchas, and durable preferences without a human-facing owner | Applicable `AGENTS.md`                          |
| Normative identity, voice, and visual direction                                          | Brand documentation                             |
| Non-normative prototypes, images, PDFs, and research                                     | Source material area established by the project |
| Implementation progress, dependencies, blockers, and evaluation                          | Ticket documentation                            |

Follow established placement and format first. Link to canonical text instead of duplicating it. Introduce stable IDs only when durable cross-document traceability needs them; persistent tickets always require IDs because their dependencies and lifecycle refer to them.

Before completing work, identify durable knowledge discovered during implementation and route it to its canonical owner. Record it in the applicable `AGENTS.md` only when it is an agent-specific instruction, local maintenance guardrail, or non-obvious operational gotcha that lacks a useful human-facing owner. Prefer normal project documentation when the knowledge would also help human developers.

Lead with what the intended reader needs to know or do. Use concise, concrete language. Include rationale when it prevents misuse or preserves a confirmed trade-off; omit empty templates, filler, and prose that merely restates code.

Use a diagram when relationships, flow, state, sequence, or structure become clearer than they would be in concise text and that clarity justifies another artifact to maintain. Follow project convention; otherwise prefer Mermaid so the source remains text-based and reviewable.

Load the focused reference only when its branch applies:

- [README guidance](readme.md) for a root, documentation, or nested directory README.
- [Requirements guidance](requirements.md) for externally meaningful target behavior and constraints.
- [Design guidance](design.md) for architecture, interfaces, data, or technical decisions.
- [Domain language guidance](domain-language.md) when terminology or bounded contexts are introduced or clarified.
- [ADR guidance](adr.md) for a hard-to-reverse, surprising architectural choice produced by a real trade-off.
- [Ticket guidance](tickets.md) when the project keeps persistent work-state in Markdown.

This step is complete when the durable information exists in one useful owner and any indexes or links affected by the change are current.

## 4. Reconcile Drift

Drift is an unaccounted mismatch among confirmed intent, documented current behavior, implementation, and work-state. A temporary implementation/specification gap explained by an active ticket is expected work, not drift.

When drift exists:

1. Cite the conflicting claims precisely.
2. Explain the user-visible or engineering consequence.
3. Ask whether implementation, documentation, or both should change, and provide a recommendation when confirmed intent supports one.
4. Record unresolved drift as an open question or ticket if work must continue.

Do not interrupt a requested change for the temporary mismatch created by that same change. Reconcile its documentation, implementation, and ticket state before finishing. For pre-existing or ambiguous drift, wait for the user's decision instead of silently selecting a source of truth.

Before completion, remove unsupported claims, stale text, duplicated ownership, and structure that no longer earns its maintenance cost. Check changed paths, commands, links, examples, and terminology. Summarize documentation changes; request review only when meaningful interpretation or ambiguity remains.

The work is complete when every relevant difference is either reconciled or explicitly accounted for.
