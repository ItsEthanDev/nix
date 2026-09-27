# README and Governance

The root `README.md` helps a person identify the project, get started using verified commands, and find its detailed owners. Link to live specifications and implementation rather than restating every setting or requirement. Human-facing guides belong in the repository's established documentation location, often `docs/`; keep them focused on what their readers need to do.

Governance owns durable constraints on future work, not a description of every current behavior. Use existing policy owners when present; use `specs/constitution.md` only when the project needs a consolidated owner and has none. Record an actionable rule and how to recognize compliance. Do not infer policy from current code or move a one-feature requirement into governance. If a proposed change conflicts with governance, surface the conflict rather than bypassing it.

Agent-specific operating instructions belong in the applicable `AGENTS.md` or harness equivalent; point to canonical human-facing documentation for shared facts. Verify changed paths, links, and commands at their sources. Small [README-independent governance starter](templates/constitution.md) sections may help when a consolidated constitution is needed; omit unnecessary structure.
