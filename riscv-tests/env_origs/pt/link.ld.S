#include "e603_defines.h"
OUTPUT_ARCH( "riscv" )
ENTRY(_start)

#ifdef N600_ILM_BASE_ADDR
  #define ILM_BASE_ADDR N600_ILM_BASE_ADDR;
  #define ILM_ADDR_WIDTH N600_CFG_ILM_ADDR_WIDTH 
#else
  #define ILM_BASE_ADDR 0x80000000; 
  #define ILM_ADDR_WIDTH 16
#endif

SECTIONS
{
  __stack_size = 2K;

  . = ILM_BASE_ADDR;
  .text.init : { *(.text.init) }
  .tohost ALIGN(0x1000) : { *(.tohost) }
  .text ALIGN(0x1000) : { *(.text) }
  .data ALIGN(0x1000) : 
  { 
    *(.data)
    . = ALIGN(8);
    PROVIDE( __global_pointer$ = . + 0x800 );
  }
  .bss : { *(.bss) }
  .stack ILM_BASE_ADDR + (1 << ILM_ADDR_WIDTH) - __stack_size :
  {
    PROVIDE( _heap_end = . );
    PROVIDE( _sp = 2K);
  }
  _end = .;
}

