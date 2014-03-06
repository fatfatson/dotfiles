source ~/.bash_rc
export NDK_ROOT=~/sdk/andk
export ANDROID_SDK_ROOT=~/sdk/adk
export LIBIMOBILE_ROOT=~/sdk/libimobiledevice-macosx
export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT:$LIBIMOBILE_ROOT
export DYLD_LIBRARY_PATH=$LIBIMOBILE_ROOT:$DYLD_LIBRARY_PATH
export PS1="[\u@\h:\w]"
export LANG="en_US.UTF-8"

