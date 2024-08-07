#!/bin/bash
set -e

if [ -d "$BASEDIR/free-rtos" ]; then
  rm -rf $BASEDIR/free-rtos
fi

mkdir -p $BASEDIR/free-rtos/

cp -r $BASEDIR/$BENCHMARK/free-rtos-kernel $BASEDIR/free-rtos/
cp -r $BASEDIR/$BENCHMARK/free-rtos-posix $BASEDIR/free-rtos/

cp $BASEDIR/$BENCHMARK/free-rtos/* $BASEDIR/free-rtos/

cp $BASEDIR/ld/linker.ld $BASEDIR/free-rtos/

cp $BASEDIR/$BENCHMARK/mak/free-rtos.mak $BASEDIR/free-rtos/Makefile

cd $BASEDIR/free-rtos

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/free-rtos/*.riscv $BASEDIR/riscv/
cp $BASEDIR/free-rtos/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/free-rtos