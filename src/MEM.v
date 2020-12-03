`include "dm.v"
`include "ctrlor.v"
`include "mux.v"

`timescale 1ns / 1ps

module MEM (
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
           output wire [31:0] mem_read_data_out
       );

wire mem_write_en;
wire [31:0] mem_read_data;

ctrlor CTR(
           //in
           .instr(instr_code_in),
           //out
           .RegWrite(),
           .RegDst(),
           .ALUSrc(),
           .Branch(),
           .MemWrite(mem_write_en),
           .MemtoReg(),
           .EXTop(),
           .writeR31(),
           .Jump(),
           .JumpToReg(),
           .ALUop()
       );

dm DM(
       .clk(clk),
       .reset(reset),
       .MemWrite(mem_write_en),
       .PC(pc_in),
       .addr(alu_result_in),
       .writeData(reg_read_data2_in),
       .readData(mem_read_data)
   );

assign pc_out = pc_in;
assign instructure_out = instructure_in;
assign instr_code_out = instr_code_in;
assign alu_result_out = alu_result_in;
assign mem_read_data_out = mem_read_data;


endmodule
