#!/bin/bash

#set aliases
if [ -f $HOME/.bash_alias ]; then
	source $HOME/.bash_alias
fi

function L_PWD {
tmp=${PWD%/*/*};
[ ${#tmp} -gt 0 -a "$tmp" != "$PWD" ] && echo ${PWD:${#tmp}+1} || echo $PWD;
}

export pet=~/petuumos

BLUE='\[\e[34m\]'
RED='\[\e[31m\]'
YELLOW='\[\e[33m\]'
RESET='\[\e[0m\]'

export TERM="xterm-256color"
#set up the GIT and SVN prompts
source ~/.vim/branch_prompt.sh
export __PLATFORM__=`uname`

if [[ "$__PLATFORM__" == 'Linux' ]]; then
    # Ubuntu
    export PS1="$BLUE\u$YELLOW@$RED [VM] $YELLOW"'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
elif [[ "$__PLATFORM__" == 'Darwin' ]]; then
    #MAC
    export PS1="$BLUE\u$YELLOW@$RED"MAC"$YELLOW "'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
fi

if [ -f $HOME/helper ]; then
	. $HOME/helper
fi
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/vagrant/bin
export GOPATH=$HOME/go
