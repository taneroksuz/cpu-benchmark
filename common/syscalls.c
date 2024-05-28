// See LICENSE for license details.

#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include "util.h"

#define SYS_write 64
#define SYS_exit 93
#define SYS_stats 1234

#define UART 0x1000000

extern volatile uint64_t tohost;
extern volatile uint64_t fromhost;

static uintptr_t handle_frontend_syscall(uintptr_t which, uint64_t arg0, uint64_t arg1, uint64_t arg2)
{
  volatile uint64_t magic_mem[8] __attribute__((aligned(64)));
  magic_mem[0] = which;
  magic_mem[1] = arg0;
  magic_mem[2] = arg1;
  magic_mem[3] = arg2;
  __sync_synchronize();

  tohost = (uintptr_t)magic_mem;
  while (fromhost == 0)
    ;
  fromhost = 0;

  __sync_synchronize();
  return magic_mem[0];
}

#define NUM_COUNTERS 2
static uintptr_t counters[NUM_COUNTERS];
static char* counter_names[NUM_COUNTERS];

static int handle_stats(int enable)
{
  int i = 0;
#define READ_CTR(name) do { \
    while (i >= NUM_COUNTERS) ; \
    uintptr_t csr = read_csr(name); \
    if (!enable) { csr -= counters[i]; counter_names[i] = #name; } \
    counters[i++] = csr; \
  } while (0)

  READ_CTR(mcycle);
  READ_CTR(minstret);

#undef READ_CTR
  return 0;
}

void __attribute__((noreturn)) tohost_exit(uintptr_t code)
{
  tohost = (code << 1) | 1;
  while (1);
}

uintptr_t handle_trap(uintptr_t cause, uintptr_t epc, uintptr_t regs[32])
{
  if (cause != CAUSE_MACHINE_ECALL)
    tohost_exit(1337);
  else if (regs[17] == SYS_exit)
    tohost_exit(regs[10]);
  else if (regs[17] == SYS_stats)
    regs[10] = handle_stats(regs[10]);
  else
    regs[10] = handle_frontend_syscall(regs[17], regs[10], regs[11], regs[12]);

  return epc + ((*(unsigned short*)epc & 3) == 3 ? 4 : 2);
}

static uintptr_t syscall(uintptr_t num, uintptr_t arg0, uintptr_t arg1, uintptr_t arg2)
{
  register uintptr_t a7 asm("a7") = num;
  register uintptr_t a0 asm("a0") = arg0;
  register uintptr_t a1 asm("a1") = arg1;
  register uintptr_t a2 asm("a2") = arg2;
  asm volatile ("scall" : "+r"(a0) : "r"(a1), "r"(a2), "r"(a7));
  return a0;
}

void exit(int code)
{
  syscall(SYS_exit, code, 0, 0);
  while (1);
}

void setStats(int enable)
{
  syscall(SYS_stats, enable, 0, 0);
}

void printstr(const char* s)
{
  syscall(SYS_write, 1, (uintptr_t)s, strlen(s));
}

int __attribute__((weak)) main(int argc, char** argv)
{
  // single-threaded programs override this function.
  printstr("Implement main(), foo!\n");
  return -1;
}

#undef putchar
int putchar(int ch)
{
  *(volatile int*)UART = (char) ch;
  return 0;
}

#define UNIMPL_FUNC(_f) ".globl " #_f "\n.type " #_f ", @function\n" #_f ":\n"

asm (
	".text\n"
	".align 2\n"
	UNIMPL_FUNC(_open)
	UNIMPL_FUNC(_openat)
	UNIMPL_FUNC(_lseek)
	UNIMPL_FUNC(_stat)
	UNIMPL_FUNC(_lstat)
	UNIMPL_FUNC(_fstatat)
	UNIMPL_FUNC(_isatty)
	UNIMPL_FUNC(_access)
	UNIMPL_FUNC(_faccessat)
	UNIMPL_FUNC(_link)
	UNIMPL_FUNC(_unlink)
	UNIMPL_FUNC(_execve)
	UNIMPL_FUNC(_getpid)
	UNIMPL_FUNC(_fork)
	UNIMPL_FUNC(_kill)
	UNIMPL_FUNC(_wait)
	UNIMPL_FUNC(_times)
	UNIMPL_FUNC(_gettimeofday)
	UNIMPL_FUNC(_ftime)
	UNIMPL_FUNC(_utime)
	UNIMPL_FUNC(_chown)
	UNIMPL_FUNC(_chmod)
	UNIMPL_FUNC(_chdir)
	UNIMPL_FUNC(_getcwd)
	UNIMPL_FUNC(_sysconf)
	"j unimplemented_syscall\n"
);

void unimplemented_syscall()
{
	const char *p = "Unimplemented system call called!\n";
	while (*p)
		*(volatile int*)UART = *(p++);
	asm volatile ("ebreak");
	__builtin_unreachable();
}

void _init(int cid, int nc)
{
  int ret = main(0, 0);

  exit(ret);
}

ssize_t _read(int file, void *ptr, size_t len)
{
  return 0;
}

ssize_t _write(int file, const void *ptr, size_t len)
{
  const void *eptr = ptr + len;
  while (ptr != eptr)
    *(volatile int*)UART = *(char*)(ptr++);
  return len;
}

int _close(int file)
{
  return 0;
}

int _fstat(int file, struct stat *st)
{
  errno = ENOENT;
  return -1;
}

void *_sbrk(ptrdiff_t incr)
{
  extern unsigned char _end[];
  static unsigned long heap_end;

  if (heap_end == 0)
    heap_end = (long)_end;

  heap_end += incr;
  return (void *)(heap_end - incr);
}

void _exit(int exit_status)
{
	asm volatile ("ebreak");
	__builtin_unreachable();
}
