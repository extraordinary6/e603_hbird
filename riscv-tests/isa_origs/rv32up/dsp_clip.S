# See LICENSE for license details.

#*****************************************************************************
# dsp_clip.S
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
# uclip8
#########################################################################
  # imm=7, with overflow
  li TESTNUM, 2
  li t0, 0x7f00ff7e
  li t1, 0x7f00007e
  uclip8 t2, t0, 7
  bne t2, t1, fail 

  # imm=7, without overflow
  li TESTNUM, 3
  li t0, 0x7f003f7e
  li t1, 0x7f003f7e
  uclip8 t2, t0, 7
  bne t2, t1, fail

  # imm=6, with overflow
  li TESTNUM, 4
  li t0, 0x7f00ff3e
  li t1, 0x3f00003e
  uclip8 t2, t0, 6
  bne t2, t1, fail

  # imm=5, with overflow
  li TESTNUM, 5
  li t0, 0x7f00ff1e
  li t1, 0x1f00001e
  uclip8 t2, t0, 5
  bne t2, t1, fail

  # imm=4, with overflow
  li TESTNUM, 6
  li t0, 0x7f00ff0e
  li t1, 0x0f00000e
  uclip8 t2, t0, 4
  bne t2, t1, fail

  # imm=3, with overflow
  li TESTNUM, 7
  li t0, 0x7f00ff06
  li t1, 0x07000006
  uclip8 t2, t0, 3
  bne t2, t1, fail

  # imm=2, with overflow
  li TESTNUM, 8
  li t0, 0x7f00ff02
  li t1, 0x03000002
  uclip8 t2, t0, 2
  bne t2, t1, fail

  # imm=1, with overflow
  li TESTNUM, 9
  li t0, 0x7f00ff00
  li t1, 0x01000000
  uclip8 t2, t0, 1
  bne t2, t1, fail

  # imm=0, with overflow
  li TESTNUM, 10
  li t0, 0x7f00ff00
  li t1, 0x00000000
  uclip8 t2, t0, 0
  bne t2, t1, fail

  # imm=0, without overflow
  li TESTNUM, 11
  li t0, 0x00000000
  li t1, 0x00000000
  uclip8 t2, t0, 0
  bne t2, t1, fail

#########################################################################
# sclip8
#########################################################################
  # imm=7, without overflow
  li TESTNUM, 12
  li t0, 0x7f00807e
  li t1, 0x7f00807e
  sclip8 t2, t0, 7
  bne t2, t1, fail 

  # imm=6, without overflow
  li TESTNUM, 13
  li t0, 0x3f00c0c1
  li t1, 0x3f00c0c1
  sclip8 t2, t0, 6
  bne t2, t1, fail

  # imm=6, with overflow
  li TESTNUM, 14
  li t0, 0x7f0080c1
  li t1, 0x3f00c0c1
  sclip8 t2, t0, 6
  bne t2, t1, fail

  # imm=5, with overflow
  li TESTNUM, 15
  li t0, 0x7f0080e1
  li t1, 0x1f00e0e1
  sclip8 t2, t0, 5
  bne t2, t1, fail

  # imm=4, with overflow
  li TESTNUM, 16
  li t0, 0x7f0080f1
  li t1, 0x0f00f0f1
  sclip8 t2, t0, 4
  bne t2, t1, fail

  # imm=3, with overflow
  li TESTNUM, 17
  li t0, 0x7f0080f9
  li t1, 0x0700f8f9
  sclip8 t2, t0, 3
  bne t2, t1, fail

  # imm=2, with overflow
  li TESTNUM, 18
  li t0, 0x7f0080fd
  li t1, 0x0300fcfd
  sclip8 t2, t0, 2
  bne t2, t1, fail

  # imm=1, with overflow
  li TESTNUM, 19
  li t0, 0x7f0080ff
  li t1, 0x0100feff
  sclip8 t2, t0, 1
  bne t2, t1, fail

  # imm=0, with overflow
  li TESTNUM, 20
  li t0, 0x7f0080ff
  li t1, 0x0000ffff
  sclip8 t2, t0, 0
  bne t2, t1, fail

  # imm=0, without overflow
  li TESTNUM, 21
  li t0, 0x000000ff
  li t1, 0x000000ff
  sclip8 t2, t0, 0
  bne t2, t1, fail

#########################################################################
# uclip16
#########################################################################
  # imm=15, with overflow
  li TESTNUM, 22
  li t0, 0x7fffffff
  li t1, 0x7fff0000
  uclip16 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, without overflow
  li TESTNUM, 23
  li t0, 0x7fff0000
  li t1, 0x7fff0000
  uclip16 t2, t0, 15
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 24
  li t0, 0x7fffffff
  li t1, 0x3fff0000
  uclip16 t2, t0, 14
  bne t2, t1, fail

  # imm=14, without overflow
  li TESTNUM, 25
  li t0, 0x3fff0000
  li t1, 0x3fff0000
  uclip16 t2, t0, 14
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 26
  li t0, 0x7fffffff
  li t1, 0x1fff0000
  uclip16 t2, t0, 13
  bne t2, t1, fail

  # imm=13, without overflow
  li TESTNUM, 27
  li t0, 0x1fff0000
  li t1, 0x1fff0000
  uclip16 t2, t0, 13
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 28
  li t0, 0x7fffffff
  li t1, 0x0fff0000
  uclip16 t2, t0, 12
  bne t2, t1, fail

  # imm=12, without overflow
  li TESTNUM, 29
  li t0, 0x0fff0000
  li t1, 0x0fff0000
  uclip16 t2, t0, 12
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 30
  li t0, 0x7fffffff
  li t1, 0x07ff0000
  uclip16 t2, t0, 11
  bne t2, t1, fail

  # imm=11, without overflow
  li TESTNUM, 31
  li t0, 0x07ff0000
  li t1, 0x07ff0000
  uclip16 t2, t0, 11
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 32
  li t0, 0x7fffffff
  li t1, 0x03ff0000
  uclip16 t2, t0, 10
  bne t2, t1, fail

  # imm=10, without overflow
  li TESTNUM, 33
  li t0, 0x03ff0000
  li t1, 0x03ff0000
  uclip16 t2, t0, 10
  bne t2, t1, fail

  # imm=9, with overflow
  li TESTNUM, 34
  li t0, 0x7fffffff
  li t1, 0x01ff0000
  uclip16 t2, t0, 9
  bne t2, t1, fail

  # imm=9, without overflow
  li TESTNUM, 35
  li t0, 0x01ff0000
  li t1, 0x01ff0000
  uclip16 t2, t0, 9
  bne t2, t1, fail

  # imm=8, with overflow
  li TESTNUM, 36
  li t0, 0x7fffffff
  li t1, 0x00ff0000
  uclip16 t2, t0, 8
  bne t2, t1, fail

  # imm=8, without overflow
  li TESTNUM, 37
  li t0, 0x00ff0000
  li t1, 0x00ff0000
  uclip16 t2, t0, 8
  bne t2, t1, fail

  # imm=7, with overflow
  li TESTNUM, 38
  li t0, 0x7fffffff
  li t1, 0x007f0000
  uclip16 t2, t0, 7
  bne t2, t1, fail

  # imm=7, without overflow
  li TESTNUM, 39
  li t0, 0x007f0000
  li t1, 0x007f0000
  uclip16 t2, t0, 7
  bne t2, t1, fail

  # imm=6, with overflow
  li TESTNUM, 40
  li t0, 0x7fffffff
  li t1, 0x003f0000
  uclip16 t2, t0, 6
  bne t2, t1, fail

  # imm=6, without overflow
  li TESTNUM, 41
  li t0, 0x003f0000
  li t1, 0x003f0000
  uclip16 t2, t0, 6
  bne t2, t1, fail

  # imm=5, with overflow
  li TESTNUM, 42
  li t0, 0x7fffffff
  li t1, 0x001f0000
  uclip16 t2, t0, 5
  bne t2, t1, fail

  # imm=5, without overflow
  li TESTNUM, 43
  li t0, 0x001f0000
  li t1, 0x001f0000
  uclip16 t2, t0, 5
  bne t2, t1, fail

  # imm=4, with overflow
  li TESTNUM, 44
  li t0, 0x7fffffff
  li t1, 0x000f0000
  uclip16 t2, t0, 4
  bne t2, t1, fail

  # imm=4, without overflow
  li TESTNUM, 45
  li t0, 0x000f0000
  li t1, 0x000f0000
  uclip16 t2, t0, 4
  bne t2, t1, fail

  # imm=3, with overflow
  li TESTNUM, 46
  li t0, 0x7fffffff
  li t1, 0x00070000
  uclip16 t2, t0, 3
  bne t2, t1, fail

  # imm=3, without overflow
  li TESTNUM, 47
  li t0, 0x00070000
  li t1, 0x00070000
  uclip16 t2, t0, 3
  bne t2, t1, fail

  # imm=2, with overflow
  li TESTNUM, 48
  li t0, 0x7fffffff
  li t1, 0x00030000
  uclip16 t2, t0, 2
  bne t2, t1, fail

  # imm=2, without overflow
  li TESTNUM, 49
  li t0, 0x00030000
  li t1, 0x00030000
  uclip16 t2, t0, 2
  bne t2, t1, fail

  # imm=1, with overflow
  li TESTNUM, 50
  li t0, 0x7fffffff
  li t1, 0x00010000
  uclip16 t2, t0, 1
  bne t2, t1, fail

  # imm=1, without overflow
  li TESTNUM, 51
  li t0, 0x00010000
  li t1, 0x00010000
  uclip16 t2, t0, 1
  bne t2, t1, fail

  # imm=0, with overflow
  li TESTNUM, 52
  li t0, 0x7fffffff
  li t1, 0x00000000
  uclip16 t2, t0, 0
  bne t2, t1, fail

  # imm=0, without overflow
  li TESTNUM, 53
  li t0, 0x00000000
  li t1, 0x00000000
  uclip16 t2, t0, 0
  bne t2, t1, fail

#########################################################################
# sclip16
#########################################################################
  # imm=15, without overflow
  li TESTNUM, 54
  li t0, 0x7fff8000
  li t1, 0x7fff8000
  sclip16 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, without overflow
  li TESTNUM, 55
  li t0, 0x7fffffff
  li t1, 0x7fffffff
  sclip16 t2, t0, 15
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 56
  li t0, 0x7fff8000
  li t1, 0x3fffc000
  sclip16 t2, t0, 14
  bne t2, t1, fail

  # imm=14, without overflow
  li TESTNUM, 57
  li t0, 0x3fffffff
  li t1, 0x3fffffff
  sclip16 t2, t0, 14
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 58
  li t0, 0x7fff8000
  li t1, 0x1fffe000
  sclip16 t2, t0, 13
  bne t2, t1, fail

  # imm=13, without overflow
  li TESTNUM, 59
  li t0, 0x1fffffff
  li t1, 0x1fffffff
  sclip16 t2, t0, 13
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 60
  li t0, 0x7fff8000
  li t1, 0x0ffff000
  sclip16 t2, t0, 12
  bne t2, t1, fail

  # imm=12, without overflow
  li TESTNUM, 61
  li t0, 0x0fffffff
  li t1, 0x0fffffff
  sclip16 t2, t0, 12
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 62
  li t0, 0x7fff8000
  li t1, 0x07fff800
  sclip16 t2, t0, 11
  bne t2, t1, fail

  # imm=11, without overflow
  li TESTNUM, 63
  li t0, 0x07ffffff
  li t1, 0x07ffffff
  sclip16 t2, t0, 11
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 64
  li t0, 0x7fff8000
  li t1, 0x03fffc00
  sclip16 t2, t0, 10
  bne t2, t1, fail

  # imm=10, without overflow
  li TESTNUM, 65
  li t0, 0x03ffffff
  li t1, 0x03ffffff
  sclip16 t2, t0, 10
  bne t2, t1, fail

  # imm=9, with overflow
  li TESTNUM, 66
  li t0, 0x7fff8000
  li t1, 0x01fffe00
  sclip16 t2, t0, 9
  bne t2, t1, fail

  # imm=9, without overflow
  li TESTNUM, 67
  li t0, 0x01ffffff
  li t1, 0x01ffffff
  sclip16 t2, t0, 9
  bne t2, t1, fail

  # imm=8, with overflow
  li TESTNUM, 68
  li t0, 0x7fff8000
  li t1, 0x00ffff00
  sclip16 t2, t0, 8
  bne t2, t1, fail

  # imm=8, without overflow
  li TESTNUM, 69
  li t0, 0x00ffffff
  li t1, 0x00ffffff
  sclip16 t2, t0, 8
  bne t2, t1, fail

  # imm=7, with overflow
  li TESTNUM, 70
  li t0, 0x7fff8000
  li t1, 0x007fff80
  sclip16 t2, t0, 7
  bne t2, t1, fail

  # imm=7, without overflow
  li TESTNUM, 71
  li t0, 0x007fffff
  li t1, 0x007fffff
  sclip16 t2, t0, 7
  bne t2, t1, fail

  # imm=6, with overflow
  li TESTNUM, 72
  li t0, 0x7fff8000
  li t1, 0x003fffc0
  sclip16 t2, t0, 6
  bne t2, t1, fail

  # imm=6, without overflow
  li TESTNUM, 73
  li t0, 0x003fffff
  li t1, 0x003fffff
  sclip16 t2, t0, 6
  bne t2, t1, fail

  # imm=5, with overflow
  li TESTNUM, 74
  li t0, 0x7fff8000
  li t1, 0x001fffe0
  sclip16 t2, t0, 5
  bne t2, t1, fail

  # imm=5, without overflow
  li TESTNUM, 75
  li t0, 0x001fffff
  li t1, 0x001fffff
  sclip16 t2, t0, 5
  bne t2, t1, fail

  # imm=4, with overflow
  li TESTNUM, 76
  li t0, 0x7fff8000
  li t1, 0x000ffff0
  sclip16 t2, t0, 4
  bne t2, t1, fail

  # imm=4, without overflow
  li TESTNUM, 77
  li t0, 0x000fffff
  li t1, 0x000fffff
  sclip16 t2, t0, 4
  bne t2, t1, fail

  # imm=3, with overflow
  li TESTNUM, 78
  li t0, 0x7fff8000
  li t1, 0x0007fff8
  sclip16 t2, t0, 3
  bne t2, t1, fail

  # imm=3, without overflow
  li TESTNUM, 79
  li t0, 0x0007ffff
  li t1, 0x0007ffff
  sclip16 t2, t0, 3
  bne t2, t1, fail

  # imm=2, with overflow
  li TESTNUM, 80
  li t0, 0x7fff8000
  li t1, 0x0003fffc
  sclip16 t2, t0, 2
  bne t2, t1, fail

  # imm=2, without overflow
  li TESTNUM, 81
  li t0, 0x0003ffff
  li t1, 0x0003ffff
  sclip16 t2, t0, 2
  bne t2, t1, fail

  # imm=1, with overflow
  li TESTNUM, 82
  li t0, 0x7fff8000
  li t1, 0x0001fffe
  sclip16 t2, t0, 1
  bne t2, t1, fail

  # imm=1, without overflow
  li TESTNUM, 83
  li t0, 0x0001ffff
  li t1, 0x0001ffff
  sclip16 t2, t0, 1
  bne t2, t1, fail

  # imm=0, with overflow
  li TESTNUM, 84
  li t0, 0x7fff8000
  li t1, 0x0000ffff
  sclip16 t2, t0, 0
  bne t2, t1, fail

  # imm=0, without overflow
  li TESTNUM, 85
  li t0, 0x0000ffff
  li t1, 0x0000ffff
  sclip16 t2, t0, 0
  bne t2, t1, fail

#########################################################################
# uclip32
#########################################################################
  # imm=31, with overflow
  li TESTNUM, 86
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 31
  bne t2, t1, fail

  # imm=31, without overflow
  li TESTNUM, 87
  li t0, 0x7fffffff
  li t1, 0x7fffffff
  uclip32 t2, t0, 31
  bne t2, t1, fail 

  # imm=31, without overflow
  li TESTNUM, 88
  li t0, 0x7ffffff0
  li t1, 0x7ffffff0
  uclip32 t2, t0, 31
  bne t2, t1, fail 

  # imm=30, with overflow
  li TESTNUM, 89
  li t0, 0x7fffffff
  li t1, 0x3fffffff
  uclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=30, with overflow
  li TESTNUM, 90
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=30, without overflow
  li TESTNUM, 91
  li t0, 0x3fff0000
  li t1, 0x3fff0000
  uclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=29, with overflow
  li TESTNUM, 92
  li t0, 0x7fffffff
  li t1, 0x1fffffff
  uclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=29, with overflow
  li TESTNUM, 93
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=29, without overflow
  li TESTNUM, 94
  li t0, 0x1fff0000
  li t1, 0x1fff0000
  uclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=28, with overflow
  li TESTNUM, 95
  li t0, 0x7fffffff
  li t1, 0x0fffffff
  uclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=28, with overflow
  li TESTNUM, 96
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=28, without overflow
  li TESTNUM, 97
  li t0, 0x0fff0000
  li t1, 0x0fff0000
  uclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=27, with overflow
  li TESTNUM, 98
  li t0, 0x7fffffff
  li t1, 0x07ffffff
  uclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=27, with overflow
  li TESTNUM, 99
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=27, without overflow
  li TESTNUM, 100
  li t0, 0x07ff0000
  li t1, 0x07ff0000
  uclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=26, with overflow
  li TESTNUM, 101
  li t0, 0x7fffffff
  li t1, 0x03ffffff
  uclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=26, with overflow
  li TESTNUM, 102
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=26, without overflow
  li TESTNUM, 103
  li t0, 0x03ff0000
  li t1, 0x03ff0000
  uclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=25, with overflow
  li TESTNUM, 104
  li t0, 0x7fffffff
  li t1, 0x01ffffff
  uclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=25, with overflow
  li TESTNUM, 105
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 25
  bne t2, t1, fail

 # imm=25, without overflow
  li TESTNUM, 106
  li t0, 0x01ff0000
  li t1, 0x01ff0000
  uclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=24, with overflow
  li TESTNUM, 107
  li t0, 0x7fffffff
  li t1, 0x00ffffff
  uclip32 t2, t0, 24
  bne t2, t1, fail

  # imm=24, with overflow
  li TESTNUM, 108
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 24
  bne t2, t1, fail

  # imm=24, without overflow
  li TESTNUM, 109
  li t0, 0x00ff0000
  li t1, 0x00ff0000
  uclip32 t2, t0, 24 
  bne t2, t1, fail

  # imm=23, with overflow
  li TESTNUM, 110
  li t0, 0x7fffffff
  li t1, 0x007fffff
  uclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=23, with overflow
  li TESTNUM, 111
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=23, without overflow
  li TESTNUM, 112
  li t0, 0x007f0000
  li t1, 0x007f0000
  uclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=22, with overflow
  li TESTNUM, 113
  li t0, 0x7fffffff
  li t1, 0x003fffff
  uclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=22, with overflow
  li TESTNUM, 114
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=22, without overflow
  li TESTNUM, 115
  li t0, 0x003f0000
  li t1, 0x003f0000
  uclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=21, with overflow
  li TESTNUM, 116
  li t0, 0x7fffffff
  li t1, 0x001fffff
  uclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=21, with overflow
  li TESTNUM, 117
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=21, without overflow
  li TESTNUM, 118
  li t0, 0x001f0000
  li t1, 0x001f0000
  uclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=20, with overflow
  li TESTNUM, 119
  li t0, 0x7fffffff
  li t1, 0x000fffff
  uclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=20, with overflow
  li TESTNUM, 120
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=20, without overflow
  li TESTNUM, 121
  li t0, 0x000f0000
  li t1, 0x000f0000
  uclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=19, with overflow
  li TESTNUM, 122
  li t0, 0x7fffffff
  li t1, 0x0007ffff
  uclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=19, with overflow
  li TESTNUM, 123
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=19, without overflow
  li TESTNUM, 124
  li t0, 0x00070000
  li t1, 0x00070000
  uclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=18, with overflow
  li TESTNUM, 125
  li t0, 0x7fffffff
  li t1, 0x0003ffff
  uclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=18, with overflow
  li TESTNUM, 126
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=18, without overflow
  li TESTNUM, 127
  li t0, 0x00030000
  li t1, 0x00030000
  uclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=17, with overflow
  li TESTNUM, 128
  li t0, 0x7fffffff
  li t1, 0x0001ffff
  uclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=17, with overflow
  li TESTNUM, 129
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=17, without overflow
  li TESTNUM, 130
  li t0, 0x00010000
  li t1, 0x00010000
  uclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=16, with overflow
  li TESTNUM, 131
  li t0, 0x7fffffff
  li t1, 0x0000ffff
  uclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=16, with overflow
  li TESTNUM, 132
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=16, without overflow
  li TESTNUM, 133
  li t0, 0x0000f000
  li t1, 0x0000f000
  uclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=15, with overflow
  li TESTNUM, 134
  li t0, 0x7fffffff
  li t1, 0x00007fff
  uclip32 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, with overflow
  li TESTNUM, 135
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, without overflow
  li TESTNUM, 136
  li t0, 0x00007000
  li t1, 0x00007000
  uclip32 t2, t0, 15
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 137
  li t0, 0x7fffffff
  li t1, 0x00003fff
  uclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 138
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=14, without overflow
  li TESTNUM, 139
  li t0, 0x00003000
  li t1, 0x00003000
  uclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 140
  li t0, 0x7fffffff
  li t1, 0x00001fff
  uclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 141
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=13, without overflow
  li TESTNUM, 142
  li t0, 0x00001000
  li t1, 0x00001000
  uclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 143
  li t0, 0x7fffffff
  li t1, 0x00000fff
  uclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 144
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=12, without overflow
  li TESTNUM, 145
  li t0, 0x00000f00
  li t1, 0x00000f00
  uclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 146
  li t0, 0x7fffffff
  li t1, 0x000007ff
  uclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 147
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=11, without overflow
  li TESTNUM, 148
  li t0, 0x00000700
  li t1, 0x00000700
  uclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 149
  li t0, 0x7fffffff
  li t1, 0x000003ff
  uclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 150
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=10, without overflow
  li TESTNUM, 151
  li t0, 0x00000300
  li t1, 0x00000300
  uclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=09, with overflow
  li TESTNUM, 152
  li t0, 0x7fffffff
  li t1, 0x000001ff
  uclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=09, with overflow
  li TESTNUM, 153
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=09, without overflow
  li TESTNUM, 154
  li t0, 0x00000100
  li t1, 0x00000100
  uclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=08, with overflow
  li TESTNUM, 155
  li t0, 0x7fffffff
  li t1, 0x000000ff
  uclip32 t2, t0, 8 
  bne t2, t1, fail

  # imm=08, with overflow
  li TESTNUM, 156
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 8 
  bne t2, t1, fail

  # imm=08, without overflow
  li TESTNUM, 157
  li t0, 0x000000f0
  li t1, 0x000000f0
  uclip32 t2, t0, 8  
  bne t2, t1, fail

  # imm=07, with overflow
  li TESTNUM, 158
  li t0, 0x7fffffff
  li t1, 0x0000007f
  uclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=07, with overflow
  li TESTNUM, 159
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=07, without overflow
  li TESTNUM, 160
  li t0, 0x00000070
  li t1, 0x00000070
  uclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=06, with overflow
  li TESTNUM, 161
  li t0, 0x7fffffff
  li t1, 0x0000003f
  uclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=06, with overflow
  li TESTNUM, 162
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=06, without overflow
  li TESTNUM, 163
  li t0, 0x00000030
  li t1, 0x00000030
  uclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=05, with overflow
  li TESTNUM, 164
  li t0, 0x7fffffff
  li t1, 0x0000001f
  uclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=05, with overflow
  li TESTNUM, 165
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=05, without overflow
  li TESTNUM, 166
  li t0, 0x00000010
  li t1, 0x00000010
  uclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=04, with overflow
  li TESTNUM, 167
  li t0, 0x7fffffff
  li t1, 0x0000000f
  uclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=04, with overflow
  li TESTNUM, 168
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=04, without overflow
  li TESTNUM, 169
  li t0, 0x00000007
  li t1, 0x00000007
  uclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=03, with overflow
  li TESTNUM, 170
  li t0, 0x7fffffff
  li t1, 0x00000007
  uclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=03, with overflow
  li TESTNUM, 171
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=03, without overflow
  li TESTNUM, 172
  li t0, 0x00000006
  li t1, 0x00000006
  uclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=02, with overflow
  li TESTNUM, 173
  li t0, 0x7fffffff
  li t1, 0x00000003
  uclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=02, with overflow
  li TESTNUM, 174
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=02, without overflow
  li TESTNUM, 175
  li t0, 0x00000002
  li t1, 0x00000002
  uclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=01, with overflow
  li TESTNUM, 176
  li t0, 0x7fffffff
  li t1, 0x00000001
  uclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=01, with overflow
  li TESTNUM, 177
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=01, without overflow
  li TESTNUM, 178
  li t0, 0x00000000
  li t1, 0x00000000
  uclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=00, with overflow
  li TESTNUM, 179
  li t0, 0x7fffffff
  li t1, 0x00000000
  uclip32 t2, t0, 0 
  bne t2, t1, fail

  # imm=00, with overflow
  li TESTNUM, 180
  li t0, 0xffffffff
  li t1, 0x00000000
  uclip32 t2, t0, 0 
  bne t2, t1, fail

  # imm=00, without overflow
  li TESTNUM, 181
  li t0, 0x00000000
  li t1, 0x00000000
  uclip32 t2, t0, 0 
  bne t2, t1, fail

#########################################################################
# sclip32
#########################################################################
  # imm=31, without overflow
  li TESTNUM, 182
  li t0, 0x7fffffff
  li t1, 0x7fffffff
  sclip32 t2, t0, 31
  bne t2, t1, fail 

  # imm=31, without overflow
  li TESTNUM, 183
  li t0, 0x80000000
  li t1, 0x80000000
  sclip32 t2, t0, 31
  bne t2, t1, fail

  # imm=30, with overflow
  li TESTNUM, 184
  li t0, 0x7fffffff
  li t1, 0x3fffffff
  sclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=30, with overflow
  li TESTNUM, 185
  li t0, 0x80000000
  li t1, 0xc0000000
  sclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=30, without overflow
  li TESTNUM, 186
  li t0, 0x3fff0000
  li t1, 0x3fff0000
  sclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=30, without overflow
  li TESTNUM, 187
  li t0, 0xc0000000
  li t1, 0xc0000000
  sclip32 t2, t0, 30
  bne t2, t1, fail

  # imm=29, with overflow
  li TESTNUM, 188
  li t0, 0x7fffffff
  li t1, 0x1fffffff
  sclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=29, with overflow
  li TESTNUM, 189
  li t0, 0x80000000
  li t1, 0xe0000000
  sclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=29, without overflow
  li TESTNUM, 190
  li t0, 0x1fff0000
  li t1, 0x1fff0000
  sclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=29, without overflow
  li TESTNUM, 191
  li t0, 0xe0000000
  li t1, 0xe0000000
  sclip32 t2, t0, 29
  bne t2, t1, fail

  # imm=28, with overflow
  li TESTNUM, 192
  li t0, 0x7fffffff
  li t1, 0x0fffffff
  sclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=28, with overflow
  li TESTNUM, 193
  li t0, 0x80000000
  li t1, 0xf0000000
  sclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=28, without overflow
  li TESTNUM, 194
  li t0, 0x0fff0000
  li t1, 0x0fff0000
  sclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=28, without overflow
  li TESTNUM, 195
  li t0, 0xf0000000
  li t1, 0xf0000000
  sclip32 t2, t0, 28
  bne t2, t1, fail

  # imm=27, with overflow
  li TESTNUM, 196
  li t0, 0x7fffffff
  li t1, 0x07ffffff
  sclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=27, with overflow
  li TESTNUM, 197
  li t0, 0x80000000
  li t1, 0xf8000000
  sclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=27, without overflow
  li TESTNUM, 198
  li t0, 0x07ff0000
  li t1, 0x07ff0000
  sclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=27, without overflow
  li TESTNUM, 199
  li t0, 0xf8000000
  li t1, 0xf8000000
  sclip32 t2, t0, 27
  bne t2, t1, fail

  # imm=26, with overflow
  li TESTNUM, 200
  li t0, 0x7fffffff
  li t1, 0x03ffffff
  sclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=26, with overflow
  li TESTNUM, 201
  li t0, 0x80000000
  li t1, 0xfc000000
  sclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=26, without overflow
  li TESTNUM, 202
  li t0, 0x03ff0000
  li t1, 0x03ff0000
  sclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=26, without overflow
  li TESTNUM, 203
  li t0, 0xfc000000
  li t1, 0xfc000000
  sclip32 t2, t0, 26
  bne t2, t1, fail

  # imm=25, with overflow
  li TESTNUM, 204
  li t0, 0x7fffffff
  li t1, 0x01ffffff
  sclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=25, with overflow
  li TESTNUM, 205
  li t0, 0x80000000
  li t1, 0xfe000000
  sclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=25, without overflow
  li TESTNUM, 206
  li t0, 0x01ff0000
  li t1, 0x01ff0000
  sclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=25, without overflow
  li TESTNUM, 207
  li t0, 0xfe000000
  li t1, 0xfe000000
  sclip32 t2, t0, 25
  bne t2, t1, fail

  # imm=24, with overflow
  li TESTNUM, 208
  li t0, 0x7fffffff
  li t1, 0x00ffffff
  sclip32 t2, t0, 24
  bne t2, t1, fail

  # imm=24, with overflow
  li TESTNUM, 209
  li t0, 0x80000000
  li t1, 0xff000000
  sclip32 t2, t0, 24
  bne t2, t1, fail

 # imm=24, without overflow
  li TESTNUM, 210
  li t0, 0x00ff0000
  li t1, 0x00ff0000
  sclip32 t2, t0, 24 
  bne t2, t1, fail
 
 # imm=24, without overflow
  li TESTNUM, 211
  li t0, 0xff000000
  li t1, 0xff000000
  sclip32 t2, t0, 24 
  bne t2, t1, fail

  # imm=23, with overflow
  li TESTNUM, 212
  li t0, 0x7fffffff
  li t1, 0x007fffff
  sclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=23, with overflow
  li TESTNUM, 213
  li t0, 0x80000000
  li t1, 0xff800000
  sclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=23, without overflow
  li TESTNUM, 214
  li t0, 0x007f0000
  li t1, 0x007f0000
  sclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=23, without overflow
  li TESTNUM, 215
  li t0, 0xff800000
  li t1, 0xff800000
  sclip32 t2, t0, 23
  bne t2, t1, fail

  # imm=22, with overflow
  li TESTNUM, 216
  li t0, 0x7fffffff
  li t1, 0x003fffff
  sclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=22, with overflow
  li TESTNUM, 217
  li t0, 0x80000000
  li t1, 0xffc00000
  sclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=22, without overflow
  li TESTNUM, 218
  li t0, 0x003f0000
  li t1, 0x003f0000
  sclip32 t2, t0, 22
  bne t2, t1, fail
 
  # imm=22, without overflow
  li TESTNUM, 219
  li t0, 0xffc00000
  li t1, 0xffc00000
  sclip32 t2, t0, 22
  bne t2, t1, fail

  # imm=21, with overflow
  li TESTNUM, 220
  li t0, 0x7fffffff
  li t1, 0x001fffff
  sclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=21, with overflow
  li TESTNUM, 221
  li t0, 0x80000000
  li t1, 0xffe00000
  sclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=21, without overflow
  li TESTNUM, 222
  li t0, 0x001f0000
  li t1, 0x001f0000
  sclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=21, without overflow
  li TESTNUM, 223
  li t0, 0xffe00000
  li t1, 0xffe00000
  sclip32 t2, t0, 21
  bne t2, t1, fail

  # imm=20, with overflow
  li TESTNUM, 224
  li t0, 0x7fffffff
  li t1, 0x000fffff
  sclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=20, with overflow
  li TESTNUM, 225
  li t0, 0x80000000
  li t1, 0xfff00000
  sclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=20, without overflow
  li TESTNUM, 226
  li t0, 0x000f0000
  li t1, 0x000f0000
  sclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=20, without overflow
  li TESTNUM, 227
  li t0, 0xfff00000
  li t1, 0xfff00000
  sclip32 t2, t0, 20
  bne t2, t1, fail

  # imm=19, with overflow
  li TESTNUM, 228
  li t0, 0x7fffffff
  li t1, 0x0007ffff
  sclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=19, with overflow
  li TESTNUM, 229
  li t0, 0x80000000
  li t1, 0xfff80000
  sclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=19, without overflow
  li TESTNUM, 230
  li t0, 0x00070000
  li t1, 0x00070000
  sclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=19, without overflow
  li TESTNUM, 231
  li t0, 0xfff80000
  li t1, 0xfff80000
  sclip32 t2, t0, 19
  bne t2, t1, fail

  # imm=18, with overflow
  li TESTNUM, 232
  li t0, 0x7fffffff
  li t1, 0x0003ffff
  sclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=18, with overflow
  li TESTNUM, 233
  li t0, 0x80000000
  li t1, 0xfffc0000
  sclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=18, without overflow
  li TESTNUM, 234
  li t0, 0x00030000
  li t1, 0x00030000
  sclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=18, without overflow
  li TESTNUM, 235
  li t0, 0xfffc0000
  li t1, 0xfffc0000
  sclip32 t2, t0, 18
  bne t2, t1, fail

  # imm=17, with overflow
  li TESTNUM, 236
  li t0, 0x7fffffff
  li t1, 0x0001ffff
  sclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=17, with overflow
  li TESTNUM, 237
  li t0, 0x80000000
  li t1, 0xfffe0000
  sclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=17, without overflow
  li TESTNUM, 238
  li t0, 0x00010000
  li t1, 0x00010000
  sclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=17, without overflow
  li TESTNUM, 239
  li t0, 0xfffe0000
  li t1, 0xfffe0000
  sclip32 t2, t0, 17
  bne t2, t1, fail

  # imm=16, with overflow
  li TESTNUM, 240
  li t0, 0x7fffffff
  li t1, 0x0000ffff
  sclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=16, with overflow
  li TESTNUM, 241
  li t0, 0x80000000
  li t1, 0xffff0000
  sclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=16, without overflow
  li TESTNUM, 242
  li t0, 0x0000f000
  li t1, 0x0000f000
  sclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=16, without overflow
  li TESTNUM, 243
  li t0, 0xffff0000
  li t1, 0xffff0000
  sclip32 t2, t0, 16
  bne t2, t1, fail

  # imm=15, with overflow
  li TESTNUM, 244
  li t0, 0x7fffffff
  li t1, 0x00007fff
  sclip32 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, with overflow
  li TESTNUM, 245
  li t0, 0x80000000
  li t1, 0xffff8000
  sclip32 t2, t0, 15
  bne t2, t1, fail 

  # imm=15, without overflow
  li TESTNUM, 246
  li t0, 0x00007000
  li t1, 0x00007000
  sclip32 t2, t0, 15
  bne t2, t1, fail
 
  # imm=15, without overflow
  li TESTNUM, 247
  li t0, 0xffff8000
  li t1, 0xffff8000
  sclip32 t2, t0, 15
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 248
  li t0, 0x7fffffff
  li t1, 0x00003fff
  sclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=14, with overflow
  li TESTNUM, 249
  li t0, 0x80000000
  li t1, 0xffffc000
  sclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=14, without overflow
  li TESTNUM, 250
  li t0, 0xffffc000
  li t1, 0xffffc000
  sclip32 t2, t0, 14
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 251
  li t0, 0x7fffffff
  li t1, 0x00001fff
  sclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=13, with overflow
  li TESTNUM, 252
  li t0, 0x80000000
  li t1, 0xffffe000
  sclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=13, without overflow
  li TESTNUM, 253
  li t0, 0x00001000
  li t1, 0x00001000
  sclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=13, without overflow
  li TESTNUM, 254
  li t0, 0xffffe000
  li t1, 0xffffe000
  sclip32 t2, t0, 13
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 255
  li t0, 0x7fffffff
  li t1, 0x00000fff
  sclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=12, with overflow
  li TESTNUM, 256
  li t0, 0x80000000
  li t1, 0xfffff000
  sclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=12, without overflow
  li TESTNUM, 257
  li t0, 0x00000f00
  li t1, 0x00000f00
  sclip32 t2, t0, 12
  bne t2, t1, fail
 
  # imm=12, without overflow
  li TESTNUM, 258
  li t0, 0x80000000
  li t1, 0xfffff000
  sclip32 t2, t0, 12
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 259
  li t0, 0x7fffffff
  li t1, 0x000007ff
  sclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=11, with overflow
  li TESTNUM, 260
  li t0, 0x80000000
  li t1, 0xfffff800
  sclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=11, without overflow
  li TESTNUM, 261
  li t0, 0x00000700
  li t1, 0x00000700
  sclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=11, without overflow
  li TESTNUM, 262
  li t0, 0xfffff800
  li t1, 0xfffff800
  sclip32 t2, t0, 11
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 263
  li t0, 0x7fffffff
  li t1, 0x000003ff
  sclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=10, with overflow
  li TESTNUM, 264
  li t0, 0x80000000
  li t1, 0xfffffc00
  sclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=10, without overflow
  li TESTNUM, 265
  li t0, 0x00000300
  li t1, 0x00000300
  sclip32 t2, t0, 10
  bne t2, t1, fail
 
  # imm=10, without overflow
  li TESTNUM, 266
  li t0, 0xfffffc00
  li t1, 0xfffffc00
  sclip32 t2, t0, 10
  bne t2, t1, fail

  # imm=09, with overflow
  li TESTNUM, 267
  li t0, 0x7fffffff
  li t1, 0x000001ff
  sclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=09, with overflow
  li TESTNUM, 268
  li t0, 0x80000000
  li t1, 0xfffffe00
  sclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=09, without overflow
  li TESTNUM, 269
  li t0, 0x00000100
  li t1, 0x00000100
  sclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=09, without overflow
  li TESTNUM, 270
  li t0, 0xfffffe00
  li t1, 0xfffffe00
  sclip32 t2, t0, 9 
  bne t2, t1, fail

  # imm=08, with overflow
  li TESTNUM, 271
  li t0, 0x7fffffff
  li t1, 0x000000ff
  sclip32 t2, t0, 8 
  bne t2, t1, fail

  # imm=08, with overflow
  li TESTNUM, 272
  li t0, 0x80000000
  li t1, 0xffffff00
  sclip32 t2, t0, 8 
  bne t2, t1, fail

  # imm=08, without overflow
  li TESTNUM, 273
  li t0, 0x000000f0
  li t1, 0x000000f0
  sclip32 t2, t0, 8  
  bne t2, t1, fail

  # imm=08, without overflow
  li TESTNUM, 274
  li t0, 0xffffff00
  li t1, 0xffffff00
  sclip32 t2, t0, 8  
  bne t2, t1, fail

  # imm=07, with overflow
  li TESTNUM, 275
  li t0, 0x7fffffff
  li t1, 0x0000007f
  sclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=07, with overflow
  li TESTNUM, 276
  li t0, 0x80000000
  li t1, 0xffffff80
  sclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=07, without overflow
  li TESTNUM, 277
  li t0, 0x00000070
  li t1, 0x00000070
  sclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=07, without overflow
  li TESTNUM, 278
  li t0, 0xffffff80
  li t1, 0xffffff80
  sclip32 t2, t0, 7 
  bne t2, t1, fail

  # imm=06, with overflow
  li TESTNUM, 279
  li t0, 0x7fffffff
  li t1, 0x0000003f
  sclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=06, with overflow
  li TESTNUM, 280
  li t0, 0x80000000
  li t1, 0xffffffc0
  sclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=06, without overflow
  li TESTNUM, 281
  li t0, 0x00000030
  li t1, 0x00000030
  sclip32 t2, t0, 6 
  bne t2, t1, fail
 
  # imm=06, without overflow
  li TESTNUM, 282
  li t0, 0xffffffc0
  li t1, 0xffffffc0
  sclip32 t2, t0, 6 
  bne t2, t1, fail

  # imm=05, with overflow
  li TESTNUM, 283
  li t0, 0x7fffffff
  li t1, 0x0000001f
  sclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=05, with overflow
  li TESTNUM, 284
  li t0, 0x80000000
  li t1, 0xffffffe0
  sclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=05, without overflow
  li TESTNUM, 285
  li t0, 0x00000010
  li t1, 0x00000010
  sclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=05, without overflow
  li TESTNUM, 286
  li t0, 0xffffffe0
  li t1, 0xffffffe0
  sclip32 t2, t0, 5 
  bne t2, t1, fail

  # imm=04, with overflow
  li TESTNUM, 287
  li t0, 0x7fffffff
  li t1, 0x0000000f
  sclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=04, with overflow
  li TESTNUM, 288
  li t0, 0x80000000
  li t1, 0xfffffff0
  sclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=04, without overflow
  li TESTNUM, 289
  li t0, 0x00000007
  li t1, 0x00000007
  sclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=04, without overflow
  li TESTNUM, 290
  li t0, 0xfffffff0
  li t1, 0xfffffff0
  sclip32 t2, t0, 4 
  bne t2, t1, fail

  # imm=03, with overflow
  li TESTNUM, 291
  li t0, 0x7fffffff
  li t1, 0x00000007
  sclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=03, with overflow
  li TESTNUM, 292
  li t0, 0x80000000
  li t1, 0xfffffff8
  sclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=03, without overflow
  li TESTNUM, 293
  li t0, 0x00000006
  li t1, 0x00000006
  sclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=03, without overflow
  li TESTNUM, 294
  li t0, 0xfffffff8
  li t1, 0xfffffff8
  sclip32 t2, t0, 3 
  bne t2, t1, fail

  # imm=02, with overflow
  li TESTNUM, 295
  li t0, 0x7fffffff
  li t1, 0x00000003
  sclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=02, with overflow
  li TESTNUM, 296
  li t0, 0x80000000
  li t1, 0xfffffffc
  sclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=02, without overflow
  li TESTNUM, 297
  li t0, 0x00000002
  li t1, 0x00000002
  sclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=02, without overflow
  li TESTNUM, 298
  li t0, 0xfffffffc
  li t1, 0xfffffffc
  sclip32 t2, t0, 2 
  bne t2, t1, fail

  # imm=01, with overflow
  li TESTNUM, 299
  li t0, 0x7fffffff
  li t1, 0x00000001
  sclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=01, with overflow
  li TESTNUM, 300
  li t0, 0x80000000
  li t1, 0xfffffffe
  sclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=01, without overflow
  li TESTNUM, 301
  li t0, 0x00000000
  li t1, 0x00000000
  sclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=01, without overflow
  li TESTNUM, 302
  li t0, 0xfffffffe
  li t1, 0xfffffffe
  sclip32 t2, t0, 1 
  bne t2, t1, fail

  # imm=00, with overflow
  li TESTNUM, 303
  li t0, 0x7fffffff
  li t1, 0x00000000
  sclip32 t2, t0, 0 
  bne t2, t1, fail

  # imm=00, with overflow
  li TESTNUM, 304
  li t0, 0x80000000
  li t1, 0xffffffff
  sclip32 t2, t0, 0 
  bne t2, t1, fail

  # imm=00, without overflow
  li TESTNUM, 305
  li t0, 0x00000000
  li t1, 0x00000000
  sclip32 t2, t0, 0 
  bne t2, t1, fail

  # imm=00, without overflow
  li TESTNUM, 306
  li t0, 0xffffffff
  li t1, 0xffffffff
  sclip32 t2, t0, 0 
  bne t2, t1, fail

#endif 

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

