`include "instr.vh"
`include "constant.vh"

`timescale 1ns / 1ps

module MEM_WB (
           input wire clk,
           input wire reset,
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           input wire[5:0] instr_code_in,
           input wire [31:0] alu_result_in,
           input wire [31:0] mem_read_data_in,

           output wire [31:0] pc_out,
           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire [31:0] alu_result_out,
           output wire [31:0] mem_read_data_out
       );

reg [31:0] pc,instructure,
    alu_result,mem_read_data;
reg[5:0] instr_code;

assign pc_out = pc;
assign instructure_out = instructure;
assign instr_code_out = instr_code;
assign alu_result_out = alu_result;
assign mem_read_data_out = mem_read_data;



initial begin
    pc <= `PC_START;
    instructure <= 32'h0000_0000;
    instr_code <= `nop;
    alu_result <= 32'h0000_0000;
    mem_read_data <= 32'h0000_0000;
end

always @(posedge clk) begin
    if(reset) begin
        pc <= `PC_START;
        instructure <= 32'h0000_0000;
        instr_code <= `nop;
        alu_result <= 32'h0000_0000;
        mem_read_data <= 32'h0000_0000;
    end
    else begin
        pc <= pc_in;
        instructure <= instructure_in;
        instr_code <= instr_code_in;
        alu_result <= alu_result_in;
        mem_read_data <= mem_read_data_in;
    end
end

endmodule
