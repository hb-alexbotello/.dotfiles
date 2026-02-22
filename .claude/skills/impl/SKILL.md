---
name: impl
description: Executes an implementation plan by following plan.md and checking off tasks in todo.md. Use when the user is ready to implement after research and planning are complete.
---

<objective>
Execute the implementation plan. Read the plan, follow it step by step, mark progress in `todo.md`, and don't stop until every task is complete. All creative decisions were made during planning — implementation should be mechanical, not creative.
</objective>

<essential_principles>

**Three prerequisites. No exceptions.** `research.md`, `plan.md`, and `todo.md` must all exist in the current working directory before implementation begins. If any are missing, stop and tell the user which files are missing and which commands to run (`/research`, `/plan`, `/plan finalize`).

**Implement it all.** Execute everything in the plan. Don't cherry-pick. Don't skip steps. Don't stop for confirmation mid-flow. The plan was reviewed and approved — now execute it. If a task in `todo.md` is unchecked, it needs to be done.

**Mark progress in todo.md.** After completing each task, check it off in `todo.md` immediately. This is the user's progress tracker. They should be able to glance at it at any point and see exactly where things stand. Use the Edit tool to change `- [ ]` to `- [x]` for completed items.

**Implementation is boring. That's the point.** Every decision was made during planning. Don't get creative. Don't "improve" the plan. Don't add features that aren't in the plan. Don't refactor adjacent code. Follow the plan exactly as written. If the plan says to create a function with a specific signature, create that function with that signature.

**Keep the code clean.** No unnecessary comments. No jsdocs unless the plan specifies them. No `any` or `unknown` types in typed languages. No placeholder code. No TODO comments. Write production-quality code the first time.

**Continuous validation.** Run tests, type checks, linters, or build commands after each phase — not just at the end. Catch problems early. If the project has a test suite, run it. If it has type checking, run it. If the plan specifies a validation approach, follow it.

**Delegate everything to sub-agents.** The main context is a coordinator — it never writes code directly. Three types of sub-agents (all subagent_type: "general-purpose", model: "sonnet"):
1. **Implement agent** — receives plan sections and tasks, writes the code
2. **Validate agent** — runs tests, type checks, compilation, reports pass/fail
3. **Fix agent** — receives specific errors from validation, fixes only those issues

The main context orchestrates: spawn implement → spawn validate → if fail, spawn fix → validate again → repeat until pass → mark todo.md → next phase.

**Accept terse corrections.** During implementation, the user's role shifts from architect to supervisor. Their corrections will be short — "wider", "move it to the admin app", "you missed the dedup function." These are not vague — the full context is in the plan. Act on them immediately.

**Reference existing code when told to.** When the user says "make it look like X" or "same as the users table", read that reference code first, then match it. Most features in a mature codebase are variations on existing patterns. The reference communicates all implicit requirements.

**Revert when told to.** If the user says they reverted changes, don't try to reconstruct what was there. Start fresh from the current state. If they narrow the scope, respect the new scope — implement only what they asked for, not the full original plan.

</essential_principles>

<prerequisites>
All three files must exist in the current working directory:

1. **`research.md`** — the research findings the plan was built on
2. **`plan.md`** — the approved implementation plan with code snippets
3. **`todo.md`** — the granular task checklist

If any are missing, stop and tell the user:
- Missing `research.md` → run `/research` first
- Missing `plan.md` → run `/plan` first
- Missing `todo.md` → run `/plan finalize` first
</prerequisites>

<quick_start>
1. Use the Glob tool to check for `research.md`, `plan.md`, and `todo.md` in the current working directory
2. If any are missing → **stop.** Tell the user which are missing and what to run.
3. Read all three files completely
4. Scan `todo.md` for unchecked items (`- [ ]`) — these are the remaining tasks
5. If all items are checked → tell the user implementation is already complete
6. Begin implementation from the first unchecked task
</quick_start>

<execution_process>

**The main context is a coordinator.** It does not write implementation code directly. It reads artifacts, spawns sub-agents, marks progress, and orchestrates the implement → validate → fix loop.

**Process:**

1. **Read all artifacts.** Read `research.md`, `plan.md`, and `todo.md` completely. Understand the full context before spawning any agents.
2. **Identify remaining work.** Scan `todo.md` for unchecked items. Group them by phase.
3. **For each phase, run the implement → validate → fix loop:**

   **Step A: Implement.** Spawn a sub-agent (subagent_type: "general-purpose", model: "sonnet") with:
   - The specific tasks from `todo.md` for this phase
   - The relevant implementation steps from `plan.md` (with code snippets)
   - Relevant context from `research.md` (existing patterns, conventions)
   - Clear instruction: implement exactly as specified, no creative additions

   When the sub-agent finishes, mark completed tasks in `todo.md` using the Edit tool.

   **Step B: Validate.** Spawn a separate sub-agent (subagent_type: "general-purpose", model: "sonnet") to run the project's validation:
   - Tests
   - Type checking / compilation
   - Linting if configured
   - The sub-agent reports pass/fail with specific error output

   **Step C: Fix (if needed).** If validation fails, spawn a new implementation sub-agent with:
   - The specific errors and test failures from the validation agent
   - The relevant plan sections and research context
   - Instruction: fix only the failing issues, don't touch anything else

   After the fix agent finishes, go back to **Step B** (validate again). Repeat the validate → fix loop until validation passes.

4. **Move to the next phase.** Only after validation passes for the current phase.
5. **Continue until done.** Don't stop until every item in `todo.md` is checked off and the final validation passes.

**The loop visualized:**

```
For each phase:
  Implement (sub-agent) → Mark todo.md
       ↓
  Validate (sub-agent)
       ↓
  Pass? → Next phase
  Fail? → Fix (sub-agent) → Validate again → repeat until pass
```

</execution_process>

<handling_corrections>

During implementation, the user may provide corrections. These come in several forms:

- **Terse fixes:** "wider", "still cropped", "2px gap" → apply immediately, the context is obvious from the plan
- **Missed items:** "you didn't implement the dedup function" → go back and implement it, check it off
- **Relocation:** "move it to the admin app" → move the code, update imports, verify it works in the new location
- **Reference-based:** "make it look like the users table" → read the reference code first, then match its patterns
- **Screenshots:** if the user shares a screenshot, examine it and fix the visual issues shown
- **Reverts:** "I reverted everything. Now just do X" → start fresh from current state, implement only what was asked
- **Scope narrowing:** "forget the rest, only do X" → stop following the full plan, implement only X

For corrections, apply them and continue with the remaining tasks. Don't re-explain the plan or ask for confirmation — just fix and move on.

</handling_corrections>

<success_criteria>
- All items in `todo.md` checked off
- Validation passes (tests, type checks, builds)
- Code matches the plan's specifications — no creative additions, no skipped steps
- Code is clean — no unnecessary comments, no placeholder types, no TODOs
