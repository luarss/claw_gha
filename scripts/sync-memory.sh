#!/bin/bash
# Sync memory files between repository and OpenClaw workspace
# Usage: sync-memory.sh [to-workspace|from-workspace]

set -e

WORKSPACE="${HOME}/.openclaw/workspace"
MEMORY_DIR="memory"
MODE="${1:-to-workspace}"

sync_to_workspace() {
    echo "Syncing memory to workspace..."
    if [ -d "$MEMORY_DIR" ] && [ "$(ls -A $MEMORY_DIR 2>/dev/null)" ]; then
        mkdir -p "$WORKSPACE"
        cp -r "$MEMORY_DIR"/* "$WORKSPACE/"
        echo "✓ Memory synced to workspace"
    else
        echo "Warning: No memory files to sync"
        exit 1
    fi
}

sync_from_workspace() {
    echo "Syncing memory from workspace..."
    if [ -d "$WORKSPACE" ] && [ "$(ls -A $WORKSPACE 2>/dev/null)" ]; then
        mkdir -p "$MEMORY_DIR"
        cp -r "$WORKSPACE"/* "$MEMORY_DIR/" || echo "Warning: Some files could not be copied"
        echo "✓ Memory synced from workspace"
    else
        echo "Warning: No workspace files to sync"
        exit 1
    fi
}

case "$MODE" in
    to-workspace)
        sync_to_workspace
        ;;
    from-workspace)
        sync_from_workspace
        ;;
    *)
        echo "Usage: $0 [to-workspace|from-workspace]"
        exit 1
        ;;
esac
