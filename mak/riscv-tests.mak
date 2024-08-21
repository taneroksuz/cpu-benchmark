default: all

ROOTDIR = .

bmarks = \
	median \
	qsort \
	rsort \
	towers \
	vvadd \
	memcpy \
	multiply \
	dhrystone \
	spmv \
	pmp \

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -O3 -Wno-implicit
RISCV_LINK_OPTS ?= -static -nostartfiles -lm -lgcc -T $(ROOTDIR)/common/linker.ld
RISCV_OBJDUMP ?= $(RISCV)/bin/riscv32-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

INCS += -I$(ROOTDIR)/../env -I$(ROOTDIR)/common $(addprefix -I$(ROOTDIR)/, $(bmarks))

define compile_template
$(1).riscv: $(wildcard $(ROOTDIR)/$(1)/*) $(wildcard $(ROOTDIR)/common/*)
	$$(RISCV_GCC) $$(INCS) $$(RISCV_GCC_OPTS) -o $$@ $(wildcard $(ROOTDIR)/$(1)/*.c) $(wildcard $(ROOTDIR)/$(1)/*.S) $(wildcard $(ROOTDIR)/common/*.c) $(wildcard $(ROOTDIR)/common/*.S) $$(RISCV_LINK_OPTS)
endef

$(foreach bmark,$(bmarks),$(eval $(call compile_template,$(bmark))))

bmarks_riscv_bin  = $(addsuffix .riscv,  $(bmarks))
bmarks_riscv_dump = $(addsuffix .riscv.dump, $(bmarks))

$(bmarks_riscv_dump): %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

riscv: $(bmarks_riscv_dump)

JUNK += $(bmarks_riscv_bin) $(bmarks_riscv_dump)

all: riscv

clean:
	rm -rf $(JUNK)


