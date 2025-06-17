# See LICENSE for license details.

#*****************************************************************************
# dsp_shift16.S
#-----------------------------------------------------------------------------
#
# Test DSP shift16 operation.
#

#define SRA16_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sra16 t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define SRA16U_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sra16.u t2, t0, t1   ;                    \
  bne t3, t2, fail     ;                    

#define SRAI16_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srai16 t2, t0, imm   ;                    \
  bne t2, t1, fail     ;                    

#define SRAI16U_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srai16.u t2, t0, imm ;                    \
  bne t2, t1, fail     ;                    

#define SRL16_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  srl16 t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define SRL16U_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  srl16.u t2, t0, t1   ;                    \
  bne t3, t2, fail     ;                    

#define SRLI16_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srli16 t2, t0, imm   ;                    \
  bne t2, t1, fail     ;                    

#define SRLI16U_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srli16.u t2, t0, imm ;                    \
  bne t2, t1, fail     ;                    

#define SLL16_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sll16 t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define SLLI16_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  slli16 t2, t0, imm   ;                    \
  bne t2, t1, fail     ;                    

#define KSLL16_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  ksll16 t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#define KSLLI16_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  kslli16 t2, t0, imm  ;                    \
  bne t2, t1, fail     ;                    

#define KSLRA16_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslra16 t2, t0, t1   ;                    \
  bne t3, t2, fail     ;                    

#define KSLRA16U_OP(testnum, in, imm, exp)  \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslra16.u t2, t0, t1 ;                    \
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
# sra16
#########################################################################
  SRA16_OP(2,  0x1234abcd,  0, 0x1234abcd)
  SRA16_OP(2,  0x1234abcd,  1, 0x091ad5e6)
  SRA16_OP(2,  0x1234abcd,  2, 0x048deaf3)
  SRA16_OP(2,  0x1234abcd,  3, 0x0246f579)
  SRA16_OP(2,  0x1234abcd,  4, 0x0123fabc)
  SRA16_OP(2,  0x1234abcd,  5, 0x0091fd5e)
  SRA16_OP(2,  0x1234abcd,  6, 0x0048feaf)
  SRA16_OP(2,  0x1234abcd,  7, 0x0024ff57)
  SRA16_OP(2,  0x1234abcd,  8, 0x0012ffab)
  SRA16_OP(2,  0x1234abcd,  9, 0x0009ffd5)
  SRA16_OP(2,  0x1234abcd, 10, 0x0004ffea)
  SRA16_OP(2,  0x1234abcd, 11, 0x0002fff5)
  SRA16_OP(2,  0x1234abcd, 12, 0x0001fffa)
  SRA16_OP(2,  0x1234abcd, 13, 0x0000fffd)
  SRA16_OP(2,  0x1234abcd, 14, 0x0000fffe)
  SRA16_OP(2,  0x1234abcd, 15, 0x0000ffff)

#########################################################################
# srai16
#########################################################################
  SRAI16_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRAI16_OP(2, 0x1234abcd,  1, 0x091ad5e6)
  SRAI16_OP(2, 0x1234abcd,  2, 0x048deaf3)
  SRAI16_OP(2, 0x1234abcd,  3, 0x0246f579)
  SRAI16_OP(2, 0x1234abcd,  4, 0x0123fabc)
  SRAI16_OP(2, 0x1234abcd,  5, 0x0091fd5e)
  SRAI16_OP(2, 0x1234abcd,  6, 0x0048feaf)
  SRAI16_OP(2, 0x1234abcd,  7, 0x0024ff57)
  SRAI16_OP(2, 0x1234abcd,  8, 0x0012ffab)
  SRAI16_OP(2, 0x1234abcd,  9, 0x0009ffd5)
  SRAI16_OP(2, 0x1234abcd, 10, 0x0004ffea)
  SRAI16_OP(2, 0x1234abcd, 11, 0x0002fff5)
  SRAI16_OP(2, 0x1234abcd, 12, 0x0001fffa)
  SRAI16_OP(2, 0x1234abcd, 13, 0x0000fffd)
  SRAI16_OP(2, 0x1234abcd, 14, 0x0000fffe)
  SRAI16_OP(2, 0x1234abcd, 15, 0x0000ffff)

#########################################################################
# sra16u
#########################################################################
  SRA16U_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRA16U_OP(2, 0x1234abcd,  1, 0x091ad5e7)
  SRA16U_OP(2, 0x1234abcd,  2, 0x048deaf3)
  SRA16U_OP(2, 0x1234abcd,  3, 0x0247f57a)
  SRA16U_OP(2, 0x1234abcd,  4, 0x0123fabd)
  SRA16U_OP(2, 0x1234abcd,  5, 0x0092fd5e)
  SRA16U_OP(2, 0x1234abcd,  6, 0x0049feaf)
  SRA16U_OP(2, 0x1234abcd,  7, 0x0024ff58)
  SRA16U_OP(2, 0x1234abcd,  8, 0x0012ffac)
  SRA16U_OP(2, 0x1234abcd,  9, 0x0009ffd6)
  SRA16U_OP(2, 0x1234abcd, 10, 0x0005ffeb)
  SRA16U_OP(2, 0x1234abcd, 11, 0x0002fff5)
  SRA16U_OP(2, 0x1234abcd, 12, 0x0001fffb)
  SRA16U_OP(2, 0x1234abcd, 13, 0x0001fffd)
  SRA16U_OP(2, 0x1234abcd, 14, 0x0000ffff)
  SRA16U_OP(2, 0x1234abcd, 15, 0x0000ffff)

#########################################################################
# srai16u
#########################################################################
  SRAI16U_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRAI16U_OP(2, 0x1234abcd,  1, 0x091ad5e7)
  SRAI16U_OP(2, 0x1234abcd,  2, 0x048deaf3)
  SRAI16U_OP(2, 0x1234abcd,  3, 0x0247f57a)
  SRAI16U_OP(2, 0x1234abcd,  4, 0x0123fabd)
  SRAI16U_OP(2, 0x1234abcd,  5, 0x0092fd5e)
  SRAI16U_OP(2, 0x1234abcd,  6, 0x0049feaf)
  SRAI16U_OP(2, 0x1234abcd,  7, 0x0024ff58)
  SRAI16U_OP(2, 0x1234abcd,  8, 0x0012ffac)
  SRAI16U_OP(2, 0x1234abcd,  9, 0x0009ffd6)
  SRAI16U_OP(2, 0x1234abcd, 10, 0x0005ffeb)
  SRAI16U_OP(2, 0x1234abcd, 11, 0x0002fff5)
  SRAI16U_OP(2, 0x1234abcd, 12, 0x0001fffb)
  SRAI16U_OP(2, 0x1234abcd, 13, 0x0001fffd)
  SRAI16U_OP(2, 0x1234abcd, 14, 0x0000ffff)
  SRAI16U_OP(2, 0x1234abcd, 15, 0x0000ffff)

#########################################################################
# srl16
#########################################################################
  SRL16_OP(2,  0x1234abcd,  0, 0x1234abcd)
  SRL16_OP(2,  0x1234abcd,  1, 0x091a55e6)
  SRL16_OP(2,  0x1234abcd,  2, 0x048d2af3)
  SRL16_OP(2,  0x1234abcd,  3, 0x02461579)
  SRL16_OP(2,  0x1234abcd,  4, 0x01230abc)
  SRL16_OP(2,  0x1234abcd,  5, 0x0091055e)
  SRL16_OP(2,  0x1234abcd,  6, 0x004802af)
  SRL16_OP(2,  0x1234abcd,  7, 0x00240157)
  SRL16_OP(2,  0x1234abcd,  8, 0x001200ab)
  SRL16_OP(2,  0x1234abcd,  9, 0x00090055)
  SRL16_OP(2,  0x1234abcd, 10, 0x0004002a)
  SRL16_OP(2,  0x1234abcd, 11, 0x00020015)
  SRL16_OP(2,  0x1234abcd, 12, 0x0001000a)
  SRL16_OP(2,  0x1234abcd, 13, 0x00000005)
  SRL16_OP(2,  0x1234abcd, 14, 0x00000002)
  SRL16_OP(2,  0x1234abcd, 15, 0x00000001)

#########################################################################
# srli16
#########################################################################
  SRLI16_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRLI16_OP(2, 0x1234abcd,  1, 0x091a55e6)
  SRLI16_OP(2, 0x1234abcd,  2, 0x048d2af3)
  SRLI16_OP(2, 0x1234abcd,  3, 0x02461579)
  SRLI16_OP(2, 0x1234abcd,  4, 0x01230abc)
  SRLI16_OP(2, 0x1234abcd,  5, 0x0091055e)
  SRLI16_OP(2, 0x1234abcd,  6, 0x004802af)
  SRLI16_OP(2, 0x1234abcd,  7, 0x00240157)
  SRLI16_OP(2, 0x1234abcd,  8, 0x001200ab)
  SRLI16_OP(2, 0x1234abcd,  9, 0x00090055)
  SRLI16_OP(2, 0x1234abcd, 10, 0x0004002a)
  SRLI16_OP(2, 0x1234abcd, 11, 0x00020015)
  SRLI16_OP(2, 0x1234abcd, 12, 0x0001000a)
  SRLI16_OP(2, 0x1234abcd, 13, 0x00000005)
  SRLI16_OP(2, 0x1234abcd, 14, 0x00000002)
  SRLI16_OP(2, 0x1234abcd, 15, 0x00000001)

#########################################################################
# srl16u
#########################################################################
  SRL16U_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRL16U_OP(2, 0x1234abcd,  1, 0x091a55e7)
  SRL16U_OP(2, 0x1234abcd,  2, 0x048d2af3)
  SRL16U_OP(2, 0x1234abcd,  3, 0x0247157a)
  SRL16U_OP(2, 0x1234abcd,  4, 0x01230abd)
  SRL16U_OP(2, 0x1234abcd,  5, 0x0092055e)
  SRL16U_OP(2, 0x1234abcd,  6, 0x004902af)
  SRL16U_OP(2, 0x1234abcd,  7, 0x00240158)
  SRL16U_OP(2, 0x1234abcd,  8, 0x001200ac)
  SRL16U_OP(2, 0x1234abcd,  9, 0x00090056)
  SRL16U_OP(2, 0x1234abcd, 10, 0x0005002b)
  SRL16U_OP(2, 0x1234abcd, 11, 0x00020015)
  SRL16U_OP(2, 0x1234abcd, 12, 0x0001000b)
  SRL16U_OP(2, 0x1234abcd, 13, 0x00010005)
  SRL16U_OP(2, 0x1234abcd, 14, 0x00000003)
  SRL16U_OP(2, 0x1234abcd, 15, 0x00000001)

#########################################################################
# srli16u
#########################################################################
  SRLI16U_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SRLI16U_OP(2, 0x1234abcd,  1, 0x091a55e7)
  SRLI16U_OP(2, 0x1234abcd,  2, 0x048d2af3)
  SRLI16U_OP(2, 0x1234abcd,  3, 0x0247157a)
  SRLI16U_OP(2, 0x1234abcd,  4, 0x01230abd)
  SRLI16U_OP(2, 0x1234abcd,  5, 0x0092055e)
  SRLI16U_OP(2, 0x1234abcd,  6, 0x004902af)
  SRLI16U_OP(2, 0x1234abcd,  7, 0x00240158)
  SRLI16U_OP(2, 0x1234abcd,  8, 0x001200ac)
  SRLI16U_OP(2, 0x1234abcd,  9, 0x00090056)
  SRLI16U_OP(2, 0x1234abcd, 10, 0x0005002b)
  SRLI16U_OP(2, 0x1234abcd, 11, 0x00020015)
  SRLI16U_OP(2, 0x1234abcd, 12, 0x0001000b)
  SRLI16U_OP(2, 0x1234abcd, 13, 0x00010005)
  SRLI16U_OP(2, 0x1234abcd, 14, 0x00000003)
  SRLI16U_OP(2, 0x1234abcd, 15, 0x00000001)

#########################################################################
# sll16
#########################################################################
  SLL16_OP(2, 0x1234abcd,  0, 0x1234abcd)
  SLL16_OP(2, 0x1234abcd,  1, 0x2468579a)
  SLL16_OP(2, 0x1234abcd,  2, 0x48d0af34)
  SLL16_OP(2, 0x1234abcd,  3, 0x91a05e68)
  SLL16_OP(2, 0x1234abcd,  4, 0x2340bcd0)
  SLL16_OP(2, 0x1234abcd,  5, 0x468079a0)
  SLL16_OP(2, 0x1234abcd,  6, 0x8d00f340)
  SLL16_OP(2, 0x1234abcd,  7, 0x1a00e680)
  SLL16_OP(2, 0x1234abcd,  8, 0x3400cd00)
  SLL16_OP(2, 0x1234abcd,  9, 0x68009a00)
  SLL16_OP(2, 0x1234abcd, 10, 0xd0003400)
  SLL16_OP(2, 0x1234abcd, 11, 0xa0006800)
  SLL16_OP(2, 0x1234abcd, 12, 0x4000d000)
  SLL16_OP(2, 0x1234abcd, 13, 0x8000a000)
  SLL16_OP(2, 0x1234abcd, 14, 0x00004000)
  SLL16_OP(2, 0x1234abcd, 15, 0x00008000)

#########################################################################
# slli16
#########################################################################
  SLLI16_OP(3, 0x1234abcd,  0, 0x1234abcd)
  SLLI16_OP(4, 0x1234abcd,  1, 0x2468579a)
  SLLI16_OP(5, 0x1234abcd,  2, 0x48d0af34)
  SLLI16_OP(6, 0x1234abcd,  3, 0x91a05e68)
  SLLI16_OP(7, 0x1234abcd,  4, 0x2340bcd0)
  SLLI16_OP(8, 0x1234abcd,  5, 0x468079a0)
  SLLI16_OP(9, 0x1234abcd,  6, 0x8d00f340)
  SLLI16_OP(9, 0x1234abcd,  7, 0x1a00e680)
  SLLI16_OP(9, 0x1234abcd,  8, 0x3400cd00)
  SLLI16_OP(9, 0x1234abcd,  9, 0x68009a00)
  SLLI16_OP(9, 0x1234abcd, 10, 0xd0003400)
  SLLI16_OP(9, 0x1234abcd, 11, 0xa0006800)
  SLLI16_OP(9, 0x1234abcd, 12, 0x4000d000)
  SLLI16_OP(9, 0x1234abcd, 13, 0x8000a000)
  SLLI16_OP(9, 0x1234abcd, 14, 0x00004000)
  SLLI16_OP(9, 0x1234abcd, 15, 0x00008000)

#########################################################################
# ksll16
#########################################################################
  KSLL16_OP(23, 0x1234abcd,  0, 0x1234abcd)
  KSLL16_OP(24, 0x1234abcd,  1, 0x24688000)
  KSLL16_OP(25, 0x1234abcd,  2, 0x48d08000)
  KSLL16_OP(26, 0x1234abcd,  3, 0x7fff8000)
  KSLL16_OP(27, 0x1234abcd,  4, 0x7fff8000)
  KSLL16_OP(28, 0x1234abcd,  5, 0x7fff8000)
  KSLL16_OP(29, 0x1234abcd,  6, 0x7fff8000)
  KSLL16_OP(29, 0x1234abcd,  7, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd,  8, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd,  9, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 10, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 11, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 12, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 13, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 14, 0x7fff8000)
  KSLL16_OP(30, 0x1234abcd, 15, 0x7fff8000)

//#########################################################################
//# kslli16
//#########################################################################
  KSLLI16_OP(3, 0x1234abcd,  0, 0x1234abcd)
  KSLLI16_OP(4, 0x1234abcd,  1, 0x24688000)
  KSLLI16_OP(5, 0x1234abcd,  2, 0x48d08000)
  KSLLI16_OP(6, 0x1234abcd,  3, 0x7fff8000)
  KSLLI16_OP(7, 0x1234abcd,  4, 0x7fff8000)
  KSLLI16_OP(8, 0x1234abcd,  5, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd,  6, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd,  7, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd,  8, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd,  9, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 10, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 11, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 12, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 13, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 14, 0x7fff8000)
  KSLLI16_OP(9, 0x1234abcd, 15, 0x7fff8000)

#########################################################################
# kslra16
#########################################################################
  KSLRA16_OP(2, 0x1234abcd,  0, 0x1234abcd)
  KSLRA16_OP(2, 0x1234abcd,  1, 0x24688000)
  KSLRA16_OP(2, 0x1234abcd,  2, 0x48d08000)
  KSLRA16_OP(2, 0x1234abcd,  3, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  4, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  5, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  6, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  7, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  8, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd,  9, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 10, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 11, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 12, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 13, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 14, 0x7fff8000)
  KSLRA16_OP(2, 0x1234abcd, 15, 0x7fff8000)

  KSLRA16_OP(2, 0x1234abcd, 31, 0x091ad5e6)
  KSLRA16_OP(2, 0x1234abcd, 30, 0x048deaf3)
  KSLRA16_OP(2, 0x1234abcd, 29, 0x0246f579)
  KSLRA16_OP(2, 0x1234abcd, 28, 0x0123fabc)
  KSLRA16_OP(2, 0x1234abcd, 27, 0x0091fd5e)
  KSLRA16_OP(2, 0x1234abcd, 26, 0x0048feaf)
  KSLRA16_OP(2, 0x1234abcd, 25, 0x0024ff57)
  KSLRA16_OP(2, 0x1234abcd, 24, 0x0012ffab)
  KSLRA16_OP(2, 0x1234abcd, 23, 0x0009ffd5)
  KSLRA16_OP(2, 0x1234abcd, 22, 0x0004ffea)
  KSLRA16_OP(2, 0x1234abcd, 21, 0x0002fff5)
  KSLRA16_OP(2, 0x1234abcd, 20, 0x0001fffa)
  KSLRA16_OP(2, 0x1234abcd, 19, 0x0000fffd)
  KSLRA16_OP(2, 0x1234abcd, 18, 0x0000fffe)
  KSLRA16_OP(2, 0x1234abcd, 17, 0x0000ffff)
  KSLRA16_OP(2, 0x1234abcd, 16, 0x0000ffff)

#########################################################################
# kslra16u
#########################################################################
  KSLRA16U_OP(2, 0x1234abcd,  0, 0x1234abcd)
  KSLRA16U_OP(2, 0x1234abcd,  1, 0x24688000)
  KSLRA16U_OP(2, 0x1234abcd,  2, 0x48d08000)
  KSLRA16U_OP(2, 0x1234abcd,  3, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  4, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  5, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  6, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  7, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  8, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd,  9, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 10, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 11, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 12, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 13, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 14, 0x7fff8000)
  KSLRA16U_OP(2, 0x1234abcd, 15, 0x7fff8000)

  KSLRA16U_OP(2, 0x1234abcd, 31, 0x091ad5e7)
  KSLRA16U_OP(2, 0x1234abcd, 30, 0x048deaf3)
  KSLRA16U_OP(2, 0x1234abcd, 29, 0x0247f57a)
  KSLRA16U_OP(2, 0x1234abcd, 28, 0x0123fabd)
  KSLRA16U_OP(2, 0x1234abcd, 27, 0x0092fd5e)
  KSLRA16U_OP(2, 0x1234abcd, 26, 0x0049feaf)
  KSLRA16U_OP(2, 0x1234abcd, 25, 0x0024ff58)
  KSLRA16U_OP(2, 0x1234abcd, 24, 0x0012ffac)
  KSLRA16U_OP(2, 0x1234abcd, 23, 0x0009ffd6)
  KSLRA16U_OP(2, 0x1234abcd, 22, 0x0005ffeb)
  KSLRA16U_OP(2, 0x1234abcd, 21, 0x0002fff5)
  KSLRA16U_OP(2, 0x1234abcd, 20, 0x0001fffb)
  KSLRA16U_OP(2, 0x1234abcd, 19, 0x0001fffd)
  KSLRA16U_OP(2, 0x1234abcd, 18, 0x0000ffff)
  KSLRA16U_OP(2, 0x1234abcd, 17, 0x0000ffff)
  KSLRA16U_OP(2, 0x1234abcd, 16, 0x0000ffff)

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

