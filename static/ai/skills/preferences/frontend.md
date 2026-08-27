# Frontend

## Tailwind in React components

Use Tailwind utility classes directly in React component `className` values. Do not extract utilities into custom CSS classes solely to shorten component markup.

Use a CSS file when styles are genuinely global, require unsupported CSS behavior, integrate with third-party markup, or become clearer as a separately owned style definition. Preserve an established project styling convention during unrelated work.

After editing, render or build the affected component and inspect the resulting layout and states.

## Shadcn component primitives

When setting up shadcn or adding a primitive in a shadcn project that has not established a primitive library, use Base UI instead of Radix.

Do not mix Base UI and Radix implementations for equivalent primitives without a concrete compatibility or migration requirement. When the project already uses Radix, preserve that choice unless replacing it is part of the requested work.

Verify the generated or installed component's imports and exercise its relevant interaction and accessibility states.
