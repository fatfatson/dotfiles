#!/bin/bash
OS=$(uname)

echo "syscopy:" $1
if [ "$OS" == "Darwin" ] ;then
    echo -n $1|reattach-to-user-namespace pbcopy

elif [[ $OS == CYGWIN* ]]; then
    echo -n $1 > /dev/clipboard

else
    echo "not implemented os: "$OS

fi
