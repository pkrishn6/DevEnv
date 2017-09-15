#! /bin/bash

sudo rm ~/.bashrc ~/.bash_profile ~/.bash_alias ~/.tmux.conf ~/.gitconfig ~/.gitignore ~/.vimrc ~/.dircolors
sudo rm ~/.vim

ln -s bashrc ~/.bashrc
ln -s gitconfig ~/.gitconfig
ln -s gitignore_global ~/.gitignore_global
ln -s vimrc ~/.vimrc
cp -rf vim/ ~/.vim
