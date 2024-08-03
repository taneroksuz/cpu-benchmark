#!/bin/bash
set -e

if [ -d "$BASEDIR/whetstone" ]; then
  rm -rf $BASEDIR/whetstone
fi

mkdir -p $BASEDIR/whetstone/common

cp $BASEDIR/../whetstone/whetstone.c $BASEDIR/whetstone/

cp $BASEDIR/crt.S $BASEDIR/whetstone/common/
cp $BASEDIR/test.ld $BASEDIR/whetstone/common/

cp $BASEDIR/../common/util.h $BASEDIR/whetstone/common/
cp $BASEDIR/../common/encoding.h $BASEDIR/whetstone/common/
cp $BASEDIR/../common/strcmp.S $BASEDIR/whetstone/common/
cp $BASEDIR/../common/syscalls.c $BASEDIR/whetstone/common/
cp $BASEDIR/../common/whetstone.mak $BASEDIR/whetstone/Makefile

cd $BASEDIR/whetstone

make PORT_DIR=$BASEDIR/../common

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/whetstone/*.riscv $BASEDIR/riscv/
cp $BASEDIR/whetstone/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/whetstone