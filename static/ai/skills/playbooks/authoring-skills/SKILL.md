---
name: authoring-skills
description: Create or revise an agent skill.
disable-model-invocation: true
---

# Authoring Skills

Create or revise a skill that changes how an agent acts on a recognizable task. Read the existing skill and nearby capabilities when revising one; identify overlap before adding a new one. Follow the target project's skill format and instructions.

## Choose a role

Choose one primary role by the decision the skill owns, unless the target project's conventions organize skills differently:

- **Lifecycle:** Decide the work state, prerequisites, transition gates, and who can authorize a transition. Leave the strategy for solving a particular problem to a playbook.
- **Playbook:** Provide a reusable strategy for a particular problem or outcome, such as diagnosing a bug. Leave project-wide stage gates to the lifecycle.
- **Technique:** Define a bounded operation and its result, such as tracing a code path or committing a change. Leave the reason for the larger task to its playbook or requester.
- **Principle:** Constrain judgment across tasks so a choice can change or be rejected. Do not turn the principle into a task sequence.

Ask which decision an overlapping instruction makes, then put it with that decision's owner. For example, a test requirement before leaving an implementation stage is a lifecycle gate; choosing tests that reveal a defect belongs to a diagnosis playbook; writing one test can be a technique. Skills in different roles can work together without copying one another's rules.

Use the role to define scope, not file layout or invocation. Follow the target project's organization and invocation conventions. Where they leave a choice open, use a router when it improves selection among related material; otherwise keep the skill independently discoverable.

## Choose invocation

Decide who should initiate the skill. If the agent should select it, write a description that names the capability and the distinct positive cases that should trigger it. Lead with the words a request is likely to use. Describe each case once rather than listing synonyms or exclusions. If a person should select it explicitly, use the harness's manual-invocation metadata and a short human-facing description. Check the target harness's supported frontmatter rather than assuming one format works everywhere.

## Shape the skill

Put actions needed on every run in the main file, followed by rules that most runs need. Place branch-specific detail in references with clear instructions for when to read them. Keep related definitions and rules together.

Keep one skill when the material shares an invocation and purpose. Split out a skill when it has a distinct reason to be invoked independently. When several related skills are hard to find or choose among, use a router that names each branch and points to the appropriate skill or reference. Keep the router focused on selection; leave detailed instructions with their owners.

Write reusable procedure in the skill. Find project policy, paths, commands, and other local facts in the target project's own sources rather than treating one environment as universal. Point to another authoritative instruction instead of copying it.

## Delegate mechanics to scripts

Put repeatable execution in a script when it makes the operation more reliable. Keep invocation criteria, authorization decisions, and unresolved judgment in the skill. Defer to the script for its interface and implemented behavior; do not duplicate its arguments, defaults, checks, or execution steps in skill prose.

When adding or revising a bundled script, read [Writing skill scripts](references/scripts.md). Each skill that needs Nix-managed dependencies owns its own flake and lockfile rather than depending on a host configuration or collection-wide flake.

## Prune and check

When in doubt, delete. Keep prose that changes a decision or action. Tell the agent to do the thing and skip the reason unless the rule would be confusing without it. Match tone and detail to scope.

Check the target harness's required frontmatter, invocation setting, referenced paths, and links. For an agent-selected skill, compare the description with representative requests that should reach it; for a manual skill, check that its command or loading path is available. Exercise a representative use when the skill's structure or behavior needs proof. Report what was checked and any unverified behavior.
