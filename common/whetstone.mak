default: all

src_dir = .

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

RISCV_GCC ?= $(RISCV)bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -DRISCV -O3 -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-tree-dominator-opts -fno-tree-loop-distribute-patterns -Wno-implicit -Wno-stringop-overflow
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lc -lgcc -T $(src_dir)/common/linker.ld
RISCV_OBJDUMP ?= $(RISCV)bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

incs  += -I$(src_dir)/common
objs  :=

whetstone.riscv: $(wildcard $(src_dir)/whetstone/*) $(wildcard $(src_dir)/common/*)
	$(RISCV_GCC) $(incs) $(RISCV_GCC_OPTS) -o $@ $(wildcard $(src_dir)/*.c) $(wildcard $(src_dir)/*.S) $(wildcard $(src_dir)/common/*.c) $(wildcard $(src_dir)/common/*.S) $(RISCV_LINK_OPTS)

#------------------------------------------------------------

whetstone.riscv.dump: %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

all: whetstone.riscv.dump

clean:
	rm -rf $(objs) $(junk)
