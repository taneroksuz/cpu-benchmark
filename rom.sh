#!/bin/bash
set -e

if [ -d "$BASEDIR/rom" ]; then
  rm -rf $BASEDIR/rom
fi

mkdir -p $BASEDIR/rom

cp $BASEDIR/ld/rom.S $BASEDIR/rom/
cp $BASEDIR/ld/rom.ld $BASEDIR/rom/

cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/rom/

cp $BASEDIR/$BENCHMARK/mak/rom.mak $BASEDIR/rom/Makefile

cd $BASEDIR/rom

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

cp $BASEDIR/rom/*.riscv $BASEDIR/riscv/
cp $BASEDIR/rom/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/rom
