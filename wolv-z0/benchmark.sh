#!/bin/bash
set -e

if [ -d "$BASEDIR/$CPU/wolv-benchmark" ]; then
  rm -rf $BASEDIR/$CPU/wolv-benchmark
fi

mkdir -p $BASEDIR/$CPU/wolv-benchmark

cd $BASEDIR/$CPU/wolv-benchmark

cp -R $BASEDIR/riscv-tests/ .

./configure
make -j$(nproc)