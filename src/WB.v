`include "dm.v"
`include "ctrlor.v"
`include "mux.v"

`timescale 1ns / 1ps

module WB (
           input wire [31:0] pc_in,
           input wire [31:0] instructure_in,
           input wire [5:0] instr_code_in,
           input wire [31:0] alu_result_in,
           input wire [31:0] mem_read_data_in,

           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire reg_write_en,
           output wire [4:0] reg_write_addr,
           output wire [31:0] reg_write_data
       );

wire write_r31;

ctrlor CTR(
           //in
           .instr(instr_code_in),
           //out
           .RegWrite(reg_write_en),
           .RegDst(),
           .ALUSrc(),
           .Branch(),
           .MemWrite(),
           .MemtoReg(),
           .EXTop(),
           .writeR31(write_r31),
           .Jump(),
           .JumpToReg(),
           .ALUop()
       );






endmodule
