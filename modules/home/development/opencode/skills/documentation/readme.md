# README Guidance

## Goal

Help a new reader quickly determine what the project does, whether it fits their
need, how to get it running, and where to find deeper documentation.

## When To Update

Update the README when a user instruction or implementation change affects:

- The project's purpose, audience, or supported environment.
- Prerequisites, installation, configuration, or startup.
- The first useful workflow or common commands.
- Verification, testing, troubleshooting, or documentation navigation.

Do not wait for a specific README request. Keep detailed requirements and design
decisions in their canonical documents and link to them instead of duplicating
them here.

## Recommended Content

Include only sections the reader needs:

- Project name and a one- or two-sentence description.
- Status or scope warning when readers could otherwise make a wrong assumption.
- Prerequisites and the shortest verified setup path.
- A minimal usage example that produces a useful result.
- Common development, test, build, or deployment commands.
- Configuration and troubleshooting information that is frequently needed.
- Links to deeper documentation.

Prefer progressive disclosure: put the common path first and link to advanced or
specialized instructions.

## Stage README Files

Every existing `docs/requirements/` and `docs/design/` directory must contain a
`README.md`. A stage README is a directory index, not a second project overview.
Keep it brief and include:

- The stage's purpose and scope.
- A linked list of its artifacts with a one-line description and status when
  useful.
- A suggested reading order.
- Important handoff or traceability links to the preceding or following stage.
- Links to the stage's `assumptions.md` and relevant diagrams.

Update the index whenever an artifact is added, removed, renamed, or changes
status. Do not copy normative requirements, assumptions, or design decisions into
the index.

## Documentation Root README

A `docs/README.md` is recommended as the handbook for using and maintaining the
project's documentation. It should help humans and agents apply the same rules
without inspecting every document first.

Include the project-specific information that is useful:

- The purpose and scope of the documentation tree.
- A directory map and suggested high-level reading order.
- Which artifacts are canonical for requirements, design, assumptions, and other
  project knowledge.
- File naming, placement, status, ID, heading, linking, and traceability
  conventions.
- Assumption lifecycle and diagram location or format conventions.
- How and when documentation is reviewed, updated, and checked for drift.
- Documentation validation tools or commands, when used by the project.

Keep this file focused on project-wide documentation practice. Put stage-specific
artifact indexes in the stage README files, product behavior in requirements, and
technical decisions in design documentation.

Read and follow `docs/README.md` before writing or maintaining files under
`docs/`. Applicable local `AGENTS.md` instructions take priority. If the two
conflict, raise the mismatch with the user instead of silently choosing which
document to rewrite.

If `docs/` exists without a root README, recommend creating one when documentation
structure is being established or substantially changed. Its absence should not
block an unrelated task.

## Collaboration

Infer the intended reader and primary workflow from confirmed project context.
If either is unclear and materially changes the README, ask the user one focused
question and recommend the most likely answer.

After editing, ask the user to verify that the description and primary workflow
match how they want the project presented.

## Completion Check

- The opening explains the project without requiring internal knowledge.
- Setup and usage commands are current, ordered, and copyable.
- Required prerequisites and configuration are explicit.
- Examples match supported behavior.
- Links are relative and valid.
- The README does not duplicate detailed requirements or design documents.
- There are no placeholder, empty, or generic sections.
- A stage README indexes every current stage artifact and gives a useful reading
  order.
- The root `docs/README.md`, when present, accurately describes project-wide
  documentation structure, rules, conventions, and maintenance.
