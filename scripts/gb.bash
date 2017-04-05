#! /bin/bash

#---------------------------------------------------------------
# go_upt()
#
# TODO
#  -> Create a fresh branch and build
#  -> update the exsisting branch and build
#---------------------------------------------------------------
function go_upt()
{
    case "$cmd2" in
        "ct" | "cs" | "tool" )
            if [ "$cmd3" = "." ]
            then
                echo "MAKING the cscope.file..."
                find `pwd` -type f -name "*.[cChH]" >> cscope.files;
                find `pwd` -type f -name '*.asm'  >> cscope.files;
                find `pwd` -type f -name '*.cc' >> cscope.files;
                find `pwd` -type f -name '*.cpp' >> cscope.files;
                find `pwd` -type f -name '*.hh' >> cscope.files;
                find `pwd` -type f -name '*.go' >> cscope.files;
                find `pwd` -type f -name Makefile  >> cscope.files;
                find `pwd` -type f -name README  >> cscope.files;
                echo "cscope -bqv -i ./cscope.files..."
                cscope -bqv -i cscope.files;
                echo "DONE ... "
                echo "Start to build ctags"
                rm -f tags
                ctags -L cscope.files;
                echo "Done"
            fi
        ;;
        * )
            echo "Unknown update request"
        ;;
    esac
}

#---------------------------------------------------------------
# Variable init
#---------------------------------------------------------------
function var_init ()
{
    cmd1=""
    cmd2=""
    cmd3=""
    cmd4=""
    cmd5=""
    marg=""
    cmd_v=""
    dir_=""
    export BR_INFO_DIR=.__branch_info_$(uname)_
    export COMMON_INFO_DIR=.__common_info_
}

#---------------------------------------------------------------
# The Script Starts here
#---------------------------------------------------------------
var_init
if (( $# == 1 ))
then
    cmd1="misc"
    marg=$1

    case "$marg" in
        "-h" | "--h" | "help" | "h" | "-help" )
            cmd1="help"
        ;;
        "setup" )
            cmd1="setup"
        ;;
   esac
else
    cmd1=$1
    cmd2=$2
    cmd3=$3
    cmd4=$4
    cmd5=$5
    cmd6=$6
    cmd7=$7
    cmd8=$8
    cmd_v=$#
fi

#echo " (arg1) : $1 (arg2) : $2 (number of arg) : $# "
#echo " (cmd1) : $cmd1 (cmd2) : $cmd2 (cmd3) : $cmd3
#       (cmd4) : $cmd4 (cmd5) : $cmd5  marg $marg "

case "$cmd1" in
    "setup" )
        echo "setting up .."
        sudo source ~/.vim/scripts/setup.sh
    ;;
    "upt" )
        go_upt
    ;;
    "help" )
        go_help
    ;;
esac
