# See LICENSE for license details.

#*****************************************************************************
# mulhl.S
#-----------------------------------------------------------------------------
#
# Test mulh instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

#ifndef N600_CFG_NO_MULDIV
   TEST_RR_BB_OP(2,mulh,mul,0x00FFE00E,0xFF203000,0x0FFF0060,0x0FFF0080);
   TEST_RR_BB_OP(3,mulh,mul,0x00E10000,0x1E000001,0x0F000001,0x0F000001);
   TEST_RR_BB_OP(4,mulh,mul,0x00E10000,0x96000015,0x0F000003,0x0F000007);
   TEST_RR_BB_OP(5,mulhu,mul,0xFE010000,0x00000000,0xFF000000,0xFF000000);
   TEST_RR_BB_OP(6,mulh,mul,0xFFF10778,0x04000000,0xFF008000,0x0F000800); 
   TEST_RR_BB_OP(7,mulhsu,mul,0xFFFFFFFD,12,-3,-4);

#
#  #-------------------------------------------------------------
#  # Source/Destination tests
#  #-------------------------------------------------------------
#
#  TEST_RR_SRC1_EQ_DEST( 8, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_SRC2_EQ_DEST( 9, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_SRC12_EQ_DEST( 10, mulh, 43264, 13<<20 );
#
#  #-------------------------------------------------------------
#  # Bypassing tests
#  #-------------------------------------------------------------
#
#  TEST_RR_DEST_BYPASS( 11, 0, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_DEST_BYPASS( 12, 1, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_DEST_BYPASS( 13, 2, mulh, 42240, 15<<20, 11<<20 );
#
#  TEST_RR_SRC12_BYPASS( 14, 0, 0, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_SRC12_BYPASS( 15, 0, 1, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_SRC12_BYPASS( 16, 0, 2, mulh, 42240, 15<<20, 11<<20 );
#  TEST_RR_SRC12_BYPASS( 17, 1, 0, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_SRC12_BYPASS( 18, 1, 1, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_SRC12_BYPASS( 19, 2, 0, mulh, 42240, 15<<20, 11<<20 );
#
#  TEST_RR_SRC21_BYPASS( 20, 0, 0, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_SRC21_BYPASS( 21, 0, 1, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_SRC21_BYPASS( 22, 0, 2, mulh, 42240, 15<<20, 11<<20 );
#  TEST_RR_SRC21_BYPASS( 23, 1, 0, mulh, 36608, 13<<20, 11<<20 );
#  TEST_RR_SRC21_BYPASS( 24, 1, 1, mulh, 39424, 14<<20, 11<<20 );
#  TEST_RR_SRC21_BYPASS( 25, 2, 0, mulh, 42240, 15<<20, 11<<20 );
#
#  TEST_RR_ZEROSRC1( 26, mulh, 0, 31<<26 );
#  TEST_RR_ZEROSRC2( 27, mulh, 0, 32<<26 );
#  TEST_RR_ZEROSRC12( 28, mulh, 0 );
#  TEST_RR_ZERODEST( 29, mulh, 33<<20, 34<<20 );
#endif
  j pass
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
