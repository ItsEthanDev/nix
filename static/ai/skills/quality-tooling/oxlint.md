# Oxlint

Use this reference after selecting Oxlint for a JavaScript or TypeScript project. Let the installed version, project stack, and current Oxlint documentation determine supported configuration instead of copying a static rule catalog.

## Establish compatibility

Inspect before editing:

- The package manager, lockfile, workspace layout, and installed Oxlint version.
- Existing Oxlint, ESLint, Biome, formatter, TypeScript, and editor configuration.
- Source languages, module format, runtimes, frameworks, JSX transform, and test runners.
- Generated files, registry-managed source, build output, and vendored paths.
- Path aliases, import spellings, and documented architecture.
- Existing lint, fix, type-check, and CI commands.

Consult the installed CLI and package types first. Use the current official documentation for details the installation cannot answer:

- Rules: https://oxc.rs/docs/guide/usage/linter/rules.md
- Configuration: https://oxc.rs/docs/guide/usage/linter/config.md
- Plugins: https://oxc.rs/docs/guide/usage/linter/plugins.md
- Type-aware linting: https://oxc.rs/docs/guide/usage/linter/type-aware.md
- CI and integrations: https://oxc.rs/docs/guide/usage/linter/ci.md

The online rule table may describe a newer release. Confirm every uncertain rule, option, category, plugin, and CLI flag against the installed version.

## Install and configure

Add `oxlint` through the project's existing dependency mechanism. Add `oxlint-tsgolint` only when selected type-aware rules require it and its TypeScript compatibility has been verified.

Preserve a supported existing configuration format. For a new configuration, choose a format supported by the installed version and project runtime. Use a typed configuration only when the project can execute it reliably; typed syntax is not a reason to add another runtime requirement.

Follow existing command names. Otherwise provide a check command and, when useful fixes are enabled, a fix command. Keep tool arguments in canonical project scripts or tasks so local use and automation share one policy.

## Enable only relevant plugins

Oxlint plugins determine which rule families are available. Setting an explicit plugin list can replace defaults, so verify effective configuration rather than assuming it extends them.

Select plugins from observed project capabilities:

- TypeScript for TypeScript source.
- React and JSX accessibility for applicable user interfaces.
- The actual test-runner plugin for test files.
- Node rules only for files that run in Node-compatible environments.
- Import, promise, and other rule families only when their checks add value beyond enabled language and type-aware rules.

An individual rule from a plugin still requires that plugin to be available and enabled as required by the installed release.

## Choose categories and rules

Use [linting.md](linting.md) for the policy hierarchy. A defensible initial posture is to make high-confidence correctness failures blocking and introduce suspicious, experimental, performance, complexity, and deprecation diagnostics as warnings while evaluating the baseline.

Prefer rules that catch concrete failures:

- Invalid or unreachable code.
- Mishandled promises and async callbacks.
- Unsafe operations at typed boundaries.
- Non-exhaustive variants when the type model supports exhaustiveness.
- Invalid hooks, JSX, keys, or test assertions for frameworks actually in use.
- Abusive or unused suppression directives.

Treat annotation requirements, naming preferences, complexity thresholds, explicit return types, and other restriction or style rules as project policy. Add them only with evidence. Let the formatter own layout.

Type-aware linting can expose valuable unsafe assignments, calls, members, arguments, returns, assertions, unnecessary conditions, and promise mistakes. Enable it only after verifying compatibility and measuring its cost on the real repository. Start noisy or heuristic rules as warnings and inspect representative findings before making them blocking.

## Adapt to framework behavior

Static rules sometimes cannot see behavior supplied by a framework or composition abstraction. Verify the runtime or framework contract before adding an exception. Common branches include:

- Automatic JSX transforms that do not require a `React` binding.
- Route modules or hot-reload conventions that require mixed exports.
- Framework control flow that throws documented non-`Error` values or promises.
- Polymorphic component primitives that forward rendered tags, content, or accessibility semantics.
- Runtime-specific import protocols and globals.

Scope a confirmed exception to the smallest affected files and rules. Keep the rule elsewhere. Fix the code when inspection reveals a real defect rather than a limitation of static analysis.

## Treat tests and generated files deliberately

Ignore generated output instead of fixing it or weakening source policy. Use narrow overrides for managed files that people still edit.

Tests can relax incidental restrictions that make fixtures or local harnesses harder to read, but they should retain checks for:

- Focused or skipped tests that must not ship.
- Invalid assertions and duplicate titles.
- Unhandled promises and async test mistakes.
- Architecture boundaries that test support must respect.

Enable the actual test environment and plugin. Base exceptions on repeated findings in representative tests rather than a generic test override copied from another repository.

## Add architecture checks only after confirmation

Use import restrictions when the project has documented or observable dependency direction. Cover aliases and relative imports, include an actionable allowed-direction message, and test both accepted and rejected examples.

Use a dependency graph tool when the policy depends on transitive relationships, package boundaries, or cycles too complex for import-specifier rules.

## Integrate formatting separately

Oxlint owns lint policy. Read [formatting.md](formatting.md) before selecting Oxfmt or another formatter. Preserve an existing coherent formatter unless migration solves a concrete problem. Verify import and manifest sorting as potentially semantic transforms.

## Validate

1. Run the canonical Oxlint check and confirm the configuration parses.
2. Confirm each non-default plugin is active and a representative rule executes.
3. Inspect effective configuration for representative source, test, framework, and override files using `--print-config` or the installed version's equivalent when available.
4. Confirm generated files are ignored and maintained source is included.
5. Exercise architecture restrictions against intended and prohibited imports when configured.
6. Measure timings when type-aware or multi-file rules make feedback unexpectedly slow.
7. Group remaining diagnostics by rule and distinguish code findings from configuration failures.

The Oxlint branch is complete when the canonical command behaves correctly, effective configuration matches representative files, exceptions are narrow, and all remaining diagnostics are reported without claiming a clean codebase.
