#!/bin/bash
set -e

ROOT_DIR=$(pwd)

mkdir -p ./tmp
cp -r ./sources/swig ./tmp/swig
cd ./tmp/swig

./configure
make
sudo make install

rm -rf ${ROOT_DIR}/tmp/swig