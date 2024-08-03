default: all

export CPU ?= wolv-z0

all:
	git submodule update --init --recursive
	./benchmark.sh $(CPU)
	./coremark.sh $(CPU)
	./dhrystone.sh $(CPU)
	./isa.sh $(CPU)
	./whetstone.sh $(CPU)