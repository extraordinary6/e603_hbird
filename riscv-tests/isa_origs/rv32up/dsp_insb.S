# See LICENSE for license details.

#*****************************************************************************
# dsp_insb.S
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
# insb
#########################################################################
  li TESTNUM, 2
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0x012345ef
  insb t0, t1, 0
  bne t0, t2, fail

  li TESTNUM, 3
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0x0123ef67
  insb t0, t1, 1
  bne t0, t2, fail

  li TESTNUM, 4
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0x01ef4567
  insb t0, t1, 2
  bne t0, t2, fail

  li TESTNUM, 5
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0xef234567
  insb t0, t1, 3
  bne t0, t2, fail

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

