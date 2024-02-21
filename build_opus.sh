#!/bin/bash
set -e

ROOT_DIR=$(pwd)
TARGET_ARCH=$1
TARGET_PATH=${ROOT_DIR}/output/opus/${TARGET_ARCH}

mkdir -p ./tmp
cp -r ./sources/opus ./tmp/opus

cd ./tmp/opus/jni
ndk-build APP_ABI="${TARGET_ARCH}" 

mkdir -p ${TARGET_PATH}/include
mkdir -p ${TARGET_PATH}/lib
cp -r ../include ${TARGET_PATH}/include/opus
cp ../obj/local/${TARGET_ARCH}/libopus.a ${TARGET_PATH}/lib/

rm -rf ${ROOT_DIR}/tmp/opus
