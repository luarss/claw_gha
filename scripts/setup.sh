#!/bin/bash
set -e

# Install OpenClaw
npm install -g openclaw@latest

# Create directories
mkdir -p ~/.openclaw/workspace/memory
mkdir -p ~/.openclaw/workspace/skills

# Copy memory from repo to workspace
if [ -d "memory" ]; then
  cp -r memory/* ~/.openclaw/workspace/memory/
fi

# Generate config
export HOME
envsubst < config/openclaw.json.template > ~/.openclaw/openclaw.json

echo "OpenClaw setup complete"
