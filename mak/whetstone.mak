default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -DRISCV -O2 -fno-common -funroll-loops -finline-functions -funroll-all-loops -falign-functions=8 -falign-jumps=8 -falign-loops=8 -finline-limit=1000 -mtune=sifive-7-series -ffast-math -fno-tree-loop-distribute-patterns --param fsm-scale-path-stmts=3 -Wno-implicit -Wno-stringop-overflow
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lc -lgcc -T $(ROOTDIR)/common/linker.ld
RISCV_OBJDUMP ?= $(RISCV)/bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

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
