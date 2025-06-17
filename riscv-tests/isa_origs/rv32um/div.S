# See LICENSE for license details.

#*****************************************************************************
# div.S
#-----------------------------------------------------------------------------
#
# Test div instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------
 # li  t3, 0x0;
  #li  t4, 0x2;
#ifndef N600_CFG_NO_MULDIV
#ifndef N600_CFG_HAS_ZMMUL
test_start:
  TEST_RR_OP( 2, div,  3,  20,   6 );
  TEST_RR_OP( 3, div, -3, -20,   6 );
  TEST_RR_OP( 4, div, -3,  20,  -6 );
  TEST_RR_OP( 5, div,  3, -20,  -6 );

  TEST_RR_OP( 6, div, -1<<63, -1<<63,  1 );
  TEST_RR_OP( 7, div, -1<<63, -1<<63, -1 );

  TEST_RR_OP( 8, div, -1, -1<<63, 0 );
  TEST_RR_OP( 9, div, -1,      1, 0 );
  TEST_RR_OP(10, div, -1,      0, 0 );



#  SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff, 0xff);
#check_mode:
#  addi t3, t3, 1;
#  bne  t4, t4, test_start;

#endif
#endif
  j pass
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
