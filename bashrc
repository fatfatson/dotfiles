OS=$(uname)

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

function git-fix-push
{
    git ca -m "fix" && git push
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

    ipport=${finalv:-127.0.0.1:9527}
    echo "hkp_proxy is: $ipport"
    if [ -z $p ]; then
        http_proxy=http://$ipport https_proxy=http://$ipport HTTP_PROXY=http://$ipport HTTPS_PROXY=http://$ipport $@ 
    else
        http_proxy=http://$ipport https_proxy=http://$ipport HTTP_PROXY=http://$ipport HTTPS_PROXY=http://$ipport $@ --http-proxy http://$ipport
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

#############################################
elif [ "$OS" == "Linux" ] ;then

alias api="sudo apt-get install"
alias aps="apt-cache search"
alias sudo='sudo '
alias ls='ls -al --color=auto'

settitle() {
    echo -ne "\033]0;$1\007"
}

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
[ -f $pwd/tools/bash.local ] && . $pwd/tools/bash.local
#############################################

alias tmuxk='tmux kill-server'
alias tmuxa='tmux attach'
alias cddof='cd ~/dotfiles'

export PATH=/usr/local/sbin:/usr/local/bin/:$PATH

function load-nvm(){
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function load-rvm(){
    source ~/.rvm/scripts/rvm
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
