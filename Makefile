.PHONY: run system tools lint check install-deps pull

PLAYBOOK_DIR := playbooks
GALAXY_FILE  := requirements.yml
PULL_REPO    := https://github.com/Nikola-Popov/macos-setup

run: install-deps
	ansible-playbook $(PLAYBOOK_DIR)/site.yml

system: install-deps
	ansible-playbook $(PLAYBOOK_DIR)/site.yml --tags system,homebrew

tools: install-deps
	ansible-playbook $(PLAYBOOK_DIR)/configure_tools_and_runtimes.yml

lint:
	ansible-lint

check: install-deps
	ansible-playbook $(PLAYBOOK_DIR)/site.yml --check --diff

install-deps:
	ansible-galaxy collection install -r $(GALAXY_FILE)

pull:
	ansible-pull \
		-U $(PULL_REPO) \
		-d ~/.ansible/pull/macos-setup \
		-c ~/.ansible/pull/macos-setup/ansible.cfg \
		$(PLAYBOOK_DIR)/site.yml
