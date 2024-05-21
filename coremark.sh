#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "example usage: ./coremark.sh wolv-z0"
  exit 1
fi

cd $1

export BASEDIR=$(pwd)
export $(grep -v '^#' $BASEDIR/.env | xargs)

if [ -d "$BASEDIR/coremark" ]; then
  rm -rf $BASEDIR/coremark
fi

cp -r $BASEDIR/../coremark $BASEDIR/

cd $BASEDIR/coremark

make PORT_DIR=$BASEDIR/../common compile ITERATIONS=10