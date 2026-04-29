# claude-irondev

Two Claude Code skills for writing rock-solid software.

## Skills

### `master-review` — 5-Lens Code Review

Deep code review through five sequential lenses. Each catches what others miss.

| Lens | Source | What it catches |
|------|--------|----------------|
| Problem Correctness | Art of Problem Solving | Wrong algorithms, broken invariants, missed boundaries |
| Abstraction Quality | SICP | Leaky barriers, bloated state, missing higher-order patterns |
| Debuggability | Debugging: 9 Indispensable Rules | Untestable code, swallowed errors, baked-in assumptions |
| Systems Thinking | The Linux Command Line | Unclosed resources, non-composable code, non-idempotent ops |
| Design & Architecture | Clean Code, DDD, DDIA, GoF, PoEAA, EIP, Pragmatic Programmer | Wrong patterns, bounded context violations, consistency bugs |

### `solid-dev` — Orchestrated Dev Cycle

Turns a feature request into a complete, reviewed dev cycle using subagents.

```
user: "add feature X"
        ↓
detect default branch + create worktree
        ↓
dev subagent  →  implements with all 5 canonical rules + TDD
        ↓
review subagent  →  runs master-review on the actual diff
        ↓
fix loop (max 2 iterations)
        ↓
report: branch, files changed, tests added, review verdict
```

You (orchestrator) write zero code. Subagents do the work.

## Install

Copy skills into your Claude Code skills directory:

```bash
git clone git@github.com:arielonoriaga/claude-irondev.git
cp -r claude-irondev/master-review ~/.claude/skills/
cp -r claude-irondev/solid-dev ~/.claude/skills/
```

## Usage

In any Claude Code session:

```
/master-review   # review current code with 5 lenses
/solid-dev       # start a full orchestrated dev cycle
```

## Requirements

- [Claude Code](https://claude.ai/code)
- For `solid-dev`: Claude Code with agent dispatch support (uses the `Agent` tool internally)

## Knowledge Base

Skills encode principles from:

- *The Art of Problem Solving* — Rusczyk
- *Debugging: The 9 Indispensable Rules* — Agans
- *Structure and Interpretation of Computer Programs* — Abelson & Sussman
- *The Linux Command Line* — Shotts
- *Clean Code* — Martin
- *Domain-Driven Design* — Evans
- *Designing Data-Intensive Applications* — Kleppmann
- *Patterns of Enterprise Application Architecture* — Fowler
- *Enterprise Integration Patterns* — Hohpe & Woolf
- *The Pragmatic Programmer* — Thomas & Hunt
- *Design Patterns (GoF)* — Gamma et al.
