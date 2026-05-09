# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
make install-deps        # Install Ansible Galaxy collections (required before first run)
make run                 # Install deps + run full playbook (site.yml)
make system              # Run only system and homebrew roles
make tools               # Run only configure_tools_and_runtimes.yml
make lint                # Run ansible-lint against the project
make check               # Dry-run the full playbook (--check --diff)
make pull                # ansible-pull: fetch latest repo + execute site.yml non-interactively
```

**Run a single role by tag:**
```bash
ansible-playbook playbooks/site.yml --tags <tag>
```
Available tags: `system`, `homebrew`, `git`, `zsh`, `oh_my_zsh`, `oh_my_posh`, `nvim`, `ghostty`, `vscode`, `python`, `btop`, `claude`, `worktrunk`, `sdkman`, `java`, `maven`

**Pass runtime variables:**
```bash
ansible-playbook playbooks/site.yml -e "pyenv_global_version=3.12.0 homebrew_upgrade_enabled=false"
```

## Architecture

### Playbook structure

`playbooks/site.yml` composes two playbooks in order:

1. **`configure_system.yml`** — targets `local`, runs two pre_tasks (create folders, ensure Homebrew), then applies the `system` and `homebrew` roles.
2. **`configure_tools_and_runtimes.yml`** — targets `local`, interactively prompts for `git_name` / `git_email` (falls back to `GIT_AUTHOR_NAME` / `GIT_AUTHOR_EMAIL` env vars), then applies all tool/dotfile roles.

The inventory is a single host (`inventory/hosts`) pointing at `localhost`. Global variables live in `inventory/group_vars/all.yml`.

### Roles

Each role in `roles/` is self-contained. Roles use a mix of `tasks/`, `defaults/`, `vars/`, `files/`, and `templates/`. Notable patterns:

- **`system`** — dynamically includes all `tasks/*.yml` files except `main.yml` via `fileglob`, so new macOS setting files are picked up automatically.
- **`homebrew`** — package lists live in `roles/homebrew/vars/packages.yml`, organized into named profiles (`general`, `dev`, `work`). Active profiles are selected via `homebrew_profiles_enabled` in `group_vars/all.yml`.
- **`ghostty`** — uses a Jinja2 template (`templates/config.j2`) driven by defaults in `defaults/main.yml`; also configures SSH `~/.ssh/config` for `TERM` fallback.
- **`zsh`** — copies `.zshrc`, generates `.aliases.zsh` from a template (with `workspace_dir` substitution), and copies `utilities.zsh` to the Oh My Zsh custom path.
- **`claude`** — installs Claude Code skills globally via `npx skills add`, idempotent via `args.creates`.

### Adding a new role

```bash
ansible-galaxy init roles/<rolename>
```

Then add `{ role: <rolename>, tags: [<tag>] }` to the appropriate playbook in `playbooks/`.

### Linting

`ansible-lint` runs automatically as a pre-commit hook (`.pre-commit-config.yaml`) and as a PostToolUse Claude Code hook on every YAML file edit. Running `make lint` manually invokes it project-wide.
