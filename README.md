# 🛠️ dotfiles & system setup with Ansible

## ✨ Why Ansible?

Managing dotfiles and setting up a new system should be **fast**, **reliable**,
and **reproducible** — without needing to manually install a bunch of things
every time.

Ansible provides a **declarative**, **idempotent**, and **powerful** way to
automate:

- Installing system packages
- Configuring user environments
- Managing dotfiles


## 📦 Requirements
The following are one-time actions which are to be executed on the initial use of the repo.

> [!NOTE]
> Supported Operating System - `MacOS`

### Steps

1. Install [`Ansible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

```bash
brew install ansible
```

2. Clone the repo
```bash
git clone git@github.com:Nikola-Popov/macos-setup.git
```

3. Install Ansible required collections 
```bash
cd macos-setup
```

```bash
ansible-galaxy install -r collections/requirements.yml
```

4. Configure linting via a pre-commit hook
```bash
make setup
```

## 🚀 Usage

```bash
ansible-playbook playbooks/site.yaml
```

## ⚙️ Settings

> [!NOTE]
> This relies on the playbook is executed at least once. Refer to the [Usage](#usage) section to see how.

Manually apply the pre-exported settings (stored in the /settings folder) to their respective tools. 

1. IntelliJ

```
Choose File | Manage IDE Settings | Import Settings from the main menu.

In the Import File Location dialog that opens select the desired archive.

In the Select Components to Import dialog that opens specify the settings to be imported, and click OK. By default, all settings are selected.
```

2. Raycast  
```
Settings | Advanced | Import

Select the .rayconfig file.
```

The rayconfig is password protected. The password is `12345678`.