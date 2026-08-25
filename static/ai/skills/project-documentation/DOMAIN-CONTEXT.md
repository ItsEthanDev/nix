# Domain Context

Use domain context to record canonical project-specific vocabulary. Use the `domain-modeling` skill when actively discovering or challenging the model.

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

Create these files lazily. If neither context file exists, create a root `CONTEXT.md` when the first project-specific term is resolved. Introduce a context map only when the repository has multiple contexts whose language or ownership must be distinguished.

## CONTEXT.md

Start from [templates/context.md](templates/context.md). Define what each term is in one or two sentences. Select one canonical term and list ambiguous or competing terms under `_Avoid_`. Include only concepts specific to the project's domain; exclude general programming concepts, implementation details, requirements, technical decisions, and session notes.

Group terms only when natural clusters improve retrieval. Keep a flat glossary when one cohesive list is clearer.

A context is ready when every entry identifies one concept precisely, competing language is explicit, definitions contain no implementation policy, and usage agrees with related contexts.

## CONTEXT-MAP.md

For each context, record its name, location, responsibility, and relationships to other contexts. Describe relationships using canonical domain concepts and direction, for example which context produces or consumes an event. Do not use the map as a substitute for each context's glossary or for interface contracts.

A context map is ready when every context has one listed location and responsibility, cross-context relationships name both directions or roles unambiguously, and links resolve.
