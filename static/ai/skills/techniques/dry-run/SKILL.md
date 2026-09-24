---
name: dry-run
description: Preview a small, concrete edit as a diff in chat and wait for approval before changing files.
disable-model-invocation: true
---

# Dry Run

1. **Inspect the target.** Read the relevant files, project instructions, and existing changes. Limit the preview to a small, bounded edit whose exact lines you can identify. Do not edit files, stage changes, commit, or run mutating commands while preparing the preview. If the change cannot be specified accurately as a short diff, say what is missing or propose a narrower scope instead of guessing.
2. **Show the proposed edit.** Put a unified diff with file paths in chat, showing only the intended changes against the current file contents. Briefly note any consequential assumption or verification that would follow. Distinguish existing uncommitted changes from the proposed edit. Do not create a patch file or apply the diff as part of the preview.
3. **Pause for approval.** Wait for an explicit direction to apply the shown edit. A question or additional context is not approval. If the user revises the request, show an updated diff and pause again.
4. **Apply only the approved edit.** Recheck the target before changing it. If it has changed or the edit would materially differ from the approved diff, show a revised preview and wait again. Otherwise apply the edit, verify the affected behavior under the project rules, and report the result. Follow the project's normal commit rules after verification; approval of the diff does not authorize a push, deployment, or unrelated changes.

`propose-first` owns approval of an approach before implementation. Use this skill for approval of exact, small edits instead of a plan. `show-me` can present work on other surfaces; this preview is a diff in chat before any edit.
