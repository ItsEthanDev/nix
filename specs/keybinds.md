# Global Keybindings

This living specification defines the intended grammar and catalog for global
keyboard bindings on Linux. It owns the interaction model that individual Nix
bindings implement but cannot express adequately. A global binding is available
regardless of which application has focus. Bindings owned by the active context
and pointer gestures are outside this specification's scope.

The strategy is compositor-independent and describes actions rather than the
keystrokes an implementation forwards. macOS may approximate the same feel
where practical, but this document does not prescribe macOS bindings.

## Design Priorities

Resolve competing binding choices in this order:

1. Preserve the boundary between global and context bindings.
2. Add friction as an action becomes more destructive or disruptive.
3. Follow mature, widely recognized Linux conventions.
4. Preserve the internal grammar and established semantic families.
5. Keep frequent actions ergonomic.
6. Prefer clear mnemonics when stronger considerations do not decide the key.
7. Leave uncommon actions to searchable surfaces rather than pursuing complete
   direct coverage.

Evaluate conventions and collisions as complete families, not isolated chords.
For example, `Super+L` retains its directional meaning because it is part of the
established `H/J/K/L` family rather than an otherwise available mnemonic for
locking.

## Binding Grammar

- Every ordinary global binding includes `Super`. Self-identifying keys such as
  media, volume, brightness, microphone, keyboard-backlight, and `Print` keys
  are exempt because the key itself identifies its global scope.
- Global bindings are direct simultaneous chords, not prefixes or modal
  submaps.
- Bindings refer to logical key symbols rather than fixed physical positions.
- `H/J/K/L` expresses direction, and number keys identify numbered workspaces.
  Other keys may use mnemonics selected case by case.
- A base key owns one semantic family. Additional modifiers may select related
  variants, but they do not turn the key into a namespace for unrelated
  actions.
- Only `Super` has one universal modifier meaning. Secondary modifiers have
  consistent meanings within their semantic family. Their meanings may compose
  when the result remains clear, but composition is not required globally.
- Capability-specific chords remain reserved on hosts that lack the capability;
  they are not reassigned to unrelated actions.
- Repeat behavior follows compositor and tool defaults.

Use a direct chord only when frequency, convention, or membership in a coherent
core family justifies it. Most applications and infrequent global actions belong
in the searchable launcher or control center. A direct application launch names
a stable role rather than a particular product.

Visible, harmless, and immediately reversible state changes may use toggles.
Graceful lifecycle actions may be direct, forceful variants require an added
modifier, and logout, reboot, and shutdown require a confirming system surface.

## Binding Catalog

The catalog is normative wherever a host provides the corresponding capability.
A host may expose any practical range of numbered workspaces, but it preserves
the number-key grammar throughout that range.

### Editing

These globally available bindings provide a deliberately closed compatibility
family. Save, find, new, quit, and other context actions are not added to it.

| Binding | Action |
| --- | --- |
| `Super+C` | Copy. |
| `Super+V` | Paste. |
| `Super+X` | Cut. |
| `Super+A` | Select all. |
| `Super+Z` | Undo. |
| `Super+Shift+Z` | Redo. |
| `Super+Ctrl+V` | Open clipboard history. |

### Navigation and Placement

Adding `Shift` to a destination binding changes "go" into "send." Sending a
window to another workspace or monitor preserves the current view rather than
following the window.

| Binding | Action |
| --- | --- |
| `Super+H` | Focus left. |
| `Super+J` | Focus down. |
| `Super+K` | Focus up. |
| `Super+L` | Focus right. |
| `Super+Shift+H` | Move the focused window left. |
| `Super+Shift+J` | Move the focused window down. |
| `Super+Shift+K` | Move the focused window up. |
| `Super+Shift+L` | Move the focused window right. |
| `Super+number` | Select the corresponding available workspace. |
| `Super+Shift+number` | Send the focused window to that workspace without following. |
| `Super+Tab` | Focus the next monitor. |
| `Super+Shift+Tab` | Send the focused window to the next monitor without following. |

Directional bindings use only `H/J/K/L`; arrow keys remain available to the
focused context. Keyboard resizing is not part of this family.

### Window Lifecycle and State

| Binding | Action |
| --- | --- |
| `Super+W` | Gracefully close the focused window. |
| `Super+Ctrl+W` | Force-close the focused window. |
| `Super+F` | Toggle fullscreen. |
| `Super+T` | Toggle between tiled and floating. |

Pinning and less common window properties use the launcher or control center.

### System Entry Points

| Binding | Action |
| --- | --- |
| `Super+Space` | Open the searchable launcher. |
| `Super+Ctrl+Space` | Open the control center. |
| `Super+Enter` | Open the default terminal. |

The terminal is the exceptional direct application role. Browsers and other
applications use the launcher. Bar visibility, individual settings panels,
notifications, color picking, session locking, and power actions use the
launcher or control center instead of dedicated global chords.

### Audio

| Binding | Action |
| --- | --- |
| `Super+M` | Toggle microphone mute. |

Speaker volume and mute use their self-identifying hardware keys. The ordinary
chord for microphone mute accommodates keyboards that cannot emit a dedicated
microphone key.

### Gaming

The active game and game launcher are separate, directly addressable targets on
the host's dedicated gaming display. Invoking either target while the other is
visible switches directly between them. Invoking the visible target dismisses
it and restores the underlying workspace.

| Binding | Action |
| --- | --- |
| `Super+G` | Summon or dismiss the active game |
| `Super+Ctrl+G` | Summon or dismiss the game launcher, starting it when necessary. |

Games and the game launcher route to their targets automatically, so this family
does not provide manual window-transfer variants. Controller macros invoke the
same canonical chords rather than defining a separate control scheme.

### Capture

`Shift` narrows the capture from the active monitor to a selected region.
Capture destinations follow the configured screenshot behavior.

| Binding | Action |
| --- | --- |
| `Super+P` | Capture the active monitor. |
| `Super+Shift+P` | Capture a selected region. |

Other self-identifying hardware keys invoke their matching action without
`Super`, but machine-specific hardware controls are not cataloged here.

## Sources

This specification is constrained by
[PR-009](constitution.md#pr-009--nix-owns-configuration-behavior) of the project
constitution. It does not amend repository governance.
