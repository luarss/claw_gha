# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

OpenClaw on GitHub Actions — an AI-powered stock analysis agent that runs on GitHub Actions infrastructure every 6 hours. This is a **configuration + memory repository**, not a traditional code project. There is no package.json, build step, or test suite.

The agent uses the [OpenClaw](https://openclaw.dev) CLI framework with:
- **LLM**: Alibaba Bailian (Qwen models via `bailian/qwen3.5-plus` by default)
- **Web search**: Google Gemini
- **Stock prices**: Finnhub API
- **Browser automation**: Chromium (headless, Xvfb on Linux)

## Running Locally

```bash
# First-time setup
./scripts/setup.sh

# Sync memory from repo to OpenClaw workspace
./scripts/sync-memory.sh to-workspace

# Run the agent with a message
./scripts/run-agent.sh "Analyze NVDA"

# Or manually:
openclaw gateway --port 18789 &
openclaw agent --session-id stock-picker --message "..." --thinking high

# After a run, sync memory back
./scripts/sync-memory.sh from-workspace
```

Required env vars (put in `.env`): `BAILIAN_API_KEY`, `GEMINI_API_KEY`, `FINNHUB_API_KEY`

## Architecture

### GitHub Actions Workflow (`.github/workflows/openclaw.yml`)
- Triggers: cron every 6 hours + manual `workflow_dispatch` with optional message
- Installs OpenClaw globally, spins up a gateway on port 18789, runs the agent, syncs memory back to the repo, then auto-commits with `[skip ci]`
- Concurrency: single queue, never cancels in-progress runs
- Timeout: 15 minutes for the agent step

### Memory System (`memory/`)
Markdown files persisted via git between runs. The agent reads these on startup to restore context.

| File | Purpose |
|------|---------|
| `SOUL.md` | Investment philosophy (Buffett/Lynch/Druckenmiller/Simons synthesis) |
| `AGENTS.md` | Workspace operation guide, session startup checklist |
| `MEMORY.md` | Active watch list, trade signals, prediction log |
| `TOOLS.md` | API configuration and Finnhub usage notes |
| `IDENTITY.md` / `USER.md` | Agent personality / user profile templates |
| `HEARTBEAT.md` | Periodic task config (empty = no recurring tasks) |
| `memory/YYYY-MM-DD.md` | Daily session logs |

### Skills (`memory/skills/`)
Reusable knowledge modules loaded by the agent:

- **`stock-picker/`** — 5-phase investment analysis workflow (data freshness → screen → deep dive → risk scoring → recommendation) using 4 investor methodologies
- **`live-pricing/`** — Finnhub API wrapper with implementations in JS, Python, and shell

### Configuration (`config/openclaw.json.template`)
Defines the OpenClaw gateway: 8 Qwen/MiniMax/GLM/Kimi model options, Gemini web search tool, gateway on localhost:18789. The setup script fills in API keys from env vars.

## Key Patterns

- **Memory commits use `[skip ci]`** — prevents infinite workflow loops when the agent pushes updated memory
- **Input sanitization** — the workflow strips backticks, `$`, and `\` from user messages before passing to the agent
- **Session ID** — always `stock-picker`; changing this loses workspace context
- **Thinking mode** — `--thinking high` is required for quality analysis; don't remove it
