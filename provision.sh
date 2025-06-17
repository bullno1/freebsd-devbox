#!/bin/sh -e

# packages
yes | sudo pkg install llvm20 mold cmake ninja vim git python3

# dotfiles
if [ ! -d ~/dotfiles ]
then
	git clone https://github.com/bullno1/dotfiles ~/dotfiles
else
	cd ~/dotfiles
	git pull
	./install.sh
fi

# Vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# vim plugins
vim +BundleInstall +qa

# ycm
YCM_DIR=~/.vim/bundle/YouCompleteMe
if [ ! -f "$YCM_DIR/third_party/ycmd/ycm_core.cpython"* ]
then
	cd $YCM_DIR
	export CC=/usr/local/llvm20/bin/clang
	export CXX=/usr/local/llvm20/bin/clang++
	./install.py --clangd-completer --ninja --verbose || true  # No prebuilt clangd
fi

# clangd
YCM_CLANGD_DIR=~/.vim/bundle/YouCompleteMe/third_party/clangd/output/bin
mkdir -p $YCM_CLANGD_DIR
rm $YCM_CLANGD_DIR/clangd
ln -s /usr/local/llvm20/bin/clangd $YCM_CLANGD_DIR/clangd
