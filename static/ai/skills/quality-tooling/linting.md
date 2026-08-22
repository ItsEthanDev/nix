# Linting

Use linting to encode high-confidence correctness checks and demonstrated project policy. A useful linter reduces review burden without forcing code into shapes that are harder to understand or maintain.

## Select the linter

Preserve an existing linter when it is supported, integrated, and capable of enforcing the required policy. Select a new linter using evidence from the project:

- It supports the project's languages, syntax, runtime, and frameworks.
- It understands the type information required by the desired checks.
- It can represent necessary file scopes and narrow exceptions.
- It runs fast enough for the intended local and automated workflows.
- Its diagnostics are actionable and stable enough for the selected severity.
- The project can install and update it through its existing dependency mechanism.

Add a second linter only when it owns a distinct set of valuable checks that the first cannot provide. State that division explicitly so future maintainers know which tool owns each policy.

## Select rules from evidence

Apply rules in descending confidence:

1. **Language and runtime correctness.** Invalid control flow, unreachable code, unsafe promise handling, impossible comparisons, invalid framework usage, and similar defects can normally block changes.
2. **Security and boundary safety.** Enable checks that match the project's actual inputs, outputs, runtimes, and dangerous sinks.
3. **Type-aware correctness.** Use when the linter and installed language version are compatible and the added runtime cost fits the workflow.
4. **Confirmed project policy.** Dependency direction, banned APIs, naming required by external systems, and similar rules need a documented or observable basis.
5. **Refactoring signals.** Complexity, deprecations, suspicious patterns, and experimental diagnostics normally begin as warnings.
6. **Subjective style.** Leave layout to the formatter. Adopt other stylistic restrictions only when the team has chosen them and the rule improves consistency without encouraging artificial abstractions.

A large baseline does not by itself invalidate a valuable rule. Classify the findings before changing severity. A noisy rule with frequent legitimate exceptions is a weaker guardrail than a narrow rule agents can trust.

## Avoid metric-driven damage

Treat size and complexity metrics as signals rather than architecture. Global limits on function length, parameter count, nesting, file length, or callback count can cause agents to split cohesive logic into pass-through modules and move context away from its use.

Adopt a metric rule when a recurring problem demonstrates its value. Begin with a warning, inspect representative findings, and scope exceptions for declarative code, generated code, and tests where the metric measures the wrong thing.

## Encode architecture only when confirmed

Import restrictions can preserve dependency direction, but directory names alone do not establish architecture. Confirm intended layers from project documentation, package relationships, existing imports, and composition roots.

When adding a boundary rule:

- Cover every supported alias and relative spelling that can cross the boundary.
- State the allowed direction in the diagnostic message.
- Test both a forbidden import and an intended import.
- Use a dependency graph tool when transitive or package-level constraints exceed the linter's model.

The rule is complete when it rejects the prohibited dependency and accepts representative intended dependencies.

## Scope exceptions narrowly

An exception should name the smallest file set and the specific rule whose model does not fit that code. Common valid branches include:

- Generated and vendored files, which normally belong in ignore configuration.
- Framework entry points with required exports or control-flow values.
- Primitive wrappers whose rendered semantics are invisible to static analysis.
- Tests that need looser fixture typing or local helpers while retaining assertion, promise, and focused-test correctness.
- Configuration and scripts that run under a different runtime from application code.

Inspect the behavior before adding the exception. Keep the diagnostic when it identifies a real defect in the abstraction rather than a limitation of the linter.

## Triage the baseline

Group findings by rule or common cause and assign each group one disposition:

| Finding | Disposition |
| --- | --- |
| Real defect or unsafe behavior | Keep the rule and fix within the agreed scope. |
| Valuable rule exposing existing debt | Keep it; document a staged rollout or leave visible findings. |
| Useful but heuristic signal | Keep as a non-blocking warning. |
| Framework-required pattern | Add the narrowest verified override. |
| Generated or vendored content | Exclude the owned path. |
| Test ceremony without meaningful safety | Relax only for the affected test files. |
| Formatter duplication or subjective preference | Let the formatter or project convention own it. |
| Unsupported rule or option | Remove it and identify a supported alternative if needed. |

Review automatic fixes before accepting them. Apply fixes in small groups when a rule can change runtime behavior, imports, coercion, promise handling, or control flow.

## Expose and integrate commands

Use the project's existing script and task conventions. A complete local interface normally provides:

- A check command that changes no files and returns a meaningful status.
- A fix command only when the linter has reviewed, useful fixes.
- A way to inspect effective configuration for representative files when the tool supports it.

Automated hooks and CI should invoke the same check command rather than duplicate its arguments. Keep expensive checks at the layer where their feedback time is acceptable. Commit hooks should remain fast and predictable; comprehensive checks can run in CI when that matches project policy.

## Completion checklist

- Does each enabled rule have an appropriate confidence and severity?
- Does every project-specific restriction trace to evidence?
- Do representative source, test, generated, ignored, and overridden files receive the intended configuration?
- Do exceptions preserve useful checks outside their narrow scope?
- Does check mode return success and failure correctly without changing files?
- Are automatic fixes reviewed for semantic changes?
- Are remaining findings grouped and reported without claiming a clean codebase?
