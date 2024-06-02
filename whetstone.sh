#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "example usage: ./whetstone.sh wolv-z0"
  exit 1
fi

cd $1

export BASEDIR=$(pwd)
export $(grep -v '^#' $BASEDIR/.env | xargs -d '\n')

if [ -d "$BASEDIR/whetstone" ]; then
  rm -rf $BASEDIR/whetstone
fi

mkdir -p $BASEDIR/whetstone/common

cp $BASEDIR/../whetstone/whetstone.c $BASEDIR/whetstone/

cp $BASEDIR/crt.S $BASEDIR/whetstone/common/
cp $BASEDIR/test.ld $BASEDIR/whetstone/common/

cp $BASEDIR/../common/util.h $BASEDIR/whetstone/common/
cp $BASEDIR/../common/encoding.h $BASEDIR/whetstone/common/
cp $BASEDIR/../common/strcmp.S $BASEDIR/whetstone/common/
cp $BASEDIR/../common/syscalls.c $BASEDIR/whetstone/common/
cp $BASEDIR/../common/whetstone.mak $BASEDIR/whetstone/Makefile

cd $BASEDIR/whetstone

make PORT_DIR=$BASEDIR/../common