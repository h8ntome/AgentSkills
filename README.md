# 🎯 Hermes Agent Skills Collection

> **500+ production-ready skills** from **20 curated sources** — ready for Hermes Agent, Claude Code, and any AI coding assistant.

[![Skills Count](https://img.shields.io/badge/Skills-500+-brightgreen)](https://github.com/h8ntome/AgentSkills)
[![Sources](https://img.shields.io/badge/Sources-20-blue)](https://github.com/h8ntome/AgentSkills)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Last Updated](https://img.shields.io/badge/Updated-2026--07--11-orange)](https://github.com/h8ntome/AgentSkills/commits/main)

---

## 🎯 Quick Navigation

| | | |
|---|---|---|
| [📦 Quick Install](#-quick-install) | [📁 Repo Structure](#-repository-structure) | [🏷️ Skill Categories](#-skill-categories) |
| [🔧 Skill Format](#-skill-format) | [🔄 Maintenance](#-maintenance) | [🙏 Sources & Credits](#-sources--credits) |

---

## ⚡ Quick Install

### 🎯 Option 1: Just Skills (Recommended)
```bash
git clone https://github.com/h8ntome/AgentSkills.git
```

### 🚀 Option 2: Full Hermes + All Skills (One Command)
```bash
curl -fsSL https://raw.githubusercontent.com/h8ntome/AgentSkills/main/scripts/install-hermes-full.sh | bash
```

### 🐳 Option 3: Docker (Full Stack)
```bash
docker run -d \
  -v /path/to/AgentSkills/skills:/opt/hermes/skills \
  -p 8080:8080 \
  h8ntome/hermes-agent:full-skills
```

### 🛠️ Manual Setup (Hermes Agent)
```bash
# 1. Install Hermes
pip install hermes-agent

# 2. Clone skills
git clone https://github.com/h8ntome/AgentSkills.git

# 3. Add to ~/.hermes/config.yaml
skills:
  external_dirs:
    - /path/to/AgentSkills/skills

# 4. Start!
hermes chat
```

### 🤖 For Claude Code
```bash
cp -r skills/* ~/.claude/skills/
```

---

## 📁 Repository Structure

```
AgentSkills/
├── 📁 skills/                    # 20 skill categories, 500+ skills
│   ├── 📁 anthropic/            # 18  - Official Anthropic skills
│   ├── 📁 vercel/               # 9   - Vercel/Next.js production
│   ├── 📁 google/               # 59  - GKE, Vertex AI, BigQuery
│   ├── 📁 openai/               # 39  - Codex, Figma, Notion, security
│   ├── 📁 addyosmani/           # 16  - Senior eng workflows (Chrome)
│   ├── 📁 garrytan/             # 59  - gstack AI engineering
│   ├── 📁 microsoft/            # 191 - Azure services (full suite)
│   ├── 📁 rlespinasse/          # 8   - Verified agent skills
│   ├── 📁 nicobailon/           # 1   - Visual explainer/slides
│   ├── 📁 makenotion/           # 1   - Notion CLI
│   ├── 📁 mixedbread/           # 3   - Search, RAG, parsing
│   ├── 📁 skillseekers/         # 26  - Universal doc→skill converter
│   ├── 📁 voltagent/            # 1   - Awesome agent skills list
│   ├── 📁 peterfei/             # 12  - AI agent team roles
│   ├── 📁 muratcankoylan/       # 16  - Context engineering, memory
│   ├── 📁 memodb-io/            # 3   - Acontext memory templates
│   ├── 📁 thedotmack/           # 21  - Claude-mem persistent memory
│   ├── 📁 resend/               # 5   - Email API, React Email
│   ├── 📁 airtable/             # 8   - Product/Sales ops, CLI
│   ├── 📁 agentskills/          # 1   - Agentskills.io spec
│   └── 📁 voltagent/            # 1   - Awesome agent skills
├── 📁 scripts/
│   ├── install-hermes-full.sh   # One-command full install
│   └── update-skills.sh         # Daily sync from upstream
├── 📄 README.md
├── 📄 skills-index.json         # Machine-readable skill index
├── 📄 config.example.yaml       # Example Hermes config
└── 📄 LICENSE
```

---

## 🏷️ Skill Categories

### ☁️ Cloud & Infrastructure
| Source | Skills | Description |
|--------|--------|-------------|
| **Microsoft Azure** | 191 | Complete Azure suite: Functions, Networking, Security, AI, Containers |
| **Google Cloud** | 59 | GKE, Vertex AI, BigQuery, Agent Platform, Cloud Run, Cloud SQL |
| **Garry Tan / gstack** | 59 | CEO review, QA, release, iOS testing, browser automation |
| **Vercel** | 9 | Deploy, optimize, React/Next.js patterns |

### 🤖 AI/ML & LLM
| Source | Skills | Description |
|--------|--------|-------------|
| **Anthropic** | 18 | Claude API, MCP, document processing, creative tools |
| **OpenAI** | 39 | Codex, Figma, Notion, Playwright, deployment, security |
| **Mura Cankoylan** | 16 | Context engineering, memory systems, evaluation |
| **TheDotMack** | 21 | Claude-mem: persistent memory, session management |
| **Memodb/Acontext** | 3 | Memory layer templates for production agents |
| **Skill Seekers** | 26 | Universal doc→skill converter (21+ platforms) |
| **Mixedbread** | 3 | Search, RAG, parsing with Mixedbread |

### ⚙️ Engineering Workflows
| Source | Skills | Description |
|--------|--------|-------------|
| **Addy Osmani** | 16 | Senior eng: code review, debugging, TDD, shipping |
| **Peter Fei** | 12 | AI agent team: fullstack, frontend, backend, QA, DevOps |
| **Rlespinasse** | 8 | Verified: Diataxis, draw.io, conventional commits |
| **Resend** | 5 | Email API, React Email, best practices, inbox mgmt |
| **Airtable** | 8 | Product/Sales ops, CLI, filters, marketing ops |

### 🎨 Design & Documentation
| Source | Skills | Description |
|--------|--------|-------------|
| **Nicobailon** | 1 | Visual explainer / slide generation |
| **Makenotion** | 1 | Notion CLI integration |
| **Agentskills.io** | 1 | Agent Skills specification reference |

---

## 🔧 Skill Format

Each skill follows the [Agent Skills specification](https://agentskills.io/specification):

```
skill-name/
├── SKILL.md          # Main definition (YAML frontmatter + markdown)
├── scripts/          # Optional executable scripts
├── references/       # Optional supporting docs
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

---

## 🔄 Maintenance

### Daily/Weekly Sync
```bash
# Auto-sync from all 20 upstream sources
./scripts/update-skills.sh

# Review changes
git diff

# Commit & push
git add -A && git commit -m "Weekly sync: $(date +%F)"
git push origin main
```

### Manual Update (if script unavailable)
```bash
# Re-clone specific upstream repos
cd /path/to/AgentSkills
git pull origin main  # Gets latest curated collection
```

---

## 📦 Installation Options

| Method | Use Case | Command |
|--------|----------|---------|
| **Full Install** | Fresh machine, want everything | `curl -fsSL .../install-hermes-full.sh \| bash` |
| **Skills Only** | Already have Hermes/Claude | `git clone https://github.com/h8ntome/AgentSkills.git` |
| **Docker** | Isolated/containerized | `docker run -v /path/to/skills:/opt/hermes/skills ...` |
| **Individual** | Need just one skill | `cp -r skills/google/gke-security ~/.hermes/skills/` |

---

## 🙏 Sources & Credits

| Source | Repository | ★ Stars |
|--------|------------|---------|
| **Anthropic** | [anthropics/skills](https://github.com/anthropics/skills) | 160K |
| **Vercel** | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | 28K |
| **Google** | [google/skills](https://github.com/google/skills) | 14K |
| **OpenAI** | [openai/skills](https://github.com/openai/skills) | 23K |
| **Addy Osmani** | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 77K |
| **Garry Tan** | [garrytan/gstack](https://github.com/garrytan/gstack) | — |
| **Microsoft** | [MicrosoftDocs/Agent-Skills](https://github.com/MicrosoftDocs/Agent-Skills) | — |
| **Rlespinasse** | [rlespinasse/agent-skills](https://github.com/rlespinasse/agent-skills) | — |
| **Mixedbread** | [mixedbread-ai/skills](https://github.com/mixedbread-ai/skills) | — |
| **Skill Seekers** | [yusufkaraaslan/Skill_Seekers](https://github.com/yusufkaraaslan/Skill_Seekers) | — |
| **Peter Fei** | [peterfei/ai-agent-team](https://github.com/peterfei/ai-agent-team) | — |
| **VoltAgent** | [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 27K |
| **Nicobailon** | [nicobailon/visual-explainer](https://github.com/nicobailon/visual-explainer) | — |
| **Makenotion** | [makenotion/skills](https://github.com/makenotion/skills) | — |
| **Mura Cankoylan** | [muratcankoylan/agent-skills-for-context-engineering](https://github.com/muratcankoylan/agent-skills-for-context-engineering) | — |
| **Memodb** | [memodb-io/Acontext](https://github.com/memodb-io/Acontext) | — |
| **TheDotMack** | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | — |
| **Resend** | [resend/resend-skills](https://github.com/resend/resend-skills) | — |
| **Airtable** | [airtable/skills](https://github.com/airtable/skills) | — |
| **Agentskills.io** | [agentskills/agentskills](https://github.com/agentskills/agentskills) | — |

---

## 📊 Summary

| Metric | Value |
|--------|-------|
| **Total Skills** | 500+ |
| **Sources** | 20 repositories |
| **Categories** | 25+ |
| **Last Updated** | 2026-07-11 |
| **Maintained By** | h8ntome & H-bot |

---

## 📄 License

Individual skills retain their original licenses. See each skill's `SKILL.md` or `LICENSE` file.

---

<p align="center">
  <strong>Generated and maintained by <a href="https://github.com/h8ntome">h8ntome</a> and <a href="https://github.com/h8ntome">H-bot</a></strong>
</p>