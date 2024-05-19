OUTPUT_ARCH( "riscv" )

MEMORY
{
  host (airwx) : ORIGIN = 0x1000000, LENGTH = 0x100
  bram (airwx) : ORIGIN = 0x80000000, LENGTH = 0x100000
}

PHDRS
{
    host PT_LOAD;
    bram PT_LOAD;
}

SECTIONS
{
  __stack_size = DEFINED(__stack_size) ? __stack_size : 0x400;
  __heap_size = DEFINED(__heap_size) ? __heap_size : 0x800;

  .tohost :
  {
    *(.tohost)
  } >host :host

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
    *(.srodata.cst16)
    *(.srodata.cst8)
    *(.srodata.cst4)
    *(.srodata.cst2)
    *(.srodata*)
    *(.sdata
      .sdata.*
      .gnu.linkonce.s.*)
  } >bram :bram

  .sbss :
  {
    *(.sbss
      .sbss.*
      .gnu.linkonce.sb.*)
    *(.scommon)
  } >bram :bram

  .bss :
  {
    *(.bss)
  } >bram :bram

  .stack (NOLOAD) : ALIGN(16)
  {
      PROVIDE(stack_begin = .);
      . += __stack_size;
      PROVIDE( _sp = . );
      PROVIDE(stack_end = .);
  } >bram :bram

  .heap (NOLOAD) : ALIGN(8)
  {
      PROVIDE( __end = . );
      PROVIDE( __heap_start = . );
      . = DEFINED(__heap_max) ? MIN( LENGTH(bram) - ( . - ORIGIN(bram) ) , 0x100000) : __heap_size;
      PROVIDE( _heap_end = . );
      PROVIDE( __heap_end = . );
  } >bram :bram

}
