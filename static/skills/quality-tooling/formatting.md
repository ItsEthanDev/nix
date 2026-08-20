# Formatting

Use a formatter to make layout deterministic and remove low-value review decisions. Formatting should make code easier to scan without becoming a vehicle for unrelated style migration or semantic sorting.

## Select the formatter

Preserve an existing formatter when it supports the maintained file types and produces stable output. Select a new formatter using the project's languages, frameworks, package system, editor conventions, and generated-file boundaries.

Prefer one formatter for a file type. If several formatters are necessary, make their file ownership disjoint and visible in the commands or configuration. Avoid chains where one formatter immediately rewrites another formatter's output.

Use the formatter's defaults when the project has no established style. Add options only to preserve an existing convention, satisfy a compatibility constraint, or improve a demonstrated readability problem. Quote style, semicolons, indentation, bracket placement, and line width are project policy rather than universal correctness.

## Define scope

Format maintained source and the supported documentation and configuration files that the project wants standardized. Exclude files that another system owns:

- Generated source and declarations.
- Vendored dependencies.
- Build output, caches, coverage, and snapshots owned by another tool.
- Lockfiles or manifests whose ordering is owned by their package manager.
- Registry-managed source when local formatting would be overwritten.

Prefer the formatter's ignore mechanism and reuse established ignore files when supported. Verify that exclusions match only intended paths.

## Separate adoption from migration

Adding a formatter and reformatting an entire repository are distinct changes. Choose an adoption strategy explicitly:

- **Clean baseline:** format all owned files when repository-wide churn is acceptable and review it separately from behavioral changes.
- **Staged adoption:** check or format only an agreed scope while existing debt is migrated deliberately.
- **Changed-file workflow:** format files touched by current work when the tool and repository can define that scope consistently.

Do not hide a broad formatting migration inside a feature or bug fix. Preserve blame and reviewability by separating mechanical formatting from semantic edits when practical.

## Treat sorting as semantic

Import, export, object-key, class-name, manifest, and utility-class sorting can improve consistency, but not every order is cosmetic.

Before enabling sorting:

- Identify side-effect imports and order-sensitive registration.
- Confirm aliases and module groups are classified correctly.
- Check whether manifests or generated files have another ordering owner.
- Exercise framework-specific syntax and helper functions on representative files.
- Inspect the first full diff rather than assuming the transform preserves behavior.

Keep a sorting transform disabled when order can carry semantics and the tool cannot prove or preserve that order.

## Expose commands

Follow existing task names and package-manager conventions. Otherwise expose two clear operations:

- A write command that formats the intended files.
- A check command that reports drift without modifying files.

Editor integration, commit hooks, and CI should call or match these canonical operations rather than invent separate format policy. Add those integrations only when they fit the requested scope and repository conventions.

## Verify idempotence

1. Run check mode before write mode and record the baseline.
2. Run write mode over the agreed scope.
3. Inspect the diff for unsupported files, style migration beyond scope, and sorting that could alter semantics.
4. Run the project's tests or targeted checks when formatting includes potentially semantic transforms.
5. Run write mode again and confirm it produces no diff.
6. Run check mode and confirm it passes over the agreed scope.

Formatting is verified when the second write makes no changes, check mode passes, ignored files remain untouched, and the inspected diff contains no unintended semantic edits.

## Completion checklist

- Does one formatter own each included file type?
- Do non-default options trace to existing convention or demonstrated need?
- Are generated, vendored, and externally managed files excluded narrowly?
- Is repository-wide churn separated from behavioral work?
- Have sorting and other potentially semantic transforms been inspected on representative files?
- Are write and check commands discoverable and aligned across local and automated use?
- Does a second write produce no changes, followed by a passing check?
