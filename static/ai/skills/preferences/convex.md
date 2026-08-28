# Convex

When creating `convex.json`, use this complete default configuration:

```json
{
  "$schema": "./node_modules/convex/schemas/convex.schema.json",
  "functions": "src/convex/",
  "aiFiles": {
    "enabled": false
  }
}
```

This establishes `src/convex/` as the Convex functions directory and disables AI file generation.

For an existing `convex.json`, preserve unrelated project-specific settings while applying these defaults only when the task explicitly standardizes the Convex setup. Do not relocate existing functions or disable an established capability during unrelated work.

After editing, parse the file as JSON, confirm the referenced schema exists after installing dependencies, and run the project's Convex validation or development command.

## Environment variables

Declare application environment variables in `src/convex/convex.config.ts`, matching the configured functions directory. Define them with validators in the `env` option to `defineApp`:

```ts
import { defineApp } from "convex/server";
import { v } from "convex/values";

const app = defineApp({
  env: {
    API_KEY: v.string(),
    LOG_LEVEL: v.optional(
      v.union(v.literal("debug"), v.literal("info"), v.literal("error")),
    ),
  },
});

export default app;
```

Treat this as a pattern, not a literal set of variable names. Declare every application variable the Convex functions expect, choose the narrowest supported validator, and preserve existing `defineApp` options and component registrations. Do not put environment variable values or secrets in `convex.config.ts`; set values separately for each deployment.

After declaration and code generation, import the typed `env` object from `_generated/server` and use it instead of `process.env` in queries, mutations, actions, and HTTP actions:

```ts
import { env, query } from "./_generated/server";

export const example = query({
  args: {},
  handler: async () => env.API_KEY,
});
```

Run `bunx convex dev` to validate declarations and regenerate `_generated/server`. Confirm required variables are set in every applicable deployment and run the project's type check to catch invalid names or value assumptions.

Do not condition exported Convex functions on environment variables. Function exports are determined during deployment and are not reevaluated when an environment variable changes.

## Sources

- Convex environment variables: https://docs.convex.dev/production/environment-variables
