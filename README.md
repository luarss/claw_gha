# OpenClaw on GitHub Actions

Run OpenClaw (a personal AI assistant) on GitHub Actions with persistent memory stored as markdown files.

## Overview

This project runs an AI-powered stock picker agent on GitHub Actions infrastructure. The agent maintains context across runs by persisting memory in markdown files that are committed back to the repository.

## Prerequisites

- Node.js ≥22
- Z.AI API key (for GLM-5 model)

## Repository Structure

```
claw_gha/
├── .github/
│   └── workflows/
│       └── openclaw.yml          # Main workflow
├── memory/                        # Persisted memory
│   ├── MEMORY.md                 # Main memory file
│   ├── SOUL.md                   # Agent persona
│   └── skills/
│       └── stock-picker/
│           └── SKILL.md          # Stock picker skill
├── scripts/
│   ├── setup.sh                  # Install & configure
│   └── run-agent.sh              # Execute agent
├── config/
│   └── openclaw.json.template    # Config template
└── README.md
```

## Setup

### 1. Add GitHub Secret

Add your Z.AI API key as a repository secret:

1. Go to Settings → Secrets and variables → Actions
2. Add secret: `ZAI_API_KEY` with your API key value

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
openclaw agent --message "Analyze AAPL stock" --model zai/glm-5
```

## Memory Persistence

The agent's memory persists across runs via markdown files in the `memory/` directory:

- `MEMORY.md` - Main memory with watch list, picks, and analysis history
- `SOUL.md` - Agent persona and core principles
- `skills/` - Custom skills for specialized tasks

After each run, updated memory is committed back to the repository with `[skip ci]` to prevent recursive workflow triggers.

## Configuration

Edit `config/openclaw.json.template` to customize:

- Model selection (default: `zai/glm-5`)
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
- Verify `ZAI_API_KEY` secret is set correctly
- Check API usage limits
