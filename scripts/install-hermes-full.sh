#!/bin/bash
# install-hermes-full.sh
# One-command full installation of Hermes Agent + all skills

set -e

echo "🚀 Installing Hermes Agent + Complete Skills Collection..."

# Check for Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

# Check for pip
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is required but not installed."
    exit 1
fi

# Install Hermes Agent
echo "📦 Installing Hermes Agent..."
pip3 install --upgrade hermes-agent

# Clone skills collection
SKILLS_DIR="$HOME/hermes-skills-collection"
echo "📥 Cloning skills collection to $SKILLS_DIR..."
if [ -d "$SKILLS_DIR" ]; then
    echo "📂 Directory exists, pulling latest..."
    cd "$SKILLS_DIR" && git pull origin main
else
    git clone https://github.com/h8ntome/AgentSkills.git "$SKILLS_DIR"
fi

# Configure Hermes
CONFIG_FILE="$HOME/.hermes/config.yaml"
echo "⚙️ Configuring Hermes Agent..."
mkdir -p "$(dirname "$CONFIG_FILE")"

if [ -f "$CONFIG_FILE" ]; then
    # Check if external_dirs already configured
    if grep -q "external_dirs:" "$CONFIG_FILE"; then
        echo "⚠️ external_dirs already configured in $CONFIG_FILE"
        echo "   Please manually add: $SKILLS_DIR/skills"
    else
        cat >> "$CONFIG_FILE" << EOF

skills:
  external_dirs:
    - $SKILLS_DIR/skills
EOF
        echo "✅ Added skills directory to config"
    fi
else
    cat > "$CONFIG_FILE" << EOF
skills:
  external_dirs:
    - $SKILLS_DIR/skills
EOF
    echo "✅ Created config with skills directory"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 Summary:"
echo "  - Hermes Agent: installed via pip"
echo "  - Skills collection: $SKILLS_DIR"
echo "  - Config updated: $CONFIG_FILE"
echo ""
echo "🚀 To start Hermes with all skills:"
echo "  hermes chat"
echo ""
echo "📚 To verify skills loaded:"
echo "  hermes chat --preload-skills \"anthropic/claude-api,google/gke-security,openai/figma-implement-design\""
echo ""
echo "🔄 To update skills later:"
echo "  cd $SKILLS_DIR && git pull"
echo "  hermes chat  # skills auto-reload on start"