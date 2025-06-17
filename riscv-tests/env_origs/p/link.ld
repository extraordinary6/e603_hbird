#include "e603_defines.h"
OUTPUT_ARCH( "riscv" )
ENTRY(_start)

INCLUDE evalsoc.memory

SECTIONS
{
  __stack_size = 2K;

  . = ILM_MEMORY_BASE;
  .text.init : { *(.text.init) }
  .tohost ALIGN(0x1000) : { *(.tohost) }
  .data ALIGN(0x1000) : 
  { 
    *(.data)
    . = ALIGN(8);
    PROVIDE( __global_pointer$ = . + 0x800 );
  }
  .bss : { *(.bss) }
  .stack ILM_MEMORY_BASE + ILM_MEMORY_SIZE - __stack_size :
  {
    PROVIDE( _heap_end = . );
    PROVIDE( _sp = 2K);
  }
  _end = .;
}

