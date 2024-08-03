default: all

export RISCV ?= /opt/rv32imc/
export RISCV_PREFIX ?= /opt/rv32imc/bin/riscv32-unknown-elf-
export ARCH ?= rv32imc_zicsr_zifencei
export ABI ?= ilp32
export CPU ?= wolv-z0

all:
	git submodule update --init --recursive
	./benchmark.sh
	./coremark.sh
	./dhrystone.sh
	./isa.sh
	./whetstone.sh