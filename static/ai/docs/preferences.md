# Preferences Skill Design

## Purpose

The `preferences` skill records Ethan's personal defaults for choices that recur across software projects. It gives coding agents concrete guidance when several valid tools or implementation styles are available and no stronger project-specific direction selects among them.

Preferences are intentionally narrower than engineering principles. A principle guides reasoning across many situations; a preference selects a favored tool, configuration, command, or code style in a defined situation.

## Desired outcomes

Projects created or changed with the skill should:

- Use Ethan's defaults when a covered choice is genuinely open.
- Apply exact configuration and commands consistently.
- Preserve coherent project conventions during unrelated work.
- Avoid introducing competing tools that serve the same purpose.
- Keep version-sensitive preferences verifiable against authoritative sources.
- Allow the collection to grow without loading every preference into every task.

## Authority and adoption

Apply authorities in this order:

1. The user's explicit request for the current task.
2. Repository instructions and documented project decisions.
3. Existing coherent project conventions.
4. The preferences skill.

A preference is a default for an open choice, not an automatic migration mandate. The presence of an npm, pnpm, Yarn, Radix, formatter, or other established setup is not by itself a reason to replace it during unrelated work.

When work explicitly establishes, replaces, or standardizes the relevant setup, the applicable preference should guide the choice. Surface a material conflict with a higher authority rather than silently mixing incompatible conventions.

## Information architecture

`SKILL.md` is the discoverable router. It contains the authority order, the common application process, and pointers that select topic references.

Topic references group preferences by the condition that causes an agent to need them. A reference may contain several closely related instructions when they are normally considered together. Do not create a leaf skill or file for every individual preference.

Split a reference when part of it develops a distinct trigger or when agents would otherwise need to load substantial irrelevant material. Keep exact configuration beside its applicability, merge behavior, exceptions, verification, and sources.

## Preference shape

Each preference must make the following clear when applicable:

- **Trigger:** the choice or artifact governed by the preference.
- **Default:** the concrete behavior, tool, command, or configuration to use.
- **Adoption behavior:** whether the preference applies only to new setup or also justifies migration.
- **Merge behavior:** for configuration, whether to merge a fragment or establish the complete file.
- **Exceptions:** conditions under which applying the default would be incorrect.
- **Verification:** how to inspect or run the resulting behavior.
- **Source:** authoritative documentation for version-sensitive syntax or semantics.

Small, self-explanatory preferences may express these elements in a few sentences rather than fixed headings. Do not add empty sections merely to satisfy the shape.

## Canonical ownership and skill boundaries

The preferences skill owns Ethan's reusable personal defaults. It does not own:

- Project-specific requirements or established repository policy.
- General implementation, debugging, or architecture principles.
- The full procedure for introducing and validating specialized tooling when another skill owns that procedure.
- Historical rationale that does not change agent behavior.

For example, `preferences` may select Oxlint and Oxfmt and provide Ethan's preferred options. `quality-tooling` owns compatibility inspection, lint and format policy design, baseline triage, command integration, and verification procedure. A topic reference should route to the owning skill instead of duplicating that guidance.

Every preference has one authoritative runtime location. Other skills may point to it but must not restate it as an independent rule.

## Adding a preference

Before adding a preference:

1. Confirm that it changes agent behavior relative to common defaults or ambiguous tool choices.
2. State the trigger narrowly enough that the agent can tell when it applies.
3. Decide whether it belongs in an existing topic reference or needs a distinct loading condition.
4. Define how it interacts with an existing project setup.
5. Verify exact commands and configuration against the installed tool or an authoritative source.
6. Add or update the router pointer if the new trigger is not already represented.

Do not encode an exact preferred configuration until its desired contents are known. Avoid placeholders that could be mistaken for an approved default.

## Evaluating changes

A change to the skill is complete when:

- The router can select the new preference from a concrete task description.
- Only relevant topic material needs to be loaded.
- The preference cannot reasonably be mistaken for an unrelated migration instruction.
- Exact snippets state whether they are complete files or fragments to merge.
- Version-sensitive claims and verification steps have been checked.
- The change does not duplicate policy owned by another skill.
