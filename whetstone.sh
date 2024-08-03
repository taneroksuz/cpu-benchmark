#!/bin/bash
set -e

if [ -d "$BASEDIR/whetstone" ]; then
  rm -rf $BASEDIR/whetstone
fi

mkdir -p $BASEDIR/whetstone/common

cp $BASEDIR/wolv-benchmark/whetstone/whetstone.c $BASEDIR/whetstone/

cp $BASEDIR/ld/startup.S $BASEDIR/whetstone/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/whetstone/common/

cp $BASEDIR/wolv-benchmark/common/util.h $BASEDIR/whetstone/common/
cp $BASEDIR/wolv-benchmark/common/encoding.h $BASEDIR/whetstone/common/
cp $BASEDIR/wolv-benchmark/common/strcmp.S $BASEDIR/whetstone/common/
cp $BASEDIR/wolv-benchmark/common/syscalls.c $BASEDIR/whetstone/common/
cp $BASEDIR/wolv-benchmark/common/whetstone.mak $BASEDIR/whetstone/Makefile

cd $BASEDIR/whetstone

make PORT_DIR=$BASEDIR/wolv-benchmark/common

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/whetstone/*.riscv $BASEDIR/riscv/
cp $BASEDIR/whetstone/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/whetstone