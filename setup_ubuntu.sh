#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

set_bashrc() {
	cp my-bashrc ~/.my-bashrc
	if ! grep -E "source\s+\~/.my-bashrc" ~/.bashrc >/dev/null 2>&1
	then
		echo 'source ~/.my-bashrc' >> ~/.bashrc
	fi
}

setup_git() {
	sudo apt-get -y install git
	git config --global user.name "Dane"
	git config --global user.email "daneshih1125@gmail.com"
	git config --global alias.ll "log --all --graph --decorate --oneline --simplify-by-decoration"
	git config --global alias.ls "log --name-status"
	git config --global alias.pl "pull --rebase"
}

setup_docker() {
	sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) \
		stable"
	sudo apt-get update
	sudo apt-get -y install docker-ce
}

setup_vim() {
	# vim8
	sudo add-apt-repository -y ppa:jonathonf/vim
	sudo apt-get update
	sudo apt-get -y install vim vim-gtk cscope ctags
	# YouCompleteMe
	sudo apt-get -y install python-dev
	# github repository
	git clone https://github.com/daneshih1125/my-vim.git ${HOME}/.vim
	cp -a ${HOME}/.vim/vimrc ${HOME}/.vimrc

	# Install vundle
	git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/vundle
	# Install all plgin from command line
	vim +BundleInstall +qall

	sudo apt-get -y install cmake
	# install YouCompleteMe
	if [ -f "${HOME}/.vim/bundle/YouCompleteMe/install.sh" ]
	then
		${HOME}/.vim/bundle/YouCompleteMe/install.sh 2>&1 |tee /tmp/YouCompleteMe_install.log
	fi
}

apt_deb_tools() {
	sudo apt-get update
	sudo apt-get -y install apt-file
	apt-file update
	# deb build utils
	sudo apt-get -y install build-essential dh-make fakeroot devscripts pbuilder cdbs
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

apt_deb_tools

set_bashrc

setup_docker

setup_git

setup_vim

python_env

utils_install

ubuntu_kernel_env
