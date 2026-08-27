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
