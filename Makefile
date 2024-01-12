install-all: install-min install-homebrew-dependencies link-dotfiles ##@install Install complete setup

install-min: install-homebrew link-min-dotfiles install-homebrew-dependencies ##@install Install minimal setup
	make install-oh-my-zsh && \
	make install-asdf-plugins-and-versions

install-homebrew: ##@homebrew Install
	bash -c "./brew/install.sh"

link-min-dotfiles:
	brew install stow && \
	make link-git && \
	make link-zsh

link-dotfiles: link-min-dotfiles link-home-config

dump-homebrew-dependencies: ##@homebrew Dump Homebrew dependencies
	brew bundle dump --brews --taps --describe --force --file=./brew/Brewfile

install-homebrew-dependencies: ##@homebrew Install dependencies
	brew bundle --debug --verbose --no-lock --file=./brew/Brewfile

brew-upgrade-deps: ##@homebrew Upgrade brew dependencies
	brew upgrade --greedy && \
	make dump-homebrew-dependencies && \
	make install-homebrew-dependencies

cleanup-homebrew-dependencies: ##@homebrew Uninstall all dependencies not listed from the Brewfile
	brew bundle cleanup --file=./brew/Brewfile --force && \
	make dump-homebrew-dependencies && \
	make install-homebrew-dependencies

install-oh-my-zsh: ##@oh-my-zsh Install Oh My Zsh
	bash -c "./oh-my-zsh/install.sh"

link-zsh: ##@zsh Link Zsh
	stow --verbose --target=/Users/${USER}/ zsh

link-git: ##@git Link Git
	stow --verbose --restow --ignore=configs --target=/Users/${USER}/ git

link-asdf: ##@asdf Link asdf
	stow --verbose --target=/Users/${USER}/ asdf

link-home-config: ##@home-config Link ~/.config
	mkdir -p /Users/${USER}/.config
	stow --verbose --target=/Users/${USER}/.config/ home_config

install-asdf-plugins-and-versions: link-asdf ##@asdf install asdf plugins and versions
	bash -c "./scripts/install-asdf-plugins.sh" && asdf install

######################################################
################### help generator ###################
######################################################

#COLORS
GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

HELP_DOCS = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (sort keys %help) { \
	print "${WHITE}$$_:${RESET}\n"; \
	for (@{$$help{$$_}}) { \
	$$sep = " " x (48 - length $$_->[0]); \
	print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	}; \
	print "\n"; }

help: ##@other Show this help.
	@perl -e '$(HELP_DOCS)' $(MAKEFILE_LIST)
