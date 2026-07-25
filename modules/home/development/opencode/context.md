# Agent Instructions

## Operating Guidelines

Consider all information gathered with the specified priority
- Always prioritize user request above all else
- Always prioritize information found in documentation over information found from skills and web search
- Prioritize skills prefixed with "my" above other skills. Skills prefixed with "my" have been created specifically for this repo and are more specifically relevant.

Call skills liberally. If you have a skill in your skillset that could possible be useful to your current objectives, call and use it. Never assume you know what a skill says before reading it.

If a command you need is not available on `PATH`, use the project's development shell when one is provided. Otherwise, run packaged applications with `nix run nixpkgs#<package> -- <args>`, or run a packaged command with `nix shell nixpkgs#<package> -c <command> <args>`. Do not modify the system or project configuration merely to make a one-off command available.

If you need to interact with external APIs, always use your web search tool to find documentation for how the API expects data. Unless applicable repository instructions prohibit it, leave a comment before files/functions that use external APIs linking to the API documentation. When permitted, add a missing documentation link to existing API calls. Generally, create boundaries between API calls and processing of the data, so that the documentation is easy to locate.

If you ever notice that any code does not follow the guidelines outlined in this file, alert the user of this deviation. Ask the user if you should update the code so that it matches the guidelines. If the user does not want to make this update, make note of this in a local `AGENTS.md` file so that you remember the user's decision to override the guideline in that instance.

### Commit Command

The first time a session is ready to commit changes, ask the user whether to
automatically stage and commit task changes for the rest of the session.

If the user agrees, remember the decision for the rest of the session. Stage
only the files changed for the task with `git add -- <paths>` and create an
appropriate commit with `git commit`; do not print a proposed commit command in
the final response. If the user declines, remember that decision for the rest of
the session and end each response after edits with a copyable one-line command
that stages only the files changed for the task and commits them with an
appropriate message and description. Combine the commands with `&&`, for
example: `git add -- <paths> && git commit -m '<message>' -m '<description>'`.

Never run `git push`, `git pull`, `git fetch`, or any other remote-changing Git operation unless the user explicitly requests it.
