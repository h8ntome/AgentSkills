#!/bin/bash
# Update skills script - fetches latest from upstream repos and updates collection

set -e

REPO_ROOT="/opt/data/hermes-skills-collection"
SKILLS_DIR="$REPO_ROOT/skills"
TEMP_DIR="/tmp/skill-updates"

echo "🔄 Updating skills collection..."

mkdir -p "$TEMP_DIR"

# Function to update a repo
update_repo() {
    local repo_url=$1
    local dest_dir=$2
    local repo_name=$3
    
    echo "  📥 Updating $repo_name..."
    cd "$TEMP_DIR"
    rm -rf "$repo_name"
    git clone --depth 1 "$repo_url" "$repo_name" 2>/dev/null || echo "    ⚠️  Failed to clone $repo_name"
}

# Update all source repos
update_repo "https://github.com/anthropics/skills" "anthropic" "Anthropic"
update_repo "https://github.com/vercel-labs/agent-skills" "vercel" "Vercel"
update_repo "https://github.com/google/skills" "google" "Google"
update_repo "https://github.com/openai/skills" "openai" "OpenAI"
update_repo "https://github.com/addyosmani/agent-skills" "addyosmani" "Addy Osmani"
update_repo "https://github.com/garrytan/gstack" "garrytan" "Garry Tan"
update_repo "https://github.com/MicrosoftDocs/Agent-Skills" "microsoft" "Microsoft"
update_repo "https://github.com/rlespinasse/agent-skills" "rlespinasse" "Rlespinasse"
update_repo "https://github.com/mixedbread-ai/skills" "mixedbread" "Mixedbread"
update_repo "https://github.com/yusufkaraaslan/Skill_Seekers" "skillseekers" "Skill Seekers"
update_repo "https://github.com/peterfei/ai-agent-team" "peterfei" "Peter Fei"
update_repo "https://github.com/nicobailon/visual-explainer" "nicobailon" "Nicobailon"
update_repo "https://github.com/makenotion/skills" "makenotion" "Makenotion"
update_repo "https://github.com/mixedbread-ai/skills" "voltagent" "VoltAgent"

# Copy skills to collection
echo "📋 Copying skills to collection..."

# Anthropic
cp -r "$TEMP_DIR/anthropic/skills/"* "$SKILLS_DIR/anthropic/" 2>/dev/null || true

# Vercel
cp -r "$TEMP_DIR/vercel/skills/"* "$SKILLS_DIR/vercel/" 2>/dev/null || true

# Google
cp -r "$TEMP_DIR/google/skills/cloud/"* "$SKILLS_DIR/google/" 2>/dev/null || true

# OpenAI
cp -r "$TEMP_DIR/openai/skills/.curated/"* "$SKILLS_DIR/openai/" 2>/dev/null || true

# Addy Osmani
cp -r "$TEMP_DIR/addyosmani/skills/"* "$SKILLS_DIR/addyosmani/" 2>/dev/null || true

# Garry Tan
cp -r "$TEMP_DIR/garrytan/"* "$SKILLS_DIR/garrytan/" 2>/dev/null || true

# Microsoft
cp -r "$TEMP_DIR/microsoft/skills/"* "$SKILLS_DIR/microsoft/" 2>/dev/null || true

# Rlespinasse
cp -r "$TEMP_DIR/rlespinasse/skills/"* "$SKILLS_DIR/rlespinasse/" 2>/dev/null || true

# Mixedbread
cp -r "$TEMP_DIR/mixedbread/skills/"* "$SKILLS_DIR/mixedbread/" 2>/dev/null || true

# Skill Seekers
cp -r "$TEMP_DIR/skillseekers/skills/skill-seekers" "$SKILLS_DIR/skillseekers/" 2>/dev/null || true

# Peter Fei
cp -r "$TEMP_DIR/peterfei/.claude/skills/"* "$SKILLS_DIR/peterfei/" 2>/dev/null || true

# Nicobailon
cp -r "$TEMP_DIR/nicobailon/plugins/visual-explainer" "$SKILLS_DIR/nicobailon/" 2>/dev/null || true

# Makenotion
cp -r "$TEMP_DIR/makenotion/skills/notion-cli" "$SKILLS_DIR/makenotion/" 2>/dev/null || true

# VoltAgent (awesome-agent-skills is a curated list, not installable skills)
# Skipping as it's a list, not skills

echo "✅ Skills updated!"
echo "📝 Don't forget to:"
echo "   1. Update skills-index.json"
echo "   2. Update README.md with new counts"
echo "   3. Commit and push changes"

# Cleanup
rm -rf "$TEMP_DIR"