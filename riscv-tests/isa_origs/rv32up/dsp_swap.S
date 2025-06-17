# See LICENSE for license details.

#*****************************************************************************
# dsp_swap.S
#-----------------------------------------------------------------------------
#
# Test DSP bit reverse operation.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2

#ifdef N600_CFG_HAS_DSP

#########################################################################
# swap8
#########################################################################
  li TESTNUM, 2
  li t0, 0x12345678
  li t1, 0x34127856
  swap8 t2, t0
  bne t2 ,t1, fail

#########################################################################
# swap16
#########################################################################
  li TESTNUM, 3
  li t0, 0x12345678
  li t1, 0x56781234
  swap16 t2, t0
  bne t2 ,t1, fail

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

