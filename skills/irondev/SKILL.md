---
name: irondev
description: Use when user requests feat, fix, or refactor — orchestrates branch setup from repo's default branch, dispatches canonical-rules dev subagent, then dispatches irondev-review subagent to validate before completion.
---

# Irondev — Orchestrated Dev Cycle

Orchestrator. ⊥ write code. Dispatch subagents, synthesize results.

**Flow:** parse → detect branch → checkout → dev agent → review agent → fix loop → report

## §1 Parse

- **Type:** `feat` | `fix` | `refactor`
- **Scope:** module/domain (`auth`, `api`, `ui`) — `[a-z0-9]+`
- **Branch:** `{type}/{scope}-{short-desc}` (kebab-case)
- **short-desc sanitize:** `[a-z0-9-]+`, ≤ 40 chars, ⊥ leading `-`, ⊥ `--`, ⊥ trailing `-`. Reject otherwise.
- **Desc:** full spec → dev subagent

## §2 Detect Default Branch & Checkout

```bash
# Preferred
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||'
# Fallback
git remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}'
# Last resort (anchored — ⊥ substring match on feature branches)
git branch -r --format='%(refname:short)' | grep -Ex 'origin/(main|master|trunk|develop)' | sed 's|origin/||' | head -1
```

Record `default_branch`. Then in `repo_path` = `pwd`:

**Dirty-tree gate (! pass before checkout):**
```bash
[ -z "$(git status --porcelain)" ] || { echo "abort: working tree dirty"; exit 1; }
```
⊥ stash, ⊥ overwrite user state.

**Branch collision gate:**
```bash
git rev-parse --verify --quiet "refs/heads/{branch_name}" && { echo "abort: branch exists — pass new desc or delete"; exit 1; } || true
```

**Checkout:**
```bash
git fetch origin
git checkout {default_branch} && git pull --ff-only || { echo "abort: ff-only failed — local diverged"; exit 1; }
git checkout -b {branch_name}
```

## §3 Dev Subagent

Spawn `general-purpose` w/ `./dev-prompt.md`. Substitute: `{task_description}`, `{branch_name}`, `{repo_path}`, `{type}`. Wait → summary.

**Subagent return contract:** `{status: ok|fail|partial, summary, files_changed, tests_added, assumptions}`. `fail` → abort flow, surface to user. `partial` → still run §4.

## §4 Review Subagent

Spawn `general-purpose` w/ `./review-prompt.md`. Substitute: `{dev_summary}`, `{repo_path}`, `{branch_name}`, `{default_branch}`. Wait → report.

**Verdict parse:** last non-empty line of report ! match `^(PASS|NEEDS FIXES)$`. Malformed → treat as `NEEDS FIXES`, log parse failure.

## §5 Fix Loop

`NEEDS FIXES` → re-dispatch dev subagent w/ review findings → re-dispatch review subagent.
Cap = ≤ 2 dev re-dispatches after initial review (∴ ≤ 3 total reviews). Still `NEEDS FIXES` after cap → surface full last review + branch state to user, stop.

**Crash recovery:** orchestrator dies mid-flow → branch + uncommitted changes preserved. On resume, ⊥ auto-recover. User decides: continue manually | `git checkout {default_branch} && git branch -D {branch_name}`.

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
V3: fix loop cap = ≤ 2 dev re-dispatches after initial review
V4: ∀ subagent → only what it needs, ⊥ session history
V5: working tree ! clean before checkout — ⊥ stash, ⊥ overwrite user state
V6: branch collision → abort, ⊥ auto-suffix
V7: dev-prompt lens count = `irondev-review` lens count. drift → fix dev-prompt before dispatch
V8: subagent return ! match contract (§3). malformed → abort
V9: review verdict parse strict (§4). malformed → `NEEDS FIXES`
