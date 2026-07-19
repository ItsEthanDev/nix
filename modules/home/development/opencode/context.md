# Agent Instructions

## Operating Guidelines

Consider all information gathered with the specified priority
- Always prioritize user request above all else
- Always prioritize information found in `AGENTS.md`, `README.md`, `REQUIREMENTS.md`, `CONTRIBUTING.md` and `docs/` over information found from skills and web search
- Prioritize skills prefixed with "my" above other skills. Skills prefixed with "my" have been created specifically for this repo and are more specifically relevant.

Call skills liberally. If you have a skill in your skillset that could possible be useful to your current objectives, call and use it. Never assume you know what a skill says before reading it.

If you need to interact with external APIs, always use your web search tool to find documentation for how the API expects data. Unless applicable repository instructions prohibit it, leave a comment before files/functions that use external APIs linking to the API documentation. When permitted, add a missing documentation link to existing API calls. Generally, create boundaries between API calls and processing of the data, so that the documentation is easy to locate.

If you ever notice that any code does not follow the guidelines outlined in this file, alert the user of this deviation. Ask the user if you should update the code so that it matches the guidelines. If the user does not want to make this update, make note of this in a local `AGENTS.md` file so that you remember the user's decision to override the guideline in that instance.

### AGENTS.md

While editing, determine if you have learnings worth preserving in nearby `AGENTS.md` files:

1. **Identify directories with edited files** - Look at which directories you modified
2. **Check for existing AGENTS.md** - Look for `AGENTS.md` in those directories or parent directories. Create `AGENTS.md` files as appropriate.
3. **Add valuable learnings** - If you discovered something future developers/agents should know:
   - API patterns or conventions specific to that module
   - Gotchas or non-obvious requirements
   - Dependencies between files
   - Testing approaches for that area
   - Configuration or environment requirements

**Examples of good AGENTS.md additions:**
- "When modifying X, also update Y to keep them in sync"
- "This module uses pattern Z for all API calls"
- "Tests require the dev server running on PORT 3000"
- "Field names must match the template exactly"

**Do NOT add:**
- Story-specific implementation details
- Temporary debugging notes

Only update `AGENTS.md` if you have **genuinely reusable knowledge** that would help future work in that directory. Create `AGENTS.md` files as needed.

### Consistency

Whenever editing make sure that `AGENTS.md`, `README.md`, `REQUIREMENTS.md`, and
`docs` are up to date and reflect the project accurately.

### Commit Command

After editing files, end the final response with a copyable, optional one-line
command that stages only the files changed for the task and commits them with an
appropriate commit message and description. Combine the commands with `&&`, for
example: `git add -- <paths> && git commit -m '<message>' -m '<description>'`.

Never stage or commit the changes yourself, and never require the user to run the
command. Do not introduce, explain, or otherwise comment on the command or its
commit message; output the command as the final line of the response.
