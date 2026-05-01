---
name: irondev-review
description: Use when reviewing code requiring depth — correctness, abstraction, debuggability, design, and systems thinking. High-risk code, core domain logic, or anything that must be rock-solid.
---

# Irondev Review

5 sequential lenses. ⊥ collapse. V1: summarize before judging.

**Think Anywhere:** ambiguous finding mid-review → stop, reason before reporting.
Triggers: subtle invariant breach, unclear blast radius, competing lens signals, "feels wrong" w/o clear cause.
Reason: what breaks? ∀ callers affected? root cause or symptom? Then report.

## L1 — Correctness (AoPS)

- Decompose cleanly. ∀ code path preserve invariants.
- Boundaries: empty, null, zero, max, overflow, concurrent.
- Prove algo correct. Edge cases = theorems, ⊥ afterthoughts.

Flags: off-by-one, `doX(true)` bool param, magic number, ⊥ base case, deep if-else (⊥ guard clauses)

## L2 — Abstraction (SICP)

- ⊥ barrier leaks. Fns = one nameable idea. Complexity ∝ problem.
- Repeated structure → map/filter/fold. Mutable state minimal & co-located.

Flags: "and then also" fns, bool-flag selectors, raw data passing, setup+process+cleanup as 1 fn, repeated variants (⊥ higher-order)

## L3 — Debuggability (Agans)

- Fresh reader reconstructs intent. ∀ implicit assumption = future bug.
- Errors surface w/ context. State changes observable. One change ⊥ 5 silent breaks.

Flags: `catch (e) {}`, `setTimeout` for sync ops, magic state changes

## L4 — Systems (Unix)

- ∀ open must close (`using`/`defer`/`with`). ⊥ hidden global state.
- Errors propagate. Success → defined shape. Idempotent where relevant.

Flags: global mutation, unclosed resources, error swallowing, shared global coupling

## L5 — Design (Canon)

| Ref | Check |
|-----|-------|
| Clean Code | names reveal intent. fns ≤ 20 lines. ⊥ output args |
| GoF | pattern solves real problem, ⊥ decoration |
| DDD | ubiquitous lang. bounded context. ⊥ cross-domain imports |
| DDIA | consistency guarantees match req. ⊥ accidental eventual consistency |
| EIP | right messaging pattern. ⊥ polling where events fit |
| Pragmatic | DRY on knowledge. orthogonal. ⊥ broken windows |

## Output

```
## Code Review

### Summary
[1-2 frags]

### Critical  (correctness | security)
- [file:line] — [issue] — [why] — [fix]

### Design  (abstraction | arch)
- [file:line] — [lens] — [issue] — [fix]

### Systemic  (debuggability | resources)
- [file:line] — [lens] — [issue] — [fix]

### Style
- [file:line] — [issue] — [fix]

### Strengths
- [specific, ⊥ generic]
```

## V-Rules

V1: ⊥ skip lens
V2: separate lenses, separate passes
V3: strengths ! — ⊥ found = code ⊥ understood
V4: root fix > 5 leaf patches
