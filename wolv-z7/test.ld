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
      . = ALIGN(8);
      __store_start_text = .;
      *(.text)
      __store_stop_text = .;
    }
  } >tim0 AT>ram

  OVERLAY :
  {
    .data
    {
      . = ALIGN(8);
      __store_start_data = .;
      *(.data)
    }
    .sdata
    {
      _gp = . + 0x800;
      *(.sdata)
      __store_stop_data = .;
    }
    .sbss
    {
      __store_start_bss = .;
      *(.sbss)
    }
    .bss
    {
      *(.bss)
      __store_stop_bss = .;
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

}

