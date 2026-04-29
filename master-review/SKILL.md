---
name: master-review
description: Use when reviewing code requiring depth — correctness, abstraction, debuggability, design, and systems thinking. High-risk code, core domain logic, or anything that must be rock-solid.
---

# Master Code Review

Five sequential lenses. Each catches what others miss. Don't collapse — a SICP smell differs from a debugging smell.

**Iron rule:** Summarize what the code does before judging it.

## Lens 1 — Problem Correctness (AoPS)

- **Decomposition:** Clean sub-problems or tangled blob?
- **Invariants:** Every code path preserve what must always hold?
- **Boundaries:** Empty, null, zero, max, overflow, concurrent
- **Proof sketch:** Informally prove algorithm correct before trusting it
- **Edge cases:** Theorems to verify, not afterthoughts

Flags: off-by-one, unchecked shape assumptions, no base case

## Lens 2 — Abstraction (SICP)

- **Barriers:** Caller knows impl details it shouldn't?
- **State:** Mutable state explicit, minimal, co-located?
- **Functions:** Capture one nameable idea?
- **Data:** Encapsulated or raw-leaked to callers?
- **Higher-order:** Repeated structure → map/filter/fold?
- **Proportionality:** Simple problem = simple code. Complex code for simple problem = wrong level

Flags: "and then also" fns, bool-flag behavior selectors, raw data passing

## Lens 3 — Debuggability (Agans' 9 Rules)

- **Understandability:** Fresh reader reconstructs intent from code alone?
- **Reproducibility:** Behavior-affecting state observable and isolatable?
- **Observability:** Errors surface with context? State changes logged?
- **Assumptions:** Every implicit assumption = future bug
- **Coupling:** One change → five silent breaks?
- **Testability:** Can you make it fail deterministically?

Flags: `catch (e) {}`, magic state changes, assumptions baked silently

## Lens 4 — Systems Thinking (Unix)

- **Resources:** Every open must close — `using`/`defer`/`with`/`try-with-resources`
- **I/O:** Buffering, flushing, encoding, backpressure
- **Composability:** No hidden global-state side effects
- **Exit contract:** Errors propagate; success has defined shape
- **Idempotency:** Retry-safe? Twice-safe?

Flags: global mutation, unclosed resources, error swallowing at boundary

## Lens 5 — Design (Canon)

| Ref | Check |
|-----|-------|
| Clean Code | Names reveal intent. Fns ≤ 20 lines. One abstraction level. No output args |
| GoF | Pattern solves real problem, not decoration |
| DDD | Ubiquitous language. Bounded context. No cross-domain imports |
| PoEAA | Right data access pattern for the scale |
| DDIA | Consistency guarantees match requirement. No accidental eventual consistency |
| EIP | Right messaging pattern. No polling where events fit |
| Pragmatic | DRY on knowledge. Orthogonal. No broken windows |

## Output Format

```
## Code Review

### Summary
[1-2 sentences]

### Critical  (correctness / security)
- [file:line] — [issue] — [why] — [fix]

### Design  (abstraction / architecture)
- [file:line] — [lens] — [issue] — [fix]

### Systemic  (debuggability / resources)
- [file:line] — [lens] — [issue] — [fix]

### Style
- [file:line] — [issue] — [fix]

### Strengths
- [specific, not generic]
```

## Quick Findings

| Smell | Lens | Verdict |
|-------|------|---------|
| `doX(true)` bool param | SICP | Split into two named fns |
| `catch (e) { log(e) }` | 9 Rules | Swallowed, no recovery |
| Magic number in algo | AoPS | No boundary proof |
| Repo doing biz logic | DDD | Bounded context breach |
| Shared mutable state | DDIA | Race condition |
| `setTimeout` for sync | 9 Rules | Race disguised as timing |
| Setup+process+cleanup fn | SICP | Three fns as one |
| Cross-domain import | DDD | Context breach |
| Open without `finally` | Unix | Leak on error path |
| Deep if-else nesting | AoPS | Missing guard clauses |
| Repeated structure variants | SICP | Missing higher-order |
| Shared global coupling | Unix | Non-composable |

## Rules

Never skip a lens — each sees what others miss.
Separate lenses, separate passes.
Strengths required — if none found, code not understood.
Fix root causes not symptoms — five leaf-patches = one root fix needed.
