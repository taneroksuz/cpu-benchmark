#!/bin/bash
set -e

export BASEDIR=$(pwd)

export XLEN="32"
export RISCV_PREFIX="/opt/rv32imc/bin/riscv32-unknown-elf-"
export RISCV_GCC_OPTS="-DPREALLOCATE=1 -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns -Wno-implicit"

if [ -d "$BASEDIR/benchmarks" ]; then
  rm -rf $BASEDIR/benchmarks
fi

mkdir -p $BASEDIR/benchmarks

cp -r $BASEDIR/../riscv-tests/benchmarks/common $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/dhrystone $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/median $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/memcpy $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/multiply $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/qsort $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/rsort $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/spmv $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/towers $BASEDIR/benchmarks/
cp -r $BASEDIR/../riscv-tests/benchmarks/Makefile $BASEDIR/benchmarks/

cp -r $BASEDIR/../riscv-tests/env $BASEDIR/

cp $BASEDIR/../common/crt.S $BASEDIR/benchmarks/
cp $BASEDIR/../common/util.h $BASEDIR/benchmarks/
cp $BASEDIR/../common/test.ld $BASEDIR/benchmarks/
cp $BASEDIR/../common/syscalls.c $BASEDIR/benchmarks/

make -j$(nproc)