# Project Documentation

This living supporting specification refines the [AI-assisted development specification](../spec.md) for project documentation. It owns the desired outcomes, authority model, and boundaries of the configured `project-documentation` capability. The runtime skill owns its task-specific procedures.

## Purpose

The `project-documentation` skill provides a reusable, workflow-independent but convention-opinionated documentation system for software repositories. It standardizes artifact roles, fallback organization, formats, ownership, and traceability across projects without prescribing approval gates or development phase transitions.

The skill is independently distributable. A team can adopt its documentation conventions without adopting `spec-driven-development` or another prescribed development process.

## Desired outcomes

Repositories using the skill should:

- Organize equivalent information in predictable artifact roles and formats.
- Keep each durable semantic claim in one authoritative owner.
- Minimize the number of artifacts changed when project information changes.
- Preserve traceability from project rules through requirements, plans, tasks, and verification evidence.
- Produce reasonably deterministic documentation when no local convention exists.
- Respect established repository conventions when they already provide clear ownership.
- Remain understandable to humans and coding agents without conversation history.

## Authority order

When selecting documentation structure, the skill must apply authorities in this order:

1. The user's explicit request.
2. Established repository conventions.
3. The skill's fallback conventions.

The skill must surface material conflicts between these authorities rather than silently choosing one.

## Logical roles before filenames

The skill must define documentation in terms of logical roles before prescribing filenames or paths.

For example, project governance is a logical role. It may be owned by `specs/constitution.md`, `docs/principles.md`, `SECURITY.md`, or another established artifact.

Fallback paths provide consistency for repositories without conventions. They must not override an existing artifact that already owns the information.

## Canonical ownership

Every durable semantic claim that can be independently changed, contradicted, or relied upon must have one authoritative owner.

Other artifacts may contain a derived projection when locality, navigation, machine readability, or executable verification requires it. A projection must identify its authoritative source and preserve the source's semantics. It must not introduce a new obligation, weaken an existing obligation, convert an implementation choice into project policy, or conceal a conflict.

Canonical ownership applies to the meaning of a claim, not necessarily to every textual occurrence of the information. Related artifacts may own different levels of precision:

| Claim | Canonical owner |
| --- | --- |
| Externally meaningful behavioral obligation | Feature specification |
| Exact protocol or interface representation | Contract |
| Technical approach and integration design | Implementation plan |
| Detailed technical representation and transitions | Data model |
| Executable assertion | Test or check |
| Observed execution result | CI record or durable verification report |
| Explanation needed for local use | Explicitly derived summary |

A more precise downstream artifact may elaborate an upstream claim only within the variation permitted by that claim. If a protocol detail creates new externally meaningful behavior, update the specification before adding it to the contract.

When two artifacts appear to own the same claim:

1. State the conflicting formulations.
2. Classify the claim by artifact role and level of precision.
3. Select the canonical owner using the authority order.
4. Convert the other occurrence into a reference or explicitly derived projection.
5. Reconcile all affected dependents.

Do not resolve an ownership conflict merely by choosing the most recently edited artifact. When semantics change, the canonical upstream owner must change first.

## Locality of change

The documentation model should minimize reconciliation work.

A change should update:

1. The artifact that canonically owns the changed information.
2. Only the direct dependents affected by that change.

The skill should define dependency and reconciliation rules clearly enough that an agent can identify this set without reading or rewriting every artifact. Dependents should record forward references to their canonical sources. Agents should discover reverse relationships by searching those stable identifiers, paths, and headings rather than maintaining stale backlink lists.

## Fallback feature organization

When no repository convention exists, feature artifacts should be colocated:

```text
specs/
├── constitution.md
└── 001-short-feature-name/
    ├── spec.md
    ├── plan.md
    ├── tasks.md
    ├── checklists/
    ├── research.md
    ├── data-model.md
    ├── quickstart.md
    └── contracts/
```

`spec.md`, `plan.md`, and `tasks.md` are the standard feature artifacts, not mandatory ceremony. Create only the artifacts the work needs. Especially small work may omit a separate specification, plan, or task list when another established artifact clearly owns the necessary information and traceability remains sufficient for responsible execution. Optional supporting artifacts must be created only when separating their contents improves ownership, comprehension, reuse, or verification.

## Deterministic fallbacks

Fallback conventions should make agent output predictable through:

- Stable artifact names and locations.
- Standard section ordering.
- Stable identifier patterns.
- Explicit normative requirement language.
- Defined lifecycle states where lifecycle affects use.
- Observable readiness criteria.
- Templates for artifacts whose structure is sufficiently stable.

Determinism must not become ceremony. Artifacts created from templates should omit optional sections and phases that do not add information, and the documentation set should not be more complex than the work requires.

## Traceability

Stable identifiers must be assigned to entities referenced across artifacts, such as project principles, user stories, requirements, success criteria, tasks, and ADRs.

Identifiers must remain stable when content is reordered or reworded without changing identity. Retired identifiers must not be reused.

The skill should avoid assigning identifiers to content that is not referenced outside its owner.

## Domain knowledge

The skill owns both the organization and active maintenance of domain context. It must instruct agents to:

- Challenge conflicting or overloaded terminology.
- Test concepts with concrete and edge-case scenarios.
- Distinguish neighboring concepts and context ownership.
- Compare the proposed domain model with code and existing documentation.
- Record resolved terminology promptly in its canonical context.
- Keep implementation details, requirements, and technical decisions out of domain glossaries.

Consequential domain-boundary decisions may warrant an ADR; terminology alone does not.

## Skill boundaries

The skill must define:

- Artifact roles and ownership.
- Recommended organization and formats.
- Traceability and lifecycle conventions.
- Readiness criteria.
- Documentation reconciliation rules.
- Domain-context discovery and maintenance.

The skill must not prescribe:

- Approval gates or development phase transitions.
- A universal repository layout when clear conventions already exist.
- Empty artifacts created only to satisfy a template.

The skill may define lifecycle states, their meanings, and the readiness conditions for using an artifact. It must not decide who approves a transition, require an approval pause, or infer that approval has been delegated. The active workflow, repository governance, or user's explicit request owns those decisions.

Workflow-specific instructions belong to the user or in other workflow skills. Repository-specific facts belong in repository documentation.

## Runtime guidance and design rationale

Runtime skill files should contain instructions that change agent behavior.

Historical rationale, rejected alternatives, ownership explanations, and statements about what the skill is trying to accomplish belong in this document unless an agent needs them to perform a task correctly.

## Evaluating changes

Before changing the skill, determine:

1. Which desired outcome the change advances.
2. Whether it preserves independent use outside a specific workflow.
3. Whether it creates duplicate ownership or overlapping instructions.
4. Whether the instruction produces observable agent behavior.
5. Whether the rule belongs in runtime guidance or this design document.
6. Whether templates, references, and examples remain consistent.
7. Whether structure or validation could enforce the result instead of additional prose.

A change is complete when the runtime skill remains internally consistent, independently usable, and aligned with this specification.

## Sources

This specification refines the [AI-assisted development specification](../spec.md) and is constrained by [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior) of the project constitution.
