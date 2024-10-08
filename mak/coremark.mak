default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -O2 -fno-common -funroll-loops -finline-functions -funroll-all-loops -falign-functions=8 -falign-jumps=8 -falign-loops=8 -finline-limit=1000 -mtune=sifive-7-series -ffast-math -fno-tree-loop-distribute-patterns --param fsm-scale-path-stmts=3 -Wno-implicit
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


