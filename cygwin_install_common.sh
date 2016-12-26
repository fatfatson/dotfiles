#!/usr/bin/bash
./setup-x86_64 -q -P wget,tar,qawk,bzip2,subversion,vim
apt-cyg install libevent-devel libncurses-devel make gcc-g++ vim curl tmux
