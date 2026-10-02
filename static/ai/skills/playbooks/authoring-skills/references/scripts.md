# Writing skill scripts

Use scripts for repeatable mechanics with explicit inputs and observable results. Leave ambiguous choices and authorization decisions to the agent or user.

## Keep one source of truth

Let the script own its arguments, defaults, validation, execution steps, and implemented verification. Provide usage through its help interface.

In the skill, state when to invoke the script, what authorization or context it needs, and what remains outside its responsibility. Point to the script and its help instead of reproducing their contents. Do not instruct the agent to repeat checks the script already performs.

## Own dependencies locally

When Nix supplies dependencies, bundle a flake.nix and flake.lock within the skill. Locate them relative to the script, not the caller's working directory.

Keep the skill runnable after moving it into another repository. Do not reference a personal configuration, its top-level flake, or a collection-wide dependency flake.

Declare Nix and any required Nix features as host prerequisites. Do not require NixOS unless the operation actually depends on it. Declare supported platforms.

Pin runtime dependencies through the flake lock and the application's dependency locks and hashes. Pinning a runtime does not pin packages it downloads. Prefer packaging the application with its dependency graph over resolving packages at execution time.

Allow Nix to acquire declared dependencies without installing them into a user profile. Report unavailable prerequisites rather than installing Nix or changing host configuration.

## Separate dependencies from runtime state

Treat ports, permissions, network connectivity, and authenticated services as runtime conditions. Supplying an executable does not establish a working service session.

Check only prerequisites needed for the requested operation. Local browser viewing does not require Tailscale. Remote viewing requires an explicitly selected access method.

Do not broaden network exposure, authenticate services, or change system configuration as automatic recovery. Require authorization for those actions.

## Make execution predictable

Validate inputs before side effects. Quote paths and arguments, preserve argument boundaries, and avoid evaluating caller-provided shell text.

Use safe defaults and explicit inputs for consequential behavior. For a viewer, default to loopback access and serve only the requested directory.

Define success through observable postconditions. Use bounded waits and actionable failures when checking readiness. Return a nonzero exit status on failure, and do not report success merely because a process started.

Make process ownership explicit. Either run in the foreground or return a handle for stopping the process. Clean up resources the script owns on failure; do not stop unrelated processes.

Keep output useful to the caller. Report results clearly and send diagnostics to standard error. Use structured output when a caller needs to parse results reliably.

## Verify the boundary

Check syntax and exercise a representative successful invocation. Test relevant failures, including invalid inputs and unavailable runtime prerequisites.

Run from another working directory and verify that bundled paths still resolve. Check that the skill does not depend on its containing repository's configuration.

Distinguish reproducible dependencies from stateful execution. A locked environment does not guarantee available ports, connectivity, or permissions.
