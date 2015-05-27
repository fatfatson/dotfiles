export EXEC_BASH_PROFILE=`whoami`
source ~/.bashrc
[ -f ~/.dotfiles_home ] && source ~/.dotfiles_home
export NDK_ROOT=~/sdk/andk
export ANDROID_SDK_ROOT=~/sdk/adk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_SDK=$ANDROID_SDK_ROOT
export ANT_ROOT=/usr/local/bin
export COCOS_CONSOLE_ROOT=~/git-repo/mmd-cc/tools/cocos2d-console/bin
export PATH=$dotfiles_home:$COCOS_CONSOLE_ROOT:$ANT_ROOT:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT:$PATH
export PS1="[\u@\h:\w]"
export LANG="en_US.UTF-8"
export SSL_CERT_FILE=$dotfiles_home/cacert.pem


