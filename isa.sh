#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "example usage: ./isa.sh wolv-z0"
  exit 1
fi

cd $1

export BASEDIR=$(pwd)
export $(grep -v '^#' $BASEDIR/.env | xargs -d '\n')

if [ -d "$BASEDIR/isa" ]; then
  rm -rf $BASEDIR/isa
fi

mkdir -p $BASEDIR/isa

cp -r $BASEDIR/../riscv-tests/isa/macros $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32ui $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32uc $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32um $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32uf $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32ud $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32mi $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv32si $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64ui $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64uc $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64um $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64uf $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64ud $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64mi $BASEDIR/isa/
cp -r $BASEDIR/../riscv-tests/isa/rv64si $BASEDIR/isa/

cp -r $BASEDIR/../riscv-tests/env $BASEDIR/

cp $BASEDIR/../common/isa.mak $BASEDIR/isa/Makefile

cd $BASEDIR/isa

make