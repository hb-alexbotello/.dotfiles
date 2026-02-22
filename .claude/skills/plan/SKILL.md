---
name: plan
description: Creates and iteratively refines a detailed implementation plan in a plan.md file in the current working directory. Use when the user wants to plan an implementation, design a solution, or refine an existing plan through direct edits and annotations.
---

<objective>
Create a detailed, actionable implementation plan. Automatically detects mode based on whether `plan.md` exists in the current working directory:

- **From scratch**: No `plan.md` → create one based on the user's prompt
- **In progress**: `plan.md` exists → user has made edits → recalibrate with targeted updates
- **Finalize**: User signals the plan is ready → generate `todo.md` with a granular implementation checklist
</objective>

<essential_principles>

**Research is a hard prerequisite.** `research.md` must exist before planning begins. No exceptions. Every decision in the plan must be grounded in the research findings — existing patterns, conventions, system boundaries, caching layers, known constraints. A plan that ignores research will produce an implementation that breaks the surrounding system.

**Never implement.** This skill produces a plan. It does not write implementation code, create files, or make changes to the codebase. The only files this skill writes are `plan.md` and `todo.md`. If the plan feels "good enough" — stop. Do not start implementing. The user decides when the plan is ready and when implementation begins.

**Show the code.** The plan must include code snippets showing the actual changes — not just descriptions of what to change. A step that says "add a pagination function" is incomplete. Show the function signature, the key logic, the data structures. The user needs to review concrete code to approve or reject the approach.

**Use reference implementations.** If the user provides code from another project, an open source repo, or a working example — use it as the foundation for the plan. Claude works dramatically better with a concrete reference to adapt from than designing from scratch. Cite the reference, show how it maps to the current codebase, and plan the adaptation.

**Specificity over abstraction.** Name the files. Name the functions. Name the data structures. Specify the order. A vague plan produces a vague implementation. "Add authentication" is not a plan step — "Add JWT middleware in `src/middleware/auth.ts` that validates tokens from the `Authorization` header and attaches the decoded user to `req.user`" is a plan step.

**Respect what exists.** The plan must work within the existing system, not against it. If the codebase uses a specific ORM, the plan uses that ORM. If there's a shared utility for something, the plan uses that utility. If there's a naming convention, the plan follows it. Never plan to reinvent what already exists.

**Ordered steps with dependencies.** Sequence matters. A migration must run before code that depends on the new schema. A shared utility must be created before the features that use it. Make dependencies explicit. If step 4 depends on step 2, say so.

**The plan is a contract.** `plan.md` is the document the user will approve before any implementation begins. It must be specific enough that the user can say "yes, build exactly this" or "no, change step 3." Ambiguity in the plan becomes bugs in the implementation.

**Delegate to sub-agents.** All planning work must be performed through Task tool sub-agents (subagent_type: "general-purpose", model: "opus"). Break the planning into focused sub-tasks — each sub-agent investigates a specific area (codebase analysis, architecture design, risk assessment), returns findings, and the main context synthesizes results into `plan.md`. This keeps the main conversation context clean and allows parallel investigation.

</essential_principles>

<prerequisite>
**`research.md` must exist in the current working directory.** Planning without research produces plans built on assumptions. If `research.md` does not exist, stop and tell the user to run `/research` first. Do not proceed.
</prerequisite>

<quick_start>
1. Use the Glob tool to check for both `research.md` and `plan.md` in the current working directory
2. If `research.md` does **not** exist → **stop.** Tell the user to run `/research` first.
3. Read `research.md` completely
4. If `plan.md` does **not** exist → enter **from scratch** mode
5. If `plan.md` **does** exist and the user's prompt contains finalization signals ("finalize", "todo", "ready", "generate checklist", "create todo") → enter **finalize** mode
6. If `plan.md` **does** exist otherwise → enter **in progress** mode
</quick_start>

<from_scratch_mode>
**Triggered when:** `plan.md` does not exist in CWD.

**Process:**

1. **Read research.md completely.** This is the foundation for every planning decision. If it doesn't exist, stop — tell the user to run `/research` first.
2. Parse the user's prompt to identify the objective, scope, and constraints. If the user provided reference code or a link to a reference implementation, study it thoroughly.
3. **Understand the target environment.** If the research didn't cover something relevant, use Grep/Glob/Read to fill gaps — file structure, existing patterns, conventions, dependencies. Don't plan blind.
4. Design the implementation approach — architecture decisions, technology choices, integration points
5. Break it into ordered, specific implementation steps with code snippets
6. Identify risks, edge cases, and what NOT to do
7. Write `plan.md` to the current working directory

**plan.md structure:**

```markdown
# [Plan Title]

## Objective
[1-2 paragraphs — what we're building and why]

## Approach
[High-level architecture and key decisions.
Why this approach over alternatives.
How this fits into the existing system.
If a reference implementation was provided, explain how it maps to our codebase.]

## Implementation Steps

### Step 1: [Specific action]
- **Files:** `path/to/file.ts` (create / modify)
- **What:** [Exactly what to do — specific functions, data structures, logic]
- **Why:** [Why this step, why in this order]
- **Depends on:** None

```ts
// Code snippet showing the actual change
export function createUser(data: CreateUserInput): Promise<User> {
  // key implementation logic here
}
```

### Step 2: [Specific action]
- **Files:** `path/to/file.ts` (modify)
- **What:** [Exactly what to do]
- **Why:** [Why this step]
- **Depends on:** Step 1

```ts
// Code snippet showing the actual change
```

### Step N: [...]

## Edge Cases & Risks
[What could go wrong. What to watch out for.
Specific scenarios that need handling.]

## What NOT To Do
[Anti-patterns specific to this plan.
Things that seem obvious but would break the system.
Shortcuts that would cause problems.]

## Testing Strategy
[How to verify the implementation works.
What to test, in what order.]

```

**Guidelines:**
- Every step must name specific files, describe specific changes, and include code snippets showing the actual changes
- Code snippets should show real code — function signatures, key logic, data structures — not pseudocode
- Order steps by dependency — what must exist before what
- Include "What NOT to do" — the anti-patterns that research revealed
- The plan should be implementable by following it step-by-step, in order
- Reference research.md findings. Don't contradict them without explanation.
- If the user provided reference code, show how it maps to the current codebase
- Flag uncertainties. If you're unsure about an approach, say so — let the user decide.
- **Do not implement.** Write the plan and stop.
</from_scratch_mode>

<in_progress_mode>
**Triggered when:** `plan.md` already exists in CWD.

This is the annotation cycle. The user has reviewed the plan, added inline notes, and is sending you back to the document. This cycle may repeat 1-6 times. Each round makes the plan more precise. **Do not implement — only update the plan.**

**Process:**

1. Read the existing `plan.md` file completely
2. Re-read `research.md` to stay grounded in the research
3. Analyze what the user has changed — look for:
   - New text added by the user (questions, alternatives, corrections, constraints, domain knowledge, code snippets)
   - Steps deleted or reordered
   - Inline cues: "TODO", "?", "wrong", "simplify", "split this", "merge these", "add step for", "not optional", "use X instead", "remove this"
   - Pasted code snippets (reference implementations the user wants adopted)
   - Structural changes (new sections, reordered steps, removed steps)
4. For each detected change, determine user intent:
   - **Added question** → research the answer and update the plan accordingly
   - **Marked as wrong** → rethink the approach, re-research if needed, correct it
   - **Domain knowledge note** (e.g., "use drizzle:generate for migrations, not raw SQL") → adopt it, update all affected steps
   - **"Simplify"** → reduce complexity while preserving correctness
   - **"Split this"** → break a step into smaller, more specific sub-steps
   - **Deleted steps or "remove this"** → respect the deletion, adjust dependencies of remaining steps
   - **Reordered steps** → accept the new order, verify dependencies still hold
   - **New constraints** → rework affected steps to satisfy the constraint
   - **Alternative suggested** → evaluate it honestly. If it's better, adopt it. If not, explain why.
   - **Pasted reference code** → study it, adapt the plan to follow that approach
5. Conduct targeted research as needed to support plan changes
6. Update `plan.md` preserving unchanged sections exactly as-is
7. **Re-verify step ordering and dependencies** after any changes — edits can break the dependency chain
8. Append a `## Revision Notes` section at the bottom documenting what changed and why
10. **Do not implement.** Update the plan and stop.

**Guidelines:**
- Preserve the user's structural choices and edits — they are intentional
- Only touch sections that need updating based on detected changes
- If the user reordered steps, verify the new order respects dependencies
- If the user deleted a step, check if other steps depended on it and adjust
- When the user provides domain knowledge, treat it as authoritative — they know their system
- When the user suggests an alternative, evaluate it on merit — don't defend your original plan
- Keep revision notes concise — bullet list of changes made
</in_progress_mode>

<finalize_mode>
**Triggered when:** `plan.md` exists and the user's prompt signals finalization — "finalize", "todo", "ready", "generate checklist", "create todo", or similar.

This is the transition from planning to implementation. The user is satisfied with the plan. Now produce the implementation checklist.

**Process:**

1. Read `plan.md` completely
2. Extract every implementation step, sub-step, and testing item
3. Break each step down into granular, individual tasks — each task should be a single, completable action
4. Organize tasks into phases that respect the dependency order from the plan
5. Write `todo.md` to the current working directory

**todo.md structure:**

```markdown
# Implementation Checklist

## Phase 1: [phase name]
- [ ] [Specific, granular task — single action with file path]
- [ ] [Next task]
- [ ] [Next task]

## Phase 2: [phase name]
- [ ] [Specific task]
- [ ] [Next task]

## Phase N: [...]

## Verification
- [ ] [Test / validation step]
- [ ] [Test / validation step]
```

**Guidelines:**
- Each checkbox should be a single, completable action — not a compound task
- Include file paths in every task so it's clear where the work happens
- Phases map to the plan's dependency order — phase 1 must complete before phase 2
- End with a verification phase for testing and validation
- This is a progress tracker — during implementation, items get checked off as they're completed
- **Do not implement.** Write `todo.md` and stop.
</finalize_mode>

<success_criteria>
**From scratch mode:**
- `plan.md` created in CWD with specific, actionable implementation steps
- Every step names files, functions, and specific changes with code snippets
- Code snippets show real code, not pseudocode or placeholders
- Steps are ordered by dependency with dependencies made explicit
- Plan is grounded in research.md findings
- Reference implementations cited and adapted if provided by user
- Risks, edge cases, and anti-patterns documented
- Plan is specific enough for the user to approve or reject each step
- No implementation performed — only plan.md written

**In progress mode:**
- All user edits, annotations, and domain knowledge notes addressed
- Only changed sections updated — unchanged content untouched
- Step ordering and dependencies re-verified after changes
- User's structural decisions preserved as authoritative
- Revision notes document what was updated and why
- No implementation performed — only plan.md updated

**Finalize mode:**
- `todo.md` created in CWD with a granular implementation checklist
- Every task is a single, completable action with file paths
- Tasks are organized into phases respecting dependency order
- Verification phase included at the end
- No implementation performed — only todo.md written
</success_criteria>
