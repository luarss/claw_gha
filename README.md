# OpenClaw on GitHub Actions

Run OpenClaw (a personal AI assistant) on GitHub Actions with persistent memory stored as markdown files.

## Overview

This project runs an AI-powered stock picker agent on GitHub Actions infrastructure. The agent maintains context across runs by persisting memory in markdown files that are committed back to the repository.

## Prerequisites

- Node.js ≥22
- Alibaba Cloud Bailian API key (for Qwen models)
- Google Gemini API key (for web search)

## Repository Structure

```
claw_gha/
├── .github/
│   └── workflows/
│       ├── openclaw.yml          # Main workflow
│       └── test.yml              # Validation tests
├── memory/                        # Persisted memory
│   ├── MEMORY.md                 # Main memory file
│   ├── SOUL.md                   # Agent persona
│   ├── AGENTS.md                 # Workspace guide
│   ├── HEARTBEAT.md              # Periodic check config
│   ├── IDENTITY.md               # Agent identity
│   ├── TOOLS.md                  # Tool configuration
│   ├── USER.md                   # User profile
│   └── skills/
│       └── stock-picker/
│           ├── SKILL.md          # Stock picker skill
│           ├── VALUATION.md      # Valuation formulas
│           ├── CHECKLISTS.md     # Analysis checklists
│           ├── REDFLAGS.md       # Warning signs
│           ├── TERMINOLOGY.md    # Financial terms
│           └── SOURCES.md        # Data sources
├── scripts/
│   ├── sync-memory.sh            # Memory sync utility
│   ├── setup.sh                  # Install & configure
│   └── run-agent.sh              # Execute agent
├── config/
│   └── openclaw.json.template    # Config template
└── README.md
```

## Setup

### 1. Add GitHub Secrets

Add your API keys as repository secrets:

1. Go to Settings → Secrets and variables → Actions
2. Add secret: `BAILIAN_API_KEY` with your Alibaba Cloud Bailian API key
3. Add secret: `GEMINI_API_KEY` with your Google Gemini API key

### 2. Enable Workflows

The workflow runs automatically every 6 hours, or can be triggered manually:

1. Go to Actions tab
2. Select "OpenClaw Agent" workflow
3. Click "Run workflow"
4. Enter your message to the agent

## Local Testing

```bash
# Install OpenClaw
npm install -g openclaw@latest

# Run setup script
./scripts/setup.sh

# Start gateway (background)
openclaw gateway --port 18789 &
sleep 3

# Run agent
openclaw agent --message "Analyze AAPL stock" --model bailian/qwen3.5-plus
```

## Memory Persistence

The agent's memory persists across runs via markdown files in the `memory/` directory:

- `MEMORY.md` - Main memory with watch list, picks, and analysis history
- `SOUL.md` - Agent persona and core principles
- `skills/` - Custom skills for specialized tasks

After each run, updated memory is committed back to the repository with `[skip ci]` to prevent recursive workflow triggers.

## Configuration

Edit `config/openclaw.json.template` to customize:

- Model selection (default: `bailian/qwen3.5-plus`)
- Gateway port (default: 18789)
- Workspace location

## Customization

### Add New Skills

Create a new directory in `memory/skills/` with a `SKILL.md` file:

```markdown
# Skill Name

## Purpose
Description of what this skill does.

## Capabilities
- Capability 1
- Capability 2
```

### Modify Agent Persona

Edit `memory/SOUL.md` to change the agent's behavior and communication style.

## Troubleshooting

### Gateway fails to start
- Check if port 18789 is available
- Verify OpenClaw is installed correctly

### Memory not persisting
- Check file permissions
- Verify git credentials are configured

### API errors
- Verify `BAILIAN_API_KEY` and `GEMINI_API_KEY` secrets are set correctly
- Check API usage limits
