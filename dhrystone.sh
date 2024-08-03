#!/bin/bash
set -e

if [ -d "$BASEDIR/dhrystone" ]; then
  rm -rf $BASEDIR/dhrystone
fi

cp -r $BASEDIR/../dhrystone $BASEDIR/

mkdir -p $BASEDIR/dhrystone/common/

cp $BASEDIR/crt.S $BASEDIR/dhrystone/common/
cp $BASEDIR/test.ld $BASEDIR/dhrystone/common/

cp $BASEDIR/../common/util.h $BASEDIR/dhrystone/common/
cp $BASEDIR/../common/encoding.h $BASEDIR/dhrystone/common/
cp $BASEDIR/../common/strcmp.S $BASEDIR/dhrystone/common/
cp $BASEDIR/../common/syscalls.c $BASEDIR/dhrystone/common/
cp $BASEDIR/../common/dhrystone.mak $BASEDIR/dhrystone/Makefile

cd $BASEDIR/dhrystone

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/dhrystone/*.riscv $BASEDIR/riscv/
cp $BASEDIR/dhrystone/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/dhrystone