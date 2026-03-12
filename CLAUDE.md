# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

OpenClaw on GitHub Actions — AI-powered investment agents that run on GitHub Actions infrastructure. This is a **configuration + memory repository**, not a traditional code project. There is no package.json, build step, or test suite.

### Two Agents

| Agent | Purpose | Schedule | Model |
|-------|---------|----------|-------|
| **stock-picker** | Individual stock research, find opportunities | Every 6 hours | `bailian/qwen3.5-plus` |
| **portfolio-advisor** | Portfolio allocation, risk management, rebalancing | Weekly (Sunday) | `bailian/qwen3-max-2026-01-23` |

The agents use the [OpenClaw](https://openclaw.dev) CLI framework with:
- **LLM**: Alibaba Bailian (Qwen models)
- **Web search**: Google Gemini
- **Stock prices**: Finnhub API
- **Browser automation**: Chromium (headless, Xvfb on Linux)

## Running Locally (Optional)

```bash
# Setup workspaces
mkdir -p ~/.openclaw/workspace ~/.openclaw/workspace-portfolio-advisor
cp -r memory/*.md ~/.openclaw/workspace/
cp -r memory/portfolio-advisor/*.md ~/.openclaw/workspace-portfolio-advisor/
export HOME && envsubst < config/openclaw.json.template > ~/.openclaw/openclaw.json

# Run agent
openclaw gateway --port 18789 &
openclaw agent --session-id stock-picker --message "..." --thinking high
openclaw agent --session-id portfolio-advisor --message "..." --thinking high
```

Required env vars (put in `.env`): `BAILIAN_API_KEY`, `GEMINI_API_KEY`, `FINNHUB_API_KEY`

## Architecture

### GitHub Actions Workflows

| Workflow | File | Schedule |
|----------|------|----------|
| Stock Picker | `.github/workflows/openclaw.yml` | Every 6 hours |
| Portfolio Advisor | `.github/workflows/portfolio-advisor.yml` | Weekly (Sunday midnight UTC) |

Both workflows: install OpenClaw globally, spin up a gateway on port 18789, run the agent, sync memory back to the repo, then auto-commit with `[skip ci]`.

### Memory System

#### Stock Picker (`memory/`)
Markdown files persisted via git between runs.

| File | Purpose |
|------|---------|
| `SOUL.md` | Investment philosophy (Buffett/Lynch/Druckenmiller/Simons synthesis) |
| `AGENTS.md` | Workspace operation guide, session startup checklist |
| `MEMORY.md` | Active watch list, trade signals, prediction log |
| `TOOLS.md` | API configuration and Finnhub usage notes |
| `IDENTITY.md` / `USER.md` | Agent personality / user profile templates |
| `HEARTBEAT.md` | Periodic task config (empty = no recurring tasks) |
| `memory/YYYY-MM-DD.md` | Daily session logs |

#### Portfolio Advisor (`memory/portfolio-advisor/`)
| File | Purpose |
|------|---------|
| `SOUL.md` | Portfolio philosophy (diversification, risk management, long-term focus) |
| `AGENTS.md` | Portfolio review, allocation, and performance workflows |
| `MEMORY.md` | Current holdings, target allocation, trade log |
| `USER.md` | User risk profile template (to be customized) |

### Skills (`memory/skills/`)
Reusable knowledge modules loaded by the agents:

| Skill | Used By | Purpose |
|-------|---------|---------|
| `stock-picker` | Both | 5-phase investment analysis (Buffett/Lynch/Druckenmiller/Simons) |
| `live-pricing` | Both | Finnhub API wrapper (JS, Python, shell) |
| `quant-portfolio-optimization` | portfolio-advisor | Markowitz, Kelly, Black-Litterman allocation |
| `quant-risk-metrics` | portfolio-advisor | VaR, max drawdown, factor exposure |
| `backtesting` | portfolio-advisor | Validate allocation strategies |
| `quant-performance-metrics` | portfolio-advisor | Sharpe, alpha, beta tracking |

### Configuration (`config/openclaw.json.template`)
Defines both agents in `agents.list`, 8 model options, Gemini web search, gateway on localhost:18789. The setup script fills in API keys from env vars.

## Key Patterns

- **Memory commits use `[skip ci]`** — prevents infinite workflow loops when the agent pushes updated memory
- **Input sanitization** — the workflow strips backticks, `$`, and `\` from user messages before passing to the agent
- **Session IDs** — `stock-picker` or `portfolio-advisor`; changing loses workspace context
- **Thinking mode** — `--thinking high` is required for quality analysis; don't remove it
