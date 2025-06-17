
`include "tb_defines.v"

`define PASS_STRING "NUCLEI_TEST_PASS"
`define FAIL_STRING "NUCLEI_TEST_FAIL"


module tb_monitor(
  input tb_clk,
  input   rst_n,

  input                    uart_clk,
  input                    uart_icb_cmd_valid,
  input                    uart_icb_cmd_ready,
  input  [31:0]            uart_icb_cmd_addr, 
  input                    uart_icb_cmd_read, 
  input  [7:0]             uart_icb_cmd_wdata
);

  //{

  wire [31:0] pc_write_to_host_cnt;
  wire [31:0] pc_write_to_host_cycle;
  wire [31:0] cycle_count;
  
  tb_wait_pass u_tb_wait_pass(tb_clk,tb_top.tb_rst_n,pc_write_to_host_cnt,pc_write_to_host_cycle,cycle_count);

  reg[8*300:1] testcase;
  bit[`N600_XLEN-1:0] mscratch;
  always@(posedge tb_clk) begin
     if (`CPU_CORE_TOP.mscratch_ena)
        mscratch <= `CPU_CORE_TOP.mscratch_nxt;
  end
  wire [16-1:0] x3 = mscratch[31:16]; 

  initial begin //{
      $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");  
      if($value$plusargs("TESTCASE=%s",testcase))begin
        $display("TESTCASE=%s",testcase);
      end
  end //}
  
  initial begin
    #600
    @(pc_write_to_host_cnt == 32'd2);

    $display("~TESTCASE: %s ~~~~~~~~~~~~~", testcase);
    $display("~~~~~~~~~~~~~~Total cycle_count value: %d ~~~~~~~~~~~~~", cycle_count);
    $display("~~~~~The test ending reached at cycle: %d ~~~~~~~~~~~~~", pc_write_to_host_cycle);
    $display("~~~~~~~~~~~~~~~The final x3 Reg value: %d ~~~~~~~~~~~~~", x3);
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    if (x3 == 1) begin
        $display("~~~~~~~~~~~~~~~~ TEST_PASS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #####     ##     ####    #### ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #    #   #  #   #       #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #    #  #    #   ####    #### ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #####   ######       #       #~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #       #    #  #    #  #    #~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~ #       #    #   ####    #### ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    end
    else begin
        $display("~~~~~~~~~~~~~~~~ TEST_FAIL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~~~~~~~");
        $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    end
    #100

    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~ Test Finish  ~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    #10
    $finish;
  end

/*
    if uart enable tx, we don't print the uart info in here. only judge the auto finish
*/
    wire uart_tx_ena_write = uart_icb_cmd_valid & uart_icb_cmd_ready & 
                       ~uart_icb_cmd_read & 
                         (uart_icb_cmd_addr[11:0] == 12'h008);
   
    reg tx_ena = 1'b0;
    always@(posedge uart_clk) begin
        if (uart_tx_ena_write & uart_icb_cmd_wdata[0]) 
            tx_ena = 1'b1;
        if (uart_tx_ena_write & ~uart_icb_cmd_wdata[0]) 
            tx_ena = 1'b0;
    end


    wire uart_tx_write = uart_icb_cmd_valid & uart_icb_cmd_ready & 
                         ~uart_icb_cmd_read &
                         (uart_icb_cmd_addr[11:0] == 12'h000);


    reg uart_test_end = 1'b0;
    wire finish = (uart_tx_write & (uart_icb_cmd_wdata[7:0] == 8'h4))  | 
                  uart_test_end;


	string a = "";
    wire [7:0] data = uart_icb_cmd_wdata[7:0];
    always@(posedge uart_clk) begin
        if (uart_tx_write)  begin
            if (data == 8'h0a || data == 8'h0d ) begin
                a = "";
            end
            else begin
                a = {a, string'(data)};
                // when print info has NUCLEI_TEST_PASS or 
                if (a.icompare(`PASS_STRING) == 0) begin
                    a = "";
                    uart_test_end <= 1'b1;
                end
                else if (a.icompare(`FAIL_STRING) == 0) begin
                    $display("%s", a);
                    $fatal({"Program print", `FAIL_STRING});
                end
            end
        end
    end

/*
    auto finish, write 4 to uart, tb will wait some cycles to finish
*/
    reg need_finish = 1'b0;
    always@(posedge uart_clk) begin
        //if (uart_tx_write & ~tx_ena & ~finish)
        //    $fwrite(32'h80000001,"%c", uart_icb_cmd_wdata[7:0]);
        // only display once, even uart is written 4 more than once
        if (finish & !need_finish) begin
            $display("\nauto finish trigger, wait some cycles to finish");
            need_finish = 1'b1;
        end
    end

    reg [10:0] delay_count = 11'b0;
    always@(posedge uart_clk) begin
        if (need_finish)
            delay_count <= delay_count + 1'b1;
        if (delay_count >= 20) begin
            $finish(); 
        end 
    end

/*
benchmark print main loop start time and end time
    rxfifo register:
        write 1: print the main loop start time
        write 2: print the main loop end time
*/
    wire uart_rx_write = uart_icb_cmd_valid & uart_icb_cmd_ready & 
                        ~uart_icb_cmd_read &
                        (uart_icb_cmd_addr[11:0] == 12'h004);
    wire benchmark_start_flag = uart_rx_write & (uart_icb_cmd_wdata[7:0] == 8'h1);
    wire benchmark_end_flag = uart_rx_write & (uart_icb_cmd_wdata[7:0] == 8'h2);

    always@(posedge uart_clk) begin
        if (benchmark_start_flag)        
            $display("BENCHMARK START: %dns", $time());
        if (benchmark_end_flag)        
            $display("BENCHMARK END: %dns", $time());
    end
endmodule
