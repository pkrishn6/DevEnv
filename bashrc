#!/bin/bash

#set aliases
if [ -f $HOME/.bash_alias ]; then
	source $HOME/.bash_alias
fi

export SR_CODE_BASE=/home/pkumar/workspace/master
export GOPATH=$SR_CODE_BASE/snaproute:$SR_CODE_BASE/external:$SR_CODE_BASE/generated
export PATH=$PATH:/usr/local/go/bin
export PKG_CONFIG_PATH=$SR_CODE_BASE/build/arm/lib/pkgconfig/:$SR_CODE_BASE/build/x86_64/lib/pkgconfig/

# Source code paths
export l3=$SR_CODE_BASE/snaproute/src/l3
export l2=$SR_CODE_BASE/snaproute/src/l2
export asicd=$SR_CODE_BASE/snaproute/src/asicd
export utils=$SR_CODE_BASE/snaproute/src/utils
export infra=$SR_CODE_BASE/snaproute/src/infra
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

#Working directories
export master=/home/pkumar/workspace/master
export dev=/home/pkumar/workspace/vrf_dev
export vrf=/home/pkumar/workspace/vrf_dev2
export vg=/home/pkumar/workspace/voyager_dev
export cavm=/home/pkumar/workspace/cavm_dev
export rl=/home/pkumar/workspace/release2.0

function L_PWD {
tmp=${PWD%/*/*};
[ ${#tmp} -gt 0 -a "$tmp" != "$PWD" ] && echo ${PWD:${#tmp}+1} || echo $PWD;
}

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
    export PS1="$BLUE\u$YELLOW@$RED [202] $YELLOW"'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
elif [[ "$__PLATFORM__" == 'Darwin' ]]; then
    #MAC
    export PS1="$BLUE\u$YELLOW@$RED"MAC"$YELLOW "'$(L_PWD)'"$RED"'$(__git_ps1)$(__svn_prompt)'" $YELLOW>$RESET"
fi

if [ -f $HOME/scripts/snaproute_scripts ]; then
    . $HOME/scripts/snaproute_scripts
fi
