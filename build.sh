#!/bin/bash

BUILD_TARGET=AVR_328
BUILD_TYPE=Release
BUILD_TYPE_MASSAGED=`echo $BUILD_TYPE | tr '[:upper:]' '[:lower:]'`

BUILD_DIR="cmake-$BUILD_TARGET-$BUILD_TYPE_MASSAGED"

if [ ! -d $BUILD_DIR ]; then
    mkdir $BUILD_DIR
fi

cd $BUILD_DIR

cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBUILD_TARGET=$BUILD_TARGET ..

cores=`grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}'`
make -j$cores
