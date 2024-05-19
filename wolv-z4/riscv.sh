#!/bin/bash
set -e

PREFIX="/opt/rv32imfcb"
BASEDIR=$(pwd)


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

if [ -d "$BASEDIR/riscv-gnu-toolchain" ]; then
  rm -rf $BASEDIR/riscv-gnu-toolchain
fi

git clone https://github.com/riscv/riscv-gnu-toolchain $BASEDIR/riscv-gnu-toolchain

cd $BASEDIR/riscv-gnu-toolchain

./configure --prefix=$PREFIX --with-arch=rv32imcf_zba_zbb_zbc_zbs_zicsr --with-abi=ilp32
make -j$(nproc)