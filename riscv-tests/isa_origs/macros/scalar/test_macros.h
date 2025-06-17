// See LICENSE for license details.

#ifndef __TEST_MACROS_SCALAR_H
#define __TEST_MACROS_SCALAR_H


#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------

#define MASK_XLEN(x) ((x) & ((1 << (__riscv_xlen - 1) << 1) - 1))
/////////////////////origin funct//////////////////////////////////////////
#define TEST_CASE( testnum, testreg, correctval, code... ) \
test_ ## testnum: \
    code; \
    li  a0, MASK_XLEN(correctval); \
    li  TESTNUM, testnum; \
    bne testreg, a0, fail;

// Dzj: Newly added specially for rv32ud
#define TEST_CASE_fclass( testnum, testreg, correctval,input, code... ) \
test_ ## testnum: \
 la  a0, test_ ## testnum ## _data ;\
    code; \
    li  a0, MASK_XLEN(correctval); \
    li  TESTNUM, testnum; \
    bne testreg, a0, fail;\
    .pushsection .data; \
    .align 3; \
    test_ ## testnum ## _data: \
    .dword input; \
    .popsection

// Dzj: Newly added specially for rv32ud
#define TEST_CASE_fcvt( testnum, testreg, correctval_high, correctval_low, code... ) \
test_ ## testnum: \
    code; \
    li t1 , correctval_high; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne a3, a5, fail;\
    bne a4, t1, fail;
//
#define TEST_CASE_fcvt_w( testnum, testreg, correctval_high , correctval_low , code... ) \
test_ ## testnum: \
    code; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne testreg, a5, fail;
//
#define TEST_CASE_ldst( testnum, testreg, correctval_high , correctval_low , code... ) \
test_ ## testnum: \
    code; \
    li t1 , correctval_high; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne a3, a5, fail;\
    bne a4, t1, fail;
//
#define TEST_CASE_FSGNJD( testnum, testreg, correctval_high, correctval_low, code... ) \
test_ ## testnum: \
    code; \
    li t1 , correctval_high; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne a3, a5, fail;\
    bne a4, t1, fail;
//
#define TEST_CASE_1_FSGNJS( testnum, testreg, correctval, code... ) \
test_ ## testnum: \
    code; \
    li  a0, MASK_XLEN(correctval); \
    li  TESTNUM, testnum; \
    bne testreg, a0, fail;
//
#define TEST_CASE_2_FSGNJS( testnum, testreg, correctval_high, correctval_low, code... ) \
test_ ## testnum: \
    code; \
    li t1 , correctval_high; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne a3, a5, fail;\
    bne a4, t1, fail;
//
#define TEST_CASE_1_FSGNJD_SP( testnum, testreg, correctval, code... ) \
test_ ## testnum: \
    code; \
    li  a0, MASK_XLEN(correctval); \
    li  TESTNUM, testnum; \
    bne testreg, a0, fail;
//
#define TEST_CASE_2_FSGNJD_SP( testnum, testreg, correctval_high, correctval_low, code... ) \
test_ ## testnum: \
    code; \
    li t1 , correctval_high; \
    li a5 , correctval_low; \
    li  TESTNUM, testnum; \
    bne a3, a5, fail;\
    bne a4, t1, fail;
/////////////////////////////////////////////////////////////////////////////////////

# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.

#define TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_1  nop; TEST_INSERT_NOPS_0
#define TEST_INSERT_NOPS_2  nop; TEST_INSERT_NOPS_1
#define TEST_INSERT_NOPS_3  nop; TEST_INSERT_NOPS_2
#define TEST_INSERT_NOPS_4  nop; TEST_INSERT_NOPS_3
#define TEST_INSERT_NOPS_5  nop; TEST_INSERT_NOPS_4
#define TEST_INSERT_NOPS_6  nop; TEST_INSERT_NOPS_5
#define TEST_INSERT_NOPS_7  nop; TEST_INSERT_NOPS_6
#define TEST_INSERT_NOPS_8  nop; TEST_INSERT_NOPS_7
#define TEST_INSERT_NOPS_9  nop; TEST_INSERT_NOPS_8
#define TEST_INSERT_NOPS_10 nop; TEST_INSERT_NOPS_9


#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------

#define SEXT_IMM(x) ((x) | (-(((x) >> 11) & 1) << 11))

#define TEST_IMM_OP( testnum, inst, result, val1, imm ) \
    TEST_CASE( testnum, a1, result, \
      li  x1, MASK_XLEN(val1); \
      inst a1, x1, SEXT_IMM(imm); \
    )

#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      inst x1, x1, SEXT_IMM(imm); \
    )

#define TEST_IMM_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      inst a1, x1, SEXT_IMM(imm); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, a1, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_IMM_SRC1_BYPASS( testnum, nop_cycles, inst, result, val1, imm ) \
    TEST_CASE( testnum, a1, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## nop_cycles \
      inst a1, x1, SEXT_IMM(imm); \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_IMM_ZEROSRC1( testnum, inst, result, imm ) \
    TEST_CASE( testnum, x1, result, \
      inst x1, x0, SEXT_IMM(imm); \
    )

#define TEST_IMM_ZERODEST( testnum, inst, val1, imm ) \
    TEST_CASE( testnum, x0, 0, \
      li  x1, MASK_XLEN(val1); \
      inst x0, x1, SEXT_IMM(imm); \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------

#define TEST_R_OP( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, a1, result, \
      li  x1, val1; \
      inst a1, x1; \
    )

#define TEST_R_SRC1_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, val1; \
      inst x1, x1; \
    )

#define TEST_R_DEST_BYPASS( testnum, nop_cycles, inst, result, val1 ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, val1; \
      inst a1, x1; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, a1, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------


#define TEST_RR_BB_OP( testnum, inst1,inst2, result1, result2, val1, val2 ) \
test_ ## testnum: \
      li  x1, MASK_XLEN(val1); \
      li  a2, MASK_XLEN(val2); \
      li  t0, MASK_XLEN(result1); \
      li  t1, MASK_XLEN(result2); \
      inst1 t2, x1, a2; \
      inst2 s0, x1, a2; \
      li  TESTNUM, testnum;  \
      bne t0, t2, fail;   \
      bne t1, s0, fail;   

      

#define TEST_RR_OP( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, a1, result, \
      li  x1, MASK_XLEN(val1); \
      li  a2, MASK_XLEN(val2); \
      inst a1, x1, a2; \
    )

#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      li  a2, MASK_XLEN(val2); \
      inst x1, x1, a2; \
    )

#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 ) \
    TEST_CASE( testnum, a2, result, \
      li  x1, MASK_XLEN(val1); \
      li  a2, MASK_XLEN(val2); \
      inst a2, x1, a2; \
    )

#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
    TEST_CASE( testnum, x1, result, \
      li  x1, MASK_XLEN(val1); \
      inst x1, x1, x1; \
    )

#define TEST_RR_DEST_BYPASS( testnum, nop_cycles, inst, result, val1, val2 ) \
    TEST_CASE( testnum, x6, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      li  a2, MASK_XLEN(val2); \
      inst a1, x1, a2; \
      TEST_INSERT_NOPS_ ## nop_cycles \
      addi  x6, a1, 0; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE( testnum, a1, result, \
      li  x4, 0; \
1:    li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## src1_nops \
      li  a2, MASK_XLEN(val2); \
      TEST_INSERT_NOPS_ ## src2_nops \
      inst a1, x1, a2; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, result, val1, val2 ) \
    TEST_CASE( testnum, a1, result, \
      li  x4, 0; \
1:    li  a2, MASK_XLEN(val2); \
      TEST_INSERT_NOPS_ ## src1_nops \
      li  x1, MASK_XLEN(val1); \
      TEST_INSERT_NOPS_ ## src2_nops \
      inst a1, x1, a2; \
      addi  x4, x4, 1; \
      li  x5, 2; \
      bne x4, x5, 1b \
    )

#define TEST_RR_ZEROSRC1( testnum, inst, result, val ) \
    TEST_CASE( testnum, a2, result, \
      li x1, MASK_XLEN(val); \
      inst a2, x0, x1; \
    )

#define TEST_RR_ZEROSRC2( testnum, inst, result, val ) \
    TEST_CASE( testnum, a2, result, \
      li x1, MASK_XLEN(val); \
      inst a2, x1, x0; \
    )

#define TEST_RR_ZEROSRC12( testnum, inst, result ) \
    TEST_CASE( testnum, x1, result, \
      inst x1, x0, x0; \
    )

#define TEST_RR_ZERODEST( testnum, inst, val1, val2 ) \
    TEST_CASE( testnum, x0, 0, \
      li x1, MASK_XLEN(val1); \
      li a2, MASK_XLEN(val2); \
      inst x0, x1, a2; \
    )

#-----------------------------------------------------------------------
# Tests for an instruction with vecter-vecter operands
#-----------------------------------------------------------------------
#define vpu_sew_is_8  8
#define vpu_sew_is_16 16
#define vpu_sew_is_32 32
#define vpu_sew_is_64 64
#define MASK_XLEN_SEW8(x)  ((x) & ((1 << (vpu_sew_is_8  - 1) << 1) - 1))
#define MASK_XLEN_SEW16(x) ((x) & ((1 << (vpu_sew_is_16 - 1) << 1) - 1))
#define MASK_XLEN_SEW32(x) ((x) & ((1 << (vpu_sew_is_32 - 1) << 1) - 1))
#define MASK_XLEN_SEW64(x) ((x) & ((1 << (vpu_sew_is_64 - 1) << 1) - 1))

#define TEST_VV_OP_SEW8( testnum, inst, result, elemt_num, val1, val2 ) \
test_ ## testnum: \
    li  a1, MASK_XLEN_SEW8(val1); \
    li  a0, 0x90000100; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op1_loop_ ## test_ ## testnum: \
    sb  a1, 0(a0); \
    addi a0, a0, 1; \
    sub a2, a2, a3; \
    bnez a2, init_op1_loop_ ## test_ ## testnum; \
    li  a1, MASK_XLEN_SEW8(val2); \
    li  a0, 0x90000300; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op2_loop_ ## test_ ## testnum: \
    sb  a1, 0(a0); \
    addi a0, a0, 1; \
    sub a2, a2, a3; \
    bnez a2, init_op2_loop_ ## test_ ## testnum; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000100; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v0, (x5); \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000300; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v8, (x5); \
    li x11, 128; \
    vsetvli x10, x11, e8, m8; \
    li x0, 8; \
    li x6, 1; \
    li x7, 2; \
vdiv_loop_ ## test_ ## testnum: \
    inst v16, v0, v8; \
    sub x7, x7, x6; \
    bnez x7, vdiv_loop_ ## test_ ## testnum; \
    li x7, MASK_XLEN_SEW8(result); \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
    li x0, 8; \
    li x0, 8; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8

#define TEST_VV_OP_SEW16( testnum, inst, result, elemt_num, val1, val2 ) \
test_ ## testnum: \
    li  a1, MASK_XLEN_SEW16(val1); \
    li  a0, 0x90000100; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op1_loop_ ## test_ ## testnum: \
    sh  a1, 0(a0); \
    addi a0, a0, 2; \
    sub a2, a2, a3; \
    bnez a2, init_op1_loop_ ## test_ ## testnum; \
    li  a1, MASK_XLEN_SEW16(val2); \
    li  a0, 0x90000300; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op2_loop_ ## test_ ## testnum: \
    sh  a1, 0(a0); \
    addi a0, a0, 2; \
    sub a2, a2, a3; \
    bnez a2, init_op2_loop_ ## test_ ## testnum; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000100; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v0, (x5); \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000300; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v8, (x5); \
    li x11, 128; \
    vsetvli x10, x11, e16, m8; \
    li x0, 8; \
    li x6, 1; \
    li x7, 2; \
vdiv_loop_ ## test_ ## testnum: \
    inst v16, v0, v8; \
    sub x7, x7, x6; \
    bnez x7, vdiv_loop_ ## test_ ## testnum; \
    li x7, MASK_XLEN_SEW16(result); \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8

#define TEST_VV_OP_SEW32( testnum, inst, result, elemt_num, val1, val2 ) \
test_ ## testnum: \
    li  a1, MASK_XLEN_SEW32(val1); \
    li  a0, 0x90000100; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op1_loop_ ## test_ ## testnum: \
    sw  a1, 0(a0); \
    addi a0, a0, 4; \
    sub a2, a2, a3; \
    bnez a2, init_op1_loop_ ## test_ ## testnum; \
    li  a1, MASK_XLEN_SEW32(val2); \
    li  a0, 0x90000300; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op2_loop_ ## test_ ## testnum: \
    sw  a1, 0(a0); \
    addi a0, a0, 4; \
    sub a2, a2, a3; \
    bnez a2, init_op2_loop_ ## test_ ## testnum; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000100; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v0, (x5); \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000300; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v8, (x5); \
    li x11, 128; \
    vsetvli x10, x11, e32, m8; \
    li x0, 8; \
    li x6, 1; \
    li x7, 2; \
vdiv_loop_ ## test_ ## testnum: \
    inst v16, v0, v8; \
    sub x7, x7, x6; \
    bnez x7, vdiv_loop_ ## test_ ## testnum; \
    li x7, MASK_XLEN_SEW32(result); \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8

#define TEST_VV_OP_SEW64( testnum, inst, result, elemt_num, val1, val2 ) \
test_ ## testnum: \
    li  a1, MASK_XLEN_SEW64(val1); \
    li  a0, 0x90000100; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op1_loop_ ## test_ ## testnum: \
    sd  a1, 0(a0); \
    addi a0, a0, 8; \
    sub a2, a2, a3; \
    bnez a2, init_op1_loop_ ## test_ ## testnum; \
    li  a1, MASK_XLEN_SEW64(val2); \
    li  a0, 0x90000300; \
    li  a2, MASK_XLEN(elemt_num); \
    li  a3, 1; \
init_op2_loop_ ## test_ ## testnum: \
    sd  a1, 0(a0); \
    addi a0, a0, 8; \
    sub a2, a2, a3; \
    bnez a2, init_op2_loop_ ## test_ ## testnum; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000100; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v0, (x5); \
    li x11, 16; \
    vsetvli x10, x11, e32, m8; \
    li x5, 0x90000300; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vle64.v v8, (x5); \
    li x11, 128; \
    vsetvli x10, x11, e64, m8; \
    li x0, 8; \
    li x6, 1; \
    li x7, 2; \
vdiv_loop_ ## test_ ## testnum: \
    inst v16, v0, v8; \
    sub x7, x7, x6; \
    bnez x7, vdiv_loop_ ## test_ ## testnum; \
    li x7, MASK_XLEN_SEW64(result); \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
    li x0, 8; \
    li x0, 8; \
    li x0, 8; \
    li x11, 16; \
    vsetvli x10, x11, e32, m8

#-----------------------------------------------------------------------
# RV64UV MACROS
#-----------------------------------------------------------------------
#define vpu_sew_is_128 128
//#define vsext(x, sew) (((x) << (64-sew)) >> (64-sew))
#define SIGN_EXT_XLEN_8(x) ((x) | ((x >> 7)*(0xffffffffffffff00)))
#define SIGN_EXT_XLEN_16(x) ((x) | ((x >> 15)*(0xffffffffffff0000)))
#define SIGN_EXT_XLEN_32(x) ((x) | ((x >> 31)*(0xffffffff00000000)))
#define SIGN_EXT_XLEN_64(x) ((x) & ((1 << (vpu_sew_is_64 - 1) << 1) - 1))

//result_w
#define SIGN_EXT_XLEN_W_8(x) ((x) | ((x >> 15)*(0xffffffffffff0000)))
#define SIGN_EXT_XLEN_W_16(x) ((x) | ((x >> 31)*(0xffffffff00000000)))
#define SIGN_EXT_XLEN_W_32(x) ((x) & ((1 << (vpu_sew_is_64 - 1) << 1) - 1))
#define SIGN_EXT_XLEN_W_64(x) ((x) & ((1 << (vpu_sew_is_128 - 1) << 1) - 1))

//val1_w
#define MASK_XLEN_SEW_W_8(x)  ((x) & ((1 << (vpu_sew_is_16 - 1) << 1) - 1))
#define MASK_XLEN_SEW_W_16(x) ((x) & ((1 << (vpu_sew_is_32 - 1) << 1) - 1))
#define MASK_XLEN_SEW_W_32(x) ((x) & ((1 << (vpu_sew_is_64 - 1) << 1) - 1))
#define MASK_XLEN_SEW_W_64(x) ((x) & ((1 << (vpu_sew_is_128 - 1) << 1) - 1))

#-----------------------------------------------------------------------
# Tests for instructions with vecter-vecter operand
#-----------------------------------------------------------------------
//vmv.x.s, when SEW < XLEN, the value is sign-extended to XLEN bits;
//x2(sp),x3(gp),x4(tp),x5(t0) reg value maybe have impact of passfail;
//x4 reg value maybe lead PASSFAIL couldn't jump to pass;

//LMUL=2,v reg number can't be odd
//LMUL=4,v reg number must be multiples of four
//LMUL=8,v reg number must be multiples of eight

//vadd.vv,vaaddu.vv,vaadd.vv,vsaddu.vv,vsadd.vv,vsub.vv,vrsub.vv
#define TEST_VV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x9; \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, v24, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x9; \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, v24, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VM_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    vmv.v.x v24, x6; \
    vmv.v.i v16, 0; \
    inst v16, v8, v24; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vmerge.vvm
#define TEST_VVM_OP( testnum, inst, vl, sew, mul, result, val1, val2, v0mask ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x9, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    li x9, MASK_XLEN_SEW ## sew(v0mask); \
    vmv.v.x v24, x5; \
    vmv.v.x v8, x6; \
    vmv.v.x v0, x9; \
    vmv.v.i v16, 0; \
    inst v16, v24, v8, v0; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \


//vwaddu.vv,vwadd.vv
#define TEST_VV_OP_Widen( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x5; \
    vmv.v.x v8, x6; \
    inst v16, v24, v8; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VVvm_OP_Widen( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x5; \
    vmv.v.x v8, x6; \
    inst v16, v24, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vwaddu.wv,vwadd.wv,vwsubu.wv,vwsub.wv
#define TEST_WV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x5, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x5; \
    vmv.v.x v8, x6; \
    inst v16, v24, v8; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_WVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x5, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v24, x5; \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16,v24,v8,v0.t; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vnsrl.wv,vnsra.wv
#define TEST_WVV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    vmv.v.x v24, x9; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x6; \
    inst v16, v24, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_WVVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    vmv.v.x v24, x9; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, v24, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
//vmv.v.x v24, x3 only get x3 8bit give to v24;

//vmsbf.m
#define TEST_VMS_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VMSvm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \


#define TEST_NR1_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v2, x6; \
    vmv.v.i v1, 0; \
    inst v1, v2; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v1; \
    bne x8, x7, fail; \

#define TEST_NR4_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    vmv.v.i v4, 0; \
    inst v4, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v4; \
    bne x8, x7, fail; \

#define TEST_NR8_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    vmv.v.i v0, 0; \
    inst v0, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v0; \
    bne x8, x7, fail; \

//vid.v
#define TEST_VID_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v0, x6; \
    vmv.v.i v8, 0; \
    inst v8 ; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v8; \
    bne x8, x7, fail; \

#define TEST_VIDvm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v0, x6; \
    vmv.v.i v8, 0; \
    inst v8,v0.t ; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v8; \
    bne x8, x7, fail; \


#-----------------------------------------------------------------------
# Tests for instructions with vecter-scalar operand
#-----------------------------------------------------------------------
//vadd.vx,vaaddu.vx,vaadd.vx,vsaddu.vx,vsadd.vx,vsub.vx,vrsub.vx
#define TEST_VX_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    vmv.v.i v16, 0; \
    inst v16, v8, x6; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \
//V0->V8

#define TEST_VXvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    vmv.v.i v16, 0; \
    inst v16, v8, x6, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vmerge.vxm
#define TEST_VXM_OP( testnum, inst, vl, sew, mul, result, val1, val2, v0mask ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x9, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    li x9, MASK_XLEN_SEW ## sew(v0mask); \
    vmv.v.x v24, x5; \
    vmv.v.x v0, x9; \
    vmv.v.i v16, 0; \
    inst v16, v24, x6, v0; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vwaddu.vx,vwadd.vx,vwsubu.vx,vwsub.vx
#define TEST_VX_OP_Widen( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    inst v16, v8, x6; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VXvm_OP_Widen( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    inst v16, v8, x6, v0.t; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \


//vwaddu.wx,vwadd.wx,vwsubu.wx,vwsub.wx
#define TEST_WX_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    inst v16, v8, x6; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_WXvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    inst v16, v8, x6, v0.t; \
    li x7, SIGN_EXT_XLEN_W_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vnsrl.wx,vnsra.wx
#define TEST_WXV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    vmv.v.i v16, 0; \
    inst v16, v8, x6; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_WXVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW_W_ ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x9; \
    vmv.v.i v16, 0; \
    inst v16, v8, x6,v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vnmsac.vx
#define TEST_XV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x6; \
    vmv.v.i v16, 0; \
    inst v16, x9, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_XVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x9, 0; \
    li x6, 0; \
    li x9, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(val2); \
    vmv.v.x v8, x6; \
    inst v16, x9, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vmv.x.s rd, vs2; vpooc.m;vfirst.m;
#define TEST_XS_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    inst x8, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    bne x8, x7, fail; \

#define TEST_XSvm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x6; \
    li x8, 0; \
    inst x8, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    bne x8, x7, fail; \

//vmv.s.x vd, rs1;
#define TEST_SX_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x6, 0; \
    li x6, MASK_XLEN_SEW ## sew(val1); \
    inst v16, x6; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#-----------------------------------------------------------------------
# Tests for instructions with vecter-immediate operand
#-----------------------------------------------------------------------
//vadd.vi,vsaddu.vi,vsadd.vi,vrsub.vi
#define TEST_VI_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x5; \
    vmv.v.i v16, 0; \
    inst v16, v8, MASK_XLEN_SEW ## sew(val2); \
    vmv.x.s x8, v16; \
    li  x7, SIGN_EXT_XLEN_ ## sew(result); \
    bne x8, x7, fail; \
//V0->V8
#define TEST_VIvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    vmv.v.x v8, x5; \
    vmv.v.i v16, 0; \
    inst v16, v8, MASK_XLEN_SEW ## sew(val2), v0.t; \
    vmv.x.s x8, v16; \
    li  x7, SIGN_EXT_XLEN_ ## sew(result); \
    bne x8, x7, fail; \

//vnsrl.wi,vnsra.wi
#define TEST_WIV_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x5, MASK_XLEN_SEW_W_ ## sew(val1); \
    vmv.v.x v8, x5; \
    inst v16, v8, val2; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_WIVvm_OP( testnum, inst, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x5, MASK_XLEN_SEW_W_ ## sew(val1); \
    vmv.v.x v8, x5; \
    vmv.v.i v16, 0; \
    inst v16, v8, val2, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

//vmerge.vim
#define TEST_VIM_OP( testnum, inst, vl, sew, mul, result, val1, val2, v0mask ) \
test_ ## testnum: \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    li x5, 0; \
    li x6, 0; \
    li x5, MASK_XLEN_SEW ## sew(val1); \
    li x6, MASK_XLEN_SEW ## sew(v0mask); \
    vmv.v.x v24, x5; \
    vmv.v.x v0, x6; \
    vmv.v.i v16, 0; \
    inst v16, v24, MASK_XLEN_SEW ## sew(val2), v0; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#-----------------------------------------------------------------------
# Tests for loads and stores instructions with vecter operand
#-----------------------------------------------------------------------
#define TEST_VR_LS( testnum, vl, sew, mul, inst, vd, rs1 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  sw x6, 0(a0); \
  vmv.v.i v16, 0; \
  inst v16, (a0); \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \

#define TEST_VRvm_LS( testnum, vl, sew, mul, inst, vd, rs1 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  sw x6, 0(a0); \
  vmv.v.i v16, 0; \
  inst v16, (a0),v0.t; \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \

#define TEST_RV_LS( testnum, vl, sew, mul, inst, vd, rs1 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  vmv.v.x v8, x6; \
  inst v8, (a1); \
  li x7, vd; \
  lw x8, 0(a1) ; \
  bne x8, x7, fail; \


#define TEST_VRV_LS( testnum, vl, sew, mul, inst, vd, rs1, vs2 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  li x9, vs2;\
  vmv.v.x v8, x9; \
  vmv.v.i v16, 0; \
  inst v16, (x6), v8; \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \

#define TEST_VRVvm_LS( testnum, vl, sew, mul, inst, vd, rs1, vs2 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  li x9, vs2; \
  vmv.v.x v8, x9; \
  vmv.v.i v16, 0; \
  inst v16, (x6), v8, v0.t; \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \

#define TEST_VRR_LS( testnum, vl, sew, mul, inst, vd, rs1, rs2 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  li x9, rs2;\
  vmv.v.i v16, 0; \
  inst v16, (x6), x9; \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \

#define TEST_VRRvm_LS( testnum, vl, sew, mul, inst, vd, rs1, rs2 ) \
test_ ## testnum: \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x6, rs1; \
  li x9, rs2;\
  vmv.v.i v16, 0; \
  inst v16, (x6), x9, v0.t; \
  li x7, vd; \
  vmv.x.s x8, v16; \
  bne x8, x7, fail; \
#-----------------------------------------------------------------------
# Tests for instructions with vecter integer operand
#-----------------------------------------------------------------------
//val1:EEW=SEW/2
#define MASK_VF2_EEW8(x)  ((x) & ((1 << (4 - 1) << 1) - 1))
#define MASK_VF2_EEW16(x)  ((x) & ((1 << (8 - 1) << 1) - 1))
#define MASK_VF2_EEW32(x)  ((x) & ((1 << (16 - 1) << 1) - 1))
#define MASK_VF2_EEW64(x)  ((x) & ((1 << (32 - 1) << 1) - 1))

#define TEST_VF2_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF2_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VF2vm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF2_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define MASK_VF4_EEW16(x)  ((x) & ((1 << (4 - 1) << 1) - 1))
#define MASK_VF4_EEW32(x)  ((x) & ((1 << (8 - 1) << 1) - 1))
#define MASK_VF4_EEW64(x)  ((x) & ((1 << (16 - 1) << 1) - 1))

#define TEST_VF4_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF4_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VF4vm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF4_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define MASK_VF8_EEW64(x)  ((x) & ((1 << (8 - 1) << 1) - 1))

#define TEST_VF8_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF8_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \

#define TEST_VF8vm_OP( testnum, inst, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
    li x5, 0; \
    li x5, MASK_VF8_EEW ## sew(val1); \
    vmv.v.x v8, x5; \
    li x11, MASK_XLEN(vl); \
    vsetvli x10, x11, e ## sew, m ## mul; \
    vmv.v.i v16, 0; \
    inst v16, v8, v0.t; \
    li x7, SIGN_EXT_XLEN_ ## sew(result); \
    vmv.x.s x8, v16; \
    bne x8, x7, fail; \



#-----------------------------------------------------------------------
# Tests for floating-point instructions with vecter-vecter operand
#-----------------------------------------------------------------------
#define TEST_VV_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ; \
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v16, f1; \
  vfmv.v.f v8, f2; \
  vmv.v.i v24, 0; \
  inst v24, v16, v8; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;

#define TEST_VVvm_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ; \
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v16, f1; \
  vfmv.v.f v8, f2; \
  vmv.v.i v24, 0; \
  inst v24, v16, v8,v0.t; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;

//vfrece7.v
#define TEST_VV2_FP( testnum, inst, flags, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x5, 0; \
  li x7, 0; \
  li x5, val1; \
  vmv.v.x v8, x5; \
  inst v16, v8; \
  vmv.x.s x8, v16; \
  li x7, result; \
  bne x8, x7, fail; \

#define TEST_VV2vm_FP( testnum, inst, flags, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  li x5, 0; \
  li x7, 0; \
  li x5, val1; \
  vmv.v.x v8, x5; \
  inst v16, v8, v0.t; \
  vmv.x.s x8, v16; \
  li x7, result; \
  bne x8, x7, fail; \

#define TEST_VF_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v8, f1; \
  vmv.v.i v16, 0;\
  inst v16, v8, f2; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;

#define TEST_VFvm_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v8, f1; \
  vmv.v.i v16, 0;\
  inst v16, v8, f2, v0.t; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;

#define TEST_FV_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v8, f2; \
  vmv.v.i v16, 0; \
  inst v16, f1, v8; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;

#define TEST_FVvm_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  flw f7, 8(a0); \
  vfmv.v.f v8, f2; \
  vmv.v.i v16, 0; \
  inst v16, f1, v8, v0.t; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float result; \
  .popsection;



#define TEST_VF2_FP( testnum, inst, flags, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f7, 4(a0); \
  inst v16, f1; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float result; \
  .popsection;

#define TEST_FV2_FP( testnum, inst, flags, vl, sew, mul, result, val1) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f7, 4(a0); \
  vfmv.v.f v0, f1; \
  inst f8, v0; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float result; \
  .popsection;

#define TEST_CVV_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ; \
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  vfmv.v.f v16, f1; \
  vfmv.v.f v8, f2; \
  vmv.v.i v24 , 0; \
  inst v24, v16, v8; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .popsection;

#define TEST_CVVvm_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ; \
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  vfmv.v.f v16, f1; \
  vfmv.v.f v8, f2; \
  vmv.v.i v24 , 0; \
  inst v24, v16, v8, v0.t; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .popsection;

#define TEST_CVF_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  vfmv.v.f v16, f1; \
  vmv.v.i v24 , 0; \
  inst v24, v16, f2; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .popsection;

#define TEST_CVFvm_FP( testnum, inst, flags, vl, sew, mul, result, val1, val2 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f2, 4(a0); \
  vfmv.v.f v16, f1; \
  vmv.v.i v24 , 0; \
  inst v24, v16, f2, v0.t; \
  vfmv.f.s f8, v24; \
  fmv.x.s x8, f8; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .popsection;

#define TEST_CVF2_FP( testnum, inst, flags, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  vfmv.v.f v8, f1; \
  inst v16, v8; \
  vmv.x.s x8, v16; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .popsection;

#define TEST_CVF2vm_FP( testnum, inst, flags, vl, sew, mul, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  vfmv.v.f v8, f1; \
  inst v16, v8, v0.t; \
  vmv.x.s x8, v16; \
  li x7, SIGN_EXT_XLEN_ ## sew(result); \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .popsection;

#define TEST_CFV2_FP( testnum, inst, flags, vl, sew, mul, result, val1) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x5, 0; \
  li x5, MASK_XLEN_SEW ## sew(val1); \
  vmv.v.x v8, x5; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f7, 0(a0); \
  inst v16, v8; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float result; \
  .popsection;

#define TEST_CFV2vm_FP( testnum, inst, flags, vl, sew, mul, result, val1) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x5, 0; \
  li x5, MASK_XLEN_SEW ## sew(val1); \
  vmv.v.x v8, x5; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f7, 0(a0); \
  inst v16, v8, v0.t; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float result; \
  .popsection;

#define TEST_CVV2_FP( testnum, inst, flags, vl, sew, mul, result, val1) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f7, 4(a0); \
  vfmv.v.f v8, f1; \
  inst v16, v8; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float result; \
  .popsection;

#define TEST_CVV2vm_FP( testnum, inst, flags, vl, sew, mul, result, val1) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  li x11, MASK_XLEN(vl); \
  vsetvli x10, x11, e ## sew, m ## mul; \
  la  a0, test_ ## testnum ## _data ;\
  flw f1, 0(a0); \
  flw f7, 4(a0); \
  vfmv.v.f v8, f1; \
  inst v16, v8, v0.t; \
  vfmv.f.s f8, v16; \
  fmv.x.s x8, f8; \
  fmv.x.s x7, f7; \
  bne x8, x7, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float result; \
  .popsection;


#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------

#define TEST_STREAM_LD_ST_OP( testnum, load_inst, store_inst, result, base ) \
    TEST_CASE( testnum, a1, result, \
      la  x1, base; \
      li  a2, result; \
      store_inst a2,    0(x1); \
      store_inst a2,   16(x1); \
      store_inst a2,   32(x1); \
      store_inst a2,   48(x1); \
      store_inst a2,   64(x1); \
      store_inst a2,   80(x1); \
      store_inst a2,   96(x1); \
      store_inst a2,  112(x1); \
      store_inst a2,  128(x1); \
      store_inst a2,    0(x1); \
      store_inst a2,   16(x1); \
      store_inst a2,   32(x1); \
      store_inst a2,   48(x1); \
      store_inst a2,   64(x1); \
      store_inst a2,   80(x1); \
      store_inst a2,   96(x1); \
      store_inst a2,  112(x1); \
      load_inst a1,     0(x1); \
      load_inst a1,    16(x1); \
      load_inst a1,    32(x1); \
      load_inst a1,    48(x1); \
      load_inst a1,    64(x1); \
      load_inst a1,    80(x1); \
      load_inst a1,    96(x1); \
      load_inst a1,   112(x1); \
      load_inst a1,   128(x1); \
      load_inst a1,     0(x1); \
      load_inst a1,    16(x1); \
      load_inst a1,    32(x1); \
      load_inst a1,    48(x1); \
      load_inst a1,    64(x1); \
      load_inst a1,    80(x1); \
      load_inst a1,    96(x1); \
      load_inst a1,   112(x1); \
    )

#define TEST_LD_OP( testnum, inst, result, offset, base ) \
    TEST_CASE( testnum, a1, result, \
      la  x1, base; \
      inst a1, offset(x1); \
    )

#define TEST_ST_OP( testnum, load_inst, store_inst, result, offset, base ) \
    TEST_CASE( testnum, a1, result, \
      la  x1, base; \
      li  a2, result; \
      store_inst a2, offset(x1); \
      load_inst a1, offset(x1); \
    )

#define TEST_LD_DEST_BYPASS( testnum, nop_cycles, inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x1, base; \
    inst a1, offset(x1); \
    TEST_INSERT_NOPS_ ## nop_cycles \
    addi  x6, a1, 0; \
    li  a2, result; \
    bne x6, a2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b; \

#define TEST_LD_SRC1_BYPASS( testnum, nop_cycles, inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x1, base; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst a1, offset(x1); \
    li  a2, result; \
    bne a1, a2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_ST_SRC12_BYPASS( testnum, src1_nops, src2_nops, load_inst, store_inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  x1, result; \
    TEST_INSERT_NOPS_ ## src1_nops \
    la  a2, base; \
    TEST_INSERT_NOPS_ ## src2_nops \
    store_inst x1, offset(a2); \
    load_inst a1, offset(a2); \
    li  a3, result; \
    bne a1, a3, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_ST_SRC21_BYPASS( testnum, src1_nops, src2_nops, load_inst, store_inst, result, offset, base ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  a2, base; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  x1, result; \
    TEST_INSERT_NOPS_ ## src2_nops \
    store_inst x1, offset(a2); \
    load_inst a1, offset(a2); \
    li  a3, result; \
    bne a1, a3, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_BR2_OP_TAKEN( testnum, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x1, val1; \
    li  a2, val2; \
    inst x1, a2, 2f; \
    bne x0, TESTNUM, fail; \
1:  bne x0, TESTNUM, 3f; \
2:  inst x1, a2, 1b; \
    bne x0, TESTNUM, fail; \
3:

#define TEST_BR2_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x1, val1; \
    li  a2, val2; \
    inst x1, a2, 1f; \
    bne x0, TESTNUM, 2f; \
1:  bne x0, TESTNUM, fail; \
2:  inst x1, a2, 1b; \
3:

#define TEST_BR2_SRC12_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  x1, val1; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  a2, val2; \
    TEST_INSERT_NOPS_ ## src2_nops \
    inst x1, a2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_BR2_SRC21_BYPASS( testnum, src1_nops, src2_nops, inst, val1, val2 ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  li  a2, val2; \
    TEST_INSERT_NOPS_ ## src1_nops \
    li  x1, val1; \
    TEST_INSERT_NOPS_ ## src2_nops \
    inst x1, a2, fail; \
    addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------

#define TEST_JR_SRC1_BYPASS( testnum, nop_cycles, inst ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x6, 2f; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst x6; \
    bne x0, TESTNUM, fail; \
2:  addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \

#define TEST_JALR_SRC1_BYPASS( testnum, nop_cycles, inst ) \
test_ ## testnum: \
    li  TESTNUM, testnum; \
    li  x4, 0; \
1:  la  x6, 2f; \
    TEST_INSERT_NOPS_ ## nop_cycles \
    inst a2, x6, 0; \
    bne x0, TESTNUM, fail; \
2:  addi  x4, x4, 1; \
    li  x5, 2; \
    bne x4, x5, 1b \


#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------

#define qNaNf 0f:7fc00000
#define sNaNf 0f:7f800001
#define qNaN 0d:7ff8000000000000
#define sNaN 0d:7ff0000000000001
///////////////////////////origin funct//////////////////////////////////////////////////////////
#define TEST_FP_OP_S_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  flw f0, 0(a0); \
  flw f1, 4(a0); \
  flw f2, 8(a0); \
  lw  a3, 12(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float val3; \
  .result; \
  .popsection
//Dzj:Newly added specially for rv32ud
#define TEST_FP_OP_S_INTERNAL_fcvt( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  flw f0, 0(a0); \
  flw f1, 4(a0); \
  flw f2, 8(a0); \
  lw  a3, 12(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float val1; \
  .float val2; \
  .float val3; \
  .result; \
  .popsection

//////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////origin funct//////////////////////////////////////////////////////
#define TEST_FP_OP_D_INTERNAL( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  ld  a3, 24(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fadd( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  a4, 28(a0);\
  code; \
  bne a4, a5, fail; \
  fsflags a1, x0; \
    li a2, flags; \
  bne t1, a3, fail; \
    bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fdiv( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  a4, 28(a0);\
  code; \
  bne a4, a5, fail; \
  fsflags a1, x0; \
    li a2, flags; \
  bne t1, a3, fail; \
    bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fcmp( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  code; \
  fsflags a1, x0; \
    li a2, flags; \
  bne a3, a0, fail; \
    bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fcvt( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  a4, 28(a0);\
  code; \
  bne a4, a5, fail; \
  bne t1, a3, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fcvt_w( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  code; \
  fsflags a1, x0; \
  li a2, flags; \
  bne a0, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fmadd( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  a4, 28(a0);\
  code; \
  bne a4, a5, fail; \
  fsflags a1, x0; \
  li a2, flags; \
  bne t1, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
//
#define TEST_FP_OP_D_INTERNAL_fmin( testnum, flags, result, val1, val2, val3, code... ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  fld f0, 0(a0); \
  fld f1, 8(a0); \
  fld f2, 16(a0); \
  lw  a3, 24(a0); \
  lw  a4, 28(a0);\
  code; \
  bne a4, a5, fail; \
  fsflags a1, x0; \
  li a2, flags; \
  bne t1, a3, fail; \
  bne a1, a2, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double val1; \
  .double val2; \
  .double val3; \
  .result; \
  .popsection
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////origin funct//////////////////////////////////////////////////////////////
#define TEST_FCVT_S_D( testnum, result, val1 ) \
  TEST_FP_OP_D_INTERNAL( testnum, 0, double result, val1, 0.0, 0.0, \
                    fcvt.s.d f3, f0; fcvt.d.s f3, f3; fmv.x.d a0, f3)


#define TEST_FCVT_S_D_fcvt( testnum, result, val1 ) \
  TEST_FP_OP_D_INTERNAL_fcvt( testnum, 0, double result, val1, 0.0, 0.0, \
                    fcvt.s.d f3, f0; fcvt.d.s f3, f3; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
/////////////////////////////////origin funct///////////////////////////////////////////////////////////////////////
#define TEST_FCVT_D_S( testnum, result, val1 ) \
  TEST_FP_OP_S_INTERNAL( testnum, 0, float result, val1, 0.0, 0.0, \
                    fcvt.d.s f3, f0; fcvt.s.d f3, f3; fmv.x.s a0, f3)
//
#define TEST_FCVT_D_S_fcvt( testnum, result, val1 ) \
  TEST_FP_OP_S_INTERNAL_fcvt( testnum, 0, float result, val1, 0.0, 0.0, \
                    fcvt.d.s f3, f0; fcvt.s.d f3, f3; fmv.x.s a0, f3)
////////////////////////////////////////////////////////////////////////////////////////////////
#define TEST_FP_OP1_S( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.s a0, f3)
/////////////////////////////////origin funct////////////////////////////////////////////////
#define TEST_FP_OP1_D( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.d a0, f3)
//
#define TEST_FP_OP1_D_fdiv( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D_INTERNAL_fdiv( testnum, flags, double result, val1, 0.0, 0.0, \
                    inst f3, f0;fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
/////////////////////////////////////////////////////////////////////////////////
#define TEST_FP_OP1_S_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.s a0, f3)
///////////////////////////////origin funct/////////////////////////////////////////////////
#define TEST_FP_OP1_D_DWORD_RESULT( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst f3, f0; fmv.x.d a0, f3)
//
#define TEST_FP_OP1_D_DWORD_RESULT_fdiv( testnum, inst, flags, result, val1 ) \
  TEST_FP_OP_D_INTERNAL_fdiv( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst f3, f0; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
//
////////////////////////////////////////////////////////////////////////////////////////////
#define TEST_FP_OP2_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, val2, 0.0, \
                    inst f3, f0, f1; fmv.x.s a0, f3)
/////////////////////////origin function/////////////////////////////////
#define TEST_FP_OP2_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, val2, 0.0, \
                    inst f3, f0, f1; fmv.x.d a0, f3)
//
#define TEST_FP_OP2_D_fadd( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_fadd( testnum, flags, double result, val1, val2, 0.0, \
                    inst f3, f0, f1; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
//
#define TEST_FP_OP2_D_fdiv( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_fdiv( testnum, flags, double result, val1, val2, 0.0, \
                    inst f3, f0, f1; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
//
#define TEST_FP_OP2_D_fmin( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_fmin( testnum, flags, double result, val1, val2, 0.0, \
                    inst f3, f0, f1; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
///////////////////////////////////////////////////////////////////////////////
#define TEST_FP_OP3_S( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, float result, val1, val2, val3, \
                    inst f3, f0, f1, f2; fmv.x.s a0, f3)
///////////////////////////origin funct//////////////////////////////////////////////////////////
#define TEST_FP_OP3_D( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, double result, val1, val2, val3, \
                    inst f3, f0, f1, f2; fmv.x.d a0, f3)

#define TEST_FP_OP3_D_fmadd( testnum, inst, flags, result, val1, val2, val3 ) \
  TEST_FP_OP_D_INTERNAL_fmadd( testnum, flags, double result, val1, val2, val3, \
                    inst f3, f0, f1, f2; fsd f3, 24(a0); lw t1 ,24(a0); lw a5,28(a0))
////////////////////////////////////////////////////////////////////////////////////////
#define TEST_FP_INT_OP_S( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, word result, val1, 0.0, 0.0, \
                    inst a0, f0, rm)
//////////////////////////origin funct//////////////////////////////////////////////////
#define TEST_FP_INT_OP_D( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst a0, f0, rm)
//
#define TEST_FP_INT_OP_D_fcvt_w( testnum, inst, flags, result, val1, rm ) \
  TEST_FP_OP_D_INTERNAL_fcvt_w( testnum, flags, dword result, val1, 0.0, 0.0, \
                    inst a0, f0, rm)
/////////////////////////////////////////////////////////////////////////
#define TEST_FP_CMP_OP_S( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_S_INTERNAL( testnum, flags, word result, val1, val2, 0.0, \
                    inst a0, f0, f1)
///////////////////////////origin funct/////////////////////////////////////////////
#define TEST_FP_CMP_OP_D( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL( testnum, flags, dword result, val1, val2, 0.0, \
                    inst a0, f0, f1)
//
#define TEST_FP_CMP_OP_D_fcmp( testnum, inst, flags, result, val1, val2 ) \
  TEST_FP_OP_D_INTERNAL_fcmp( testnum, flags, dword result, val1, val2, 0.0, \
                    inst a0, f0, f1)
///////////////////////////////////////////////////////////////////////////////////
#define TEST_FCLASS_S(testnum, correct, input) \
  TEST_CASE(testnum, a0, correct, li a0, input; fmv.s.x fa0, a0; \
                    fclass.s a0, fa0)
/////////////////////////origin function///////////////////////////////////////////////
#define TEST_FCLASS_D(testnum, correct, input) \
  TEST_CASE(testnum, a0, correct, li a0, input; fmv.d.x fa0, a0; \
                    fclass.d a0, fa0)
//
#define TEST_FCLASS_D_fclass(testnum, correct, input) \
    TEST_CASE_fclass(testnum, a0, correct, input, fld fa0,(a0); \
                        fclass.d a0, fa0)
//////////////////////////////////////////////////////////////////////////////////////
#define TEST_INT_FP_OP_S( testnum, inst, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  lw  a3, 0(a0); \
  li  a0, val1; \
  inst f0, a0; \
  fsflags x0; \
  fmv.x.s a0, f0; \
  bne a0, a3, fail; \
  .pushsection .data; \
  .align 2; \
  test_ ## testnum ## _data: \
  .float result; \
  .popsection
////////////////////////////////origin function/////////////////////////////////////////////////////
#define TEST_INT_FP_OP_D( testnum, inst, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  ld  a3, 0(a0); \
  li  a0, val1; \
  inst f0, a0; \
  fsflags x0; \
  fmv.x.d a0, f0; \
  bne a0, a3, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double result; \
  .popsection
//Dzj:Newly added specially for rv32ud
#define TEST_INT_FP_OP_D_fcvt( testnum, inst, result, val1 ) \
test_ ## testnum: \
  li  TESTNUM, testnum; \
  la  a0, test_ ## testnum ## _data ;\
  lw  a3, 0(a0);\
  lw  a4, 4(a0);\
  li  a1, val1; \
  inst f0, a1; \
  fsflags x0; \
  fsd  f0, 0(a0);\
  lw   t1, 0(a0);\
  lw   a5, 4(a0);\
  bne a4, a5, fail; \
  bne t1, a3, fail; \
  .pushsection .data; \
  .align 3; \
  test_ ## testnum ## _data: \
  .double result; \
  .popsection
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in TESTNUM)
#-----------------------------------------------------------------------

#define TEST_PASSFAIL \
        bne x0, TESTNUM, pass; \
fail: \
        RVTEST_FAIL; \
pass: \
        RVTEST_PASS \


#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------

#define TEST_DATA

#endif
