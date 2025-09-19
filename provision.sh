#!/bin/sh -e

# packages
yes | sudo pkg install llvm20 mold cmake ninja vim git python py311-pip inotify-tools ripgrep

# dotfiles
if [ ! -d ~/dotfiles ]
then
	git clone https://github.com/bullno1/dotfiles ~/dotfiles
fi
cd ~/dotfiles
git pull
./install.sh

# Vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# vim plugins
vim +BundleInstall +qa

# ycm
YCM_DIR=~/.vim/bundle/YouCompleteMe
pip install --user watchdog
if [ ! -f "$YCM_DIR/third_party/ycmd/ycm_core.cpython"* ]
then
	cd $YCM_DIR
	export CC=/usr/local/llvm20/bin/clang
	export CXX=/usr/local/llvm20/bin/clang++
	./install.py --clangd-completer --ninja --verbose || true  # No prebuilt clangd
fi

# clangd
rm -f ~/bin/clangd
ln -s /usr/local/llvm20/bin/clangd ~/bin
