#!/bin/env bash

set -e

install_dependencies() {
	sudo apt install -y gnupg2 pinentry-curses
}

restart_gpg_agent() {
	gpgconf --kill gpg-agent
	gpgconf --launch gpg-agent
}

setup() {
	install_dependencies

	gpg --full-generate-key

	cp ./git-credential-gpg $HOME/.git-credential-gpg

	chmod +x $HOME/.git-credential-gpg

	git config --global credential.helper "$HOME/.git-credential-gpg"

	mkdir -p $HOME/.gnupg
	cp ./gpg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
	cp ./gpg/gpg.conf $HOME/.gnupg/gpg.conf

	chmod 700 $HOME/.gnupg
	chmod 600 $HOME/.gnupg/*

	restart_gpg_agent
}

setup
