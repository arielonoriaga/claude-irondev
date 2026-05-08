<div align="center">

# ⚙️ claude-irondev

**Stop shipping code that breaks under pressure.**

Two [Claude Code](https://claude.ai/code) skills that encode foundational engineering wisdom into your dev workflow —
adversarial master-level code review and a fully orchestrated, self-reviewing dev cycle.

[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-black?logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Skills](https://img.shields.io/badge/skills-2-blue)](#whats-inside)
[![Books](https://img.shields.io/badge/knowledge%20base-15%20books-orange)](#knowledge-base)

</div>

---

## Why irondev?

Most AI-generated code passes the happy path and fails everything else — broken invariants, leaky abstractions, unclosed resources, edge cases never considered.

**`irondev` makes a senior engineer part of every cycle, automatically.**

---

## What's Inside

### `/irondev-review` — 6-Lens Adversarial Code Review

> Not a linter. Not a style check. A systematic review through six lenses — starts with a hostile **devil's advocate** pass that attacks every premise before any other check runs.

| Lens | Source | What It Catches |
|------|--------|----------------|
| **L0 Devil's Advocate** | Hyrum's Law · Chesterton's Fence · YAGNI · reversibility analysis | Unjustified novelty, cargo-cult "best practice", premature abstraction, irreversible change without rationale, removed safeguards |
| **L1 Correctness** | Art of Problem Solving | Off-by-one, overflow, TOCTOU, race conditions, NaN propagation, broken invariants, missed boundaries |
| **L2 Abstraction** | SICP · Hickey (Simple Made Easy) · Ousterhout (PoSD) | Leaky barriers, shallow modules, premature DRY, primitive obsession, god objects, speculative generics |
| **L3 Debuggability** | Debugging: 9 Indispensable Rules (Agans) | Silent failure, lost stack traces, error-without-context, log-and-continue, untestable code |
| **L4 Systems** | Unix philosophy · Postel's Law · CAP · end-to-end principle | Resource leaks, retry storms, thundering herd, split-brain, missing timeouts, unsynchronized shared state |
| **L5 Design** | Clean Code · DDD · DDIA · GoF · PoEAA · EIP · Pragmatic · Refactoring (Fowler) · Domain Modeling Made Functional (Wlaschin) | Anemic models, distributed monoliths, pattern-as-decoration, framework leaking into domain, illegal states representable |

Every critical finding must survive a **steelman counter-argument** before it's reported. Every finding: `file:line` — what's wrong — why — how to fix it. Style preferences are labeled honestly, not disguised as defects.

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
npx skills add -g arielonoriaga/claude-irondev
```

<details>
<summary>curl (no Node required)</summary>

```bash
curl -fsSL https://raw.githubusercontent.com/arielonoriaga/claude-irondev/main/install.sh | bash
```

</details>

<details>
<summary>Manual</summary>

```bash
git clone https://github.com/arielonoriaga/claude-irondev.git
cp -r claude-irondev/skills/irondev-review ~/.claude/skills/
cp -r claude-irondev/skills/irondev ~/.claude/skills/
```

</details>

---

## Update

```bash
npx skills add -g arielonoriaga/claude-irondev
```

Or via curl — same command, always idempotent:

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
| *A Philosophy of Software Design* — Ousterhout | Deep modules, complexity as cost, strategic vs tactical |
| *Simple Made Easy* — Hickey | Untangling > familiarity, complecting as design sin |
| *Refactoring* — Fowler | Named refactorings, code smell catalog |
| *Domain Modeling Made Functional* — Wlaschin | Make illegal states unrepresentable, types as proofs |

Plus engineering laws applied throughout: **Hyrum's Law** (all observable behavior is contract), **Chesterton's Fence** (don't remove what you don't understand), **Postel's Law** (carefully), **CAP** theorem, **end-to-end principle**, **YAGNI**, and the **9 Debugging Rules**.

---

<div align="center">

Built for [Claude Code](https://claude.ai/code) · by [arielonoriaga](https://github.com/arielonoriaga)

</div>
