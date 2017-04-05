#! /bin/bash

sudo rm ~/.bashrc ~/.bash_profile ~/.bash_alias ~/.tmux.conf ~/.gitconfig ~/.gitignore ~/.vimrc ~/.dircolors

ln -s ~/.vim/bashrc ~/.bashrc
ln -s ~/.vim/bash_profile ~/.bash_profile
ln -s ~/.vim/bash_alias ~/.bash_alias
ln -s ~/.vim/gitconfig ~/.gitconfig
ln -s ~/.vim/gitignore ~/.gitignore
ln -s ~/.vim/tmux.conf ~/.tmux.conf
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/dircolor_solarized ~/.dircolors
ln -s ~/.vim/mrconfig ~/.mrconfig

__platform__=`uname`
if [[ "$__platform__" == 'Linux' ]]; then
    sudo apt-get -y --force-yes install `cat app.list`
fi


