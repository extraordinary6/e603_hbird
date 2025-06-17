# See LICENSE for license details.

#*****************************************************************************
# dsp_bpick.S
#-----------------------------------------------------------------------------
#
# Test DSP packing operation.
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
# bpick
#########################################################################
  li TESTNUM, 2
  li t0, 0xffffffff
  li t1, 0x00000000
  li t2, 0xffffffff
  bpick t3, t1, t0, t2
  bne t3, t1, fail

  li TESTNUM, 3
  li t0, 0xffffffff
  li t1, 0x00000000
  li t2, 0xffffffff
  bpick t3, t1, t0, t1
  bne t3, t0, fail

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

