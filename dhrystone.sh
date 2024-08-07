#!/bin/bash
set -e

if [ -d "$BASEDIR/dhrystone" ]; then
  rm -rf $BASEDIR/dhrystone
fi

cp -r $BASEDIR/$BENCHMARK/dhrystone $BASEDIR/

mkdir -p $BASEDIR/dhrystone/common/

cp $BASEDIR/ld/startup.S $BASEDIR/dhrystone/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/dhrystone/common/

cp $BASEDIR/$BENCHMARK/common/util.h $BASEDIR/dhrystone/common/
cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/dhrystone/common/
cp $BASEDIR/$BENCHMARK/common/strcmp.S $BASEDIR/dhrystone/common/
cp $BASEDIR/$BENCHMARK/common/syscalls.c $BASEDIR/dhrystone/common/

cp $BASEDIR/$BENCHMARK/mak/dhrystone.mak $BASEDIR/dhrystone/Makefile

cd $BASEDIR/dhrystone

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/dhrystone/*.riscv $BASEDIR/riscv/
cp $BASEDIR/dhrystone/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/dhrystone