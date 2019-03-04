OS=$(uname)
[ -f ~/.dotfiles_home ] && source ~/.dotfiles_home

function reload-bashrc
{
    source ~/.bashrc
}

function reload-profile
{
    source ~/.bash_profile
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

function gif2mp4
{
    ffmpeg -f gif -i $1 -pix_fmt yuv420p -c:v libx264 -movflags +faststart -filter:v crop='floor(in_w/2)*2:floor(in_h/2)*2' $1.mp4
}

function git-fix-push
{
    git ca -m "${1:-fix}" && git push
}

function add2path
{
    np=$1
    echo "add_to_path:"$np
    echo "origin:"$PATH_DYNADD
    gsed -i -r 's@(export PATH_DYNADD=)@\1'$np':@g'  ~/dotfiles/bash_profile 

}

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

function adbt
{
    adb shell su root date $(date +%m%d%H%M%Y.%S)
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
    if [ $? -eq 0 ]; then
        tm-setenv SSH_AGENT_PID $SSH_AGENT_PID
        tm-setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK

    fi
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
    finalv=$hkp_proxy
    if [ -z "$finalv" ]; then 
        if [ -f ~/.hkp_proxy ]; then
            finalv=`cat ~/.hkp_proxy 2>/dev/null`
        fi
    fi

    no_proxy="192.168.0.0/16,10.96.0.0/16,10.244.0.0/16"

    ipport=${finalv:-127.0.0.1:9527}
    echo "hkp_proxy is: $ipport"

    #echo "var:",$exp,$uexp,$p
    if [ -v exp ]; then
        export http_proxy=http://$ipport
        export https_proxy=http://$ipport
        export no_proxy="$no_proxy"
        export HTTP_PROXY=http://$ipport
        export HTTPS_PROXY=http://$ipport
        export NO_PROXY="$no_proxy"
        echo 'exported!',$exp
    elif [ -v uexp ]; then
        unset http_proxy
        unset https_proxy
        unset no_proxy
        echo 'unset!'
    elif [ -z $p ]; then
        no_proxy="$no_proxy" http_proxy=http://$ipport https_proxy=http://$ipport HTTP_PROXY=http://$ipport HTTPS_PROXY=http://$ipport $@ 
    else
        http_proxy=http://$ipport no_proxy="$no_proxy" https_proxy=http://$ipport HTTP_PROXY=http://$ipport HTTPS_PROXY=http://$ipport $@ --http-proxy http://$ipport
    fi
}

function sock5_do
{
    ipport=${hkp_proxy:-127.0.0.1:1080}
    http_proxy=socks5://$ipport https_proxy=socks5://$ipport HTTP_PROXY=socks5://$ipport HTTPS_PROXY=socks5://$ipport $@
}


function tm-setenv
{
    export $1=$2
    tmux set-env $1 $2
}

function tm-upenv
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


function run-tmux-copy-server {
    ps aux|grep -ie socat | grep 29292 | awk '{print $2}' | xargs kill
    (socat TCP4-LISTEN:29292,fork EXEC:$HOME/dotfiles/copy_to_sysclip.sh )&
}

function exssh {
    ssh $@ -t "export LOCALUSER=`whoami`; bash -l"
}

#############################################
if [ "$OS" == "Darwin" ] ;then

export PATH=/usr/local/bin:$PATH
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
alias ctags="`brew --prefix`/bin/ctags"
alias ls='ls -alG'
alias sed=gsed
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias mysql="rlwrap -a -- mysql"
alias aps="brew search"
alias api="brew install"
alias readlink=greadlink
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

function logs
{
    log stream --info --debug --predicate "sender == \"$1\"" --style syslog
}

settitle() {
    echo -ne "\033]0;$1\007"
}

#############################################
elif [ "$OS" == "Linux" ] ;then

alias api="sudo apt-get install"
alias aps="apt-cache search"
alias sudo='sudo '
alias ls='ls -al --color=auto'

settitle() {
    echo -ne "\033]0;$1\007"
}

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

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
 
#############################################
#all platform

alias tmuxk='tmux kill-server'
alias tmuxa='tmux attach'
alias cddof='cd ~/dotfiles'
alias kbc='kubectl'
alias kbm='kubeadm'
export PATH=/usr/local/sbin:/usr/local/bin/:$PATH

source $dotfiles_home/tmux.comp
source $dotfiles_home/bash_util_docker.sh
source $dotfiles_home/bash_util_git.sh

function ssh-lfs(){
   dir=`readlink -f ${2:-$PWD}`
   rdir=/tmp/sshfs
   echo "ssh and mount:"$dir
   ssh $1 -R 12000:localhost:22 -t "mkdir -p $rdir; sshfs -p 12000 -o idmap=user,nonempty -o allow_other wellbye@localhost:$dir $rdir; cd $rdir; bash -l"
}


function load-kube(){

    type kubectl >/dev/null 2>&1
    [ $? -eq 0 ] && bin=kubectl
    type kubectl.exe >/dev/null 2>&1
    [ $? -eq 0 ] && bin=kubectl.exe

    #echo "kubebin":$bin
    #$bin completion bash
    [ -v bin ] && source <($bin completion bash)
}

function _nr_completion() {

    local words cword
    _get_comp_words_by_ref -n = -n @ -n : -w words -i cword

    if [ $cword -gt 1 ]; then return 0; fi

    local point=8 #'npm run '的长度
    local w1=${COMP_WORDS[1]:-''}
    local wlen=${#w1}
    point=$((point+wlen))
    #echo !!!w1:$w1, point:$point
    local si="$IFS"
    #set -x
    IFS=$'\n' COMPREPLY=($(COMP_CWORD=2 COMP_LINE="npm run $w1" COMP_POINT=$point npm completion -- npm run "$w1" 2>/dev/null)) || return $?
    #set +x
    IFS="$si"
    #echo !!!cword:$COMP_CWORD, words:$w1, point:$point, reply:${COMPREPLY[@]},----
    #COMPREPLY=(a b c)
    __ltrim_colon_completions "${words[cword]}"
}

export NVM_DIR="$HOME/.nvm"
function load-nvm(){
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  
    alias nr='npm run'
    complete -o default -F _nr_completion nr
    #complete -o default -F _npm_completion nr
}
#load-nvm

function load-rvm(){
    source ~/.rvm/scripts/rvm
    export PATH="$PATH:$HOME/.rvm/bin"
}

function load-sdkman(){
    export SDKMAN_DIR="$HOME/.sdkman"
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
}

#############################################
#加载本机特定配置文件
[ -f $dotfiles_home/bashrc.`hostname` ] && source $dotfiles_home/bashrc.`hostname`
#############################################

#############################################
#最后加载当前目录下的配置文件
pwd=$(pwd)
[ -f $pwd/bash.local ] && . $pwd/bash.local
[ -f $pwd/tool/bash.local ] && . $pwd/tool/bash.local
[ -f $pwd/tools/bash.local ] && . $pwd/tools/bash.local
#############################################
