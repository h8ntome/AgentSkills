#!/bin/bash
# install-hermes-full.sh
# One-command full installation of Hermes Agent + all skills
# Installs Hermes Agent, wires up the skills collection, then launches
# the Hermes setup wizard directly so you land straight in setup.

set -e

echo "🚀 Installing Hermes Agent + Complete Skills Collection..."

# ---------------------------------------------------------------------------
# 1. Locate or install Hermes Agent
# ---------------------------------------------------------------------------
HERMES_BIN=""

# Prefer an existing container/local install at /opt/hermes
if [ -x "/opt/hermes/.venv/bin/hermes" ]; then
    HERMES_BIN="/opt/hermes/.venv/bin/hermes"
    echo "✅ Found existing Hermes at /opt/hermes"
elif command -v hermes &> /dev/null; then
    HERMES_BIN="$(command -v hermes)"
    echo "✅ Found hermes on PATH: $HERMES_BIN"
else
    echo "📦 Hermes not found — installing hermes-agent..."
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required but not installed."
        exit 1
    fi
    # Prefer uv, fall back to pip
    if command -v uv &> /dev/null; then
        uv pip install --system --upgrade hermes-agent
    elif command -v pip3 &> /dev/null; then
        pip3 install --upgrade hermes-agent
    elif python3 -m pip --version &> /dev/null; then
        python3 -m pip install --upgrade hermes-agent
    else
        echo "❌ Neither uv nor pip found. Install one and re-run."
        exit 1
    fi
    HERMES_BIN="$(command -v hermes)"
    # Bootstrap non-Python deps (node, browser, ripgrep, ffmpeg)
    "$HERMES_BIN" postinstall || true
fi

# ---------------------------------------------------------------------------
# 2. Clone / update the skills collection
# ---------------------------------------------------------------------------
SKILLS_DIR="$HOME/hermes-skills-collection"
echo "📥 Setting up skills collection at $SKILLS_DIR..."
if [ -d "$SKILLS_DIR/.git" ]; then
    echo "📂 Directory exists, pulling latest..."
    cd "$SKILLS_DIR" && git pull origin main
else
    git clone https://github.com/h8ntome/AgentSkills.git "$SKILLS_DIR"
fi

# ---------------------------------------------------------------------------
# 3. Wire skills into the Hermes config
# ---------------------------------------------------------------------------
CONFIG_FILE="$HOME/.hermes/config.yaml"
echo "⚙️  Configuring Hermes Agent..."
mkdir -p "$(dirname "$CONFIG_FILE")"

if [ -f "$CONFIG_FILE" ]; then
    if grep -q "external_dirs:" "$CONFIG_FILE"; then
        if ! grep -q "$SKILLS_DIR/skills" "$CONFIG_FILE"; then
            echo "⚠️  external_dirs exists — add this line manually under it:"
            echo "      - $SKILLS_DIR/skills"
        else
            echo "✅ Skills directory already in config"
        fi
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
echo "✅ Hermes Agent + skills installed."
echo "  - Hermes binary : $HERMES_BIN"
echo "  - Skills        : $SKILLS_DIR/skills"
echo "  - Config        : $CONFIG_FILE"
echo ""

# ---------------------------------------------------------------------------
# 4. Launch the Hermes setup wizard directly
# ---------------------------------------------------------------------------
echo "🧭 Launching Hermes setup wizard..."
echo ""
exec "$HERMES_BIN" setup