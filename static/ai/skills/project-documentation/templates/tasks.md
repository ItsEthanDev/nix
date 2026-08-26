# Tasks: [Feature name]

**Feature Directory:** `specs/[NNN-feature-name]`
**Specification:** [Path to `spec.md`]
**Plan:** [Path to the plan ready for implementation]

<!-- Remove unused phases. Preserve task identifiers when editing an existing task list; phase numbering may change without renumbering tasks. -->

## Format

Each task uses:

```text
- [ ] T### [P?] [US-###?] [Refs: FR-###, SC-###]? Action with exact file path
```

- `[P]` means the task can run in parallel because it has no incomplete dependency and does not conflict on the same files.
- `[US-###]` links feature work to a user story. Setup, foundational, and cross-cutting tasks may omit it.
- The optional `[Refs: ...]` block links delivery and verification work to one or more `FR-###` or `SC-###` identifiers. Pure scaffold or delivery-administration tasks may omit it.
- Mark a task `[x]` only after its verification succeeds.

## Phase 1: Setup

<!-- Optional. Include only when the feature requires project or tooling setup. -->

- [ ] T001 [P] Create necessary project or tooling setup in `exact/path`

## Phase 2: Foundational

<!-- Optional. Include only for shared prerequisites that block multiple user stories. -->

- [ ] T002 Implement shared prerequisite in `exact/path`

**Checkpoint:** Foundational work is verified; user-story phases may begin.

## Phase 3: US-001 — [Title] (Priority: P1)

**Goal:** [Observable value delivered by this story.]

**Independent Test:** [How to verify this story on its own.]

### Tests, when required by the specification or project policy

- [ ] T003 [P] [US-001] [Refs: FR-001] Add failing test in `tests/exact-path`

### Implementation

- [ ] T004 [US-001] [Refs: FR-001] Implement the required behavior in `src/exact-path`

**Checkpoint:** US-001 passes its independent test.

## Final Phase: Polish & Cross-Cutting Concerns

- [ ] T005 [P] Update relevant documentation in `exact/path`
- [ ] T006 [Refs: FR-001, SC-001] Run complete verification commands from `plan.md`

## Verification Results

<!-- Retain when durable result traceability is required and no stable external system already owns it. -->

| Requirement or outcome | Evidence | Result |
| --- | --- | --- |
| FR-001 | `[command, test, or stable CI link]` | [Observed result] |
| SC-001 | `[measurement procedure or stable result link]` | [Observed result] |

## Dependencies

<!-- Remove relationships for omitted phases and replace generic ordering with the actual dependency graph. -->

- Setup precedes Foundational.
- Foundational blocks all user stories.
- User stories proceed in priority order unless the plan proves they are independent.
- Within a story, required tests precede implementation.
