---
name: documentation
description: Defines the recommended documentation directories, file roles, boundaries, IDs, and Markdown traceability links. Use when making changes, asked questions about the system, creating or updating docs, or learning something new about how the system should work. This skill should be called liberally and regularly.
---

# Documentation

This skill defines where information belongs, which file owns each kind of information, and how documents link without duplicating source text.

The goal is that a human or agent can answer three questions quickly:

- Where is the canonical source for this fact or decision?
- Which downstream documents depend on it?
- If it changes, which single source document must be edited?

## Big Picture

- Be comprehensive, but brief. Don't omit details, but don't be overly wordy.
Each artifact should be digestable.
- The docs will be considered the source of truth for the application.
- Before asking questions, inspect existing `AGENTS.md`, `README.md`, `REQUIREMENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/` content when present. Do not ask questions that can be answered from existing project documentation or code.
- Ask focused clarification questions one at a time. For each question, provide your recommended answer and explain the trade-off briefly.
- Ask the user to review the changes you make in the docs to make sure you are capturing the user intent correctly.
- If you notice that documentation and implementation have deviated from one
another, call it out to the user and ask how they would like to resolve it. Do
not assume that the docs or code should be updated.
- If documentation is missing, incomplete, or lack stable IDs/linkable headings, warn the user and ask whether to fix first or proceed with explicit assumptions.
- Never invent documentation not given to you by the user. If you have questions
about the software record it as an assumption or ask the user.
- Avoid writing design documentation without requirements documentation.

## AGENTS.md

If the user has any documentation preferences that deviate from this skill,
record those preferences in the project `AGENTS.md` file. Create one if it
doesn't exist.

## Canoncial Directories

All agile docs live under `docs/`:

| Directory | Stage | Owns |
| --- | --- | --- |
| `docs/requirements` | Requirements analysis | Stakeholder needs, obligations, constraints, use cases, acceptance criteria, validation intent |
| `docs/design` | System Design | Interface design, architecture design, and
detailed design |

## Common Skeleton

Each canonical directory uses this skeleton:

| File | Role | Why it belongs in every stage |
| --- | --- | --- |
| `README.md` | Directory index, stage purpose, artifact status, reading order, and handoff notes | Gives humans and agents a predictable entry point |
| `assumptions.md` | Assumptions, open questions, rejected ideas, and deferred topics for that stage | Keeps uncertainty visible without promoting it to fact |
| `diagrams/` | Mermaid source files linked from markdown docs | Keeps diagrams reviewable in GitHub and easy to update |

Common files are stage-local. For example, `docs/system/assumptions.md` contains system-design assumptions, not requirements assumptions. If an assumption becomes a requirement, move its source text to `docs/requirements` and leave a link behind where useful.

## Linking Rules

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
