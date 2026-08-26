# Domain Context

Use domain context to discover, resolve, and record canonical project-specific vocabulary and context boundaries. When only consuming established vocabulary, read the applicable context and proceed without changing it.

## Resolve domain language

When the domain model may change:

1. **Locate the context.** Read the applicable context map and glossary. Identify the context that owns the topic before introducing language.
2. **Challenge conflicts.** When the user's term conflicts with canonical language, state both meanings and ask which concept is intended. Do not silently create a synonym.
3. **Sharpen vague language.** Propose a precise canonical term for overloaded language and distinguish neighboring concepts that would otherwise collapse into one name.
4. **Test concrete scenarios.** Invent ordinary and edge-case scenarios that force relationships, identity, lifecycle, ownership, and context boundaries to become explicit.
5. **Cross-check reality.** Compare the proposed model with relevant code and existing documentation. Surface contradictions and establish whether the model, implementation, or both must change.
6. **Record resolved language immediately.** Update the canonical context as soon as a term is resolved. Keep implementation details, requirements, technical decisions, and scratch notes in their respective owners.
7. **Preserve consequential decisions selectively.** When a resolved domain boundary is also a hard-to-reverse, surprising trade-off, apply [DECISION-RECORDS.md](DECISION-RECORDS.md). Do not create an ADR for terminology alone.

Domain language is resolved when each affected concept has one canonical term and distinguishable meaning, concrete scenarios expose no relevant ambiguity, context ownership is explicit, contradictions are reconciled or reported, and durable language is recorded outside conversation history.

## Organization

Most repositories use one root context:

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
└── src/
```

When the repository contains multiple distinct domain contexts, use a root `CONTEXT-MAP.md` that points to each context-local `CONTEXT.md`:

```text
/
├── CONTEXT-MAP.md
├── docs/adr/                    # system-wide decisions
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/            # ordering decisions
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/            # billing decisions
```

Create these files lazily. During specification work, if neither context file exists, generally create the canonical `CONTEXT.md` alongside the specification work unless the feature introduces no project-specific domain concepts. Follow repository context boundaries for its location; “alongside” means during the same workflow step, not necessarily inside the feature directory. Outside specification work, create a root `CONTEXT.md` when the first project-specific term is resolved. Introduce a context map only when the repository has multiple contexts whose language or ownership must be distinguished.

## CONTEXT.md

Start from [templates/context.md](templates/context.md). Define what each term is in one or two sentences. Select one canonical term and list ambiguous or competing terms under `_Avoid_`. Include only concepts specific to the project's domain; exclude general programming concepts, implementation details, requirements, technical decisions, and session notes.

Group terms only when natural clusters improve retrieval. Keep a flat glossary when one cohesive list is clearer.

A context is ready when every entry identifies one concept precisely, competing language is explicit, definitions contain no implementation policy, and usage agrees with related contexts.

## CONTEXT-MAP.md

For each context, record its name, location, responsibility, and relationships to other contexts. Describe relationships using canonical domain concepts and direction, for example which context produces or consumes an event. Do not use the map as a substitute for each context's glossary or for interface contracts.

A context map is ready when every context has one listed location and responsibility, cross-context relationships name both directions or roles unambiguously, and links resolve.
