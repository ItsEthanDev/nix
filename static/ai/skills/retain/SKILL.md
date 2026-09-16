---
name: retain
description: Extract up to three durable project, personal, or reusable learning candidates from the current context without reading files or recording anything.
disable-model-invocation: true
---

# Retain

Surface only information worth carrying beyond the current conversation so Ethan can decide whether and where to preserve it. This is a curation step, not memory storage, a retrospective, or a work summary.

## Extract candidates

1. Use only the conversation and context already loaded. Do not call tools, reread artifacts, inspect history, or modify anything. Arguments may narrow the boundary or topic but do not authorize tools or writes.
2. Consider any strong candidate under one primary scope:
   - **Project:** a project-specific fact, decision, constraint, convention, or vocabulary item.
   - **Personal:** an explicit or strongly established preference about how Ethan works.
   - **Reusable:** knowledge, a technique, a pitfall, or a procedure likely to help across projects.
3. Retain a candidate only when it passes every condition:
   - **Durable:** likely to remain useful after the current conversation.
   - **Specific:** expressible as a concrete fact, rule, preference, or procedure.
   - **Novel:** not already known from the loaded context to have a durable owner. When uncertain, prefer exclusion over claiming it is missing.
   - **High-confidence:** established directly by the conversation rather than inferred from silence or an incidental choice.
   - **Worth maintaining:** its likely future value exceeds the cost of another durable instruction or document entry.
   - **Routable:** it has a plausible broad owner such as project documentation, a specification, code or tests, project instructions, personal preferences, a skill, a template, or tooling.
4. Rank qualifying candidates by expected future value and keep at most three across all scopes. Scope labels are tags, not quotas; do not fill a scope with a weak candidate.

Exclude completed-work summaries, temporary state, open tasks, handoff information, routine technical facts, generic advice, speculative conclusions, review findings, and anything already known to be recorded. Do not infer a personal preference from one unremarked implementation choice.

## Report

When candidates exist, output only:

```markdown
## Retention candidates

- **Project → [broad owner]:** [one concise, standalone candidate]
- **Personal → [broad owner]:** [one concise, standalone candidate]
- **Reusable → [broad owner]:** [one concise, standalone candidate]
```

Include only qualifying bullets and keep each to one sentence. Order them by value, not by scope.

When nothing qualifies, output only:

```text
No durable learnings to capture.
```

Stop after the report. Do not offer to persist the candidates or begin another workflow.
