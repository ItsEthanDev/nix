---
description: Publish confirmed target-state intent as the project's specification.
agent: build
---

Load the `documentation` skill. Turn the confirmed intent from the current conversation into the project's smallest useful target-state specification.

`$ARGUMENTS` optionally narrows the scope. When empty, use the scope established in the current conversation.

## 1. Establish Authority

Read the applicable project instructions, documentation, domain glossary, and ADRs as directed by the documentation skill. Explore relevant implementation and tests until you understand the current behavior and constraints that bear on the specification.

Treat implementation as evidence of current state, not as target-state intent.

This step is complete when the scope, applicable canonical owners, confirmed intent, and relevant current behavior are known.

## 2. Resolve Uncertainty

Separate confirmed intent from verified current facts, source material, assumptions, and open questions.

When an unresolved decision would materially change required behavior or design, ask one focused question, provide a recommended answer and its main trade-off, and wait for the user's decision. Keep non-blocking uncertainty explicitly non-normative.

This step is complete when every normative statement has a confirmed source and every remaining uncertainty is clearly identified.

## 3. Publish Canonical Documentation

Route every confirmed decision to its canonical owner using the documentation skill. Update all affected project documentation, not only requirements and design.

- Ensure the root `README.md` exists unless the project records an explicit opt-out. Keep it accurate about the project's purpose, audience, current status, supported usage, and documentation navigation. Label planned behavior rather than presenting it as implemented.
- Update the applicable `CONTEXT.md` when discovery established or changed canonical domain language. Create it just in time when those distinctions are useful.
- Capture qualifying architectural decisions as ADRs when they are hard to reverse, surprising without context, and the result of a confirmed trade-off.
- Publish externally meaningful target-state obligations and acceptance intent in requirements documentation.
- Publish confirmed architecture, interfaces, data shape, boundaries, and technical decisions in design documentation.
- Update `docs/README.md` or applicable nested README files when created or changed artifacts affect documentation ownership, navigation, or reading order.
- Record durable agent-specific documentation preferences in the applicable `AGENTS.md` only when they lack a human-facing owner.

Use the smallest project-appropriate structure. Link canonical artifacts instead of duplicating their content.

## 4. Verify The Result

Check that:

- Every normative statement comes from confirmed intent.
- Requirements describe observable obligations rather than accidental implementation.
- Design adds only confirmed technical decisions.
- Current-state and work-state information are not presented as target-state intent.
- Assumptions and open questions are visibly non-normative.
- Terminology, links, indexes, and artifact ownership are consistent.
- The specification is sufficient input for independent ticket creation.

The complete output of this command is specification documentation and affected documentation indexes. Keep implementation and ticket state unchanged.

Summarize what was published and identify any unresolved questions or specification gaps.
