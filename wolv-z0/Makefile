abs_top_src_dir  := ${BASEDIR}/riscv-tests
bmarkdir         := $(abs_top_src_dir)/benchmarks

XLEN             := ${XLEN}
RISCV_PREFIX     := ${RISCV_PREFIX}
RISCV_GCC_OPTS   := ${RISCV_GCC_OPTS}
RISCV_PREFIX_VAR := 

all:
	mkdir -p benchmarks
	$(MAKE) -C benchmarks -f $(bmarkdir)/Makefile src_dir=$(bmarkdir) XLEN=$(XLEN) $(RISCV_PREFIX_VAR)

.PHONY: all

