---
name: show-me
description: Present work for feedback in chat, a live Hunk diff, or a browser-based Markdown directory viewer. Use when the user asks to see work or chooses a surface to inspect it; not for routine completion reporting or a development audit.
---

# Show Me

Help the user inspect the requested work in the surface they choose. This is a presentation technique, not a mandate to audit the work or run a review after every task.

1. Identify the **object** to show (changes, document, or directory) and the requested **surface**. Follow an explicit choice. If none is specified, use chat when it can convey the object adequately; otherwise ask which surface the user wants. Do not replace an unsupported requested surface without asking.
2. Present the actual artifact, not a claim that it is available. Verify the chosen surface is showing the right content, give the user its location or URL, and say what is ready for feedback.
3. Keep review distinct from evaluation. Do not treat "show me" as a request for a code audit, approval gate, publication, or deployment. Follow project and user rules for any action needed to expose material.

## Surfaces

- **Chat:** Give a short orientation to what changed or where the artifact lives, with concrete paths or links and any important limitation. Do not paste a whole artifact unless the user requests it.
- **Live Hunk diff:** When the user wants an interactive diff or is already using Hunk for the target changes, read [Hunk guidance](references/hunk.md). Use its session CLI to verify the selected repository and diff before guiding the user's view. Do not open the Hunk TUI on the user's behalf.
- **Browser Markdown directory:** When the user wants to browse Markdown files, read [mdts guidance](references/mdts.md). Select the smallest directory that contains the requested files and confirm who may reach the server before starting it.

Other surfaces, including PDFs and running products, are outside this skill's first iteration. Ask how to present those rather than silently serving a different object.
