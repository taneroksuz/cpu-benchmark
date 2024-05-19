#!/bin/bash
set -e

export BASEDIR=$(pwd)
export RISCV="/opt/rv32imc/"

if [ -d "$BASEDIR/coremark" ]; then
  rm -rf $BASEDIR/coremark
fi

cp -r $BASEDIR/../coremark $BASEDIR/

cd $BASEDIR/coremark

make PORT_DIR=$BASEDIR/coremark/common compile ITERATIONS=10