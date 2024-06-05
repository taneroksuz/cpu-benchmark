OUTPUT_ARCH( "riscv" )

MEMORY
{
  ram (rwx) : ORIGIN = 0x80000000, LENGTH = 0x100000
  host (rwx) : ORIGIN = 0x90000000, LENGTH = 0x100
}

SECTIONS
{

  .text.init :
  {
    *(.text.init)
  } >ram

  .text :
  {
    *(.text)
  } >ram

  .data :
  {
    *(.data)
  } >ram

  .sdata :
  {
    _gp = . + 0x800;
    *(.sdata)
  } >ram

  .sbss :
  {
    *(.sbss)
  } >ram

  .bss :
  {
    *(.bss)
  } >ram

  .heap (NOLOAD) :
  {
     _end = .;
  } >ram

  .stack (NOLOAD) :
  {
     _sp = ORIGIN(ram) + LENGTH(ram);
  } >ram

  .tohost :
  {
    *(.tohost)
  } >host

}
