default: all

ROOTDIR := .

ifeq ($(ARCH),rv32i_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif
ifeq ($(ARCH),rv32im_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32um/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif
ifeq ($(ARCH),rv32imc_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32um/Makefrag
include $(ROOTDIR)/rv32uc/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif
ifeq ($(ARCH),rv32imcb_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32um/Makefrag
include $(ROOTDIR)/rv32uc/Makefrag
include $(ROOTDIR)/rv32uzba/Makefrag
include $(ROOTDIR)/rv32uzbb/Makefrag
include $(ROOTDIR)/rv32uzbs/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif
ifeq ($(ARCH),rv32imfcb_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32um/Makefrag
include $(ROOTDIR)/rv32uc/Makefrag
include $(ROOTDIR)/rv32uf/Makefrag
include $(ROOTDIR)/rv32uzba/Makefrag
include $(ROOTDIR)/rv32uzbb/Makefrag
include $(ROOTDIR)/rv32uzbs/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif
ifeq ($(ARCH),rv32imfdcb_zicsr_zifencei)
include $(ROOTDIR)/rv32ui/Makefrag
include $(ROOTDIR)/rv32um/Makefrag
include $(ROOTDIR)/rv32uc/Makefrag
include $(ROOTDIR)/rv32uf/Makefrag
include $(ROOTDIR)/rv32ud/Makefrag
include $(ROOTDIR)/rv32uzba/Makefrag
include $(ROOTDIR)/rv32uzbb/Makefrag
include $(ROOTDIR)/rv32uzbs/Makefrag
include $(ROOTDIR)/rv32mi/Makefrag
endif

default: all

RISCV_GCC ?= $(RISCV)/bin/riscv32-unknown-elf-gcc
RISCV_GCC_OPTS ?= -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles
RISCV_OBJDUMP ?= $(RISCV)/bin/riscv32-unknown-elf-objdump -M numeric --disassemble-all --disassemble-zeroes

vpath %.S $(ROOTDIR)

%.dump: %
	$(RISCV_OBJDUMP) $< > $@

define compile_template

$$($(1)_p_tests): $(1)-p-%: $(1)/%.S
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(ROOTDIR)/../env/p -I$(ROOTDIR)/macros/scalar -T$(ROOTDIR)/../env/p/link.ld $$< -o $$@
$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))

$(1): $$($(1)_tests_dump)

.PHONY: $(1)

COMPILER_SUPPORTS_$(1) := $$(shell $$(RISCV_GCC) $(2) -c -x c /dev/null -o /dev/null 2> /dev/null; echo $$$$?)

ifeq ($$(COMPILER_SUPPORTS_$(1)),0)
tests += $$($(1)_tests)
endif

endef

ifeq ($(ARCH),rv32i_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32i_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32i_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),rv32im_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32im_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32im_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32im_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),rv32imc_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uc,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imc_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),rv32imcb_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uc,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32um,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzba,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbb,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbs,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imcb_zicsr_zifencei -mabi=ilp32))
endif
ifeq ($(ARCH),rv32imfcb_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uc,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32um,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uf,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32f))
$(eval $(call compile_template,rv32uzba,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbb,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbs,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imfcb_zicsr_zifencei -mabi=ilp32f))
endif
ifeq ($(ARCH),rv32imfdcb_zicsr_zifencei)
$(eval $(call compile_template,rv32ui,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
$(eval $(call compile_template,rv32uc,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
$(eval $(call compile_template,rv32um,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
$(eval $(call compile_template,rv32uf,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
$(eval $(call compile_template,rv32ud,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
$(eval $(call compile_template,rv32uzba,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbb,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32uzbs,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32))
$(eval $(call compile_template,rv32mi,-march=rv32imfdcb_zicsr_zifencei -mabi=ilp32d))
endif

tests_dump = $(addsuffix .dump, $(tests))

JUNK += $(tests) $(tests_dump)

all: $(tests_dump)

clean:
	rm -rf $(JUNK)