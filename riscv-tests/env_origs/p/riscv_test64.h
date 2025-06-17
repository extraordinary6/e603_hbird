// See LICENSE for license details.

#ifndef _ENV_PHYSICAL_SINGLE_CORE_H
#define _ENV_PHYSICAL_SINGLE_CORE_H

#include "e603_defines.h"
#include "../encoding64.h"
//-----------------------------------------------------------------------
// Begin Macro
//-----------------------------------------------------------------------

#define  INITIAL_X    \
        li   x1 , 0;\
        li   x2 , 0;\
        li   x3 , 0;\
        li   x4 , 0;\
        li   x5 , 0;\
        li   x6 , 5;\
        li   x7 , 6;\
        li   x8 , 7;\
        li   x9 , 8;\
        li   x10 , 9;\
        li   x11 , 10;\
        li   x12 , 11;\
        li   x13 , 12;\
        li   x14 , 13;\
        li   x15 , 14;\
        li   x16 , 15;\
        li   x17 , 16;\
        li   x18 , 17;\
        li   x19 , 18;\
        li   x20 , 19;\
        li   x21 , 20;\
        li   x22 , 21;\
        li   x23 , 22;\
        li   x24 , 23;\
        li   x25 , 24;\
        li   x26 , 25;\
        li   x27 , 26;\
        li   x28 , 27;\
        li   x29 , 28;\
        li   x31 , 29;\

#define RVTEST_RV64U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV64UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV32U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV32UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV64M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV64S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#define RVTEST_RV32M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV32S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#if __riscv_xlen == 64
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bgez a0, 1f; RVTEST_PASS; 1:
#else
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bltz a0, 1f; RVTEST_PASS; 1:
#endif

#define INIT_PMP                                                        \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  li t0, -1;        /* Set up a PMP to permit all accesses */           \
  csrw pmpaddr0, t0;                                                    \
  li t0, PMP_NAPOT | PMP_R | PMP_W | PMP_X;                             \
  csrw pmpcfg0, t0;                                                     \
  .align 2;                                                             \
1:

#define INIT_CLIC                                                       \
  li   x8, 1;                                                           \
  li   x9, N600_CLIC_BASE_ADDR;                                                  \
  sb   x8, 0(x9) ;                                                      \
  sb   x8, 4(x9) ;                                                      \
  sb   x8, 8(x9) ;                                                      \
  sb   x8, 12(x9) ;                                                      \
  sb   x8, 16(x9) ;                                                      \
  sb   x8, 20(x9) ;                                                      \
  sb   x8, 24(x9) ;                                                      \
  sb   x8, 28(x9) ;                                                      \
  sb   x8, 32(x9) ;                                                      \
  sb   x8, 36(x9) ;                                                      \
  sb   x8, 40(x9) ;                                                      \
  sb   x8, 44(x9) ;                                                      \
  sb   x8, 48(x9) ;                                                      \
  sb   x8, 52(x9) ;                                                      \
  sb   x8, 56(x9) ;                                                      \
  sb   x8, 60(x9) ;                                                      \
  sb   x8, 64(x9) ;                                                      \
  sb   x8, 68(x9) ;                                                      \
  sb   x8, 72(x9) ;                                                      \
  sb   x8, 76(x9) ;                                                      \
  sb   x8, 80(x9) ;                                                      \
  sb   x8, 84(x9) ;                                                      \
  sb   x8, 88(x9) ;                                                      \
  sb   x8, 92(x9) ;                                                      \
  sb   x8, 96(x9) ;                                                      \
  sb   x8, 100(x9) ;                                                      \
  sb   x8, 104(x9) ;                                                      \
  sb   x8, 108(x9) ;                                                      \
  sb   x8, 112(x9) ;                                                      \
  sb   x8, 116(x9) ;                                                      \
  sb   x8, 120(x9) ;                                                      \
  sb   x8, 124(x9) ;                                                      \
  sb   x8, 128(x9) ;                                                      \
  sb   x8, 132(x9) ;                                                      \
  sb   x8, 136(x9) ;                                                      \
  sb   x8, 140(x9) ;                                                      \
  sb   x8, 144(x9) ;                                                      \
  sb   x8, 148(x9) ;                                                      \
  sb   x8, 152(x9) ;                                                      \
  sb   x8, 156(x9) ;                                                      \
  sb   x8, 160(x9) ;                                                      \
  sb   x8, 164(x9) ;                                                      \
  sb   x8, 168(x9) ;                                                      \
  sb   x8, 172(x9) ;                                                      \
  sb   x8, 176(x9) ;                                                      \
  sb   x8, 180(x9) ;                                                      \
  sb   x8, 184(x9) ;                                                      \
  sb   x8, 188(x9) ;                                                      \
  sb   x8, 192(x9) ;                                                      \
  sb   x8, 196(x9) ;                                                      \
  sb   x8, 200(x9) ;                                                      \
  sb   x8, 204(x9) ;                                                      \
  sb   x8, 208(x9) ;                                                      \
  sb   x8, 212(x9) ;                                                      \
  sb   x8, 216(x9) ;                                                      \
  sb   x8, 220(x9) ;                                                      \
  sb   x8, 224(x9) ;                                                      \
  sb   x8, 228(x9) ;                                                      \
  sb   x8, 232(x9) ;                                                      \
  sb   x8, 236(x9) ;                                                      \
  sb   x8, 240(x9) ;                                                      \
  sb   x8, 244(x9) ;                                                      \
  sb   x8, 248(x9) ;                                                      \
  sb   x8, 252(x9) ;                                                      \
  sb   x8, 256(x9) ;                                                      \
  sb   x8, 260(x9) ;                                                      \
  sb   x8, 264(x9) ;                                                      \
  sb   x8, 268(x9) ;                                                      \
  sb   x8, 272(x9) ;                                                      \
  sb   x8, 276(x9) ;                                                      \
  sb   x8, 280(x9) ;                                                      \


#define INIT_SPTBR                                                      \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  csrwi sptbr, 0;                                                       \
  .align 2;                                                             \
1:

#define DELEGATE_NO_TRAPS                                               \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  csrwi medeleg, 0;                                                     \
  csrwi mideleg, 0;                                                     \
  csrwi mie, 0;                                                         \
  .align 2;                                                             \
1:

#define RVTEST_ENABLE_SUPERVISOR                                        \
  li a0, MSTATUS_MPP & (MSTATUS_MPP >> 1);                              \
  csrs mstatus, a0;                                                     \
  li a0, SIP_SSIP | SIP_STIP;                                           \
  csrs mideleg, a0;                                                     \

#define RVTEST_ENABLE_MACHINE                                           \
  li a0, MSTATUS_MPP;                                                   \
  csrs mstatus, a0;                                                     \

#define RVTEST_FP_ENABLE                                                \
  li a0, MSTATUS_FS & (MSTATUS_FS >> 1);                                \
  csrs mstatus, a0;                                                     \
  csrwi fcsr, 0

#define NONVEC_HANDLER_TRICK                                            \
    li a0, 0;                                                           \
    li a1, 0;                                                           \
    li a2, 0;                                                           \
    li a3, 0;                                                           \
    li a4, 0;                                                           \
    li a5, 0;                                                           \
    li a6, 0;                                                           \
    li a7, 0;                                                           \
    li t0, 0;                                                           \
    li t1, 0;                                                           \
    li t2, 0;                                                           \
    li t3, 0;                                                           \
    li t4, 0;                                                           \
    li t5, 0;                                                           \
    li t6, 0;                                                           \

#define RISCV_MULTICORE_DISABLE                                         \
  csrr a0, mhartid;                                                     \
  1: bnez a0, 1b
#define JUDGE_MCAUSE_VECTOR_HANDLER_CLOSE_IRQ\
        li a1,0xfff;\
        csrr a0, mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0x3;  /*software irq id*/\
        beq a0,a1,close_soft_irq; \
        li a1,0x7;  /*timer irq id*/\
        beq a0,a1,close_timer_irq; \
        li a1,0xb;  /*plic irq id*/\
        beq a0,a1,close_ext_irq; \
        li a1, 16;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq16_irq; \
        li a1, 17;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq17_irq; \
        li a1, 18;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq18_irq; \
        li a1, 19;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq19_irq; \
        li a1, 20;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq20_irq; \
        li a1, 21;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq21_irq; \
        li a1, 22;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq22_irq; \
        li a1, 23;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq23_irq; \
        li a1, 24;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq24_irq; \
        li a1, 25;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq25_irq; \
        li a1, 26;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq26_irq; \
        li a1, 27;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq27_irq; \
        li a1, 28;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq28_irq; \
        li a1, 29;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq29_irq; \
        li a1, 30;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq30_irq; \
        li a1, 31;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq31_irq; \
        li a1, 32;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq32_irq; \
        li a1, 33;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq33_irq; \
        li a1, 34;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq34_irq; \
        li a1, 35;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq35_irq; \
        li a1, 36;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq36_irq; \
        li a1, 37;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq37_irq; \
        li a1, 38;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq38_irq; \
        li a1, 39;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq39_irq; \
        li a1, 40;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq40_irq; \
        li a1, 41;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq41_irq; \
        li a1, 42;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq42_irq; \
        li a1, 43;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq43_irq; \
        li a1, 44;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq44_irq; \
        li a1, 45;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq45_irq; \
        li a1, 46;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq46_irq; \
        li a1, 47;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq47_irq; \
        li a1, 48;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq48_irq; \
        li a1, 49;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq49_irq; \
        li a1, 50;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq50_irq; \
        li a1, 51;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq51_irq; \
        li a1, 52;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq52_irq; \
        li a1, 53;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq53_irq; \
        li a1, 54;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq54_irq; \
        li a1, 55;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq55_irq; \
        li a1, 56;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq56_irq; \
        li a1, 57;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq57_irq; \
        li a1, 58;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq58_irq; \
        li a1, 59;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq59_irq; \
        li a1, 60;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq60_irq; \
        li a1, 61;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq61_irq; \
        li a1, 62;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq62_irq; \
        li a1, 63;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq63_irq; \
        li a1, 64;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq64_irq; \
        li a1, 65;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq65_irq; \
        li a1, 66;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq66_irq; \
        li a1, 67;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq67_irq; \
        li a1, 68;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq68_irq; \
        li a1, 69;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq69_irq; \
        li a1, 70;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq70_irq; \

#define EXTRA_TVEC_USER
#define EXTRA_TVEC_MACHINE
#define EXTRA_INIT
#define EXTRA_INIT_TIMER

#define INTERRUPT_HANDLER \
j other_exception;\


#define RVTEST_CODE_BEGIN                                               \
        .section .text.init;                                            \
        .align  6;                                                      \
        .weak stvec_handler;                                            \
        .weak mtvec_handler;                                            \
        .weak nmi_handlers;                                            \
        .weak user_trap_vector;                                            \
        .weak illegal_instruction_handler_pit;\
        .weak clic_user_trap_vector;                                            \
        .weak standard_clic_mtvt2_handler; \
        .weak standard_clic_mnxti_handler; \
        .weak test_wfi1; \
        .weak test_wfi2; \
        .globl _start;                                                  \
_start:                                                                 \
\
        /*Bruce add conditional jump for nmi handler*/ \
        /*addi sp, sp, -2*4;*/ \
        /*sd t5, 0*4(sp);*/\
        /*sd t6, 1*4(sp);*/\
#ifdef N600_CFG_HAS_IOCC \
        li t0,0x80005000;\
        li t1, 1;\
        sd t1, 0(t0);\
#endif \
        csrr t6,CSR_MISC_CTL;       \
        andi t6,t6,0x200;\
        bnez t6, ignore_nmi_judge;\
\
        csrr t6, mcause; \
        andi t6, t6, 0x7ff;\
        xori t6,t6,0x1;\
        beqz t6, nmi_interrupt;\
ignore_nmi_judge:\
        INITIAL_X ;               \
        /* reset vector */                                              \
        j  reset_vector;                                                \
        .align 2;                                                       \
\
trap_vector:                                                            \
        /* test whether the test came from pass/fail */                 \
        /* Bob: since we have added the random irq */                   \
        /* Bob:  we need to save-and-restore the registers: begin */    \
        csrw mscratch, a0;                                              \
        la  a0, test_trap_data ;                                        \
        sd t5, 0(a0);                                                   \
        sd t6, 8(a0);                                                   \
  .pushsection .data; \
  .align 2; \
  test_trap_data: \
  .word 0; \
  .word 0; \
  .word 0; \
  .word 0; \
  .popsection \
/*upper code is used for compatibility of old ccts, there is no use for new ccts*/\
        /* was it an interrupt or an exception? */                      \
        csrr t5, mcause;                                                \
        bgez t5, handle_exception;                                      \
  interrupt_handler:                                              \
        li a1,0xfff;\
        csrr a0, mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0x3;  /*software irq id*/\
        beq a0,a1,trap_vector_close_soft_irq; \
        li a1,0xfff;\
        csrr a0, mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0x7;  /*timer irq id*/\
        beq a0,a1,trap_vector_close_timer_irq; \
        li a1,0xfff;\
        csrr a0 , mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0xb;  /*plic irq id*/\
        beq a0,a1,trap_vector_close_ext_irq; \
        li a1,0xfff;\
        csrr a0 , mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,16;  /*irq 16*/\
        beq a0,a1,trap_vector_close_irq16; \
        li a1,0xfff;\
        csrr a0 , mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,17;  /*irq 17*/\
        beq a0,a1,trap_vector_close_irq17; \
        li a1,0xfff;\
        csrr a0 , mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,18;  /*irq 18*/\
        beq a0,a1,trap_vector_close_irq18; \
        j other_exception;/* No interrupts should occur */ \
        trap_vector_close_ext_irq:\
        li a0,  0x2;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_soft_irq:\
        li a0,  0x3;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_timer_irq:\
        li a0,  0x4;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_nmi_irq:\
        li a0,  0x6;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_irq16:\
        li a0, 16;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_irq17:\
        li a0, 17;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
        trap_vector_close_irq18:\
        li a0, 18;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j trap_vector_restore_rountine;\
  handle_exception:                                                       \
        li t5, 0xfff;                                                       \
        csrr t6, mcause;                                                    \
        and t5, t6, t5;                                                 \
        li t6, CAUSE_NMI;                                        \
        beq t5, t6,trap_vector_close_nmi_irq;                                       \
        li t6, CAUSE_USER_ECALL;                                        \
        beq t5, t6, write_tohost;                                       \
        li t6, CAUSE_SUPERVISOR_ECALL;                                  \
        beq t5, t6, write_tohost;                                       \
        li t6, CAUSE_MACHINE_ECALL;                                     \
        beq t5, t6, write_tohost;                                       \
        /* Bob: Here to check bus-error : Begin */                   \
        li t6, CAUSE_ILLEGAL_INSTRUCTION;                                     \
        beq t5, t6, illegal_instruction_handler;                                      \
        li t6, CAUSE_FETCH_ACCESS;                                     \
        beq t5, t6, ifetch_error_handler;                                      \
        li t6, CAUSE_LOAD_ACCESS;                                     \
        beq t5, t6, load_error_handler;                                      \
        li t6, CAUSE_STORE_ACCESS;                                     \
        beq t5, t6, store_error_handler;                                      \
        li t6, CAUSE_BREAKPOINT;                                        \
        beq t5, t6, ebreak_handler;                                     \
        li t6, CAUSE_MISALIGNED_FETCH;                                        \
        beq t5, t6, misaligned_fetch_handler;                                     \
        li t6,CAUSE_MISALIGNED_LOAD;                                        \
        beq t5, t6, misaligned_load_handler;                                     \
        li t6,CAUSE_MISALIGNED_STORE;                                        \
        beq t5, t6, misaligned_store_handler;                                     \
        /* Bob: Here to check bus-error : end */      \
        /* if an mtvec_handler is defined, jump to it */                \
        /*la t5, mtvec_handler; */\
        /*beqz t5, 1f;*/                                                    \
        /*jr t5;*/                                                          \
  other_exception:                                                      \
        /* some unhandlable exception occurred */                       \
        /* Bob add IRQ Cause here: begin */                       \
  trap_vector_restore_rountine:\
      /*--- Restore ABI registers with interrupts enabled -(14)*/\
        ld ra, 18*8(sp);       /* Restore return address*/\
        ld t6, 17*8(sp);    /* Restore temporaries.*/\
        ld t5, 16*8(sp);    /* Restore temporaries.*/\
        ld t4, 15*8(sp);    /* Restore temporaries.*/\
        ld t3, 14*8(sp);    /* Restore temporaries.*/\
        ld t2, 13*8(sp);    /* Restore temporaries.*/\
        ld t1, 12*8(sp);    /* Restore temporaries.*/\
        ld t0, 11*8(sp);    /* Restore temporaries.*/\
        ld a7, 10*8(sp);    /* Restore other arguments.*/\
        ld a6,  9*8(sp);    /* Restore other arguments.*/\
        ld a5,  8*8(sp);    /* Restore other arguments.*/\
        ld a4,  7*8(sp);    /* Restore other arguments.*/\
        ld a3,  6*8(sp);    /* Restore other arguments.*/\
        ld a1,  4*8(sp);       /* Get saved mcause,*/\
        ld a0,  3*8(sp);       /* Get saved mepc.*/\
        bgez a1, 1f;            /*ignore saving xstatus if exception happens*/\
        la a2,standard_clic_mnxti_handler; /*if define standard_clic_mnxti_handler, ignore saving xstatus*/\
        bnez a2,trap_vector_ignore_xstatus_save;\
        ld a2, 5*8(sp);    /*Get saved xstatus*/\
        csrw CSR_XSTATUS, a2;   /*Restore previous context.*/\
trap_vector_ignore_xstatus_save:\
1:      csrw mcause, a1;         /* Restore previous context.*/\
        csrw mepc, a0 ;          /* Restore previous context.*/\
        ld a2, 2*8(sp);         /*Restore original a2 value.*/\
        ld a0, 1*8(sp) ;      /* Restore original a1 value.*/\
        ld a1, 0*8(sp);       /* Restore original a0 value.*/\
        addi sp, sp, 20*8;/* Reclaim stack space.*/\
        mret;\
  write_tohost:                                                         \
        slli a1, x3, 16;        \
        addi a1, a1, 0x1;   \
        csrw mscratch, a1;  /*tell testbench*/   \
        sd TESTNUM, tohost, t5;                                         \
        j write_tohost;                                                 \
        /* Bob add IRQ handler here: begin */                       \
  ifetch_error_handler:                                                         \
  load_error_handler:                                                         \
  store_error_handler:                                                         \
  misaligned_fetch_handler:                                                         \
        csrr a0, mbadaddr;                                              \
        j trap_vector_restore_rountine;\
  illegal_instruction_handler:\
        csrr a0, mbadaddr;                                              \
        la a0, illegal_instruction_handler_pit;\
        beqz a0, trap_vector_restore_rountine;                                                    \
        jr a0;\
  misaligned_load_handler:                                               \
  misaligned_store_handler:                                              \
  ebreak_handler:                                                         \
        csrr a0, mbadaddr;                                              \
        ld ra, 18*8(sp);       /* Restore return address*/\
        ld t6, 17*8(sp);    /* Restore temporaries.*/\
        ld t5, 16*8(sp);    /* Restore temporaries.*/\
        ld t4, 15*8(sp);    /* Restore temporaries.*/\
        ld t3, 14*8(sp);    /* Restore temporaries.*/\
        ld t2, 13*8(sp);    /* Restore temporaries.*/\
        ld t1, 12*8(sp);    /* Restore temporaries.*/\
        ld t0, 11*8(sp);    /* Restore temporaries.*/\
        ld a7, 10*8(sp);    /* Restore other arguments.*/\
        ld a6,  9*8(sp);    /* Restore other arguments.*/\
        ld a5,  8*8(sp);    /* Restore other arguments.*/\
        ld a4,  7*8(sp);    /* Restore other arguments.*/\
        ld a3,  6*8(sp);    /* Restore other arguments.*/\
        ld a1,  4*8(sp);       /* Get saved mcause,*/\
        ld a0,  3*8(sp);       /* Get saved mepc.*/\
        csrw mcause, a1;         /* Restore previous context.*/\
        addi a0,a0,0x04;                                                \
        csrw mepc, a0 ;          /* Restore previous context.*/\
        ld a2, 2*8(sp) ;      /* Restore original a2 value.*/\
        ld a0, 1*8(sp) ;      /* Restore original a0 value.*/\
        ld a1, 0*8(sp);       /* Restore original a1 value.*/\
        addi sp, sp, 20*8;/* Reclaim stack space.*/\
/*sdith to machine mode*/\
        li a0, MSTATUS_MPP;\
        csrs mstatus, a0;                                                     \
        mret;\
.align 2;\
  nmi_interrupt:                                                        \
/*disable nmi_irq by writting mscratch*/\
        li t6, 0x6;\
        csrw mscratch,t6;\
        mret;   /*jump back to the saved mepc*/                                \
        /* Bob add handler here: End */                       \
  vector_irq_handler:                                                         \
        addi sp, sp, -10*8;     \
        sd a0, 0*8(sp);           /* Save a0.*/ \
        sd a1, 1*8(sp);           /* Save a1.*/ \
        sd a2, 2*8(sp);           /* Save a1.*/ \
        csrr a0, mcause;         /* Get mcause of interrupted context.*/ \
        sd a0,3*8(sp);       /* Save a0.*/ \
        csrr a1, mepc;           /* Get mepc of interrupt context.*/ \
        sd a1, 4*8(sp);       /* Save mepc.*/ \
        csrr a2, CSR_XSTATUS; /*Get xstatus of interrupt context.*/ \
        sd a2, 5*8(sp);     /*Save xstatus*/\
        csrsi mstatus,  0x8;/*enable interrupt*/\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
   csrrw a2, CSR_MSCRATCHCSW, a1;        \
   csrrw a2, CSR_MSCRATCHCSWL, a1;        \
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
#ifdef N600_CFG_SHARE_MULDIV \
        div a0,a1,a0;\
#endif  \
#ifdef N600_CFG_INDEP_MULDIV \
        div a0,a1,a0;\
#endif  \
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        csrci mstatus,  0x8; /*disable interrupt*/\
        ld a2, 5*8(sp);       /* Get saved xstatus.*/\
        csrw CSR_XSTATUS, a2 ;          /* Restore previous context.*/\
        ld a1, 4*8(sp);       /* Get saved mepc.*/\
        csrw mepc, a1 ;          /* Restore previous context.*/\
        ld a0, 3*8(sp) ;      /* Get saved mcause*/\
        csrw mcause, a0;         /* Restore previous context.*/\
        JUDGE_MCAUSE_VECTOR_HANDLER_CLOSE_IRQ;\
        j trap_rountine1;\
  close_ext_irq: \
        li a0,  0x2;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  close_soft_irq: \
        li a0,  0x3;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  close_timer_irq: \
        li a0,0x4;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  vector_handler_close_irq16_irq: \
        li a0,16;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq17_irq: \
        li a0,17;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq18_irq: \
        li a0,18;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq19_irq: \
        li a0,19;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq20_irq: \
        li a0,20;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq21_irq: \
        li a0,21;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq22_irq: \
        li a0,22;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq23_irq: \
        li a0,23;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq24_irq: \
        li a0,24;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq25_irq: \
        li a0,25;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq26_irq: \
        li a0,26;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq27_irq: \
        li a0,27;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq28_irq: \
        li a0,28;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq29_irq: \
        li a0,29;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq30_irq: \
        li a0,30;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq31_irq: \
        li a0,31;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq32_irq: \
        li a0,32;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq33_irq: \
        li a0,33;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq34_irq: \
        li a0,34;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq35_irq: \
        li a0,35;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq36_irq: \
        li a0,36;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq37_irq: \
        li a0,37;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq38_irq: \
        li a0,38;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq39_irq: \
        li a0,39;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq40_irq: \
        li a0,40;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq41_irq: \
        li a0,41;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq42_irq: \
        li a0,42;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq43_irq: \
        li a0,43;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq44_irq: \
        li a0,44;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq45_irq: \
        li a0,45;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq46_irq: \
        li a0,46;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq47_irq: \
        li a0,47;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq48_irq: \
        li a0,48;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq49_irq: \
        li a0,49;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq50_irq: \
        li a0,50;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq51_irq: \
        li a0,51;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq52_irq: \
        li a0,52;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq53_irq: \
        li a0,53;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq54_irq: \
        li a0,54;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq55_irq: \
        li a0,55;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq56_irq: \
        li a0,56;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq57_irq: \
        li a0,57;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq58_irq: \
        li a0,58;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq59_irq: \
        li a0,59;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq60_irq: \
        li a0,60;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq61_irq: \
        li a0,61;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq62_irq: \
        li a0,62;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq63_irq: \
        li a0,63;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq64_irq: \
        li a0,64;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq65_irq: \
        li a0,65;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq66_irq: \
        li a0,66;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq67_irq: \
        li a0,67;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq68_irq: \
        li a0,68;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq69_irq: \
        li a0,69;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq70_irq: \
        li a0,70;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  trap_rountine1:\
        ld a2, 2*8(sp);       /* Restore original a2 value.*/\
        ld a1, 1*8(sp);       /* Restore original a1 value.*/\
        ld a0, 0*8(sp);       /* Restore original a0 value.*/\
        addi sp, sp, 10*8;/* Reclaim stack space.*/\
        mret;   /*jump back to the saved mepc*/                                \
  common_handler_close_ext_irq: \
        li a0,  0x2;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        ret; \
  common_handler_close_soft_irq: \
        li a0,  0x3;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        ret; \
  common_handler_close_timer_irq: \
        li a0,0x4;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        ret; \
  common_handler_close_irq16_irq: \
        li a0,16;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq17_irq: \
        li a0,17;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq18_irq: \
        li a0,18;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq19_irq: \
        li a0,19;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq20_irq: \
        li a0,20;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq21_irq: \
        li a0,21;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq22_irq: \
        li a0,22;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq23_irq: \
        li a0,23;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq24_irq: \
        li a0,24;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq25_irq: \
        li a0,25;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq26_irq: \
        li a0,26;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq27_irq: \
        li a0,27;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq28_irq: \
        li a0,28;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq29_irq: \
        li a0,29;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq30_irq: \
        li a0,30;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq31_irq: \
        li a0,31;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq32_irq: \
        li a0,32;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq33_irq: \
        li a0,33;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq34_irq: \
        li a0,34;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq35_irq: \
        li a0,35;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq36_irq: \
        li a0,36;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq37_irq: \
        li a0,37;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq38_irq: \
        li a0,38;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq39_irq: \
        li a0,39;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq40_irq: \
        li a0,40;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq41_irq: \
        li a0,41;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq42_irq: \
        li a0,42;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq43_irq: \
        li a0,43;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq44_irq: \
        li a0,44;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq45_irq: \
        li a0,45;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq46_irq: \
        li a0,46;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq47_irq: \
        li a0,47;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq48_irq: \
        li a0,48;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq49_irq: \
        li a0,49;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq50_irq: \
        li a0,50;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq51_irq: \
        li a0,51;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq52_irq: \
        li a0,52;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq53_irq: \
        li a0,53;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq54_irq: \
        li a0,54;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq55_irq: \
        li a0,55;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq56_irq: \
        li a0,56;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq57_irq: \
        li a0,57;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq58_irq: \
        li a0,58;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq59_irq: \
        li a0,59;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq60_irq: \
        li a0,60;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq61_irq: \
        li a0,61;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq62_irq: \
        li a0,62;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq63_irq: \
        li a0,63;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq64_irq: \
        li a0,64;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq65_irq: \
        li a0,65;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq66_irq: \
        li a0,66;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq67_irq: \
        li a0,67;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq68_irq: \
        li a0,68;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq69_irq: \
        li a0,69;       \
        csrw mscratch, a0; \
        ret; \
  common_handler_close_irq70_irq: \
        li a0,70;       \
        csrw mscratch, a0; \
        ret; \
  common_irq_handler:                                                         \
        NONVEC_HANDLER_TRICK;                                   \
        la a2,test_wfi2; /*is*/\
        bnez a2,test_mstratch2;\
   csrrw t2, CSR_MSCRATCHCSW, t1;        \
   csrrw t2, CSR_MSCRATCHCSWL, t1;        \
  test_mstratch2:;\
        li a1,0xfff;\
        csrr a0, mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0x3;  /*software irq id*/\
        beq a0,a1,common_handler_close_soft_irq; \
        li a1,0x7;  /*timer irq id*/\
        beq a0,a1,common_handler_close_timer_irq; \
        li a1,0xb;  /*plic irq id*/\
        beq a0,a1,common_handler_close_ext_irq; \
        li a1, 16;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq16_irq; \
        li a1, 17;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq17_irq; \
        li a1, 18;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq18_irq; \
        li a1, 19;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq19_irq; \
        li a1, 20;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq20_irq; \
        li a1, 21;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq21_irq; \
        li a1, 22;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq22_irq; \
        li a1, 23;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq23_irq; \
        li a1, 24;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq24_irq; \
        li a1, 25;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq25_irq; \
        li a1, 26;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq26_irq; \
        li a1, 27;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq27_irq; \
        li a1, 28;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq28_irq; \
        li a1, 29;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq29_irq; \
        li a1, 30;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq30_irq; \
        li a1, 31;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq31_irq; \
        li a1, 32;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq32_irq; \
        li a1, 33;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq33_irq; \
        li a1, 34;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq34_irq; \
        li a1, 35;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq35_irq; \
        li a1, 36;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq36_irq; \
        li a1, 37;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq37_irq; \
        li a1, 38;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq38_irq; \
        li a1, 39;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq39_irq; \
        li a1, 40;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq40_irq; \
        li a1, 41;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq41_irq; \
        li a1, 42;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq42_irq; \
        li a1, 43;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq43_irq; \
        li a1, 44;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq44_irq; \
        li a1, 45;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq45_irq; \
        li a1, 46;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq46_irq; \
        li a1, 47;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq47_irq; \
        li a1, 48;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq48_irq; \
        li a1, 49;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq49_irq; \
        li a1, 50;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq50_irq; \
        li a1, 51;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq51_irq; \
        li a1, 52;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq52_irq; \
        li a1, 53;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq53_irq; \
        li a1, 54;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq54_irq; \
        li a1, 55;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq55_irq; \
        li a1, 56;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq56_irq; \
        li a1, 57;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq57_irq; \
        li a1, 58;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq58_irq; \
        li a1, 59;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq59_irq; \
        li a1, 60;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq60_irq; \
        li a1, 61;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq61_irq; \
        li a1, 62;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq62_irq; \
        li a1, 63;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq63_irq; \
        li a1, 64;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq64_irq; \
        li a1, 65;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq65_irq; \
        li a1, 66;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq66_irq; \
        li a1, 67;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq67_irq; \
        li a1, 68;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq68_irq; \
        li a1, 69;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq69_irq; \
        li a1, 70;  /*external irq id*/\
        beq a0,a1,common_handler_close_irq70_irq; \
        ret;\
  .align 6; \
  common_base_handler:        \
    addi sp, sp, -20*8;      \
    sd a1, 0*8(sp);           /* Save a1.*/ \
    csrr a1, mcause;         /* Get mcause of interrupted context.*/ \
    sd a0,1*8(sp);       /* Save a0.*/ \
    csrr a0, mepc;           /* Get mepc of interrupt context.*/ \
    sd a2,2*8(sp);       /* Save a2.*/ \
    la a2,standard_clic_mnxti_handler; /*if define standard_clic_mnxti_handler, ignore saving xstatus*/\
    bnez a2,ignore_xstatus_save;\
    csrr a2,CSR_XSTATUS; /*Get xstatus of interrupt context.*/\
    sd a2, 5*8(sp);    /* Save xstatus of interrupted context.*/ \
ignore_xstatus_save: \
    sd a0, 3*8(sp);       /* Save mepc.*/ \
    sd a1, 4*8(sp);       /* Save mcause of interrupted context.*/ \
    sd a3, 6*8(sp);    /* Save other argument registers.*/ \
    sd a4, 7*8(sp);    /* Save other argument registers.*/ \
    sd a5, 8*8(sp);    /* Save other argument registers.*/ \
    sd a6, 9*8(sp);    /* Save other argument registers.*/ \
    sd a7, 10*8(sp);    /* Save other argument registers.*/ \
    sd t0, 11*8(sp);    /* Save temporaries.*/ \
    sd t1, 12*8(sp);    /* Save temporaries.*/ \
    sd t2, 13*8(sp);    /* Save temporaries.*/ \
    sd t3, 14*8(sp);    /* Save temporaries.*/ \
    sd t4, 15*8(sp);    /* Save temporaries.*/ \
    sd t5, 16*8(sp);    /* Save temporaries.*/ \
    sd t6, 17*8(sp);    /* Save temporaries.*/ \
    sd ra, 18*8(sp);       /* 1 return address (5)*/ \
    la t3, clic_user_trap_vector; /* If clic_user_trap_vector is defined, jump to clic_user_trap_vector */ \
    beqz t3, 1f;             \
	jr t3;                   \
  1:                           \
    bgez a1, trap_vector;     /* Handle synchronous exception. (3)*/ \
    csrr a0, mtvec;                         \
    andi a0, a0, 0x3f;\
    li a1, 0x3;\
    bne a0,a1,trap_vector; /*if mtvec[5:0]!=0b000011 which means it's in clint mode, jump to trap_vector*/\
  clic_label:              /* If clic_user_trap_vector is defined, PC should jump back from clic_user_trap_vector */   \
    zxlab_test: /*zaixin:add a lab for some test*/\
    csrrsi a0, CSR_MNXTI, MSTATUS_MIE;   /* Get highest current interrupt and enable interrupts.*/ \
  /*----Interrupts enabled ---------------------(7)*/\
    beqz a0, exit;           /* Check if original interrupt vanished. (8)*/\
  service_loop:             /* 5 instructions in pending-interrupt service loop.*/\
    ld a1, (a0);             /* Indirect into handler vector table for function pointer. (9)*/\
    csrrsi x0, mstatus, MSTATUS_MIE; /* Ensure interrupts enabled. (10)*/\
    jalr a1;                 /* Call C ABI Routine, a0 has interrupt ID encoded. (11)*/\
                            /* Routine must clear down interrupt in CLIC.*/\
    csrrsi a0, CSR_MNXTI, MSTATUS_MIE;   /* Claim any pending interrupt at level > mcause.pil (12)*/\
    bnez a0, service_loop;   /* Loop to service any interrupt. (13)*/\
    la a2,test_wfi1; /*is*/\
    bnez a2,test_mstratch1;\
   csrrw t2, CSR_MSCRATCHCSW, t1;        \
   csrrw t2, CSR_MSCRATCHCSWL, t1;        \
test_mstratch1:;\
  /*--- Restore ABI registers with interrupts enabled -(14)*/\
    ld ra, 18*8(sp);       /* Restore return address*/\
    ld t6, 17*8(sp);    /* Restore temporaries.*/\
    ld t5, 16*8(sp);    /* Restore temporaries.*/\
    ld t4, 15*8(sp);    /* Restore temporaries.*/\
    ld t3, 14*8(sp);    /* Restore temporaries.*/\
    ld t2, 13*8(sp);    /* Restore temporaries.*/\
    ld t1, 12*8(sp);    /* Restore temporaries.*/\
    ld t0, 11*8(sp);    /* Restore temporaries.*/\
    ld a7, 10*8(sp);    /* Restore other arguments.*/\
    ld a6, 9*8(sp);    /* Restore other arguments.*/\
    ld a5, 8*8(sp);    /* Restore other arguments.*/\
    ld a4, 7*8(sp);    /* Restore other arguments.*/\
    ld a3, 6*8(sp);    /* Restore other arguments.*/\
  exit:                     /* Fast exit point.*/\
    la a2,standard_clic_mnxti_handler; /*if define standard_clic_mnxti_handler, ignore restore xstatus*/\
    bnez a2,ignore_xstatus_restore;\
    ld a2, 5*8(sp);    /*Get saved xstatus.*/\
    csrw CSR_XSTATUS,a2;    /*Restroe previous xstatus.*/\
ignore_xstatus_restore:\
    ld a1, 4*8(sp);       /* Get saved mcause,*/\
    ld a0, 3*8(sp);       /* Get saved mepc.*/\
    csrrci x0, mstatus, MSTATUS_MIE; /* Disable interrupts (15)*/\
  /*---- Critical section with interrupts disabled -----------------------*/\
    ld a2, 2*8(sp) ;      /* Restore original a2 value.*/\
    csrw mcause, a1;         /* Restore previous context.*/\
    ld a1, 0*8(sp) ;      /* Restore original a1 value.*/\
    csrw mepc, a0 ;          /* Restore previous context.*/\
    csrrci a0,CSR_MNXTI, MSTATUS_MIE;   /* Claim highest current interrupt. (16)*/\
    bnez a0, service_loop;   /* Go around if new interrupt.*/\
    ld a0, 1*8(sp);       /* Restore original a0 value.*/\
    addi sp, sp, 20*8;/* Reclaim stack space.*/\
    mret;                    /* Return from interrupt.*/\
  .align 6; \
  mtvt2_base_handler:        \
    addi sp, sp, -20*8;      \
    sd a0, 0*8(sp);       /* Save a0*/ \
    sd a1, 1*8(sp);       /* Save a1*/ \
    csrrwi x0, CSR_PUSHMCAUSE, 2;/*Save mcause*/\
    csrrwi x0, CSR_PUSHMEPC, 3;/*Save mepc*/\
    sd a2, 4*8(sp);    /* Save other argument registers.*/ \
    csrrwi x0, CSR_PUSHMXSTATUS, 5;/*Save xstatus*/\
    sd a3, 6*8(sp);    /* Save other argument registers.*/ \
    sd a4, 7*8(sp);    /* Save other argument registers.*/ \
    sd a5, 8*8(sp);    /* Save other argument registers.*/ \
    sd a6, 9*8(sp);    /* Save other argument registers.*/ \
    sd a7, 10*8(sp);    /* Save other argument registers.*/ \
    sd t0, 11*8(sp);    /* Save temporaries.*/ \
    sd t1, 12*8(sp);    /* Save temporaries.*/ \
    sd t2, 13*8(sp);    /* Save temporaries.*/ \
    sd t3, 14*8(sp);    /* Save temporaries.*/ \
    sd t4, 15*8(sp);    /* Save temporaries.*/ \
    sd t5, 16*8(sp);    /* Save temporaries.*/ \
    sd t6, 17*8(sp);    /* Save temporaries.*/ \
    sd ra, 18*8(sp);       /* 1 return address (5)*/ \
  mtvt2_service_loop:            \
/*Replace to a new CSR read/write operation, which is actually Claim the CLIC to find*/\
/* its pending highest ID, if the ID is not 0, then automatically enable the mstatus.MIE*/\
/* , and jump to its vector-entry-label, and update the link register */\
    csrrw ra, CSR_JALMNXTI,ra;\
    /*csrrs a0, CSR_MNXTI, 0;\*/\
    /*bnez a0, mtvt2_service_loop;    Loop to service any interrupt. (13)*/\
  /*--- Restore ABI registers with interrupts enabled -(14)*/\
    ld ra, 18*8(sp);       /* Restore return address*/\
    ld t6, 17*8(sp);    /* Restore temporaries.*/\
    ld t5, 16*8(sp);    /* Restore temporaries.*/\
    ld t4, 15*8(sp);    /* Restore temporaries.*/\
    ld t3, 14*8(sp);    /* Restore temporaries.*/\
    ld t2, 13*8(sp);    /* Restore temporaries.*/\
    ld t1, 12*8(sp);    /* Restore temporaries.*/\
    ld t0, 11*8(sp);    /* Restore temporaries.*/\
    ld a7, 10*8(sp);    /* Restore other arguments.*/\
    ld a6, 9*8(sp);    /* Restore other arguments.*/\
    ld a5, 9*8(sp);    /* Restore other arguments.*/\
    ld a4, 7*8(sp);    /* Restore other arguments.*/\
    ld a3, 6*8(sp);    /* Restore other arguments.*/\
    ld a2, 5*8(sp);    /* Get saved mxstatus*/\
    csrw CSR_XSTATUS, a2;\
    ld a2, 4*8(sp);\
    ld a0, 3*8(sp);       /* Get saved mepc,*/\
    ld a1, 2*8(sp);       /* Get saved mcause.*/\
    csrrci x0, mstatus, MSTATUS_MIE; /* Disable interrupts (15)*/\
  /*---- Critical section with interrupts disabled -----------------------*/\
    csrw mcause, a1 ;          /* Restore previous context.*/\
    ld a1, 1*8(sp) ;      /* Restore original a1 value.*/\
    csrw mepc, a0;         /* Restore previous context.*/\
    csrrs a0, CSR_MNXTI, 0;      /*check if there is pending interrupt*/\
    bnez a0, mtvt2_service_loop;   /* Go around if new interrupt.*/\
    ld a0, 0*8(sp);       /* Restore original a0 value.*/\
    addi sp, sp, 20*8;/* Reclaim stack space.*/\
    mret;                    /* Return from interrupt.*/\
                                                                \
  .align 12;                                                       \
  mtvt_base: \
/*irq_0*/   .dword vector_irq_handler;                                                          \
/*irq_1*/   .dword common_irq_handler;                                                          \
/*irq_2*/   .dword vector_irq_handler;                                                          \
/*irq_3*/   .dword common_irq_handler;                                                          \
/*irq_4*/   .dword vector_irq_handler;                                                          \
/*irq_5*/   .dword common_irq_handler;                                                          \
/*irq_6*/   .dword vector_irq_handler;                                                          \
/*irq_7*/   .dword common_irq_handler;                                                          \
/*irq_8*/   .dword vector_irq_handler;                                                          \
/*irq_9*/   .dword common_irq_handler;                                                          \
/*irq_10*/  .dword vector_irq_handler;                                                          \
/*irq_11*/  .dword common_irq_handler;                                                          \
/*irq_12*/  .dword vector_irq_handler;                                                          \
/*irq_13*/  .dword common_irq_handler;                                                          \
/*irq_14*/  .dword vector_irq_handler;                                                          \
/*irq_15*/  .dword common_irq_handler;                                                          \
/*irq_16*/  .dword vector_irq_handler;                                                          \
/*irq_17*/  .dword common_irq_handler;                                                          \
/*irq_18*/  .dword vector_irq_handler;                                                          \
/*irq_19*/  .dword common_irq_handler;                                                          \
/*irq_20*/  .dword vector_irq_handler;                                                          \
/*irq_21*/  .dword common_irq_handler;                                                          \
/*irq_22*/  .dword vector_irq_handler;                                                          \
/*irq_23*/  .dword common_irq_handler;                                                          \
/*irq_24*/  .dword vector_irq_handler;                                                          \
/*irq_25*/  .dword common_irq_handler;                                                          \
/*irq_26*/  .dword vector_irq_handler;                                                          \
/*irq_27*/  .dword common_irq_handler;                                                          \
/*irq_28*/  .dword vector_irq_handler;                                                          \
/*irq_29*/  .dword common_irq_handler;                                                          \
/*irq_30*/  .dword vector_irq_handler;                                                          \
/*irq_31*/  .dword common_irq_handler;                                                          \
/*irq_32*/  .dword vector_irq_handler;                                                          \
/*irq_33*/  .dword common_irq_handler;                                                          \
/*irq_34*/  .dword vector_irq_handler;                                                          \
/*irq_35*/  .dword common_irq_handler;                                                          \
/*irq_36*/  .dword vector_irq_handler;                                                          \
/*irq_37*/  .dword common_irq_handler;                                                          \
/*irq_38*/  .dword vector_irq_handler;                                                          \
/*irq_39*/  .dword common_irq_handler;                                                          \
/*irq_40*/  .dword vector_irq_handler;                                                          \
/*irq_41*/  .dword common_irq_handler;                                                          \
/*irq_42*/  .dword vector_irq_handler;                                                          \
/*irq_43*/  .dword common_irq_handler;                                                          \
/*irq_44*/  .dword vector_irq_handler;                                                          \
/*irq_45*/  .dword common_irq_handler;                                                          \
/*irq_46*/  .dword vector_irq_handler;                                                          \
/*irq_47*/  .dword common_irq_handler;                                                          \
/*irq_48*/  .dword vector_irq_handler;                                                          \
/*irq_49*/  .dword common_irq_handler;                                                          \
/*irq_50*/  .dword vector_irq_handler;                                                          \
/*irq_51*/  .dword common_irq_handler;                                                          \
/*irq_52*/  .dword vector_irq_handler;                                                          \
/*irq_53*/  .dword common_irq_handler;                                                          \
/*irq_54*/  .dword vector_irq_handler;                                                          \
/*irq_55*/  .dword common_irq_handler;                                                          \
/*irq_56*/  .dword vector_irq_handler;                                                          \
/*irq_57*/  .dword common_irq_handler;                                                          \
/*irq_58*/  .dword vector_irq_handler;                                                          \
/*irq_59*/  .dword common_irq_handler;                                                          \
/*irq_60*/  .dword vector_irq_handler;                                                          \
/*irq_61*/  .dword common_irq_handler;                                                          \
/*irq_62*/  .dword vector_irq_handler;                                                          \
/*irq_63*/  .dword common_irq_handler;                                                          \
/*irq_64*/  .dword vector_irq_handler;                                                          \
/*irq_65*/  .dword common_irq_handler;                                                          \
/*irq_66*/  .dword vector_irq_handler;                                                          \
/*irq_67*/  .dword common_irq_handler;                                                          \
/*irq_68*/  .dword vector_irq_handler;                                                          \
/*irq_69*/  .dword common_irq_handler;                                                          \
/*irq_70*/  .dword vector_irq_handler;                                                          \
reset_vector:                                                           \
        /*Bruce allocate stack point end address*/          \
		.option push;                                       \
		.option norelax;                                    \
		la gp, __global_pointer$;                             \
		.option pop;                                           \
        la t0, _sp;                                                      \
        mv sp, t0;                                                      \
        /* Bob Initialize t5 and t6 here: Begin */                       \
        mv t5, x0;                                                  \
        mv t6, x0;                                                  \
        /* Bob Initialize t5 and t6 here: End */                       \
        RISCV_MULTICORE_DISABLE;                                        \
        /*INIT_SPTBR;*/                                                     \
        /*INIT_PMP;*/                                                       \
        /*DELEGATE_NO_TRAPS;*/                                              \
        /*li TESTNUM, 0; */                                                 \
        /*Bob added code to enable the interrupt enables: begin*/              \
        li a0, MSTATUS_MIE;                                                   \
        csrs mstatus, a0;                                                     \
        li a0, 0xFFFFFFFF;                                                   \
        csrs mie, a0;                                                     \
        /*Bob added code to enable the interrupt enables: End*/              \
        la t0,  nmi_interrupt;\
        csrw CSR_MNVEC, t0;\
        la t0, common_base_handler;                                             \
        csrw mtvec, t0;                                                 \
        la t0, mtvt_base;                                             \
        /*csrw CSR_MTVT, t0;*/                                               \
        /*csrr t1, CSR_MISC_CTL; */                                            \
        li t2, 0x200;                                                     \
        or t1,t1,t2;                                                        \
        csrw CSR_MISC_CTL,t1;                                                  \
        csrw mscratch, 0x5;/*This is to tell testbench this point*/ \
        #ifdef N600_CFG_HAS_ICACHE \
        csrw CSR_MCACHECTL , 0x1;                                     \
        #endif \
        #ifdef N600_CFG_HAS_DCACHE  \
        li t2, 0x10000; \
        csrs CSR_MCACHECTL, t2; \
        #endif \
        /*CHECK_XLEN;*/                                                     \
        /* if an stvec_handler is defined, delegate exceptions to it */ \
post_mtvec:                                            \
        /* Set MPIE and MPP*/              \
        li a0, MSTATUS_MPIE | MSTATUS_MPP;                                                   \
        csrs mstatus, a0;                                                     \
        init;                                                           \
        EXTRA_INIT;                                                     \
        EXTRA_INIT_TIMER;                                               \
        /*INIT_CLIC; */                                                     \
        li t0, 0xffffffff;                                              \
        csrw mie,t0;                                                    \
        la t0, 1f;                                                      \
        csrw mepc, t0;                                                  \
        csrr a0, mhartid;                                               \
        mret;                                                           \
1:

//-----------------------------------------------------------------------
// End Macro
//-----------------------------------------------------------------------

#define RVTEST_CODE_END                                                 \
        unimp

//-----------------------------------------------------------------------
// Pass/Fail Macro
//-----------------------------------------------------------------------

#define RVTEST_PASS                                                     \
        fence;                                                          \
        la t0, _sp;                                                      \
        mv sp, t0;                                                      \
        li gp, 1;                                                  \
        ecall; \
        nop ;\
        nop ;\
        .space 0x100,0


#define TESTNUM tp
#define RVTEST_FAIL                                                     \
        fence;                                                          \
        li TESTNUM, 0;                                                  \
        ecall

//-----------------------------------------------------------------------
// Data Section Macro
//-----------------------------------------------------------------------

#define EXTRA_DATA

#define RVTEST_DATA_BEGIN                                               \
        EXTRA_DATA                                                      \
        .pushsection .tohost,"aw",@progbits;                            \
        .align 6; .global tohost; tohost: .dword 0;                     \
        .align 6; .global fromhost; fromhost: .dword 0;                 \
        .popsection;                                                    \
        .align 4; .global begin_signature; begin_signature:

#define RVTEST_DATA_END .align 4; .global end_signature; end_signature:

#endif
