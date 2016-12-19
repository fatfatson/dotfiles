export EXEC_BASH_PROFILE=`whoami`
source ~/.bashrc
[ -f ~/.dotfiles_home ] && source ~/.dotfiles_home
[ -f ~/.bash_local ] && source ~/.bash_local
export NDK_ROOT=~/sdk/andk
export ANDROID_SDK_ROOT=~/sdk/adk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_SDK=$ANDROID_SDK_ROOT
export ANT_ROOT=/usr/local/bin
export COCOS_CONSOLE_ROOT=~/git-repo/mmd-cc/tools/cocos2d-console/bin
export QT_ROOT=~/Qt5.5.1/5.5/clang_64/bin
export DEPOT=~/git-repo/depot_tools
export PATH=$dotfiles_home:$COCOS_CONSOLE_ROOT:$ANT_ROOT:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT:$QT_ROOT:$PATH
export PS1="[\u@\h:\w]"
export LANG="en_US.UTF-8"
export SSL_CERT_FILE=$dotfiles_home/cacert.pem
export HOMEBREW_GITHUB_API_TOKEN=6a4ecda4b196dc049e584ca7c4a6e0ca133ed931



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/admin/.sdkman"
#[[ -s "/home/admin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/admin/.sdkman/bin/sdkman-init.sh"
