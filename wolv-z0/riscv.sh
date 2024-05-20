#!/bin/bash
set -e

PREFIX="/opt/rv32imc"
BASEDIR=$(pwd)

ARCH="rv32imc_zicsr"
ABI="ilp32"

GCC_VERSION="basepoints/gcc-15"
NEWLIB_VERSION="newlib-4.4.0"
BINTUILS_VERSION="binutils-2_42"

if [ -d "$PREFIX" ]; then
  sudo rm -rf $PREFIX
fi

sudo mkdir -p $PREFIX
sudo chown -R $USER:$USER $PREFIX

sudo apt-get -y install autoconf automake autotools-dev curl \
                        python3 python3-pip libmpc-dev libmpfr-dev \
                        libgmp-dev gawk build-essential bison flex \
                        texinfo gperf libtool patchutils bc \
                        zlib1g-dev libexpat-dev ninja-build git \
                        cmake libglib2.0-dev libslirp-dev

if [ -d "$BASEDIR/gcc" ]; then
  rm -rf $BASEDIR/gcc
fi
if [ -d "$BASEDIR/binutils" ]; then
  rm -rf $BASEDIR/binutils
fi
if [ -d "$BASEDIR/newlib" ]; then
  rm -rf $BASEDIR/newlib
fi
if [ -d "$BASEDIR/combined" ]; then
  rm -rf $BASEDIR/combined
fi

git clone --branch $GCC_VERSION --depth=1 https://github.com/gcc-mirror/gcc.git $BASEDIR/gcc
git clone --branch $NEWLIB_VERSION --depth=1 https://github.com/bminor/newlib.git $BASEDIR/newlib
git clone --branch $BINTUILS_VERSION --depth=1 https://github.com/bminor/binutils-gdb.git $BASEDIR/binutils

mkdir -p $BASEDIR/combined/build

ln -s $BASEDIR/newlib/* $BASEDIR/combined/.
ln --force -s $BASEDIR/binutils/* $BASEDIR/combined/.
ln --force -s $BASEDIR/gcc/* $BASEDIR/combined/.

cd $BASEDIR/combined/build

../configure --target=riscv32-unknown-elf --enable-languages=c \
             --disable-shared --disable-threads --disable-multilib \
             --disable-gdb --disable-libssp --with-newlib \
             --with-arch=$ARCH --with-abi=$ABI --prefix=$PREFIX

make -j$(nproc)
make install