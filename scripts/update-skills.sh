#!/bin/bash
# update-skills.sh
# Update the skills collection and reload Hermes

set -e

SKILLS_DIR="$HOME/hermes-skills-collection"
HERMES_DIR="/opt/hermes"

echo "🔄 Updating Hermes Skills Collection..."

if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Skills directory not found at $SKILLS_DIR"
    echo "   Run install-hermes-full.sh first"
    exit 1
fi

cd "$SKILLS_DIR"
git pull origin main

echo "✅ Skills updated successfully!"

# Optional: restart Hermes if running
if pgrep -f "hermes chat" > /dev/null; then
    echo "⚠️  Hermes is running. Restart to load new skills:"
    echo "   pkill -f 'hermes chat'"
    echo "   $HERMES_DIR/.venv/bin/hermes chat"
else
    echo "🚀 Start Hermes to use updated skills:"
    echo "   $HERMES_DIR/.venv/bin/hermes chat"
fi