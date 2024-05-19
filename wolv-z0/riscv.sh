#!/bin/bash
set -e

PREFIX="/opt/rv32imc"

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

if [ -d "$BASEDIR/$CPU/riscv-gnu-toolchain" ]; then
  rm -rf $BASEDIR/$CPU/riscv-gnu-toolchain
fi

git clone https://github.com/riscv/riscv-gnu-toolchain $BASEDIR/$CPU/

cd $BASEDIR/$CPU/riscv-gnu-toolchain

./configure --prefix=$PREFIX --with-arch=rv32imc --with-abi=ilp32
make -j$(nproc)