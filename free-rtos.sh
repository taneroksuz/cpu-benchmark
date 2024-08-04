#!/bin/bash
set -e

if [ -d "$BASEDIR/free-rtos" ]; then
  rm -rf $BASEDIR/free-rtos
fi

cp -r $BASEDIR/wolv-benchmark/free-rtos $BASEDIR/

cd $BASEDIR/free-rtos

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/free-rtos/*.riscv $BASEDIR/riscv/
cp $BASEDIR/free-rtos/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/free-rtos