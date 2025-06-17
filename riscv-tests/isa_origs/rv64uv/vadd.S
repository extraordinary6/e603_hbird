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
# vadd.S
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
# vadd.vv
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP8 tests( testnum, inst, vl, sew, mul, result, val1, val2(,v0.t));
  #----------------------------------------------------------------------
    li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VVvm_OP(sew8_13, vadd.vv, 16, 8, 1, 0x00, 0x00, 0xff);

    vmv.v.i v0 , 0x0001;
    TEST_VVvm_OP(sew8_16, vadd.vv, 128, 8, 8, 0x80, 0x01, 0x7f);

    TEST_VV_OP(sew8_2 , vadd.vv, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VV_OP(sew8_3 , vadd.vv, 16, 8, 1, 0x03, 0x02, 0x01 );
    TEST_VV_OP(sew8_4 , vadd.vv, 16, 8, 1, 0x04, 0x02, 0x02 );
    TEST_VV_OP(sew8_5 , vadd.vv, 16, 8, 1, 0x0f, 0x0f, 0x00 );
    TEST_VV_OP(sew8_6 , vadd.vv, 16, 8, 1, 0x80, 0x80, 0x00 );
    TEST_VV_OP(sew8_7 , vadd.vv, 16, 8, 1, 0x7f, 0x80, 0xff );
    TEST_VV_OP(sew8_8 , vadd.vv, 16, 8, 1, 0x7f, 0x00, 0x7f );
    TEST_VV_OP(sew8_9 , vadd.vv, 16, 8, 1, 0xff, 0xff, 0x00 );
    TEST_VV_OP(sew8_10, vadd.vv, 16, 8, 1, 0x7e, 0xff, 0x7f );
    TEST_VV_OP(sew8_11, vadd.vv, 16, 8, 1, 0xff, 0x80, 0x7f );
    TEST_VV_OP(sew8_12, vadd.vv, 16, 8, 1, 0x7e, 0x7f, 0xff );
    TEST_VV_OP(sew8_14, vadd.vv, 128, 8, 8, 0x00, 0xff, 0x01 );
    TEST_VV_OP(sew8_15, vadd.vv, 128, 8, 8, 0xfe, 0xff, 0xff );

  #------------------------------------------------------------
  # TEST_VV_OP16 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew16_2 , vadd.vv, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VV_OP(sew16_3 , vadd.vv, 8, 16, 1, 0x0002, 0x0001, 0x0001 );
    TEST_VV_OP(sew16_4 , vadd.vv, 8, 16, 1, 0x000a, 0x0003, 0x0007 );
    TEST_VV_OP(sew16_5 , vadd.vv, 8, 16, 1, 0xff80, 0x0000, 0xff80 );
    TEST_VV_OP(sew16_6 , vadd.vv, 8, 16, 1, 0x8000, 0x8000, 0x0000 );
    TEST_VV_OP(sew16_8 , vadd.vv, 8, 16, 1, 0x7fff, 0x0000, 0x7fff );
    TEST_VV_OP(sew16_9 , vadd.vv, 8, 16, 1, 0xffff, 0xffff, 0x0000 );
    TEST_VV_OP(sew16_10, vadd.vv, 8, 16, 1, 0x807f, 0x8000, 0x007f );
    TEST_VV_OP(sew16_11, vadd.vv, 8, 16, 1, 0xffff, 0x0000, 0xffff );
    TEST_VV_OP(sew16_12, vadd.vv, 8, 16, 1, 0x8000, 0x0001, 0x7fff );
    TEST_VV_OP(sew16_13, vadd.vv, 8, 16, 1, 0x7fff, 0x8000, 0xffff );
    TEST_VV_OP(sew16_14, vadd.vv, 8, 16, 1, 0x7ffe, 0xffff, 0x7fff );
    TEST_VV_OP(sew16_15, vadd.vv, 64, 16, 8, 0x7ffe, 0x7fff, 0xffff );
    TEST_VV_OP(sew16_16, vadd.vv, 64, 16, 8, 0x0000, 0xffff, 0x0001 );
    TEST_VV_OP(sew16_17, vadd.vv, 64, 16, 8, 0xfffe, 0xffff, 0xffff );

  #------------------------------------------------------------
  # TEST_VV_OP32 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew32_2 , vadd.vv, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VV_OP(sew32_3 , vadd.vv, 4, 32, 1, 0x00000002, 0x00000001, 0x00000001 );
    TEST_VV_OP(sew32_4 , vadd.vv, 4, 32, 1, 0x0000000a, 0x00000003, 0x00000007 );
    TEST_VV_OP(sew32_5 , vadd.vv, 4, 32, 1, 0xffff8000, 0x00000000, 0xffff8000 );
    TEST_VV_OP(sew32_6 , vadd.vv, 4, 32, 1, 0x80000000, 0x80000000, 0x00000000 );
    TEST_VV_OP(sew32_8 , vadd.vv, 4, 32, 1, 0x00007fff, 0x00000000, 0x00007fff );
    TEST_VV_OP(sew32_9 , vadd.vv, 4, 32, 1, 0x7fffffff, 0x7fffffff, 0x00000000 );
    TEST_VV_OP(sew32_10 , vadd.vv, 4, 32, 1, 0x80007ffe, 0x7fffffff, 0x00007fff );
    TEST_VV_OP(sew32_11 , vadd.vv, 4, 32, 1, 0x80007fff, 0x80000000, 0x00007fff );
    TEST_VV_OP(sew32_12 , vadd.vv, 4, 32, 1, 0xffffffff, 0x00000000, 0xffffffff );
    TEST_VV_OP(sew32_13 , vadd.vv, 4, 32, 1, 0x80000000, 0x00000001, 0x7fffffff );
    TEST_VV_OP(sew32_14 , vadd.vv, 4, 32, 1, 0x7fff8000, 0x80000000, 0xffff8000 );
    TEST_VV_OP(sew32_15 , vadd.vv, 32, 32, 8, 0x7fff7fff, 0x7fffffff, 0xffff8000 );
    TEST_VV_OP(sew32_16 , vadd.vv, 32, 32, 8, 0x00000000, 0xffffffff, 0x00000001 );
    TEST_VV_OP(sew32_17 , vadd.vv, 32, 32, 8, 0xfffffffe, 0xffffffff, 0xffffffff );

  #------------------------------------------------------------
  # TEST_VV_OP64 tests
  #-------------------------------------------------------------
    TEST_VV_OP(sew64_2 , vadd.vv,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VV_OP(sew64_3 , vadd.vv,  2, 64, 1, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
    TEST_VV_OP(sew64_4 , vadd.vv,  2, 64, 1, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );
    TEST_VV_OP(sew64_5 , vadd.vv,  2, 64, 1, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
    TEST_VV_OP(sew64_6 , vadd.vv,  2, 64, 1, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
    TEST_VV_OP(sew64_8 , vadd.vv,  2, 64, 1, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
    TEST_VV_OP(sew64_9 , vadd.vv,  2, 64, 1, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
    TEST_VV_OP(sew64_10, vadd.vv,  2, 64, 1, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );
    TEST_VV_OP(sew64_11, vadd.vv,  2, 64, 1, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
    TEST_VV_OP(sew64_12, vadd.vv,  2, 64, 1, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
    TEST_VV_OP(sew64_13, vadd.vv,  2, 64, 1, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
    TEST_VV_OP(sew64_14, vadd.vv,  2, 64, 1, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
    TEST_VV_OP(sew64_15, vadd.vv,  16, 64, 8, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );
    TEST_VV_OP(sew64_16, vadd.vv,  16, 64, 8, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );
    TEST_VV_OP(sew64_17, vadd.vv,  16, 64, 8, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );



#*****************************************************************************
# vadd.vx
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP(sew8vx_2 , vadd.vx, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VX_OP(sew8vx_3 , vadd.vx, 16, 8, 1, 0x03, 0x02, 0x01 );
    TEST_VX_OP(sew8vx_4 , vadd.vx, 16, 8, 1, 0x04, 0x02, 0x02 );
    TEST_VX_OP(sew8vx_5 , vadd.vx, 16, 8, 1, 0x0f, 0x0f, 0x00 );
    TEST_VX_OP(sew8vx_6 , vadd.vx, 16, 8, 1, 0x80, 0x80, 0x00 );
    TEST_VX_OP(sew8vx_7 , vadd.vx, 16, 8, 1, 0x7f, 0x80, 0xff );
    TEST_VX_OP(sew8vx_8 , vadd.vx, 16, 8, 1, 0x7f, 0x00, 0x7f );
    TEST_VX_OP(sew8vx_9 , vadd.vx, 16, 8, 1, 0xff, 0xff, 0x00 );
    TEST_VX_OP(sew8vx_10, vadd.vx, 16, 8, 1, 0x7e, 0xff, 0x7f );
    TEST_VX_OP(sew8vx_11, vadd.vx, 16, 8, 1, 0xff, 0x80, 0x7f );
    TEST_VX_OP(sew8vx_12, vadd.vx, 16, 8, 1, 0x7e, 0x7f, 0xff );
    TEST_VX_OP(sew8vx_13, vadd.vx, 16, 8, 1, 0xff, 0x00, 0xff );
    TEST_VX_OP(sew8vx_14, vadd.vx, 128, 8, 8, 0x00, 0xff, 0x01 );
    TEST_VX_OP(sew8vx_15, vadd.vx, 128, 8, 8, 0xfe, 0xff, 0xff );
    TEST_VX_OP(sew8vx_16, vadd.vx, 128, 8, 8, 0x80, 0x01, 0x7f );

  #----------------------------------------------------------------------
  # TEST_VX_OP16 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VXvm_OP(sew16vx_2 , vadd.vx, 8, 16, 1, 0x0000, 0x8000, 0x007f );

    vmv.v.i v0 , 0x0001;
    TEST_VXvm_OP(sew16vx_3 , vadd.vx, 8, 16, 1, 0x0002, 0x0001, 0x0001 );

    TEST_VX_OP(sew16vx_4 , vadd.vx, 8, 16, 1, 0x000a, 0x0003, 0x0007 );
    TEST_VX_OP(sew16vx_5 , vadd.vx, 8, 16, 1, 0xff80, 0x0000, 0xff80 );
    TEST_VX_OP(sew16vx_6 , vadd.vx, 8, 16, 1, 0x8000, 0x8000, 0x0000 );
    TEST_VX_OP(sew16vx_8 , vadd.vx, 8, 16, 1, 0x7fff, 0x0000, 0x7fff );
    TEST_VX_OP(sew16vx_9 , vadd.vx, 8, 16, 1, 0xffff, 0xffff, 0x0000 );
    TEST_VX_OP(sew16vx_10, vadd.vx, 8, 16, 1, 0x807f, 0x8000, 0x007f );
    TEST_VX_OP(sew16vx_11, vadd.vx, 8, 16, 1, 0xffff, 0x0000, 0xffff );
    TEST_VX_OP(sew16vx_12, vadd.vx, 8, 16, 1, 0x8000, 0x0001, 0x7fff );
    TEST_VX_OP(sew16vx_13, vadd.vx, 8, 16, 1, 0x7fff, 0x8000, 0xffff );
    TEST_VX_OP(sew16vx_14, vadd.vx, 8, 16, 1, 0x7ffe, 0xffff, 0x7fff );
    TEST_VX_OP(sew16vx_15, vadd.vx, 64, 16, 8, 0x7ffe, 0x7fff, 0xffff );
    TEST_VX_OP(sew16vx_16, vadd.vx, 64, 16, 8, 0x0000, 0xffff, 0x0001 );
    TEST_VX_OP(sew16vx_17, vadd.vx, 64, 16, 8, 0xfffe, 0xffff, 0xffff );

  #----------------------------------------------------------------------
  # TEST_VX_OP32 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP(sew32vx_2 , vadd.vx, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VX_OP(sew32vx_3 , vadd.vx, 4, 32, 1, 0x00000002, 0x00000001, 0x00000001 );
    TEST_VX_OP(sew32vx_4 , vadd.vx, 4, 32, 1, 0x0000000a, 0x00000003, 0x00000007 );
    TEST_VX_OP(sew32vx_5 , vadd.vx, 4, 32, 1, 0xffff8000, 0x00000000, 0xffff8000 );
    TEST_VX_OP(sew32vx_6 , vadd.vx, 4, 32, 1, 0x80000000, 0x80000000, 0x00000000 );
    TEST_VX_OP(sew32vx_8 , vadd.vx, 4, 32, 1, 0x00007fff, 0x00000000, 0x00007fff );
    TEST_VX_OP(sew32vx_9 , vadd.vx, 4, 32, 1, 0x7fffffff, 0x7fffffff, 0x00000000 );
    TEST_VX_OP(sew32vx_10, vadd.vx, 4, 32, 1, 0x80007ffe, 0x7fffffff, 0x00007fff );
    TEST_VX_OP(sew32vx_11, vadd.vx, 4, 32, 1, 0x80007fff, 0x80000000, 0x00007fff );
    TEST_VX_OP(sew32vx_12, vadd.vx, 4, 32, 1, 0xffffffff, 0x00000000, 0xffffffff );
    TEST_VX_OP(sew32vx_13, vadd.vx, 4, 32, 1, 0x80000000, 0x00000001, 0x7fffffff );
    TEST_VX_OP(sew32vx_14, vadd.vx, 4, 32, 1, 0x7fff8000, 0x80000000, 0xffff8000 );
    TEST_VX_OP(sew32vx_15, vadd.vx, 32, 32, 8, 0x7fff7fff, 0x7fffffff, 0xffff8000 );
    TEST_VX_OP(sew32vx_16, vadd.vx, 32, 32, 8, 0x00000000, 0xffffffff, 0x00000001 );
    TEST_VX_OP(sew32vx_17, vadd.vx, 32, 32, 8, 0xfffffffe, 0xffffffff, 0xffffffff );

  #----------------------------------------------------------------------
  # TEST_VX_OP64 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP(sew64vx_2 , vadd.vx,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_3 , vadd.vx,  2, 64, 1, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
    TEST_VX_OP(sew64vx_4 , vadd.vx,  2, 64, 1, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );
    TEST_VX_OP(sew64vx_5 , vadd.vx,  2, 64, 1, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
    TEST_VX_OP(sew64vx_6 , vadd.vx,  2, 64, 1, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_8 , vadd.vx,  2, 64, 1, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
    TEST_VX_OP(sew64vx_9 , vadd.vx,  2, 64, 1, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
    TEST_VX_OP(sew64vx_10, vadd.vx,  2, 64, 1, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );
    TEST_VX_OP(sew64vx_11, vadd.vx,  2, 64, 1, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
    TEST_VX_OP(sew64vx_12, vadd.vx,  2, 64, 1, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
    TEST_VX_OP(sew64vx_13, vadd.vx,  2, 64, 1, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
    TEST_VX_OP(sew64vx_14, vadd.vx,  2, 64, 1, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
    TEST_VX_OP(sew64vx_15, vadd.vx,  16, 64, 8, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );
    TEST_VX_OP(sew64vx_16, vadd.vx,  16, 64, 8, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );
    TEST_VX_OP(sew64vx_17, vadd.vx,  16, 64, 8, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );



#*****************************************************************************
# vadd.vi
#-----------------------------------------------------------------------------
 #----------------------------------------------------------------------
  # TEST_VI_OP8 tests( testnum, inst, vl, sew, mul, result, val1, imm );
  #----------------------------------------------------------------------
    TEST_VI_OP(sew8vi_2 , vadd.vi, 16, 8, 1, 0x00, 0x00, 0x00 );
    TEST_VI_OP(sew8vi_3 , vadd.vi, 16, 8, 1, 0x03, 0x02, 0x01 );
    TEST_VI_OP(sew8vi_4 , vadd.vi, 16, 8, 1, 0x04, 0x02, 0x02 );
    TEST_VI_OP(sew8vi_5 , vadd.vi, 16, 8, 1, 0x0f, 0x0f, 0x00 );
    TEST_VI_OP(sew8vi_6 , vadd.vi, 16, 8, 1, 0x80, 0x80, 0x00 );
    TEST_VI_OP(sew8vi_7 , vadd.vi, 16, 8, 1, 0x80, 0x7f, 0x01 );
    TEST_VI_OP(sew8vi_8 , vadd.vi, 128, 8, 8, 0x7f, 0x7f, 0x00 );
    TEST_VI_OP(sew8vi_9 , vadd.vi, 128, 8, 8, 0xff, 0xff, 0x00 );
    TEST_VI_OP(sew8vi_10, vadd.vi, 128, 8, 8, 0x00, 0xff, 0x01 );


  #----------------------------------------------------------------------
  # TEST_VI_OP16 tests( testnum, inst, vl, sew, mul, result, val1, imm );
  #----------------------------------------------------------------------
    TEST_VI_OP(sew16vi_2 , vadd.vi, 8, 16, 1, 0x0000, 0x0000, 0x0000 );
    TEST_VI_OP(sew16vi_3 , vadd.vi, 8, 16, 1, 0x0002, 0x0001, 0x0001 );
    TEST_VI_OP(sew16vi_4 , vadd.vi, 8, 16, 1, 0x000a, 0x0003, 0x0007 );
    TEST_VI_OP(sew16vi_5 , vadd.vi, 8, 16, 1, 0xff80, 0xff80, 0x0000 );
    TEST_VI_OP(sew16vi_6 , vadd.vi, 8, 16, 1, 0x8000, 0x8000, 0x0000 );
    TEST_VI_OP(sew16vi_8 , vadd.vi, 8, 16, 1, 0x7fff, 0x7fff, 0x0000 );
    TEST_VI_OP(sew16vi_9 , vadd.vi, 64, 16, 8, 0xffff, 0xffff, 0x0000 );
    TEST_VI_OP(sew16vi_10, vadd.vi, 64, 16, 8, 0x0000, 0xffff, 0x0001 );
    TEST_VI_OP(sew16vi_11, vadd.vi, 64, 16, 8, 0x8000, 0x7fff, 0x0001 );

  #----------------------------------------------------------------------
  # TEST_VI_OP32 tests( testnum, inst, vl, sew, mul, result, val1, imm );
  #----------------------------------------------------------------------
    TEST_VI_OP(sew32vi_2 , vadd.vi, 4, 32, 1, 0x00000000, 0x00000000, 0x00000000 );
    TEST_VI_OP(sew32vi_3 , vadd.vi, 4, 32, 1, 0x00000002, 0x00000001, 0x00000001 );
    TEST_VI_OP(sew32vi_4 , vadd.vi, 4, 32, 1, 0x0000000a, 0x00000003, 0x00000007 );
    TEST_VI_OP(sew32vi_5 , vadd.vi, 4, 32, 1, 0xffff8000, 0xffff8000, 0x00000000 );
    TEST_VI_OP(sew32vi_6 , vadd.vi, 4, 32, 1, 0x80000000, 0x80000000, 0x00000000 );
    TEST_VI_OP(sew32vi_8 , vadd.vi, 32, 32, 8, 0x00007fff, 0x00007fff, 0x00000000 );
    TEST_VI_OP(sew32vi_9 , vadd.vi, 32, 32, 8, 0x7fffffff, 0x7fffffff, 0x00000000 );
    TEST_VI_OP(sew32vi_10, vadd.vi, 32, 32, 8, 0x00000000, 0xffffffff, 0x00000001 );

  #----------------------------------------------------------------------
  # TEST_VI_OP64 tests( testnum, inst, vl, sew, mul, result, val1, imm );
  #----------------------------------------------------------------------
    TEST_VI_OP(sew64vi_2 , vadd.vi,  2, 64, 1, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
    TEST_VI_OP(sew64vi_3 , vadd.vi,  2, 64, 1, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
    TEST_VI_OP(sew64vi_4 , vadd.vi,  2, 64, 1, 0x000000000000000a, 0x0000000000000003, 0x0000000000000007 );
    TEST_VI_OP(sew64vi_5 , vadd.vi,  2, 64, 1, 0xffffffffffff8000, 0xffffffffffff8000, 0x0000000000000000 );
    TEST_VI_OP(sew64vi_6 , vadd.vi,  2, 64, 1, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
    TEST_VI_OP(sew64vi_8 , vadd.vi,  16, 64, 8, 0x0000000000007fff, 0x0000000000007fff, 0x0000000000000000 );

    li x12, 0x0000;
    vmv.v.x v0 , x12;
    TEST_VIvm_OP(sew64vi_9 , vadd.vi,  16, 64, 8, 0x0000000000000000, 0x000000007fffffff, 0x0000000000000000 );

    vmv.v.i v0 , 0x0001;
    TEST_VIvm_OP(sew64vi_10, vadd.vi,  16, 64, 8, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );




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

