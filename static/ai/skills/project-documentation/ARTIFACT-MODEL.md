# Artifact Model

Use this reference for ownership, traceability, lifecycle, and reconciliation across project documentation.

## Dependency model

```text
Project rule
    ↓ constrains
Feature requirement
    ↓ realized and verified by
Plan change + verification strategy
    ↓ executed through
Task
    ↓ proven by
Verification evidence
```

Supporting relationships:

- Domain context supplies canonical terminology to every artifact.
- Research supplies evidence for a plan decision; it does not own the decision.
- An ADR preserves consequential rationale that must outlive a plan.
- A README navigates to canonical owners without replacing them.
- Contracts and technical data models elaborate a plan and must preserve specification semantics.

A reference is preferable to repeated prose. Include a short local summary only when the reader cannot use the artifact correctly without it, and link to the canonical owner.

## Stable identifiers

Use established identifiers when present. Otherwise use:

| Entity | Pattern | Scope |
| --- | --- | --- |
| Feature directory | `NNN-kebab-case-name` | Specification root |
| Project principle | `PR-001` | Governance owner |
| User story | `US-001` | Feature directory |
| Functional requirement | `FR-001` | Feature directory |
| Success criterion | `SC-001` | Feature directory |
| Task | `T001` | Feature directory |
| ADR | `NNNN-kebab-case-title.md` | ADR directory |

Start numeric sequences at one and pad them to the width shown. Assign identifiers only to entities referenced across artifacts. Preserve an identifier when wording or ordering changes but identity does not. Never renumber for presentation, reuse a retired identifier, or silently transfer an identifier to a different obligation. When one entity splits, preserve the original identifier for the closest continuing meaning and assign new identifiers to the others; record supersession when ambiguity would remain.

For references outside the identifier's scope, include its feature path or other canonical owner, such as `specs/003-token-revocation/FR-002`.

## Lifecycle metadata

Use lifecycle metadata only when it changes how readers may use an artifact.

- Feature specification: `Draft`, `Accepted`, `Implemented`, or `Superseded`.
- Implementation plan: `Draft`, `Accepted`, `Completed`, or `Superseded` when plan approval is meaningful.
- ADR: `Proposed`, `Accepted`, `Deprecated`, or `Superseded by ADR-NNNN` when decisions are revisited.
- Task list: derive progress from task checkboxes; do not duplicate it in a status field.
- Constitution: record version or amendment date when governance history matters.
- README and domain context: normally omit status.

A `Draft` artifact may contain explicitly marked unresolved items. An artifact used as an accepted downstream input must not contain unresolved items that could change that downstream work.

## Persistence policy

Follow the repository's established history model. Otherwise use living feature artifacts:

- `spec.md` is the current behavioral contract.
- Change intended behavior in the specification before reconciling its plan and tasks.
- Treat task checkboxes as mutable execution state.
- Preserve rationale that must outlive regenerated planning artifacts in an ADR.
- Run a consistency pass after every material revision.

Use flow-forward history instead when auditability requires completed feature directories to remain immutable. Record that project-level choice in governance, create a successor feature directory for changed intent, and link predecessor and successor.

## Change reconciliation

Update the canonical owner first, then inspect the listed dependents:

| Changed information | Canonical owner | Dependents to reconcile |
| --- | --- | --- |
| Repository purpose, setup, use, or navigation | README | Linked documentation and commands |
| Durable project policy | Governance owner | Specifications, plans, agent instructions, and checks constrained by it |
| Canonical terminology | Domain context | Specifications, plans, contracts, ADRs, code-facing documentation |
| Desired behavior or scope | Feature specification | Plan, tasks, contracts, validation scenarios, and verification evidence |
| Technical approach | Implementation plan | Tasks, data model, contracts, quickstart, and relevant ADR references |
| Consequential durable rationale | ADR | Plan and architecture documentation that reference the decision |
| Execution order, dependency, or progress | Task list | Completion reports or automation consuming task state |
| Technical evidence or unknown | Research | Plan decisions that rely on the finding |
| Delivered proof | Tests and verification results | Task state and feature status |

A material upstream revision requires a consistency pass over every direct dependent. Reconcile by changing the artifact that owns the inconsistency; do not patch a downstream summary to conceal an upstream error.

## Universal readiness criteria

An artifact is ready for its intended use when:

- Its required content is present and its status permits that use.
- Facts are in their canonical owners and links to external owners resolve.
- Identifiers are unique, stable, and correctly scoped.
- Unresolved placeholders are absent or explicitly permitted by the lifecycle state.
- It is internally consistent and does not contradict its upstream sources.
- It contains no empty optional section retained only for template compliance.

Apply the artifact-specific readiness criteria in the corresponding reference in addition to these criteria.
