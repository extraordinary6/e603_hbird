`ifndef __TB_DEFINES__
`define __TB_DEFINES__

typedef longint  unsigned reg_t;
typedef longint     unsigned    uint64_t;
typedef int         unsigned    uint32_t;
typedef shortint    unsigned    uint16_t;
typedef byte        unsigned    uint8_t;
typedef longint     signed      int64_t;
typedef int         signed      int32_t;
typedef shortint    signed      int16_t;
typedef byte        signed      int8_t;
   //****************************************************************************************************
  // HACK-HERE:
  //  If you integrate the N600 core into your SoC, you can hack here to change the path to your SoC path

  `define CPU_SOC_TOP  tb_top.u_soc_top
  `define SUB_TOP `CPU_SOC_TOP.u_subsys_top
  `define SUB_MAIN `SUB_TOP.u_subsys_main
  `define SUB_MEM  `SUB_MAIN.u_subsys_mems
  `define SUB_LM `SUB_MAIN.u_subsys_lm
  `define SUB_SLAVE_LM `SUB_MAIN.u_subsys_slave_lm
  `define SUB_RAM `SUB_MAIN.u_subsys_ram
  `define SUB_SLAVE_RAM `SUB_MAIN.u_subsys_slave_ram
     `define CPU_CORE_WRAPPER `SUB_MAIN.u_core_rams.u_core
     `define CPU_CORE_TOP `CPU_CORE_WRAPPER.u_core
     `define CPU_SRAM_WRAPPER `SUB_MAIN.u_core_rams.u_rams

  `define CPU_CORE_TOP `CPU_CORE_WRAPPER.u_core
  `define CPU_CORE `CPU_CORE_TOP.u_ucore
  `define CPU_UCORE `CPU_CORE_TOP.u_ucore
  `define TMR_TOP `CPU_CORE_TOP.u_tmr_top
  `define TMR_MAIN `TMR_TOP.u_tmr_main
  `define CLIC_TOP `CPU_CORE_TOP.u_clic_top
  `define LSU `CPU_CORE.u_lsu
  `define EXU `CPU_CORE.u_exu
  `define COMMIT_BRANCHSLV `CMT.u_exu_branchslv
  `define EXU_EXCP `EXU.u_exu_excp_wrapper.u_i0_exu_excp
  `define REGFILE  `EXU.u_exu_regfile
  `define IFU `CPU_CORE.u_ifu
  `define IFU_ICBCTRL `IFU.u_ifu_icbctrl
  `define BIU `CPU_CORE.u_biu
  `define ICACHE `IFU.u_icache
  `define CMT   `EXU.u_exu_commit_wrapper.u_i0_exu_commit
  `define EXCP  `EXU_EXCP
  `define DBG   `CPU_CORE_WRAPPER.u_dbg_top
  `define DBG_CSR `CPU_CORE_TOP.u_dbg_csr
  `define CSR   `EXU.u_exu_csr
  `define EXU_CSR   `CSR
  `define DECODE   `EXU.u_exu_decode
  `define DLM_CTRL `CPU_CORE_TOP.u_dlm_ctrl
  
`define MEM_PATH  `SUB_MEM.u_sysmem_top.u_gnrl_ram.u_ram
`define DDR_PATH `SUB_MAIN.u_subsys_axi2sram.u_icb_ram_top.u_gnrl_ram.u_ram.mem_r

`ifdef EVALSOC_HAS_CPU_RAM_WRAPPER
   `define ILM_MEM       `CPU_SRAM_WRAPPER.u_ilm_ram.u_ram.mem_r
   `define SLAVE_ILM_MEM   `CPU_SRAM_WRAPPER.u_slave_ilm_ram.u_ram.mem_r

   `define DLM_MEM      `CPU_SRAM_WRAPPER.u_dlm_ram.u_ram.mem_r
   `define SLAVE_DLM_MEM  `CPU_SRAM_WRAPPER.u_slave_dlm_ram.u_ram.mem_r

 `ifdef N600_DLM_CTRL_NUM_IS_2
     `define DLM0_MEM0        `CPU_SRAM_WRAPPER.u_dlm0_ram0.u_ram.mem_r
     `define SLAVE_DLM0_MEM0  `CPU_SRAM_WRAPPER.u_slave_dlm0_ram0.u_ram.mem_r
     `define DLM0_MEM1        `CPU_SRAM_WRAPPER.u_dlm0_ram1.u_ram.mem_r
     `define SLAVE_DLM0_MEM1  `CPU_SRAM_WRAPPER.u_slave_dlm0_ram1.u_ram.mem_r
     `define DLM1_MEM0        `CPU_SRAM_WRAPPER.u_dlm1_ram0.u_ram.mem_r
     `define SLAVE_DLM1_MEM0  `CPU_SRAM_WRAPPER.u_slave_dlm1_ram0.u_ram.mem_r
     `define DLM1_MEM1        `CPU_SRAM_WRAPPER.u_dlm1_ram1.u_ram.mem_r
     `define SLAVE_DLM1_MEM1  `CPU_SRAM_WRAPPER.u_slave_dlm1_ram1.u_ram.mem_r
 `else
     `define DLM_MEM0  `CPU_SRAM_WRAPPER.u_dlm0_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM0  `CPU_SRAM_WRAPPER.u_slave_dlm0_ram.u_ram.mem_r
     `define DLM_MEM1  `CPU_SRAM_WRAPPER.u_dlm1_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM1  `CPU_SRAM_WRAPPER.u_slave_dlm1_ram.u_ram.mem_r
     `define DLM_MEM2  `CPU_SRAM_WRAPPER.u_dlm2_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM2  `CPU_SRAM_WRAPPER.u_slave_dlm2_ram.u_ram.mem_r
     `define DLM_MEM3  `CPU_SRAM_WRAPPER.u_dlm3_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM3  `CPU_SRAM_WRAPPER.u_slave_dlm3_ram.u_ram.mem_r
     `define DLM_MEM4  `CPU_SRAM_WRAPPER.u_dlm4_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM4  `CPU_SRAM_WRAPPER.u_slave_dlm4_ram.u_ram.mem_r
     `define DLM_MEM5  `CPU_SRAM_WRAPPER.u_dlm5_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM5  `CPU_SRAM_WRAPPER.u_slave_dlm5_ram.u_ram.mem_r
     `define DLM_MEM6  `CPU_SRAM_WRAPPER.u_dlm6_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM6  `CPU_SRAM_WRAPPER.u_slave_dlm6_ram.u_ram.mem_r
     `define DLM_MEM7  `CPU_SRAM_WRAPPER.u_dlm7_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM7  `CPU_SRAM_WRAPPER.u_slave_dlm7_ram.u_ram.mem_r
     `define DLM_MEM8  `CPU_SRAM_WRAPPER.u_dlm8_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM8  `CPU_SRAM_WRAPPER.u_slave_dlm8_ram.u_ram.mem_r
     `define DLM_MEM9  `CPU_SRAM_WRAPPER.u_dlm9_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM9  `CPU_SRAM_WRAPPER.u_slave_dlm9_ram.u_ram.mem_r
     `define DLM_MEM10  `CPU_SRAM_WRAPPER.u_dlm10_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM10  `CPU_SRAM_WRAPPER.u_slave_dlm10_ram.u_ram.mem_r
     `define DLM_MEM11  `CPU_SRAM_WRAPPER.u_dlm11_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM11  `CPU_SRAM_WRAPPER.u_slave_dlm11_ram.u_ram.mem_r
     `define DLM_MEM12  `CPU_SRAM_WRAPPER.u_dlm12_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM12  `CPU_SRAM_WRAPPER.u_slave_dlm12_ram.u_ram.mem_r
     `define DLM_MEM13  `CPU_SRAM_WRAPPER.u_dlm13_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM13  `CPU_SRAM_WRAPPER.u_slave_dlm13_ram.u_ram.mem_r
     `define DLM_MEM14  `CPU_SRAM_WRAPPER.u_dlm14_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM14  `CPU_SRAM_WRAPPER.u_slave_dlm14_ram.u_ram.mem_r
     `define DLM_MEM15  `CPU_SRAM_WRAPPER.u_dlm15_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM15  `CPU_SRAM_WRAPPER.u_slave_dlm15_ram.u_ram.mem_r
     `define DLM_MEM16  `CPU_SRAM_WRAPPER.u_dlm16_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM16  `CPU_SRAM_WRAPPER.u_slave_dlm16_ram.u_ram.mem_r
     `define DLM_MEM17  `CPU_SRAM_WRAPPER.u_dlm17_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM17  `CPU_SRAM_WRAPPER.u_slave_dlm17_ram.u_ram.mem_r
     `define DLM_MEM18  `CPU_SRAM_WRAPPER.u_dlm18_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM18  `CPU_SRAM_WRAPPER.u_slave_dlm18_ram.u_ram.mem_r
     `define DLM_MEM19  `CPU_SRAM_WRAPPER.u_dlm19_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM19  `CPU_SRAM_WRAPPER.u_slave_dlm19_ram.u_ram.mem_r
     `define DLM_MEM20  `CPU_SRAM_WRAPPER.u_dlm20_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM20  `CPU_SRAM_WRAPPER.u_slave_dlm20_ram.u_ram.mem_r
     `define DLM_MEM21  `CPU_SRAM_WRAPPER.u_dlm21_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM21  `CPU_SRAM_WRAPPER.u_slave_dlm21_ram.u_ram.mem_r
     `define DLM_MEM22  `CPU_SRAM_WRAPPER.u_dlm22_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM22  `CPU_SRAM_WRAPPER.u_slave_dlm22_ram.u_ram.mem_r
     `define DLM_MEM23  `CPU_SRAM_WRAPPER.u_dlm23_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM23  `CPU_SRAM_WRAPPER.u_slave_dlm23_ram.u_ram.mem_r
     `define DLM_MEM24  `CPU_SRAM_WRAPPER.u_dlm24_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM24  `CPU_SRAM_WRAPPER.u_slave_dlm24_ram.u_ram.mem_r
     `define DLM_MEM25  `CPU_SRAM_WRAPPER.u_dlm25_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM25  `CPU_SRAM_WRAPPER.u_slave_dlm25_ram.u_ram.mem_r
     `define DLM_MEM26  `CPU_SRAM_WRAPPER.u_dlm26_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM26  `CPU_SRAM_WRAPPER.u_slave_dlm26_ram.u_ram.mem_r
     `define DLM_MEM27  `CPU_SRAM_WRAPPER.u_dlm27_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM27  `CPU_SRAM_WRAPPER.u_slave_dlm27_ram.u_ram.mem_r
     `define DLM_MEM28  `CPU_SRAM_WRAPPER.u_dlm28_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM28  `CPU_SRAM_WRAPPER.u_slave_dlm28_ram.u_ram.mem_r
     `define DLM_MEM29  `CPU_SRAM_WRAPPER.u_dlm29_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM29  `CPU_SRAM_WRAPPER.u_slave_dlm29_ram.u_ram.mem_r
     `define DLM_MEM30  `CPU_SRAM_WRAPPER.u_dlm30_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM30  `CPU_SRAM_WRAPPER.u_slave_dlm30_ram.u_ram.mem_r
     `define DLM_MEM31  `CPU_SRAM_WRAPPER.u_dlm31_ram.u_ram.mem_r
     `define SLAVE_DLM_MEM31  `CPU_SRAM_WRAPPER.u_slave_dlm31_ram.u_ram.mem_r
 `endif
`else
    `define ILM_MEM            `SUB_LM.u_ilm_ram.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_ILM_MEM      `SUB_LM.u_slave_ilm_ram.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM            `SUB_LM.u_dlm_ram.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM0        `SUB_LM.u_dlm_ram0.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM0  `SUB_LM.u_slave_dlm_ram0.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM1        `SUB_LM.u_dlm_ram1.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM1  `SUB_LM.u_slave_dlm_ram1.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM2        `SUB_LM.u_dlm_ram2.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM2  `SUB_LM.u_slave_dlm_ram2.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM3        `SUB_LM.u_dlm_ram3.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM3  `SUB_LM.u_slave_dlm_ram3.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM4        `SUB_LM.u_dlm_ram4.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM4  `SUB_LM.u_slave_dlm_ram4.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM5        `SUB_LM.u_dlm_ram5.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM5  `SUB_LM.u_slave_dlm_ram5.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM6        `SUB_LM.u_dlm_ram6.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM6  `SUB_LM.u_slave_dlm_ram6.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM7        `SUB_LM.u_dlm_ram7.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM7  `SUB_LM.u_slave_dlm_ram7.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM8        `SUB_LM.u_dlm_ram8.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM8  `SUB_LM.u_slave_dlm_ram8.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM9        `SUB_LM.u_dlm_ram9.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM9  `SUB_LM.u_slave_dlm_ram9.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM10        `SUB_LM.u_dlm_ram10.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM10  `SUB_LM.u_slave_dlm_ram10.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM11        `SUB_LM.u_dlm_ram11.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM11  `SUB_LM.u_slave_dlm_ram11.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM12        `SUB_LM.u_dlm_ram12.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM12  `SUB_LM.u_slave_dlm_ram12.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM13        `SUB_LM.u_dlm_ram13.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM13  `SUB_LM.u_slave_dlm_ram13.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM14        `SUB_LM.u_dlm_ram14.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM14  `SUB_LM.u_slave_dlm_ram14.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM15        `SUB_LM.u_dlm_ram15.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM15  `SUB_LM.u_slave_dlm_ram15.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM16        `SUB_LM.u_dlm_ram16.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM16  `SUB_LM.u_slave_dlm_ram16.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM17        `SUB_LM.u_dlm_ram17.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM17  `SUB_LM.u_slave_dlm_ram17.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM18        `SUB_LM.u_dlm_ram18.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM18  `SUB_LM.u_slave_dlm_ram18.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM19        `SUB_LM.u_dlm_ram19.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM19  `SUB_LM.u_slave_dlm_ram19.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM20        `SUB_LM.u_dlm_ram20.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM20  `SUB_LM.u_slave_dlm_ram20.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM21        `SUB_LM.u_dlm_ram21.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM21  `SUB_LM.u_slave_dlm_ram21.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM22        `SUB_LM.u_dlm_ram22.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM22  `SUB_LM.u_slave_dlm_ram22.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM23        `SUB_LM.u_dlm_ram23.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM23  `SUB_LM.u_slave_dlm_ram23.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM24        `SUB_LM.u_dlm_ram24.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM24  `SUB_LM.u_slave_dlm_ram24.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM25        `SUB_LM.u_dlm_ram25.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM25  `SUB_LM.u_slave_dlm_ram25.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM26        `SUB_LM.u_dlm_ram26.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM26  `SUB_LM.u_slave_dlm_ram26.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM27        `SUB_LM.u_dlm_ram27.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM27  `SUB_LM.u_slave_dlm_ram27.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM28        `SUB_LM.u_dlm_ram28.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM28  `SUB_LM.u_slave_dlm_ram28.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM29        `SUB_LM.u_dlm_ram29.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM29  `SUB_LM.u_slave_dlm_ram29.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM30        `SUB_LM.u_dlm_ram30.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM30  `SUB_LM.u_slave_dlm_ram30.u_gnrl_ram.u_ram.mem_r
    `define DLM_MEM31        `SUB_LM.u_dlm_ram31.u_gnrl_ram.u_ram.mem_r
    `define SLAVE_DLM_MEM31  `SUB_LM.u_slave_dlm_ram31.u_gnrl_ram.u_ram.mem_r
`endif

// subsys lm 
    `define SUB_IRAM_MEM         `SUB_RAM.u_iram.u_gnrl_ram.u_ram.mem_r
    `define SUB_DRAM_MEM         `SUB_RAM.u_dram.u_gnrl_ram.u_ram.mem_r

    `define SUB_SLAVE_IRAM_MEM   `SUB_SLAVE_RAM.u_iram.u_gnrl_ram.u_ram.mem_r
    `define SUB_SLAVE_DRAM_MEM   `SUB_SLAVE_RAM.u_dram.u_gnrl_ram.u_ram.mem_r

  //
  //****************************************************************************************************
  
`endif
