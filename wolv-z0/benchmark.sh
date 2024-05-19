#!/bin/bash
set -e

export CPU="wolv-z0"
export XLEN="32"
export RISCV="/opt/rv32imc"
export BASEDIR="/home/taner/Project/wolv-benchmark"

export PATH=$PATH:"/opt/rv32imc/bin"

if [ -d "$BASEDIR/$CPU/wolv-benchmark" ]; then
  rm -rf $BASEDIR/$CPU/wolv-benchmark
fi

mkdir -p $BASEDIR/$CPU/wolv-benchmark

cp -R $BASEDIR/riscv-tests/* $BASEDIR/$CPU/wolv-benchmark/

cp $BASEDIR/$CPU/crt.S $BASEDIR/$CPU/wolv-benchmark/benchmarks/common/
cp $BASEDIR/$CPU/syscalls.c $BASEDIR/$CPU/wolv-benchmark/benchmarks/common/
cp $BASEDIR/$CPU/test.ld $BASEDIR/$CPU/wolv-benchmark/benchmarks/common/

cd $BASEDIR/$CPU/wolv-benchmark

./configure --prefix=$RISCV/target
make -j$(nproc)