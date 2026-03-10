#!/bin/bash
set -e

MESSAGE="${1:-Check for updates and continue tasks}"
SESSION_ID=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --session-id)
            SESSION_ID="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Ensure gateway is running
if ! pgrep -f "openclaw gateway" > /dev/null; then
    echo "Starting OpenClaw gateway..."
    openclaw gateway --port 18789 &
    # Health check with timeout
    for i in {1..30}; do
        if curl -s http://localhost:18789/health > /dev/null 2>&1; then
            echo "Gateway ready after ${i} attempts"
            break
        fi
        sleep 0.1
    done
fi

# Build agent command
AGENT_CMD="openclaw agent --message \"$MESSAGE\" --thinking high"
if [[ -n "$SESSION_ID" ]]; then
    AGENT_CMD="openclaw agent --session-id $SESSION_ID --message \"$MESSAGE\" --thinking high"
fi

# Run the agent
echo "Running OpenClaw agent with message: $MESSAGE"
eval "$AGENT_CMD"

# Sync memory back to repo (incremental)
echo "Syncing memory back to repository..."
rsync -a --delete ~/.openclaw/workspace/ memory/ 2>/dev/null || true

echo "Done!"
