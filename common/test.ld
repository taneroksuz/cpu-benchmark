OUTPUT_ARCH( "riscv" )

MEMORY
{
  bram (airwx) : ORIGIN = 0x80000000, LENGTH = 0x100000
  host (airwx) : ORIGIN = 0x90000000, LENGTH = 0x100
}

PHDRS
{
    bram PT_LOAD;
    host PT_LOAD;
}

SECTIONS
{

  .text.init :
  {
    *(.text.init)
  } >bram :bram

  .text :
  {
    *(.text)
  } >bram :bram

  .data :
  {
    *(.data)
  } >bram :bram

  .sdata :
  {
    _gp = . + 0x800;
    *(.sdata)
  } >bram :bram

  .sbss :
  {
    *(.sbss)
  } >bram :bram

  .bss :
  {
    *(.bss)
  } >bram :bram

  .heap (NOLOAD) :
  {
     _end = .;
  } >bram :bram

  .stack (NOLOAD) :
  {
     _sp = ORIGIN(bram) + LENGTH(bram);
  } >bram :bram

  .tohost :
  {
    *(.tohost)
  } >host :host

}
