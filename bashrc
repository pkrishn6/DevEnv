#!/bin/bash

#Bash configurations
set noclobber           # do not overwrite exisiting files when redirecting output
umask 022               # set file creation mask so perms are 755
export HISTSIZE=1000    # keep history of last 40 commands
export SAVEHIST=4000    # save last 40 commands to a file
set notify              # notified immediately when background jobs are completed
ulimit unlimited        # coredump size is infinity

function L_PWD {
tmp=${PWD%/*/*};
[ ${#tmp} -gt 0 -a "$tmp" != "$PWD" ] && echo ${PWD:${#tmp}+1} || echo $PWD;
}

BLUE='\[\e[34m\]'
RED='\[\e[31m\]'
YELLOW='\[\e[33m\]'
RESET='\[\e[0m\]'

#set the bash to vi mode
set -o vi
stty -ixon
export TERM="xterm-256color"

#set up the GIT and SVN prompts
source ~/.vim/branch_prompt.sh
export __PLATFORM__=`uname`

if [[ "$__PLATFORM__" == 'Linux' ]]; then
    # Ubuntu
    export PS1="$BLUE\u$YELLOW@$RED [202] $YELLOW"'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
elif [[ "$__PLATFORM__" == 'Darwin' ]]; then
    #MAC
    export PS1="$BLUE\u$YELLOW@$RED"MAC"$YELLOW "'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
fi

#set aliases
if [ -f $HOME/.bash_alias ]; then
source $HOME/.bash_alias
fi

#set dircolors
if [[ "$__PLATFORM__" == 'Linux' ]]; then
# Ubuntu
    #setup the color
    if [ -f "$HOME/.dircolors" ] ; then
                eval $(dircolors -b $HOME/.dircolors)
    fi
fi

# Add $HOME/bin to PATH
export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin:~/gotool/bin"

export SR_CODE_BASE=$HOME/workspace/snaproute
export GOPATH=$HOME/gotool:$SR_CODE_BASE/snaproute/:$SR_CODE_BASE/external/:$SR_CODE_BASE/generated/
export GOROOT=/usr/local/go

# Source code paths
export l3=$SR_CODE_BASE/snaproute/src/l3
export l2=$SR_CODE_BASE/snaproute/src/l2
export asicd=$SR_CODE_BASE/snaproute/src/asicd
export rib=$SR_CODE_BASE/snaproute/src/l3/rib
export mpls=$SR_CODE_BASE/snaproute/src/mpls
export config=$SR_CODE_BASE/snaproute/src/config
export plat=$SR_CODE_BASE/snaproute/src/infra/platformd
export arp=$SR_CODE_BASE/snaproute/src/l3/arp
export ospf=$SR_CODE_BASE/snaproute/src/l3/ospf
export bgp=$SR_CODE_BASE/snaproute/src/l3/bgp
export rel=$SR_CODE_BASE/reltools
export mo=$SR_CODE_BASE/snaproute/src/models/objects
export ven=$SR_CODE_BASE/snaproute/src/vendors
export nsl=$SR_CODE_BASE/snaproute/src/vendors/bcm/opennsl-3.1.0.8-odp

if [[ ":$PATH:" != *":$HOME/bin:"* ]]
then
    export PATH=$HOME/bin:$PATH
fi
