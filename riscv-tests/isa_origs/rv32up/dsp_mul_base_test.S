# See LICENSE for license details.

#*****************************************************************************
#dsp_longp_base_test.S
#-----------------------------------------------------------------------------
#
# Test instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"


RVTEST_RV32M
RVTEST_CODE_BEGIN

.align 2
.option norvc


li TESTNUM, 2

#ifdef N600_CFG_HAS_DSP

#################################################################################
############SMUL8#############
//-1*-1 = 1
li a2, 0xffffffff
li a3, 0xffffffff
smul8 a4,a2,a3
li a6, 0x10001
li a7, 0x10001
bne a4,a6,fail
bne a5,a7,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x01010101
smul8 a4,a2,a3
li a6, 0xffffffff
li a7, 0xffffffff
bne a4,a6,fail
bne a5,a7,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x0
smul8 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//3*4 = 12
li a2, 0x3030303
li a3, 0x4040404
smul8 a4,a2,a3
li a6, 0xc000c
li a7, 0xc000c
bne a4,a6,fail
bne a5,a7,fail

############SMUL16#############
//-1*-1 = 1
li a2, 0xffffffff
li a3, 0xffffffff
smul16 a4,a2,a3
li a6, 0x1
li a7, 0x1
bne a4,a6,fail
bne a5,a7,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x10001
smul16 a4,a2,a3
li a6, 0xffffffff
li a7, 0xffffffff
bne a4,a6,fail
bne a5,a7,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x0
smul16 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//3*4 = 12
li a2, 0x30003
li a3, 0x40004
smul16 a4,a2,a3
li a6, 0xc
li a7, 0xc
bne a4,a6,fail
bne a5,a7,fail


############SMMUL#############
li a2, 0xffffffff
li a3, 0xffffffff
smmul a4,a2,a3
li a5, 0x0
bne a4,a5,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x00001
smmul a4,a2,a3
li a5, 0xffffffff
bne a4,a5,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x0
smmul a4,a2,a3
li a5, 0x0
bne a4,a5,fail
//3*4 = 12
li a2, 0x30000000
li a3, 0x40000000
smmul a4,a2,a3
li a5, 0x0c000000
bne a4,a5,fail

############MADDR32#############
li a2, 0xffffffff
li a3, 0xffffffff
li a4, 0x1;
maddr32 a4,a2,a3
li a5, 0x2
bne a4,a5,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x00001
maddr32 a4,a2,a3
li a5, 0x1
bne a4,a5,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x0
maddr32 a4,a2,a3
li a5, 0x1
bne a4,a5,fail
//3*4 = 12
li a2, 0x3
li a3, 0x4
maddr32 a4,a2,a3
li a5, 0xd
bne a4,a5,fail
li a2, 0x1
li a3, 0x1
maddr32 a4,a2,a3 ###e
maddr32 a4,a2,a3 ###f
maddr32 a4,a2,a3 ###10
maddr32 a4,a2,a3 ###11
maddr32 a4,a2,a3 ###12
maddr32 a4,a2,a3 ###13
maddr32 a4,a2,a3 ###14
li a5, 0x14
bne a4,a5,fail

//umul16
//0xffff*0xffff = 0xfffe0001
li a2, 0xffffffff
li a3, 0xffffffff
umul16 a4,a2,a3
li a6, 0xfffe0001
li a7, 0xfffe0001
bne a4,a6,fail
bne a5,a7,fail
// 0xffff*1=0x0000ffff
li a2, 0xffffffff
li a3, 0x00010001
umul16 a4,a2,a3
li a6, 0x0000ffff
li a7, 0x0000ffff
bne a4,a6,fail
bne a5,a7,fail
//0xffff*0 = 0
li a2, 0xffffffff
li a3, 0x0
umul16 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//3*4 = 12
li a2, 0x40003
li a3, 0x30004
umul16 a4,a2,a3
li a6, 0xc
li a7, 0xc
bne a4,a6,fail
bne a5,a7,fail

//umulx16
//0xffff*0xffff = 0xfffe0001
li a2, 0xffffffff
li a3, 0xffffffff
umulx16 a4,a2,a3
li a6, 0xfffe0001
li a7, 0xfffe0001
bne a4,a6,fail
bne a5,a7,fail
// 0xffff*1=0x0000ffff
li a2, 0xffffffff
li a3, 0x00010001
umulx16 a4,a2,a3
li a6, 0x0000ffff
li a7, 0x0000ffff
bne a4,a6,fail
bne a5,a7,fail
//0xffff*0 = 0
li a2, 0xffffffff
li a3, 0x0
umulx16 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//3*4 = 12
li a2, 0x40003
li a3, 0x30004
umulx16 a4,a2,a3
li a6, 0x9
li a7, 0x10
bne a4,a6,fail
bne a5,a7,fail

//umul8
//0xff*0xff = 0xfe01 
li a2, 0xffffffff
li a3, 0xffffffff
umul8 a4,a2,a3
li a6, 0xfe01fe01
li a7, 0xfe01fe01
bne a4,a6,fail
bne a5,a7,fail
// 0xff*0x1=0x00ff
li a2, 0xffffffff
li a3, 0x01010101
umul8 a4,a2,a3
li a6, 0x00ff00ff
li a7, 0x00ff00ff
bne a4,a6,fail
bne a5,a7,fail
//0xff*0 = 0x0000
li a2, 0xffffffff
li a3, 0x0
umul8 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//0x03*0x04 =0x000c 
li a2, 0x4030403
li a3, 0x4030403
umul8 a4,a2,a3
li a6, 0x100009
li a7, 0x100009
bne a4,a6,fail
bne a5,a7,fail

//umulx8
//0xff*0xff = 0xfe01 
li a2, 0xffffffff
li a3, 0xffffffff
umulx8 a4,a2,a3
li a6, 0xfe01fe01
li a7, 0xfe01fe01
bne a4,a6,fail
bne a5,a7,fail
// 0xff*0x01=0x00ff
li a2, 0xffffffff
li a3, 0x01010101
umulx8 a4,a2,a3
li a6, 0x00ff00ff
li a7, 0x00ff00ff
bne a4,a6,fail
bne a5,a7,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x0
umulx8 a4,a2,a3
li a6, 0x0
li a7, 0x0
bne a4,a6,fail
bne a5,a7,fail
//3*4 = 12
li a2, 0x4030403
li a3, 0x4030403
umulx8 a4,a2,a3
li a6, 0xc000c
li a7, 0xc000c
bne a4,a6,fail
bne a5,a7,fail


############smmwb#############
//rd = Mres[47:16]
//-1*-1 = 0
li a2, 0xffffffff
li a3, 0x2356ffff
smmwb a4,a2,a3
li a6, 0x0
bne a4,a6,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0xf1e10001
smmwb a4,a2,a3
li a6, 0xffffffff
bne a4,a6,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x45010000
smmwb a4,a2,a3
li a6, 0x0
bne a4,a6,fail
//30000*4 = 12
li a2, 0x30000
li a3, 0x63250004
smmwb a4,a2,a3
li a6, 0xc
bne a4,a6,fail

//##########smmwt#########
//-1*-1 = 0
li a2, 0xffffffff
li a3, 0xffff0234
smmwt a4,a2,a3
li a6, 0x0
bne a4,a6,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x0001f1e1
smmwt a4,a2,a3
li a6, 0xffffffff
bne a4,a6,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x00004501
smmwt a4,a2,a3
li a6, 0x0
bne a4,a6,fail
//3*4 = 12
li a2, 0x30000
li a3, 0x00046325
smmwt a4,a2,a3
li a6, 0xc
bne a4,a6,fail

##########kmmwb2##########
//rd = Mres[46:15]
//-1*-1 = 0
li a2, 0xffffffff
li a3, 0x2356ffff
kmmwb2 a4,a2,a3
li a6, 0x0
bne a4,a6,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0xf1e10001
kmmwb2 a4,a2,a3
li a6, 0xffffffff
bne a4,a6,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x45010000
kmmwb2 a4,a2,a3
li a6, 0x0
bne a4,a6,fail
//30000*4 = 12
li a2, 0x30000
li a3, 0x63250004
kmmwb2 a4,a2,a3
li a6, 0x18
bne a4,a6,fail

//##########kmmwt2##########
//rd = Mres[46:15]
//-1*-1 = 0
li a2, 0xffffffff
li a3, 0xffff0234
kmmwt2 a4,a2,a3
li a6, 0x0
bne a4,a6,fail
// -1*1=-1
li a2, 0xffffffff
li a3, 0x0001f1e1
kmmwt2 a4,a2,a3
li a6, 0xffffffff
bne a4,a6,fail
//-1*0 = 0
li a2, 0xffffffff
li a3, 0x00004501
kmmwt2 a4,a2,a3
li a6, 0x0
bne a4,a6,fail
//3*4 = 12
li a2, 0x30000
li a3, 0x00046325
kmmwt2 a4,a2,a3
li a6, 0x18
bne a4,a6,fail
//##########kwmmul##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//kwmmul a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//kwmmul a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//kwmmul a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//kwmmul a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smmul##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smmul a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smmul a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smmul a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smmul a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########mulr64##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//mulr64 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//mulr64 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//mulr64 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//mulr64 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########mulsr64##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//mulsr64 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//mulsr64 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//mulsr64 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//mulsr64 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smbb16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smbb16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smbb16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smbb16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smbb16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smbt16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smbt16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smbt16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smbt16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smbt16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smtt16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smtt16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smtt16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smtt16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smtt16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
##########khmbb##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khmbb a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khmbb a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khmbb a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khmbb a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//0x8000*0x8000 = 0x7fff
li a2, 0x8000
li a3, 0x8000
khmbb a4,a2,a3
li a6, 0x7fff
bne a4,a6,fail
//##########khmbt##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khmbt a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khmbt a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khmbt a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khmbt a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########khmtt##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khmtt a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khmtt a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khmtt a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khmtt a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########kdmbb##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//kdmbb a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//kdmbb a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//kdmbb a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//kdmbb a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########kdmbt##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//kdmbt a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//kdmbt a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//kdmbt a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//kdmbt a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########kdmtt##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//kdmtt a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//kdmtt a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//kdmtt a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//kdmtt a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########khm8##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khm8 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khm8 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khm8 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khm8 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########khmx8##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khmx8 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khmx8 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khmx8 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khmx8 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########khm16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khm16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khm16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khm16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khm16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########khmx16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//khmx16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//khmx16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//khmx16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//khmx16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smul8##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smul8 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smul8 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smul8 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smul8 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smulx8##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smulx8 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smulx8 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smulx8 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smulx8 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smul16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smul16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smul16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smul16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smul16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail
//##########smulx16##########
////-1*-1 = 1
//li a2, 0xffffffff
//li a3, 0xffffffff
//smulx16 a4,a2,a3
//li a6, 0x10001
//li a7, 0x10001
//##bne a4,a6,fail
//##bne a5,a7,fail
//// -1*1=-1
//li a2, 0xffffffff
//li a3, 0x01010101
//smulx16 a4,a2,a3
//li a6, 0xffffffff
//li a7, 0xffffffff
//##bne a4,a6,fail
//##bne a5,a7,fail
////-1*0 = 0
//li a2, 0xffffffff
//li a3, 0x0
//smulx16 a4,a2,a3
//li a6, 0x0
//li a7, 0x0
//##bne a4,a6,fail
//##bne a5,a7,fail
////3*4 = 12
//li a2, 0x3030303
//li a3, 0x4040404
//smulx16 a4,a2,a3
//li a6, 0xc000c
//li a7, 0xc000c
//##bne a4,a6,fail
//##bne a5,a7,fail

#endif 

#################################################################################
j pass


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
