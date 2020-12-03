`include "grf.v"
`include "ext.v"
`include "ctrlor.v"
`include "mux.v"

`timescale 1ns / 1ps

module ID (
           input wire clk,
           input wire reset,
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           input wire[5:0] instr_code_in,
           input wire reg_write_en,
           input wire[4:0] reg_write_addr,
           input wire[31:0] reg_write_data,

           output wire[31:0] pc_out,
           output wire[31:0] instructure_out,
           output wire[5:0] instr_code_out, 
           output wire [31:0] reg_read_data1_out,
           output wire [31:0] reg_read_data2_out,
           output wire [31:0] extend_imme_out,
           
           output wire branch_out,
           output wire [31:0] branch_addr,
           output wire jump_out,
           output wire [25:0] jump_addr,
           output wire jump_reg_out,
           output wire [31:0] jump_reg_addr
       );


wire ext_op,branch,jump,jump_reg;
wire [31:0] extend_imme;
wire [31:0] reg_read_data1,reg_read_data2;

ctrlor CTR(
           //in
           .instr(instr_code_in),
           //out
           .RegWrite(),
           .RegDst(),
           .ALUSrc(),
           .Branch(branch),
           .MemWrite(),
           .MemtoReg(),
           .EXTop(ext_op),
           .writeR31(),
           .Jump(jump),
           .JumpToReg(jump_reg),
           .ALUop()
       );

wire [4:0] rs,rt;

assign rs = instructure_in[25:21];
assign rt = instructure_in[20:16];


grf GRF(
        //in
        .clk(clk),
        .reset(reset),
        .writeEnable(reg_write_en),
        .PCReg(pc_in),
        .readReg1(rs),
        .readReg2(rt),
        .writeReg(reg_write_addr),
        .writeData(reg_write_data),
        //out
        .readData1(reg_read_data1),
        .readData2(reg_read_data2)
    );

wire [15:0] imme;

assign imme = instructure_in[15:0];

ext EXT(
        //in
        .in(imme),
        .zero(ext_op),
        //out
        .out(extend_imme)
    );


assign pc_out = pc_in;
assign instructure_in = instructure_out;
assign instr_code_in = instr_code_out;
assign reg_read_data1_out = reg_read_data1;
assign reg_read_data2_out = reg_read_data2;
assign extend_imme_out = extend_imme;


assign branch_out = branch &
       ((reg_read_data1 == reg_read_data2) ? 1'b1 : 1'b0);
assign branch_addr = extend_imme;

assign jump_out = jump;
assign jump_addr = instructure_in[25:0];

assign jump_reg = jump_reg;
assign jump_reg_addr = reg_read_data1;



endmodule
