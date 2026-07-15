# Requirements Docs

The goal of organizing our requirements is to make it easy for both agents and
humans to manage, prioritize, and track. The main types of software requirements
are functional, non-functional, and domain requirements.

## Big Picture

- Follow agile best practices
- Requirements link to validation and acceptance intent.
- Design requirements so that future humans/agents have an easier time designing
- Write requirements so that they could be sent to stakeholders as needed
- Requirements must be atomic, unambiguous, testable, and written as obligations, not implementation ideas. Do not treat a design choice as a requirement unless the user confirms it as a constraint or desired behavior.
- Maintain a clear separation between confirmed facts, assumptions, unresolved questions, and rejected or out-of-scope ideas. If information is uncertain, record it as an assumption or open question instead of silently promoting it to a requirement.
- Never invent requirements

## Types of Software Requirements

### Functional Requirements

Definition: Functional requirements describe what the software should do. They define the functions or features that the system must have.

Examples:
- User Authentication: The system must allow users to log in using a username and password.
- Search Functionality: The software should enable users to search for products by name or category.
- Report Generation: The system should be able to generate sales reports for a specified date range.

Explanation: Functional requirements specify the actions that the software needs to perform. These are the basic features and functionalities that users expect from the software.

### Non-functional Requirements

Definition: Non-functional requirements describe how the software performs a task rather than what it should do. They define the quality attributes, performance criteria, and constraints.

Examples:
- Performance: The system should process 1,000 transactions per second.
- Usability: The software should be easy to use and have a user-friendly interface.
- Reliability: The system must have 99.9% uptime.
    Security: Data must be encrypted during transmission and storage.

Explanation: Non-functional requirements are about the system’s behavior, quality, and constraints. They ensure that the software meets certain standards of performance, usability, reliability, and security.

### Domain Requirements

Definition: Domain requirements are specific to the domain or industry in which the software operates. They include terminology, rules, and standards relevant to that particular domain.

Examples:
- Healthcare: The software must comply with HIPAA regulations for handling patient data.
- Finance: The system should adhere to GAAP standards for financial reporting.
- E-commerce: The software should support various payment gateways like PayPal, Stripe, and credit cards.

Explanation: Domain requirements reflect the unique needs and constraints of a particular industry. They ensure that the software is relevant and compliant with industry-specific regulations and standards.

## Use Cases

Record use cases for describe scenarios, main flows, alternate flow, failure
paths, and functionality of the system as needed. These describe the desired
externally observable behavior before design commits to boundaries or
internals.

Use the INVEST framework when writing use cases.

Independent - Not dependent on each other
Negotiable - Includes the important avoid contract
Valuable - Provides value to customer
Estimable - Estimated in terms of effort (use relative terms like points and not
absolute terms like hours)
Small - Simple and small, not complex
Testable - Should be evaluated by acceptance criteria

## Stage specific files

| `requirements.md` | Atomic functional, non-functional, and domain requirements | This is the canonical source of obligations; downstream docs allocate or satisfy these obligations |
| `use-cases.md` | Scenarios, main flows, alternate flows, and failure paths | These describe desired externally observable behavior before design commits to boundaries or internals |
| `acceptance.md` | Acceptance criteria, validation intent, and high-level
verification method |

## ID Rules

Recommended ID prefixes:

| Prefix | Owner |
| --- | --- |
| `REQ-FUNC-001` | `docs/requirements/requirements.md` |
| `REQ-NFR-001` | `docs/requirements/requirements.md` |
| `REQ-DOM-001` | `docs/requirements/requirements.md` |
| `UC-001 `| `docs/requirements/use-cases.md` |
