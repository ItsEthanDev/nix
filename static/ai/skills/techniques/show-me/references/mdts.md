# Browser Markdown directory with mdts

mdts renders a directory of Markdown files as a browsable tree. Use it for reviewing files, not as a publication or access-control system.

1. Confirm the directory to serve. Resolve its path and choose the smallest directory containing the requested files. Check for material in that directory that should not be shared with the intended audience. Do not expose a parent repository merely for convenience.
2. Check whether `mdts` is available (`command -v mdts`). On Ethan's configured Pi dev shell it is packaged, but other environments may differ. Check that the chosen port is free; if a server already occupies it, identify the owner and use that session only if it serves the right directory, or choose another port. Do not stop another server without permission.
3. Choose the binding for the intended viewer:
   - On this computer only: `mdts /absolute/path/to/directory --host 127.0.0.1 --port 8521 --no-open`.
   - From another device: confirm the permitted network and its access controls before using `--host 0.0.0.0`. This listens on all interfaces; an interface-specific firewall rule may restrict incoming connections, but the listener itself does not. Do not open a firewall, enable public sharing, or deploy system changes without authorization.
4. Start the server in a terminal or a managed background process. Record its process and chosen port. Verify the HTTP page loads and the file tree includes a requested Markdown file before giving the URL. For remote access, report the host address reachable on the permitted network; verify from that network if possible and state clearly when remote access is unverified. A localhost URL works only on the server's own computer.
5. Leave the server available while the user is inspecting it. Stop only the process started for this review when the user finishes or requests cleanup, unless they ask to keep it running.

The viewer has no built-in login. Access depends on the selected directory, binding, firewall, and network permissions. Do not imply that `--host 0.0.0.0` by itself makes access Tailscale-only.
