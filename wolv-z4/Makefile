abs_top_src_dir  := ${BASEDIR}
bmarkdir         := $(abs_top_src_dir)/benchmarks

XLEN             := ${XLEN}
RISCV_PREFIX     := ${RISCV_PREFIX}
RISCV_GCC_OPTS   := ${RISCV_GCC_OPTS}
RISCV_PREFIX_VAR := 

all: benchmarks

install: all
	install -d $(instbasedir)/share/benchmarks
	install -p -m 644 `find benchmarks -maxdepth 1 -type f` $(instbasedir)/share/benchmarks

benchmarks:
	mkdir -p benchmarks
	$(MAKE) -C benchmarks -f $(bmarkdir)/Makefile src_dir=$(bmarkdir) XLEN=$(XLEN) $(RISCV_PREFIX_VAR)

clean:
	[ ! -d benchmarks ] || $(MAKE) -C benchmarks -f $(bmarkdir)/Makefile src_dir=$(bmarkdir) clean

.PHONY: benchmarks

