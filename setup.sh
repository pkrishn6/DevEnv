#! /bin/bash

sudo rm ~/.bashrc ~/.bash_profile ~/.bash_alias ~/.tmux.conf ~/.gitconfig ~/.gitignore ~/.vimrc ~/.dircolors

ln -s ~/.vim/bashrc ~/.bashrc
ln -s ~/.vim/bash_alias ~/.bash_alias
ln -s ~/.vim/gitconfig ~/.gitconfig
ln -s ~/.vim/gitignore_global ~/.gitignore_global
ln -s ~/.vim/vimrc ~/.vimrc
