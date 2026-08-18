default: all

ROOTDIR = .

RISCV_GCC ?= $(RISCV)gcc
RISCV_GCC_OPTS ?= -march=$(ARCH) -mabi=$(ABI) -O0
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lgcc -T $(ROOTDIR)/rom.ld
RISCV_OBJDUMP ?= $(RISCV)objdump -M numeric --disassemble-all --disassemble-zeroes
RISCV_OBJCOPY ?= $(RISCV)objcopy -O binary

INCS += -I$(ROOTDIR)

RISCV_GCC_OPTS += -DPERFORMANCE_RUN=1 -DITERATIONS=10 -DMAIN_HAS_NOARGC=1 -DMAIN_HAS_NORETURN=1 -DHAS_FLOAT=0 -DFLAGS_STR=\"\"

rom.riscv: $(wildcard $(ROOTDIR)/*)
	$(RISCV_GCC) $(INCS) $(RISCV_GCC_OPTS) -o $@ $(wildcard $(ROOTDIR)/*.S) $(RISCV_LINK_OPTS)

rom.riscv.dump: %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

rom.bin: %.bin: %.riscv
	$(RISCV_OBJCOPY) $< $@

JUNK += rom.riscv rom.riscv.dump rom.bin

all: rom.riscv.dump rom.bin

clean:
	rm -rf $(JUNK)


