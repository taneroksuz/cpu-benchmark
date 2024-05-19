#!/bin/bash
set -e

export BASEDIR=$(pwd)

export XLEN="32"
export RISCV_PREFIX="/opt/rv32imc/bin/riscv32-unknown-elf-"
export RISCV_GCC_OPTS="-DPREALLOCATE=1 -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns"

if [ -d "$BASEDIR/riscv-tests" ]; then
  rm -rf $BASEDIR/riscv-tests
fi

cp -R $BASEDIR/../riscv-tests $BASEDIR/

cp $BASEDIR/Makefile $BASEDIR/riscv-tests/
cp $BASEDIR/crt.S $BASEDIR/riscv-tests/benchmarks/common/
cp $BASEDIR/syscalls.c $BASEDIR/riscv-tests/benchmarks/common/
cp $BASEDIR/test.ld $BASEDIR/riscv-tests/benchmarks/common/

cd $BASEDIR/riscv-tests

make -j$(nproc)