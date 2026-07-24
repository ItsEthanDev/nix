# Agent Instructions

## Operating Guidelines

Consider all information gathered with the specified priority
- Always prioritize user request above all else
- Always prioritize information found in documentation over information found from skills and web search
- Prioritize skills prefixed with "my" above other skills. Skills prefixed with "my" have been created specifically for this repo and are more specifically relevant.

Call skills liberally. If you have a skill in your skillset that could possible be useful to your current objectives, call and use it. Never assume you know what a skill says before reading it.

If you need to interact with external APIs, always use your web search tool to find documentation for how the API expects data. Unless applicable repository instructions prohibit it, leave a comment before files/functions that use external APIs linking to the API documentation. When permitted, add a missing documentation link to existing API calls. Generally, create boundaries between API calls and processing of the data, so that the documentation is easy to locate.

If you ever notice that any code does not follow the guidelines outlined in this file, alert the user of this deviation. Ask the user if you should update the code so that it matches the guidelines. If the user does not want to make this update, make note of this in a local `AGENTS.md` file so that you remember the user's decision to override the guideline in that instance.

### Commit Command

After editing files, end the final response with a copyable, optional one-line
command that stages only the files changed for the task and commits them with an
appropriate commit message and description. Combine the commands with `&&`, for
example: `git add -- <paths> && git commit -m '<message>' -m '<description>'`.

Never stage or commit the changes yourself unless otherwise instructed to, and never require the user to run the
command. Do not introduce, explain, or otherwise comment on the command or its
commit message; output the command as the final line of the response.
