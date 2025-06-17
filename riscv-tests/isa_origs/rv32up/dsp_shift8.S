# See LICENSE for license details.

#*****************************************************************************
# dsp_shift8.S
#-----------------------------------------------------------------------------
#
# Test DSP shift8 operation.
#

#define SRA8_OP(testnum, in, imm, exp)      \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sra8 t2, t0, t1      ;                    \
  bne t3, t2, fail     ;                    

#define SRA8U_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sra8.u t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#define SRAI8_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srai8 t2, t0, imm    ;                    \
  bne t2, t1, fail     ;                    

#define SRAI8U_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srai8.u t2, t0, imm  ;                    \
  bne t2, t1, fail     ;                    

#define SRL8_OP(testnum, in, imm, exp)      \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  srl8 t2, t0, t1      ;                    \
  bne t3, t2, fail     ;                    

#define SRL8U_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  srl8.u t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#define SRLI8_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srli8 t2, t0, imm    ;                    \
  bne t2, t1, fail     ;                    

#define SRLI8U_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srli8.u t2, t0, imm  ;                    \
  bne t2, t1, fail     ;                    

#define SLL8_OP(testnum, in, imm, exp)      \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sll8 t2, t0, t1      ;                    \
  bne t3, t2, fail     ;                    

#define SLLI8_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  slli8 t2, t0, imm    ;                    \
  bne t2, t1, fail     ;                    

#define KSLL8_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  ksll8 t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define KSLLI8_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  kslli8 t2, t0, imm   ;                    \
/*  .word (0x7c8283ff | (imm << 20)); */    \
  bne t2, t1, fail     ;                    

#define KSLRA8_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslra8 t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#define KSLRA8U_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslra8.u t2, t0, t1  ;                    \
/*  .word 0x6e6283ff     ; */               \
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
# sra8
#########################################################################
  SRA8_OP(2,  0x1234abcd, 0, 0x1234abcd)
  SRA8_OP(2,  0x1234abcd, 1, 0x091ad5e6)
  SRA8_OP(2,  0x1234abcd, 2, 0x040deaf3)
  SRA8_OP(2,  0x1234abcd, 3, 0x0206f5f9)
  SRA8_OP(2,  0x1234abcd, 4, 0x0103fafc)
  SRA8_OP(2,  0x1234abcd, 5, 0x0001fdfe)
  SRA8_OP(2,  0x1234abcd, 6, 0x0000feff)
  SRA8_OP(2,  0x1234abcd, 7, 0x0000ffff)

#########################################################################
# srai8
#########################################################################
  SRAI8_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRAI8_OP(2, 0x1234abcd, 1, 0x091ad5e6)
  SRAI8_OP(2, 0x1234abcd, 2, 0x040deaf3)
  SRAI8_OP(2, 0x1234abcd, 3, 0x0206f5f9)
  SRAI8_OP(2, 0x1234abcd, 4, 0x0103fafc)
  SRAI8_OP(2, 0x1234abcd, 5, 0x0001fdfe)
  SRAI8_OP(2, 0x1234abcd, 6, 0x0000feff)
  SRAI8_OP(2, 0x1234abcd, 7, 0x0000ffff)

#########################################################################
# sra8u
#########################################################################
  SRA8U_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRA8U_OP(2, 0x1234abcd, 1, 0x091ad6e7)
  SRA8U_OP(2, 0x1234abcd, 2, 0x050debf3)
  SRA8U_OP(2, 0x1234abcd, 3, 0x0207f5fa)
  SRA8U_OP(2, 0x1234abcd, 4, 0x0103fbfd)
  SRA8U_OP(2, 0x1234abcd, 5, 0x0102fdfe)
  SRA8U_OP(2, 0x1234abcd, 6, 0x0001ffff)
  SRA8U_OP(2, 0x1234abcd, 7, 0x0000ff00)

#########################################################################
# srai8u
#########################################################################
  SRAI8U_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRAI8U_OP(2, 0x1234abcd, 1, 0x091ad6e7)
  SRAI8U_OP(2, 0x1234abcd, 2, 0x050debf3)
  SRAI8U_OP(2, 0x1234abcd, 3, 0x0207f5fa)
  SRAI8U_OP(2, 0x1234abcd, 4, 0x0103fbfd)
  SRAI8U_OP(2, 0x1234abcd, 5, 0x0102fdfe)
  SRAI8U_OP(2, 0x1234abcd, 6, 0x0001ffff)
  SRAI8U_OP(2, 0x1234abcd, 7, 0x0000ff00)

#########################################################################
# srl8
#########################################################################
  SRL8_OP(2,  0x1234abcd, 0, 0x1234abcd)
  SRL8_OP(2,  0x1234abcd, 1, 0x091a5566)
  SRL8_OP(2,  0x1234abcd, 2, 0x040d2a33)
  SRL8_OP(2,  0x1234abcd, 3, 0x02061519)
  SRL8_OP(2,  0x1234abcd, 4, 0x01030a0c)
  SRL8_OP(2,  0x1234abcd, 5, 0x00010506)
  SRL8_OP(2,  0x1234abcd, 6, 0x00000203)
  SRL8_OP(2,  0x1234abcd, 7, 0x00000101)

#########################################################################
# srli8
#########################################################################
  SRLI8_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRLI8_OP(2, 0x1234abcd, 1, 0x091a5566)
  SRLI8_OP(2, 0x1234abcd, 2, 0x040d2a33)
  SRLI8_OP(2, 0x1234abcd, 3, 0x02061519)
  SRLI8_OP(2, 0x1234abcd, 4, 0x01030a0c)
  SRLI8_OP(2, 0x1234abcd, 5, 0x00010506)
  SRLI8_OP(2, 0x1234abcd, 6, 0x00000203)
  SRLI8_OP(2, 0x1234abcd, 7, 0x00000101)

#########################################################################
# srl8u
#########################################################################
  SRL8U_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRL8U_OP(2, 0x1234abcd, 1, 0x091a5667)
  SRL8U_OP(2, 0x1234abcd, 2, 0x050d2b33)
  SRL8U_OP(2, 0x1234abcd, 3, 0x0207151a)
  SRL8U_OP(2, 0x1234abcd, 4, 0x01030b0d)
  SRL8U_OP(2, 0x1234abcd, 5, 0x01020506)
  SRL8U_OP(2, 0x1234abcd, 6, 0x00010303)
  SRL8U_OP(2, 0x1234abcd, 7, 0x00000102)

#########################################################################
# srli8u
#########################################################################
  SRLI8U_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SRLI8U_OP(2, 0x1234abcd, 1, 0x091a5667)
  SRLI8U_OP(2, 0x1234abcd, 2, 0x050d2b33)
  SRLI8U_OP(2, 0x1234abcd, 3, 0x0207151a)
  SRLI8U_OP(2, 0x1234abcd, 4, 0x01030b0d)
  SRLI8U_OP(2, 0x1234abcd, 5, 0x01020506)
  SRLI8U_OP(2, 0x1234abcd, 6, 0x00010303)
  SRLI8U_OP(2, 0x1234abcd, 7, 0x00000102)

#########################################################################
# sll8
#########################################################################
  SLL8_OP(2, 0x1234abcd, 0, 0x1234abcd)
  SLL8_OP(2, 0x1234abcd, 1, 0x2468569a)
  SLL8_OP(2, 0x1234abcd, 2, 0x48d0ac34)
  SLL8_OP(2, 0x1234abcd, 3, 0x90a05868)
  SLL8_OP(2, 0x1234abcd, 4, 0x2040b0d0)
  SLL8_OP(2, 0x1234abcd, 5, 0x408060a0)
  SLL8_OP(2, 0x1234abcd, 6, 0x8000c040)
  SLL8_OP(2, 0x1234abcd, 7, 0x00008080)

#########################################################################
# slli8
#########################################################################
  SLLI8_OP(3, 0x1234abcd, 0, 0x1234abcd)
  SLLI8_OP(4, 0x1234abcd, 1, 0x2468569a)
  SLLI8_OP(5, 0x1234abcd, 2, 0x48d0ac34)
  SLLI8_OP(6, 0x1234abcd, 3, 0x90a05868)
  SLLI8_OP(7, 0x1234abcd, 4, 0x2040b0d0)
  SLLI8_OP(8, 0x1234abcd, 5, 0x408060a0)
  SLLI8_OP(9, 0x1234abcd, 6, 0x8000c040)
  SLLI8_OP(10, 0x1234abcd, 7, 0x00008080)

#########################################################################
# ksll8
#########################################################################
  KSLL8_OP(23, 0x1234abcd, 0, 0x1234abcd)
  KSLL8_OP(24, 0x1234abcd, 1, 0x2468809a)
  KSLL8_OP(25, 0x1234abcd, 2, 0x487f8080)
  KSLL8_OP(26, 0x1234abcd, 3, 0x7f7f8080)
  KSLL8_OP(27, 0x1234abcd, 4, 0x7f7f8080)
  KSLL8_OP(28, 0x1234abcd, 5, 0x7f7f8080)
  KSLL8_OP(29, 0x1234abcd, 6, 0x7f7f8080)
  KSLL8_OP(30, 0x1234abcd, 7, 0x7f7f8080)

#########################################################################
# kslli8
#########################################################################
  KSLLI8_OP(3, 0x1234abcd, 0, 0x1234abcd)
  KSLLI8_OP(4, 0x1234abcd, 1, 0x2468809a)
  KSLLI8_OP(5, 0x1234abcd, 2, 0x487f8080)
  KSLLI8_OP(6, 0x1234abcd, 3, 0x7f7f8080)
  KSLLI8_OP(7, 0x1234abcd, 4, 0x7f7f8080)
  KSLLI8_OP(8, 0x1234abcd, 5, 0x7f7f8080)
  KSLLI8_OP(9, 0x1234abcd, 6, 0x7f7f8080)
  KSLLI8_OP(10, 0x1234abcd, 7, 0x7f7f8080)

#########################################################################
# kslra8
#########################################################################
  KSLRA8_OP(2, 0x1234abcd, 0, 0x1234abcd)
  KSLRA8_OP(2, 0x1234abcd, 1, 0x2468809a)
  KSLRA8_OP(2, 0x1234abcd, 2, 0x487f8080)
  KSLRA8_OP(2, 0x1234abcd, 3, 0x7f7f8080)
  KSLRA8_OP(2, 0x1234abcd, 4, 0x7f7f8080)
  KSLRA8_OP(2, 0x1234abcd, 5, 0x7f7f8080)
  KSLRA8_OP(2, 0x1234abcd, 6, 0x7f7f8080)
  KSLRA8_OP(2, 0x1234abcd, 7, 0x7f7f8080)

  KSLRA8_OP(2, 0x1234abcd, 15, 0x091ad5e6)
  KSLRA8_OP(2, 0x1234abcd, 14, 0x040deaf3)
  KSLRA8_OP(2, 0x1234abcd, 13, 0x0206f5f9)
  KSLRA8_OP(2, 0x1234abcd, 12, 0x0103fafc)
  KSLRA8_OP(2, 0x1234abcd, 11, 0x0001fdfe)
  KSLRA8_OP(2, 0x1234abcd, 10, 0x0000feff)
  KSLRA8_OP(2, 0x1234abcd,  9, 0x0000ffff)
  KSLRA8_OP(2, 0x1234abcd,  8, 0x0000ffff)

#########################################################################
# kslra8u
#########################################################################
  KSLRA8U_OP(2, 0x1234abcd, 0, 0x1234abcd)
  KSLRA8U_OP(2, 0x1234abcd, 1, 0x2468809a)
  KSLRA8U_OP(2, 0x1234abcd, 2, 0x487f8080)
  KSLRA8U_OP(2, 0x1234abcd, 3, 0x7f7f8080)
  KSLRA8U_OP(2, 0x1234abcd, 4, 0x7f7f8080)
  KSLRA8U_OP(2, 0x1234abcd, 5, 0x7f7f8080)
  KSLRA8U_OP(2, 0x1234abcd, 6, 0x7f7f8080)
  KSLRA8U_OP(2, 0x1234abcd, 7, 0x7f7f8080)

  KSLRA8U_OP(2, 0x1234abcd, 15, 0x091ad6e7)
  KSLRA8U_OP(2, 0x1234abcd, 14, 0x050debf3)
  KSLRA8U_OP(2, 0x1234abcd, 13, 0x0207f5fa)
  KSLRA8U_OP(2, 0x1234abcd, 12, 0x0103fbfd)
  KSLRA8U_OP(2, 0x1234abcd, 11, 0x0102fdfe)
  KSLRA8U_OP(2, 0x1234abcd, 10, 0x0001ffff)
  KSLRA8U_OP(2, 0x1234abcd,  9, 0x0000ff00)
  KSLRA8U_OP(2, 0x1234abcd,  8, 0x0000ff00)


#endif




  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

