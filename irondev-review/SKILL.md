---
name: irondev-review
description: Use when reviewing code requiring depth — correctness, abstraction, debuggability, design, and systems thinking. High-risk code, core domain logic, or anything that must be rock-solid.
---

# Irondev Review — Master Code Review

5 sequential lenses. Each catches what others miss. ⊥ collapse — SICP smell ≠ debug smell.

V1: summarize what code does before judging it.

## L1 — Correctness (AoPS)

- **Decomposition:** clean sub-problems | tangled blob?
- **Invariants:** ∀ code path preserve what must hold?
- **Boundaries:** empty, null, zero, max, overflow, concurrent
- **Proof sketch:** informally prove algo correct before trusting
- **Edge cases:** theorems to verify, ⊥ afterthoughts

Flags: off-by-one, unchecked shape assumptions, ⊥ base case

## L2 — Abstraction (SICP)

- **Barriers:** caller knows impl details it shouldn't?
- **State:** mutable state explicit, minimal, co-located?
- **Fns:** capture one nameable idea?
- **Data:** encapsulated | raw-leaked to callers?
- **Higher-order:** repeated structure → map/filter/fold?
- **Proportionality:** simple problem = simple code. complex code → simple problem = wrong level

Flags: "and then also" fns, bool-flag behavior selectors, raw data passing

## L3 — Debuggability (Agans' 9 Rules)

- **Understandability:** fresh reader reconstructs intent from code alone?
- **Reproducibility:** behavior-affecting state observable & isolatable?
- **Observability:** errors surface w/ context? state changes logged?
- **Assumptions:** ∀ implicit assumption = future bug
- **Coupling:** one change → 5 silent breaks?
- **Testability:** make fail deterministically?

Flags: `catch (e) {}`, magic state changes, assumptions baked silently

## L4 — Systems (Unix)

- **Resources:** ∀ open must close — `using`/`defer`/`with`/`try-with-resources`
- **I/O:** buffering, flushing, encoding, backpressure
- **Composability:** ⊥ hidden global-state side effects
- **Exit contract:** errors propagate; success → defined shape
- **Idempotency:** retry-safe? twice-safe?

Flags: global mutation, unclosed resources, error swallowing at boundary

## L5 — Design (Canon)

| Ref | Check |
|-----|-------|
| Clean Code | names reveal intent. fns ≤ 20 lines. one abstraction level. ⊥ output args |
| GoF | pattern solves real problem, ⊥ decoration |
| DDD | ubiquitous lang. bounded context. ⊥ cross-domain imports |
| PoEAA | right data access pattern for scale |
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

## Quick Findings

| Smell | Lens | Verdict |
|-------|------|---------|
| `doX(true)` bool param | SICP | split → 2 named fns |
| `catch (e) { log(e) }` | 9 Rules | swallowed, ⊥ recovery |
| magic number in algo | AoPS | ⊥ boundary proof |
| repo doing biz logic | DDD | bounded context breach |
| shared mutable state | DDIA | race condition |
| `setTimeout` for sync | 9 Rules | race disguised as timing |
| setup+process+cleanup fn | SICP | 3 fns as 1 |
| cross-domain import | DDD | context breach |
| open ⊥ `finally` | Unix | leak on error path |
| deep if-else nesting | AoPS | ⊥ guard clauses |
| repeated structure variants | SICP | ⊥ higher-order |
| shared global coupling | Unix | ⊥ composable |

## V-Rules

V1: ⊥ skip lens — each sees what others miss
V2: separate lenses, separate passes
V3: strengths ! — ⊥ found = code ⊥ understood
V4: fix root causes ⊥ symptoms — 5 leaf-patches = 1 root fix needed
