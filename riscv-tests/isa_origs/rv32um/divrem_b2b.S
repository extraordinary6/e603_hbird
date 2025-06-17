# See LICENSE for license details.

#*****************************************************************************
# div_rem.S
#-----------------------------------------------------------------------------
#
# Test divu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

#ifndef N600_CFG_NO_MULDIV

#ifndef N600_CFG_HAS_ZMMUL


test_start:
  TEST_RR_BB_OP(2, divu, remu,3,2,20,6);
  TEST_RR_BB_OP(3, divu, remu,0xD27E2,0x1C,0xEF45602,0x123);
  TEST_RR_BB_OP(4, div, rem, -3,-2,-20,6);
  TEST_RR_BB_OP(5, div, rem, 3,-2,-20,-6);
  TEST_RR_BB_OP(6, remu, divu,2,3,20,6);
  TEST_RR_BB_OP(7, remu, divu,0x1C,0xD27E2,0xEF45602,0x123);
  TEST_RR_BB_OP(8, rem, div, -2,-3,-20,6);
  TEST_RR_BB_OP(9, rem, div, -2,3,-20,-6);

# TEST_RR_OP( 2, divu,                   3,  20,   6 );
# TEST_RR_OP( 3, divu,           715827879, -20,   6 );
# TEST_RR_OP( 4, divu,                   0,  20,  -6 );
# TEST_RR_OP( 5, divu,                   0, -20,  -6 );

# TEST_RR_OP( 6, divu, -1<<31, -1<<31,  1 );
# TEST_RR_OP( 7, divu,     0,  -1<<31, -1 );

# TEST_RR_OP( 8, divu, -1, -1<<31, 0 );
# TEST_RR_OP( 9, divu, -1,      1, 0 );
# TEST_RR_OP(10, divu, -1,      0, 0 );
// CAI: add for umode coverage collection.

#endif
#endif
  j pass
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
