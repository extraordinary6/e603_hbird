
`include "tb_defines.v"

module tb_wait_pass (
  input  tb_clk,
  input  tb_rst_n,
  output reg [31:0] pc_write_to_host_cnt,
  output reg [31:0] pc_write_to_host_cycle,
  output reg [31:0] cycle_count

);

  

  wire chk_write_tohost = (`CPU_CORE_TOP.mscratch_ena & (`CPU_CORE_TOP.mscratch_nxt[15:0] == 16'h1)) | (`CPU_CORE_TOP.sscratch_ena & (`CPU_CORE_TOP.sscratch_nxt[15:0] == 16'h1));  
  reg pc_write_to_host_flag;
  
  always @(posedge tb_clk or negedge tb_rst_n)
  begin 
    if(tb_rst_n == 1'b0) begin
        pc_write_to_host_cnt <= 32'b0;
        pc_write_to_host_flag <= 1'b0;
        pc_write_to_host_cycle <= 32'b0;
    end
    else if (chk_write_tohost) begin
        pc_write_to_host_cnt <= pc_write_to_host_cnt + 1'b1;
        pc_write_to_host_flag <= 1'b1;
        if (pc_write_to_host_flag == 1'b0) begin
            pc_write_to_host_cycle <= cycle_count;
        end
    end
  end

  always @(posedge tb_clk or negedge tb_rst_n)
  begin 
    if(tb_rst_n == 1'b0) begin
        cycle_count <= 32'b0;
    end
    else begin
        cycle_count <= cycle_count + 1'b1;
    end
  end



endmodule



