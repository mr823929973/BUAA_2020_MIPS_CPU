`ifndef BRANCH_V
`define BRANCH_V

`include "instr.vh"

`timescale 1ns / 1ps

module branch(
           input wire[5:0] instr_code_in,
           input wire[31:0] srcA,
           input wire[31:0] srcB,
           output reg branch_out
       );

always @(*) begin
    case (instr_code_in)
        `beq:
            branch_out = (srcA == srcB) ? 1'b1 : 1'b0;
        `bne:
            branch_out = (srcA != srcB) ? 1'b1 : 1'b0;
        `blez:
            branch_out = ($signed(srcA) <= $signed(0) ) ? 1'b1 : 1'b0;
        `bltz:
            branch_out = ($signed(srcA) < $signed(0) ) ? 1'b1 : 1'b0;
        `bgez:
            branch_out = ($signed(srcA) >= $signed(0) ) ? 1'b1 : 1'b0;
        `bgtz:
            branch_out = ($signed(srcA) > $signed(0) ) ? 1'b1 : 1'b0;
        default:
            branch_out = 1'b0;
    endcase
end


endmodule

`endif
