OUTPUT_ARCH( "riscv" )

MEMORY
{
  ram (airwx) : ORIGIN = 0x80000000, LENGTH = 0x100000
  host (airwx) : ORIGIN = 0x90000000, LENGTH = 0x100
}

PHDRS
{
    ram PT_LOAD;
    host PT_LOAD;
}

SECTIONS
{

  .text.init :
  {
    *(.text.init)
  } >ram :ram

  .text :
  {
    *(.text)
  } >ram :ram

  .data :
  {
    *(.data)
  } >ram :ram

  .sdata :
  {
    _gp = . + 0x800;
    *(.sdata)
  } >ram :ram

  .sbss :
  {
    *(.sbss)
  } >ram :ram

  .bss :
  {
    *(.bss)
  } >ram :ram

  .heap (NOLOAD) :
  {
     _end = .;
  } >ram :ram

  .stack (NOLOAD) :
  {
     _sp = ORIGIN(ram) + LENGTH(ram);
  } >ram :ram

  .tohost :
  {
    *(.tohost)
  } >host :host

}
