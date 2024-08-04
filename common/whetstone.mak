default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -DRISCV -O3 -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-tree-dominator-opts -fno-tree-loop-distribute-patterns -Wno-implicit -Wno-stringop-overflow
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lc -lgcc -T $(ROOTDIR)/common/linker.ld
RISCV_OBJDUMP ?= $(RISCV)bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

INCS += -I$(ROOTDIR)/common

whetstone.riscv: $(wildcard $(ROOTDIR)/whetstone/*) $(wildcard $(ROOTDIR)/common/*)
	$(RISCV_GCC) $(INCS) $(RISCV_GCC_OPTS) -o $@ $(wildcard $(ROOTDIR)/*.c) $(wildcard $(ROOTDIR)/*.S) $(wildcard $(ROOTDIR)/common/*.c) $(wildcard $(ROOTDIR)/common/*.S) $(RISCV_LINK_OPTS)

#------------------------------------------------------------

whetstone.riscv.dump: %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

JUNK += whetstone.riscv whetstone.riscv.dump

all: whetstone.riscv.dump

clean:
	rm -rf $(JUNK)
