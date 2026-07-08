---
name: sdlc-v-docs
description: Defines the canonical SDLC-V documentation directories, file roles, boundaries, IDs, and Markdown traceability links. Use when creating or editing SDLC-V requirements, system, architecture, or module design docs.
---

# SDLC-V Docs

Use this skill before creating or editing SDLC-V documentation artifacts. This skill defines where SDLC-V information belongs, which file owns each kind of information, and how documents link without duplicating source text.

The goal is that a human or agent can answer three questions quickly:

- Where is the canonical source for this fact or decision?
- Which downstream documents depend on it?
- If it changes, which single source document must be edited?

## Canonical Directories

All SDLC-V artifacts live under `docs/`:

| Directory | Stage | Owns | Does not own |
| --- | --- | --- | --- |
| `docs/requirements` | Requirements analysis | Stakeholder needs, obligations, constraints, use cases, acceptance criteria, validation intent | System boundaries, external interface designs, internal architecture, module internals |
| `docs/system` | System design | System context, boundary, externally visible functions, external interfaces, states, requirement allocation, system verification implications | Stakeholder requirement text, internal components, technologies, deployment topology, module APIs |
| `docs/architecture` | Architecture design | Internal structure, components/subsystems, architectural decisions, runtime topology, persistence strategy, quality-attribute strategies, integration approach | Requirements source text, black-box system contracts, module internals, algorithms |
| `docs/modules` | Module design | Internal module responsibilities, APIs, data structures, algorithms, invariants, dependencies, module-level verification implications | Requirements source text, system boundary contracts, architecture-wide topology or technology decisions |

If a repository already has non-canonical SDLC-V docs, ask whether to migrate, link, or continue using the existing structure. Do not silently create duplicate sources of truth.

## Big Picture

The left side of the V decomposes intent into implementable design:

- `docs/requirements` defines why the system exists and what it must satisfy.
- `docs/system` turns requirements into externally visible system behavior and boundaries.
- `docs/architecture` turns system design into internal structure and cross-cutting strategies.
- `docs/modules` turns architecture into implementable module contracts and internals.

The right side of the V uses traceability to verify and validate the work:

- Requirements link to validation and acceptance intent.
- System design links requirements to system-level verification implications.
- Architecture links system design to integration and architecture-level verification implications.
- Module design links architecture to unit, module, and static verification implications.

Verification agents should be able to build tests, reviews, demonstrations, and analyses from these trace links without rediscovering why a design element exists.

## Common Skeleton

Each canonical directory uses this skeleton:

| File | Role | Why it belongs in every stage |
| --- | --- | --- |
| `README.md` | Directory index, stage purpose, artifact status, reading order, and handoff notes | Gives humans and agents a predictable entry point |
| `traceability.md` | Stage-local trace links from upstream sources to local artifacts and downstream implications | Prevents duplicate source text and supports SDLC-V verification |
| `assumptions.md` | Assumptions, open questions, rejected ideas, and deferred topics for that stage | Keeps uncertainty visible without promoting it to fact |
| `diagrams/` | Mermaid source files linked from markdown docs | Keeps diagrams reviewable in GitHub and easy to update |

Common files are stage-local. For example, `docs/system/assumptions.md` contains system-design assumptions, not requirements assumptions. If an assumption becomes a requirement, move its source text to `docs/requirements` and leave a link behind where useful.

## Link And ID Rules

Use GitHub-compatible relative Markdown links for cross-document references.

Use stable ID-only headings for link targets:

```markdown
### REQ-FUNC-001

**Summary:** Users can authenticate with an approved identity provider.
```

Link to the heading with a relative path from the current document:

```markdown
[REQ-FUNC-001](../requirements/requirements.md#req-func-001)
```

Rules:

- The canonical source text for any fact, requirement, constraint, design element, or decision lives in exactly one document.
- Downstream documents link to canonical sources instead of copying their source text.
- Downstream documents may include a short label for readability, but the normative text must remain upstream.
- If an upstream source changes, edit the upstream source first, then update downstream trace links or local implications only when they actually changed.
- Prefer relative links that work in GitHub, not absolute filesystem paths.
- Keep heading IDs stable. If the human-readable title changes, the link target should not change.

Recommended ID prefixes:

| Prefix | Owner | Meaning |
| --- | --- | --- |
| `NEED-001` | `docs/requirements/stakeholders.md` | Stakeholder need |
| `ACT-001` | `docs/requirements/stakeholders.md` | Actor or stakeholder class |
| `UC-001` | `docs/requirements/use-cases.md` | Use case or scenario |
| `REQ-FUNC-001` | `docs/requirements/requirements.md` | Functional requirement |
| `REQ-NFR-001` | `docs/requirements/requirements.md` | Non-functional requirement |
| `REQ-IFACE-001` | `docs/requirements/requirements.md` | Interface requirement |
| `REQ-DATA-001` | `docs/requirements/requirements.md` | Data requirement |
| `REQ-OPS-001` | `docs/requirements/requirements.md` | Operational requirement |
| `REQ-SEC-001` | `docs/requirements/requirements.md` | Security requirement |
| `CON-001` | `docs/requirements/requirements.md` | Confirmed constraint |
| `ACC-001` | `docs/requirements/acceptance.md` | Acceptance or validation criterion |
| `ASM-001` | stage-local `assumptions.md` | Assumption |
| `OQ-001` | stage-local `assumptions.md` | Open question |
| `SYS-CTX-001` | `docs/system/context.md` | System context item |
| `SYS-BND-001` | `docs/system/boundary.md` | Boundary or responsibility decision |
| `SYS-FUNC-001` | `docs/system/functions.md` | System-level function |
| `SYS-IFACE-001` | `docs/system/interfaces.md` | External interface design |
| `SYS-STATE-001` | `docs/system/states.md` | System state, mode, or transition |
| `ARCH-COMP-001` | `docs/architecture/components.md` | Component or subsystem |
| `ARCH-DEC-001` | `docs/architecture/decisions.md` | Architecture decision |
| `ARCH-RUN-001` | `docs/architecture/runtime.md` | Runtime or deployment element |
| `ARCH-DATA-001` | `docs/architecture/data.md` | Architecture-level data or persistence decision |
| `ARCH-QA-001` | `docs/architecture/quality-attributes.md` | Quality-attribute strategy |
| `ARCH-ITEST-001` | `docs/architecture/integration-tests.md` | Architecture integration test scenario |
| `MOD-001` | `docs/modules/catalog.md` | Module |
| `MOD-IFACE-001` | `docs/modules/interfaces.md` | Internal module interface |
| `MOD-BEH-001` | `docs/modules/behavior.md` | Module behavior, algorithm, or invariant |
| `MOD-DATA-001` | `docs/modules/data-structures.md` | Module-local data structure |
| `MOD-DEP-001` | `docs/modules/dependencies.md` | Module dependency rule |
| `MOD-TEST-001` | `docs/modules/module-tests.md` | Module-level test scenario |

## `docs/requirements`

Requirements analysis owns the problem statement, stakeholder intent, obligations, and validation intent. It says what must be true, not how the system is structured.

Stage-specific files:

| File | Role | Why here and not elsewhere |
| --- | --- | --- |
| `stakeholders.md` | Stakeholders, actors, goals, needs, and concerns | These explain the origin of requirements; design stages should link back instead of redefining users |
| `requirements.md` | Atomic functional, non-functional, interface, data, operational, safety, security, compliance requirements, and confirmed constraints | This is the canonical source of obligations; downstream docs allocate or satisfy these obligations |
| `use-cases.md` | Scenarios, main flows, alternate flows, and failure paths | These describe desired externally observable behavior before design commits to boundaries or internals |
| `acceptance.md` | Acceptance criteria, validation intent, and high-level verification method | This defines how stakeholders will recognize success; detailed system/module tests belong later |

Keep out:

- Internal components, services, packages, classes, functions, algorithms, or schemas.
- Architecture choices unless the user confirms them as constraints.
- System boundary decisions unless they are stated as required obligations.

## `docs/system`

System design owns the black-box and gray-box system view. It translates requirements into externally visible system behavior and system boundaries while avoiding internal architecture and module design.

Stage-specific files:

| File | Role | Why here and not elsewhere |
| --- | --- | --- |
| `context.md` | External actors, neighboring systems, external dependencies, operating environment, and system context diagrams | Requirements name stakeholders; system context defines how the system sits among external parties |
| `boundary.md` | In-scope and out-of-scope responsibilities, ownership boundaries, non-responsibilities, and boundary rationale | Architecture needs a stable system boundary before assigning internals |
| `functions.md` | Top-level system functions allocated from requirements | These are externally meaningful capabilities, not internal components or modules |
| `interfaces.md` | External interfaces, protocols, contracts, data exchanged at the system boundary, and interaction obligations | External contracts are system-level; internal APIs belong in modules |
| `states.md` | System lifecycle states, modes, transitions, failure behavior, and externally visible behavioral rules | System states describe observable behavior; internal state machines belong in architecture or modules |

Keep out:

- Internal component breakdowns, service boundaries, or package/module APIs.
- Technology selections, hosting/deployment topology, persistence choices, and algorithms.
- Repeated requirement text. Link to `docs/requirements` instead.

## `docs/architecture`

Architecture design owns the internal structure that satisfies the system design. It decides how the system is organized at component, subsystem, runtime, and cross-cutting levels.

Stage-specific files:

| File | Role | Why here and not elsewhere |
| --- | --- | --- |
| `overview.md` | Architecture summary, drivers, constraints, and reading guide | Gives the internal design context without duplicating requirements or system design |
| `components.md` | Components, subsystems, responsibilities, ownership, and major dependencies | Components are internal structure, not system-level functions or module internals |
| `interactions.md` | Internal flows, orchestration, messaging, error paths, and integration patterns | System interfaces stop at the boundary; this explains behavior inside it |
| `data.md` | Data ownership, persistence boundaries, consistency model, retention, migration, and architecture-level schemas | Requirements state data obligations; modules own local structures; architecture owns shared persistence strategy |
| `runtime.md` | Deployment topology, environments, scaling, resilience, observability, and operational architecture | Runtime topology is an architectural choice unless it is a confirmed requirement constraint |
| `quality-attributes.md` | Strategies for performance, security, reliability, maintainability, accessibility, privacy, and compliance | Requirements define quality targets; architecture defines how the system will meet them |
| `integration-tests.md` | Integration seams, architecture-level test scenarios, harness assumptions, and links to runnable integration tests | Architecture owns component/subsystem seams and integration strategy; detailed unit/module tests belong in module or verification stages |
| `decisions.md` | Architecture decisions, alternatives considered, trade-offs, and links to ADRs when used | Durable internal choices belong here or in linked ADRs, not in requirements |

Keep out:

- Stakeholder needs and requirement source text.
- External black-box contracts that belong in `docs/system/interfaces.md`.
- Function-level algorithms, private data structures, and module-local invariants.
- Test assertions that belong to detailed verification artifacts, unless they are architecture-level integration scenarios or links to runnable integration tests.

## `docs/modules`

Module design owns implementable internal detail below the architecture level. It translates architecture components into module contracts, local behavior, and code-facing design.

Stage-specific files:

| File | Role | Why here and not elsewhere |
| --- | --- | --- |
| `catalog.md` | Module list, ownership, purpose, status, and parent architecture component links | Gives implementation agents a stable inventory without redefining architecture |
| `interfaces.md` | Internal module APIs, contracts, errors, events, and data exchanged between modules | Internal APIs are module design; external system interfaces stay in `docs/system` |
| `dependencies.md` | Allowed dependencies, layering rules, coupling constraints, and forbidden imports | Architecture sets broad structure; modules define precise dependency contracts |
| `behavior.md` | Module-local behavior, algorithms, state machines, edge cases, and invariants | These details are too specific for architecture and too implementation-oriented for system design |
| `data-structures.md` | Module-local data structures, schemas, invariants, validation rules, and transformations | Architecture owns shared data strategy; modules own local representations |
| `module-tests.md` | Module-level public seams, TDD scenarios, harness assumptions, and links to runnable tests | Modules own code-facing behavior and public module contracts; architecture owns integration seams and verification agents own full test suites |

Keep out:

- New requirements or changes to requirement meaning.
- New architecture-wide components or runtime topology.
- External system contracts unless documenting how a module implements a linked system interface.
- Tests coupled to private implementation details instead of public module seams.

For large projects, add one file per module under `docs/modules/` only when the shared files become hard to navigate. Keep the common files as the index and traceability layer.

## Traceability Patterns

Each stage links upstream and records local implications:

| Stage | Traceability source | Local trace target | Downstream implication |
| --- | --- | --- | --- |
| Requirements | Stakeholder needs and use cases | Requirements and acceptance criteria | Validation intent |
| System | Requirements, constraints, assumptions | System functions, boundaries, interfaces, states | System verification implications |
| Architecture | System design elements and quality constraints | Components, interactions, runtime, data, decisions, integration test scenarios | Integration and architecture verification implications |
| Modules | Architecture components and decisions | Module APIs, behavior, dependencies, data structures, module test scenarios | Unit/module verification implications |

Use traceability tables with links rather than copied paragraphs. A typical row should include source link, local artifact link, rationale or implication, and status.

## Diagram Guidance

Store Mermaid diagrams as `.mmd` files in the stage-local `diagrams/` directory and link to them from markdown docs.

Recommended diagram types:

| Stage | Preferred Mermaid diagrams |
| --- | --- |
| Requirements | `requirementDiagram`, `flowchart`, `sequenceDiagram`, `stateDiagram-v2`, `erDiagram` for information requirements |
| System | `flowchart`, `sequenceDiagram`, `stateDiagram-v2`, `requirementDiagram` |
| Architecture | `flowchart`, `sequenceDiagram`, `stateDiagram-v2`, `requirementDiagram` |
| Modules | `classDiagram`, `flowchart`, `sequenceDiagram`, `stateDiagram-v2` |

Choose diagrams that match the stage boundary. For example, a component diagram belongs in architecture, not system; a class diagram belongs in modules, not requirements.

## When Information Seems To Belong In Two Places

Use this rule: one place owns the source text; other places link to it and describe their local consequence.

Examples:

- A customer says, "The system must support SSO." The requirement text belongs in `docs/requirements/requirements.md`; `docs/system/interfaces.md` may link to it when defining the external identity-provider interface.
- The system must expose a REST API. If this is a stakeholder constraint, the constraint belongs in requirements; the system API contract belongs in `docs/system/interfaces.md`; internal routing and service ownership belong in architecture; handler/module APIs belong in modules.
- A database choice is mandated by compliance. The mandate belongs as a constraint in requirements; the persistence architecture that satisfies it belongs in `docs/architecture/data.md`; table or local data structure details belong in modules.
- A module needs a cache. The cache belongs in modules if it is local behavior, architecture if it affects system-wide topology or consistency, and requirements only if stakeholders require caching or a performance target that implies it.

When uncertain, record the uncertainty in the current stage's `assumptions.md` or `OQ-*` item, then ask the user before promoting it to a canonical source.
