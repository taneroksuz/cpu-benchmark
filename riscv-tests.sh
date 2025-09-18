#!/bin/bash
set -e

if [ -d "$BASEDIR/riscv-tests" ]; then
  rm -rf $BASEDIR/riscv-tests
fi

mkdir -p $BASEDIR/riscv-tests/common

cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/median $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/qsort $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/rsort $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/towers $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/vvadd $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/memcpy $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/multiply $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/dhrystone $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/spmv $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/pmp $BASEDIR/riscv-tests/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/benchmarks/Makefile $BASEDIR/riscv-tests/

cp $BASEDIR/ld/startup.S $BASEDIR/riscv-tests/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/riscv-tests/common/

cp $BASEDIR/$BENCHMARK/common/util.h $BASEDIR/riscv-tests/common/
cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/riscv-tests/common/
cp $BASEDIR/$BENCHMARK/common/syscalls.c $BASEDIR/riscv-tests/common/

cp $BASEDIR/$BENCHMARK/mak/riscv-tests.mak $BASEDIR/riscv-tests/Makefile

cd $BASEDIR/riscv-tests

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/riscv-tests/*.riscv $BASEDIR/riscv/
cp $BASEDIR/riscv-tests/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/riscv-tests