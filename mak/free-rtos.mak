default: all

ROOTDIR             = .

RISCV_PREFIX        = $(RISCV)/bin/riscv32-unknown-elf-
FREERTOS_SOURCE_DIR = $(ROOTDIR)/free-rtos-kernel
FREERTOS_POSIX_DIR  = $(ROOTDIR)/free-rtos-posix

AR                  = $(RISCV_PREFIX)ar
CC                  = $(RISCV_PREFIX)gcc
OBJDUMP             = $(RISCV_PREFIX)objdump
OBJCOPY             = $(RISCV_PREFIX)objcopy
READELF             = $(RISCV_PREFIX)readelf

RISCV_GCC_OPTS      = -mcmodel=medany -nostartfiles -nostdlib -Wno-maybe-uninitialized -Wno-address
RISCV_OBJDUMP_OPTS  = --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data

FREERTOS_SRC = \
    $(FREERTOS_SOURCE_DIR)/croutine.c \
    $(FREERTOS_SOURCE_DIR)/list.c \
    $(FREERTOS_SOURCE_DIR)/queue.c \
    $(FREERTOS_SOURCE_DIR)/tasks.c \
    $(FREERTOS_SOURCE_DIR)/timers.c \
    $(FREERTOS_SOURCE_DIR)/stream_buffer.c \
    $(FREERTOS_SOURCE_DIR)/event_groups.c \
    $(FREERTOS_SOURCE_DIR)/portable/MemMang/heap_3.c

FREERTOS_POSIX_SRC = \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_clock.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_mqueue.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_pthread.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_pthread_barrier.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_pthread_cond.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_pthread_mutex.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_sched.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_semaphore.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_timer.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_unistd.c \
    $(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/source/FreeRTOS_POSIX_utils.c

PORT_SRC = $(FREERTOS_SOURCE_DIR)/portable/GCC/RISC-V/port.c \
           ./port.c \
           ./syscall.c \

PORT_ASM = $(FREERTOS_SOURCE_DIR)/portable/GCC/RISC-V/portASM.S \
           ./crt.S

MAIN_SRC = free-rtos.c

RTOS_OBJ = $(FREERTOS_SRC:.c=.o)
POSIX_OBJ= $(FREERTOS_POSIX_SRC:.c=.o)
PORT_OBJ = $(PORT_SRC:.c=.o)
PORT_ASM_OBJ = $(PORT_ASM:.S=.o)
MAIN_OBJ = $(MAIN_SRC:.c=.riscv)
OBJS = $(PORT_ASM_OBJ) $(PORT_OBJ) $(RTOS_OBJ) $(POSIX_OBJ)
FREERTOS_LIBRARY = libfreertos.a
POSIX_LIBRARY = libpthread.a

INCLUDES = \
    -I$(FREERTOS_SOURCE_DIR)/include \
    -I$(FREERTOS_SOURCE_DIR)/portable/GCC/RISC-V \
    -I$(FREERTOS_POSIX_DIR)/include \
    -I$(FREERTOS_POSIX_DIR)/include/private \
    -I$(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/include \
    -I$(FREERTOS_POSIX_DIR)/FreeRTOS-Plus-POSIX/include/portable \
    -I./

CFLAGS   = -O2 -g -Wall $(INCLUDES) $(RISCV_GCC_OPTS)
LDFLAGS  = -L. -T ./linker.ld $(RISCV_GCC_OPTS)
LIBS     = -lfreertos -lpthread -lm -lc -lgcc

.PHONY: clean

all: $(FREERTOS_LIBRARY) $(POSIX_LIBRARY) $(MAIN_OBJ)

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o: %.S
	$(CC) -c $(CFLAGS) -o $@ $<

$(FREERTOS_LIBRARY): $(PORT_ASM_OBJ) $(PORT_OBJ) $(RTOS_OBJ)
	$(AR) rcs $@ $(PORT_ASM_OBJ) $(PORT_OBJ) $(RTOS_OBJ)

$(POSIX_LIBRARY): $(POSIX_OBJ)
	$(AR) rcs $@ $(POSIX_OBJ)

%.riscv: %.c
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS) $(LIBS)
	$(OBJDUMP) $(RISCV_OBJDUMP_OPTS) $@ > $(@:.riscv=.dump)

clean:
	$(RM) -f $(OBJS) $(FREERTOS_LIBRARY) $(POSIX_LIBRARY)