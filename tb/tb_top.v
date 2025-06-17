`include "tb_defines.v"
`timescale 1ns/1ps
module tb_top();
  reg  sys_clk;
  reg  nex_clk;
  reg  aon_clk;
  reg  tb_rst_n;
  reg  sys_clk_fast;
  reg  nex_rst_n;

  wire hfclk = sys_clk;// To leave it here since many TB cov need to use this
`define N600_XLEN                                64

  tb_exception_check #(.XLEN(`N600_XLEN)) u_tb_exception_check(
     .trace_ivalid      (`CPU_CORE_WRAPPER.trace_ivalid),
     .trace_pc          (`CPU_CORE_WRAPPER.trace_iaddr),
     .trace_opcode      (`CPU_CORE_WRAPPER.trace_instr),
     .trace_iexception  (`CPU_CORE_WRAPPER.trace_iexception),
     .trace_cause       (`CPU_CORE_WRAPPER.trace_cause),
     .trace_tval        (`CPU_CORE_WRAPPER.trace_tval),
     .core_wfi_mode     (`CPU_CORE_WRAPPER.core_wfi_mode),

     .clk (`CPU_CORE_WRAPPER.core_clk_aon),
     .rst_n (`CPU_CORE_WRAPPER.core_reset_n)
  );


  initial begin

     nex_clk <= 1'b0;
     sys_clk <= 1'b0;
     aon_clk <= 1'b0;
     sys_clk_fast <=1'b0;
     tb_rst_n <= 1'b0;
     nex_rst_n <= 1'b0;
     #2000 tb_rst_n <= 1'b1;
     #2000 nex_rst_n <= 1'b1;
  end

  always
  begin 
     #31 sys_clk = ~sys_clk;
  end

  always
  begin 
     #1000 aon_clk = ~aon_clk;
  end

`ifdef GATE_SIM
  always 
  begin
     #(clk_half_period * 0.7) sys_clk_fast = ~sys_clk_fast;
  end
`else
  always
  begin 
     #21 sys_clk_fast = ~sys_clk_fast;
  end
`endif

  always
  begin 
     #50 nex_clk = 1'b0;
     repeat ($urandom_range(1, 5)) #1 nex_clk <= 1'b0;
     #50 nex_clk = 1'b1;
     repeat ($urandom_range(1, 5)) #1 nex_clk <= 1'b1;
  end

  integer dumpwave;
  integer wavefsdb;
  initial begin
    $value$plusargs("DUMPWAVE=%d",dumpwave);
    $value$plusargs("WAVEFSDB=%d",wavefsdb);
    if(dumpwave != 0)begin
       if(wavefsdb ==1) begin
        $fsdbDumpfile("tb_top.fsdb");
        $fsdbDumpvars(0, tb_top, "+mda");
       end
       else begin
        $vcdplusfile ("tb_top.vpd");
        $vcdpluson;
        $vcdplusmemon;
       end
    end
  end

  bit[`N600_XLEN-1:0] boot_addr;
  string testcase;
  int error;

  import "DPI-C" function int parse_elf(string elf_path, output uint64_t addr);
  // process the reset vector
  initial begin
      boot_addr = `N600_XLEN'h1000; 
      if($test$plusargs("sram_check"))begin //{
          $display("TB SRAM CHECK instead of testcase");
      end //}
      else if ($value$plusargs("BOOT_ADDR=%h", boot_addr)) begin
          $display("set boot_addr=%h", boot_addr);
      end
      else begin
        longint unsigned addr;
         if($value$plusargs("TESTCASE=%s",testcase))begin
          $display("TESTCASE=%s",testcase);
        end
		error = parse_elf(testcase, addr);
		if (error) begin
			$display("ERROR: call pasre_elf failed\n");
			$finish();
		end
		$cast(boot_addr, addr);
      end
      force `SUB_TOP.reset_vector = boot_addr;
  end


  bit[63:0] timeout_value;
  initial begin
    if ($value$plusargs("timeout=%d", timeout_value)) begin
        if (timeout_value != 0) begin
            $display("timeout set %d", timeout_value);
            #timeout_value;
            $fatal("Time Out !!!");
            $finish();
        end
    end
  end

  //****************************************************************************************************
  // Here we instantiated the TB ILM-Loader and Result-Checker
  tb_mem_init u_tb_mem_init(sys_clk);
  tb_monitor u_tb_monitor(
    .tb_clk(sys_clk),
    .rst_n (tb_rst_n),

    .uart_clk           (`SUB_MAIN.u_subsys_perips.u_uart0_top.clk),
    .uart_icb_cmd_valid (`SUB_MAIN.u_subsys_perips.u_uart0_top.i_icb_cmd_valid),
    .uart_icb_cmd_ready (`SUB_MAIN.u_subsys_perips.u_uart0_top.i_icb_cmd_ready),
    .uart_icb_cmd_addr  (`SUB_MAIN.u_subsys_perips.u_uart0_top.i_icb_cmd_addr[31:0]), 
    .uart_icb_cmd_read  (`SUB_MAIN.u_subsys_perips.u_uart0_top.i_icb_cmd_read), 
    .uart_icb_cmd_wdata (`SUB_MAIN.u_subsys_perips.u_uart0_top.i_icb_cmd_wdata[7:0])
  );

  //****************************************************************************************************
  // Here we instantiated the Demo SoC
  soc_top u_soc_top(
   .por_rst_n(tb_rst_n),
   .sys_rst_n(tb_rst_n),

   .sys_clk(sys_clk),
   .aon_clk(aon_clk),
`ifndef FPGA_SOURCE//{
   .sys_clk_fast        (sys_clk_fast),
`endif//}

   .evt_i  (1'b0),
   .nmi_i  (1'b0),
   .core_sleep_value (),
   .core_wfi_mode  (),
   .stop_on_reset (1'b0),

   .nex_o_clk(),
   .nex_o_data(),
   .nex_clk(nex_clk),
   .nex_rst_n(nex_rst_n),    

   .io_pads_jtag_tdo_drv_o_oval (),
   .io_pads_jtag_TMS_out_o_oval (),
   .io_pads_jtag_DRV_TMS_o_oval (),
   .io_pads_jtag_bk_o_oval (),

   .io_pads_jtag_TCK_i_ival (1'b0),
   .io_pads_jtag_TMS_i_ival (1'b0),
   .io_pads_jtag_TDI_i_ival (1'b0),
   .io_pads_jtag_TDO_o_oval (),

   .xec_sys_clk                   (1'b0),
   .xmii_txc_i_ival               (1'b0),
   .xmii_txc_o_oval               (),
   .xmii_txc_o_oe                 (),
   .gmii_rxc_i_ival               (1'b0),
   .gmii_rxd_bit0_i_ival          (1'b0),
   .gmii_txd_bit0_o_oval          (),
   .gmii_rxd_bit1_i_ival          (1'b0),
   .gmii_txd_bit1_o_oval          (),
   .gmii_rxd_bit2_i_ival          (1'b0),
   .gmii_txd_bit2_o_oval          (),
   .gmii_rxd_bit3_i_ival          (1'b0),
   .gmii_txd_bit3_o_oval          (),
   .gmii_crs_i_ival               (1'b0),
   .gmii_col_i_ival               (1'b0),
   .gmii_rxdv_i_ival              (1'b0),
   .gmii_rxer_i_ival              (1'b0),
   .gmii_txen_o_oval              (),
   .gmii_txer_o_oval              (),
   .mdio_i_ival                   (1'b0),
   .mdio_o_oval                   (),
   .mdio_o_oe                     (),
   .mdc_o_oval                    (),

   .io_pads_qspi0_sck_o_oval (),
   .io_pads_qspi0_dq_0_i_ival (1'b0),
   .io_pads_qspi0_dq_0_o_oval (),
   .io_pads_qspi0_dq_0_o_oe (),
   .io_pads_qspi0_dq_0_o_ie (),
   .io_pads_qspi0_dq_0_o_pue (),
   .io_pads_qspi0_dq_0_o_ds (),
   .io_pads_qspi0_dq_1_i_ival (1'b0),
   .io_pads_qspi0_dq_1_o_oval (),
   .io_pads_qspi0_dq_1_o_oe (),
   .io_pads_qspi0_dq_1_o_ie (),
   .io_pads_qspi0_dq_1_o_pue (),
   .io_pads_qspi0_dq_1_o_ds (),
   .io_pads_qspi0_dq_2_i_ival (1'b0),
   .io_pads_qspi0_dq_2_o_oval (),
   .io_pads_qspi0_dq_2_o_oe (),
   .io_pads_qspi0_dq_2_o_ie (),
   .io_pads_qspi0_dq_2_o_pue (),
   .io_pads_qspi0_dq_2_o_ds (),
   .io_pads_qspi0_dq_3_i_ival (1'b0),
   .io_pads_qspi0_dq_3_o_oval (),
   .io_pads_qspi0_dq_3_o_oe (),
   .io_pads_qspi0_dq_3_o_ie (),
   .io_pads_qspi0_dq_3_o_pue (),
   .io_pads_qspi0_dq_3_o_ds (),
   .io_pads_qspi0_cs_0_o_oval (),

   .io_pads_qspi1_sck_o_oval (),
   .io_pads_qspi1_dq_0_i_ival (1'b1),
   .io_pads_qspi1_dq_0_o_oval (),
   .io_pads_qspi1_dq_0_o_oe (),
   .io_pads_qspi1_dq_0_o_ie (),
   .io_pads_qspi1_dq_0_o_pue (),
   .io_pads_qspi1_dq_0_o_ds (),
   .io_pads_qspi1_dq_1_i_ival (1'b1),
   .io_pads_qspi1_dq_1_o_oval (),
   .io_pads_qspi1_dq_1_o_oe (),
   .io_pads_qspi1_dq_1_o_ie (),
   .io_pads_qspi1_dq_1_o_pue (),
   .io_pads_qspi1_dq_1_o_ds (),
   .io_pads_qspi1_dq_2_i_ival (1'b1),
   .io_pads_qspi1_dq_2_o_oval (),
   .io_pads_qspi1_dq_2_o_oe (),
   .io_pads_qspi1_dq_2_o_ie (),
   .io_pads_qspi1_dq_2_o_pue (),
   .io_pads_qspi1_dq_2_o_ds (),
   .io_pads_qspi1_dq_3_i_ival (1'b1),
   .io_pads_qspi1_dq_3_o_oval (),
   .io_pads_qspi1_dq_3_o_oe (),
   .io_pads_qspi1_dq_3_o_ie (),
   .io_pads_qspi1_dq_3_o_pue (),
   .io_pads_qspi1_dq_3_o_ds (),
   .io_pads_qspi1_cs_0_o_oval (),
   .io_pads_qspi1_cs_1_o_oval (),
   .io_pads_qspi1_cs_2_o_oval (),
   .io_pads_qspi1_cs_3_o_oval (),

   .io_pads_qspi2_sck_o_oval (),
   .io_pads_qspi2_dq_0_i_ival (1'b1),
   .io_pads_qspi2_dq_0_o_oval (),
   .io_pads_qspi2_dq_0_o_oe (),
   .io_pads_qspi2_dq_0_o_ie (),
   .io_pads_qspi2_dq_0_o_pue (),
   .io_pads_qspi2_dq_0_o_ds (),
   .io_pads_qspi2_dq_1_i_ival (1'b1),
   .io_pads_qspi2_dq_1_o_oval (),
   .io_pads_qspi2_dq_1_o_oe (),
   .io_pads_qspi2_dq_1_o_ie (),
   .io_pads_qspi2_dq_1_o_pue (),
   .io_pads_qspi2_dq_1_o_ds (),
   .io_pads_qspi2_dq_2_i_ival (1'b1),
   .io_pads_qspi2_dq_2_o_oval (),
   .io_pads_qspi2_dq_2_o_oe (),
   .io_pads_qspi2_dq_2_o_ie (),
   .io_pads_qspi2_dq_2_o_pue (),
   .io_pads_qspi2_dq_2_o_ds (),
   .io_pads_qspi2_dq_3_i_ival (1'b1),
   .io_pads_qspi2_dq_3_o_oval (),
   .io_pads_qspi2_dq_3_o_oe (),
   .io_pads_qspi2_dq_3_o_ie (),
   .io_pads_qspi2_dq_3_o_pue (),
   .io_pads_qspi2_dq_3_o_ds (),
    .io_pads_qspi2_cs_0_i_ival(1'b0), 
    .io_pads_qspi2_cs_0_o_oval(),
    .io_pads_qspi2_cs_0_o_oe  (),
    .io_pads_qspi2_cs_0_o_ie  (),
    .io_pads_qspi2_cs_0_o_pue (),
    .io_pads_qspi2_cs_0_o_ds  (),

    .io_pads_uart0_rxd_i_ival (1'b1),
    .io_pads_uart0_rxd_o_oval (),
    .io_pads_uart0_rxd_o_oe   (),
    .io_pads_uart0_rxd_o_ie   (),
    .io_pads_uart0_rxd_o_pue  (),
    .io_pads_uart0_rxd_o_ds   (),
    .io_pads_uart0_txd_i_ival (1'b1),
    .io_pads_uart0_txd_o_oval (),
    .io_pads_uart0_txd_o_oe   (),
    .io_pads_uart0_txd_o_ie   (),
    .io_pads_uart0_txd_o_pue  (),
    .io_pads_uart0_txd_o_ds   ()

  );

endmodule
