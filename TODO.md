### Open issues

1. Requires BECOME / Privileges app to execute HOMEBREW

`ansible-playbook playbooks/site.yaml` gets stuck on installing/updating homebrew packages. 

That's why, I should generally ask for BECOME. However, if `Privileges` app is installed, then request privileges for a given period (e.g. 2 - 5min). Revoke the privileges after the homebrew tasks are done.

```bash
PrivilegesCLI --status
```

> User XXX has standard user privileges

> User XXX has administrator privileges
Administrator privileges expire in 60 minutes



2. Profiles for packages installs (via `brew`) 

Create separate profiles (e.g. dev, personal, etc.) which install a group of predifined packages. For instance, although it's a perfect fit for dev tasks, the pgadmin4 cask is not relevant for everyday use.