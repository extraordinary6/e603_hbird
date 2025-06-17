
module tb_exception_check
   #(parameter XLEN=32) 
(
    input            trace_ivalid,
    input [XLEN-1:0] trace_pc,
    input [XLEN-1:0] trace_cause,
    input [XLEN-1:0] trace_tval,
    input [31:0]     trace_opcode,
    input            trace_iexception,
    input            core_wfi_mode,

    input clk,
    input rst_n
);

    bit check_enable;
    bit [31:0] wfi_counter;

    initial begin
        wfi_counter = 32'b0;
        check_enable = 1'b0;
        if ($test$plusargs("TB_EXCEPTION_CHECK")) 
            check_enable = 1'b1;
    end

    always @(posedge clk) begin
        if (rst_n) begin
            if (trace_ivalid & trace_iexception & check_enable) begin
                if (trace_opcode != 32'h00000073) begin // ignore ecall
                    $fatal("Exception happen, PC:0x%h, opcode:0x%h, cause:0x%h, tval:0x%h", 
                           trace_pc, trace_opcode, trace_cause, trace_tval);
                end
            end
        end
    end
    always @(posedge clk) begin
        if (check_enable & core_wfi_mode) 
            wfi_counter <= wfi_counter + 1'b1;
        else
            wfi_counter <= 32'b0;

        if (wfi_counter > 50) begin
            $fatal("WFI happen");
        end
    end

endmodule
