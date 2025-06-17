#-----------------------------------------------------------------------
# Tests for an instruction with vector-vector operands
#-----------------------------------------------------------------------
#include "riscv_test.h"
#undef RVTEST_RV64S
#define RVTEST_RV64S RVTEST_RV32M
#define __MACHINE_MODE

# See LICENSE for license details.
# Test illegal instruction trap.
#
#*****************************************************************************
# vsub.S
#-----------------------------------------------------------------------------
#
#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

#ifdef N600_CFG_HAS_VPU
#ifdef N600_CFG_VPU_ELEN_64
#ifndef N600_CFG_HAS_ONLY_VCAU

RVTEST_RV64U
RVTEST_CODE_BEGIN

.align 2
.option norvc

li TESTNUM, 2
  #-------------------------------------------------------------
  # Initialization
  #-------------------------------------------------------------

  #enable vpu
  li x1, 0x200
  csrs mstatus, x1

  li x11, 32
  vsetvli x10, x11, e32, m1
  li x0, 8
  li x0, 8
  li x0, 8
  li x0, 8
  vmv.v.i v0 , 0
  vmv.v.i v1 , 0
  vmv.v.i v2 , 0
  vmv.v.i v3 , 0
  vmv.v.i v4 , 0
  vmv.v.i v5 , 0
  vmv.v.i v6 , 0
  vmv.v.i v7 , 0
  vmv.v.i v8 , 0
  vmv.v.i v9 , 0
  vmv.v.i v10, 0
  vmv.v.i v11, 0
  vmv.v.i v12, 0
  vmv.v.i v13, 0
  vmv.v.i v14, 0
  vmv.v.i v15, 0
  vmv.v.i v16, 0
  vmv.v.i v17, 0
  vmv.v.i v18, 0
  vmv.v.i v19, 0
  vmv.v.i v20, 0
  vmv.v.i v21, 0
  vmv.v.i v22, 0
  vmv.v.i v23, 0
  vmv.v.i v24, 0
  vmv.v.i v25, 0
  vmv.v.i v26, 0
  vmv.v.i v27, 0
  vmv.v.i v28, 0
  vmv.v.i v29, 0
  vmv.v.i v30, 0
  vmv.v.i v31, 0

test_start:

#*****************************************************************************
# vsub.vv( testnum, inst, vl, sew, mul, result, val1, val2 );
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP8 tests  #----------------------------------------------------------------------
    TEST_VV_OP(sew8_2 , vsub.vv, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VV_OP(sew8_3 , vsub.vv, 16, 8, 1, 0x02, 0x03, 0x01 );
    TEST_VV_OP(sew8_4 , vsub.vv, 16, 8, 1, 0x02, 0x04, 0x02 );
    TEST_VV_OP(sew8_5 , vsub.vv, 16, 8, 1, 0x0f, 0x0f, 0x00 );
    TEST_VV_OP(sew8_6 , vsub.vv, 16, 8, 1, 0x80, 0x80, 0x00 );
li x12, 0x0000;
vmv.v.x v0 , x12;
    TEST_VVvm_OP(sew8_7 , vsub.vv, 16, 8, 1, 0x00, 0x01, 0x00 );
vmv.v.i v0 , 0x0001;
    TEST_VVvm_OP(sew8_8 , vsub.vv, 128, 8, 8, 0x00, 0x7f, 0x7f );
    TEST_VV_OP(sew8_9 , vsub.vv, 128, 8, 8, 0xff, 0xff, 0x00 );
    TEST_VV_OP(sew8_10, vsub.vv, 128, 8, 8, 0x00, 0xff, 0xff );

  #------------------------------------------------------------
  # TEST_VV_OP16 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew16_2 , vsub.vv, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VV_OP(sew16_3 , vsub.vv, 8, 16, 1, 0x0001, 0x0002, 0x0001 );
    TEST_VV_OP(sew16_4 , vsub.vv, 8, 16, 1, 0x0003, 0x000a, 0x0007 );
    TEST_VV_OP(sew16_5 , vsub.vv, 8, 16, 1, 0x0000, 0xff80, 0xff80 );
    TEST_VV_OP(sew16_6 , vsub.vv, 8, 16, 1, 0x8000, 0x8000, 0x0000 );
    TEST_VV_OP(sew16_7 , vsub.vv, 8, 16, 1, 0x8000, 0x8001, 0x0001 );
    TEST_VV_OP(sew16_8 , vsub.vv, 64, 16, 8, 0x0000, 0x7fff, 0x7fff );
    TEST_VV_OP(sew16_9 , vsub.vv, 64, 16, 8, 0xffff, 0xffff, 0x0000 );
    TEST_VV_OP(sew16_10, vsub.vv, 64, 16, 8, 0x8000, 0x807f, 0x007f );

  #------------------------------------------------------------
  # TEST_VV_OP32 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew32_2 , vsub.vv, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VV_OP(sew32_3 , vsub.vv, 4, 32, 1, 0x00000002, 0x00000003, 0x00000001 );
    TEST_VV_OP(sew32_4 , vsub.vv, 4, 32, 1, 0x00000003, 0x0000000a, 0x00000007 );
    TEST_VV_OP(sew32_5 , vsub.vv, 4, 32, 1, 0x00000000, 0xffff8000, 0xffff8000 );
    TEST_VV_OP(sew32_6 , vsub.vv, 4, 32, 1, 0x80000000, 0x80000000, 0x00000000 );
    TEST_VV_OP(sew32_7 , vsub.vv, 4, 32, 1, 0x80000000, 0x80000001, 0x00000001 );
    TEST_VV_OP(sew32_8 , vsub.vv, 32, 32, 8, 0xffffffff, 0xffffffff, 0x00000000 );
    TEST_VV_OP(sew32_9 , vsub.vv, 32, 32, 8, 0x7fffffff, 0x7fffffff, 0x00000000 );
    TEST_VV_OP(sew32_10, vsub.vv, 32, 32, 8, 0x00000001, 0xffffffff, 0xfffffffe );

  #------------------------------------------------------------
  # TEST_VV_OP64 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew64_2 , vsub.vv,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VV_OP(sew64_3 , vsub.vv,  2, 64, 1, 0x0000000000000002, 0x0000000000000003, 0x0000000000000001 );
    TEST_VV_OP(sew64_4 , vsub.vv,  2, 64, 1, 0x0000000000000003, 0x000000000000000a, 0x0000000000000007 );
    TEST_VV_OP(sew64_5 , vsub.vv,  2, 64, 1, 0x0000000000000000, 0xffffffffffff8000, 0xffffffffffff8000 );
    TEST_VV_OP(sew64_6 , vsub.vv,  2, 64, 1, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
    TEST_VV_OP(sew64_7 , vsub.vv,  2, 64, 1, 0xffffffff80000000, 0xffffffff80007fff,  0x0000000000007fff );
    TEST_VV_OP(sew64_8 , vsub.vv,  16, 64, 8, 0x0000000000000000, 0x0000000000007fff, 0x0000000000007fff );
    TEST_VV_OP(sew64_9 , vsub.vv,  16, 64, 8, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
    TEST_VV_OP(sew64_10, vsub.vv,  16, 64, 8, 0x0000000080000000, 0x0000000080007ffe, 0x0000000000007ffe );

#*****************************************************************************
# vsub.vx( testnum, inst, vl, sew, mul, result, val1, val2 );
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP8 tests  #----------------------------------------------------------------------
    TEST_VX_OP(sew8vx_2 , vsub.vx, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VX_OP(sew8vx_3 , vsub.vx, 16, 8, 1, 0x02, 0x03, 0x01 );
    TEST_VX_OP(sew8vx_4 , vsub.vx, 16, 8, 1, 0x02, 0x04, 0x02 );
    TEST_VX_OP(sew8vx_5 , vsub.vx, 16, 8, 1, 0x0f, 0x0f, 0x00 );
    TEST_VX_OP(sew8vx_6 , vsub.vx, 16, 8, 1, 0x80, 0x80, 0x00 );
    TEST_VX_OP(sew8vx_7 , vsub.vx, 16, 8, 1, 0x01, 0x01, 0x00 );
    TEST_VX_OP(sew8vx_8 , vsub.vx, 128, 8, 8, 0x00, 0x7f, 0x7f );
    TEST_VX_OP(sew8vx_9 , vsub.vx, 128, 8, 8, 0xff, 0xff, 0x00 );
    TEST_VX_OP(sew8vx_10, vsub.vx, 128, 8, 8, 0x00, 0xff, 0xff );

  #----------------------------------------------------------------------
  # TEST_VX_OP16 tests  #----------------------------------------------------------------------
    TEST_VX_OP(sew16vx_2 , vsub.vx, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VX_OP(sew16vx_3 , vsub.vx, 8, 16, 1, 0x0001, 0x0002, 0x0001 );
    TEST_VX_OP(sew16vx_4 , vsub.vx, 8, 16, 1, 0x0003, 0x000a, 0x0007 );
    TEST_VX_OP(sew16vx_5 , vsub.vx, 8, 16, 1, 0x0000, 0xff80, 0xff80 );
    TEST_VX_OP(sew16vx_6 , vsub.vx, 8, 16, 1, 0x8000, 0x8000, 0x0000 );
    li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VXvm_OP(sew16vx_7 , vsub.vx, 8, 16, 1, 0x0000, 0x8001, 0x0001 );
    vmv.v.i v0 , 0x0001;
    TEST_VXvm_OP(sew16vx_8 , vsub.vx, 64, 16, 8, 0x0000, 0x7fff, 0x7fff );
    TEST_VX_OP(sew16vx_9 , vsub.vx, 64, 16, 8, 0xffff, 0xffff, 0x0000 );
    TEST_VX_OP(sew16vx_10, vsub.vx, 64, 16, 8, 0x8000, 0x807f, 0x007f );

  #----------------------------------------------------------------------
  # TEST_VX_OP32 tests  #----------------------------------------------------------------------
    TEST_VX_OP(sew32vx_2 , vsub.vx, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VX_OP(sew32vx_3 , vsub.vx, 4, 32, 1, 0x00000002, 0x00000003, 0x00000001 );
    TEST_VX_OP(sew32vx_4 , vsub.vx, 4, 32, 1, 0x00000003, 0x0000000a, 0x00000007 );
    TEST_VX_OP(sew32vx_5 , vsub.vx, 4, 32, 1, 0x00000000, 0xffff8000, 0xffff8000 );
    TEST_VX_OP(sew32vx_6 , vsub.vx, 4, 32, 1, 0x80000000, 0x80000000, 0x00000000 );
    TEST_VX_OP(sew32vx_7 , vsub.vx, 4, 32, 1, 0x80000000, 0x80000001, 0x00000001 );
    TEST_VX_OP(sew32vx_8 , vsub.vx, 32, 32, 8, 0xffffffff, 0xffffffff, 0x00000000 );
    TEST_VX_OP(sew32vx_9 , vsub.vx, 32, 32, 8, 0x7fffffff, 0x7fffffff, 0x00000000 );
    TEST_VX_OP(sew32vx_10, vsub.vx, 32, 32, 8, 0x00000001, 0xffffffff, 0xfffffffe );

  #----------------------------------------------------------------------
  # TEST_VX_OP64 tests
  #----------------------------------------------------------------------
    TEST_VX_OP(sew64vx_2 , vsub.vx,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_3 , vsub.vx,  2, 64, 1, 0x0000000000000002, 0x0000000000000003, 0x0000000000000001 );
    TEST_VX_OP(sew64vx_4 , vsub.vx,  2, 64, 1, 0x0000000000000003, 0x000000000000000a, 0x0000000000000007 );
    TEST_VX_OP(sew64vx_5 , vsub.vx,  2, 64, 1, 0x0000000000000000, 0xffffffffffff8000, 0xffffffffffff8000 );
    TEST_VX_OP(sew64vx_6 , vsub.vx,  2, 64, 1, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_7 , vsub.vx,  2, 64, 1, 0xffffffff80000000, 0xffffffff80007fff,  0x0000000000007fff );
    TEST_VX_OP(sew64vx_8 , vsub.vx,  16, 64, 8, 0x0000000000000000, 0x0000000000007fff, 0x0000000000007fff );
    TEST_VX_OP(sew64vx_9 , vsub.vx,  16, 64, 8, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_10, vsub.vx,  16, 64, 8, 0x0000000080000000, 0x0000000080007ffe, 0x0000000000007ffe );


#*****************************************************************************
# vrsub.vx( testnum, inst, vl, sew, mul, result, val2, val1 );
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP8RVX tests
  #----------------------------------------------------------------------
    TEST_VX_OP(sew8rvx_2 , vrsub.vx, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VX_OP(sew8rvx_3 , vrsub.vx, 16, 8, 1, 0x02, 0x01, 0x03 );
    TEST_VX_OP(sew8rvx_4 , vrsub.vx, 16, 8, 1, 0x02, 0x02, 0x04 );
    TEST_VX_OP(sew8rvx_5 , vrsub.vx, 16, 8, 1, 0x0f, 0x00, 0x0f );
    TEST_VX_OP(sew8rvx_6 , vrsub.vx, 16, 8, 1, 0x80, 0x00, 0x80 );
    TEST_VX_OP(sew8rvx_7 , vrsub.vx, 16, 8, 1, 0x01, 0x00, 0x01 );
    TEST_VX_OP(sew8rvx_8 , vrsub.vx, 128, 8, 8, 0x00, 0x7f, 0x7f );
    TEST_VX_OP(sew8rvx_9 , vrsub.vx, 128, 8, 8, 0xff, 0x00, 0xff );
    TEST_VX_OP(sew8rvx_10, vrsub.vx, 128, 8, 8, 0x00, 0xff, 0xff );

  #----------------------------------------------------------------------
  # TEST_VX_OP16RVX tests
  #----------------------------------------------------------------------
    TEST_VX_OP(sew16rvx_2 , vrsub.vx, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VX_OP(sew16rvx_3 , vrsub.vx, 8, 16, 1, 0x0002, 0x0001, 0x0003 );
    TEST_VX_OP(sew16rvx_4 , vrsub.vx, 8, 16, 1, 0x0003, 0x0007, 0x000a );
    TEST_VX_OP(sew16rvx_5 , vrsub.vx, 8, 16, 1, 0x0000, 0xff80, 0xff80 );
    TEST_VX_OP(sew16rvx_6 , vrsub.vx, 8, 16, 1, 0x8000, 0x0000, 0x8000 );
    TEST_VX_OP(sew16rvx_7 , vrsub.vx, 8, 16, 1, 0x0001, 0x0000, 0x0001 );
    TEST_VX_OP(sew16rvx_8 , vrsub.vx, 64, 16, 8, 0x0000, 0x7fff, 0x7fff );
    TEST_VX_OP(sew16rvx_9 , vrsub.vx, 64, 16, 8, 0xffff, 0x0000, 0xffff );
    TEST_VX_OP(sew16rvx_10, vrsub.vx, 64, 16, 8, 0x0000, 0x007f, 0x007f );

  #----------------------------------------------------------------------
  # TEST_VX_OP32RVX tests
  #------------------------------------------------------------------------
    TEST_VX_OP(sew32rvx_2 , vrsub.vx, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VX_OP(sew32rvx_3 , vrsub.vx, 4, 32, 1, 0x00000002, 0x00000001, 0x00000003 );
    TEST_VX_OP(sew32rvx_4 , vrsub.vx, 4, 32, 1, 0x00000003, 0x00000007, 0x0000000a );
    TEST_VX_OP(sew32rvx_5 , vrsub.vx, 4, 32, 1, 0x00000000, 0xffff8000, 0xffff8000 );
    TEST_VX_OP(sew32rvx_6 , vrsub.vx, 4, 32, 1, 0x80000000, 0x00000000, 0x80000000 );
    li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VXvm_OP(sew32rvx_7 , vrsub.vx, 4, 32, 1, 0x00000000, 0x00000000, 0x00000001 );
    vmv.v.i v0 , 0x0001;
    TEST_VXvm_OP(sew32rvx_8 , vrsub.vx, 32, 32, 8, 0xffffffff, 0x00000000, 0xffffffff );
    TEST_VX_OP(sew32rvx_9 , vrsub.vx, 32, 32, 8, 0x7fffffff, 0x00000000, 0x7fffffff );
    TEST_VX_OP(sew32rvx_10, vrsub.vx, 32, 32, 8, 0x00000000, 0xfffffffe, 0xfffffffe );

  #----------------------------------------------------------------------
  # TEST_VX_OP64RVX tests
  #----------------------------------------------------------------------
    TEST_VX_OP(sew64rvx_2 , vrsub.vx,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VX_OP(sew64rvx_3 , vrsub.vx,  2, 64, 1, 0x0000000000000002, 0x0000000000000001, 0x0000000000000003 );
    TEST_VX_OP(sew64rvx_4 , vrsub.vx,  2, 64, 1, 0x0000000000000003, 0x0000000000000007, 0x000000000000000a );
    TEST_VX_OP(sew64rvx_5 , vrsub.vx,  2, 64, 1, 0x0000000000000000, 0xffffffff80000000, 0xffffffff80000000 );
    TEST_VX_OP(sew64rvx_6 , vrsub.vx,  2, 64, 1, 0xffffffff80000000, 0x0000000000000000, 0xffffffff80000000 );
    TEST_VX_OP(sew64rvx_7 , vrsub.vx,  2, 64, 1, 0xffffffff80000000, 0x0000000000000000, 0xffffffff80000000 );
    TEST_VX_OP(sew64rvx_8 , vrsub.vx,  16, 64, 8, 0x0000000000000000, 0x0000000000007fff, 0x0000000000007fff );
    TEST_VX_OP(sew64rvx_9 , vrsub.vx,  16, 64, 8, 0x000000007fffffff, 0x0000000000000000, 0x000000007fffffff );
    TEST_VX_OP(sew64rvx_10, vrsub.vx,  16, 64, 8, 0x0000000000000000, 0x0000000000007ffe, 0x0000000000007ffe );

#*****************************************************************************
# vrsub.vi( testnum, inst, vl, sew, mul, result, val1, imm );
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VI_OP8RVI tests
  #----------------------------------------------------------------------
    TEST_VI_OP(sew8rvi_2 , vrsub.vi, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VI_OP(sew8rvi_3 , vrsub.vi, 16, 8, 1, 0x02, 0x01, 0x03 );
    TEST_VI_OP(sew8rvi_4 , vrsub.vi, 16, 8, 1, 0x03, 0x07, 0x0a );
    TEST_VI_OP(sew8rvi_5 , vrsub.vi, 16, 8, 1, 0x0a, 0x01, 0x0b );
    TEST_VI_OP(sew8rvi_6 , vrsub.vi, 16, 8, 1, 0x01, 0x00, 0x01 );
    TEST_VI_OP(sew8rvi_7 , vrsub.vi, 16, 8, 1, 0x00, 0x01, 0x01 );
    TEST_VI_OP(sew8rvi_8 , vrsub.vi, 128, 8, 8, 0x08, 0x07, 0x0f );
    TEST_VI_OP(sew8rvi_9 , vrsub.vi, 128, 8, 8, 0x0a, 0x05, 0x0f );
    TEST_VI_OP(sew8rvi_10, vrsub.vi, 128, 8, 8, 0x05, 0x0a, 0x0f );

  #----------------------------------------------------------------------
  # TEST_VI_OP16RVI tests
  #----------------------------------------------------------------------
    TEST_VI_OP(sew16rvi_2 , vrsub.vi, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VI_OP(sew16rvi_3 , vrsub.vi, 8, 16, 1, 0x0002, 0x0001, 0x0003 );
    TEST_VI_OP(sew16rvi_4 , vrsub.vi, 8, 16, 1, 0x0003, 0x0007, 0x000a );
    TEST_VI_OP(sew16rvi_5 , vrsub.vi, 8, 16, 1, 0x000a, 0x0001, 0x000b );
    TEST_VI_OP(sew16rvi_6 , vrsub.vi, 8, 16, 1, 0x0001, 0x0000, 0x0001 );
    TEST_VI_OP(sew16rvi_7 , vrsub.vi, 8, 16, 1, 0x0000, 0x0001, 0x0001 );
    TEST_VI_OP(sew16rvi_8 , vrsub.vi, 64, 16, 8, 0x0008, 0x0007, 0x000f );
    TEST_VI_OP(sew16rvi_9 , vrsub.vi, 64, 16, 8, 0x000a, 0x0005, 0x000f );
    TEST_VI_OP(sew16rvi_10, vrsub.vi, 64, 16, 8, 0x0005, 0x000a, 0x000f );

  #----------------------------------------------------------------------
  # TEST_VI_OP32RVI tests
  #------------------------------------------------------------------------
    TEST_VI_OP(sew32rvi_2 , vrsub.vi, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VI_OP(sew32rvi_3 , vrsub.vi, 4, 32, 1, 0x00000002, 0x00000001, 0x00000003 );
    TEST_VI_OP(sew32rvi_4 , vrsub.vi, 4, 32, 1, 0x00000003, 0x00000007, 0x0000000a );
    TEST_VI_OP(sew32rvi_5 , vrsub.vi, 4, 32, 1, 0x0000000a, 0x00000001, 0x0000000b );
    TEST_VI_OP(sew32rvi_6 , vrsub.vi, 4, 32, 1, 0x00000001, 0x00000000, 0x00000001 );
    TEST_VI_OP(sew32rvi_7 , vrsub.vi, 4, 32, 1, 0x00000000, 0x00000001, 0x00000001 );
    TEST_VI_OP(sew32rvi_8 , vrsub.vi, 32, 32, 8, 0x00000008, 0x00000007, 0x0000000f );
    TEST_VI_OP(sew32rvi_9 , vrsub.vi, 32, 32, 8, 0x0000000a, 0x00000005, 0x0000000f );
    TEST_VI_OP(sew32rvi_10, vrsub.vi, 32, 32, 8, 0x00000005, 0x0000000a, 0x0000000f );

  #----------------------------------------------------------------------
  # TEST_VI_OP64RVI tests
  #----------------------------------------------------------------------
    TEST_VI_OP(sew64rvi_2 , vrsub.vi,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VI_OP(sew64rvi_3 , vrsub.vi,  2, 64, 1, 0x0000000000000002, 0x0000000000000001, 0x0000000000000003 );
    TEST_VI_OP(sew64rvi_4 , vrsub.vi,  2, 64, 1, 0x0000000000000003, 0x0000000000000007, 0x000000000000000a );
    TEST_VI_OP(sew64rvi_5 , vrsub.vi,  2, 64, 1, 0x000000000000000a, 0x0000000000000001, 0x000000000000000b );

li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VIvm_OP(sew64rvi_6 , vrsub.vi,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001 );
    TEST_VI_OP(sew64rvi_7 , vrsub.vi,  2, 64, 1, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
    vmv.v.i v0 , 0x0001;
    TEST_VIvm_OP(sew64rvi_8 , vrsub.vi,  16, 64, 8, 0x0000000000000008, 0x0000000000000007, 0x000000000000000f );
    TEST_VI_OP(sew64rvi_9 , vrsub.vi,  16, 64, 8, 0x000000000000000a, 0x0000000000000005, 0x000000000000000f );
    TEST_VI_OP(sew64rvi_10, vrsub.vi,  16, 64, 8, 0x0000000000000005, 0x000000000000000a, 0x000000000000000f );


 TEST_PASSFAIL
.align 8

illegal_instruction_handler_pit:
        csrr a0, mbadaddr
        lw ra, 18*4(sp)
        lw t6, 17*4(sp)
        lw t5, 16*4(sp)
        lw t4, 15*4(sp)
        lw t3, 14*4(sp)
        lw t2, 13*4(sp)
        lw t1, 12*4(sp)
        lw t0, 11*4(sp)
        lw a7, 10*4(sp)
        lw a6, 9*4(sp)
        lw a5, 8*4(sp)
        lw a4, 7*4(sp)
        lw a3, 6*4(sp)
        lw a1, 4*4(sp)
        lw a0, 3*4(sp)
        csrw mcause, a1
        addi a0,a0,0x08
        csrw mepc, a0
        lw a0, 1*4(sp)
        lw a1, 0*4(sp)
        addi sp, sp, 20*4
        mret

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
.align 2
.option norvc
#endif
#endif
#endif 

#if (!defined N600_CFG_HAS_VPU) || (!defined N600_CFG_VPU_ELEN_64) || (defined N600_CFG_HAS_ONLY_VCAU)
RVTEST_RV64M
RVTEST_CODE_BEGIN

j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END

#endif
