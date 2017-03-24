OS=$(uname)

function reload-bashrc
{
    source ~/.bashrc
}

function find_top_dir
{
    if [ "$0" == "-bash" ]; then
       this_dir=`pwd`
    else
       this_dir=$(cd $(dirname $0) && pwd)
       if [ -n "$top_dir" ]; then
            return 0
       fi
    fi

    origin_dir=`pwd`
    target=$1
    echo current:`pwd`, find:$target 

    while [ ! -d $target ]
    do
        #echo `pwd`
        cd ..
        if [ "`pwd`" == "/" ]; then 
            break 
        fi
    done

    if [ `pwd` == / ]; then
        echo "*** Cannot find top_dir which contains:" $target "***"
        cd $this_dir
        #echo "aaaaaa"
        return 1
    else
        top_dir=`pwd`
        export top_dir
        echo "*** top_dir found: $top_dir ***"
    fi
}
export -f find_top_dir


function check_and_run
{
	if [ -f $1 ]
   	then 
        source $1 
    fi
}

function iconvFile
{
    cf=gbk
    ct=utf8
    for i in $1; do iconv -f $cf -t $ct ${i} > ${i}.bak; mv ${i}.bak ${i}; done
}

#去掉文件每一行最后的0x0d
function trimd
{
    sed  -i "s/\r\$//g" $@
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
export -f adbs

function adbi
{
    if [ x$2 == x ]; then
        adb install -r $1
    else
        adbs $1 install -r $2
    fi
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
    ps aux | grep ssh | grep 9527 | grep 3128 | awk '{print $2;}' | xargs kill -9
    autossh -M 0 -gN -L 9527:0.0.0.0:3128 -o ServerAliveInterval=60 root@mmdai.org 2>/dev/null &
}

function tmsp
{
    tmux split $1 -c $PWD
}

function set_hkp
{
    export hkp_proxy=$1
}

function hkp_do
{
    ipport=${hkp_proxy:-127.0.0.1:9527}
    http_proxy=http://$ipport https_proxy=http://$ipport HTTP_PROXY=http://$ipport HTTPS_PROXY=http://$ipport $@
}

function sock5_do
{
    ipport=${hkp_proxy:-127.0.0.1:1080}
    http_proxy=socks5://$ipport https_proxy=socks5://$ipport $@
}


function tm_setenv
{
    export $1=$2
    tmux set-env $1 $2
}

function tm_upenv
{
    local v
    while read v; do
        if [[ $v == -* ]]; then
            unset ${v/#-/}
        else
            # Add quotes around the argument
            v=${v/=/=\"}
            v=${v/%/\"}
            eval export $v
        fi
    done < <(tmux show-environment)
}


function clone_cc_app
{
    appname=$1
    git clone git@hz.19v5.com:logic/${appname}app.git
    git clone git@hz.19v5.com:res/${appname}res.git
}

#############################################
if [ "$OS" == "Darwin" ] ;then


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
alias ctags="`brew --prefix`/bin/ctags"
alias ls='ls -alG'
alias sed=gsed
alias readlink=greadlink
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
alias open=cygstart
#alias convert="magick convert"
#export CYGWIN="winsymlinks"
export CYGWIN=winsymlinks:native
export JAVA_HOME="/cygdrive/c/Program Files (x86)/Java/jdk1.8.0_31"
export PATH=$PATH:"/cygdrive/c/Program Files (x86)/Java/jdk1.8.0_31/bin"
unset GIT_SSH
function settitle()
{
    echo -ne '\e]0;'$1'\a'
}

fi
 
pwd=$(pwd)
[ -f $pwd/bash.local ] && . $pwd/bash.local
[ -f $pwd/tool/bash.local ] && . $pwd/tool/bash.local
#############################################

alias tmuxk='tmux kill-server'
alias tmuxa='tmux attach'
alias cddof='cd ~/dotfiles'

export PATH=/usr/local/sbin:/usr/local/bin/:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/admin/.sdkman"
#[[ -s "/home/admin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/admin/.sdkman/bin/sdkman-init.sh"
