#!/usr/bin/bash
export SYSROOT="$NDK_ROOT/platforms/android-8/arch-arm"
export CC="$NDK_ROOT/toolchains/arm-linux-androideabi-4.6/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-gcc --sysroot=$SYSROOT" 
export CXX="$NDK_ROOT/toolchains/arm-linux-androideabi-4.6/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-g++ --sysroot=$SYSROOT -I$NDK_ROOT/sources/cxx-stl/gnu-libstdc++/include" 
export AR="$NDK_ROOT/toolchains/arm-linux-androideabi-4.6/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar" 
export CMAKE_AR=$AR
export RANLIB="$NDK_ROOT/toolchains/arm-linux-androideabi-4.6/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ranlib" 
export CMAKE_RANLIB=$RANLIB
