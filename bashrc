OS=$(uname)

function check_and_run
{
	if [ -f $1 ]
   	then 
        source $1 
    fi
}

#去掉文件每一行最后的0x0d
function trimd
{
    sed  -ibak 's/\x0d$//g' $@
}

function adbs
{
    if [ x$1 == x ]; then
        adb devices | sed '1d'
        return
    fi
    dno=`expr $1 + 1`
    device="-s $(adb devices | sed -n $dno'p' | awk '{print $1}')"
    echo $dno $device
    shift
    adb $device $@
}

function adbi
{
    adb install -r $1
}

function geny
{
    if [ x$1 == x ]; then
        VBoxManage list vms
        return
    fi
    device=$(VBoxManage list vms | sed -n $1'p' | sed 's/\"\(.*\)\".*/\1/g')
    echo $device
    nohup ~/genymotion/player --vm-name "$device"&
}

function run_sshagent
{
    [ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent -s)
    ssh-add
}

function run_goagent_tunnel
{
    ssh -N -L 9527:0.0.0.0:8087 -o ServerAliveInterval=60 -o PreferredAuthentications=password goagent@14.23.145.102
}

function tmsp
{
    tmux split $1 -c $PWD
}


#############################################
if [ "$OS" == "Darwin" ] ;then


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
alias ctags="`brew --prefix`/bin/ctags"
alias ls='ls -alG'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

#############################################
elif [ "$OS" == "Linux" ] ;then

alias api="sudo apt-get install"
alias aps="apt-cache search"
alias sudo='sudo '
alias ls='ls -al --color=auto'

#############################################
elif [[ $OS == CYGWIN* ]]; then
alias ls='ls -al --color=auto'
alias sudo=''
export CYGWIN="winsymlinks:native"
unset GIT_SSH

fi

#############################################

alias tmuxk='tmux kill-server'
alias tmuxa='tmux attach'
export PATH=/usr/local/sbin:$PATH
