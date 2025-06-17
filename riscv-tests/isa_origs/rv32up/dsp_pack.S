# See LICENSE for license details.

#*****************************************************************************
# dsp_pack.S
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
# pkbb16
#########################################################################
  li TESTNUM, 2
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0xcdef4567
  pkbb16 t3, t1, t0
  bne t3, t2, fail

#########################################################################
# pkbt16
#########################################################################
  li TESTNUM, 3
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0xcdef0123
  pkbt16 t3, t1, t0
  bne t3, t2, fail

#########################################################################
# pktb16
#########################################################################
  li TESTNUM, 4
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0x89ab4567
  pktb16 t3, t1, t0
  bne t3, t2, fail

#########################################################################
# pktt16
#########################################################################
  li TESTNUM, 5
  li t0, 0x01234567
  li t1, 0x89abcdef
  li t2, 0x89ab0123
  pktt16 t3, t1, t0
  bne t3, t2, fail

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

