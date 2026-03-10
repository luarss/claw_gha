#!/bin/bash
set -e

MESSAGE="${1:-Check for updates and continue tasks}"

# Ensure gateway is running
if ! pgrep -f "openclaw gateway" > /dev/null; then
    echo "Starting OpenClaw gateway..."
    openclaw gateway --port 18789 &
    sleep 5
fi

# Run the agent
echo "Running OpenClaw agent with message: $MESSAGE"
openclaw agent --message "$MESSAGE" --thinking high

# Sync memory back to repo
echo "Syncing memory back to repository..."
cp -r ~/.openclaw/workspace/* memory/ 2>/dev/null || true

echo "Done!"
