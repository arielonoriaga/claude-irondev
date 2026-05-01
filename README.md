<div align="center">

# ⚙️ claude-irondev

**Stop shipping code that breaks under pressure.**

Two [Claude Code](https://claude.ai/code) skills that encode 11 foundational engineering books into your dev workflow —
master-level code review and a fully orchestrated, self-reviewing dev cycle.

[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-black?logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Skills](https://img.shields.io/badge/skills-2-blue)](#whats-inside)
[![Books](https://img.shields.io/badge/knowledge%20base-11%20books-orange)](#knowledge-base)

</div>

---

## Why irondev?

Most AI-generated code passes the happy path and fails everything else — broken invariants, leaky abstractions, unclosed resources, edge cases never considered.

**`irondev` makes a senior engineer part of every cycle, automatically.**

---

## What's Inside

### `/irondev-review` — 5-Lens Code Review

> Not a linter. Not a style check. A systematic review through five lenses that each catch different failure modes.

| Lens | Source | What It Catches |
|------|--------|----------------|
| **Problem Correctness** | Art of Problem Solving | Wrong algorithms, broken invariants, missed boundaries |
| **Abstraction Quality** | SICP | Leaky barriers, bloated state, missing higher-order patterns |
| **Debuggability** | Debugging: 9 Indispensable Rules | Untestable code, swallowed errors, baked-in assumptions |
| **Systems Thinking** | The Linux Command Line | Unclosed resources, non-composable code, non-idempotent ops |
| **Design & Architecture** | Clean Code · DDD · DDIA · GoF · PoEAA · EIP · Pragmatic | Wrong patterns, context violations, consistency bugs |

Every finding: `file:line` — what's wrong — why — how to fix it.

---

### `/irondev` — Orchestrated Dev Cycle

> Tell it what to build. It handles the rest.

```
you: "add feature X"
        │
        ▼
  detect default branch + create isolated worktree
        │
        ▼
  dev subagent ── TDD + all 5 canonical rules during implementation
        │
        ▼
  review subagent ── runs /irondev-review on the actual git diff
        │
        ▼
  fix loop ── up to 2 iterations to address findings
        │
        ▼
  report: branch · files changed · tests added · review verdict
```

You stay in the orchestrator seat. Zero implementation code written by you.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/arielonoriaga/claude-irondev/main/install.sh | bash
```

<details>
<summary>Manual</summary>

```bash
git clone https://github.com/arielonoriaga/claude-irondev.git
cp -r claude-irondev/irondev-review ~/.claude/skills/
cp -r claude-irondev/irondev ~/.claude/skills/
```

</details>

---

## Update

Same command — idempotent, always pulls latest:

```bash
curl -fsSL https://raw.githubusercontent.com/arielonoriaga/claude-irondev/main/install.sh | bash
```

---

## Usage

Open any Claude Code session in your repo:

```
/irondev-review    # deep review — 5 lenses, file:line findings
/irondev           # full dev cycle — branch, implement, review, fix, report
```

---

## Knowledge Base

These skills encode decades of hard-won engineering wisdom:

| Book | Principle Applied |
|------|------------------|
| *The Art of Problem Solving* — Rusczyk | Invariant analysis, boundary proofs, decomposition |
| *Debugging: 9 Indispensable Rules* — Agans | Testability, observability, assumption validation |
| *SICP* — Abelson & Sussman | Abstraction barriers, state minimization, higher-order patterns |
| *The Linux Command Line* — Shotts | Resource lifecycle, composability, idempotency |
| *Clean Code* — Martin | Naming, function size, single responsibility |
| *Domain-Driven Design* — Evans | Ubiquitous language, bounded contexts |
| *Designing Data-Intensive Applications* — Kleppmann | Consistency guarantees, distributed correctness |
| *Patterns of Enterprise Application Architecture* — Fowler | Right data access pattern for the scale |
| *Enterprise Integration Patterns* — Hohpe & Woolf | Messaging correctness |
| *The Pragmatic Programmer* — Thomas & Hunt | DRY on knowledge, orthogonality |
| *Design Patterns (GoF)* — Gamma et al. | Patterns that solve real problems, not decoration |

---

<div align="center">

Built for [Claude Code](https://claude.ai/code) · by [arielonoriaga](https://github.com/arielonoriaga)

</div>
