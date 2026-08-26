# Feature Artifacts

## Fallback organization

When the user and repository establish no feature-documentation convention, colocate one feature's artifacts in a three-digit sequential directory:

```text
specs/
├── constitution.md           # only when one consolidated governance owner is needed
└── 001-short-feature-name/
    ├── spec.md               # what and why
    ├── plan.md               # how and verification strategy
    ├── tasks.md              # execution order and progress
    ├── checklists/
    │   └── requirements.md   # optional reviewer-owned requirements-quality gate
    ├── research.md           # optional planning research
    ├── data-model.md         # optional technical data design
    ├── quickstart.md         # optional end-to-end validation scenario
    └── contracts/            # optional interface or protocol contracts
```

Use a concise action-noun feature name such as `003-add-token-revocation`. A feature directory and Git branch are independent. The core feature artifacts are `spec.md`, `plan.md`, and `tasks.md`; create an optional artifact only when separating its contents improves ownership, comprehension, reuse, or verification.

## Feature specification

`spec.md` owns desired user-visible or externally meaningful behavior, scope, and value without prescribing implementation. Start from [templates/spec.md](templates/spec.md).

Record:

- Feature identity, creation date, and lifecycle status.
- Applicable project constraints by stable ID or canonical path and heading.
- Problem, desired outcome, actors, in-scope behavior, and explicit non-goals.
- Independently valuable user stories with stable `US-###` IDs and `P1`, `P2`, and later priorities.
- For each story, its value, independent test, and observable Given/When/Then acceptance scenarios.
- Functional requirements with stable `FR-###` IDs.
- Measurable, technology-independent success criteria with stable `SC-###` IDs when such outcomes are genuine requirements.
- Relevant edge cases, domain entities, assumptions, and consequential open questions.

Use uppercase normative terms:

- `MUST` and `MUST NOT` identify behavior required for satisfaction.
- `SHOULD` and `SHOULD NOT` identify expected behavior and state the circumstances permitting an exception.
- `MAY` identifies permitted optional variation that forms part of the contract, not deferred scope.

Write one independently verifiable obligation per requirement. Use established domain terminology. Reference a project invariant rather than copying it; add a feature requirement only when it refines that invariant into observable behavior. Keep languages, libraries, schemas, endpoints, source paths, and other technical design in the plan.

Mark an unresolved product decision as `[NEEDS CLARIFICATION: specific question]` only when no responsible default exists and different answers materially affect scope, security, privacy, data handling, or user experience. Keep at most three markers in a draft, ordered by impact, and resolve them before treating the specification as accepted.

A specification is ready for acceptance when scope and non-goals are explicit, every proposed behavior has an observable acceptance condition, normative obligations are independently verifiable, assumptions are visible, and no unresolved question could materially change the technical design. Apply the acceptance authority and transition rules in [ARTIFACT-MODEL.md](ARTIFACT-MODEL.md). A specification is ready for planning once it satisfies these criteria and its status is `Accepted`.

## Implementation plan

`plan.md` owns the technical approach and verification strategy for an accepted specification. Start from [templates/plan.md](templates/plan.md).

Record, when applicable:

- The accepted specification and applicable project constraints.
- A concise summary of the requirement and smallest sufficient approach.
- Real implementation context: affected modules and interfaces, language, dependencies, storage, tests, target platform, performance constraints, and scale.
- Proposed changes mapped to `FR-###`, `SC-###`, and `US-###` identifiers.
- Verification evidence and exact commands or procedures.
- Dependencies, migration, rollback, operational risks, and unresolved technical blockers.
- Consequential design decisions and links to any ADR that must preserve their rationale.
- Links to optional research, data-model, contract, or quickstart artifacts.

The plan may add technical precision but may not add user-visible behavior or weaken the accepted specification. It summarizes linked optional artifacts rather than duplicating them.

A plan is ready for task derivation or implementation when it references the real codebase, every accepted requirement maps to a technical change and direct evidence, consequential unknowns are resolved or explicitly block use, operational concerns are addressed when applicable, and no design contradicts project governance or the specification.

## Task list

`tasks.md` owns execution order, dependencies, parallel safety, and progress derived from an accepted plan. Start from [templates/tasks.md](templates/tasks.md).

Use this fallback grammar:

```text
- [ ] T### [P?] [US-###?] Action with exact file path
```

- `T###` is stable within the feature directory and ordered by dependency.
- `[P]` means all dependencies are complete and concurrent execution cannot conflict on the same files or state.
- `[US-###]` links feature work to a user story; setup, foundational, and cross-cutting work may omit it.
- `[x]` means the task's stated verification passed, not merely that an edit was attempted.

Organize tasks into setup only when needed, shared foundational prerequisites, one independently verifiable phase per user story in priority order, and final cross-cutting work. Put required tests before implementation within a story. Each task must name a concrete action and exact path and must map to a requirement, necessary scaffold, verification step, or documented delivery concern.

A task list is ready for execution when every planned change and verification action is represented, dependencies and parallel markers agree, each story remains independently verifiable, and no task introduces behavior or design absent from its upstream artifacts.

## Planning research

`research.md` owns evidence used to resolve technical unknowns substantial enough to obscure the plan. Start from [templates/research.md](templates/research.md). For each question, record viable options, evidence and sources, finding, confidence, and plan implication. Research informs decisions; the plan owns the selected approach, and an ADR owns rationale that must outlive the plan.

Research is ready when each investigated question has a traceable finding and implication, sources can be retrieved, and remaining uncertainty is explicit.

## Technical data model

`data-model.md` owns substantial technical data design: representations, fields, relationships, validation, persistence, and state transitions. `CONTEXT.md` continues to own domain vocabulary, while `spec.md` mentions entities only as needed to describe observable behavior. Link the model from the plan.

A data model is ready when every represented concept uses canonical terminology, invariants and transitions are explicit, implementation choices preserve specification behavior, and migration or compatibility implications are represented in the plan.

## Contracts

`contracts/` owns externally meaningful interfaces or protocols such as HTTP schemas, events, commands, or public library interfaces. Use the repository's native machine-readable format when one exists. Contracts elaborate the plan but may not invent behavior absent from the specification.

A contract is ready when operations and data are unambiguous, success and failure behavior map to requirements, compatibility expectations are explicit, and machine-readable artifacts validate when applicable.

## Validation scenario

`quickstart.md` owns one concise end-to-end procedure for exercising the integrated feature. State prerequisites, exact steps, expected observable results, and cleanup when needed. Do not duplicate the complete verification strategy from the plan.

A quickstart is ready when an intended reader can execute it from a documented starting state and each expected result maps to accepted behavior.

## Requirements checklist

`checklists/requirements.md` is an optional reviewer-owned quality gate for the specification. Its checkboxes represent review findings, not implementation progress. An implementing agent may read it as a gate but must not silently approve reviewer-owned items.
