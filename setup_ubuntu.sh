#!/bin/bash
set_bashrc() {
	set_o_vi=$(grep -E "set\s*-o\s*vi" ~/.bashrc)
	[ "$set_o_vi" = "" ] && echo 'set -o vi' >> ~/.bashrc
}


setup_vim() {
	sudo apt-get install vim cscope ctags
	[ -d "/tmp/vim" ] && rm -rf /tmp/vim
	git clone https://github.com/daneshih1125/my-vim.git /tmp/vim
	cp -a /tmp/vim/.vim  /tmp/vim/.vimrc ~/
}

apt_tools() {
	sudo apt-get install apt-file 
	apt-file update
}

ubuntu_kernel_env() {
	sudo add-apt-repository ppa:canonical-kernel-team/ppa
	sudo apt-get update
	sudo apt-get install dpkg-dev
}

apt_tools

set_bashrc

setup_vim

ubuntu_kernel_env
