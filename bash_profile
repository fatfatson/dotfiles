#!/bin/bash
export EXEC_BASH_PROFILE=`whoami`
source ~/.bashrc
[ -f ~/.dotfiles_home ] && source ~/.dotfiles_home
[ -f ~/.bash_local ] && source ~/.bash_local
source ~/dotfiles/tmux.comp


export ANDROID_SDK=~/sdk/adk
export ANDROID_SDK_ROOT=$ANDROID_SDK
export ANDROID_HOME=$ANDROID_SDK

export NDK_ROOT=~/sdk/andk
export ANDROID_NDK_ROOT=~/sdk/andk
export ANDROID_NDK_HOME=$ANDROID_NDK_ROOT
export ANDROID_NDK_X86=$NDK_ROOT/toolchains/x86-4.9/prebuilt/darwin-x86_64
export ANDROID_NDK_ARM=$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
export ANDROID_NDK_CLANG=$NDK_ROOT/toolchains/llvm/prebuilt/darwin-x86_64

export ANT_ROOT=/usr/local/bin
export COCOS_CONSOLE_ROOT=~/git-repo/mmd-cc/tools/cocos2d-console/bin
export QT_ROOT=~/Qt5.5.1/5.5/clang_64/bin
export DEPOT=~/git-repo/depot_tools
export PATH=$dotfiles_home:$COCOS_CONSOLE_ROOT:$ANT_ROOT:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT:$QT_ROOT:$PATH:/usr/sbin
export PATH_DYNADD=/Users/mac/Qt5.9.1/5.9.1/clang_64/bin
export PATH=$PATH_DYNADD:"$HOME/.fastlane/bin:$PATH"

export PS1="[\u@\h:\w]"
export LANG="en_US.UTF-8"
#export SSL_CERT_FILE=$dotfiles_home/cacert.pem
export HOMEBREW_GITHUB_API_TOKEN=0a15efd6f5a715f9f9811a17049f6ec8876aa001


if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
    # many other tests omitted
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=remote/ssh;;
    esac
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="~/.sdkman"
#[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"
[[ -f /usr/libexec/path_helper ]] && eval $(/usr/libexec/path_helper -s)
