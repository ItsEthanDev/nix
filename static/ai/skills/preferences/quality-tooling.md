# Quality Tooling

When establishing JavaScript or TypeScript quality tooling without an existing coherent toolchain:

- Prefer Oxlint for linting.
- Prefer Oxfmt for formatting.
- Keep linting and formatting responsibilities distinct even when both tools come from the same project.

Read the `quality-tooling` skill before configuring these tools. It owns compatibility inspection, policy design, baseline triage, command integration, and verification. Preserve an existing coherent toolchain unless replacement is explicitly requested or solves a demonstrated problem within the task's scope.

Do not invent or copy a supposedly preferred configuration. Add Ethan's exact Oxlint and Oxfmt configurations to this reference once their desired contents, merge behavior, compatibility constraints, and verification commands are known.
