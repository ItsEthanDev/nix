# Spec Kit conventions for new projects

Use this reference when a project has no established specification workflow or when its existing artifacts follow [GitHub Spec Kit](https://github.com/github/spec-kit) conventions. For a new project, these defaults adapt Spec Kit's core artifacts without adopting its settings directory, CLI, generated commands, scripts, hooks, extensions, or branch automation. For an existing project, use them to preserve its established Spec Kit structure and traceability.

Non-Spec-Kit project conventions take precedence. Treat this as convention alignment, not a compatibility guarantee. When a project is initialized by Spec Kit, use its installed constitution, templates, and commands as the authority because they may differ by version or preset.

## Default organization

Use one directory per feature:

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
    ├── data-model.md         # optional conceptual and technical data design
    ├── quickstart.md         # optional end-to-end validation scenario
    └── contracts/            # optional interface or protocol contracts
```

Use a concise action-noun feature name and a three-digit sequential prefix, such as `003-add-token-revocation`. Spec Kit also supports timestamp prefixes, but sequential numbering is the default for this skill. A feature directory name and a Git branch name are independent; do not make one depend on parsing the other.

The three core artifacts are `spec.md`, `plan.md`, and `tasks.md`. Create optional planning artifacts only when their contents would make the plan easier to understand or verify.

## Constitution

When a new project needs a consolidated constitution, prefer `specs/constitution.md` so project governance remains alongside its specification artifacts. Keep principles in the project's existing canonical documentation when it already has a suitable owner.

A principle must state an actionable rule and how compliance can be checked. Put agent-only operational instructions in the applicable agent instruction file rather than in the constitution. Amend the constitution deliberately when a durable project rule changes; do not weaken it inside a feature plan to make a violation pass.

## Specification conventions

`spec.md` describes user value and observable behavior without choosing implementation details.

Use these identifiers:

- `US1`, `US2`, ... for user stories.
- `P1`, `P2`, ... for story priority, where `P1` is the most valuable initial slice.
- `FR-001`, `FR-002`, ... for functional requirements.
- `SC-001`, `SC-002`, ... for measurable success criteria.

Each user story should be independently implementable, testable, and demonstrable where the domain permits. Record:

- The story in plain language.
- Why it has its priority.
- How to test it independently.
- Given/When/Then acceptance scenarios.

Functional requirements state specific, testable system behavior. Success criteria state measurable, technology-independent outcomes. Keep languages, frameworks, schemas, endpoints, and source structure in `plan.md`, not `spec.md`.

Include relevant edge cases, key domain entities, assumptions, scope, and exclusions. Mark unresolved text as `[NEEDS CLARIFICATION: specific question]` only when no responsible default exists and different answers materially affect scope, security, privacy, or user experience. Keep at most three such markers in a draft, prioritize them by impact, and resolve them before planning.

## Plan conventions

`plan.md` translates the accepted specification into a technical design. It should include:

- A concise summary of the requirement and approach.
- Concrete technical context: language, dependencies, storage, test tooling, target platform, performance constraints, and expected scale when relevant.
- A constitution check before research and design, repeated after the design is complete.
- The real source and test structure affected by the change.
- Proposed changes mapped to functional requirements, success criteria, and user stories.
- Verification evidence and exact commands or procedures.
- Dependencies, migrations, rollback needs, risks, decisions, and unresolved blockers when applicable.

Use optional artifacts to keep distinct planning concerns local:

- `research.md` records findings that resolve technical unknowns.
- `data-model.md` records entities, relationships, validation, and state transitions when data design is substantial.
- `contracts/` records externally meaningful interfaces or protocols.
- `quickstart.md` records an end-to-end scenario that can validate the integrated result.

Do not create these files as empty ceremony. Link them from `plan.md` when they exist.

## Task conventions

`tasks.md` is derived from the accepted spec and plan. Use this task grammar:

```text
- [ ] T### [P?] [US#?] Action with exact file path
```

For example:

```markdown
- [ ] T012 [P] [US1] Add revoked-token acceptance test in tests/auth/token-revocation.test.ts
- [ ] T013 [US1] Enforce revocation in src/auth/authenticate.ts
```

Apply the markers consistently:

- `T###` is a stable task ID in execution order.
- `[P]` means the task is safe to run in parallel: its dependencies are complete and it will not conflict on the same files.
- `[US#]` links a task to its user story. Setup, foundational, and cross-cutting tasks may omit it.
- `[x]` means the task's stated verification has passed, not merely that an edit was attempted.

Organize tasks into:

1. Setup.
2. Foundational shared prerequisites that block all stories.
3. One phase per user story in priority order.
4. A final polish and cross-cutting phase.

Within each story, place tests before implementation when tests are required by the specification or constituted project policy. Keep each story independently verifiable. Include exact paths and avoid vague tasks such as “finish API” or “add validation.”

## Quality gates inside the four phases

The local four-phase workflow incorporates Spec Kit's narrower commands as internal gates:

| Local phase | Spec Kit-aligned activity |
| --- | --- |
| Constitute | Establish and govern project principles |
| Specify | Draft requirements, clarify ambiguity, and review requirements quality |
| Plan | Produce technical artifacts and tasks, then run read-only cross-artifact analysis |
| Implement | Execute tasks in dependency order and converge implementation with the specification |

Before implementation, analyze `spec.md`, `plan.md`, and `tasks.md` without editing them. Check for:

- Functional requirements with no planned work or verification.
- Buildable success criteria with no evidence.
- Tasks with no requirement, story, scaffold, or delivery justification.
- Terminology drift, conflicting decisions, and unresolved placeholders.
- Task ordering or parallel markers that contradict dependencies.
- Constitution violations.

Fix each finding in the artifact that owns it, then rerun the analysis. Create `checklists/requirements.md` only when a persistent requirements-quality gate is useful. Treat its checkboxes as reviewer-owned approval rather than implementation progress; implementation may read the checklist as a gate but must not silently approve it.

After implementation, perform a convergence pass against the complete specification and constitution. When a gap remains, append a concrete convergence task to `tasks.md`, implement it, and repeat until no gap remains. Do not rewrite completed task history merely to make the artifacts appear converged.

## Persistence model

Spec Kit leaves persistence policy to each project. For a new project using this skill, default to a living specification:

- `spec.md` is the current behavioral contract.
- Change intended behavior in `spec.md` first.
- Revise or regenerate `plan.md` and `tasks.md` after specification changes.
- Treat task checkboxes as mutable execution state.
- Preserve technical rationale that must outlive regenerated plans in an ADR.
- Run cross-artifact analysis after any material revision.

Choose a flow-forward historical model instead when auditability requires completed feature directories to remain immutable. Record that choice in the project constitution so later agents know whether to revise an existing feature directory or create a successor.
