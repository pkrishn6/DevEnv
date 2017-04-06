#!/bin/bash


#set aliases
if [ -f $HOME/.bash_alias ]; then
	source $HOME/.bash_alias
fi

export SR_CODE_BASE=/home/pkumar/workspace/snaproute
export GOPATH=$SR_CODE_BASE/snaproute:$SR_CODE_BASE/external:$SR_CODE_BASE/generated
export PATH=$PATH:/usr/local/go/bin
export PKG_CONFIG_PATH=$SR_CODE_BASE/build/arm/lib/pkgconfig/:$SR_CODE_BASE/build/x86_64/lib/pkgconfig/

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
