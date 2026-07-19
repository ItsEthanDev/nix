# Repository Organization

This document defines the intended organization of the repository. The flake
assembles outputs, host configuration describes individual deployments, and
modules provide reusable opt-in capabilities.

## Core Boundaries

- `flake.nix` owns inputs, output definitions, and the assembly of complete
  system and home configurations. It imports each layer's default module
  aggregate so hosts cannot accidentally omit repository modules.
- `systems/` owns machine-wide, host-specific configuration for NixOS and
  nix-darwin.
- `homes/` owns host-specific user configuration. Prefer Home Manager whenever
  configuration does not require machine-wide privileges or services.
- `modules/` owns cohesive capabilities that could be enabled on another host
  without carrying assumptions about the original machine or user.

There is no separate shared-profile layer under `systems/` or `homes/`. Promote
cohesive cross-host behavior to a module. Leave incidental host choices in each
host, even when that creates a small amount of duplication.

## Directory Structure

System and home configurations use the platform identifier and host name:

```text
systems/<system>/<host>/default.nix
homes/<system>/<host>/default.nix
```

Examples of `<system>` include `x86_64-linux` and `aarch64-darwin`. Each home
directory represents the primary user's environment for that host. Add a user
directory level only when a host actually needs more than one managed user.

Reusable modules are separated by evaluator:

```text
modules/nixos/<capability>/default.nix
modules/darwin/<capability>/default.nix
modules/home/<capability>/default.nix
```

Capabilities may be nested under well-named categories such as `desktop/`,
`hardware/`, or `terminal/`. A behavior module's directory path should mirror
its `my.*` option path, excluding the evaluator directory. For example,
`modules/home/terminal/ghostty/default.nix` owns
`my.terminal.ghostty.*`.

Every independently importable module is a directory with a `default.nix`.
Private implementation fragments may use descriptive filenames, but they stay
within their owning module and are not imported or exported independently. A
large host may similarly split configuration into concern-based files imported
by its `default.nix`; these fragments set configuration but do not define custom
options.

## Host Configuration

Host files make deployment-specific choices. They own:

- hostnames, platforms, users, home directories, and hardware configuration;
- NixOS, nix-darwin, and Home Manager `stateVersion` values;
- services, programs, packages, and preferences selected for that host; and
- hardware identifiers, monitor layouts, local paths, and other machine-specific
  values.

A module installs packages required by its capability. General tools and
applications selected for one host remain in that host's system or home
configuration.

Host definitions normally override module defaults without special handling.
Use `lib.mkForce` only as a documented exception when an upstream or third-party
module cannot be overridden at normal priority.

## Reusable Modules

The module trees follow these rules:

- `modules/nixos/`, `modules/darwin/`, and `modules/home/` remain separate.
  Generic helper functions belong in `lib/` rather than a common module tree.
- Each behavior-producing module defines `my.<path>.enable` with
  `lib.mkEnableOption`. Importing the module must have no effect until that
  option is explicitly enabled.
- All behavior is gated by the module's primary `enable` option. Secondary
  options may have useful inert defaults, but they do not activate behavior on
  their own.
- Non-enable options have explicit types and useful descriptions. Add an option
  only when it is a genuine input to the capability; do not mirror upstream
  options merely for convenience.
- A module represents one cohesive capability, which may require several
  packages, programs, or services. Category modules organize imports only; they
  do not provide bundle-level enable options or configuration.
- Aggregate `default.nix` files list imports explicitly. Each evaluator exposes
  a `default` aggregate containing every repository module and named exports for
  each top-level module directory.
- Enabling one repository module does not enable another. A module may adapt its
  own behavior to another enabled feature, but it must not reconfigure or
  activate that feature.
- Imports of third-party modules belong to the repository module that owns the
  integration. Importing the third-party module must itself remain inert.
- A host may directly import a third-party module when it owns all of that
  module's configuration and no reusable capability needs it.
- Required prerequisites and unsupported platforms fail evaluation with clear
  assertions. Optional integrations may degrade conditionally.
- Modules do not hard-code usernames, home directories, hostnames, hardware
  identifiers, or host-specific paths. Derive standard context from existing
  options, expose a minimal input when it is part of the abstraction, or keep
  the configuration in the host.

### Definition Priorities

Enabled modules provide overridable behavior. Use `lib.mkDefault` wherever
possible for default-like definitions, including values derived from the
module's own options. A normal-priority host definition can then replace the
module's choice without `lib.mkForce`.

Intentionally additive definitions are the exception. Lists such as package or
plugin contributions should remain at normal priority when they are meant to
merge with definitions from hosts and other modules. Nix filters definitions by
override priority before applying a type's merge behavior, so wrapping an
additive list in `lib.mkDefault` would allow any normal-priority definition to
discard the module's entire contribution.

The same applies to dynamically keyed attribute sets such as shell aliases.
Their entries are merged by the option type rather than declared as independent
module options, so keep additive entries at normal priority and resolve
intentional key conflicts in the owning capability.

### Module Shape

The following NixOS module illustrates the expected shape. The package list is
intentionally additive; the remaining effects are overridable defaults.

```nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.audio;
in {
  options.my.desktop.audio.enable = lib.mkEnableOption "desktop audio";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = lib.mkDefault true;

    services.pipewire = {
      enable = lib.mkDefault true;
      alsa = {
        enable = lib.mkDefault true;
        support32Bit = lib.mkDefault true;
      };
    };

    # Keep additive definitions at normal priority so other lists merge.
    environment.systemPackages = [pkgs.pavucontrol];
  };
}
```

## Nix Conventions

- Format Nix files with Alejandra and use two-space indentation.
- Use lowercase kebab-case for directories and filenames. Use lower camelCase
  for multi-word option names.
- Keep imports explicit and organized by purpose.
- Pass flake inputs through `specialArgs` or `extraSpecialArgs` rather than
  relying on global state.
- Prefer clear `options` and `config` sections with a local `cfg` binding for
  non-trivial modules.
- Keep attribute sets reasonably ordered and use `inherit` when it improves
  clarity.

Detailed module behavior belongs in Nix option descriptions. Add focused prose
documentation only when the option contract cannot explain the behavior
clearly. Plaintext secrets do not belong in this repository; `static/` contains
only non-secret assets referenced by configuration.
