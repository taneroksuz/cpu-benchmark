default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -O3 -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-tree-dominator-opts -fno-tree-loop-distribute-patterns -Wno-implicit
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lgcc -T $(ROOTDIR)/common/linker.ld
RISCV_OBJDUMP ?= $(RISCV)/bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

INCS += -I$(ROOTDIR)/common -I$(ROOTDIR)

RISCV_GCC_OPTS += -DPERFORMANCE_RUN=1 -DITERATIONS=10 -DMAIN_HAS_NOARGC=1 -DMAIN_HAS_NORETURN=1 -DHAS_FLOAT=0 -DFLAGS_STR=\"\"

coremark.riscv: $(wildcard $(ROOTDIR)/*) $(wildcard $(ROOTDIR)/common/*)
	$(RISCV_GCC) $(INCS) $(RISCV_GCC_OPTS) -o $@ $(wildcard $(ROOTDIR)/*.c) $(wildcard $(ROOTDIR)/*.S) $(wildcard $(ROOTDIR)/common/*.c) $(wildcard $(ROOTDIR)/common/*.S) $(RISCV_LINK_OPTS)

coremark.riscv.dump: %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

JUNK += coremark.riscv coremark.riscv.dump

all: coremark.riscv.dump

clean:
	rm -rf $(JUNK)


