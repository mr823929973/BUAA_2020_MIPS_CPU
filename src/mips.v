`include "datapath.v"
`include "instrDecoder.v"
`include "ctrlor.v"

`timescale 1ns / 1ps

module mips (
           input clk,
           input reset
       );

wire RegWrite;
wire RegDst;
wire ALUSrc;
wire Branch;
wire MemWrite;
wire MemtoReg;
wire EXTop;
wire Jump;
wire writeR31;
wire JumpToReg;
wire [2:0] ALUop;
wire [5:0] opCode;
wire [5:0] Funct;
wire [3:0] instr;


datapath DATAPATH(
             .clk(clk),
             .reset(reset),
             .RegWrite(RegWrite),
             .RegDst(RegDst),
             .ALUSrc(ALUSrc),
             .Branch(Branch),
             .MemWrite(MemWrite),
             .MemtoReg(MemtoReg),
             .EXTop(EXTop),
             .writeR31(writeR31),
             .Jump(Jump),
             .JumpToReg(JumpToReg),
             .ALUop(ALUop),
             .opCode(opCode),
             .Funct(Funct)
         );

instrDecoder IDC(
                 .opCode(opCode),
                 .Funct(Funct),
                 .instr(instr)
             );

ctrlor CTR(
           .instr(instr),
           .RegWrite(RegWrite),
           .RegDst(RegDst),
           .ALUSrc(ALUSrc),
           .Branch(Branch),
           .MemWrite(MemWrite),
           .MemtoReg(MemtoReg),
           .EXTop(EXTop),
           .writeR31(writeR31),
           .Jump(Jump),
           .JumpToReg(JumpToReg),
           .ALUop(ALUop)
       );

endmodule
