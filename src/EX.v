`include "instr.vh"
`include "constant.vh"
`include "ctrlor.v"
`include "mux.v"
`include "alu.v"

`timescale 1ns / 1ps

module EX (
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           input wire[5:0] instr_code_in,
           input wire [31:0] reg_read_data1_in,
           input wire [31:0] reg_read_data2_in,
           input wire [31:0] extend_imme_in,
           
           output wire [31:0] pc_out,
           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire [31:0] alu_result_out,
           output wire [31:0] reg_read_data2_out
       );

wire [2:0] alu_op;
wire alu_src;
wire [31:0] alu_result;



ctrlor CTR(
           //in
           .instr(instr_code_in),
           //out
           .RegWrite(),
           .RegDst(),
           .ALUSrc(alu_src),
           .Branch(),
           .MemWrite(),
           .MemtoReg(),
           .EXTop(),
           .writeR31(),
           .Jump(),
           .JumpToReg(),
           .ALUop(alu_op)
       );

wire [31:0] alu_src_mux_out;
wire [4:0] s;
assign s = instructure_in[10:6];

mux_32b alu_src_mux(
            .in0(reg_read_data2_in),
            .in1(extend_imme_in),
            .sel(alu_src),
            .out(alu_src_mux_out)
        );

alu ALU(
        //in
        .srcA(reg_read_data1_in),
        .srcB(alu_src_mux_out),
        .s(s),
        .ALUop(alu_op),
        //out
        .zero(),
        .ALUout(alu_result)
    );


endmodule
