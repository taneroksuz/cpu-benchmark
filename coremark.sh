#!/bin/bash
set -e

if [ -d "$BASEDIR/coremark" ]; then
  rm -rf $BASEDIR/coremark
fi

cp -r $BASEDIR/$BENCHMARK/coremark $BASEDIR/

mkdir -p $BASEDIR/coremark/common/

cp $BASEDIR/ld/startup.S $BASEDIR/coremark/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/coremark/common/

cp $BASEDIR/$BENCHMARK/common/util.h $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/strcmp.S $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/syscalls.c $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/ee_printf.c $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/core_portme.c $BASEDIR/coremark/common/
cp $BASEDIR/$BENCHMARK/common/core_portme.h $BASEDIR/coremark/common/

cp $BASEDIR/$BENCHMARK/mak/coremark.mak $BASEDIR/coremark/Makefile

cd $BASEDIR/coremark

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/coremark/*.riscv $BASEDIR/riscv/
cp $BASEDIR/coremark/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/coremark