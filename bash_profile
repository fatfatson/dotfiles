export EXEC_BASH_PROFILE=`whoami`
source ~/.bashrc
export NDK_ROOT=~/sdk/andk
export ANDROID_SDK_ROOT=~/sdk/adk
export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT
export PS1="[\u@\h:\w]"
export LANG="en_US.UTF-8"

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/abc/git-repo/hd-cc/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/opt/local/share/java/apache-ant/bin
export PATH=$ANT_ROOT:$PATH
