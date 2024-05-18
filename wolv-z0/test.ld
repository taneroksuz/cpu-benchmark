OUTPUT_ARCH( "riscv" )

SECTIONS
{
    __stack_size = DEFINED(__stack_size) ? __stack_size : 0x400;
    PROVIDE(__stack_size = __stack_size);

    __heap_size = DEFINED(__heap_size) ? __heap_size : 0x800;

  . = 0x1000000;

  .tohost :
  {
    *(.tohost)
  }

  . = 0x80000000;

  .text.init :
  {
    crt.o(.text)
  }

  .text :
  {
    *(.text)
  }

  .data :
  {
    *(.data)
  }

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
  }

  .sbss :
  {
    *(.sbss
      .sbss.*
      .gnu.linkonce.sb.*)
    *(.scommon)
  }

  .bss :
  {
    *(.bss)
  }

  .stack (NOLOAD) : ALIGN(16)
  {
      PROVIDE(stack_begin = .);
      . += __stack_size;
      PROVIDE( _sp = . );
      PROVIDE(stack_end = .);
  }

  .heap (NOLOAD) : ALIGN(8)
  {
      PROVIDE( __end = . );
      PROVIDE( __heap_start = . );
      . = DEFINED(__heap_max) ? MIN( 0x100000 - ( . - 0x80000000 ) , 0x100000) : __heap_size;
      PROVIDE( _heap_end = . );
      PROVIDE( __heap_end = . );
  }

}
