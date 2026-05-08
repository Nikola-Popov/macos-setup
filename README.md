# 🏗️ Automated Tools & Environment Management for macOS

## ✨ Overview

(Almost) fully automated solution for configuring and personalizing your macOS environment using [Ansible](https://www.ansible.com/).

It streamlines the installation of essential tools, dotfiles, system settings, and developer utilities, making your Mac ready for productivity in minutes.

> [!WARNING]
> Supported Operating System - `MacOS`

### 🤔 Why Ansible?

Managing dotfiles and setting up a new system should be **fast**, **reliable**,
and **reproducible** — without needing to manually install a bunch of things
every time.

Ansible provides a **declarative**, **idempotent**, and **powerful** way to
automate:

- Installing system packages
- Configuring user environments
- Managing dotfiles

### 🧰 Features

- **Homebrew & Package Management**: Installs and updates Homebrew, plus your favorite CLI and GUI apps.
- **Dotfiles & Configs**: Deploys custom dotfiles for zsh, nvim, git, and more.
- **System Tweaks**: Automates macOS settings (Dock, Finder, keyboard, mouse, trackpad, software updates).
- **Developer Tools**: Installs SDKMAN, Java, Maven, VS Code extensions, and more.
- **Shell Enhancements**: Sets up Oh My Zsh, Oh My Posh, aliases, and utilities.
- **Modular Roles**: Easily extend or customize with Ansible roles for each component.
- **Profile-Based Packages**: Install different tool sets per machine type via `homebrew_profiles_enabled`.
- **Makefile Shortcuts**: Common operations available as `make` targets for convenience.

---

## ⚡ Quick Usage

```bash
make pull
```

This runs `ansible-pull` to fetch the latest version of this repo and execute the full playbook in one step.

### ⚙️ Dynamic Configuration (Extra Vars)

Below is a list of all variables you can modify at runtime to customize your setup.

| Variable                         | Type    | Example Value                                 | Description                                                 |
|----------------------------------|---------|-----------------------------------------------|-------------------------------------------------------------|
| `git_name`                       | string  | `git_name='Your Name'`                        | Sets your global Git user name (prompted interactively)     |
| `git_email`                      | string  | `git_email=user@example.com`                  | Sets your global Git email address (prompted interactively) |
| `pyenv_global_version`           | string  | `pyenv_global_version=3.11.6`                 | Sets the global Python version for pyenv                    |
| `pyenv_python_versions`          | list    | `pyenv_python_versions=['3.11.6','3.12.2']`   | List of Python versions to install with pyenv               |
| `sdkman_sapmachine_java_version` | integer | `sdkman_sapmachine_java_version=17`           | Sets the SAP Machine Java version with SDKMAN               |
| `workspace_dir`                  | string  | `workspace_dir=/Users/me/workspace`           | Sets your workspace directory                               |
| `homebrew_profiles_enabled`      | list    | `homebrew_profiles_enabled=['general','dev']` | Selects which package profiles to install                   |
| `homebrew_upgrade_enabled`       | bool    | `homebrew_upgrade_enabled=false`              | Skip `brew upgrade` during re-runs to save time             |

#### Git Credentials

The playbook will **prompt interactively** for `git_name` and `git_email`. You can provide them in three ways:

1. **Interactive**: Answer the prompts when running the playbook
2. **Environment variables**: Set `GIT_AUTHOR_NAME` and `GIT_AUTHOR_EMAIL` before running

   ```bash
   # Option 2: Using environment variables
   export GIT_AUTHOR_NAME="Your Name"
   export GIT_AUTHOR_EMAIL="you@example.com"
   ```

3. **Extra vars**: Pass `-e "git_name='Your Name' git_email='you@example.com'"`

#### Examples

You can customize your setup by passing variables to Ansible using the `-e` flag.  
This lets you set values directly (like `key=value`), or load them from a JSON or YAML file (using `@filename`).  
You can use `-e` as many times as you need in one command.

1. Pass variables directly with `-e`:

   ```bash
   ansible-pull \
     ...
     -e "git_name='Your Name' pyenv_global_version=3.11.6 workspace_dir=/Users/me/workspace" \
     playbooks/site.yml
   ```

   or

    ```bash
   ansible-pull \
     ...
     -e "git_name='Your Name'" \
     -e "pyenv_global_version=3.11.6" \
     -e "workspace_dir=/Users/me/workspace" \
     playbooks/site.yml
   ```

2. Create a YAML file (e.g. `myvars.yml`) with your variables:
  Store your configuration in a file for easy reuse and sharing.

   ```yml
   git_name: "Your Name"
   pyenv_global_version: "3.11.6"
   workspace_dir: "/Users/me/workspace"
   ```

   Then run:

   ```bash
   ansible-pull \
     ...
     -e @myvars.yml \
     playbooks/site.yml
   ```

---

## 📝 Additional Post-Setup Manual Actions

There are steps which cannot be automated completely. Therefore, manually apply the pre-exported settings (stored in the /settings folder) to their respective tools.

> [!NOTE]
> This relies on the playbook is executed at least once. Refer to the '⚡ Quick Usage' or '🛠️ Local Setup' sections to see how.

### 💻 IntelliJ

```text
Choose File | Manage IDE Settings | Import Settings from the main menu.

In the Import File Location dialog that opens select the desired archive.

In the Select Components to Import dialog that opens specify the settings to be imported, and click OK. By default, all settings are selected.
```

### 🌟 Raycast

```text
Settings | Advanced | Import

Select the .rayconfig file.
```

> [!NOTE]
> The rayconfig is password protected. The password is `12345678`.

### 🔑 Authenticate with GitHub using Git Credential Manager

Git Credential Manager (GCM) provides secure credential storage and authentication for Git. To log in to GitHub and securely cache your credentials, run:

```bash
git-credential-manager github login --url https://github.com/
```

This command will:

1. Open a browser window where you’ll be prompted to sign in to GitHub.

2. Authenticate either with your GitHub username/password + 2FA, or using a personal access token (PAT).

3. Store the credentials securely in your system’s credential store (e.g., Windows Credential Manager, macOS Keychain, or Linux Secret Service).

4. Once authenticated, Git will automatically use these stored credentials for future operations (such as git clone, git pull, and git push) without asking for your password again.

---

## 🧑‍💻 Development

### 🛠️ Local Setup

Prepare the environment with these one-time actions.

```bash
# clone the project and navigate to it
git clone git@github.com:Nikola-Popov/macos-setup.git && cd macos-setup
```

Install dependencies and run the full playbook:

```bash
make install-deps
make run
```

#### 🎯 Available Make Targets

| Target              | Description                                                |
|---------------------|------------------------------------------------------------|
| `make run`          | Install deps and run the full playbook                     |
| `make system`       | Run only the `system` and `homebrew` roles                 |
| `make tools`        | Run only the tools and runtimes playbook                   |
| `make lint`         | Run `ansible-lint` against the project                     |
| `make check`        | Dry-run the full playbook (`--check` mode)                 |
| `make install-deps` | Install Ansible Galaxy collections from `requirements.yml` |
| `make pull`         | Run `ansible-pull` to fetch and execute the latest version |

#### 🏷️ Selective Role Execution (Tags)

Every role is tagged so you can re-run a single role without touching others:

```bash
# re-run only the git and zsh roles
ansible-playbook playbooks/site.yml --tags git,zsh

# re-run only the homebrew role (update packages)
ansible-playbook playbooks/site.yml --tags homebrew
```

Available tags: `system`, `homebrew`, `git`, `zsh`, `oh_my_zsh`, `oh_my_posh`, `nvim`, `ghostty`, `sdkman`, `java`, `vscode`, `python`, `btop`, `claude`.

### 🧩 Extending & Customization

#### 🪛 New workflows

Add or modify roles in `roles/` to suit your workflow. Create a new role in `roles/` by:

```bash
ansible-galaxy init roles/<rolename>
```

Later, include the role in one of the playbooks in `playbooks/`, so that it's picked-up and executed by Ansible.

#### 📦 Profile-Based Installation of Homebrew packages

Packages are grouped under named profiles (`general`, `dev`, `work`) in `roles/homebrew/vars/packages.yml`. You can define multiple profiles and selectively enable them to control which packages are installed.

```yml
# Example package grouping
homebrew_package_profiles:
  general:
    packages:
      - eza
      - neovim
    cask_packages:
      - raycast

  dev:
    packages:
      - node
    cask_packages:
      - intellij-idea-ce

  work:
    packages:
      - kubernetes-cli
      - helm
    cask_packages:
      - docker
```

Then in `group_vars/all.yml` decide which profiles to enable:

```yml
# Example package group/profile selection
homebrew_profiles_enabled:
  - general
  - dev
  - work
```

#### 🧩 Install VS Code Extensions

VS Code extensions are defined as a YAML list in `roles/vscode/defaults/main.yml`. Each entry is the unique extension identifier (for example, `ms-python.python`).

You can find the extension identifier on the extension's page in the VS Code Marketplace, as shown below:

![VS Code Extensions](docs/images/vs-code-id.png)

To install a new extension, add its identifier to `vscode_extensions` in `roles/vscode/defaults/main.yml` and re-run the playbook with `--tags vscode`.

---

## 📜 License

This project is licensed under the MIT License.  
You are free to use, modify, and distribute this software with proper attribution. See the [MIT License](LICENSE) file for full details.
