# See LICENSE for license details.

#*****************************************************************************
# breakpoint.S
#-----------------------------------------------------------------------------
#
# Test breakpoints, if they are implemented.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

#define DSP_TEST32(rs1, rs2, ires_l, insn) \
test_ ## insn: \
  li   a0, rs1;\
  li   a2, rs2;\
  insn a4, a0,a2;\
  li   t0, ires_l;\
  bne  a4, t0, fail ; 

#define DSP_TEST64( rs1, rs2, ires_h, ires_l, insn) \
test_ ## insn: \
  li   a0, rs1;\
  li   a1, rs1;\
  li   a2, rs2;\
  li   a3, rs2;\
  insn a4, a0,a2;\
  li   t0, ires_l;\
  li   t1, ires_h;\
  bne  a4, t0, fail ;\
  bne  a5, t1, fail ; 

#define DSP_TEST_ABS( rs1, ires, insn) \
test_ ## insn: \
  li     a0,  rs1; \
  li     a1,  ires; \
  insn  a2, a0; \
  bne   a2, a1, fail;

  li TESTNUM, 2

 #ifdef N600_CFG_HAS_DSP 

  # Set up breakpoint to trap on M-mode fetches.
v5_dsp_addsub_test:
 #DSP_TEST32( rs1       , rs2       ,  ires_l    , insn) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0800f4, add8   )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0400fa, radd8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x7f0480fa, uradd8 )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0800f4, kadd8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff08ffff, ukadd8 )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x01fcfe04, sub8   )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00feff02, rsub8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x80fe7f02, ursub8 )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x01fcfe04, ksub8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000fe04, uksub8 )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00000000, cmpeq8 )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00ffff00, scmple8)
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00ffff00, scmplt8)
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xffff0000, ucmple8)
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xffff0000, ucmplt8)
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff02fff8, smin8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x000601fc, smax8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x000201f8, umin8  )
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff06fffc, umax8  )

  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0801f4, add16    ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff8400fa, radd16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x7f8480fa, uradd16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0801f4, kadd16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff08ffff, ukadd16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fcfe04, sub16    ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x007eff02, rsub16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x807e7f02, ursub16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fcfe04, ksub16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000fe04, uksub16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00000000, cmpeq16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000ffff, scmple16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000ffff, scmplt16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xffff0000, ucmple16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xffff0000, ucmplt16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff06fffc, smin16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x000201f8, smax16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x000201f8, umin16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff06fffc, umax16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x01fa00f6, cras16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fd007b, rcras16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fd007b, urcras16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x01fa00f6, kcras16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x01fa00f6, ukcras16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xfe0aff02, crsa16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff05ff81, rcrsa16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff05ff81, urcrsa16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xfe0aff02, kcrsa16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000ffff, ukcrsa16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff08fe04, stas16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff84ff02, rstas16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x7f847f02, urstas16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff08fe04, kstas16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff08fe04, ukstas16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fc01f4, stsa16   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x007e00fa, rstsa16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x807e80fa, urstsa16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fc01f4, kstsa16  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000ffff, ukstsa16 ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff8480fa, ave      ) 

  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xffff8000 , kaddh  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0000ffff , ukaddh ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00007fff , ksubh  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00000000 , uksubh ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff8480fa , raddw  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x7f8480fa , uraddw ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0901f4 , kaddw  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0901f4 , ukaddw ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x007e7f02 , rsubw  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x807e7f02 , ursubw ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00fcfe04 , ksubw  ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x00000000 , uksubw ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0x0002fffc , maxw   ) 
  DSP_TEST32( 0x0002fffc, 0xff0601f8,  0xff0601f8 , minw   ) 

# DSP_TEST64( rs1,        rs2,        ires_h,     ires_l,    insn)  
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x943280F3, 0x943280F3 ,add64  )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x4A194079, 0xCA194079 ,radd64 )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x4A194079, 0xCA194079 ,uradd64)
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x7FFFFFFF, 0xFFFFFFFF ,kadd64 )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x943280F3, 0x943280F3 ,ukadd64)
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x09FA7F0F, 0x09FA7F0F ,sub64  )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x04FD3F87, 0x84FD3F87 ,rsub64 )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x04FD3F87, 0x84FD3F87 ,ursub64)
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x09FA7F0F, 0x09FA7F0F ,ksub64 )
  DSP_TEST64( 0x4f168001, 0x451c00f2, 0x09FA7F0F, 0x09FA7F0F ,uksub64)

# DSP_TEST_ABS( rs1,       ires, insn) 
  DSP_TEST_ABS(0x0002fffc, 0x00020104, kabs8)
  DSP_TEST_ABS(0x0002fffc, 0x00020004, kabs16)
  DSP_TEST_ABS(0xff0601f8, 0x00f9fe08, kabsw)


#endif 

  TEST_PASSFAIL


RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

data1: .word 0
data2: .word 0

RVTEST_DATA_END
