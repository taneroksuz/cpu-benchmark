#!/bin/bash
set -e

if [ -d "$BASEDIR/rom" ]; then
  rm -rf $BASEDIR/rom
fi

mkdir -p $BASEDIR/rom

cp $BASEDIR/ld/rom.S $BASEDIR/rom/
cp $BASEDIR/ld/linker.ld $BASEDIR/rom/

cp $BASEDIR/$BENCHMARK/common/encoding.h $BASEDIR/rom/

cp $BASEDIR/$BENCHMARK/mak/rom.mak $BASEDIR/rom/Makefile

cd $BASEDIR/rom

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump
mkdir -p $BASEDIR/hex

cp $BASEDIR/rom/*.riscv $BASEDIR/riscv/
cp $BASEDIR/rom/*.dump $BASEDIR/dump/
cp $BASEDIR/rom/*.hex $BASEDIR/hex/

rm -rf $BASEDIR/rom
