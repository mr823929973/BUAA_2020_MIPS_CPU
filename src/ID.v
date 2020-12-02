`include "grf.v"
`include "ext.v"
`include "ctrlor.v"

`timescale 1ns / 1ps

module ID (
           input wire clk,
           input wire reset,
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           input wire[5:0] instr_code_in
       );

ctrlor CTR(
            //in
           .instr(instr_code_in),
           //out
           .RegWrite(),
           .RegDst(),
           .ALUSrc(),
           .Branch(),
           .MemWrite(),
           .MemtoReg(),
           .EXTop(),
           .writeR31(),
           .Jump(),
           .JumpToReg(),
           .ALUop()
       );

grf GRF(
        //in
        .clk(clk),
        .reset(reset),
        .writeEnable(),
        .PCReg(),
        .readReg1(),
        .readReg2(),
        .writeReg(),
        .writeData(),
        //out
        .readData1(),
        .readData2()
    );

ext EXT(
        //in
        .in(),
        //out
        .zero(),
        .out()
    );



endmodule
