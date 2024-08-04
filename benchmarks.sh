#!/bin/bash
set -e

if [ -d "$BASEDIR/benchmarks" ]; then
  rm -rf $BASEDIR/benchmarks
fi

mkdir -p $BASEDIR/benchmarks/common

cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/dhrystone $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/median $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/memcpy $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/multiply $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/qsort $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/rsort $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/spmv $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/towers $BASEDIR/benchmarks/
cp -r $BASEDIR/wolv-benchmark/riscv-tests/benchmarks/Makefile $BASEDIR/benchmarks/

cp $BASEDIR/ld/startup.S $BASEDIR/benchmarks/common/
cp $BASEDIR/ld/linker.ld $BASEDIR/benchmarks/common/

cp $BASEDIR/wolv-benchmark/common/util.h $BASEDIR/benchmarks/common/
cp $BASEDIR/wolv-benchmark/common/encoding.h $BASEDIR/benchmarks/common/
cp $BASEDIR/wolv-benchmark/common/strcmp.S $BASEDIR/benchmarks/common/
cp $BASEDIR/wolv-benchmark/common/syscalls.c $BASEDIR/benchmarks/common/

cp $BASEDIR/wolv-benchmark/mak/benchmarks.mak $BASEDIR/benchmarks/Makefile

cd $BASEDIR/benchmarks

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/benchmarks/*.riscv $BASEDIR/riscv/
cp $BASEDIR/benchmarks/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/benchmarks