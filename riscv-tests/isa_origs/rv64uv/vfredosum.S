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
# vfredosum.S
#-----------------------------------------------------------------------------
#
# Test f{add|sub|mul}.s instructions.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

#ifdef N600_CFG_HAS_VPU
#ifdef N600_CFG_HAS_FPU
#ifdef N600_CFG_VPU_ELEN_64
#ifndef N600_CFG_HAS_ONLY_VCAU
RVTEST_RV64UF
RVTEST_CODE_BEGIN

.align 2
.option norvc

# TODO: add double/half, for now, we only add single precision


  #-------------------------------------------------------------
  # Initialization
  #-------------------------------------------------------------

  #enable fpu
  li x1, 0x2000
  csrs mstatus, x1

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

teststart:
#*****************************************************************************
# vfredosum.vs tests( testnum, inst, flags, vl, sew, mul, result, val1, val2 )
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VF_OP_32
  #----------------------------------------------------------------------
  TEST_VV_FP( 5, vfredosum.vs, 0,  4, 32, 1,   1.0,        0.0,        1.0 );
  TEST_VV_FP( 6, vfredosum.vs, 0,  4, 32, 1,   11.0,        2.5,        1.0 );


  TEST_VV_FP( 7, vfredosum.vs, 0,  32, 32, 8,   17.0,        0.5,        1.0 );
  TEST_VV_FP( 8, vfredosum.vs, 0,  32, 32, 8,   34.5,        1.0,        2.5 );

#*****************************************************************************
# vfredsum.vs tests( testnum, inst, flags, vl, sew, mul, result, val1, val2 )
#-----------------------------------------------------------------------------
  #----------------------------------------------------------------------
  # TEST_VV_OP_32
  #----------------------------------------------------------------------
  TEST_VV_FP( 25, vfredsum.vs, 0,  4, 32, 1,   1.0,        0.0,        1.0 );
  TEST_VV_FP( 26, vfredsum.vs, 0,  4, 32, 1,   11.0,        2.5,        1.0 );

  TEST_VV_FP( 27, vfredsum.vs, 0,  32, 32, 8,   17.0,        0.5,        1.0 );
  TEST_VV_FP( 28, vfredsum.vs, 0,  32, 32, 8,   34.5,        1.0,        2.5 );


nop
nop
nop

  TEST_PASSFAIL


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
#endif

#if (!defined N600_CFG_HAS_VPU) || (!defined N600_CFG_HAS_FPU) || (!defined N600_CFG_VPU_ELEN_64) || (defined N600_CFG_HAS_ONLY_VCAU)
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
