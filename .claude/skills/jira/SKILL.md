---
name: jira
description: Creates Jira tickets using the jira CLI tool. Gathers ticket title, description, and labels interactively. Use when the user wants to create a new Jira issue or ticket.
---

<objective>
Create Jira tickets via the `jira` CLI with a consistent, guided flow. Collects ticket title, description, and labels before creating the issue.
</objective>

<essential_principles>

- **Always use the `jira` CLI tool** — never use Atlassian MCP tools for ticket creation.
- **Default project:** HB
- **Default issue type:** Task
- **Default label:** devops-team

</essential_principles>

<quick_start>
If the user provided arguments (e.g., `/jira Add cursor-based pagination`), use the arguments as the ticket title and skip the title question. Otherwise, start from step 1.
</quick_start>

<process>

1. **Gather ticket title**
   Ask the user: "What should the ticket title be?"
   Use their response as the `--summary` value.

2. **Gather description**
   Ask the user: "What's the description for this ticket?"
   Use their response as the `--body` value.

3. **Gather labels**
   Use AskUserQuestion to ask which labels to apply:

   - **devops-team (Recommended)** — Default team label
   - **No label** — Create without labels
   - (User can select "Other" to type a custom label)

4. **Select parent Epic**
   Fetch active DevOps epics using the `jira` CLI:

   ```bash
   jira issue list --type Epic --label devops-team --project HB --status "In Progress" --plain --no-truncate --columns key,summary
   ```

   If that returns no results, broaden the search by dropping `--status`:

   ```bash
   jira issue list --type Epic --label devops-team --project HB --plain --no-truncate --columns key,summary
   ```

   Review the ticket title and description against the list of epics. **Suggest the best-fit epic** and explain briefly why it seems like a match. Then use AskUserQuestion to present the options:

   - List up to 3-4 epics as options (put your recommendation first with "(Recommended)" suffix)
   - Include a **"No epic"** option for standalone tickets
   - User can always select "Other" to provide a different epic key

   The user makes the final decision.

5. **Confirm before creating**
   Display a summary of the ticket to the user:

   ```
   Project:  HB
   Type:     Task
   Epic:     <epic key> - <epic summary> (or "None")
   Title:    <title>
   Desc:     <description>
   Labels:   <labels>
   ```

   Ask: "Create this ticket?" — proceed only on confirmation.

6. **Create the ticket**
   Run the `jira` CLI command:

   ```bash
   jira issue create \
     --project HB \
     --type Task \
     --summary "<title>" \
     --body "<description>" \
     --label "<label>" \
     --parent "<epic-key>"
   ```

   Omit `--label` if the user chose "No label".
   Omit `--parent` if the user chose "No epic".

7. **Show result**
   Display the created ticket key and a link so the user can verify.

</process>

<success_criteria>
- Ticket title, description, and labels gathered from the user
- DevOps epics fetched via `jira` CLI and best-fit suggested to user
- User selected (or declined) a parent epic
- Confirmation summary shown before creation
- Ticket created successfully via `jira` CLI
- Ticket key displayed to the user after creation
</success_criteria>
