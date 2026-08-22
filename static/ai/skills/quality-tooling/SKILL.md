---
name: quality-tooling
description: Establish or improve project-local linting and formatting. Use when scaffolding a project, adding or auditing quality tooling, repairing drifting lint or format configuration, or turning recurring preventable corrections into automated checks.
---

# Quality Tooling

Turn durable code-quality standards into commands that agents and people can run. Prefer the smallest coherent toolchain that catches demonstrated problems, produces deterministic output, and fits the project already in front of you.

This skill owns linting and formatting setup. Existing project instructions own policy. Existing scripts, configuration, lockfiles, and CI reveal current implementation but do not silently override documented intent.

During an unrelated implementation task, run the project's existing checks. Introduce or replace project-wide tooling only when the user requests it, project setup includes it, or repeated corrections demonstrate that an automated guardrail is warranted. Keep baseline cleanup separate from an unrelated change.

## References

- Read [linting.md](linting.md) when selecting a linter, choosing rules, triaging findings, or designing exceptions.
- Read [formatting.md](formatting.md) when selecting a formatter, defining its scope, or adding check and write commands.
- Read [oxlint.md](oxlint.md) only when Oxlint is installed, requested, or selected for a JavaScript or TypeScript project.

Read both general references when establishing a complete quality baseline. Load a tool-specific reference only after selecting that tool.

## Process

1. **Establish scope.** Read applicable project instructions, manifests, lockfiles, existing scripts, lint and format configuration, ignore files, editor settings, and relevant CI. Identify the languages, runtimes, generated files, and files changed by the current task. Complete this step when the existing toolchain, project conventions, and requested scope are explicit.

2. **Choose the smallest coherent toolchain.** Preserve an existing supported tool unless replacement solves a concrete problem. Select one owner for lint policy and one owner for deterministic formatting; use one tool for both when it handles both jobs well. Complete this step when each selected tool has a distinct responsibility and every replacement or overlap has a stated reason.

3. **Define policy from evidence.** Read the applicable references. Start with high-confidence correctness checks and the project's established format. Add restrictions only for confirmed architecture or recurring failure modes. Complete this step when every non-default rule or formatter option traces to a project requirement, demonstrated defect, compatibility constraint, or established convention.

4. **Expose repeatable commands.** Follow existing command names and package-manager conventions. Otherwise provide clear check and write commands for linting and formatting. Keep local and automated environments on the same underlying commands. Complete this step when a fresh contributor or agent can discover and run each command without reconstructing tool arguments.

5. **Triage the baseline.** Run check mode before broad automatic fixes. Group findings by rule or cause and distinguish configuration failures, real defects, useful warnings, existing debt, generated files, and false positives. Complete this step when every finding category has an explicit disposition and unrelated cleanup remains outside the tooling change.

6. **Verify the real workflow.** Run each configured command. Exercise representative source, test, generated, ignored, and overridden files. For formatting, inspect the write-mode diff, run write mode a second time, and confirm check mode passes. Complete this step when commands exit as intended, exclusions are narrow, and a second formatting pass makes no changes.

7. **Report the result.** Name the selected tools, commands, policy choices, exceptions, validation evidence, and remaining baseline findings. Complete this step when the report distinguishes a clean configuration from a clean codebase and makes unresolved debt visible.

## Guardrails

- Preserve one source of truth for each check. Avoid duplicate lint rules, formatter overlap, and wrapper commands that only rename another command without adding policy.
- Keep correctness separate from style. Let the formatter own whitespace and layout; let the linter own defects, unsafe constructs, and enforceable project policy.
- Prefer narrow file overrides and actionable diagnostics over global disables.
- Ignore generated or vendored files rather than changing them or weakening policy for maintained source.
- Keep advisory rules non-blocking until the project intentionally adopts them as required policy.
- Treat hooks and CI as delivery integrations, not prerequisites for useful local commands. Add or change them only within the requested scope and existing repository conventions.
- Inspect semantic changes from automatic fixes and sorting. Deterministic does not mean semantics-preserving.

The setup is complete when the commands are discoverable and rerunnable, their scope matches the project, formatting is idempotent, and the report accurately states all remaining failures.
