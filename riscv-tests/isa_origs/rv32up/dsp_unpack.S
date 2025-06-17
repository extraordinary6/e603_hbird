# See LICENSE for license details.

#*****************************************************************************
# dsp_unpack.S
#-----------------------------------------------------------------------------
#
# Test DSP unpacking operation.
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
# sunpkd810
#########################################################################
  li TESTNUM, 2
  li t0, 0x0000817f
  li t1, 0xff81007f
  sunpkd810 t2, t0
  bne t1, t2, fail

  li TESTNUM, 3
  li t0, 0xffff7f81
  li t1, 0x007fff81
  sunpkd810 t2, t0
  bne t1, t2, fail

#########################################################################
# sunpkd820
#########################################################################
  li TESTNUM, 4
  li t0, 0x0081007f
  li t1, 0xff81007f
  sunpkd820 t2, t0
  bne t1, t2, fail

  li TESTNUM, 5
  li t0, 0xff7f0081
  li t1, 0x007fff81
  sunpkd820 t2, t0
  bne t1, t2, fail

#########################################################################
# sunpkd830
#########################################################################
  li TESTNUM, 6
  li t0, 0x8100ff7f
  li t1, 0xff81007f
  sunpkd830 t2, t0
  bne t1, t2, fail

  li TESTNUM, 7
  li t0, 0x7fff0081
  li t1, 0x007fff81
  sunpkd830 t2, t0
  bne t1, t2, fail

#########################################################################
# sunpkd831
#########################################################################
  li TESTNUM, 8
  li t0, 0x81007fff
  li t1, 0xff81007f
  sunpkd831 t2, t0
  bne t1, t2, fail

  li TESTNUM, 9
  li t0, 0x7fff8100
  li t1, 0x007fff81
  sunpkd831 t2, t0
  bne t1, t2, fail

#########################################################################
# sunpkd832
#########################################################################
  li TESTNUM, 10
  li t0, 0x817fffff
  li t1, 0xff81007f
  sunpkd832 t2, t0
  bne t1, t2, fail

  li TESTNUM, 11
  li t0, 0x7f810000
  li t1, 0x007fff81
  sunpkd832 t2, t0
  bne t1, t2, fail

#########################################################################
# zunpkd810
#########################################################################
  li TESTNUM, 12
  li t0, 0xffff817f
  li t1, 0x0081007f
  zunpkd810 t2, t0
  bne t1, t2, fail

  li TESTNUM, 12
  li t0, 0xffff7f81
  li t1, 0x007f0081
  zunpkd810 t2, t0
  bne t1, t2, fail

#########################################################################
# zunpkd820
#########################################################################
  li TESTNUM, 14
  li t0, 0xff81ff7f
  li t1, 0x0081007f
  zunpkd820 t2, t0
  bne t1, t2, fail

  li TESTNUM, 15
  li t0, 0xff7fff81
  li t1, 0x007f0081
  zunpkd820 t2, t0
  bne t1, t2, fail

#########################################################################
# zunpkd830
#########################################################################
  li TESTNUM, 16
  li t0, 0x81ffff7f
  li t1, 0x0081007f
  zunpkd830 t2, t0
  bne t1, t2, fail

  li TESTNUM, 17
  li t0, 0x7fffff81
  li t1, 0x007f0081
  zunpkd830 t2, t0
  bne t1, t2, fail

#########################################################################
# zunpkd831
#########################################################################
  li TESTNUM, 18
  li t0, 0x81ff7fff
  li t1, 0x0081007f
  zunpkd831 t2, t0
  bne t1, t2, fail

  li TESTNUM, 19
  li t0, 0x7fff81ff
  li t1, 0x007f0081
  zunpkd831 t2, t0
  bne t1, t2, fail

#########################################################################
# zunpkd832
#########################################################################
  li TESTNUM, 20
  li t0, 0x817fffff
  li t1, 0x0081007f
  zunpkd832 t2, t0
  bne t1, t2, fail

  li TESTNUM, 21
  li t0, 0x7f81ffff
  li t1, 0x007f0081
  zunpkd832 t2, t0
  bne t1, t2, fail

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

