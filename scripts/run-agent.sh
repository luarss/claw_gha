#!/bin/bash
set -e

MESSAGE="${1:-Check for updates and continue tasks}"

# Ensure gateway is running
if ! pgrep -f "openclaw gateway" > /dev/null; then
    echo "Starting OpenClaw gateway..."
    openclaw gateway --port 18789 &
    # Health check with timeout (replaces fixed sleep)
    for i in {1..30}; do
        if curl -s http://localhost:18789/health > /dev/null 2>&1; then
            echo "Gateway ready after ${i} attempts"
            break
        fi
        sleep 0.1
    done
fi

# Run the agent
echo "Running OpenClaw agent with message: $MESSAGE"
openclaw agent --message "$MESSAGE" --thinking high

# Sync memory back to repo (incremental)
echo "Syncing memory back to repository..."
rsync -a --delete ~/.openclaw/workspace/ memory/ 2>/dev/null || true

echo "Done!"
