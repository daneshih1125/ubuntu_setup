#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

set_bashrc() {
	set_o_vi=$(grep -E "set\s*-o\s*vi" ~/.bashrc)
	[ "$set_o_vi" = "" ] && echo 'set -o vi' >> ~/.bashrc
}

setup_vim() {
	sudo apt-get -y install vim vim-gtk cscope ctags
	# YouCompleteMe
	sudo apt-get -y install python-dev
	# github repository
	git clone https://github.com/daneshih1125/my-vim.git ~/.vim
	cp -a ~/.vim/vimrc ~/.vimrc

	# Install vundle
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
	# Install all plgin from command line
	vim +BundleInstall +qall

	# install YouCompleteMe
	if [ -f "~/.vim/bundle/YouCompleteMe/install.sh" ]
	then
		~/.vim/bundle/YouCompleteMe/install.sh 2>&1 |tee /tmp/YouCompleteMe_install.log
	fi
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

utils_install() {
	sudo apt-get -y install tree meld vbindiff
}

python_env() {
	sudo apt-get -y install ipython ipython-qtconsole python-pip
	sudo pip install pyzmq pycscope
}

apt_tools

set_bashrc

setup_vim

python_env

utils_install

ubuntu_kernel_env
