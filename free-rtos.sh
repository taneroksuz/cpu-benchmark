#!/bin/bash
set -e

if [ -d "$BASEDIR/free-rtos" ]; then
  rm -rf $BASEDIR/free-rtos
fi

mkdir -p $BASEDIR/free-rtos/

cp -r $BASEDIR/wolv-benchmark/free-rtos-kernel $BASEDIR/free-rtos/
cp -r $BASEDIR/wolv-benchmark/free-rtos-posix $BASEDIR/free-rtos/

cp $BASEDIR/wolv-benchmark/common/free-rtos.mak $BASEDIR/free-rtos/Makefile

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/free-rtos/*.riscv $BASEDIR/riscv/
cp $BASEDIR/free-rtos/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/free-rtos