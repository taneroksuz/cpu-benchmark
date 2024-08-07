#!/bin/bash
set -e

if [ -d "$BASEDIR/isa" ]; then
  rm -rf $BASEDIR/isa
fi

mkdir -p $BASEDIR/isa

cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/macros $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32ui $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32uc $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32um $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32uf $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32ud $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32mi $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv32si $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64ui $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64uc $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64um $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64uf $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64ud $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64mi $BASEDIR/isa/
cp -r $BASEDIR/$BENCHMARK/riscv-tests/isa/rv64si $BASEDIR/isa/

if [ -d "$BASEDIR/env" ]; then
  rm -rf $BASEDIR/env
fi

cp -r $BASEDIR/$BENCHMARK/riscv-tests/env $BASEDIR/

cp $BASEDIR/$BENCHMARK/mak/isa.mak $BASEDIR/isa/Makefile

cd $BASEDIR/isa

make

mkdir -p $BASEDIR/riscv
mkdir -p $BASEDIR/dump

for file in $BASEDIR/isa/*.dump; do
  directory="$(dirname $file)"
  filename="$(basename $file .dump)"
  cp $directory/$filename.dump $BASEDIR/riscv/$filename.riscv
done

cp $BASEDIR/isa/*.dump $BASEDIR/dump/

rm -rf $BASEDIR/isa
rm -rf $BASEDIR/env