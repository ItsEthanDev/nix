# Browser Markdown viewer

Use mdts to browse Markdown in a specified directory.

1. Check `command -v mdts`. If it is unavailable, tell the user; do not install it implicitly.
2. Serve the requested directory with `mdts /absolute/path/to/directory --no-open`. For access from another device, add `--host 0.0.0.0` and give the user a reachable host address, not `localhost`. Choose another port with `--port` if the default is occupied. Serve only files the user intends to make accessible on that network.
3. Confirm the page and a requested file load, then give the user the URL. Keep the server running while they inspect it, and stop the process you started when they are done.
