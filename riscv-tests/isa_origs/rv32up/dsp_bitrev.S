# See LICENSE for license details.

#*****************************************************************************
# dsp_bitrev.S
#-----------------------------------------------------------------------------
#
# Test DSP bit reverse operation.
#

#define BITREVI_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  bitrevi t2, t0, imm  ;                    \
  bne t2, t1, fail     ;                    

#define BITREV_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  bitrev t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2 
#ifdef N600_CFG_HAS_DSP

#########################################################################
# bitrevi
#########################################################################
  BITREVI_OP(2,  0x12345678, 31, 0x1e6a2c48>>0)
  BITREVI_OP(3,  0x12345678, 30, 0x1e6a2c48>>1)
  BITREVI_OP(4,  0x12345678, 29, 0x1e6a2c48>>2)
  BITREVI_OP(5,  0x12345678, 28, 0x1e6a2c48>>3)
  BITREVI_OP(6,  0x12345678, 27, 0x1e6a2c48>>4)
  BITREVI_OP(7,  0x12345678, 26, 0x1e6a2c48>>5)
  BITREVI_OP(8,  0x12345678, 25, 0x1e6a2c48>>6)
  BITREVI_OP(9,  0x12345678, 24, 0x1e6a2c48>>7)
  BITREVI_OP(10, 0x12345678, 23, 0x1e6a2c48>>8)
  BITREVI_OP(11, 0x12345678, 22, 0x1e6a2c48>>9)
  BITREVI_OP(12, 0x12345678, 21, 0x1e6a2c48>>10)
  BITREVI_OP(13, 0x12345678, 20, 0x1e6a2c48>>11)
  BITREVI_OP(14, 0x12345678, 19, 0x1e6a2c48>>12)
  BITREVI_OP(15, 0x12345678, 18, 0x1e6a2c48>>13)
  BITREVI_OP(16, 0x12345678, 17, 0x1e6a2c48>>14)
  BITREVI_OP(17, 0x12345678, 16, 0x1e6a2c48>>15)
  BITREVI_OP(18, 0x12345678, 15, 0x1e6a2c48>>16)
  BITREVI_OP(19, 0x12345678, 14, 0x1e6a2c48>>17)
  BITREVI_OP(20, 0x12345678, 13, 0x1e6a2c48>>18)
  BITREVI_OP(21, 0x12345678, 12, 0x1e6a2c48>>19)
  BITREVI_OP(22, 0x12345678, 11, 0x1e6a2c48>>20)
  BITREVI_OP(23, 0x12345678, 10, 0x1e6a2c48>>21)
  BITREVI_OP(24, 0x12345678,  9, 0x1e6a2c48>>22)
  BITREVI_OP(25, 0x12345678,  8, 0x1e6a2c48>>23)
  BITREVI_OP(26, 0x12345678,  7, 0x1e6a2c48>>24)
  BITREVI_OP(27, 0x12345678,  6, 0x1e6a2c48>>25)
  BITREVI_OP(28, 0x12345678,  5, 0x1e6a2c48>>26)
  BITREVI_OP(29, 0x12345678,  4, 0x1e6a2c48>>27)
  BITREVI_OP(30, 0x12345678,  3, 0x1e6a2c48>>28)
  BITREVI_OP(31, 0x12345678,  2, 0x1e6a2c48>>29)
  BITREVI_OP(32, 0x12345678,  1, 0x1e6a2c48>>30)
  BITREVI_OP(33, 0x00000001,  0, 0x000000001)

#########################################################################
# bitrev
#########################################################################
  BITREV_OP(2,  0x12345678, 31, 0x1e6a2c48>>0)
  BITREV_OP(3,  0x12345678, 30, 0x1e6a2c48>>1)
  BITREV_OP(4,  0x12345678, 29, 0x1e6a2c48>>2)
  BITREV_OP(5,  0x12345678, 28, 0x1e6a2c48>>3)
  BITREV_OP(6,  0x12345678, 27, 0x1e6a2c48>>4)
  BITREV_OP(7,  0x12345678, 26, 0x1e6a2c48>>5)
  BITREV_OP(8,  0x12345678, 25, 0x1e6a2c48>>6)
  BITREV_OP(9,  0x12345678, 24, 0x1e6a2c48>>7)
  BITREV_OP(10, 0x12345678, 23, 0x1e6a2c48>>8)
  BITREV_OP(11, 0x12345678, 22, 0x1e6a2c48>>9)
  BITREV_OP(12, 0x12345678, 21, 0x1e6a2c48>>10)
  BITREV_OP(13, 0x12345678, 20, 0x1e6a2c48>>11)
  BITREV_OP(14, 0x12345678, 19, 0x1e6a2c48>>12)
  BITREV_OP(15, 0x12345678, 18, 0x1e6a2c48>>13)
  BITREV_OP(16, 0x12345678, 17, 0x1e6a2c48>>14)
  BITREV_OP(17, 0x12345678, 16, 0x1e6a2c48>>15)
  BITREV_OP(18, 0x12345678, 15, 0x1e6a2c48>>16)
  BITREV_OP(19, 0x12345678, 14, 0x1e6a2c48>>17)
  BITREV_OP(20, 0x12345678, 13, 0x1e6a2c48>>18)
  BITREV_OP(21, 0x12345678, 12, 0x1e6a2c48>>19)
  BITREV_OP(22, 0x12345678, 11, 0x1e6a2c48>>20)
  BITREV_OP(23, 0x12345678, 10, 0x1e6a2c48>>21)
  BITREV_OP(24, 0x12345678,  9, 0x1e6a2c48>>22)
  BITREV_OP(25, 0x12345678,  8, 0x1e6a2c48>>23)
  BITREV_OP(26, 0x12345678,  7, 0x1e6a2c48>>24)
  BITREV_OP(27, 0x12345678,  6, 0x1e6a2c48>>25)
  BITREV_OP(28, 0x12345678,  5, 0x1e6a2c48>>26)
  BITREV_OP(29, 0x12345678,  4, 0x1e6a2c48>>27)
  BITREV_OP(30, 0x12345678,  3, 0x1e6a2c48>>28)
  BITREV_OP(31, 0x12345678,  2, 0x1e6a2c48>>29)
  BITREV_OP(32, 0x12345678,  1, 0x1e6a2c48>>30)
  BITREV_OP(33, 0x00000001,  0, 0x000000001)

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

