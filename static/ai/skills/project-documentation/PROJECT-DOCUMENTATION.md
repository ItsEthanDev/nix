# Project Documentation

## README

`README.md` is the entry point for a person trying to understand or use the repository. It owns orientation and navigation, not every project fact.

Include, when applicable and in this order:

1. Project name and a concise statement of purpose.
2. Current capabilities and intended audience.
3. Prerequisites and the shortest verified setup path.
4. Common usage, development, test, build, and deployment commands.
5. A concise repository map.
6. Links to canonical governance, architecture, domain context, specifications, and contribution guidance.
7. Known support or operational boundaries needed for correct use.

Link to detailed canonical owners rather than copying their contents. Do not put agent-only operating instructions, feature requirements, task progress, or transient implementation plans in the README.

A README is ready when a new reader can identify the project's purpose, find detailed documentation, and execute the documented common path using verified commands.

## Project governance

Project governance owns durable rules that constrain independently designed future work. A rule belongs here when it:

- is expected to constrain work beyond one feature;
- requires project-level authority to change;
- remains meaningful if the current implementation is replaced; and
- defines an invariant or decision boundary rather than merely an implementation mechanism.

A durable security, compliance, or subsystem rule may govern only a narrow class of work. Current implementation does not become policy merely because it exists.

Route other information to its owner:

| Information | Owner |
| --- | --- |
| Observable behavior, metric, threshold, timing, or placement for one feature | Feature specification |
| Library, vendor, deployment mechanism, or technical design | Plan, or ADR for durable consequential rationale |
| Execution order or progress | Task list |
| Verified current behavior not accepted as policy | Code, tests, or current-state documentation |
| Agent-specific operating behavior | Agent instructions |

Use existing security policies, engineering principles, architecture documentation, or other governance owners when present. Create `specs/constitution.md` only when the project needs one consolidated governance owner and no suitable owner exists.

### Constitution format

Start from [templates/constitution.md](templates/constitution.md). Each principle must have:

- A stable `PR-###` identifier.
- A concise name.
- An actionable normative rule.
- A compliance signal that later work can demonstrate.
- Rationale only when it prevents likely misinterpretation.

Keep feature acceptance scenarios, feature-specific thresholds, source paths, tools, and implementation mechanics downstream unless they are themselves accepted project policy. Amend governance deliberately; do not weaken it in a feature plan to make a violation pass.

A constitution is ready when every principle is actionable, has one canonical owner and compliance signal, is distinguishable from current implementation and feature behavior, and has no unresolved conflict with other governance.

## Agent instructions

Agent instruction files own repository-specific operating constraints for coding agents: commands to run, paths to inspect, edit restrictions, local conventions, and verification expectations. Human-facing project facts belong in human documentation and should be linked rather than duplicated.

Agent instructions are ready when their scope is explicit, commands and paths are verified, rules are concrete enough to alter behavior, and no instruction conflicts with a higher-precedence owner.
