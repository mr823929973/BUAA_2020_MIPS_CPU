`include "ifu.v"
`include "alu.v"
`include "dm.v"
`include "grf.v"
`include "ext.v"
`include "mux.v"

`timescale 1ns / 1ps

module datapath (
           input clk,
           input reset,
           input RegWrite,
           input RegDst,
           input ALUSrc,
           input Branch,
           input MemWrite,
           input MemtoReg,
           input EXTop,
           input Jump,
           input writeR31,
           input JumpToReg,
           input [2:0] ALUop,
           output [5:0] opCode,
           output [5:0] Funct
       );


wire [31:0] PC,instructure,SignImm;
wire [31:0] grfRD1,grfRD2;
wire [31:0] ALUResult;
wire ALUZero;
wire [31:0] dmReadData;

assign opCode = instructure[31:26];
assign Funct = instructure[5:0];

wire [4:0] grfWA;
wire [31:0] grfWD;

/*ifu*/
wire [25:0] jumpAddr;
assign jumpAddr = instructure[25:0];

ifu IFU(
        //in
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .isBranch(ALUZero & Branch),
        .branchAddr(SignImm),
        .isJump(Jump),
        .jumpAddr(jumpAddr),
        .isJumpReg(JumpToReg),
        .jumpRegAddr(grfRD1),
        //out
        .instructure(instructure)
    );

/*grf*/
wire [4:0] rs,rt,rd;
wire [4:0] regDstMuxOut;

assign rs = instructure[25:21];
assign rt = instructure[20:16];
assign rd = instructure[15:11];
assign s = instructure[10:6];

mux_5b regDstMux(
           .in0(rt),
           .in1(rd),
           .sel(RegDst),
           .out(regDstMuxOut)
       );

grf GRF(
        //in
        .clk(clk),
        .reset(reset),
        .writeEnable(RegWrite),
        .PCReg(PC),
        .readReg1(rs),
        .readReg2(rt),
        .writeReg(grfWA),
        .writeData(grfWD),
        //out
        .readData1(grfRD1),
        .readData2(grfRD2)
    );

/*ext*/
wire [15:0] imme;
assign imme = instructure[15:0];

ext EXT(
        .in(imme),
        .zero(EXTop),
        .out(SignImm)
    );

/*alu*/
wire [31:0] aluSrcMuxOut;
wire [4:0] s;
assign s = instructure[10:6];

mux_32b aluSRCMux(
            .in0(grfRD2),
            .in1(SignImm),
            .sel(ALUSrc),
            .out(aluSrcMuxOut)
        );

alu ALU(
        .srcA(grfRD1),
        .srcB(aluSrcMuxOut),
        .s(s),
        .ALUop(ALUop),
        .zero(ALUzero),
        .ALUout(ALUResult)
    );

/*dm*/

wire[31:0] memToRegMuxOut;

dm DM(
       .clk(clk),
       .reset(reset),
       .MemWrite(MemWrite),
       .PC(PC),
       .addr(ALUResult),
       .writeData(grfRD2),
       .readData(dmReadData)
   );

mux_32b memToRegMux(
            .in0(ALUResult),
            .in1(dmReadData),
            .sel(MemtoReg),
            .out(memToRegMuxOut)
        );

mux_32b grfWDMux(
            .in0(memToRegMuxOut),
            .in1(PC+4),
            .sel(writeR31),
            .out(grfWD)
        );

mux_5b grfWAMux(
           .in0(regDstMuxOut),
           .in1(5'd31),
           .sel(writeR31),
           .out(grfWA)
       );



endmodule
