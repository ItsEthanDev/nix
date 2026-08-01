---
name: oxlint
description: Adaptive Oxlint setup and rule selection for JavaScript and TypeScript projects. Use when adding, auditing, or updating oxlint, oxlint.config.ts, plugins, categories, type-aware linting, test overrides, framework exceptions, or architectural import boundaries.
---

# Oxlint Project Setup

Configure Oxlint for the project in front of you. Produce a consistent quality baseline across projects without copying a blanket configuration or forcing code to satisfy rules that do not understand its framework.

This skill primarily covers Oxlint. After Oxlint is configured, recommend Oxfmt and ask whether the user wants automatic formatting set up as well. Do not create or change formatter configuration until the user agrees.

## Outcomes

An effective configuration should:

- Make AI-generated code easier for people to read and review.
- Detect bugs, unsafe assumptions, and missed promise handling.
- Expose useful refactoring opportunities without forcing arbitrary decomposition.
- Preserve dependency direction and keep architectural layers decoupled.
- Reinforce current language and framework best practices.
- Apply lighter restrictions to tests while retaining test correctness checks.
- Explain every project-specific exception narrowly enough that it cannot hide unrelated problems.

The number of initial findings is not a reason to reject a valuable rule. A large baseline can represent real debt. Classify the findings before changing the policy.

## Sources Of Truth

Consult the installed Oxlint version and current official documentation before writing rule names or options:

- Rules: https://oxc.rs/docs/guide/usage/linter/rules.md
- Configuration: https://oxc.rs/docs/guide/usage/linter/config.md
- Plugins: https://oxc.rs/docs/guide/usage/linter/plugins.md
- Type-aware linting: https://oxc.rs/docs/guide/usage/linter/type-aware.md
- CI and integrations: https://oxc.rs/docs/guide/usage/linter/ci.md
- Configuration reference: https://oxc.rs/docs/guide/usage/linter/config-file-reference.md
- Oxfmt configuration: https://oxc.rs/docs/guide/usage/formatter/config.md
- Oxfmt configuration reference: https://oxc.rs/docs/guide/usage/formatter/config-file-reference.md
- Oxfmt sorting: https://oxc.rs/docs/guide/usage/formatter/sorting.md

The online rules table may describe rules newer than the installed package. Verify uncertain rules against the installed CLI or package types. Do not configure an ESLint ecosystem rule merely because ESLint implements it; Oxlint must implement it too.

## Required Investigation

Inspect the project before selecting rules:

1. Read package manifests, lockfiles, existing lint configuration, TypeScript configuration, and project instructions.
2. Identify the package manager and existing `lint` and `lint:fix` script conventions.
3. Identify languages, runtimes, frameworks, JSX transform, test runner, generated files, and supported deployment targets.
4. Identify path aliases and actual import spellings.
5. Map source directories into composition roots, features, reusable UI, shared/domain code, backend code, generated code, and testing support.
6. Search for framework conventions that conflict with otherwise useful rules.
7. Run the existing linter before editing when possible and group findings by rule.

Do not infer architecture from directory names alone. Confirm direction from project documentation and existing imports. If the intended dependency direction remains ambiguous, ask one focused question before enforcing it.

## Installation And Configuration

Prefer `oxlint.config.ts` with `defineConfig` when the project's runtime supports TypeScript configuration files:

```ts
import { defineConfig } from "oxlint";

export default defineConfig({
  // Adapt this object to the project.
});
```

Add `oxlint` as a development dependency using the project's package manager. Add `oxlint-tsgolint` only when enabling type-aware linting, and verify its current TypeScript compatibility in the official documentation.

Use the project's script style. Typical scripts are:

```json
{
  "lint": "oxlint",
  "lint:fix": "oxlint --fix"
}
```

Pin or deliberately manage Oxlint upgrades when stable CI output is important. Oxlint may add rules or improve diagnostics in non-major releases, and type-aware linting has separate compatibility considerations.

## Repository Hosting Workflow

After Oxlint is configured and its local command has been validated, ask the user whether they want an automatic lint workflow on their preferred repository hosting platform. Do not create or modify CI configuration until the user agrees.

Detect the repository host and existing CI conventions when possible. If the preferred host is unclear, ask which platform to target, such as GitHub, GitLab, Bitbucket, or Azure DevOps.

Before implementing the workflow, read the current official Oxlint CI documentation at https://oxc.rs/docs/guide/usage/linter/ci.md. Treat it as the baseline, then adapt it to the project rather than copying an example verbatim.

Inspect and preserve:

- The project's package manager, lockfile, runtime version, and immutable-install command.
- Existing workflow files, job naming, triggers, caching, concurrency, permissions, and security conventions.
- The existing lint script and whether type-aware linting requires `oxlint-tsgolint`.
- The repository's default and protected branches.
- The team's decision about whether warnings are advisory or build-blocking.
- Host-specific annotations or code-quality report formats.

For GitHub Actions, normally run lint for pull requests and pushes to the protected default branch, use least-privilege permissions, disable persisted checkout credentials when they are unnecessary, and follow the repository's action-pinning policy. Oxlint automatically emits GitHub annotations in GitHub Actions unless another formatter is selected.

For GitLab, offer either a normal failing lint job or the official `--format=gitlab` Code Quality artifact integration. Adapt artifact paths and stages to the existing pipeline.

For platforms not covered by Oxlint's examples, apply the same principles using that platform's official workflow syntax. Do not introduce a second CI system when the repository already uses one.

Use the project's existing `lint` script in CI so local and automated behavior remain aligned. Do not silently add `--deny-warnings`, change severities, or run automatic fixes in a validation workflow. Verify the workflow syntax and run the underlying lint command locally when possible.

## Optional Automatic Formatting

After Oxlint is configured and validated, ask whether the user would also like automatic formatting configured with Oxfmt. Recommend accepting because a deterministic formatter removes low-value review discussion and makes AI-generated code easier to scan.

Do not assume that an existing Prettier, Biome, dprint, or framework formatter should be replaced. Inspect the current formatter, editor, hooks, CI, ignore files, and package scripts first. If another formatter owns the project, explain the migration or overlap and ask before replacing it.

When the user agrees:

1. Read the current official Oxfmt configuration and sorting documentation from the Sources Of Truth section.
2. Verify the installed Oxfmt version and supported configuration fields.
3. Prefer `oxfmt.config.ts` with `defineConfig` when the project runtime supports it; otherwise use a supported JSON configuration.
4. Preserve established quote, semicolon, indentation, and line-ending conventions unless the user requests a style migration.
5. Add or align `fmt` and `fmt:check` scripts using the project's package manager and script naming conventions.
6. Ignore generated output, vendored code, build artifacts, coverage, and agent-managed skill directories as appropriate.
7. Format the project, review the diff for semantic sorting risks, then run the check command.

Prioritize formatting decisions with substantial readability value:

- Use a `printWidth` near 100 for TypeScript and JSX unless the project has an established width. Narrow widths can create excessive vertical wrapping; unusually wide lines impair review.
- Enable `sortImports` when deterministic dependency grouping benefits the project. Confirm path aliases are recognized as internal imports and keep side-effect import sorting disabled unless execution order is proven irrelevant.
- Enable `sortTailwindcss` for Tailwind projects. Point Tailwind 4 projects at their canonical stylesheet, point Tailwind 3 projects at their config when discovery is insufficient, and include actual helper functions such as `cn`, `clsx`, `cva`, or `tw` only when the project uses them.
- Keep package manifest sorting enabled unless another tool owns manifest order. Sort scripts only when the team prefers alphabetical order over lifecycle grouping.
- Keep trailing commas in multiline structures and final newlines unless the existing project standard requires otherwise.

Avoid style churn with little readability value. Do not change quote style, semicolon style, arrow parentheses, bracket placement, or JSX attribute layout merely to express a preference. Avoid `singleAttributePerLine` by default because it makes JSX unnecessarily tall. Keep prose wrapping preserved unless documentation policy requires hard wrapping.

Adapt the formatter to the stack:

- Ignore generated TanStack route trees and other framework-generated files.
- Ignore Convex `_generated/**` output.
- Configure Tailwind sorting only when Tailwind is installed and its stylesheet or config can be identified.
- Enable Svelte formatting only when Svelte is installed, because Oxfmt requires the Svelte compiler at runtime.
- Use nested formatter configs only when packages intentionally require different conventions.

If the user also accepts repository-hosted automation, add the project's check-only formatting script to the existing validation workflow when appropriate. Do not run write-mode formatting or automatically commit formatting changes in CI unless the user explicitly requests that behavior.

## Plugins

List every plugin the project needs. Setting `plugins` replaces Oxlint's default plugin set rather than extending it.

Common TypeScript application plugins are:

```ts
plugins: ["eslint", "typescript", "unicorn", "oxc", "import"],
```

Add only plugins supported by the project:

| Project capability | Plugin |
| --- | --- |
| React | `react` |
| React accessibility | `jsx-a11y` |
| Vitest | `vitest` |
| Jest | `jest` |
| Node-specific code | `node` |
| Promise conventions not covered by type-aware TypeScript | `promise` |

Enabling an individual rule from a non-default plugin is not a substitute for enabling that plugin. Categories only activate rules from enabled plugins.

## Categories

Use this default posture:

```ts
categories: {
  correctness: "error",
  suspicious: "warn",
},
```

Category guidance:

| Category | Default posture | Reason |
| --- | --- | --- |
| `correctness` | Error | High-confidence bugs and useless code should block changes. |
| `suspicious` | Warning initially | Likely problems are useful signals, but framework and library patterns can expose false positives. |
| `pedantic` | Select rules individually | The category intentionally permits false positives. |
| `perf` | Select rules individually | Avoid speculative micro-optimization and framework-obsolete advice. |
| `restriction` | Select rules individually | These rules encode project policy rather than universal correctness. |
| `style` | Select rules individually | Include readability conventions, but leave formatting to a formatter. |
| `nursery` | Select rules as warnings | Rules under development may change or contain rough edges. |

Do not repeat a category-enabled rule at the same severity with default options unless the explicit entry documents an important policy. Individual rules should normally represent a severity promotion, custom option, or exception.

## General Rule Baseline

Select from this baseline after checking support and project applicability.

### Readability And Refactoring Signals

| Rule | Suggested severity | Guidance |
| --- | --- | --- |
| `curly` | Error | Braces make generated control flow safer to edit and easier to review. |
| `eqeqeq` | Error | Avoid coercion bugs. Use narrowly documented exceptions only when loose equality is intentional. |
| `prefer-const` | Error | Communicates mutation intent. |
| `no-shadow` | Error | Reduces ambiguity for readers and AI edits. Relax in tests only if fixture scopes make it noisy. |
| `complexity` | Warning, commonly 15 | Highlights refactoring candidates without making a heuristic a hard architectural boundary. |

Avoid global `max-lines`, `max-lines-per-function`, `max-depth`, `max-params`, and `max-nested-callbacks` by default. They often make AI split cohesive code, create pass-through abstractions, or move test context away from assertions. Add one only when the project has a demonstrated recurring problem, keep it a warning initially, and relax it for declarative UI and tests.

### Imports And Modules

Use these when the import plugin supports the project's resolver and module format:

```ts
"import/no-cycle": "error",
"import/no-duplicates": "error",
"import/no-mutable-exports": "error",
"import/no-self-import": "error",
```

Do not impose a shallow `maxDepth` on `import/no-cycle` unless measured performance requires it. A depth cap allows longer cycles to escape detection.

Use `no-restricted-imports` to enforce dependency direction. See Architecture Boundaries below.

### TypeScript

When type-aware linting is compatible and installed, prefer concrete safety rules over annotation-heavy rules:

```ts
options: {
  typeAware: true,
  reportUnusedDisableDirectives: "error",
},
```

High-value rules commonly include:

```ts
"typescript/no-misused-promises": "error",
"typescript/no-unnecessary-type-assertion": "error",
"typescript/no-unsafe-argument": "error",
"typescript/no-unsafe-assignment": "error",
"typescript/no-unsafe-call": "error",
"typescript/no-unsafe-member-access": "error",
"typescript/no-unsafe-return": "error",
"typescript/only-throw-error": "error",
"typescript/switch-exhaustiveness-check": "error",
```

Useful warning-level rules commonly include:

```ts
"typescript/no-deprecated": "warn",
"typescript/no-explicit-any": "warn",
"typescript/no-unnecessary-condition": "warn",
"typescript/prefer-nullish-coalescing": "warn",
"typescript/prefer-optional-chain": "warn",
```

Use consistent type imports and exports when the project uses ESM and `verbatimModuleSyntax` or otherwise benefits from explicit runtime boundaries:

```ts
"typescript/consistent-type-exports": "error",
"typescript/consistent-type-imports": [
  "error",
  { prefer: "type-imports", fixStyle: "inline-type-imports" },
],
```

Do not enable explicit return-type or explicit module-boundary annotation rules by default. Type inference is usually clearer and lower maintenance. Add them only when public API declaration quality or isolated declaration generation creates a concrete need.

### React

For React projects, commonly use:

```ts
"react/button-has-type": "error",
"react/only-export-components": ["error", { allowConstantExport: true }],
"react/rules-of-hooks": "error",
"react/react-compiler": "warn",
```

Enable `react/react-compiler` only when the project uses or is evaluating compatible React Compiler behavior. Keep experimental compiler diagnostics at warning until the team has evaluated the baseline.

Use `react/only-export-components` when the development server relies on React Fast Refresh and source modules follow compatible export conventions. Scope or disable it for framework and component-library files that intentionally mix component and non-component exports.

Use React correctness category coverage for keys, invalid JSX, hook dependencies, and related defects rather than listing every correctness rule individually.

### Accessibility

React user interfaces should normally enable `jsx-a11y` and its correctness rules. Accessibility findings represent behavior, not cosmetic style.

Do not globally disable accessibility rules merely because reusable polymorphic components produce findings. First determine whether the linter cannot see props, rendered tags, children, or semantics passed through a composition API. Use file-specific overrides for confirmed wrapper false positives and retain checks in application UI.

### Unicorn

Useful broadly applicable rules include:

```ts
"unicorn/error-message": "error",
"unicorn/no-abusive-eslint-disable": "error",
"unicorn/throw-new-error": "error",
```

Use `unicorn/prefer-node-protocol` when the relevant files run in Node-compatible environments. Use `unicorn/prefer-structured-clone` only when all deployment targets support it and the suggested replacements preserve semantics.

Treat suspicious Unicorn findings such as immutable sorting and stable function scoping as review signals. Disable them narrowly where local test definitions or platform callback APIs are clearer.

## Framework And Convention Exceptions

Apply exceptions only when the stated condition is verified.

### Automatic React JSX Transform

Turn `react/react-in-jsx-scope` off when React 17+ uses the automatic JSX transform, such as TypeScript `jsx: "react-jsx"` or `"react-jsxdev"`, or Babel `runtime: "automatic"`.

The automatic transform imports from `react/jsx-runtime`; adding unused `React` imports would teach an obsolete convention and create noise.

### TanStack Router And TanStack Start

Turn `react/only-export-components` off for TanStack file-route modules when they export the framework-required `Route` value alongside route components. Do not split route files solely to satisfy Fast Refresh heuristics.

Consider turning `typescript/only-throw-error` off only in files that intentionally throw TanStack redirects, not-found results, or other documented control-flow values. Keep it enabled elsewhere.

Suspense tests may intentionally throw a promise. Prefer one documented inline exception or a narrow test-file override rather than disabling `typescript/only-throw-error` globally.

### Convex

Ignore generated Convex output, commonly `_generated/**`. Never fix generated files to satisfy lint.

Allow Convex system field names `_id` and `_creationTime` in `no-underscore-dangle`, or turn the rule off when underscore naming is otherwise not a team concern. These are external API fields, not pseudo-private application members.

Keep Convex backend code independent from frontend components, hooks, feature orchestration, and routes. It may depend on shared domain utilities that are runtime-compatible with Convex.

Type-aware rules can identify branded ID assertions and generic Convex test helpers as unsafe. Keep these diagnostics as warnings when they reveal a real boundary, but use narrow testing or adapter exceptions when the framework's types require an assertion that cannot be replaced by validation.

### Component Libraries And Polymorphic Rendering

Rules such as `jsx-a11y/anchor-has-content`, `click-events-have-key-events`, `label-has-associated-control`, `no-static-element-interactions`, and `prefer-tag-over-role` may not understand props and semantics forwarded through shadcn, Base UI, Radix, slot, `asChild`, or render-prop composition.

Inspect the rendered element and every call site before adding an exception. If content, `href`, keyboard behavior, `htmlFor`, or role semantics are supplied through the abstraction, disable only the affected rule for the primitive wrapper file. If the rendered output is actually inaccessible, fix the component instead.

Turn `react/only-export-components` off for generated or registry-managed component-library files that intentionally export components and variant helpers together. Do not require artificial file splitting that will drift from the upstream component convention.

### Node Protocol Imports

Use `unicorn/prefer-node-protocol` for Node, Bun, server, script, and configuration files when the runtime supports `node:` specifiers. Disable or scope it away from runtimes and bundlers that do not support them.

## Tests

Tests should have low incidental restrictions but strong correctness checks. Test code optimizes for clear setup, behavior, and assertions rather than production API purity.

Enable the actual test environment and plugin. Keep checks such as focused tests, valid assertions, valid titles, standalone assertions, and identical titles.

Reasonable test-only exceptions include:

```ts
{
  files: ["**/*.{test,spec}.{ts,tsx}"],
  env: { vitest: true },
  rules: {
    "typescript/no-unsafe-assignment": "off",
    "typescript/no-unsafe-argument": "off",
    "vitest/require-mock-type-parameters": "off",
  },
}
```

Adapt the environment and rules for Jest or another runner. Requiring generic type parameters on every mock can add more ceremony than safety when implementations and surrounding interfaces already provide useful inference.

Consider relaxing these only in tests when the baseline demonstrates repeated friction:

- `no-shadow` for nested fixture scopes.
- `unicorn/consistent-function-scoping` for scenario-local harness components and helpers.
- `unicorn/no-useless-undefined` when explicit resolved `undefined` makes mock behavior clearer.
- Type assertion warnings for DOM queries and branded fixture identifiers.

Do not turn off promise correctness, focused-test detection, invalid assertion detection, or architecture boundaries merely because files are tests.

## Architecture Boundaries

Use `no-restricted-imports` when the project has recognizable layers. Enforce only confirmed direction.

A common dependency direction is:

```text
routes or entry points -> feature modules -> reusable components and hooks -> shared or domain utilities
                                        -> backend client boundary

backend implementation -> shared or domain utilities
```

Typical constraints are:

- Shared or domain code must not import UI, features, routes, backend implementations, or test support.
- Reusable components must not import feature orchestration, routes, backend implementations, or test support.
- Backend implementation must not import frontend components, hooks, features, or routes.
- Feature modules must not import route entry points.
- Composition roots may depend inward on the layers they assemble.

Match every supported alias and relative parent spelling so an import cannot bypass the policy. Include an actionable message explaining the allowed direction.

Example shape, to be adapted rather than copied:

```ts
{
  files: ["src/shared/**/*.{ts,tsx}"],
  rules: {
    "no-restricted-imports": [
      "error",
      {
        patterns: [
          {
            regex: "^(?:(?:@|#)/|(?:\\.\\./)+)(?:components|backend|features|routes)(?:/|$)",
            message: "Shared code must not depend on higher application layers.",
          },
        ],
      },
    ],
  },
}
```

Do not use `import/no-relative-parent-imports` as a substitute for architecture. It bans syntax, not dependency direction, and aliases can bypass it.

Use a dependency graph tool when the project needs transitive boundaries, package-level constraints, cycle visualization, or dependency rules too complex for import-specifier patterns.

## Generated And Managed Files

Ignore generated files rather than weakening rules for the entire project. Common examples include route trees, API clients, schema output, build artifacts, coverage, and framework-generated declarations.

Use narrow overrides instead of ignores for registry-managed source that developers still intentionally edit. This preserves applicable correctness rules while disabling conventions the registry cannot satisfy.

## Baseline Triage

After enabling the candidate configuration, group findings by rule and classify each group:

| Classification | Action |
| --- | --- |
| Real bug or unsafe behavior | Keep the rule and fix the code. |
| Useful refactoring signal | Keep as warning and prioritize deliberately. |
| Existing debt with a valuable rule | Keep the rule; fix incrementally or use a temporary, documented rollout plan. |
| Framework-required convention | Add the narrowest file or pattern override. |
| Generated code | Ignore the generated path. |
| Test-only ceremony without meaningful safety | Relax only in test files. |
| Subjective preference or formatter duplication | Remove the rule. |
| Unsupported or invalid Oxlint rule | Remove it and identify an implemented alternative. |

Do not disable a rule solely because it reports many findings. Do not automatically fix dangerous suggestions or semantic transformations without reviewing the diff.

## Validation

Before completing setup:

1. Format the configuration with the project's existing formatter.
2. Run Oxlint and confirm the configuration parses.
3. Verify non-default plugins are enabled and their rules execute.
4. Verify each override applies to a representative file, using `--print-config` or an equivalent installed CLI facility when available.
5. Confirm generated files are ignored and source files are not accidentally excluded.
6. Confirm architecture rules cover aliases and relative imports without rejecting intended dependencies.
7. Run `oxlint --debug timings` when type-aware or multi-file rules make lint unexpectedly slow.
8. Report remaining errors and warnings by rule; distinguish existing code findings from configuration failures.

Warnings should remain non-blocking during evaluation. Enable warning denial only after the team intentionally decides every warning is CI-blocking and removes advisory or experimental noise.

## Completion Report

Summarize:

- Installed packages and scripts.
- Enabled plugins and categories.
- Important explicit rules and why they were selected.
- Framework, generated-code, and test exceptions with their rationale.
- Enforced architecture boundaries.
- Whether an automated repository-hosting lint workflow was offered, and the user's decision or implemented platform.
- Whether automatic Oxfmt setup was offered, and the user's decision or implemented formatter configuration.
- Validation commands and results.
- Remaining baseline findings that require code changes.

Do not claim the configuration is clean when lint still fails. Do not fix unrelated application findings unless the user asks for baseline cleanup.
