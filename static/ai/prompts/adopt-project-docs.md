---
description: Bootstrap or migrate this project's documentation to the project-documentation system
argument-hint: "[area or constraint]"
---

Adopt the `project-documentation` system in this project. Scope: ${ARGUMENTS:-the whole repository}. Load the `project-documentation` skill and its bootstrap/migration reference; use `writing` when drafting human-facing or agent-facing prose. Follow this repository's instructions and existing authoritative decisions. Do not run the full development lifecycle merely because documentation is changing.

Inventory existing docs and inspect relevant code, tests, configuration, and commands. Distinguish observed behavior, accepted target, and uncertain interpretation. For missing documentation, use code as evidence of current behavior and ask me focused, batched questions where you cannot establish the project's purpose, intended feature outcomes, scope, or consequential design. For legacy documentation, preserve useful claims in their proper owners and reconcile or remove outdated copies. Do not invent intent or decision history to make the result appear as if it was always organized this way.

Create only useful artifacts: a concise README and verified coworker setup where needed, living feature specs for established intent that merits separate documentation, and plans, tasks, context, contracts, or operations guidance only when they carry distinct information. Reference schemas and configuration for their exact declarations. Do not infer live deployments or configured integrations from code alone, record secrets, modify code or external services, or deploy.

Proceed with clear, independent documentation work; ask for direction before resolving material conflicts or treating inferred behavior as an accepted target. Check links, commands, and factual claims against their sources. Finish with the artifact map, what changed, verification results and limitations, and any unresolved questions. Do not claim a completed migration while consequential ownership or intent is unresolved.
