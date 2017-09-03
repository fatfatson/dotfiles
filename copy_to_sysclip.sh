#!/bin/bash
OS=$(uname)

text=`cat`
echo "$OS copy_to_sysclip: $text"
if [ -n "$SSH_CLIENT" ]; then
    echo "copy to socket"
    exec 3>/dev/tcp/127.0.0.1/29292
    echo "open socket:"$?
    echo $text >&3
    exec 3>&-
    echo "close socket:"$?

elif [ "$OS" == "Darwin" ] ;then
    echo -n $text|reattach-to-user-namespace pbcopy

elif [[ $OS == CYGWIN* ]]; then
    echo -n $text > /dev/clipboard

else
    echo "not implemented os: "$OS

fi
