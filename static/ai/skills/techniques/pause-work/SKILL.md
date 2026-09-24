---
name: pause-work
description: Pause work safely and save a resume checkpoint for another agent or after compaction.
disable-model-invocation: true
---

# Pause Work

1. **Stop at a safe boundary.** Finish the current atomic action or leave it explicitly incomplete. Start no new task work. Account for any running child or background work: stop it when safe and permitted, or record how to locate it and what result is still pending. Do not push, deploy, or take other irreversible action merely to make the pause tidy.
2. **Inspect the actual state.** Check the relevant workspace and Git status, including branch, uncommitted changes, and any work belonging to others. Record what changed, what was verified, and what remains uncertain. Do not commit incomplete or ambiguously scoped work just to checkpoint it; follow the repository's commit rules for already completed, verified work.
3. **Leave a resume note outside the conversation.** Use an existing work artifact if it owns the unfinished state and the request permits updating it. Otherwise write a short note to a temporary file on the current machine, outside the repository. If writing is not permitted, give the note in the reply and say that it is not persisted. Include the objective and scope, current boundary, decisions and evidence not already recorded elsewhere, exact paths to relevant artifacts, verification results and gaps, blockers or pending work, and the first concrete next action. Distinguish facts from assumptions. Refer to specs, commits, and diffs instead of copying them. Exclude secrets and unnecessary personal data. A temporary note is not a portable or permanent record; arrange a permitted shared destination if the next agent cannot access this machine.
4. **Check the handoff.** Confirm the note exists and its references resolve where possible. Report its path, branch and dirty/clean state, outstanding work, and first resume action. Tell the next agent to read the note and recheck current repository state and authoritative sources before acting. Then stop.

The checkpoint does not grant approval for new decisions or external actions.
