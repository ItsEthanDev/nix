# Bun

## Package manager

When a JavaScript or TypeScript project does not have an established package manager, use Bun instead of npm, pnpm, or Yarn.

Use Bun consistently for the resulting workflow:

- Install dependencies with `bun install`.
- Add dependencies with `bun add`.
- Run package scripts with `bun run`.
- Execute package binaries with `bunx`.

A package-manager choice is established when repository instructions, a lockfile, package-manager metadata, automation, or deployment requirements deliberately select it. Do not migrate an established package manager during unrelated work.

## Isolated linker

For a new Bun setup, or when the task explicitly standardizes Bun configuration, ensure `bunfig.toml` contains this fragment:

```toml
[install]
linker = "isolated"
```

Treat this as a fragment to merge. Preserve unrelated `bunfig.toml` settings. If `[install]` already exists, add or update its `linker` key instead of creating a duplicate table.

After editing, run `bun install` and inspect the resulting install rather than assuming the setting was accepted. Existing Bun lockfiles can preserve their current linker and layout, so changing an established project requires explicit migration scope.

## Parallel scripts

Use Bun's built-in parallel script runner instead of adding a concurrency package solely to run package scripts concurrently:

```sh
bun run --parallel <args>
```

Replace `<args>` with script names, a script glob, or supported workspace filtering arguments. Preserve sequencing where scripts depend on one another; use parallel execution only for work that can run concurrently.

Run the actual command and confirm that every selected script executes and failures produce the intended exit behavior.
