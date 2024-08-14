#!/bin/bash
set -e

if [ -d "$BASEDIR/whetstone" ]; then
  rm -rf $BASEDIR/whetstone
fi

mkdir -p $BASEDIR/whetstone/common

cp $BASEDIR/$BENCHMARK/whetstone/whetstone.c $BASEDIR/whetstone/

cp $BASEDIR/ld/startup.S $BASEDIR/whetstone/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/whetstone/common/

cp $BASEDIR/$BENCHMARK/common/util.h $BASEDIR/whetstone/common/
cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/whetstone/common/
cp $BASEDIR/$BENCHMARK/common/syscalls.c $BASEDIR/whetstone/common/

cp $BASEDIR/$BENCHMARK/mak/whetstone.mak $BASEDIR/whetstone/Makefile

cd $BASEDIR/whetstone

make PORT_DIR=$BASEDIR/$BENCHMARK/common

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/whetstone/*.riscv $BASEDIR/riscv/
cp $BASEDIR/whetstone/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/whetstone