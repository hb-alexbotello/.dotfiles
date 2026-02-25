## Jira
- Always use the `jira` CLI tool (not the Atlassian MCP tools)
- Default to filtering tickets with the label `devops-team`. If no results, omit the label and search generically.
- View ticket contents: `jira issue view $TICKET_CODE --plain`
- **Starting work on a ticket:**
  1. View the ticket first to check the current assignee
  2. If someone else is already assigned, inform the user and stop — don't reassign without confirmation
  3. If unassigned or assigned to the current user, self-assign with `jira issue assign <TICKET> $(jira me)` and move to In Progress with `jira issue move <TICKET> "In Progress"`
  4. If the ticket is already in **Code Review** or **QA**, move it back to **In Progress** automatically — the user is resuming work on it
  5. If the ticket is a subtask, check the parent issue — if the parent is not already **In Progress**, move it to **In Progress** as well
- **Searching for tickets:**
    - Use `--jql` for keyword searches (NOT `-q`): `jira issue list --label devops-team --jql 'summary ~ "keyword"' --plain`
    - Search with multiple terms: `--jql 'summary ~ "term1" AND summary ~ "term2"'`                                                                                             - Find subtasks of a ticket: `--jql 'parent = HB-XXXX'`
    - **Search strategy:** Start specific, then drop terms one at a time. If "cleanup secrets yellow" fails, try just "cleanup yellow", then just "yellow".

## Git Workflow
- **Never push to `master` or `main`.** If on master/main and a commit is requested, stop and ask the user to confirm a branch name.
- **Include Jira ticket code in branches and commits.** If a Jira ticket is associated with the current work (mentioned by the user, visible in branch name, or found via context):
  - Branch name format: `<TICKET>-<short-description>` (e.g., `HB-1234-cursor-pagination`)
  - Commit message format: `<TICKET>: <message>` (e.g., `HB-1234: add cursor-based pagination`)
- If no Jira ticket is available, use standard branch/commit naming without a ticket prefix.
- **Never commit planning artifacts.** Do not stage or commit `research.md`, `plan.md`, `todo.md`, or `review.md` (or anything in `.plans/`). These are local working documents, not source code.
- **Pull Requests.** Use the `gh` CLI to create PRs. PR descriptions must be detailed:
  - Summarize what changed and why
  - Reference the Jira ticket if available
  - List key implementation decisions
  - Note any risks, trade-offs, or follow-up work
  - After PR is created, move the Jira ticket to the **Code Review** swim lane using `jira issue move <TICKET> "Code Review"`
