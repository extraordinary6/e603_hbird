# See LICENSE for license details.

#*****************************************************************************
# dsp_cl.S
#-----------------------------------------------------------------------------
#
# Test DSP count leading operation.
#

#include "riscv_test.h"
#include "test_macros.h"

#define CLZ32_OP(testnum, in, exp, instr)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  .word instr          ;                    \
  bne t2, t1, fail     ;                    

#define CLO32_OP(testnum, in, exp, instr)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  .word instr          ;                    \
  bne t2, t1, fail     ;                    

#define CLRS32_OP(testnum, in, exp, instr)  \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  .word instr          ;                    \
  bne t2, t1, fail     ;                    

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2

#ifdef N600_CFG_HAS_DSP

#########################################################################
# count leading zero 8
#########################################################################
  li TESTNUM, 2
  li t0, 0x80402010
  li t1, 0x00010203
  clz8 t2, t0
//  .word 0x1010111, 00001, 00101, 000, 00111, 1111111
//  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 3
  li t0, 0x81412111
  li t1, 0x00010203
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 4
  li t0, 0x40201008
  li t1, 0x01020304
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 5
  li t0, 0x20100804
  li t1, 0x02030405
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 6
  li t0, 0x10080402
  li t1, 0x03040506
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 7
  li t0, 0x08040201
  li t1, 0x04050607
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 8
  li t0, 0x04020100
  li t1, 0x05060708
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 9
  li t0, 0x02010080
  li t1, 0x06070800
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 10
  li t0, 0x01008040
  li t1, 0x07080001
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 11
  li t0, 0x00804020
  li t1, 0x08000102
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

  li TESTNUM, 12
  li t0, 0x80402010
  li t1, 0x00010203
//  clz8 t2, t0
  .word 0xae1283ff
  bne t2, t1, fail

#########################################################################
# count leading one 8
#########################################################################
  li TESTNUM, 13
  li t0, 0x0080c0e0
  li t1, 0x00010203
  clo8 t2, t0
//  .word 0x1010111, 00011, 00101, 000, 00111, 1111111
//  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 14
  li t0, 0x0081c1e1
  li t1, 0x00010203
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 15
  li t0, 0x80c0e0f0
  li t1, 0x01020304
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 16
  li t0, 0xc0e0f0f8
  li t1, 0x02030405
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 17
  li t0, 0xe0f0f8fc
  li t1, 0x03040506
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 18
  li t0, 0xf0f8fcfe
  li t1, 0x04050607
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 19
  li t0, 0xf8fcfeff
  li t1, 0x05060708
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 20
  li t0, 0xfcfeff00
  li t1, 0x06070800
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 21
  li t0, 0xfeff0080
  li t1, 0x07080001
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 22
  li t0, 0xff0080c0
  li t1, 0x08000102
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

  li TESTNUM, 23
  li t0, 0x0080c0e0
  li t1, 0x00010203
//  clo8 t2, t0
  .word 0xae3283ff
  bne t2, t1, fail

#########################################################################
# count leading redundant sign 8
#########################################################################
//////// sign bit is 0 ////////
  li TESTNUM, 24
  li t0, 0x80402010
  li t1, 0x00000102
  clrs8 t2, t0
//  .word 0x1010111, 00000, 00101, 000, 00111, 1111111
//  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 25
  li t0, 0x81412111
  li t1, 0x00000102
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 26
  li t0, 0x40201008
  li t1, 0x00010203
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 27
  li t0, 0x20100804
  li t1, 0x01020304
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 28
  li t0, 0x10080402
  li t1, 0x02030405
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 29
  li t0, 0x08040201
  li t1, 0x03040506
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 30
  li t0, 0x04020100
  li t1, 0x04050607
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 31
  li t0, 0x02010080
  li t1, 0x05060700
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 32
  li t0, 0x01008040
  li t1, 0x06070000
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 33
  li t0, 0x00804020
  li t1, 0x07000001
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 34
  li t0, 0x80402010
  li t1, 0x00000102
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

//////// sign bit is 1 ////////
  li TESTNUM, 35
  li t0, 0x0080c0e0
  li t1, 0x07000102
//  clrs8 t2, t0
//  .word 0x1010111, 00000, 00101, 000, 00111, 1111111
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 36
  li t0, 0x0081c1e1
  li t1, 0x07000102
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 37
  li t0, 0x80c0e0f0
  li t1, 0x00010203
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 38
  li t0, 0xc0e0f0f8
  li t1, 0x01020304
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 39
  li t0, 0xe0f0f8fc
  li t1, 0x02030405
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 40
  li t0, 0xf0f8fcfe
  li t1, 0x03040506
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 41
  li t0, 0xf8fcfeff
  li t1, 0x04050607
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 42
  li t0, 0xfcfeff00
  li t1, 0x05060707
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 43
  li t0, 0xfeff0080
  li t1, 0x06070700
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 44
  li t0, 0xff0080c0
  li t1, 0x07070001
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

  li TESTNUM, 45
  li t0, 0x0080c0e0
  li t1, 0x07000102
//  clrs8 t2, t0
  .word 0xae0283ff
  bne t2, t1, fail

#########################################################################
# count leading zero 16
#########################################################################
  li TESTNUM, 46
  li t0, 0x80004000
  li t1, 0x00000001
  clz16 t2, t0
//  .word 0x1010111, 01001, 00101, 000, 00111, 1111111
//  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 47
  li t0, 0x81414111
  li t1, 0x00000001
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 48
  li t0, 0x40002000
  li t1, 0x00010002
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 49
  li t0, 0x20001000
  li t1, 0x00020003
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 50
  li t0, 0x10000800
  li t1, 0x00030004
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 51
  li t0, 0x08000400
  li t1, 0x00040005
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 52
  li t0, 0x04000200
  li t1, 0x00050006
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 53
  li t0, 0x02000100
  li t1, 0x00060007
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 54
  li t0, 0x01000080
  li t1, 0x00070008
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 55
  li t0, 0x00800040
  li t1, 0x00080009
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 56
  li t0, 0x00400020
  li t1, 0x0009000a
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 57
  li t0, 0x00200010
  li t1, 0x000a000b
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 58
  li t0, 0x00100008
  li t1, 0x000b000c
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 59
  li t0, 0x00080004
  li t1, 0x000c000d
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 60
  li t0, 0x00040002
  li t1, 0x000d000e
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 61
  li t0, 0x00020001
  li t1, 0x000e000f
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 62
  li t0, 0x00010000
  li t1, 0x000f0010
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

  li TESTNUM, 63
  li t0, 0x00008000
  li t1, 0x00100000
//  clz16 t2, t0
  .word 0xae9283ff
  bne t2, t1, fail

#########################################################################
# count leading one 16
#########################################################################
  li TESTNUM, 64
  li t0, 0x00008000
  li t1, 0x00000001
  clo16 t2, t0
//  .word 0x1010111, 01011, 00101, 000, 00111, 1111111
//  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 65
  li t0, 0x8000c000
  li t1, 0x00010002
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 66
  li t0, 0xc000e000
  li t1, 0x00020003
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 67
  li t0, 0xe000f000
  li t1, 0x00030004
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 68
  li t0, 0xf000f800
  li t1, 0x00040005
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 69
  li t0, 0xf800fc00
  li t1, 0x00050006
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 70
  li t0, 0xfc00fe00
  li t1, 0x00060007
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 71
  li t0, 0xfe00ff00
  li t1, 0x00070008
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 72
  li t0, 0xff00ff80
  li t1, 0x00080009
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 73
  li t0, 0xff80ffc0
  li t1, 0x0009000a
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 74
  li t0, 0xffc0ffe0
  li t1, 0x000a000b
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 75
  li t0, 0xffe0fff0
  li t1, 0x000b000c
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 76
  li t0, 0xfff0fff8
  li t1, 0x000c000d
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 77
  li t0, 0xfff8fffc
  li t1, 0x000d000e
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 78
  li t0, 0xfffcfffe
  li t1, 0x000e000f
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 79
  li t0, 0xfffeffff
  li t1, 0x000f0010
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

  li TESTNUM, 80
  li t0, 0xffff0000
  li t1, 0x00100000
//  clo16 t2, t0
  .word 0xaeb283ff
  bne t2, t1, fail

#########################################################################
# count leading redundant sign 16
#########################################################################
//////// sign bit is 0 ////////
  li TESTNUM, 81
  li t0, 0x80004000
  li t1, 0x00000000
  clrs16 t2, t0
//  .word 0x1010111, 01000, 00101, 000, 00111, 1111111
//  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 82
  li t0, 0x81414111
  li t1, 0x00000000
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 83
  li t0, 0x40002000
  li t1, 0x00000001
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 84
  li t0, 0x20001000
  li t1, 0x00010002
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 85
  li t0, 0x10000800
  li t1, 0x00020003
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 86
  li t0, 0x08000400
  li t1, 0x00030004
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 87
  li t0, 0x04000200
  li t1, 0x00040005
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 88
  li t0, 0x02000100
  li t1, 0x00050006
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 89
  li t0, 0x01000080
  li t1, 0x00060007
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 90
  li t0, 0x00800040
  li t1, 0x00070008
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 91
  li t0, 0x00400020
  li t1, 0x00080009
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 92
  li t0, 0x00200010
  li t1, 0x0009000a
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 93
  li t0, 0x00100008
  li t1, 0x000a000b
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 94
  li t0, 0x00080004
  li t1, 0x000b000c
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 95
  li t0, 0x00040002
  li t1, 0x000c000d
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 96
  li t0, 0x00020001
  li t1, 0x000d000e
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 97
  li t0, 0x00010000
  li t1, 0x000e000f
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 98
  li t0, 0x00008000
  li t1, 0x000f0000
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

//////// sign bit is 1 ////////
  li TESTNUM, 99
  li t0, 0x00008000
  li t1, 0x000f0000
//  clrs16 t2, t0
//  .word 0x1010111, 01000, 00101, 000, 00111, 1111111
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 100
  li t0, 0x8000c000
  li t1, 0x00000001
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 101
  li t0, 0xc000e000
  li t1, 0x00010002
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 102
  li t0, 0xe000f000
  li t1, 0x00020003
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 103
  li t0, 0xf000f800
  li t1, 0x00030004
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 104
  li t0, 0xf800fc00
  li t1, 0x00040005
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 105
  li t0, 0xfc00fe00
  li t1, 0x00050006
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 106
  li t0, 0xfe00ff00
  li t1, 0x00060007
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 107
  li t0, 0xff00ff80
  li t1, 0x00070008
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 108
  li t0, 0xff80ffc0
  li t1, 0x00080009
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 109
  li t0, 0xffc0ffe0
  li t1, 0x0009000a
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 110
  li t0, 0xffe0fff0
  li t1, 0x000a000b
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 111
  li t0, 0xfff0fff8
  li t1, 0x000b000c
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 112
  li t0, 0xfff8fffc
  li t1, 0x000c000d
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 113
  li t0, 0xfffcfffe
  li t1, 0x000d000e
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 114
  li t0, 0xfffeffff
  li t1, 0x000e000f
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

  li TESTNUM, 115
  li t0, 0xffff0000
  li t1, 0x000f000f
//  clrs16 t2, t0
  .word 0xae8283ff
  bne t2, t1, fail

#########################################################################
# count leading zero 32
#########################################################################
  li TESTNUM, 116  
  li t0, 0x80000000            
  li t1, 0x00000000           
  clz32 t2, t0
  bne t2, t1, fail           

  CLZ32_OP(116, 0x80000000, 0x00000000, 0xaf9283ff)
  CLZ32_OP(117, 0x40000000, 0x00000001, 0xaf9283ff)
  CLZ32_OP(118, 0x20000000, 0x00000002, 0xaf9283ff)
  CLZ32_OP(119, 0x10000000, 0x00000003, 0xaf9283ff)
  CLZ32_OP(120, 0x08000000, 0x00000004, 0xaf9283ff)
  CLZ32_OP(121, 0x04000000, 0x00000005, 0xaf9283ff)
  CLZ32_OP(122, 0x02000000, 0x00000006, 0xaf9283ff)
  CLZ32_OP(123, 0x01000000, 0x00000007, 0xaf9283ff)
  CLZ32_OP(124, 0x00800000, 0x00000008, 0xaf9283ff)
  CLZ32_OP(125, 0x00400000, 0x00000009, 0xaf9283ff)
  CLZ32_OP(126, 0x00200000, 0x0000000a, 0xaf9283ff)
  CLZ32_OP(127, 0x00100000, 0x0000000b, 0xaf9283ff)
  CLZ32_OP(128, 0x00080000, 0x0000000c, 0xaf9283ff)
  CLZ32_OP(129, 0x00040000, 0x0000000d, 0xaf9283ff)
  CLZ32_OP(130, 0x00020000, 0x0000000e, 0xaf9283ff)
  CLZ32_OP(131, 0x00010000, 0x0000000f, 0xaf9283ff)
  CLZ32_OP(132, 0x00008000, 0x00000010, 0xaf9283ff)
  CLZ32_OP(133, 0x00004000, 0x00000011, 0xaf9283ff)
  CLZ32_OP(134, 0x00002000, 0x00000012, 0xaf9283ff)
  CLZ32_OP(135, 0x00001000, 0x00000013, 0xaf9283ff)
  CLZ32_OP(136, 0x00000800, 0x00000014, 0xaf9283ff)
  CLZ32_OP(137, 0x00000400, 0x00000015, 0xaf9283ff)
  CLZ32_OP(138, 0x00000200, 0x00000016, 0xaf9283ff)
  CLZ32_OP(139, 0x00000100, 0x00000017, 0xaf9283ff)
  CLZ32_OP(140, 0x00000080, 0x00000018, 0xaf9283ff)
  CLZ32_OP(141, 0x00000040, 0x00000019, 0xaf9283ff)
  CLZ32_OP(142, 0x00000020, 0x0000001a, 0xaf9283ff)
  CLZ32_OP(143, 0x00000010, 0x0000001b, 0xaf9283ff)
  CLZ32_OP(144, 0x00000008, 0x0000001c, 0xaf9283ff)
  CLZ32_OP(145, 0x00000004, 0x0000001d, 0xaf9283ff)
  CLZ32_OP(146, 0x00000002, 0x0000001e, 0xaf9283ff)
  CLZ32_OP(147, 0x00000001, 0x0000001f, 0xaf9283ff)
  CLZ32_OP(148, 0x00000000, 0x00000020, 0xaf9283ff)

#########################################################################
# count leading one 32
#########################################################################
  li TESTNUM, 149  
  li t0, 0x80000000            
  li t1, 0x00000001           
  clo32 t2, t0
  bne t2, t1, fail           

  CLO32_OP(149, 0x80000000, 0x00000001, 0xafb283ff)
  CLO32_OP(150, 0xc0000000, 0x00000002, 0xafb283ff)
  CLO32_OP(151, 0xe0000000, 0x00000003, 0xafb283ff)
  CLO32_OP(152, 0xf0000000, 0x00000004, 0xafb283ff)
  CLO32_OP(153, 0xf8000000, 0x00000005, 0xafb283ff)
  CLO32_OP(154, 0xfc000000, 0x00000006, 0xafb283ff)
  CLO32_OP(155, 0xfe000000, 0x00000007, 0xafb283ff)
  CLO32_OP(156, 0xff000000, 0x00000008, 0xafb283ff)
  CLO32_OP(157, 0xff800000, 0x00000009, 0xafb283ff)
  CLO32_OP(158, 0xffc00000, 0x0000000a, 0xafb283ff)
  CLO32_OP(159, 0xffe00000, 0x0000000b, 0xafb283ff)
  CLO32_OP(160, 0xfff00000, 0x0000000c, 0xafb283ff)
  CLO32_OP(161, 0xfff80000, 0x0000000d, 0xafb283ff)
  CLO32_OP(162, 0xfffc0000, 0x0000000e, 0xafb283ff)
  CLO32_OP(163, 0xfffe0000, 0x0000000f, 0xafb283ff)
  CLO32_OP(164, 0xffff0000, 0x00000010, 0xafb283ff)
  CLO32_OP(165, 0xffff8000, 0x00000011, 0xafb283ff)
  CLO32_OP(166, 0xffffc000, 0x00000012, 0xafb283ff)
  CLO32_OP(167, 0xffffe000, 0x00000013, 0xafb283ff)
  CLO32_OP(168, 0xfffff000, 0x00000014, 0xafb283ff)
  CLO32_OP(169, 0xfffff800, 0x00000015, 0xafb283ff)
  CLO32_OP(170, 0xfffffc00, 0x00000016, 0xafb283ff)
  CLO32_OP(171, 0xfffffe00, 0x00000017, 0xafb283ff)
  CLO32_OP(172, 0xffffff00, 0x00000018, 0xafb283ff)
  CLO32_OP(173, 0xffffff80, 0x00000019, 0xafb283ff)
  CLO32_OP(174, 0xffffffc0, 0x0000001a, 0xafb283ff)
  CLO32_OP(175, 0xffffffe0, 0x0000001b, 0xafb283ff)
  CLO32_OP(176, 0xfffffff0, 0x0000001c, 0xafb283ff)
  CLO32_OP(177, 0xfffffff8, 0x0000001d, 0xafb283ff)
  CLO32_OP(178, 0xfffffffc, 0x0000001e, 0xafb283ff)
  CLO32_OP(179, 0xfffffffe, 0x0000001f, 0xafb283ff)
  CLO32_OP(180, 0xffffffff, 0x00000020, 0xafb283ff)
  CLO32_OP(181, 0x00000000, 0x00000000, 0xafb283ff)

#########################################################################
# count leading redundant sign 32
#########################################################################
//////// sign bit is 0 ////////
  li TESTNUM, 182  
  li t0, 0x80000000            
  li t1, 0x00000000           
  clrs32 t2, t0
  bne t2, t1, fail           

  CLRS32_OP(182, 0x80000000, 0x00000000, 0xaf8283ff)
  CLRS32_OP(183, 0x40000000, 0x00000000, 0xaf8283ff)
  CLRS32_OP(184, 0x20000000, 0x00000001, 0xaf8283ff)
  CLRS32_OP(185, 0x10000000, 0x00000002, 0xaf8283ff)
  CLRS32_OP(186, 0x08000000, 0x00000003, 0xaf8283ff)
  CLRS32_OP(187, 0x04000000, 0x00000004, 0xaf8283ff)
  CLRS32_OP(188, 0x02000000, 0x00000005, 0xaf8283ff)
  CLRS32_OP(189, 0x01000000, 0x00000006, 0xaf8283ff)
  CLRS32_OP(190, 0x00800000, 0x00000007, 0xaf8283ff)
  CLRS32_OP(191, 0x00400000, 0x00000008, 0xaf8283ff)
  CLRS32_OP(192, 0x00200000, 0x00000009, 0xaf8283ff)
  CLRS32_OP(193, 0x00100000, 0x0000000a, 0xaf8283ff)
  CLRS32_OP(194, 0x00080000, 0x0000000b, 0xaf8283ff)
  CLRS32_OP(195, 0x00040000, 0x0000000c, 0xaf8283ff)
  CLRS32_OP(196, 0x00020000, 0x0000000d, 0xaf8283ff)
  CLRS32_OP(197, 0x00010000, 0x0000000e, 0xaf8283ff)
  CLRS32_OP(198, 0x00008000, 0x0000000f, 0xaf8283ff)
  CLRS32_OP(199, 0x00004000, 0x00000010, 0xaf8283ff)
  CLRS32_OP(200, 0x00002000, 0x00000011, 0xaf8283ff)
  CLRS32_OP(201, 0x00001000, 0x00000012, 0xaf8283ff)
  CLRS32_OP(202, 0x00000800, 0x00000013, 0xaf8283ff)
  CLRS32_OP(203, 0x00000400, 0x00000014, 0xaf8283ff)
  CLRS32_OP(204, 0x00000200, 0x00000015, 0xaf8283ff)
  CLRS32_OP(205, 0x00000100, 0x00000016, 0xaf8283ff)
  CLRS32_OP(206, 0x00000080, 0x00000017, 0xaf8283ff)
  CLRS32_OP(207, 0x00000040, 0x00000018, 0xaf8283ff)
  CLRS32_OP(208, 0x00000020, 0x00000019, 0xaf8283ff)
  CLRS32_OP(209, 0x00000010, 0x0000001a, 0xaf8283ff)
  CLRS32_OP(210, 0x00000008, 0x0000001b, 0xaf8283ff)
  CLRS32_OP(211, 0x00000004, 0x0000001c, 0xaf8283ff)
  CLRS32_OP(212, 0x00000002, 0x0000001d, 0xaf8283ff)
  CLRS32_OP(213, 0x00000001, 0x0000001e, 0xaf8283ff)
  CLRS32_OP(214, 0x00000000, 0x0000001f, 0xaf8283ff)

//////// sign bit is 1 ////////
  CLRS32_OP(215, 0x80000000, 0x00000000, 0xaf8283ff)
  CLRS32_OP(216, 0xc0000000, 0x00000001, 0xaf8283ff)
  CLRS32_OP(217, 0xe0000000, 0x00000002, 0xaf8283ff)
  CLRS32_OP(218, 0xf0000000, 0x00000003, 0xaf8283ff)
  CLRS32_OP(219, 0xf8000000, 0x00000004, 0xaf8283ff)
  CLRS32_OP(220, 0xfc000000, 0x00000005, 0xaf8283ff)
  CLRS32_OP(221, 0xfe000000, 0x00000006, 0xaf8283ff)
  CLRS32_OP(222, 0xff000000, 0x00000007, 0xaf8283ff)
  CLRS32_OP(223, 0xff800000, 0x00000008, 0xaf8283ff)
  CLRS32_OP(224, 0xffc00000, 0x00000009, 0xaf8283ff)
  CLRS32_OP(225, 0xffe00000, 0x0000000a, 0xaf8283ff)
  CLRS32_OP(226, 0xfff00000, 0x0000000b, 0xaf8283ff)
  CLRS32_OP(227, 0xfff80000, 0x0000000c, 0xaf8283ff)
  CLRS32_OP(228, 0xfffc0000, 0x0000000d, 0xaf8283ff)
  CLRS32_OP(229, 0xfffe0000, 0x0000000e, 0xaf8283ff)
  CLRS32_OP(230, 0xffff0000, 0x0000000f, 0xaf8283ff)
  CLRS32_OP(231, 0xffff8000, 0x00000010, 0xaf8283ff)
  CLRS32_OP(232, 0xffffc000, 0x00000011, 0xaf8283ff)
  CLRS32_OP(233, 0xffffe000, 0x00000012, 0xaf8283ff)
  CLRS32_OP(234, 0xfffff000, 0x00000013, 0xaf8283ff)
  CLRS32_OP(235, 0xfffff800, 0x00000014, 0xaf8283ff)
  CLRS32_OP(236, 0xfffffc00, 0x00000015, 0xaf8283ff)
  CLRS32_OP(237, 0xfffffe00, 0x00000016, 0xaf8283ff)
  CLRS32_OP(238, 0xffffff00, 0x00000017, 0xaf8283ff)
  CLRS32_OP(239, 0xffffff80, 0x00000018, 0xaf8283ff)
  CLRS32_OP(240, 0xffffffc0, 0x00000019, 0xaf8283ff)
  CLRS32_OP(241, 0xffffffe0, 0x0000001a, 0xaf8283ff)
  CLRS32_OP(242, 0xfffffff0, 0x0000001b, 0xaf8283ff)
  CLRS32_OP(242, 0xfffffff8, 0x0000001c, 0xaf8283ff)
  CLRS32_OP(243, 0xfffffffc, 0x0000001d, 0xaf8283ff)
  CLRS32_OP(244, 0xfffffffe, 0x0000001e, 0xaf8283ff)
  CLRS32_OP(245, 0xffffffff, 0x0000001f, 0xaf8283ff)
  CLRS32_OP(246, 0x00000000, 0x0000001f, 0xaf8283ff)

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

