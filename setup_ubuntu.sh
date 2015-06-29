#!/bin/bash
set_bashrc() {
	set_o_vi=$(grep -E "set\s*-o\s*vi" ~/.bashrc)
	[ "$set_o_vi" = "" ] && echo 'set -o vi' >> ~/.bashrc
}


setup_vim() {
	sudo apt-get install cscope ctags
	git clone https://github.com/daneshih1125/my-vim.git /tmp/vim
	cp -a /tmp/vim/.vim  /tmp/vim/.vimrc ~/
}

apt_tools() {
	sudo apt-get install apt-file 
	apt-file update
}

apt_tools

set_bashrc

setup_vim
