default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -O0
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lgcc -T $(ROOTDIR)/rom.ld
RISCV_OBJDUMP ?= $(RISCV)/bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
RISCV_OBJCOPY ?= $(RISCV)/bin/riscv32-unknown-elf-objcopy -O ihex

INCS += -I$(ROOTDIR)

RISCV_GCC_OPTS += -DPERFORMANCE_RUN=1 -DITERATIONS=10 -DMAIN_HAS_NOARGC=1 -DMAIN_HAS_NORETURN=1 -DHAS_FLOAT=0 -DFLAGS_STR=\"\"

rom.riscv: $(wildcard $(ROOTDIR)/*)
	$(RISCV_GCC) $(INCS) $(RISCV_GCC_OPTS) -o $@ $(wildcard $(ROOTDIR)/*.S) $(RISCV_LINK_OPTS)

rom.riscv.dump: %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

JUNK += rom.riscv rom.riscv.dump

all: rom.riscv.dump

clean:
	rm -rf $(JUNK)


