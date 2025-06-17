# See LICENSE for license details.

#*****************************************************************************
# dsp_wext.S
#-----------------------------------------------------------------------------
#
# Test DSP extract 32bit frim a 64 bit data operation.
#

#define WEXTI_OP(testnum, in_h, in_l, imm, exp) \
  li TESTNUM, testnum  ;                    \
  li t1, in_l          ;                    \
  li t2, in_h          ;                    \
  li t0, exp           ;                    \
  wexti t3, t1, imm    ;                    \
  bne t3, t0, fail     ;                    

#define WEXT_OP(testnum, in_h, in_l, imm, exp)  \
  li TESTNUM, testnum  ;                    \
  li t1, in_l          ;                    \
  li t2, in_h          ;                    \
  li t0, exp           ;                    \
  li t3, imm           ;                    \
  wext t4, t1, t3      ;                    \
  bne t4, t0, fail     ;                    

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2

#ifdef N600_CFG_HAS_DSP

#########################################################################
# wexti
#########################################################################
  WEXTI_OP(2,  0x12345678, 0x9abcdef0, 31, 0x2468acf1)
  WEXTI_OP(3,  0x12345678, 0x9abcdef0,  0, 0x9abcdef0)

#########################################################################
# wext
#########################################################################
  WEXT_OP(2,  0x12345678, 0x9abcdef0, 31, 0x2468acf1)
  WEXT_OP(3,  0x12345678, 0x9abcdef0,  0, 0x9abcdef0)

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

