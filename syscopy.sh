#!/bin/bash
OS=$(uname)

if [ "$OS" == "Darwin" ] ;then
    echo "syscopy:" $1
    echo -n $1|reattach-to-user-namespace pbcopy
fi
