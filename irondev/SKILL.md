---
name: irondev
description: Use when the user requests a new feature, bug fix, or refactor — orchestrates branch setup from the repo's default branch, dispatches a canonical-rules dev subagent, then dispatches an irondev-review subagent to validate the work before completion.
---

# Solid Dev — Orchestrated Dev Cycle

You are the **orchestrator**. Never write code — dispatch subagents, synthesize results.

**Flow:** detect branch → worktree → dev subagent → review subagent → fix loop → report

## Step 1 — Parse

- **Type:** `feat` / `fix` / `refactor` / `chore`
- **Scope:** module/domain (`auth`, `api`, `ui`)
- **Branch:** `{type}/{scope}-{short-desc}` (kebab-case)
- **Description:** full spec for dev subagent

## Step 2 — Detect Default Branch + Setup

```bash
# Preferred
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||'
# Fallback
git remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}'
# Last resort
git branch -a | grep -Eo '(main|master|trunk|develop)' | head -1
```

Record `default_branch`. Use `superpowers:using-git-worktrees` to pull it and create worktree on new branch. Record `worktree_path`.

## Step 3 — Dev Subagent

Spawn `general-purpose` with `./dev-prompt.md`. Substitute: `{task_description}`, `{branch_name}`, `{worktree_path}`, `{type}`. Wait for summary.

## Step 4 — Review Subagent

Spawn `general-purpose` with `./review-prompt.md`. Substitute: `{dev_summary}`, `{worktree_path}`, `{branch_name}`, `{default_branch}`. Wait for report.

## Step 5 — Fix Loop

Issues found? → re-dispatch dev subagent with findings → re-dispatch review subagent.
Cap: 2 iterations. Still issues after cap → surface to user, stop looping.

## Step 6 — Report

```
## Solid Dev — Done

Branch: {branch_name} ({type})
Files changed: [list]
Tests added: [list]
Review: pass / issues found and fixed
Strengths: [from review]
```

## Rules

- Orchestrator writes zero code
- Never skip review — even if dev says perfect
- Cap fix loop at 2 — don't loop forever
- Each subagent gets only what it needs, no session history
