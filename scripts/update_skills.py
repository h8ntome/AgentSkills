#!/usr/bin/env python3
import os
import sys
import shutil
import subprocess
import yaml
import json
from datetime import datetime

# Resolve repository paths dynamically
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.dirname(SCRIPT_DIR)
SKILLS_DIR = os.path.join(REPO_ROOT, "skills")
TEMP_DIR = os.path.join(REPO_ROOT, "temp_sources")
JSON_INDEX_PATH = os.path.join(REPO_ROOT, "skills-index.json")

# Define the 20 upstream sources
SOURCES = {
    "anthropic": {
        "url": "https://github.com/anthropics/skills",
        "copy_rules": [("skills/*", "")],
    },
    "vercel": {
        "url": "https://github.com/vercel-labs/agent-skills",
        "copy_rules": [("skills/*", "")],
    },
    "google": {
        "url": "https://github.com/google/skills",
        "copy_rules": [("skills/cloud/*", "")],
    },
    "openai": {
        "url": "https://github.com/openai/skills",
        "copy_rules": [("skills/.curated/*", "")],
    },
    "addyosmani": {
        "url": "https://github.com/addyosmani/agent-skills",
        "copy_rules": [(".opencode/skills/*", "")],
    },
    "garrytan": {
        "url": "https://github.com/garrytan/gstack",
        "copy_rules": [
            ("skills/*", ""),
            ("browser-skills/*", ""),
        ],
    },
    "microsoft": {
        "url": "https://github.com/MicrosoftDocs/Agent-Skills",
        "copy_rules": [("skills/*", "")],
    },
    "rlespinasse": {
        "url": "https://github.com/rlespinasse/agent-skills",
        "copy_rules": [("skills/*", "")],
    },
    "mixedbread": {
        "url": "https://github.com/mixedbread-ai/skills",
        "copy_rules": [("skills/*", "")],
    },
    "skillseekers": {
        "url": "https://github.com/yusufkaraaslan/Skill_Seekers",
        "copy_rules": [("skills/*", "")],
    },
    "peterfei": {
        "url": "https://github.com/peterfei/ai-agent-team",
        "copy_rules": [(".claude/skills/*", "")],
    },
    "nicobailon": {
        "url": "https://github.com/nicobailon/visual-explainer",
        "copy_rules": [("plugins/*", "")],
    },
    "makenotion": {
        "url": "https://github.com/makenotion/skills",
        "copy_rules": [("skills/*", "")],
    },
    "voltagent": {
        "url": "https://github.com/VoltAgent/awesome-agent-skills",
        "copy_rules": [("*", "")],
    },
    "muratcankoylan": {
        "url": "https://github.com/muratcankoylan/agent-skills-for-context-engineering",
        "copy_rules": [
            ("skills/*", ""),
            ("examples/*", ""),
        ],
    },
    "thedotmack": {
        "url": "https://github.com/thedotmack/claude-mem",
        "copy_rules": [
            ("plugin/skills/*", ""),
            ("openclaw/skills/*", ""),
        ],
    },
    "memodb-io": {
        "url": "https://github.com/memodb-io/Acontext",
        "copy_rules": [
            ("src/server/api/go/configs/skill_templates/*", ""),
            ("landingpage/*", "landingpage"),
        ],
    },
    "resend": {
        "url": "https://github.com/resend/resend-skills",
        "copy_rules": [("skills/*", "")],
    },
    "airtable": {
        "url": "https://github.com/airtable/skills",
        "copy_rules": [("plugins/airtable/skills/*", "")],
    },
    "agentskills": {
        "url": "https://github.com/agentskills/agentskills",
        "copy_rules": [("*", "")],
    },
}

KEPT_DIRS = set(SOURCES.keys())

def clean_skills_directory():
    print("🧹 Cleaning skills/ folder of unwanted directories...")
    if not os.path.exists(SKILLS_DIR):
        os.makedirs(SKILLS_DIR, exist_ok=True)
        return
    for item in os.listdir(SKILLS_DIR):
        item_path = os.path.join(SKILLS_DIR, item)
        if os.path.isdir(item_path) and item not in KEPT_DIRS:
            print(f"Removing unwanted folder: {item}")
            shutil.rmtree(item_path)

def update_sources():
    print(f"📂 Setting up temp directory: {TEMP_DIR}")
    os.makedirs(TEMP_DIR, exist_ok=True)
    
    for name, info in SOURCES.items():
        url = info["url"]
        clone_path = os.path.join(TEMP_DIR, name)
        print(f"\n🔄 Syncing {name} from {url}...")
        
        if os.path.exists(clone_path):
            try:
                # Try pull
                subprocess.run(["git", "pull"], cwd=clone_path, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            except Exception:
                # If pull fails, delete and clone
                shutil.rmtree(clone_path)
                subprocess.run(["git", "clone", "--depth", "1", url, clone_path], check=True)
        else:
            try:
                subprocess.run(["git", "clone", "--depth", "1", url, clone_path], check=True)
            except Exception as e:
                print(f"❌ Failed to clone {url}: {e}")
                continue
        
        # Copy files based on rules
        dst_source_dir = os.path.join(SKILLS_DIR, name)
        os.makedirs(dst_source_dir, exist_ok=True)
        
        # For a clean update, empty the specific destination directory first
        for item in os.listdir(dst_source_dir):
            path = os.path.join(dst_source_dir, item)
            if os.path.isdir(path):
                shutil.rmtree(path)
            else:
                os.remove(path)
                
        import glob
        for rule_src, rule_dst in info["copy_rules"]:
            src_pattern = os.path.join(clone_path, rule_src)
            matched_paths = glob.glob(src_pattern)
            
            sub_dst = os.path.join(dst_source_dir, rule_dst) if rule_dst else dst_source_dir
            os.makedirs(sub_dst, exist_ok=True)
            
            for src_path in matched_paths:
                base_name = os.path.basename(src_path)
                if base_name in {".git", ".github", "LICENSE", "README.md"}:
                    continue
                dest_path = os.path.join(sub_dst, base_name)
                try:
                    if os.path.isdir(src_path):
                        shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
                    else:
                        shutil.copy2(src_path, dest_path)
                except Exception as e:
                    print(f"⚠️ Copy error for {src_path}: {e}")

def fix_broken_symlinks():
    print("\n🔗 Fixing openclaw symlinks...")
    openclaw_do = os.path.join(SKILLS_DIR, "thedotmack", "openclaw", "do", "SKILL.md")
    openclaw_plan = os.path.join(SKILLS_DIR, "thedotmack", "openclaw", "make-plan", "SKILL.md")
    
    for path, target in [(openclaw_do, "../../do/SKILL.md"), (openclaw_plan, "../../make-plan/SKILL.md")]:
        if os.path.exists(os.path.dirname(path)):
            if os.path.islink(path) or os.path.exists(path):
                try:
                    os.remove(path)
                except Exception:
                    pass
            try:
                os.symlink(target, path)
                print(f"Fixed: {path} -> {target}")
            except Exception as e:
                print(f"❌ Failed to fix symlink {path}: {e}")

def generate_index():
    print("\n📝 Generating skills-index.json...")
    skills_list = []
    total_sources = set()
    
    def parse_frontmatter(file_path):
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            if content.startswith('---'):
                parts = content.split('---', 2)
                if len(parts) >= 3:
                    fm_text = parts[1]
                    data = yaml.safe_load(fm_text)
                    return data if isinstance(data, dict) else {}
        except Exception:
            pass
        return {}

    for source in os.listdir(SKILLS_DIR):
        source_path = os.path.join(SKILLS_DIR, source)
        if not os.path.isdir(source_path) or source not in KEPT_DIRS:
            continue
        
        for root, dirs, files in os.walk(source_path):
            if "SKILL.md" in files:
                skill_md_path = os.path.join(root, "SKILL.md")
                rel_path = os.path.relpath(root, SKILLS_DIR)
                fm = parse_frontmatter(skill_md_path)
                
                name = fm.get("name") or os.path.basename(root)
                description = fm.get("description") or ""
                
                skills_list.append({
                    "name": name,
                    "source": source,
                    "path": rel_path.replace(os.sep, '/'),
                    "description": description.strip()
                })
                total_sources.add(source)

    skills_list.sort(key=lambda s: (s["source"], s["name"]))
    
    index_data = {
        "version": 1,
        "generated_at": datetime.now().strftime("%Y-%m-%d"),
        "total_skills": len(skills_list),
        "total_sources": len(total_sources),
        "skills": skills_list
    }

    with open(JSON_INDEX_PATH, 'w', encoding='utf-8') as f:
        json.dump(index_data, f, indent=2, ensure_ascii=False)
        
    print(f"Generated {JSON_INDEX_PATH} successfully!")
    print(f"Total skills indexed: {len(skills_list)}")
    print(f"Total sources: {len(total_sources)}")

def main():
    clean_skills_directory()
    update_sources()
    fix_broken_symlinks()
    generate_index()
    
    # Clean up temp_sources folder
    print(f"\n🧹 Cleaning up temp sources: {TEMP_DIR}")
    shutil.rmtree(TEMP_DIR, ignore_errors=True)
    print("✨ All done!")

if __name__ == "__main__":
    main()
