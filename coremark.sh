#!/bin/bash
set -e

if [ -d "$BASEDIR/coremark" ]; then
  rm -rf $BASEDIR/coremark
fi

cp -r $BASEDIR/wolv-benchmark/coremark $BASEDIR/

mkdir -p $BASEDIR/coremark/common/

cp $BASEDIR/ld/startup.S $BASEDIR/coremark/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/coremark/common/

cp $BASEDIR/wolv-benchmark/common/util.h $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/encoding.h $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/strcmp.S $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/syscalls.c $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/ee_printf.c $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/core_portme.c $BASEDIR/coremark/common/
cp $BASEDIR/wolv-benchmark/common/core_portme.h $BASEDIR/coremark/common/

cp $BASEDIR/wolv-benchmark/mak/coremark.mak $BASEDIR/coremark/Makefile

cd $BASEDIR/coremark

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/coremark/*.riscv $BASEDIR/riscv/
cp $BASEDIR/coremark/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/coremark