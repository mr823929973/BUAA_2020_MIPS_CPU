`include "instr.vh"
`include "constant.vh"
`include "instrDecoder.v"

`timescale 1ns / 1ps

module IF_ID (
           input wire clk,
           input wire reset,
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           output wire[31:0] pc_out,
           output wire[31:0] instructure_out,
           output wire[5:0] instr_code
       );

reg [31:0] pc;
reg [31:0] instructure;
assign pc_out = pc;
assign instructure_out = instructure;

instrDecoder IDC(
                 .instructure_in(instructure),
                 .instrCode_out(instr_code)
             );

initial begin
    pc <= `PC_START;
    instructure <= 32'h0000_0000;
end

always @(posedge clk) begin
    if(reset) begin
        pc <= `PC_START;
        instructure <= 32'h0000_0000;
    end
    else begin
        pc <= pc_in;
        instructure <= instructure_in;
    end
end

endmodule
