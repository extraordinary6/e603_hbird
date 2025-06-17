# See LICENSE for license details.

#*****************************************************************************
# dsp_shift32.S
#-----------------------------------------------------------------------------
#
# Test DSP shift16 operation.
#

#define SRAU_OP(testnum, in, imm, exp)      \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  sra.u t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define SRAIU_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  srai.u t2, t0, imm   ;                    \
/*  .word (0xd40293ff | (imm <<20))   ; */  \
  bne t2, t1, fail     ;                    

#define KSLLW_OP(testnum, in, imm, exp)     \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  ksllw t2, t0, t1     ;                    \
  bne t3, t2, fail     ;                    

#define KSLLIW_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, exp           ;                    \
  kslliw t2, t0, imm   ;                    \
  bne t2, t1, fail     ;                    

#define KSLRAW_OP(testnum, in, imm, exp)    \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslraw t2, t0, t1    ;                    \
  bne t3, t2, fail     ;                    

#define KSLRAWU_OP(testnum, in, imm, exp)   \
  li TESTNUM, testnum  ;                    \
  li t0, in            ;                    \
  li t1, imm           ;                    \
  li t3, exp           ;                    \
  kslraw.u t2, t0, t1  ;                    \
  bne t3, t2, fail     ;                    

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2

#ifdef N600_CFG_HAS_DSP

#########################################################################
# srau
#########################################################################
# sign bit is 0
  SRAU_OP( 2, 0x1234abcd,  0, 0x1234abcd)
  SRAU_OP( 3, 0x1234abcd,  1, 0x091a55e7)
  SRAU_OP( 4, 0x1234abcd,  2, 0x048d2af3)
  SRAU_OP( 5, 0x1234abcd,  3, 0x0246957a)
  SRAU_OP( 6, 0x1234abcd,  4, 0x01234abd)
  SRAU_OP( 7, 0x1234abcd,  5, 0x0091a55e)
  SRAU_OP( 8, 0x1234abcd,  6, 0x0048d2af)
  SRAU_OP( 9, 0x1234abcd,  7, 0x00246958)
  SRAU_OP(10, 0x1234abcd,  8, 0x001234ac)
  SRAU_OP(11, 0x1234abcd,  9, 0x00091a56)
  SRAU_OP(12, 0x1234abcd, 10, 0x00048d2b)
  SRAU_OP(13, 0x1234abcd, 11, 0x00024695)
  SRAU_OP(14, 0x1234abcd, 12, 0x0001234b)
  SRAU_OP(15, 0x1234abcd, 13, 0x000091a5)
  SRAU_OP(16, 0x1234abcd, 14, 0x000048d3)
  SRAU_OP(17, 0x1234abcd, 15, 0x00002469)
  SRAU_OP(18, 0x1234abcd, 16, 0x00001235)
  SRAU_OP(19, 0x1234abcd, 17, 0x0000091a)
  SRAU_OP(20, 0x1234abcd, 18, 0x0000048d)
  SRAU_OP(21, 0x1234abcd, 19, 0x00000247)
  SRAU_OP(22, 0x1234abcd, 20, 0x00000123)
  SRAU_OP(23, 0x1234abcd, 21, 0x00000092)
  SRAU_OP(24, 0x1234abcd, 22, 0x00000049)
  SRAU_OP(25, 0x1234abcd, 23, 0x00000024)
  SRAU_OP(26, 0x1234abcd, 24, 0x00000012)
  SRAU_OP(27, 0x1234abcd, 25, 0x00000009)
  SRAU_OP(28, 0x1234abcd, 26, 0x00000005)
  SRAU_OP(29, 0x1234abcd, 27, 0x00000002)
  SRAU_OP(30, 0x1234abcd, 28, 0x00000001)
  SRAU_OP(31, 0x1234abcd, 29, 0x00000001)
  SRAU_OP(32, 0x1234abcd, 30, 0x00000000)
  SRAU_OP(33, 0x1234abcd, 31, 0x00000000)

# sign bit is 1
  SRAU_OP(34, 0xabcd1234,  0, 0xabcd1234)
  SRAU_OP(35, 0xabcd1234,  1, 0xd5e6891a)
  SRAU_OP(36, 0xabcd1234,  2, 0xeaf3448d)
  SRAU_OP(37, 0xabcd1234,  3, 0xf579a247)
  SRAU_OP(38, 0xabcd1234,  4, 0xfabcd123)
  SRAU_OP(39, 0xabcd1234,  5, 0xfd5e6892)
  SRAU_OP(40, 0xabcd1234,  6, 0xfeaf3449)
  SRAU_OP(41, 0xabcd1234,  7, 0xff579a24)
  SRAU_OP(42, 0xabcd1234,  8, 0xffabcd12)
  SRAU_OP(43, 0xabcd1234,  9, 0xffd5e689)
  SRAU_OP(44, 0xabcd1234, 10, 0xffeaf345)
  SRAU_OP(45, 0xabcd1234, 11, 0xfff579a2)
  SRAU_OP(46, 0xabcd1234, 12, 0xfffabcd1)
  SRAU_OP(47, 0xabcd1234, 13, 0xfffd5e69)
  SRAU_OP(48, 0xabcd1234, 14, 0xfffeaf34)
  SRAU_OP(49, 0xabcd1234, 15, 0xffff579a)
  SRAU_OP(50, 0xabcd1234, 16, 0xffffabcd)
  SRAU_OP(51, 0xabcd1234, 17, 0xffffd5e7)
  SRAU_OP(52, 0xabcd1234, 18, 0xffffeaf3)
  SRAU_OP(53, 0xabcd1234, 19, 0xfffff57a)
  SRAU_OP(54, 0xabcd1234, 20, 0xfffffabd)
  SRAU_OP(55, 0xabcd1234, 21, 0xfffffd5e)
  SRAU_OP(56, 0xabcd1234, 22, 0xfffffeaf)
  SRAU_OP(57, 0xabcd1234, 23, 0xffffff58)
  SRAU_OP(58, 0xabcd1234, 24, 0xffffffac)
  SRAU_OP(59, 0xabcd1234, 25, 0xffffffd6)
  SRAU_OP(50, 0xabcd1234, 26, 0xffffffeb)
  SRAU_OP(61, 0xabcd1234, 27, 0xfffffff5)
  SRAU_OP(62, 0xabcd1234, 28, 0xfffffffb)
  SRAU_OP(63, 0xabcd1234, 29, 0xfffffffd)
  SRAU_OP(64, 0xabcd1234, 30, 0xffffffff)
  SRAU_OP(65, 0xabcd1234, 31, 0xffffffff)

#########################################################################
# sraiu
#########################################################################
# sign bit is 0
  SRAIU_OP(66, 0x1234abcd,  0, 0x1234abcd)
  SRAIU_OP(67, 0x1234abcd,  1, 0x091a55e7)
  SRAIU_OP(68, 0x1234abcd,  2, 0x048d2af3)
  SRAIU_OP(69, 0x1234abcd,  3, 0x0246957a)
  SRAIU_OP(70, 0x1234abcd,  4, 0x01234abd)
  SRAIU_OP(71, 0x1234abcd,  5, 0x0091a55e)
  SRAIU_OP(72, 0x1234abcd,  6, 0x0048d2af)
  SRAIU_OP(73, 0x1234abcd,  7, 0x00246958)
  SRAIU_OP(74, 0x1234abcd,  8, 0x001234ac)
  SRAIU_OP(75, 0x1234abcd,  9, 0x00091a56)
  SRAIU_OP(76, 0x1234abcd, 10, 0x00048d2b)
  SRAIU_OP(77, 0x1234abcd, 11, 0x00024695)
  SRAIU_OP(78, 0x1234abcd, 12, 0x0001234b)
  SRAIU_OP(79, 0x1234abcd, 13, 0x000091a5)
  SRAIU_OP(80, 0x1234abcd, 14, 0x000048d3)
  SRAIU_OP(81, 0x1234abcd, 15, 0x00002469)
  SRAIU_OP(82, 0x1234abcd, 16, 0x00001235)
  SRAIU_OP(83, 0x1234abcd, 17, 0x0000091a)
  SRAIU_OP(84, 0x1234abcd, 18, 0x0000048d)
  SRAIU_OP(85, 0x1234abcd, 19, 0x00000247)
  SRAIU_OP(86, 0x1234abcd, 20, 0x00000123)
  SRAIU_OP(87, 0x1234abcd, 21, 0x00000092)
  SRAIU_OP(88, 0x1234abcd, 22, 0x00000049)
  SRAIU_OP(89, 0x1234abcd, 23, 0x00000024)
  SRAIU_OP(90, 0x1234abcd, 24, 0x00000012)
  SRAIU_OP(91, 0x1234abcd, 25, 0x00000009)
  SRAIU_OP(92, 0x1234abcd, 26, 0x00000005)
  SRAIU_OP(93, 0x1234abcd, 27, 0x00000002)
  SRAIU_OP(94, 0x1234abcd, 28, 0x00000001)
  SRAIU_OP(95, 0x1234abcd, 29, 0x00000001)
  SRAIU_OP(96, 0x1234abcd, 30, 0x00000000)
  SRAIU_OP(97, 0x1234abcd, 31, 0x00000000)
            
# sign bit is 1
  SRAIU_OP( 98, 0xabcd1234,  0, 0xabcd1234)
  SRAIU_OP( 99, 0xabcd1234,  1, 0xd5e6891a)
  SRAIU_OP(100, 0xabcd1234,  2, 0xeaf3448d)
  SRAIU_OP(101, 0xabcd1234,  3, 0xf579a247)
  SRAIU_OP(102, 0xabcd1234,  4, 0xfabcd123)
  SRAIU_OP(103, 0xabcd1234,  5, 0xfd5e6892)
  SRAIU_OP(104, 0xabcd1234,  6, 0xfeaf3449)
  SRAIU_OP(105, 0xabcd1234,  7, 0xff579a24)
  SRAIU_OP(106, 0xabcd1234,  8, 0xffabcd12)
  SRAIU_OP(107, 0xabcd1234,  9, 0xffd5e689)
  SRAIU_OP(108, 0xabcd1234, 10, 0xffeaf345)
  SRAIU_OP(109, 0xabcd1234, 11, 0xfff579a2)
  SRAIU_OP(120, 0xabcd1234, 12, 0xfffabcd1)
  SRAIU_OP(121, 0xabcd1234, 13, 0xfffd5e69)
  SRAIU_OP(122, 0xabcd1234, 14, 0xfffeaf34)
  SRAIU_OP(123, 0xabcd1234, 15, 0xffff579a)
  SRAIU_OP(124, 0xabcd1234, 16, 0xffffabcd)
  SRAIU_OP(125, 0xabcd1234, 17, 0xffffd5e7)
  SRAIU_OP(126, 0xabcd1234, 18, 0xffffeaf3)
  SRAIU_OP(127, 0xabcd1234, 19, 0xfffff57a)
  SRAIU_OP(128, 0xabcd1234, 20, 0xfffffabd)
  SRAIU_OP(129, 0xabcd1234, 21, 0xfffffd5e)
  SRAIU_OP(130, 0xabcd1234, 22, 0xfffffeaf)
  SRAIU_OP(131, 0xabcd1234, 23, 0xffffff58)
  SRAIU_OP(132, 0xabcd1234, 24, 0xffffffac)
  SRAIU_OP(133, 0xabcd1234, 25, 0xffffffd6)
  SRAIU_OP(134, 0xabcd1234, 26, 0xffffffeb)
  SRAIU_OP(135, 0xabcd1234, 27, 0xfffffff5)
  SRAIU_OP(136, 0xabcd1234, 28, 0xfffffffb)
  SRAIU_OP(137, 0xabcd1234, 29, 0xfffffffd)
  SRAIU_OP(138, 0xabcd1234, 30, 0xffffffff)
  SRAIU_OP(139, 0xabcd1234, 31, 0xffffffff)

#########################################################################
# ksllw 
#########################################################################
# sign bit is 0
  KSLLW_OP(140, 0x0000abcd,  0, 0x0000abcd)
  KSLLW_OP(141, 0x0000abcd,  1, 0x0001579a)
  KSLLW_OP(142, 0x0000abcd,  2, 0x0002af34)
  KSLLW_OP(143, 0x0000abcd,  3, 0x00055e68)
  KSLLW_OP(144, 0x0000abcd,  4, 0x000abcd0)
  KSLLW_OP(145, 0x0000abcd,  5, 0x001579a0)
  KSLLW_OP(146, 0x0000abcd,  6, 0x002af340)
  KSLLW_OP(147, 0x0000abcd,  7, 0x0055e680)
  KSLLW_OP(148, 0x0000abcd,  8, 0x00abcd00)
  KSLLW_OP(149, 0x0000abcd,  9, 0x01579a00)
  KSLLW_OP(150, 0x0000abcd, 10, 0x02af3400)
  KSLLW_OP(151, 0x0000abcd, 11, 0x055e6800)
  KSLLW_OP(152, 0x0000abcd, 12, 0x0abcd000)
  KSLLW_OP(153, 0x0000abcd, 13, 0x1579a000)
  KSLLW_OP(154, 0x0000abcd, 14, 0x2af34000)
  KSLLW_OP(155, 0x0000abcd, 15, 0x55e68000)
  KSLLW_OP(156, 0x0000abcd, 16, 0x7fffffff)
  KSLLW_OP(157, 0x0000abcd, 17, 0x7fffffff)
  KSLLW_OP(158, 0x0000abcd, 18, 0x7fffffff)
  KSLLW_OP(159, 0x0000abcd, 19, 0x7fffffff)
  KSLLW_OP(160, 0x0000abcd, 20, 0x7fffffff)
  KSLLW_OP(161, 0x0000abcd, 21, 0x7fffffff)
  KSLLW_OP(162, 0x0000abcd, 22, 0x7fffffff)
  KSLLW_OP(163, 0x0000abcd, 23, 0x7fffffff)
  KSLLW_OP(164, 0x0000abcd, 24, 0x7fffffff)
  KSLLW_OP(165, 0x0000abcd, 25, 0x7fffffff)
  KSLLW_OP(166, 0x0000abcd, 26, 0x7fffffff)
  KSLLW_OP(167, 0x0000abcd, 27, 0x7fffffff)
  KSLLW_OP(168, 0x0000abcd, 28, 0x7fffffff)
  KSLLW_OP(169, 0x0000abcd, 29, 0x7fffffff)
  KSLLW_OP(170, 0x0000abcd, 30, 0x7fffffff)
  KSLLW_OP(171, 0x0000abcd, 31, 0x7fffffff)

# sign bit is 1
  KSLLW_OP(172, 0xffff1234,  0, 0xffff1234)
  KSLLW_OP(173, 0xffff1234,  1, 0xfffe2468)
  KSLLW_OP(174, 0xffff1234,  2, 0xfffc48d0)
  KSLLW_OP(175, 0xffff1234,  3, 0xfff891a0)
  KSLLW_OP(176, 0xffff1234,  4, 0xfff12340)
  KSLLW_OP(177, 0xffff1234,  5, 0xffe24680)
  KSLLW_OP(178, 0xffff1234,  6, 0xffc48d00)
  KSLLW_OP(179, 0xffff1234,  7, 0xff891a00)
  KSLLW_OP(180, 0xffff1234,  8, 0xff123400)
  KSLLW_OP(181, 0xffff1234,  9, 0xfe246800)
  KSLLW_OP(182, 0xffff1234, 10, 0xfc48d000)
  KSLLW_OP(183, 0xffff1234, 11, 0xf891a000)
  KSLLW_OP(184, 0xffff1234, 12, 0xf1234000)
  KSLLW_OP(185, 0xffff1234, 13, 0xe2468000)
  KSLLW_OP(186, 0xffff1234, 14, 0xc48d0000)
  KSLLW_OP(187, 0xffff1234, 15, 0x891a0000)
  KSLLW_OP(188, 0xffff1234, 16, 0x80000000)
  KSLLW_OP(189, 0xffff1234, 17, 0x80000000)
  KSLLW_OP(190, 0xffff1234, 18, 0x80000000)
  KSLLW_OP(191, 0xffff1234, 19, 0x80000000)
  KSLLW_OP(192, 0xffff1234, 20, 0x80000000)
  KSLLW_OP(193, 0xffff1234, 21, 0x80000000)
  KSLLW_OP(194, 0xffff1234, 22, 0x80000000)
  KSLLW_OP(195, 0xffff1234, 23, 0x80000000)
  KSLLW_OP(196, 0xffff1234, 24, 0x80000000)
  KSLLW_OP(197, 0xffff1234, 25, 0x80000000)
  KSLLW_OP(198, 0xffff1234, 26, 0x80000000)
  KSLLW_OP(199, 0xffff1234, 27, 0x80000000)
  KSLLW_OP(200, 0xffff1234, 28, 0x80000000)
  KSLLW_OP(201, 0xffff1234, 29, 0x80000000)
  KSLLW_OP(202, 0xffff1234, 30, 0x80000000)
  KSLLW_OP(203, 0xffff1234, 31, 0x80000000)

#########################################################################
# kslliw 
#########################################################################
# sign bit is 0
  KSLLIW_OP(204, 0x0000abcd,  0, 0x0000abcd)
  KSLLIW_OP(205, 0x0000abcd,  1, 0x0001579a)
  KSLLIW_OP(206, 0x0000abcd,  2, 0x0002af34)
  KSLLIW_OP(207, 0x0000abcd,  3, 0x00055e68)
  KSLLIW_OP(208, 0x0000abcd,  4, 0x000abcd0)
  KSLLIW_OP(209, 0x0000abcd,  5, 0x001579a0)
  KSLLIW_OP(210, 0x0000abcd,  6, 0x002af340)
  KSLLIW_OP(211, 0x0000abcd,  7, 0x0055e680)
  KSLLIW_OP(212, 0x0000abcd,  8, 0x00abcd00)
  KSLLIW_OP(213, 0x0000abcd,  9, 0x01579a00)
  KSLLIW_OP(214, 0x0000abcd, 10, 0x02af3400)
  KSLLIW_OP(215, 0x0000abcd, 11, 0x055e6800)
  KSLLIW_OP(216, 0x0000abcd, 12, 0x0abcd000)
  KSLLIW_OP(217, 0x0000abcd, 13, 0x1579a000)
  KSLLIW_OP(218, 0x0000abcd, 14, 0x2af34000)
  KSLLIW_OP(219, 0x0000abcd, 15, 0x55e68000)
  KSLLIW_OP(220, 0x0000abcd, 16, 0x7fffffff)
  KSLLIW_OP(221, 0x0000abcd, 17, 0x7fffffff)
  KSLLIW_OP(222, 0x0000abcd, 18, 0x7fffffff)
  KSLLIW_OP(223, 0x0000abcd, 19, 0x7fffffff)
  KSLLIW_OP(224, 0x0000abcd, 20, 0x7fffffff)
  KSLLIW_OP(225, 0x0000abcd, 21, 0x7fffffff)
  KSLLIW_OP(226, 0x0000abcd, 22, 0x7fffffff)
  KSLLIW_OP(227, 0x0000abcd, 23, 0x7fffffff)
  KSLLIW_OP(228, 0x0000abcd, 24, 0x7fffffff)
  KSLLIW_OP(229, 0x0000abcd, 25, 0x7fffffff)
  KSLLIW_OP(230, 0x0000abcd, 26, 0x7fffffff)
  KSLLIW_OP(231, 0x0000abcd, 27, 0x7fffffff)
  KSLLIW_OP(232, 0x0000abcd, 28, 0x7fffffff)
  KSLLIW_OP(233, 0x0000abcd, 29, 0x7fffffff)
  KSLLIW_OP(234, 0x0000abcd, 30, 0x7fffffff)
  KSLLIW_OP(235, 0x0000abcd, 31, 0x7fffffff)

# sign bit is 1
  KSLLIW_OP(236, 0xffff1234,  0, 0xffff1234)
  KSLLIW_OP(237, 0xffff1234,  1, 0xfffe2468)
  KSLLIW_OP(238, 0xffff1234,  2, 0xfffc48d0)
  KSLLIW_OP(239, 0xffff1234,  3, 0xfff891a0)
  KSLLIW_OP(240, 0xffff1234,  4, 0xfff12340)
  KSLLIW_OP(241, 0xffff1234,  5, 0xffe24680)
  KSLLIW_OP(242, 0xffff1234,  6, 0xffc48d00)
  KSLLIW_OP(243, 0xffff1234,  7, 0xff891a00)
  KSLLIW_OP(244, 0xffff1234,  8, 0xff123400)
  KSLLIW_OP(245, 0xffff1234,  9, 0xfe246800)
  KSLLIW_OP(246, 0xffff1234, 10, 0xfc48d000)
  KSLLIW_OP(247, 0xffff1234, 11, 0xf891a000)
  KSLLIW_OP(248, 0xffff1234, 12, 0xf1234000)
  KSLLIW_OP(249, 0xffff1234, 13, 0xe2468000)
  KSLLIW_OP(250, 0xffff1234, 14, 0xc48d0000)
  KSLLIW_OP(251, 0xffff1234, 15, 0x891a0000)
  KSLLIW_OP(252, 0xffff1234, 16, 0x80000000)
  KSLLIW_OP(253, 0xffff1234, 17, 0x80000000)
  KSLLIW_OP(254, 0xffff1234, 18, 0x80000000)
  KSLLIW_OP(255, 0xffff1234, 19, 0x80000000)
  KSLLIW_OP(256, 0xffff1234, 20, 0x80000000)
  KSLLIW_OP(257, 0xffff1234, 21, 0x80000000)
  KSLLIW_OP(258, 0xffff1234, 22, 0x80000000)
  KSLLIW_OP(259, 0xffff1234, 23, 0x80000000)
  KSLLIW_OP(260, 0xffff1234, 24, 0x80000000)
  KSLLIW_OP(261, 0xffff1234, 25, 0x80000000)
  KSLLIW_OP(262, 0xffff1234, 26, 0x80000000)
  KSLLIW_OP(263, 0xffff1234, 27, 0x80000000)
  KSLLIW_OP(264, 0xffff1234, 28, 0x80000000)
  KSLLIW_OP(265, 0xffff1234, 29, 0x80000000)
  KSLLIW_OP(266, 0xffff1234, 30, 0x80000000)
  KSLLIW_OP(267, 0xffff1234, 31, 0x80000000)
              
#########################################################################
# kslraw
#########################################################################
#### left shift
# sign bit is 0
  KSLRAW_OP(268, 0x0000abcd,  0, 0x0000abcd)
  KSLRAW_OP(279, 0x0000abcd,  1, 0x0001579a)
  KSLRAW_OP(280, 0x0000abcd,  2, 0x0002af34)
  KSLRAW_OP(281, 0x0000abcd,  3, 0x00055e68)
  KSLRAW_OP(282, 0x0000abcd,  4, 0x000abcd0)
  KSLRAW_OP(283, 0x0000abcd,  5, 0x001579a0)
  KSLRAW_OP(284, 0x0000abcd,  6, 0x002af340)
  KSLRAW_OP(285, 0x0000abcd,  7, 0x0055e680)
  KSLRAW_OP(286, 0x0000abcd,  8, 0x00abcd00)
  KSLRAW_OP(287, 0x0000abcd,  9, 0x01579a00)
  KSLRAW_OP(288, 0x0000abcd, 10, 0x02af3400)
  KSLRAW_OP(289, 0x0000abcd, 11, 0x055e6800)
  KSLRAW_OP(290, 0x0000abcd, 12, 0x0abcd000)
  KSLRAW_OP(291, 0x0000abcd, 13, 0x1579a000)
  KSLRAW_OP(292, 0x0000abcd, 14, 0x2af34000)
  KSLRAW_OP(293, 0x0000abcd, 15, 0x55e68000)
  KSLRAW_OP(294, 0x0000abcd, 16, 0x7fffffff)
  KSLRAW_OP(295, 0x0000abcd, 17, 0x7fffffff)
  KSLRAW_OP(296, 0x0000abcd, 18, 0x7fffffff)
  KSLRAW_OP(297, 0x0000abcd, 19, 0x7fffffff)
  KSLRAW_OP(298, 0x0000abcd, 20, 0x7fffffff)
  KSLRAW_OP(299, 0x0000abcd, 21, 0x7fffffff)
  KSLRAW_OP(300, 0x0000abcd, 22, 0x7fffffff)
  KSLRAW_OP(301, 0x0000abcd, 23, 0x7fffffff)
  KSLRAW_OP(302, 0x0000abcd, 24, 0x7fffffff)
  KSLRAW_OP(303, 0x0000abcd, 25, 0x7fffffff)
  KSLRAW_OP(304, 0x0000abcd, 26, 0x7fffffff)
  KSLRAW_OP(305, 0x0000abcd, 27, 0x7fffffff)
  KSLRAW_OP(306, 0x0000abcd, 28, 0x7fffffff)
  KSLRAW_OP(307, 0x0000abcd, 29, 0x7fffffff)
  KSLRAW_OP(308, 0x0000abcd, 30, 0x7fffffff)
  KSLRAW_OP(309, 0x0000abcd, 31, 0x7fffffff)

# sign bit is 1
  KSLRAW_OP(310, 0xffff1234,  0, 0xffff1234)
  KSLRAW_OP(311, 0xffff1234,  1, 0xfffe2468)
  KSLRAW_OP(312, 0xffff1234,  2, 0xfffc48d0)
  KSLRAW_OP(313, 0xffff1234,  3, 0xfff891a0)
  KSLRAW_OP(314, 0xffff1234,  4, 0xfff12340)
  KSLRAW_OP(315, 0xffff1234,  5, 0xffe24680)
  KSLRAW_OP(316, 0xffff1234,  6, 0xffc48d00)
  KSLRAW_OP(317, 0xffff1234,  7, 0xff891a00)
  KSLRAW_OP(318, 0xffff1234,  8, 0xff123400)
  KSLRAW_OP(319, 0xffff1234,  9, 0xfe246800)
  KSLRAW_OP(320, 0xffff1234, 10, 0xfc48d000)
  KSLRAW_OP(321, 0xffff1234, 11, 0xf891a000)
  KSLRAW_OP(322, 0xffff1234, 12, 0xf1234000)
  KSLRAW_OP(323, 0xffff1234, 13, 0xe2468000)
  KSLRAW_OP(324, 0xffff1234, 14, 0xc48d0000)
  KSLRAW_OP(325, 0xffff1234, 15, 0x891a0000)
  KSLRAW_OP(326, 0xffff1234, 16, 0x80000000)
  KSLRAW_OP(327, 0xffff1234, 17, 0x80000000)
  KSLRAW_OP(328, 0xffff1234, 18, 0x80000000)
  KSLRAW_OP(329, 0xffff1234, 19, 0x80000000)
  KSLRAW_OP(330, 0xffff1234, 20, 0x80000000)
  KSLRAW_OP(331, 0xffff1234, 21, 0x80000000)
  KSLRAW_OP(332, 0xffff1234, 22, 0x80000000)
  KSLRAW_OP(333, 0xffff1234, 23, 0x80000000)
  KSLRAW_OP(334, 0xffff1234, 24, 0x80000000)
  KSLRAW_OP(335, 0xffff1234, 25, 0x80000000)
  KSLRAW_OP(336, 0xffff1234, 26, 0x80000000)
  KSLRAW_OP(337, 0xffff1234, 27, 0x80000000)
  KSLRAW_OP(338, 0xffff1234, 28, 0x80000000)
  KSLRAW_OP(339, 0xffff1234, 29, 0x80000000)
  KSLRAW_OP(340, 0xffff1234, 30, 0x80000000)
  KSLRAW_OP(341, 0xffff1234, 31, 0x80000000)

#### right shift
# sign bit is 0
  KSLRAW_OP(342, 0x1234abcd, 63, 0x091a55e6)
  KSLRAW_OP(343, 0x1234abcd, 62, 0x048d2af3)
  KSLRAW_OP(344, 0x1234abcd, 61, 0x02469579)
  KSLRAW_OP(345, 0x1234abcd, 60, 0x01234abc)
  KSLRAW_OP(346, 0x1234abcd, 59, 0x0091a55e)
  KSLRAW_OP(347, 0x1234abcd, 58, 0x0048d2af)
  KSLRAW_OP(348, 0x1234abcd, 57, 0x00246957)
  KSLRAW_OP(349, 0x1234abcd, 56, 0x001234ab)
  KSLRAW_OP(350, 0x1234abcd, 55, 0x00091a55)
  KSLRAW_OP(351, 0x1234abcd, 54, 0x00048d2a)
  KSLRAW_OP(352, 0x1234abcd, 53, 0x00024695)
  KSLRAW_OP(353, 0x1234abcd, 52, 0x0001234a)
  KSLRAW_OP(354, 0x1234abcd, 51, 0x000091a5)
  KSLRAW_OP(355, 0x1234abcd, 50, 0x000048d2)
  KSLRAW_OP(356, 0x1234abcd, 49, 0x00002469)
  KSLRAW_OP(357, 0x1234abcd, 48, 0x00001234)
  KSLRAW_OP(358, 0x1234abcd, 47, 0x0000091a)
  KSLRAW_OP(359, 0x1234abcd, 46, 0x0000048d)
  KSLRAW_OP(360, 0x1234abcd, 45, 0x00000246)
  KSLRAW_OP(361, 0x1234abcd, 44, 0x00000123)
  KSLRAW_OP(362, 0x1234abcd, 43, 0x00000091)
  KSLRAW_OP(363, 0x1234abcd, 42, 0x00000048)
  KSLRAW_OP(364, 0x1234abcd, 41, 0x00000024)
  KSLRAW_OP(365, 0x1234abcd, 40, 0x00000012)
  KSLRAW_OP(366, 0x1234abcd, 39, 0x00000009)
  KSLRAW_OP(367, 0x1234abcd, 38, 0x00000004)
  KSLRAW_OP(368, 0x1234abcd, 37, 0x00000002)
  KSLRAW_OP(369, 0x1234abcd, 36, 0x00000001)
  KSLRAW_OP(370, 0x1234abcd, 35, 0x00000000)
  KSLRAW_OP(371, 0x1234abcd, 34, 0x00000000)
  KSLRAW_OP(372, 0x1234abcd, 33, 0x00000000)
  KSLRAW_OP(373, 0x1234abcd, 32, 0x00000000)

# sign bit is 1
  KSLRAW_OP(374, 0xabcd1234, 63, 0xd5e6891a)
  KSLRAW_OP(375, 0xabcd1234, 62, 0xeaf3448d)
  KSLRAW_OP(376, 0xabcd1234, 61, 0xf579a246)
  KSLRAW_OP(377, 0xabcd1234, 60, 0xfabcd123)
  KSLRAW_OP(378, 0xabcd1234, 59, 0xfd5e6891)
  KSLRAW_OP(379, 0xabcd1234, 58, 0xfeaf3448)
  KSLRAW_OP(380, 0xabcd1234, 57, 0xff579a24)
  KSLRAW_OP(381, 0xabcd1234, 56, 0xffabcd12)
  KSLRAW_OP(382, 0xabcd1234, 55, 0xffd5e689)
  KSLRAW_OP(383, 0xabcd1234, 54, 0xffeaf344)
  KSLRAW_OP(384, 0xabcd1234, 53, 0xfff579a2)
  KSLRAW_OP(385, 0xabcd1234, 52, 0xfffabcd1)
  KSLRAW_OP(386, 0xabcd1234, 51, 0xfffd5e68)
  KSLRAW_OP(387, 0xabcd1234, 50, 0xfffeaf34)
  KSLRAW_OP(388, 0xabcd1234, 49, 0xffff579a)
  KSLRAW_OP(389, 0xabcd1234, 48, 0xffffabcd)
  KSLRAW_OP(390, 0xabcd1234, 47, 0xffffd5e6)
  KSLRAW_OP(391, 0xabcd1234, 46, 0xffffeaf3)
  KSLRAW_OP(392, 0xabcd1234, 45, 0xfffff579)
  KSLRAW_OP(393, 0xabcd1234, 44, 0xfffffabc)
  KSLRAW_OP(394, 0xabcd1234, 43, 0xfffffd5e)
  KSLRAW_OP(395, 0xabcd1234, 42, 0xfffffeaf)
  KSLRAW_OP(396, 0xabcd1234, 41, 0xffffff57)
  KSLRAW_OP(397, 0xabcd1234, 40, 0xffffffab)
  KSLRAW_OP(398, 0xabcd1234, 39, 0xffffffd5)
  KSLRAW_OP(399, 0xabcd1234, 38, 0xffffffea)
  KSLRAW_OP(360, 0xabcd1234, 37, 0xfffffff5)
  KSLRAW_OP(401, 0xabcd1234, 36, 0xfffffffa)
  KSLRAW_OP(402, 0xabcd1234, 35, 0xfffffffd)
  KSLRAW_OP(403, 0xabcd1234, 34, 0xfffffffe)
  KSLRAW_OP(404, 0xabcd1234, 33, 0xffffffff)
  KSLRAW_OP(405, 0xabcd1234, 32, 0xffffffff)

#########################################################################
# kslrawu
#########################################################################
#### left shift
# sign bit is 0
  KSLRAWU_OP(268, 0x0000abcd,  0, 0x0000abcd)
  KSLRAWU_OP(279, 0x0000abcd,  1, 0x0001579a)
  KSLRAWU_OP(280, 0x0000abcd,  2, 0x0002af34)
  KSLRAWU_OP(281, 0x0000abcd,  3, 0x00055e68)
  KSLRAWU_OP(282, 0x0000abcd,  4, 0x000abcd0)
  KSLRAWU_OP(283, 0x0000abcd,  5, 0x001579a0)
  KSLRAWU_OP(284, 0x0000abcd,  6, 0x002af340)
  KSLRAWU_OP(285, 0x0000abcd,  7, 0x0055e680)
  KSLRAWU_OP(286, 0x0000abcd,  8, 0x00abcd00)
  KSLRAWU_OP(287, 0x0000abcd,  9, 0x01579a00)
  KSLRAWU_OP(288, 0x0000abcd, 10, 0x02af3400)
  KSLRAWU_OP(289, 0x0000abcd, 11, 0x055e6800)
  KSLRAWU_OP(290, 0x0000abcd, 12, 0x0abcd000)
  KSLRAWU_OP(291, 0x0000abcd, 13, 0x1579a000)
  KSLRAWU_OP(292, 0x0000abcd, 14, 0x2af34000)
  KSLRAWU_OP(293, 0x0000abcd, 15, 0x55e68000)
  KSLRAWU_OP(294, 0x0000abcd, 16, 0x7fffffff)
  KSLRAWU_OP(295, 0x0000abcd, 17, 0x7fffffff)
  KSLRAWU_OP(296, 0x0000abcd, 18, 0x7fffffff)
  KSLRAWU_OP(297, 0x0000abcd, 19, 0x7fffffff)
  KSLRAWU_OP(298, 0x0000abcd, 20, 0x7fffffff)
  KSLRAWU_OP(299, 0x0000abcd, 21, 0x7fffffff)
  KSLRAWU_OP(300, 0x0000abcd, 22, 0x7fffffff)
  KSLRAWU_OP(301, 0x0000abcd, 23, 0x7fffffff)
  KSLRAWU_OP(302, 0x0000abcd, 24, 0x7fffffff)
  KSLRAWU_OP(303, 0x0000abcd, 25, 0x7fffffff)
  KSLRAWU_OP(304, 0x0000abcd, 26, 0x7fffffff)
  KSLRAWU_OP(305, 0x0000abcd, 27, 0x7fffffff)
  KSLRAWU_OP(306, 0x0000abcd, 28, 0x7fffffff)
  KSLRAWU_OP(307, 0x0000abcd, 29, 0x7fffffff)
  KSLRAWU_OP(308, 0x0000abcd, 30, 0x7fffffff)
  KSLRAWU_OP(309, 0x0000abcd, 31, 0x7fffffff)

# sign bit is 1
  KSLRAWU_OP(310, 0xffff1234,  0, 0xffff1234)
  KSLRAWU_OP(311, 0xffff1234,  1, 0xfffe2468)
  KSLRAWU_OP(312, 0xffff1234,  2, 0xfffc48d0)
  KSLRAWU_OP(313, 0xffff1234,  3, 0xfff891a0)
  KSLRAWU_OP(314, 0xffff1234,  4, 0xfff12340)
  KSLRAWU_OP(315, 0xffff1234,  5, 0xffe24680)
  KSLRAWU_OP(316, 0xffff1234,  6, 0xffc48d00)
  KSLRAWU_OP(317, 0xffff1234,  7, 0xff891a00)
  KSLRAWU_OP(318, 0xffff1234,  8, 0xff123400)
  KSLRAWU_OP(319, 0xffff1234,  9, 0xfe246800)
  KSLRAWU_OP(320, 0xffff1234, 10, 0xfc48d000)
  KSLRAWU_OP(321, 0xffff1234, 11, 0xf891a000)
  KSLRAWU_OP(322, 0xffff1234, 12, 0xf1234000)
  KSLRAWU_OP(323, 0xffff1234, 13, 0xe2468000)
  KSLRAWU_OP(324, 0xffff1234, 14, 0xc48d0000)
  KSLRAWU_OP(325, 0xffff1234, 15, 0x891a0000)
  KSLRAWU_OP(326, 0xffff1234, 16, 0x80000000)
  KSLRAWU_OP(327, 0xffff1234, 17, 0x80000000)
  KSLRAWU_OP(328, 0xffff1234, 18, 0x80000000)
  KSLRAWU_OP(329, 0xffff1234, 19, 0x80000000)
  KSLRAWU_OP(330, 0xffff1234, 20, 0x80000000)
  KSLRAWU_OP(331, 0xffff1234, 21, 0x80000000)
  KSLRAWU_OP(332, 0xffff1234, 22, 0x80000000)
  KSLRAWU_OP(333, 0xffff1234, 23, 0x80000000)
  KSLRAWU_OP(334, 0xffff1234, 24, 0x80000000)
  KSLRAWU_OP(335, 0xffff1234, 25, 0x80000000)
  KSLRAWU_OP(336, 0xffff1234, 26, 0x80000000)
  KSLRAWU_OP(337, 0xffff1234, 27, 0x80000000)
  KSLRAWU_OP(338, 0xffff1234, 28, 0x80000000)
  KSLRAWU_OP(339, 0xffff1234, 29, 0x80000000)
  KSLRAWU_OP(340, 0xffff1234, 30, 0x80000000)
  KSLRAWU_OP(341, 0xffff1234, 31, 0x80000000)

#### right shift
# sign bit is 0
  KSLRAWU_OP(342, 0x1234abcd, 63, 0x091a55e7)
  KSLRAWU_OP(343, 0x1234abcd, 62, 0x048d2af3)
  KSLRAWU_OP(344, 0x1234abcd, 61, 0x0246957a)
  KSLRAWU_OP(345, 0x1234abcd, 60, 0x01234abd)
  KSLRAWU_OP(346, 0x1234abcd, 59, 0x0091a55e)
  KSLRAWU_OP(347, 0x1234abcd, 58, 0x0048d2af)
  KSLRAWU_OP(348, 0x1234abcd, 57, 0x00246958)
  KSLRAWU_OP(349, 0x1234abcd, 56, 0x001234ac)
  KSLRAWU_OP(350, 0x1234abcd, 55, 0x00091a56)
  KSLRAWU_OP(351, 0x1234abcd, 54, 0x00048d2b)
  KSLRAWU_OP(352, 0x1234abcd, 53, 0x00024695)
  KSLRAWU_OP(353, 0x1234abcd, 52, 0x0001234b)
  KSLRAWU_OP(354, 0x1234abcd, 51, 0x000091a5)
  KSLRAWU_OP(355, 0x1234abcd, 50, 0x000048d3)
  KSLRAWU_OP(356, 0x1234abcd, 49, 0x00002469)
  KSLRAWU_OP(357, 0x1234abcd, 48, 0x00001235)
  KSLRAWU_OP(358, 0x1234abcd, 47, 0x0000091a)
  KSLRAWU_OP(359, 0x1234abcd, 46, 0x0000048d)
  KSLRAWU_OP(360, 0x1234abcd, 45, 0x00000247)
  KSLRAWU_OP(361, 0x1234abcd, 44, 0x00000123)
  KSLRAWU_OP(362, 0x1234abcd, 43, 0x00000092)
  KSLRAWU_OP(363, 0x1234abcd, 42, 0x00000049)
  KSLRAWU_OP(364, 0x1234abcd, 41, 0x00000024)
  KSLRAWU_OP(365, 0x1234abcd, 40, 0x00000012)
  KSLRAWU_OP(366, 0x1234abcd, 39, 0x00000009)
  KSLRAWU_OP(367, 0x1234abcd, 38, 0x00000005)
  KSLRAWU_OP(368, 0x1234abcd, 37, 0x00000002)
  KSLRAWU_OP(369, 0x1234abcd, 36, 0x00000001)
  KSLRAWU_OP(370, 0x1234abcd, 35, 0x00000001)
  KSLRAWU_OP(371, 0x1234abcd, 34, 0x00000000)
  KSLRAWU_OP(372, 0x1234abcd, 33, 0x00000000)
  KSLRAWU_OP(373, 0x1234abcd, 32, 0x00000000)

# sign bit is 1
  KSLRAWU_OP(374, 0xabcd1234, 63, 0xd5e6891a)
  KSLRAWU_OP(375, 0xabcd1234, 62, 0xeaf3448d)
  KSLRAWU_OP(376, 0xabcd1234, 61, 0xf579a247)
  KSLRAWU_OP(377, 0xabcd1234, 60, 0xfabcd123)
  KSLRAWU_OP(378, 0xabcd1234, 59, 0xfd5e6892)
  KSLRAWU_OP(379, 0xabcd1234, 58, 0xfeaf3449)
  KSLRAWU_OP(380, 0xabcd1234, 57, 0xff579a24)
  KSLRAWU_OP(381, 0xabcd1234, 56, 0xffabcd12)
  KSLRAWU_OP(382, 0xabcd1234, 55, 0xffd5e689)
  KSLRAWU_OP(383, 0xabcd1234, 54, 0xffeaf345)
  KSLRAWU_OP(384, 0xabcd1234, 53, 0xfff579a2)
  KSLRAWU_OP(385, 0xabcd1234, 52, 0xfffabcd1)
  KSLRAWU_OP(386, 0xabcd1234, 51, 0xfffd5e69)
  KSLRAWU_OP(387, 0xabcd1234, 50, 0xfffeaf34)
  KSLRAWU_OP(388, 0xabcd1234, 49, 0xffff579a)
  KSLRAWU_OP(389, 0xabcd1234, 48, 0xffffabcd)
  KSLRAWU_OP(390, 0xabcd1234, 47, 0xffffd5e7)
  KSLRAWU_OP(391, 0xabcd1234, 46, 0xffffeaf3)
  KSLRAWU_OP(392, 0xabcd1234, 45, 0xfffff57a)
  KSLRAWU_OP(393, 0xabcd1234, 44, 0xfffffabd)
  KSLRAWU_OP(394, 0xabcd1234, 43, 0xfffffd5e)
  KSLRAWU_OP(395, 0xabcd1234, 42, 0xfffffeaf)
  KSLRAWU_OP(396, 0xabcd1234, 41, 0xffffff58)
  KSLRAWU_OP(397, 0xabcd1234, 40, 0xffffffac)
  KSLRAWU_OP(398, 0xabcd1234, 39, 0xffffffd6)
  KSLRAWU_OP(399, 0xabcd1234, 38, 0xffffffeb)
  KSLRAWU_OP(360, 0xabcd1234, 37, 0xfffffff5)
  KSLRAWU_OP(401, 0xabcd1234, 36, 0xfffffffb)
  KSLRAWU_OP(402, 0xabcd1234, 35, 0xfffffffd)
  KSLRAWU_OP(403, 0xabcd1234, 34, 0xffffffff)
  KSLRAWU_OP(404, 0xabcd1234, 33, 0xffffffff)
  KSLRAWU_OP(405, 0xabcd1234, 32, 0xffffffff)


#endif 


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

