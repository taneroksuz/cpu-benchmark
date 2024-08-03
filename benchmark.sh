#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "example usage: ./benchmark.sh wolv-z0"
  exit 1
fi

cd $1

export BASEDIR=$(pwd)
export $(grep -v '^#' $BASEDIR/.env | xargs -d '\n')

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

cp $BASEDIR/crt.S $BASEDIR/benchmarks/common/
cp $BASEDIR/test.ld $BASEDIR/benchmarks/common/

cp $BASEDIR/../common/util.h $BASEDIR/benchmarks/common/
cp $BASEDIR/../common/encoding.h $BASEDIR/benchmarks/common/
cp $BASEDIR/../common/strcmp.S $BASEDIR/benchmarks/common/
cp $BASEDIR/../common/syscalls.c $BASEDIR/benchmarks/common/
cp $BASEDIR/../common/benchmarks.mak $BASEDIR/benchmarks/Makefile

cd $BASEDIR/benchmarks

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/benchmarks/*.riscv $BASEDIR/riscv/
cp $BASEDIR/benchmarks/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/benchmarks