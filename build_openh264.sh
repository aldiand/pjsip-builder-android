#!/bin/bash
set -e

ROOT_DIR=$(pwd)
TARGET_ARCH=$1
TARGET_PATH=${ROOT_DIR}/output/openh264/${TARGET_ARCH}

mkdir -p ${ROOT_DIR}/tmp
cp -r ${ROOT_DIR}/sources/openh264 ${ROOT_DIR}/tmp/openh264
cd ${ROOT_DIR}/tmp/openh264

sed -i '' "s*PREFIX=/usr/local*PREFIX=${TARGET_PATH}*g" Makefile

ARGS="OS=android ENABLEPIC=Yes NDKROOT=${ANDROID_NDK_25} NDKLEVEL=30 "
ARGS="${ARGS}TARGET=android-30 ARCH="

if [ "$TARGET_ARCH" == "armeabi" ]
then
    ARGS="${ARGS}arm APP_ABI=armeabi"
elif [ "$TARGET_ARCH" == "armeabi-v7a" ]
then
    ARGS="${ARGS}arm"
elif [ "$TARGET_ARCH" == "x86" ]
then
    ARGS="${ARGS}x86"
elif [ "$TARGET_ARCH" == "x86_64" ]
then
    ARGS="${ARGS}x86_64"
elif [ "$TARGET_ARCH" == "arm64-v8a" ]
then
    ARGS="${ARGS}arm64"
elif [ "$TARGET_ARCH" == "mips" ]
then
    ARGS="${ARGS}mips"
elif [ "$TARGET_ARCH" == "mips64" ]
then
    ARGS="${ARGS}mips64"
fi

make ARCH=arm64 ${ARGS} install

rm -rf ${ROOT_DIR}/tmp/openh264