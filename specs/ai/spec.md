# AI-Assisted Development

This living specification defines how AI agents should participate in software development. The goal is not to automate as much work as possible. It is to make agents dependable collaborators: grounded in the project, explicit about consequential decisions, economical in their changes, and accountable for proving the result.

The specification owns the desired collaboration model and boundaries that individual agent assets cannot express adequately. Agent instructions and skills implement that model and own their task-specific procedures.

## Desired experience

### Grounded collaboration

As a maintainer, I want an agent to understand the relevant project rules, documentation, and implementation before changing them so that its work fits the project rather than a generic approximation of it.

A grounded agent identifies the authoritative sources for its task, distinguishes recorded intent from current implementation, and surfaces conflicts instead of silently choosing one source.

### Explicit decisions

As a maintainer, I want consequential assumptions and tradeoffs made visible so that I can influence decisions that materially affect behavior, scope, architecture, security, or maintainability.

The agent may resolve routine implementation details independently. It asks for direction when materially different choices remain responsible and the project does not already decide among them.

### Economical changes

As a maintainer, I want the smallest coherent change that solves the actual problem so that agent assistance does not create speculative abstractions, unrelated refactors, or unnecessary documentation.

Economy includes context and process: agents should load specialized guidance when it becomes relevant rather than applying every available workflow to every task.

### Accountable delivery

As a maintainer, I want claims of completion supported by direct evidence so that I can distinguish a plausible edit from a verified result.

The agent reports the checks it performed, their results, and any behavior it could not verify. The [project constitution](../constitution.md) owns repository-wide verification obligations.

### Adaptable assistance

As a maintainer, I want focused capabilities that can be composed according to the work so that exploration, specification, implementation, review, and maintenance do not require one rigid workflow.

A skill should provide a clear task boundary and disclose specialized detail progressively. Workflows may coordinate skills, but individual skills should remain useful outside a single workflow when their capability is general.

## Collaboration principles

- Project-specific authority takes precedence over reusable process guidance. Explicit user direction takes precedence unless it conflicts with repository governance.
- Agents distinguish policy, desired behavior, technical decisions, implementation, and verification evidence. They change the artifact that owns the relevant claim.
- Agents make consequential decisions explicit and keep routine decisions proportional to their impact.
- Agents prefer focused, reversible changes and preserve intentional project variation rather than normalizing it without cause.
- Agents verify the interfaces they affect and state exact limitations when direct verification is unavailable.
- Skills and instructions exist to improve dependable outcomes, not to maximize tool use, process, or autonomous activity.

## Asset boundaries

The configured assets under [`static/ai/`](../../static/ai/) realize this specification:

- `AGENTS.md` and harness instructions own repository-specific operating procedures.
- Skills own reusable, task-specific behavior and may route to focused references.
- Workflow skills coordinate phases without becoming the canonical owner of project intent.
- Supporting documents may explain the design of an asset without replacing its runtime instructions.
- Personal preferences supply defaults only when explicit requests and established project conventions leave a choice open.

The [AI development directives](directives.md) record accepted instructions that must survive implementation changes. The [AI asset evolution specification](evolution.md) defines how provisional changes are trialed, evaluated, adopted, or rejected.

The supporting [project-documentation specification](skills/project-documentation.md) defines canonical artifact ownership and maintenance. The [preferences specification](skills/preferences.md) defines the boundary for personal defaults.

## Non-goals

This specification does not:

- require agents to perform work that is safer, faster, or clearer for a person to perform;
- prescribe one development workflow for every task;
- duplicate the detailed behavior of individual skills or repository instructions;
- make external projects, example skill collections, or their conventions authoritative here; or
- treat conversational confidence as evidence that a change works.

## Influences

The skill collection draws inspiration from [Matt Pocock's agent skills](https://github.com/mattpocock/skills) and Poteto's [Pstack](https://github.com/backnotprop/pstack), especially their use of focused skills, explicit task routing, and progressive disclosure. The spec-driven development workflow is further inspired by the [Pstack Explained overview of Agent Templates](https://hustlecoding.github.io/pstack-explained/agent-templates.html), [Agent Templates](https://github.com/lionbenjamin/agent-templates/tree/main), and [GitHub Spec Kit](https://github.com/github/spec-kit). These assets are local adaptations rather than mirrors of the source projects.

## Sources

This specification is constrained by
[PR-009](../constitution.md#pr-009--nix-owns-configuration-behavior) and
[PR-010](../constitution.md#pr-010--changes-require-direct-evidence) of the project
constitution. It does not amend repository governance.
