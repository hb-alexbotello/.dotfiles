---
name: research
description: Conducts deep research on any topic, producing and iteratively refining a research.md file in the current working directory. Use when the user wants to research a topic, build a knowledge base, or refine existing research through direct edits and annotations.
---

<objective>
Conduct deep, structured research on any topic. Automatically detects mode based on whether `research.md` exists in the current working directory:

- **From scratch**: No `research.md` → create one based on the user's prompt
- **In progress**: `research.md` exists → user has made edits → recalibrate with targeted updates
</objective>

<essential_principles>

**Depth over speed.** Surface-level reading is not acceptable. Do not read a file, glance at function signatures, and move on. Read implementations. Follow call chains. Understand side effects. Trace data flows end-to-end. When researching code, understand not just *what* something does but *how* it does it and *what surrounds it*.

**The artifact is a review surface.** `research.md` is not a summary for the chat — it is the document the user will read to verify you actually understood the system. If the research is wrong, every downstream decision will be wrong. Structure findings so misunderstandings are visible and correctable. Be specific enough that the user can spot where you got it right and where you didn't.

**Exhaustive exploration.** Don't stop at the first file or the obvious entry point. Follow imports, trace flows across boundaries, understand how components interconnect. Find what already exists — caching layers, shared utilities, conventions, patterns. The most expensive failure mode isn't wrong syntax or bad logic. It's implementations that work in isolation but break the surrounding system because context was missed.

**No skimming.** When the user says "deeply", "in detail", "intricacies", "go through everything" — they mean it. These are depth signals. Without them, the default research depth should still be thorough. With them, go further: read every file in a directory, trace every code path, document every edge case.

**Delegate to sub-agents.** All research work must be performed through Task tool sub-agents (subagent_type: "general-purpose", model: "opus"). Break the research into focused sub-tasks — each sub-agent investigates a specific area, returns findings, and the main context synthesizes results into `research.md`. This keeps the main conversation context clean and allows parallel investigation of multiple threads.

</essential_principles>

<quick_start>
1. Use the Glob tool to check for `research.md` in the current working directory
2. If it does **not** exist → enter **from scratch** mode
3. If it **does** exist → enter **in progress** mode
</quick_start>

<from_scratch_mode>
**Triggered when:** `research.md` does not exist in CWD.

**Process:**

1. Parse the user's prompt to identify the research topic, scope, and specific questions
2. **Go deep before writing anything.** Conduct thorough research using all available tools:
   - **Grep / Glob / Read** — codebase or local file analysis. Read implementations, not just signatures. Follow imports and call chains across files. Understand how the target connects to the rest of the system.
   - **WebSearch / WebFetch** — current information, documentation, articles, data
   - **Bash** — running commands, checking versions, testing behaviors, examining runtime state
   - **Task agents** — parallel research threads on sub-topics when breadth is needed
3. **Keep researching until you have genuine understanding.** If something is unclear, read more files. Trace more paths. Don't fill gaps with assumptions — fill them with evidence.
4. Synthesize findings into a well-structured `research.md`
5. Write the file to the current working directory

**research.md structure:**

```markdown
# [Research Topic]

## Summary
[2-3 paragraph executive summary — what this is, how it works, what matters]

## Key Findings
[Numbered list of the most important discoveries]

## [Topic Section 1]
[Detailed findings with evidence and sources.
For code research: include file paths, function names, data flows,
and how this section connects to other parts of the system.]

## [Topic Section 2]
[Detailed findings with evidence and sources]

## Existing Patterns & Conventions
[What already exists that's relevant — shared utilities, caching layers,
ORM conventions, architectural patterns. Things that must be respected
in any future implementation.]

## Open Questions
[Questions that emerged during research needing further investigation]

## Sources
[List of sources consulted with URLs / file paths where applicable]
```

**Guidelines:**
- Structure sections organically based on what the research reveals
- Include specific evidence: file paths, line references, data points, citations
- Flag areas of uncertainty or conflicting information explicitly
- Document existing patterns and conventions — these prevent downstream implementation mistakes
- End with open questions to guide the user's next iteration
- Be thorough. Depth over breadth. If you haven't traced a flow end-to-end, you haven't finished researching it.
</from_scratch_mode>

<in_progress_mode>
**Triggered when:** `research.md` already exists in CWD.

**Process:**

1. Read the existing `research.md` file completely
2. Analyze what the user has changed — look for:
   - New text added by the user (questions, notes, corrections, new sections)
   - Sections deleted or significantly rewritten
   - Inline cues: "TODO", "?", "wrong", "expand", "dig deeper", "verify", "update"
   - Structural changes (reordered sections, new headings, removed headings)
3. For each detected change, determine user intent:
   - **Added question** → research and answer it
   - **Marked as wrong / inaccurate** → re-research and correct with evidence
   - **"Expand" or "dig deeper"** → conduct deeper research on that section. Read more files, trace more paths, document more detail.
   - **Deleted content** → respect the deletion, do not restore
   - **New headings / empty sections** → fill with researched content at full depth
   - **Rewritten text** → treat user's version as the new baseline, research to support or enhance it
4. Conduct targeted research **only** on sections needing updates — apply the same depth standards as from-scratch mode
5. Update `research.md` preserving unchanged sections exactly as-is
6. Append a `## Revision Notes` section at the bottom documenting what changed and why

**Guidelines:**
- Preserve the user's structural choices and edits — they are intentional
- Only touch sections that need updating based on detected changes
- If the user rewrote a section, treat their version as authoritative
- Never restore content the user deleted
- When the user says something is wrong, don't defend the original — re-research it
- Keep revision notes concise — bullet list of changes made
</in_progress_mode>

<success_criteria>
**From scratch mode:**
- `research.md` created in CWD with substantive, deeply-researched content
- Findings reflect genuine understanding, not surface-level summaries
- Claims supported by evidence (file paths, sources, data) or clearly marked as uncertain
- Existing patterns and conventions documented so future work respects them
- Open questions identified for future iterations

**In progress mode:**
- All user edits and annotations addressed with the same research depth
- Only changed sections updated — unchanged content untouched
- User's structural decisions and corrections preserved as authoritative
- Revision notes document what was updated and why
</success_criteria>
