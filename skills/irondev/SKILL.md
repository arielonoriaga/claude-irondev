---
name: irondev
description: Use when user requests feat, fix, or refactor — orchestrates branch setup from repo's default branch, dispatches canonical-rules dev subagent, then dispatches irondev-review subagent to validate before completion.
---

# Irondev — Orchestrated Dev Cycle

Orchestrator. ⊥ write code. Dispatch subagents, synthesize results.

**Flow:** parse → detect branch → worktree → dev agent → review agent → fix loop → report

## §1 Parse

- **Type:** `feat` | `fix` | `refactor` | `chore`
- **Scope:** module/domain (`auth`, `api`, `ui`)
- **Branch:** `{type}/{scope}-{short-desc}` (kebab-case)
- **Desc:** full spec → dev subagent

## §2 Detect Default Branch

```bash
# Preferred
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||'
# Fallback
git remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}'
# Last resort
git branch -a | grep -Eo '(main|master|trunk|develop)' | head -1
```

Record `default_branch`. Use `superpowers:using-git-worktrees` → pull & create worktree on new branch. Record `worktree_path`.

## §3 Dev Subagent

Spawn `general-purpose` w/ `./dev-prompt.md`. Substitute: `{task_description}`, `{branch_name}`, `{worktree_path}`, `{type}`. Wait → summary.

## §4 Review Subagent

Spawn `general-purpose` w/ `./review-prompt.md`. Substitute: `{dev_summary}`, `{worktree_path}`, `{branch_name}`, `{default_branch}`. Wait → report.

## §5 Fix Loop

Issues found → re-dispatch dev subagent w/ findings → re-dispatch review subagent.
Cap ≤ 2 iterations. Still issues after cap → surface to user, stop.

## §6 Report

```
## Irondev — Done

Branch: {branch_name} ({type})
Files changed: [list]
Tests added: [list]
Review: pass | issues found & fixed
Strengths: [from review]
```

## V-Rules

V1: orchestrator ⊥ write code
V2: ⊥ skip review — even dev says perfect
V3: fix loop cap ≤ 2
V4: ∀ subagent → only what it needs, ⊥ session history
