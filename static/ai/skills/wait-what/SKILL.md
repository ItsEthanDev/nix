---
name: wait-what
description: Re-explain a specific statement or question when the user uses "wait what" as a clarification request, including as a numbered answer. Do not use when the phrase or this skill is merely being discussed.
---

# Wait What

Re-pitch only the part that did not land while preserving the surrounding conversation and workflow state.

1. Confirm that `wait what` is a clarification request rather than discussion of the phrase or skill.
2. Identify the narrowest responsible target:
   - In a numbered answer, target the corresponding numbered question.
   - When the user names or quotes something, target that content.
   - Otherwise target the immediately preceding claim, question, or bounded section that reasonably prompted the request.
3. Preserve every unaffected answer, decision, and workflow state. Keep the target unresolved and do not advance work that depends on it.
4. Re-explain the target with only the context needed to understand it. Use ASD-STE100 Simplified Technical English and the established ubiquitous language from the applicable `CONTEXT.md` when one exists.
5. Stop after the scoped clarification so the user can respond.

During a grilling session, record the user's other answers, leave the marked question unanswered, re-explain only that question, and wait before advancing branches that depend on it.

When no target can be identified responsibly, ask one concise targeting question instead of re-pitching the whole response.
