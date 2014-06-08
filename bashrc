OS=$(uname)

function check_and_run
{
	if [ -f $1 ]
   	then 
        source $1 
    fi
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


#############################################
if [ "$OS" == "Darwin" ] ;then

# MacPorts Installer addition on 2013-04-14_at_16:00:44: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

check_and_run /opt/local/etc/bash_completion
check_and_run /opt/local/share/git-core/git-prompt.sh
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
fi

#############################################

alias tmuxk='tmux kill-server'
