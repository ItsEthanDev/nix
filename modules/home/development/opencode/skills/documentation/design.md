# Design

Turn requirements documentation into design artifacts. Design should be broken
down into three classifications: Interface, architecture, and detailed. Design
elements should only be recorded if there is a meaningful distinction
between the design element and the requirement it's referencing. Design should
not record requirements just in different words, but rather be a valuable
addition to the requirements.

## Big Picture

By the end of the design phase, we should have a clear understanding of the
following.

Architecture: This is the conceptual model that defines the structure, behavior, and views of a system. We can use flowcharts to represent and illustrate the architecture.

A solid architecture verify the system is flexible, stable, and easy to maintain over time.

Modules: Modules as the building blocks of the system. Each one handles a specific task or feature. Breaking a system into smaller modules makes it easier to develop, test, and maintain the system.

These are components that handle one specific task in a system. A combination of the modules makes up the system.

Components: This provides a particular function or group of related functions. They are made up of modules. Organising the system into components helps keep the code clean and makes the system more adaptable.

Interfaces: These are smaller units within modules that focus on specific functions. This is the shared boundary across which the components of a system exchange information and relate.

Data: Data is at the heart of any system. It’s all about how information is stored, accessed, and shared. This is the management of the information and data flow.

## Levels of Design

### Interface Design

Interface Design is the specification of the interaction between a system and its environment. This phase proceeds at a high level of abstraction with respect to the inner workings of the system i.e, during interface design, the internal of the systems are completely ignored, and the system is treated as a black box. Attention is focused on the dialogue between the target system and the users, devices, and other systems with which it interacts. The design problem statement produced during the problem analysis step should identify the people, other systems, and devices which are collectively called agents.

Interface design should include the following details:
- Precise description of events in the environment, or messages from agents to which the system must respond.
- Precise description of the events or messages that the system must produce.
- Specification of the data, and the formats of the data coming into and going out of the system.
- Specification of the ordering and timing relationships between incoming events or messages, and outgoing events or outputs.


### Architectural Design

Architectural design is the specification of the major components of a system, their responsibilities, properties, interfaces, and the relationships and interactions between them. In architectural design, the overall structure of the system is chosen, but the internal details of major components are ignored. Issues in architectural design includes:
- Gross decomposition of the systems into major components.
- Allocation of functional responsibilities to components.
- Component Interfaces.
- Component scaling and performance properties, resource consumption properties, reliability properties, and so forth.
- Communication and interaction between components.

The architectural design adds important details ignored during the interface design. Design of the internals of the major components is ignored until the last phase of the design.

### Detailed Design

Detailed design is the specification of the internal elements of all major system components, their properties, relationships, processing, and often their algorithms and the data structures. The detailed design may include:
- Decomposition of major system components into program units.
- Allocation of functional responsibilities to units.
- User interfaces.
- Unit states and state changes.
- Data and control interaction between units.
- Data packaging and implementation, including issues of scope and visibility of program elements.
- Algorithms and data structures.
