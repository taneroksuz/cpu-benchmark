#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------

XLEN ?= 32

src_dir := .

ifeq ($(ARCH),"rv32imc_zicsr_zifencei")
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32mi/Makefrag
endif
ifeq ($(ARCH),"rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei")
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32mi/Makefrag
endif
ifeq ($(ARCH),"rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei")
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32uf/Makefrag
include $(src_dir)/rv32mi/Makefrag
endif
ifeq ($(ARCH),"rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei")
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32uf/Makefrag
include $(src_dir)/rv32ud/Makefrag
include $(src_dir)/rv32mi/Makefrag
endif

default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

RISCV_GCC ?= $(RISCV_PREFIX)gcc
RISCV_GCC_OPTS ?= -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
RISCV_SIM ?= spike

vpath %.S $(src_dir)

#------------------------------------------------------------
# Build assembly tests

%.dump: %
	$(RISCV_OBJDUMP) $< > $@

%.out: %
	$(RISCV_SIM) --isa=rv64gc_zfh_zicboz_svnapot_zicntr_zba_zbb_zbc_zbs --misaligned $< 2> $@

%.out32: %
	$(RISCV_SIM) --isa=rv32gc_zfh_zicboz_svnapot_zicntr_zba_zbb_zbc_zbs --misaligned $< 2> $@

define compile_template

$$($(1)_p_tests): $(1)-p-%: $(1)/%.S
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(src_dir)/../env/p -I$(src_dir)/macros/scalar -T$(src_dir)/../env/p/link.ld $$< -o $$@
$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))

$(1): $$($(1)_tests_dump)

.PHONY: $(1)

COMPILER_SUPPORTS_$(1) := $$(shell $$(RISCV_GCC) $(2) -c -x c /dev/null -o /dev/null 2> /dev/null; echo $$$$?)

ifeq ($$(COMPILER_SUPPORTS_$(1)),0)
tests += $$($(1)_tests)
endif

endef

ifeq ($(ARCH),"rv32imc_zicsr_zifencei")
$(eval $(call compile_template,rv32ui,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uc,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),"rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei")
$(eval $(call compile_template,rv32ui,-march=rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uc,-march=rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),"rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei")
$(eval $(call compile_template,rv32ui,-march=rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uc,-march=rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32um,-march=rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uf,-march=rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32mi,-march=rv32imfc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
endif
ifeq ($(ARCH),"rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei")
$(eval $(call compile_template,rv32ui,-march=rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uc,-march=rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32um,-march=rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uf,-march=rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32mi,-march=rv32imfdc_zba_zbb_zbc_zbs_zicsr_zifencei -mabi=ilp32f))
endif

tests_dump = $(addsuffix .dump, $(tests))
tests_hex = $(addsuffix .hex, $(tests))
tests_out = $(addsuffix .out, $(filter rv32%,$(tests)))

run: $(tests_out)

junk += $(tests) $(tests_dump) $(tests_hex) $(tests_out)

#------------------------------------------------------------
# Default

all: $(tests_dump)

#------------------------------------------------------------
# Clean up

clean:
	rm -rf $(junk)
