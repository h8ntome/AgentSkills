# Hermes Agent Skills Collection

A comprehensive collection of AI agent skills curated from top GitHub repositories. This repository contains 500+ skills organized by source, ready for use with Hermes Agent, Claude Code, and other AI coding assistants.

## 📊 Statistics

- **Total Skills:** 500+
- **Sources:** 19 repositories
- **Categories:** 25+
- **Last Updated:** 2026-07-11

## 📁 Repository Structure

```
skills/
├── anthropic/          # 18 skills - Official Anthropic skills for Claude Code
├── vercel/             # 9 skills - Vercel/Next.js production skills
├── google/             # 59 skills - Google Cloud, GKE, Vertex AI, Agent Platform
├── openai/             # 39 skills - OpenAI/Codex CLI, deployment, Figma, Notion
├── addyosmani/         # 16 skills - Senior engineering workflows (Google Chrome)
├── garrytan/           # 59 skills - gstack AI engineering workflow
├── microsoft/          # 191 skills - Azure services, networking, security
├── rlespinasse/        # 8 skills - Verified agent skills (diataxis, drawio, etc.)
├── nicobailon/         # 1 skill - Visual explanation/slide generation
├── makenotion/         # 1 skill - Notion CLI integration
├── mixedbread/         # 3 skills - Search, RAG, parsing with Mixedbread
├── skillseekers/       # 26 skills - Universal doc-to-skill converter
├── voltagent/          # 1 skill - Awesome agent skills curation
├── peterfei/           # 12 skills - AI agent team roles
├── muratcankoylan/     # 16 skills - Context engineering, memory systems, evaluation
├── memodb-io/          # 3 skills - Acontext landing page, daily-logs, user-facts
├── thedotmack/         # 21 skills - Claude-mem: standup, learn-codebase, timeline-report
├── resend/             # 5 skills - Resend CLI, React Email, email best practices
├── airtable/           # 8 skills - Product ops, sales ops, CLI, filters, marketing ops
├── agentskills/        # 1 skill - Agentskills.io specification
└── voltagent/          # 1 skill - Awesome agent skills list
```
├── memodb/             # 3 skills - Acontext memory layer templates
├── thedotmack/         # 21 skills - Claude-mem persistent memory
├── resend/             # 5 skills - Email API, templates, best practices
├── airtable/           # 8 skills - Airtable operations, filters, marketing
└── agentskills/        # 1 skill - Agent Skills specification reference
```

## ⚡ Quick Download

### Option 1: Just Skills (this repo)
```bash
git clone https://github.com/h8ntome/hermes-skills-collection.git
```

### Option 2: Full Hermes Agent + All Skills (Complete Installation)
```bash
# One-command full installation
curl -fsSL https://raw.githubusercontent.com/h8ntome/hermes-skills-collection/main/scripts/install-hermes-full.sh | bash
```

Or manual steps:
```bash
# 1. Install Hermes Agent (if not already installed)
pip install hermes-agent

# 2. Clone this skills collection
git clone https://github.com/h8ntome/hermes-skills-collection.git

# 3. Configure Hermes to use these skills
cat >> ~/.hermes/config.yaml << 'EOF'
skills:
  external_dirs:
    - /path/to/hermes-skills-collection/skills
EOF

# 4. Start Hermes with all skills
hermes chat
```

### Option 3: Docker (Full Stack)
```bash
docker run -d \
  -v /path/to/hermes-skills-collection/skills:/opt/hermes/skills \
  -p 8080:8080 \
  h8ntome/hermes-agent:full-skills
```

## 🚀 Quick Start

### For Hermes Agent
```bash
# Skills are auto-discovered from ~/.hermes/skills/
# Or add external directory in config.yaml:
skills:
  external_dirs:
    - /path/to/hermes-skills-collection/skills
```

### For Claude Code
```bash
# Copy to ~/.claude/skills/
cp -r skills/* ~/.claude/skills/
```

### Manual Usage
```bash
# Load a specific skill
skill_view('google/gke-security')
skill_view('openai/figma-implement-design')
skill_view('garrytan/review')
```

## 📋 Skill Categories

### Cloud & Infrastructure
- **Google Cloud** (59): GKE, Vertex AI, BigQuery, Agent Platform, Cloud Run
- **Microsoft Azure** (191): Functions, Networking, Security, AI, Containers
- **Vercel** (9): Deploy, optimize, React patterns, Next.js
- **Garry Tan/gstack** (59): CEO review, QA, release, iOS testing, browser automation

### AI/ML & LLM
- **Anthropic** (18): Claude API, MCP, document processing, creative tools
- **OpenAI** (39): Codex, Figma, Notion, Playwright, deployment, security
- **Mixedbread** (3): Search, RAG, parsing with Mixedbread
- **Skill Seekers** (26): Universal doc-to-skill converter for 21+ platforms
- **MuraCankoylan** (16): Context engineering, memory systems, evaluation
- **Memodb/Acontext** (3): Memory layer templates for production agents
- **TheDotMack** (21): Claude-mem persistent memory, session management

### Engineering Workflows
- **Addy Osmani** (16): Code review, debugging, spec-driven, TDD, shipping
- **Rlespinasse** (8): Diataxis, draw.io, conventional commits, PR logs
- **Peter Fei** (12): Fullstack, frontend, backend, QA, DevOps, product roles
- **Resend** (5): Email API, React Email, best practices, inbox management
- **Airtable** (8): Operations, filters, marketing ops, activity logging

### Design & Documentation
- **Nicobailon** (1): Visual explainer/slide generation
- **Makenotion** (1): Notion CLI integration
- **AgentSkills** (1): Agent Skills specification reference

## 🔧 Skill Format

Each skill follows the [Agent Skills specification](https://agentskills.io/specification):

```
skill-name/
├── SKILL.md          # Main skill definition (YAML frontmatter + markdown)
├── scripts/          # Optional executable scripts
├── references/       # Optional supporting documentation
├── templates/        # Optional templates
└── assets/           # Optional images, fonts, etc.
```

### SKILL.md Frontmatter
```yaml
---
name: skill-name
description: When to use this skill and what it does
category: category-name
version: 1.0.0
license: MIT
platforms: [macos, linux, windows]
prerequisites:
  env_vars: [API_KEY]
  commands: [curl, jq]
---
```

## 📦 Installation

### Option 1: Clone Full Collection
```bash
git clone https://github.com/h8ntome/hermes-skills-collection.git
```

### Option 2: Install Individual Skills
```bash
# Via npx skills (if available)
npx skills add h8ntome/hermes-skills-collection --skill google/gke-security

# Or manual copy
cp -r skills/google/gke-security ~/.hermes/skills/
```

## 🔄 Maintenance

This collection is updated periodically from upstream sources. To update:

```bash
# Pull latest from this repo
git pull origin main

# Or re-clone specific upstream repos and copy
cd /path/to/hermes-skills-collection
./scripts/update-skills.sh  # (if available)
```

## 📝 Contributing

1. Fork the repository
2. Add new skills in the appropriate category folder
3. Ensure each skill has a valid `SKILL.md` with frontmatter
4. Update this README with the new skill count
5. Submit a PR

## 📄 License

Individual skills retain their original licenses. See each skill's `SKILL.md` or `LICENSE` file.

## 🙏 Sources & Credits

| Source | Repo | Stars |
|--------|------|-------|
| Anthropic | [anthropics/skills](https://github.com/anthropics/skills) | 160K |
| Vercel | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | 28K |
| Google | [google/skills](https://github.com/google/skills) | 14K |
| OpenAI | [openai/skills](https://github.com/openai/skills) | 23K |
| Addy Osmani | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 77K |
| Garry Tan | [garrytan/gstack](https://github.com/garrytan/gstack) | - |
| Microsoft | [MicrosoftDocs/Agent-Skills](https://github.com/MicrosoftDocs/Agent-Skills) | - |
| Rlespinasse | [rlespinasse/agent-skills](https://github.com/rlespinasse/agent-skills) | - |
| Mixedbread | [mixedbread-ai/skills](https://github.com/mixedbread-ai/skills) | - |
| Skill Seekers | [yusufkaraaslan/Skill_Seekers](https://github.com/yusufkaraaslan/Skill_Seekers) | - |
| Peter Fei | [peterfei/ai-agent-team](https://github.com/peterfei/ai-agent-team) | - |
| VoltAgent | [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 27K |
| Nicobailon | [nicobailon/visual-explainer](https://github.com/nicobailon/visual-explainer) | - |
| Makenotion | [makenotion/skills](https://github.com/makenotion/skills) | - |
| MuraCankoylan | [muratcankoylan/agent-skills-for-context-engineering](https://github.com/muratcankoylan/agent-skills-for-context-engineering) | - |
| Memodb | [memodb-io/Acontext](https://github.com/memodb-io/Acontext) | - |
| TheDotMack | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | - |
| Resend | [resend/resend-skills](https://github.com/resend/resend-skills) | - |
| Airtable | [airtable/skills](https://github.com/airtable/skills) | - |
| Agentskills.io | [agentskills/agentskills](https://github.com/agentskills/agentskills) | - |

---

**Total: ~500 skills from 19 sources**

*Generated and maintained by Hermes Agent*