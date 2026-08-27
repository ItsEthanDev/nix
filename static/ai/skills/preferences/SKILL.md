---
name: preferences
description: Apply Ethan's personal defaults when initializing or materially changing JavaScript package management, Bun configuration or scripts, Convex configuration, linting and formatting tools, Tailwind styling, or shadcn component primitives.
---

# Preferences

Use these preferences when the task requires making a new choice in a covered area. Treat them as defaults, not automatic migration instructions.

Apply authorities in this order:

1. The user's explicit request for the current task.
2. Repository instructions and documented project decisions.
3. Existing coherent project conventions.
4. These preferences.

Do not replace an established tool or convention during unrelated work. Surface a material conflict with a higher authority instead of silently mixing incompatible conventions.

## Selection

- Read [bun.md](bun.md) when choosing a JavaScript package manager, editing `bunfig.toml`, or writing package scripts that run concurrently.
- Read [convex.md](convex.md) when creating or materially changing `convex.json`.
- Read [quality-tooling.md](quality-tooling.md) when choosing JavaScript or TypeScript linting and formatting tools.
- Read [frontend.md](frontend.md) when styling React components with Tailwind or choosing component primitives for shadcn.

Load only the references relevant to the current task.

## Application

1. Inspect repository instructions, manifests, lockfiles, and relevant configuration to determine whether the choice is open or already established.
2. Read each topic reference selected by the task.
3. Apply the preference only within the requested scope. Preserve unrelated settings and conventions.
4. Verify commands and configuration with the installed tool and the project's existing checks.
5. Briefly report any preference not applied because a higher authority or compatibility constraint prevailed.
