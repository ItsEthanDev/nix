# Browser Markdown viewer

Use mdts to browse Markdown in a specified directory.

1. Select the directory the user intends to view. Before remote access, confirm which files may be exposed and how the other device will reach the server. Do not start or configure Tailscale implicitly.
2. Run `sh <skill-directory>/scripts/browser.sh --help`, then invoke the helper with the selected inputs. Defer to its help for arguments and prerequisites; report blockers rather than changing host configuration.
3. Confirm the page and a requested file load, then give the user the URL. Keep the server running while they inspect it, and stop the process you started when they are done.
