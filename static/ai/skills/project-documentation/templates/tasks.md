# Tasks: [Feature name]

**Feature Directory:** `specs/[NNN-feature-name]`
**Specification:** [Path to `spec.md`]
**Plan:** [Path to `plan.md`]

## Format

Each task uses:

```text
- [ ] T### [P?] [US-###?] Action with exact file path
```

- `[P]` means the task can run in parallel because it has no incomplete dependency and does not conflict on the same files.
- `[US-###]` links feature work to a user story. Setup, foundational, and cross-cutting tasks may omit it.
- Mark a task `[x]` only after its verification succeeds.

## Phase 1: Setup

- [ ] T001 [P] Create necessary project or tooling setup in `exact/path`

## Phase 2: Foundational

Shared prerequisites that block every user story:

- [ ] T002 Implement shared prerequisite in `exact/path`

**Checkpoint:** Foundational work is verified; user-story phases may begin.

## Phase 3: US-001 — [Title] (Priority: P1)

**Goal:** [Observable value delivered by this story.]

**Independent Test:** [How to verify this story on its own.]

### Tests, when required by the specification or project policy

- [ ] T003 [P] [US-001] Add failing test for FR-001 in tests/exact-path

### Implementation

- [ ] T004 [US-001] Implement FR-001 in src/exact-path

**Checkpoint:** US-001 passes its independent test.

## Final Phase: Polish & Cross-Cutting Concerns

- [ ] T005 [P] Update relevant documentation in exact/path
- [ ] T006 Run complete verification commands from plan.md

## Dependencies

- Setup precedes Foundational.
- Foundational blocks all user stories.
- User stories proceed in priority order unless the plan proves they are independent.
- Within a story, required tests precede implementation.
