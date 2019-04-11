#!/bin/bash


alias dkm=docker-machine
alias dkmls="docker-machine ls -t 2"

function npm-source {
    if [ x$1 == xreset ]; then
        yarn config set registry https://registry.yarnpkg.com
        npm config set registry https://registry.npmjs.org/
    elif [ x$1 == xtb ]; then
        yarn config set registry https://registry.npm.taobao.org
        npm config set registry https://registry.npm.taobao.org
    elif [ x$1 == x31 ]; then
        yarn config set registry http://192.168.1.31:4873
        npm config set registry http://192.168.1.31:4873
    elif [ x$1 == xrm ]; then
        yarn config delete registry 
        npm config delete registry 
    elif [ x$1 == x ]; then
        yarn config get registry 
        npm config get registry 
    fi
}
