---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when resolving domain terminology, distinguishing contexts, stress-testing domain concepts, or recording a newly resolved term.
---

# Domain Modeling

Challenge domain terms, test concepts with concrete scenarios, and resolve ambiguity while designing. Before persisting a result in `CONTEXT.md`, `CONTEXT-MAP.md`, or an ADR, load the corresponding `project-documentation` guidance.

Run the process below when the domain model may change. When only consuming established vocabulary, read the applicable domain context and proceed.

## Process

1. **Locate the context.** Load the `project-documentation` domain-context guidance, then read the applicable context map and glossary. Identify the context that owns the topic before introducing language.
2. **Challenge conflicts.** When the user's term conflicts with canonical language, state both meanings and ask which concept is intended. Do not silently create a synonym.
3. **Sharpen vague language.** Propose a precise canonical term for overloaded language and distinguish neighboring concepts that would otherwise collapse into one name.
4. **Test concrete scenarios.** Invent ordinary and edge-case scenarios that force relationships, identity, lifecycle, ownership, and context boundaries to become explicit.
5. **Cross-check reality.** Compare the proposed model with relevant code and existing documentation. Surface contradictions and establish whether the model, implementation, or both must change.
6. **Record resolved language immediately.** Update the canonical context using `project-documentation`. Keep it a glossary: implementation details, requirements, technical decisions, and scratch notes belong elsewhere.
7. **Preserve consequential decisions selectively.** When a resolved domain boundary also represents a hard-to-reverse, surprising trade-off, apply the ADR selection and format rules from `project-documentation`. Do not create an ADR for terminology alone.

## Completion criteria

Domain modeling is complete when:

- Each resolved concept has one canonical term and distinguishable meaning.
- Concrete scenarios no longer expose unresolved ambiguity relevant to the request.
- Context ownership and cross-context relationships are explicit when applicable.
- Code and documentation contradictions are reconciled or reported.
- Newly resolved durable language is recorded in its canonical context rather than only in conversation.
