`ifndef MDU_V
`define MDU_V

`timescale 1ns / 1ps
`include "instr.vh"
module mdu(
           input wire clk,
           input wire reset,
           input wire [31:0] srcA,
           input wire [31:0] srcB,
           input wire [5:0] instr,
           output wire busy,
           output reg [31:0] ans
       );

reg [31:0] high,low;
reg [3:0] delay;
initial begin
    high = 32'b0;
    low = 32'b0;
    delay = 4'b0;
    ans = 32'b0;
end

assign busy = (delay != 0) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if(reset) begin
        high <= 32'b0;
        low <= 32'b0;
        delay <= 4'b0;
        ans <= 32'b0;
    end
    else begin
        if(delay != 0) begin
            delay <= delay - 1;
        end
        else
        case (instr)
            `mult: begin
                {high,low} <= $signed(srcA) * $signed(srcB);
                delay <= 5;
            end
            `multu: begin
                {high,low} <= srcA * srcB;
                delay <= 5;
            end
            `div: begin
                high = $signed(srcA) % $signed(srcB);
                low = $signed(srcA) / $signed(srcB);
                delay <= 10;
            end
            `divu: begin
                high = srcA % srcB;
                low = srcA / srcB;
                delay <= 10;
            end
            `mflo:begin
                ans <= low;
            end
            `mfhi:begin
                ans <= high;
            end
            `mtlo:begin
                low <= srcA;
            end
            `mthi:begin
                high <= srcA;
            end
            default:
                ;
        endcase
    end

end

endmodule

`endif