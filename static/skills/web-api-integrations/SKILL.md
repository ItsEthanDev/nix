---
name: web-api-integrations
description: Implement, debug, test, or review integrations with remote HTTP, REST, GraphQL, RPC, SDK, or webhook APIs. Use when code crosses a web API boundary, consumes remote data, or exposes a webhook endpoint.
---

# Web API Integrations

Treat every web API as an untrusted external boundary. Start from its documented contract, expose the smallest interface the application needs, and keep live access under explicit user control.

## Hard guardrails

- Ask once per service and environment before making any real API request, including unauthenticated and read-only requests. Permission lasts for related read-only requests during the current session.
- Retrieve public documentation and use local mocks or fake servers without API-access permission.
- Call a read endpoint only when its documentation establishes that it is non-mutating. An HTTP verb, SDK method name, or “dry run” label is not proof.
- Execute a mutation only when the user explicitly authorizes the specific effect and target environment. A request to implement mutation code does not authorize running it.
- Apply the same rules to raw HTTP, SDKs, CLIs, GraphQL, RPC, and integration tests.

## Workflow

1. **Establish the contract.** Identify the service, API version, environment, authentication, required scopes, endpoint, request, response, pagination, limits, and documented errors. Read official documentation when available. Complete this step when each implemented behavior traces to documentation or is labeled as an inference.

2. **Choose the interaction method.** Inspect project instructions, dependencies, existing adapters, and nearby integrations for an established convention such as an official SDK, generated client, GraphQL client, or plain HTTP. The existence of an SDK alone does not establish a convention. Follow a clear existing convention. When none exists, explain the relevant tradeoffs, recommend an option, and ask the user which method they want before installing a client or implementing the boundary. Complete this step when the method follows project precedent or records the user's choice.

3. **Resolve evidence.** Prefer an official versioned schema, then official endpoint documentation, official SDK types or source, and repository documentation. Use a permitted live response only as supporting evidence. When sources disagree, report the conflict; use the versioned machine-readable contract for type shape while preserving documented constraints and observed discrepancies. Complete this step when conflicts and assumptions are explicit.

4. **Design a narrow seam.** Expose application operations and types rather than vendor endpoints, clients, or response objects. Keep URLs, authentication, wire types, pagination, retries, rate limits, and vendor errors inside the adapter. Complete this step when callers depend only on the minimum behavior and data they need.

5. **Validate the boundary.** Treat remote input as unknown, validate it at runtime when practical, and map it into application types. Derive types from authoritative schemas when available. Keep parsing and mapping pure where possible, and make relevant timeout, cancellation, pagination, and error behavior visible in the interface. Apply the same validation to inbound webhooks before business logic runs. Complete this step when malformed or undocumented input cannot silently enter trusted code.

6. **Test without the network.** Test request construction, parsing, mapping, pagination, documented errors, nullable or missing fields, and retry decisions around the seam. Use documented examples, local fakes, or sanitized fixtures. Keep live contract checks separate and disabled by default. Complete this step when application behavior can be verified without credentials or network access.

7. **Add useful documentation links.** When applicable project instructions permit it, place a stable, endpoint-specific documentation link on the adapter function when it preserves non-obvious scopes, parameters, limits, pagination, version behavior, or external constraints. Keep links out of domain types and ordinary callers. Complete this step when each link helps maintain the boundary rather than narrating the code.

8. **Verify and report.** Run local tests and type checks. If a live read would materially reduce uncertainty, follow the permission protocol below. Report documentation consulted, interaction method, assumptions, source conflicts, validation performed, and any unverified live behavior. Complete this step when the evidence supports the claimed contract.

## Live read protocol

Ask with a scoped request such as:

> May I use `$SERVICE_API_KEY` for documented read-only requests to Service X's production API during this session? I will make only requests related to our work, minimize returned data, and avoid printing or persisting credentials.

After permission:

- Stay within the approved service and environment. Ask again when either changes.
- Confirm the endpoint is documented as non-mutating and check cost, quota, rate-limit, audit, and sensitive-data implications.
- Request the fewest fields, records, pages, and shortest date range that can answer the question.
- Reference credentials through environment variables without printing them. Do not write credentials or raw sensitive responses into the repository.
- Redact sensitive values from logs and reports. Stop when the response identifies an unexpected account or environment.

Mutation authorization must name or clearly authorize the operation, effect, and target environment. Treat message delivery, job triggers, uploads, token or webhook creation, acknowledgements, and state-changing reads as mutations regardless of transport syntax.
