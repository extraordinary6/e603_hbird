// See LICENSE for license details.
#ifndef _RISCV_TEST_MINI_H__
#define _RISCV_TEST_MINI_H__

#include "../encoding.h"
#include "e603_defines.h"
//-----------------------------------------------------------------------
// Begin Macro
//-----------------------------------------------------------------------

#define  INITIAL_X    \
        li   x1 , 0;\
        li   x2 , 0;\
        li   x3 , 0;\
        li   x4 , 0;\
        li   x5 , 0;\
        li   x6 , 5;\
        li   x7 , 6;\
        li   x8 , 7;\
        li   x9 , 8;\
        li   x10 , 9;\
        li   x11 , 10;\
        li   x12 , 11;\
        li   x13 , 12;\
        li   x14 , 13;\
        li   x15 , 14;\
#ifndef N600_CFG_REGNUM_IS_16 \
        li   x16 , 15;\
        li   x17 , 16;\
        li   x18 , 17;\
        li   x19 , 18;\
        li   x20 , 19;\
        li   x21 , 20;\
        li   x22 , 21;\
        li   x23 , 22;\
        li   x24 , 23;\
        li   x25 , 24;\
        li   x26 , 25;\
        li   x27 , 26;\
        li   x28 , 27;\
        li   x29 , 28;\
        li   x31 , 29;\
#endif \

#define RVTEST_RV64U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV64UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV32U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV32UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV64M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV64S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#define RVTEST_RV32M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV32S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#if __riscv_xlen == 64
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bgez a0, 1f; RVTEST_PASS; 1:
#else
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bltz a0, 1f; RVTEST_PASS; 1:
#endif

#define INIT_PMP                                                        \
#define ICACHE_INIT nop




#define RVTEST_ENABLE_SUPERVISOR                    

#define RVTEST_ENABLE_MACHINE                               

#define RVTEST_FP_ENABLE                                        

#define RISCV_MULTICORE_DISABLE                                 

#define EXTRA_TVEC_USER
#define EXTRA_TVEC_MACHINE
#define EXTRA_INIT
#define EXTRA_INIT_TIMER

#define INTERRUPT_HANDLER 

#define RVTEST_CODE_BEGIN                                               \
        .section .text.init;                                            \
        .align  6;                                                      \
        .globl _start;                                                  \
_start:                                                                 \
        INITIAL_X ;               \
        /* reset vector */                                              \
        j  reset_vector;                                                \
        .align 2;                                                       \
reset_vector:                                                           \
        /*Bruce allocate stack point end address*/          \
		.option push;                                       \
		.option norelax;                                    \
		la gp, __global_pointer$;                             \
		.option pop;                                           \
        la t0, _sp;                                                      \
        mv sp, t0;                                                      \
        /* Bob Initialize t1 and t2 here: Begin */                       \
        mv t1, x0;                                                  \
        mv t2, x0;                                                  \

//-----------------------------------------------------------------------
// End Macro
//-----------------------------------------------------------------------

#define RVTEST_CODE_END                                                 \
        unimp

//-----------------------------------------------------------------------
// Pass/Fail Macro
//-----------------------------------------------------------------------
#define RVTEST_PASS                                                     \
      fence; \
      li a0, (EVALSOC_CFG_PERIPS_BASE + 0x13000); \
      la a1, pass_str; \
1: \
      lb a2, (a1); \
      addi a1, a1, 1;\
      sb a2, (a0); \
      bnez a2, 1b; \
      wfi; \
pass_str: \
      .string "TEST_PASS\04"; \
fail_str: \
      .string "TEST_FAIL\04"; \

#define TESTNUM tp


#define RVTEST_FAIL                                                     \
      fence; \
      li a0, (EVALSOC_CFG_PERIPS_BASE + 0x13000); \
      la a1, fail_str; \
1: \
      lb a2, (a1); \
      addi a1, a1, 1;\
      sb a2, (a0); \
      bnez a2, 1b; \
      wfi; \

//-----------------------------------------------------------------------
// Data Section Macro
//-----------------------------------------------------------------------

#define EXTRA_DATA

#define RVTEST_DATA_BEGIN                                               \
        EXTRA_DATA                                                      \
        .pushsection .tohost,"aw",@progbits;                            \
        .align 6; .global tohost; tohost: .dword 0;                     \
        .align 6; .global fromhost; fromhost: .dword 0;                 \
        .popsection;                                                    \
        .align 4; .global begin_signature; begin_signature:

#define RVTEST_DATA_END .align 4; .global end_signature; end_signature:

#endif
