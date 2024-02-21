#!/bin/bash
set -e

ROOT_DIR=$(pwd)
TARGET_ARCH=$1
TARGET_PATH=${ROOT_DIR}/output/pjsip/${TARGET_ARCH}
cp -r ${ROOT_DIR}/sources/pjsip ${ROOT_DIR}/tmp/pjsip

# TODO: Use flags like in vialerpjsip for config.h
cat <<EOF > "${ROOT_DIR}/tmp/pjsip/pjlib/include/pj/config_site.h"
#define PJ_CONFIG_ANDROID 1
#define PJMEDIA_HAS_G729_CODEC 1
#define PJMEDIA_HAS_G7221_CODEC 1
#include <pj/config_site_sample.h>
#define PJMEDIA_HAS_VIDEO 1
#define PJMEDIA_AUDIO_DEV_HAS_ANDROID_JNI 1
#define PJMEDIA_AUDIO_DEV_HAS_OPENSL 1
#define PJSIP_AUTH_AUTO_SEND_NEXT 0
EOF

cd ${ROOT_DIR}/tmp/pjsip

export TARGET_ABI=${TARGET_ARCH}
export APP_PLATFORM=android-30

./configure-android \
    --use-ndk-cflags \
    --with-ssl="${ROOT_DIR}/output/openssl/${TARGET_ARCH}" \
    --with-openh264="${ROOT_DIR}/output/openh264/${TARGET_ARCH}" \
    --with-opus="${ROOT_DIR}/output/opus/${TARGET_ARCH}"

make dep
make

cd ${ROOT_DIR}/tmp/pjsip/pjsip-apps/src/swig
make

mkdir -p ${ROOT_DIR}/output/pjsip/jniLibs/${TARGET_ARCH}/
mv ./java/android/pjsua2/src/main/jniLibs/**/libpjsua2.so ${ROOT_DIR}/output/pjsip/jniLibs/${TARGET_ARCH}/

if [ ! -d "${ROOT_DIR}/output/pjsip/java" ]; then
  mv ./java/android/pjsua2/src/main/java ${ROOT_DIR}/output/pjsip/java
fi

rm -rf ${ROOT_DIR}/tmp/pjsip