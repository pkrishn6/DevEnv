#!/bin/bash

# SSH
#   -L local_PORT:remote_IP:remote_PORT
#       maps the local port to remote IP and port while sending it on the ip_sec
#       tunnel
#   -N do not excecute remote command, meaning no CLI just tunnel.








# Local variables
RED="\e[1;31m"
NORMAL="\e[0m"
IPTABLES="/sbin/iptables"
GCONFTOOL="/usr/bin/gconftool-2"
SSH="/usr/bin/ssh"
SUDO="/usr/bin/sudo"
SLEEP="/bin/sleep"
SSHFS="/usr/bin/sshfs"
FUSERMOUNT="/bin/fusermount"

# Timestamp function
timestamp() {
    ENDTIME=`date +%s`
    TS=`date | awk -F" " '{ print $4; }'`
    printf "${RED}[$TS]${NORMAL} "
}

# Sudo function
sudo() {
    # Get the user password and start sudo session
    $SUDO -k
    while :
    do
        timestamp
        read -s -p "Please enter your Ubuntu password: " SUDOPW
        echo $SUDOPW | $SUDO -v -S 2> /dev/null
        if [ $? -eq 0 ]; then
            break
        fi
        printf "\n"
    done
    printf "\n"
}

# Cleanup function
cleanup() {
    # Cleanup shit
    timestamp
    printf "Resetting firewall\n"
    $SUDO $IPTABLES -t nat -F
    $SUDO $IPTABLES -t nat -X
    $SUDO $IPTABLES -t nat -Z

    # Destroying tunnels if any
    timestamp
    printf "Destroying tunnels\n"
    $SUDO kill `ps axf | grep -v grep | grep "ssh -N -f -p" | awk -F" " '{print $1;}'` > /dev/null 2>&1
}

# Proxy switching function
proxy() {
    # Empty means we need to set the Ericsson proxy
    PROXY=""
    if [ -z $1 ]; then
        PROXY=`$GCONFTOOL --get /system/http_proxy/host`
    elif [ "$1" = "home" ]; then
        PROXY=$1
    fi

    # Apply the proper config
    if [ "$PROXY" != "" ]; then
        timestamp
        printf "Clearing proxy settings\n"
        $GCONFTOOL --set /system/http_proxy/host --type string ""
        $GCONFTOOL --set /system/http_proxy/port --type int 0
        $GCONFTOOL --set /system/http_proxy/use_http_proxy --type bool 0
        $GCONFTOOL --set /system/http_proxy/use_same_proxy --type bool 1
        $GCONFTOOL --set /system/proxy/ftp_host --type string ""
        $GCONFTOOL --set /system/proxy/ftp_port --type int 0
        $GCONFTOOL --set /system/proxy/secure_host --type string ""
        $GCONFTOOL --set /system/proxy/secure_port --type int 0
        $GCONFTOOL --set /system/proxy/socks_host --type string ""
        $GCONFTOOL --set /system/proxy/socks_port --type int 0
        $GCONFTOOL --set /system/proxy/mode --type string "none"
    else
        timestamp
        printf "Setting Ericsson proxy\n"
        $GCONFTOOL --set /system/http_proxy/host --type string "proxy-blue.sj.us.am.ericsson.se"
        $GCONFTOOL --set /system/http_proxy/port --type int 3128
        $GCONFTOOL --set /system/http_proxy/use_http_proxy --type bool 1
        $GCONFTOOL --set /system/http_proxy/use_same_proxy --type bool 1
        $GCONFTOOL --set /system/proxy/ftp_host --type string "proxy-blue.sj.us.am.ericsson.se"
        $GCONFTOOL --set /system/proxy/ftp_port --type int 3128
        $GCONFTOOL --set /system/proxy/secure_host --type string "proxy-blue.sj.us.am.ericsson.se"
        $GCONFTOOL --set /system/proxy/secure_port --type int 3128
        $GCONFTOOL --set /system/proxy/socks_host --type string "proxy-blue.sj.us.am.ericsson.se"
        $GCONFTOOL --set /system/proxy/socks_port --type int 3128
        $GCONFTOOL --set /system/proxy/mode --type string "manual"
    fi
}

# NFS mount switching function
mount() {
    # Decide if we need to mount or unmount
    MOUNTED=`ps axf | grep -v grep | grep "sshfs lxlogin.redback.com" | wc -l`
    if [ $MOUNTED -eq 0 ]; then
        timestamp
        printf "Mounting NFS filesystem\n"
        $SSHFS lxlogin.redback.com:/project/swbuild10/spitchai/ /home/spitchai/Redback/project
        $SSHFS lxlogin.redback.com:/home/spitchai/ /home/spitchai/Redback/home
    else
        timestamp
        printf "Unmounting NFS filesystem\n"
        $FUSERMOUNT -u /home/spitchai/Redback/project
        $FUSERMOUNT -u /home/spitchai/Redback/home
    fi
}

# Fire up SVI
connect() {
    # Establish SVI tunnel
    timestamp
    printf "Connecting to Ericsson network\n"

    # Start with a cleanup
    cleanup

    # Establish SVI tunnel
    timestamp
    printf "Establishing SVI tunnel\n"
    $SSH -N -f -p 22 -o ServerAliveInterval=20 spitchai@svi.sj.us.ericsson.net -L 2222:lxlogin.redback.com:22

    # Establish other tunnels
    timestamp
    printf "Establishing Ericsson tunnels\n"
    $SSH -N -f -p 2222 -o ServerAliveInterval=20 localhost -L 3128:proxy-blue.sj.us.am.ericsson.se:3128 -L 9993:mail-am.internal.ericsson.com:993 -L 2225:smtp-am.internal.ericsson.com:25 -L 1533:sametime.ericsson.se:1533 -L 3389:ecd.ericsson.se:389

    # Update iptables
    timestamp
    printf "Configuring iptables\n"
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d proxy-blue.sj.us.am.ericsson.se --dport 3128 -j DNAT --to 127.0.0.1:3128
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d mail-am.internal.ericsson.com --dport 993 -j DNAT --to 127.0.0.1:9993
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d smtp-am.internal.ericsson.com --dport 25 -j DNAT --to 127.0.0.1:2225
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d sametime.ericsson.se --dport 1533 -j DNAT --to 127.0.0.1:1533
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d ecd.ericsson.se --dport 389 -j DNAT --to 127.0.0.1:3389
    $SUDO $IPTABLES -t nat -A OUTPUT -p tcp -d lxlogin.redback.com --dport 22 -j DNAT --to 127.0.0.1:2222

    # Change proxy settings
    proxy ericsson

    # Restart things
    killall evolution
    killall pidgin

    # Mount NFS filesystem
    #mount
}

# Disconnect SVI
disconnect() {
    # Disconnect SVI
    timestamp
    printf "Disconnecting from Ericsson network\n"

    # Unmount NFS filesystem
    #mount

    # Reset firewall and tunnels
    cleanup

    # Reset proxy
    #proxy home
}

# SVI functionality
svi() {
    # Decide if we need to connect or disconnect
    TUNNELS=`ps axf | grep -v grep | grep "ssh -N -f -p" | wc -l`
    if [ $TUNNELS -ne 2 ]; then
        connect
    else
        disconnect
    fi
}


# # # # # # # # # # # # # # # # # # # # # # # # # # #
#                    DEMUX KEYWORD                  #
# # # # # # # # # # # # # # # # # # # # # # # # # # #
ARGS=("$@")
KEYWORD=${ARGS[0]}
shift 1
case $KEYWORD in
    '')
        sudo
        svi
        ;;

    d|disconnect|c|cleanup)
        sudo
        disconnect
        ;;

    p|proxy)
        proxy $@
        ;;

    m|mount)
        mount
        ;;
esac

# Kill sudo session
$SUDO -k

# Ready
timestamp
printf "Have fun!\n"
$SLEEP 1

exit 0

