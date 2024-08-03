#!/bin/bash
set -e

if [ -d "$BASEDIR/coremark" ]; then
  rm -rf $BASEDIR/coremark
fi

cp -r $BASEDIR/../coremark $BASEDIR/

mkdir -p $BASEDIR/coremark/common/

cp $BASEDIR/crt.S $BASEDIR/coremark/common/
cp $BASEDIR/test.ld $BASEDIR/coremark/common/

cp $BASEDIR/../common/util.h $BASEDIR/coremark/common/
cp $BASEDIR/../common/encoding.h $BASEDIR/coremark/common/
cp $BASEDIR/../common/strcmp.S $BASEDIR/coremark/common/
cp $BASEDIR/../common/syscalls.c $BASEDIR/coremark/common/
cp $BASEDIR/../common/ee_printf.c $BASEDIR/coremark/common/
cp $BASEDIR/../common/core_portme.c $BASEDIR/coremark/common/
cp $BASEDIR/../common/core_portme.h $BASEDIR/coremark/common/
cp $BASEDIR/../common/coremark.mak $BASEDIR/coremark/Makefile

cd $BASEDIR/coremark

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/coremark/*.riscv $BASEDIR/riscv/
cp $BASEDIR/coremark/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/coremark