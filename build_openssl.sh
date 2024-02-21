#!/bin/bash
#@see http://stackoverflow.com/questions/11929773/compiling-the-latest-openssl-for-android
set -e

ROOT_DIR=$(pwd)
GCC_VERSION=$(gcc --version | grep gcc | awk '{print $4}' | cut -d'.' -f1,2)

TARGET_ARCH=$1
TARGET_PATH=${ROOT_DIR}/output/openssl/${TARGET_ARCH}

cp -r ${ROOT_DIR}/sources/openssl ${ROOT_DIR}/tmp/openssl

if [ "$TARGET_ARCH" == "armeabi-v7a" ]
then
    export ARCH=arm
    TARGET=android-arm
    TOOLCHAIN=armv7a-linux-androideabi30-clang
    export TOOL=armv7a-linux-androideabi30-clang
    export ARCH_FLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
    export ARCH_LINK="-march=armv7-a -Wl,--fix-cortex-a8"
elif [ "$TARGET_ARCH" == "arm64-v8a" ]
then
    export ARCH=arm64
    TARGET=android-arm64
    TOOLCHAIN=aarch64-linux-android30-clang
    export TOOL=aarch64-linux-android30
    export ARCH_FLAGS=
    export ARCH_LINK=
elif [ "$TARGET_ARCH" == "armeabi" ]
then
    export ARCH=arm
    TARGET=android-arm
    TOOLCHAIN=armv7a-linux-androideabi30-clang
    export TOOL=armv7a-linux-androideabi30-clang
    export ARCH_FLAGS="-mthumb"
    export ARCH_LINK=
elif [ "$TARGET_ARCH" == "x86" ]
then
    export ARCH=x86
    TARGET=android-x86
    TOOLCHAIN=i686-linux-android30-clang
    export TOOL=i686-linux-android
    export ARCH_FLAGS="-march=i686 -msse3 -mstackrealign -mfpmath=sse"
    export ARCH_LINK=
elif [ "$TARGET_ARCH" == "x86_64" ]
then
    ARCH=x86_64
    TARGET=android-x86_64
    TOOLCHAIN=xx86_64-linux-android30-clang
    export TOOL=x86_64-linux-android
elif [ "$TARGET_ARCH" == "mips" ]
then
    TARGET=android-mips
    TOOLCHAIN=mipsel-linux-android-4.9
    export TOOL=mipsel-linux-android
    export ARCH_FLAGS=
    export ARCH_LINK=
elif [ "$TARGET_ARCH" == "mips64" ]
then
    TARGET=android-mips64
    TOOLCHAIN=mips64el-linux-android-4.9
    export TOOL=mips64el-linux-android
    export ARCH_FLAGS=
    export ARCH_LINK=
else
    echo "Unsupported target ABI: $TARGET_ARCH"
    exit 1
fi

export TOOLCHAIN_PATH="${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/darwin-x86_64/bin"
export PATH=$TOOLCHAIN_PATH:$PATH
export NDK_TOOLCHAIN_BASENAME=${TOOLCHAIN_PATH}/${TOOL}
export CC=$NDK_TOOLCHAIN_BASENAME-gcc
export CXX=$NDK_TOOLCHAIN_BASENAME-g++
export LINK=${CXX}
export LD=$NDK_TOOLCHAIN_BASENAME-ld
export AR=$NDK_TOOLCHAIN_BASENAME-ar
export RANLIB=$NDK_TOOLCHAIN_BASENAME-ranlib
export STRIP=$NDK_TOOLCHAIN_BASENAME-strip
export CPPFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export CFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export LDFLAGS=" ${ARCH_LINK} "


################################
# TODO
################################

# cd ${ANDROID_NDK_25}/build/tools/

# ./make_standalone_toolchain.py \
#     --arch=${ARCH} \
#     --api=30 \
#     --install-dir="${ROOT_DIR}/tmp/openssl/android-toolchain"

cd ${ROOT_DIR}/tmp/openssl/

################################
# TODO
################################

mkdir -p ${TARGET_PATH}/include
mkdir -p ${TARGET_PATH}/lib

./Configure ${TARGET} no-asm no-unit-test --openssldir=${TARGET_PATH} -D__ANDROID_API__=30
make

cp -r include/openssl ${TARGET_PATH}/include
cp libcrypto.a ${TARGET_PATH}/lib/
cp libssl.a ${TARGET_PATH}/lib/

rm -rf ${ROOT_DIR}/tmp/openssl/

