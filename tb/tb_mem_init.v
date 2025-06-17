
`include "tb_defines.v"
`define EVALSOC_IRAM_DATA_WIDTH                  64
`define EVALSOC_DRAM_DATA_WIDTH                  64
`define EVALSOC_IRAM_RAM_DP                      8192
`define EVALSOC_DRAM_RAM_DP                      8192

`define IRAM_LINE_SIZE (`EVALSOC_IRAM_DATA_WIDTH/8)
`define DRAM_LINE_SIZE (`EVALSOC_DRAM_DATA_WIDTH/8)

`define INI_IRAM(PFX) \
    for (i=0;i<(`EVALSOC_IRAM_RAM_DP);i=i+1) begin \
        for (j=0;j<`IRAM_LINE_SIZE;j=j+1) begin \
          `PFX``IRAM_MEM[i][j*8+:8] = mem[i*`IRAM_LINE_SIZE+j] === 8'hxx ? 8'h00 : mem[i*`IRAM_LINE_SIZE+j]; \
        end\
    end

`define INI_DRAM(PFX) \
        for (i=0;i<(`EVALSOC_DRAM_RAM_DP);i=i+1) begin \
                for (j=0;j<`DRAM_LINE_SIZE;j=j+1) begin \
                  `PFX``DRAM_MEM[i][j*8+:8] = mem[32'h0800_0000 + i*`DRAM_LINE_SIZE+j] === 8'hxx ? 8'h00 : mem[32'h08000000 + i*`DRAM_LINE_SIZE+j]; \
                end\
            end 


module tb_mem_init(
  input tb_clk
);

  //****************************************************************************************************
  // Read the test verilog file and initialize the ILM

  localparam ILM_OFFSET = 0;
  localparam DLM_OFFSET = 32'h0800_0000;
  localparam DLM_BYTES = 8;

  `include "tb_mem_init_share.svh"

  integer i;
  integer j;
  integer fd;
  integer code;
  string testcase;
  bit [31:0] elf_header;
  bit skip_init;
  
  initial begin //{
    skip_init = 1'b0;
    $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");  
    if($test$plusargs("sram_check"))begin //{
      $display("TB SRAM CHECK instead of testcase");
      skip_init = 1'b1;
    end //}
    else begin
      if($value$plusargs("TESTCASE=%s",testcase))begin
        $display("TESTCASE=%s",testcase);
    end

    if (!skip_init) begin //{
        // judge the file exist
        fd = $fopen(testcase, "rb");
        if (fd == 0) begin
            $display("file: %s is not exist, please check TESTCASE arg", testcase);
            $fatal();
        end

        // judge the file is elf file
        code = $fread(elf_header, fd, 0, 4);
        if ((code != 4) || (elf_header != 32'h7f454c46)) begin
            $display("file: %s is not valid elf file, please check TESTCASE arg", testcase);
            $fatal();
        end

          if (!load_elf64_to_mem(testcase))
            $fatal("failed to load elf64 to memory");
       $fclose(fd);
`ifndef SYNTHESIS //{
        // initial evalsoc subsys lm
    `INI_IRAM(SUB_)
    `INI_DRAM(SUB_)
`endif//}
        // initial flash
        if (flash_max_offset) begin
            `SUB_MAIN.u_subsys_perips.u_qspi0_top.memory = flash_mem; 
            $display("flash initial finish");
        end

        //initial sys mem
          if (sys_mem_max_offset) begin
            for (i=0; i< sys_mem_max_offset[31:3] + 1; i=i+1) begin
                `DDR_PATH[i][00+7:00] = mem[32'h1000_0000 + i*8+0];
                `DDR_PATH[i][08+7:08] = mem[32'h1000_0000 + i*8+1];
                `DDR_PATH[i][16+7:16] = mem[32'h1000_0000 + i*8+2];
                `DDR_PATH[i][24+7:24] = mem[32'h1000_0000 + i*8+3];
                `DDR_PATH[i][32+7:32] = mem[32'h1000_0000 + i*8+4];
                `DDR_PATH[i][40+7:40] = mem[32'h1000_0000 + i*8+5];
                `DDR_PATH[i][48+7:48] = mem[32'h1000_0000 + i*8+6];
                `DDR_PATH[i][56+7:56] = mem[32'h1000_0000 + i*8+7];
            end
            $display("sys mem initial finish");
          end
        end //}
    end //}
  end //}

endmodule
