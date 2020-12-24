`include "grf.v"
`include "ext.v"
`include "ctrlor.v"
`include "mux.v"
`include "branch.v"

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
           input wire[31:0] WB_pc_in,

           input wire forward_rs_src,
           input wire forward_rt_src,
           input wire [31:0] forward_data_MEM,

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


wire ext_op,jump,jump_reg;
wire [31:0] extend_imme;
wire [31:0] reg_read_data1,reg_read_data2;

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
           .EXTop(ext_op),
           .writeR31(),
           .Jump(jump),
           .JumpToReg(jump_reg),
           .ALUop()
       );

wire [4:0] rs,rt;

assign rs = instructure_in[25:21];
assign rt = instructure_in[20:16];


wire [31:0] grf_out_data1,grf_out_data2;

grf GRF(
        //in
        .clk(clk),
        .reset(reset),
        .writeEnable(reg_write_en),
        .PCReg(WB_pc_in),
        .readReg1(rs),
        .readReg2(rt),
        .writeReg(reg_write_addr),
        .writeData(reg_write_data),
        //out
        .readData1(grf_out_data1),
        .readData2(grf_out_data2)
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


mux_32b forward_rs_mux(
            .in0(grf_out_data1),
            .in1(forward_data_MEM),
            .sel(forward_rs_src),

            .out(reg_read_data1)
        );

mux_32b forward_rt_mux(
            .in0(grf_out_data2),
            .in1(forward_data_MEM),
            .sel(forward_rt_src),

            .out(reg_read_data2)
        );


assign pc_out = pc_in;
assign instructure_out = instructure_in;
assign instr_code_out = instr_code_in;
assign reg_read_data1_out = reg_read_data1;
assign reg_read_data2_out = reg_read_data2;
assign extend_imme_out = extend_imme;

branch BRANCH(
           .instr_code_in(instr_code_in),
           .srcA(reg_read_data1),
           .srcB(reg_read_data2),

           .out(branch_out)
       );

assign branch_addr = extend_imme;

assign jump_out = jump;
assign jump_addr = instructure_in[25:0];

assign jump_reg_out = jump_reg;
assign jump_reg_addr = reg_read_data1;



endmodule

