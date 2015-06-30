#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

set_bashrc() {
	set_o_vi=$(grep -E "set\s*-o\s*vi" ~/.bashrc)
	[ "$set_o_vi" = "" ] && echo 'set -o vi' >> ~/.bashrc
}


setup_vim() {
	sudo apt-get -y install vim cscope ctags
	[ -d "/tmp/vim" ] && rm -rf /tmp/vim
	git clone https://github.com/daneshih1125/my-vim.git /tmp/vim
	cp -a /tmp/vim/.vim  /tmp/vim/.vimrc ~/
	# Install vundle
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
	# Install all plgin from command line
	vim +BundleInstall +qall
}

apt_tools() {
	sudo apt-get -y install apt-file 
	apt-file update
}

ubuntu_kernel_env() {
	sudo add-apt-repository ppa:canonical-kernel-team/ppa
	sudo apt-get update
	sudo apt-get -y install dpkg-dev libncurses5-dev
}

apt_tools

set_bashrc

setup_vim

ubuntu_kernel_env
