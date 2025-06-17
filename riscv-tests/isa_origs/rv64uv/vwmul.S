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
# vwmul.S
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
# vwmulu.vv
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VV_OP_Widen(sew8uvv_2 , vwmulu.vv, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8uvv_3 , vwmulu.vv, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VV_OP_Widen(sew8uvv_4 , vwmulu.vv, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8uvv_5 , vwmulu.vv, 128, 8, 4, 0x0002, 0x02, 0x01 );
  #------------------------------------------------------------
  # TEST_VV_OP_Widen16 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew16uvv_2 , vwmulu.vv, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16uvv_3 , vwmulu.vv, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VV_OP_Widen(sew16uvv_4 , vwmulu.vv, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16uvv_5 , vwmulu.vv, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );
  #------------------------------------------------------------
  # TEST_VV_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew32uvv_2 , vwmulu.vv, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32uvv_3 , vwmulu.vv, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VV_OP_Widen(sew32uvv_4 , vwmulu.vv, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32uvv_5 , vwmulu.vv, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );


#*****************************************************************************
# vwmulu.vx
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP_Widen(sew8uvx_2 , vwmulu.vx, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8uvx_3 , vwmulu.vx, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VX_OP_Widen(sew8uvx_4 , vwmulu.vx, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8uvx_5 , vwmulu.vx, 128, 8, 4, 0x0002, 0x02, 0x01 );

  #------------------------------------------------------------
  # TEST_VX_OPV16 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew16uvx_2 , vwmulu.vx, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16uvx_3 , vwmulu.vx, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VX_OP_Widen(sew16uvx_4 , vwmulu.vx, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16uvx_5 , vwmulu.vx, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );

  #------------------------------------------------------------
  # TEST_VX_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew32uvx_2 , vwmulu.vx, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32uvx_3 , vwmulu.vx, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VX_OP_Widen(sew32uvx_4 , vwmulu.vx, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32uvx_5 , vwmulu.vx, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );



#*****************************************************************************
# vwmul.vv
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VV_OP_Widen(sew8vv_2 , vwmul.vv, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8vv_3 , vwmul.vv, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VV_OP_Widen(sew8vv_4 , vwmul.vv, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8vv_5 , vwmul.vv, 128, 8, 4, 0x0002, 0x02, 0x01 );

  #------------------------------------------------------------
  # TEST_VV_OP_Widen16 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew16vv_2 , vwmul.vv, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16vv_3 , vwmul.vv, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VV_OP_Widen(sew16vv_4 , vwmul.vv, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16vv_5 , vwmul.vv, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );
  #------------------------------------------------------------
  # TEST_VV_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew32vv_2 , vwmul.vv, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32vv_3 , vwmul.vv, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VV_OP_Widen(sew32vv_4 , vwmul.vv, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32vv_5 , vwmul.vv, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );


#*****************************************************************************
# vwmul.vx
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP_Widen(sew8vx_2 , vwmul.vx, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8vx_3 , vwmul.vx, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VX_OP_Widen(sew8vx_4 , vwmul.vx, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8vx_5 , vwmul.vx, 128, 8, 4, 0x0002, 0x02, 0x01 );

  #------------------------------------------------------------
  # TEST_VX_OP_Widen16 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew16vx_2 , vwmul.vx, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16vx_3 , vwmul.vx, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VX_OP_Widen(sew16vx_4 , vwmul.vx, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16vx_5 , vwmul.vx, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );
  #------------------------------------------------------------
  # TEST_VX_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew32vx_2 , vwmul.vx, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32vx_3 , vwmul.vx, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VX_OP_Widen(sew32vx_4 , vwmul.vx, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32vx_5 , vwmul.vx, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );

#*****************************************************************************
# vwmulsu.vv
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VV_OP_Widen(sew8svv_2 , vwmulsu.vv, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8svv_3 , vwmulsu.vv, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VV_OP_Widen(sew8svv_4 , vwmulsu.vv, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VV_OP_Widen(sew8svv_5 , vwmulsu.vv, 128, 8, 4, 0x0002, 0x02, 0x01 );
  #------------------------------------------------------------
  # TEST_VV_OP_Widen16 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew16svv_2 , vwmulsu.vv, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16svv_3 , vwmulsu.vv, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VV_OP_Widen(sew16svv_4 , vwmulsu.vv, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VV_OP_Widen(sew16svv_5 , vwmulsu.vv, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );

  #------------------------------------------------------------
  # TEST_VV_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VV_OP_Widen(sew32svv_2 , vwmulsu.vv, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32svv_3 , vwmulsu.vv, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VV_OP_Widen(sew32svv_4 , vwmulsu.vv, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VV_OP_Widen(sew32svv_5 , vwmulsu.vv, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );


#*****************************************************************************
# vwmulsu.vx
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VX_OP_Widen8 tests( testnum, inst, vl, sew, mul, result, val1, val2 );
  #----------------------------------------------------------------------
    TEST_VX_OP_Widen(sew8svx_2 , vwmulsu.vx, 16, 8, 1, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8svx_3 , vwmulsu.vx, 16, 8, 1, 0x0002, 0x02, 0x01 );
    TEST_VX_OP_Widen(sew8svx_4 , vwmulsu.vx, 128, 8, 4, 0xfffe, 0x02, 0xff  );
    TEST_VX_OP_Widen(sew8svx_5 , vwmulsu.vx, 128, 8, 4, 0x0002, 0x02, 0x01 );

  #------------------------------------------------------------
  # TEST_VX_OP_Widen16 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew16svx_2 , vwmulsu.vx, 8, 16, 1, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16svx_3 , vwmulsu.vx, 8, 16, 1, 0x00000002, 0x0002, 0x0001 );
    TEST_VX_OP_Widen(sew16svx_4 , vwmulsu.vx, 64, 16, 4, 0xfffffffe, 0x0002, 0xffff );
    TEST_VX_OP_Widen(sew16svx_5 , vwmulsu.vx, 64, 16, 4, 0x00000002, 0x0002, 0x0001 );

  #------------------------------------------------------------
  # TEST_VX_OP_Widen32 tests
  #-------------------------------------------------------------
    TEST_VX_OP_Widen(sew32svx_2 , vwmulsu.vx, 4, 32, 1, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32svx_3 , vwmulsu.vx, 4, 32, 1, 0x0000000000000002, 0x00000002, 0x00000001 );
    TEST_VX_OP_Widen(sew32svx_4 , vwmulsu.vx, 32, 32, 4, 0xfffffffffffffffe, 0x00000002, 0xffffffff );
    TEST_VX_OP_Widen(sew32svx_5 , vwmulsu.vx, 32, 32, 4, 0x0000000000000002, 0x00000002, 0x00000001 );

/*

*/

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
