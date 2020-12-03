`include "instr.vh"
`include "constant.vh"

`timescale 1ns / 1ps

module EX_MEM (
           input wire clk,
           input wire reset,
           input wire [31:0] pc_in,
           input wire [31:0] instructure_in,
           input wire [5:0] instr_code_in,
           input wire [31:0] alu_result_in,
           input wire [31:0] reg_read_data2_in,

           output wire [31:0] pc_out,
           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire [31:0] alu_result_out,
           output wire [31:0] reg_read_data2_out
       );

reg [31:0] pc,instructure,
    alu_result,reg_read_data2;
reg[5:0] instr_code;

assign pc_out = pc;
assign instructure_out = instructure;
assign instr_code_out = instr_code;
assign alu_result_out = alu_result;
assign reg_read_data2_out = reg_read_data2;

initial begin
    pc <= `PC_START;
    instructure <= 32'h0000_0000;
    instr_code <= `nop;
    reg_read_data2 <= 32'h0000_0000;
    alu_result <= 32'h0000_0000;
end

always @(posedge clk) begin
    if(reset) begin
        pc <= `PC_START;
        instructure <= 32'h0000_0000;
        instr_code <= `nop;
        reg_read_data2 <= 32'h0000_0000;
        alu_result <= 32'h0000_0000;
    end
    else begin
        pc <= pc_in;
        instructure <= instructure_in;
        instr_code <= instr_code_in;
        alu_result <= alu_result_in;
        reg_read_data2 <= reg_read_data2_in;
    end
end

endmodule
