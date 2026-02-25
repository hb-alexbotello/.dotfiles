---
name: review-impl
description: Reviews implementation against research.md, plan.md, and todo.md in the branch-scoped artifact directory. Verifies the implementation stayed true to the plan, catches bugs, logic errors, and missed requirements. Use after implementation is complete.
---

<objective>
Review the implementation by comparing the actual code changes against the plan. All artifacts live in `.plans/<branch-name>/`. Verify correctness, completeness, and adherence to the plan. Catch bugs, logic errors, and deviations before the user commits or merges.
</objective>

<artifact_directory>
**Before doing anything else**, resolve the artifact directory:

1. Run `git branch --show-current` to get the branch name
2. Set the artifact directory to `.plans/<branch-name>/` relative to the project root
3. All artifact files (`research.md`, `plan.md`, `todo.md`, `review.md`) live in this directory

Example: on branch `cursor-pagination`, artifacts live in `.plans/cursor-pagination/`.
</artifact_directory>

<essential_principles>

**Three prerequisites.** `research.md`, `plan.md`, and `todo.md` must all exist in `.plans/<branch-name>/`. If any missing, tell the user which to run.

**The plan is the spec.** Every code change should trace back to a plan step. Deviations are findings — flag them. Some may be intentional improvements, others may be mistakes.

**Review the diff, not the whole codebase.** Use `git diff` to get the actual changes. Review what changed, not what was already there.

**Delegate to sub-agents.** All review work through Task tool sub-agents (subagent_type: "general-purpose", model: "opus"). Each sub-agent reviews a specific area — one for plan adherence, one for bugs/logic, one for patterns/conventions. Main context synthesizes into the review report.

</essential_principles>

<quick_start>
1. Resolve the artifact directory per `<artifact_directory>`
2. Check for `research.md`, `plan.md`, and `todo.md` in `.plans/<branch-name>/`
3. Any missing → **stop.** Tell user what to run.
4. Read all three artifacts completely
5. Run `git diff` to get the implementation changes (staged + unstaged)
6. Conduct the review, write `.plans/<branch-name>/review.md`
</quick_start>

<review_process>

**Step 1: Gather context.** Read `research.md`, `plan.md`, `todo.md` from the artifact directory. Understand what was supposed to be built and why.

**Step 2: Gather changes.** Run `git diff` (and `git diff --cached` for staged changes) to get all implementation changes. Also check `git status` for new untracked files.

**Step 3: Review via sub-agents.** Spawn focused review agents:

- **Plan adherence agent** — compares each plan step against the diff. Was every step implemented? Were code snippets from the plan followed? Any deviations?
- **Bug/logic agent** — reviews the diff for bugs, logic errors, edge cases, off-by-ones, null handling, error handling, race conditions
- **Patterns agent** — checks that implementation respects existing patterns and conventions documented in `research.md`. Uses the right ORM methods, follows naming conventions, doesn't duplicate existing utilities.

**Step 4: Synthesize.** Combine sub-agent findings into `.plans/<branch-name>/review.md`.

</review_process>

<review_output>

Write `review.md` to the artifact directory with this structure:

```markdown
# Implementation Review

## Summary
[Overall assessment — pass/fail/pass with issues. 1-2 paragraphs.]

## Plan Adherence
[For each plan step: implemented correctly / deviated / missing]
- Step 1: [status and notes]
- Step 2: [status and notes]
- ...

## Unchecked Todo Items
[Any items in todo.md still unchecked — these are incomplete work]

## Bugs & Logic Errors
[Specific issues found with file paths and line references]
- **[severity]** `path/to/file.ts:42` — [description of bug]

## Deviations from Plan
[Changes that don't match the plan — may be intentional or mistakes]
- `path/to/file.ts` — [what was planned vs what was implemented]

## Convention Violations
[Places where implementation doesn't follow existing patterns from research.md]

## Recommendations
[Specific fixes needed before this is ready to merge]
```

Severity levels: **critical** (breaks functionality), **warning** (potential issue), **info** (style/convention).
</review_output>
