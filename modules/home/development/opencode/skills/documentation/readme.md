# README Guidance

## Purpose

A README is an entry point, not a dump for every fact below it. Use one to help a reader quickly understand an area, follow its common path, and find the canonical detail they need next.

## Root README

The root `README.md` should let a new reader determine:

- What the project does and who it is for.
- Whether its current status and supported environment fit their need.
- What they need before using or developing it.
- The shortest verified path to a useful result.
- Where deeper documentation lives.

Include only useful sections. Common content is a brief description, status or scope warning, prerequisites, setup, minimal usage, development or verification commands, common configuration, troubleshooting, and documentation links.

Describe current usable behavior. Clearly label planned capabilities rather than presenting target-state requirements as already available. Keep detailed requirements, designs, and decision rationale in their canonical owners and link to them.

Put the common path first. Commands must be ordered, copyable, and verified against the supported environment. Examples must match supported behavior.

## Documentation README

`docs/README.md` is the documentation entry point. In a small project, it may own all documentation that does not fit the root README. As documentation grows, it becomes a handbook that can define:

- The documentation area's purpose and scope.
- Its directory map and suggested reading order.
- Which artifacts canonically own requirements, design, domain language, decisions, tickets, brand guidance, and source material.
- Naming, placement, status, linking, and traceability conventions that the project actually uses.
- How documentation is maintained, reviewed, validated, and checked for drift.

Create it when a documentation tree needs an entry point or shared rules. Do not create it merely to announce an otherwise self-explanatory `docs/` directory.

## Nested README Files

A nested `docs/**/README.md` may provide a directory index, local scope, reading order, ownership boundaries, or maintenance instructions. Create one only when it resolves a navigation or ownership need. Not every directory needs a README.

An index lists current artifacts with short, non-normative descriptions and status only when status helps navigation. It links to canonical content instead of copying requirements, assumptions, design decisions, or ticket details. Update it when indexed artifacts are added, removed, renamed, or reorganized.

## Completion Check

- The opening is useful without internal knowledge.
- Current and planned behavior are not confused.
- Setup, usage, and verification commands are current and copyable.
- The README links to detail instead of duplicating its canonical text.
- Every section and nested README solves a current reader need.
- Links, paths, examples, indexes, and reading order are accurate.
