---
name: wait-what
description: Re-explain a specific statement or question when the user uses "wait what" as a clarification request, including as a numbered answer.
---

# Wait What

Re-pitch only the part that did not land while preserving the surrounding conversation and workflow state.

1. Identify the narrowest responsible target:
   - In a numbered answer, target the corresponding numbered question.
   - When the user names or quotes something, target that content.
   - Otherwise target the immediately preceding claim, question, or bounded section that reasonably prompted the request.
2. Preserve every unaffected answer, decision, and workflow state. Keep the target unresolved and do not advance work that depends on it.
3. Re-explain the target with only the context needed to understand it. Use ASD-STE100 Simplified Technical English and the established ubiquitous language from the applicable `CONTEXT.md` when one exists.
4. Stop after the scoped clarification so the user can respond.

When no target can be identified responsibly, ask one concise targeting question instead of re-pitching the whole response.
