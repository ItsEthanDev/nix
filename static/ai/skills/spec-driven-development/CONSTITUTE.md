# Constitute

Establish the durable rules that govern later specifications, plans, and implementations. This is a project-level phase; do not repeat it for every feature.

## Classification boundary

A constitutional rule governs how future decisions are made; it does not merely describe the first feature. Use these signals to distinguish a project invariant:

- is expected to constrain future work beyond one acceptance scenario;
- requires project-level governance or stakeholder authority to change;
- remains meaningful if the current implementation is replaced; and
- defines an invariant or decision boundary rather than an implementation mechanism.

Ask: **Would independently designed future work need to obey this rule?** Treat the answer as a strong diagnostic rather than an absolute gate; a durable security, compliance, or subsystem boundary may govern only a narrow class of work.

Route other candidates to their canonical owner:

| Candidate | Owner |
| --- | --- |
| Observable behavior, metric, threshold, timing, or placement for one feature | Specification |
| Library, vendor, deployment mechanism, or technical design | Plan, or ADR for durable consequential rationale |
| Execution order or progress | Task list |
| Verified current behavior that has not been accepted as policy | Code, tests, or current-state documentation |

A technical boundary belongs in governance only when the project has deliberately accepted it as enduring policy.

## Process

1. **Discover existing authority.** Read applicable agent instructions, the root README, documentation indexes, domain context, ADRs, build configuration, and quality-tool configuration. List the existing owners of project intent, terminology, architecture, testing, and agent behavior.
2. **Classify candidates before drafting.** Classify each candidate as existing policy, verified current behavior, a proposed project invariant, a feature requirement, a technical decision, an execution detail, or an unresolved choice. When evaluating several candidates, record the candidate, classification, expected lifetime, change authority, and canonical owner in a table. Current implementation does not become policy merely because it exists.
3. **Elicit only consequential choices.** Surface conflicts and ask about decisions that constrain future work, such as supported platforms, architectural limits, security obligations, testing expectations, and quality gates. Prefer observed project conventions for reversible details.
4. **Stress-test each principle.** State the behavior it requires, its constitutional compliance signal, and one realistic case where it could become costly or ambiguous. A compliance signal indicates what later work must demonstrate; it is not a feature test suite. Exclude exact scenarios, thresholds, paths, tools, and implementation mechanics unless they are themselves accepted project policy. Remove slogans that do not change a decision.
5. **Update canonical owners.** Put each accepted rule in the existing artifact that owns its meaning. Create one minimal governance artifact only when no suitable owner exists. Keep agent-only instructions separate from human-facing project facts.
6. **Report the constitution map.** Summarize each principle, its canonical file, its compliance signal, and any unresolved conflict.

## Boundary examples

| Statement | Likely owner |
| --- | --- |
| Customer data must not enter telemetry | Constitution or security policy |
| Show disclosure before collecting a message | Specification |
| Meet WCAG 2.2 AA across supported interfaces | Constitution, when it is a standing commitment |
| Use Shadow DOM | Plan or ADR |
| Complete migration before enabling the feature | Task list |

## Completion criteria

Constitute is complete when:

- Every accepted principle is classified against the lifetime, authority, implementation-independence, and decision-boundary signals.
- Every accepted principle is actionable and has one canonical owner.
- Feature-specific metrics and technical mechanisms are excluded unless their status as enduring policy is explicit.
- Existing conflicting guidance is reconciled or explicitly unresolved.
- Later phases can locate the project rules without relying on conversation history.
- No duplicate rules artifact was created unnecessarily.
