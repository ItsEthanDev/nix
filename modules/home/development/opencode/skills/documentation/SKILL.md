---
name: documentation
description: Helps maintain brief, usable project documentation through collaboration with the user. Use proactively and repeatedly when starting work, receiving instructions, changing behavior, terminology, or design, resolving domain language, making consequential architectural decisions, learning how a project works, answering project questions, detecting documentation drift, or creating and reviewing documentation.
---

# Documentation

Maintain documentation as part of the work, not as a separate task the user must
remember to request. Capture confirmed intent, keep each fact in one canonical
place, and make the result easy to use.

## Goals

- Help a reader understand, use, verify, and safely change the project.
- Keep documentation brief enough to scan and complete enough to act on.
- Preserve the user's intent without inventing facts or decisions.
- Make confirmed facts, assumptions, decisions, and open questions distinct.
- Keep domain language precise and preserve the rationale for consequential
  architectural decisions.
- Keep documentation and implementation aligned.
- Involve the user when intent or the source of truth is unclear.

## Instruction Priority

Apply guidance in this order:

1. The user's current instruction.
2. Documentation preferences in applicable `AGENTS.md` files, with the file
   closest to the documented artifact taking priority.
3. Documentation rules and conventions in `docs/README.md`.
4. Established project documentation conventions.
5. This skill's defaults.

Before editing documentation, read the applicable `AGENTS.md` files from the
project root through the target directory and `docs/README.md` when it exists.
Follow their terminology, structure, scope, and collaboration preferences even
when they differ from this skill. If `docs/README.md` conflicts with an applicable
`AGENTS.md`, follow `AGENTS.md` and raise the conflict as documentation drift.

Record durable project documentation conventions in `docs/README.md` when that
documentation tree exists. Record agent-specific workflow instructions in the
appropriate local `AGENTS.md` unless the user says they apply only to the current
task. Keep the files consistent, but do not duplicate detailed rules without a
need. Do not put product requirements or design decisions in `AGENTS.md`.

## When To Apply This Skill

Apply this workflow:

- At the start of a task, to learn local documentation rules from `AGENTS.md` and
  `docs/README.md` and find canonical project context.
- Whenever the user gives or changes an instruction about behavior, constraints,
  setup, operation, terminology, architecture, or documentation preferences.
- When domain terms or bounded-context relationships are clarified, challenged,
  or introduced.
- When a hard-to-reverse, non-obvious architectural trade-off is resolved.
- While implementation reveals a durable fact, decision, limitation, or mismatch.
- Before completing a change, to update affected documentation and check for
  drift.
- When answering questions whose answer should already be project knowledge.

Do not wait for the user to ask for a documentation update. If a new instruction
changes durable project knowledge, update its canonical documentation in the
same task. Do not document transient commands, experiments, or conversation that
will not help future readers.

## Workflow

### 1. Establish Context

Read applicable `AGENTS.md` files, `docs/README.md`, `CONTEXT-MAP.md`, the
applicable `CONTEXT.md`, and relevant existing documentation when they exist
before asking questions. Inspect the implementation when needed to verify current
behavior. Do not ask the user for information already available in the project.

Treat documentation as the source of confirmed intent and implementation as
evidence of current behavior. Neither silently overrides the other.

### 2. Classify The Information

Decide whether new information is:

- Confirmed intent from the user or an existing canonical source.
- Current implementation behavior verified in the project.
- An assumption that still needs confirmation.
- An open question.
- A rejected or deferred idea.

Never turn an inference, implementation accident, or suggestion into a
requirement or decision. Label uncertainty explicitly.

### 3. Collaborate On Intent

An explicit user instruction is sufficient input; document it without asking for
separate permission. If intent is ambiguous or a meaningful choice remains, ask
one focused question at a time. Include a recommended answer and its main
trade-off.

Use the user's answer to revise the documentation. Do not produce a large
specification from assumptions and ask the user to correct it afterward.

### 4. Update The Canonical Artifact

Make the smallest documentation change that preserves the durable information:

| Information | Usual owner |
| --- | --- |
| Project purpose, setup, basic usage, and navigation | Root `README.md` |
| Documentation structure, rules, conventions, and maintenance | `docs/README.md` |
| Domain vocabulary and bounded-context meaning | Applicable `CONTEXT.md` |
| Bounded contexts, locations, and relationships | Root `CONTEXT-MAP.md` |
| Expected behavior, obligations, constraints, and acceptance intent | Requirements documentation |
| Architecture, interfaces, data flow, and implementation decisions | Design documentation |
| Rationale for a consequential architectural decision | Applicable ADR |
| Agent workflow and documentation preferences | Applicable local `AGENTS.md` |
| Unconfirmed information | Clearly labeled assumptions or open questions |

Follow the project's existing structure. When no convention exists, prefer a
root `README.md` and focused files under `docs/`. Do not create a requirements or
design stage merely to satisfy a template, but use the following structure when
that stage exists:

| Path | Role |
| --- | --- |
| `docs/README.md` | Documentation guide, directory map, rules, conventions, and maintenance workflow |
| `docs/requirements/README.md` | Requirements index, artifact status, and suggested reading order |
| `docs/requirements/assumptions.md` | Requirements assumptions and open questions |
| `docs/requirements/diagrams/` | Requirements diagram source |
| `docs/design/README.md` | Design index, artifact status, and suggested reading order |
| `docs/design/assumptions.md` | Design assumptions and open questions |
| `docs/design/diagrams/` | Design diagram source |

Every existing requirements or design stage directory must have its stage
`README.md` and `assumptions.md`. Create a `diagrams/` directory when the stage
has diagrams. Keep each stage README current as artifacts are added, removed, or
renamed.

A root `docs/README.md` is recommended whenever the project has a documentation
tree. If it is missing, recommend creating it when establishing or substantially
changing the documentation structure, but do not block unrelated work. Keep it
current whenever project-wide documentation rules or structure change.

Create domain context and ADR artifacts lazily:

| Path | Role |
| --- | --- |
| `CONTEXT.md` | Ubiquitous language for a single-context repository |
| `CONTEXT-MAP.md` | Index and relationships for multiple bounded contexts |
| `{context}/CONTEXT.md` | Ubiquitous language for one bounded context |
| `docs/adr/` | System-wide architectural decision records |
| `{context}/docs/adr/` | Context-specific architectural decision records |

Create the first `CONTEXT.md` when a domain term is resolved. Create an ADR
directory only when the first qualifying architectural decision is confirmed.
Current design documentation owns how the system works; an ADR owns why a
consequential decision was made.

Give assumptions stable, stage-scoped IDs. Follow an established ID scheme;
otherwise use `ASM-REQ-001` for requirements assumptions and `ASM-DES-001` for
design assumptions. Preserve an ID when wording changes. When an assumption is
confirmed, move the normative information to its canonical artifact and retain
the ID or a resolution link according to project convention.

Store requirements and design diagrams in their respective `diagrams/`
directories. Follow the user's preference first and established project
convention second. When neither specifies a format, prefer Mermaid because its
source is text-based and reviewable. Link diagrams with relative paths and keep
editable source under version control.

Use the focused guidance when relevant:

- [README guidance](readme.md)
- [Requirements guidance](requirements.md)
- [Design guidance](design.md)
- [Context guidance](context.md)
- [ADR guidance](adr.md)

### 5. Detect And Resolve Drift

Drift exists when documentation and implementation make conflicting claims
about current or intended behavior. When found:

1. Show the conflict precisely, citing the relevant documents and implementation.
2. Explain the user-visible or engineering consequence.
3. Ask whether to update the implementation, update the documentation, or
   redefine both. Recommend an option when the latest confirmed intent supports
   one, but do not silently choose.
4. Record unresolved drift as an open issue or assumption if work must continue.

Do not interrupt an explicitly requested change merely because its implementation
and documentation are temporarily out of sync. Complete both parts of the change
unless a pre-existing conflict makes the intended result unclear.

### 6. Review With The User

Before finishing:

- Check that instructions, examples, paths, commands, links, and terminology are
  consistent with the project.
- Remove duplication, stale statements, filler, and unsupported claims.
- State which documentation changed and ask the user to review whether it captures
  their intent. The review request should not block completion unless confirmation
  is required to resolve ambiguity.

## Writing Standard

- Lead with what the reader needs to know or do.
- Use short sections, concrete language, and copyable commands.
- Include rationale only when it prevents misuse or preserves an important
  decision.
- Prefer a focused link over repeating canonical text.
- Preserve established project terminology.
- Use canonical domain terms from the applicable `CONTEXT.md`; challenge conflicts
  or ambiguity instead of introducing synonyms silently.
- Describe current and proposed behavior explicitly; do not mix them.
- Avoid generic introductions, exhaustive templates, empty headings, and content
  that merely restates code.
- Keep documentation proportional to the project and change.
- Keep stage README indexes and suggested reading orders synchronized with their
  directories.

## Linking And Ownership

The canonical source text for a fact, requirement, constraint, or decision lives
in one document. Other documents use GitHub-compatible relative Markdown links
and may include a short, non-normative label for readability.

Use existing stable IDs and headings. Assumptions always require stable IDs; use
the stage defaults above when the project has no established scheme. Introduce
IDs for other artifact types only when the project needs durable traceability,
and agree on the scheme with the user before applying it broadly. Do not change a
stable ID merely because its title changes.
