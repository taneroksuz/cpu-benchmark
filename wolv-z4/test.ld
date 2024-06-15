OUTPUT_ARCH( "riscv" )

MEMORY
{
  tim0 (rwx) : ORIGIN = 0x10000000, LENGTH = 0x100000
  tim1 (rwx) : ORIGIN = 0x20000000, LENGTH = 0x100000
  ram (rwx) : ORIGIN = 0x80000000, LENGTH = 0x100000
  host (rwx) : ORIGIN = 0x90000000, LENGTH = 0x100
}

SECTIONS
{

  OVERLAY :
  {
    .text.init
    {
      *(.text.init)
    }
  } >ram AT>ram

  OVERLAY :
  {
    .text
    {
      *(.text*)
    }
  } >tim0 AT>ram

  OVERLAY :
  {
    .data
    {
      *(.rodata*)
      *(.srodata*)
      *(.data*)
      *(.sdata*)
      *(.bss*)
      *(.sbss*)
    }
    .heap
    {
      _end = .;
    }
    .stack
    {
      _sp = ORIGIN(tim1) + LENGTH(tim1);
    }
  } >tim1 AT>ram

  .tohost :
  {
    *(.tohost)
  } >host

  PROVIDE(__tim0_start = ORIGIN(tim0));
  PROVIDE(__tim0_end = ORIGIN(tim0) + LENGTH(tim0));

  PROVIDE(__tim1_start = ORIGIN(tim1));
  PROVIDE(__tim1_end = ORIGIN(tim1) + LENGTH(tim1));

}

