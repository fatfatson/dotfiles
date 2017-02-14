#!/usr/bin/bash
./setup-x86_64 -q -P wget,tar,qawk,bzip2,subversion,vim
apt-cyg install libevent-devel libncurses-devel make gcc-g++ vim curl tmux
apt-cyg install luajit gdb libzip2-devel bzip2 libzip2 libzip-devel libcurl-devel libjpeg-devel libpng-devel libfreetype-devel libiconv-devel php-iconv libmcrypt-devel
