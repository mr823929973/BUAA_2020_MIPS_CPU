`include "IF.v"
`include "IF_ID.v"
`include "ID.v"
`include "ID_EX.v"
`include "EX.v"
`include "EX_MEM.v"
`include "MEM.v"
`include "MEM_WB.v"
`include "WB.v"
`include "hazard.v"

`timescale 1ns / 1ps

module mips (
           input wire clk,
           input wire reset
       );

wire stall,busy;
wire [31:0] MEM_forward_data,WB_forward_data;
wire forward_rs_ID_src, forward_rt_ID_src;
wire [1:0] forward_rs_EX_src, forward_rt_EX_src;
wire forward_rt_MEM_src;

wire [31:0] IF_pc,IF_instructure;
wire ID_branch,ID_jump,ID_jump_reg;
wire [31:0] ID_branch_addr,ID_jump_reg_addr;
wire [25:0] ID_jump_addr;

IF pipeline_IF (
       //in
       .clk(clk),
       .reset(reset),
       .stall(stall),
       .isBranch(ID_branch),
       .branchAddr(ID_branch_addr),
       .isJump(ID_jump),
       .jumpAddr(ID_jump_addr),
       .isJumpReg(ID_jump_reg),
       .jumpRegAddr(ID_jump_reg_addr),
       //out
       .PC(IF_pc),
       .instructure(IF_instructure)
   );

wire [31:0] IF_ID_pc,IF_ID_instructure;
wire [5:0] IF_ID_instr_code;
IF_ID pipeline_IF_ID (
          //in
          .clk(clk),
          .reset(reset),
          .stall(stall),
          .pc_in(IF_pc),
          .instructure_in(IF_instructure),
          //out
          .pc_out(IF_ID_pc),
          .instructure_out(IF_ID_instructure),
          .instr_code(IF_ID_instr_code)
      );


wire [31:0] ID_pc,ID_instructure;
wire [5:0] ID_instr_code;
wire [31:0] ID_reg_read_data1,ID_reg_read_data2;
wire [31:0] ID_extend_imme;

wire WB_reg_write_en;
wire [4:0] WB_reg_write_addr;
wire [31:0] WB_reg_write_data;
wire [31:0] WB_pc;
ID pipeline_ID(
       //in
       .clk(clk),
       .reset(reset),
       .pc_in(IF_ID_pc),
       .instructure_in(IF_ID_instructure),
       .instr_code_in(IF_ID_instr_code),
       .reg_write_en(WB_reg_write_en),
       .reg_write_addr(WB_reg_write_addr),
       .reg_write_data(WB_reg_write_data),
       .WB_pc_in(WB_pc),
       //forward in
       .forward_rs_src(forward_rs_ID_src),
       .forward_rt_src(forward_rt_ID_src),
       .forward_data_MEM(MEM_forward_data),
       //out
       .pc_out(ID_pc),
       .instructure_out(ID_instructure),
       .instr_code_out(ID_instr_code),
       .reg_read_data1_out(ID_reg_read_data1),
       .reg_read_data2_out(ID_reg_read_data2),
       .extend_imme_out(ID_extend_imme),
       //branch jump out
       .branch_out(ID_branch),
       .branch_addr(ID_branch_addr),
       .jump_out(ID_jump),
       .jump_addr(ID_jump_addr),
       .jump_reg_out(ID_jump_reg),
       .jump_reg_addr(ID_jump_reg_addr)
   );

wire [31:0] ID_EX_pc,ID_EX_instructure;
wire [5:0] ID_EX_instr_code;
wire [31:0] ID_EX_reg_read_data1,ID_EX_reg_read_data2;
wire [31:0] ID_EX_extend_imme;
ID_EX pipeline_ID_EX(
          //in
          .clk(clk),
          .reset(reset),
          .stall(stall),
          .pc_in(ID_pc),
          .instructure_in(ID_instructure),
          .instr_code_in(ID_instr_code),
          .reg_read_data1_in(ID_reg_read_data1),
          .reg_read_data2_in(ID_reg_read_data2),
          .extend_imme_in(ID_extend_imme),
          //out
          .pc_out(ID_EX_pc),
          .instructure_out(ID_EX_instructure),
          .instr_code_out(ID_EX_instr_code),
          .reg_read_data1_out(ID_EX_reg_read_data1),
          .reg_read_data2_out(ID_EX_reg_read_data2),
          .extend_imme_out(ID_EX_extend_imme)
      );

wire [31:0] EX_pc,EX_instructure;
wire [5:0] EX_instr_code;
wire [31:0] EX_alu_result,EX_reg_read_data2;
EX pipeline_EX(
       .reset(reset),
       .clk(clk),
       //in
       .pc_in(ID_EX_pc),
       .instructure_in(ID_EX_instructure),
       .instr_code_in(ID_EX_instr_code),
       .reg_read_data1_in(ID_EX_reg_read_data1),
       .reg_read_data2_in(ID_EX_reg_read_data2),
       .extend_imme_in(ID_EX_extend_imme),
       //forward in
       .forward_rs_src(forward_rs_EX_src),
       .forward_rt_src(forward_rt_EX_src),
       .forward_data_MEM(MEM_forward_data),
       .forward_data_WB(WB_forward_data),
       //out
       .pc_out(EX_pc),
       .instructure_out(EX_instructure),
       .instr_code_out(EX_instr_code),
       .alu_result_out(EX_alu_result),
       .reg_read_data2_out(EX_reg_read_data2),
       .busy(busy)
   );

wire [31:0] EX_MEM_pc,EX_MEM_instructure;
wire [5:0] EX_MEM_instr_code;
wire [31:0] EX_MEM_alu_result,EX_MEM_reg_read_data2;

assign MEM_forward_data = EX_MEM_alu_result;

EX_MEM pipeline_EX_MEM(
           //in
           .clk(clk),
           .reset(reset),
           .pc_in(EX_pc),
           .instructure_in(EX_instructure),
           .instr_code_in(EX_instr_code),
           .alu_result_in(EX_alu_result),
           .reg_read_data2_in(EX_reg_read_data2),
           //out
           .pc_out(EX_MEM_pc),
           .instructure_out(EX_MEM_instructure),
           .instr_code_out(EX_MEM_instr_code),
           .alu_result_out(EX_MEM_alu_result),
           .reg_read_data2_out(EX_MEM_reg_read_data2)
       );

wire [31:0] MEM_pc,MEM_instructure;
wire [5:0] MEM_instr_code;
wire [31:0] MEM_alu_result,MEM_mem_read_data;
MEM pipeline_MEM(
        //in
        .clk(clk),
        .reset(reset),
        .pc_in(EX_MEM_pc),
        .instructure_in(EX_MEM_instructure),
        .instr_code_in(EX_MEM_instr_code),
        .alu_result_in(EX_MEM_alu_result),
        .reg_read_data2_in(EX_MEM_reg_read_data2),
        //forward in
        .forward_rt_src(forward_rt_MEM_src),
        .forward_data_WB(WB_forward_data),
        //out
        .pc_out(MEM_pc),
        .instructure_out(MEM_instructure),
        .instr_code_out(MEM_instr_code),
        .alu_result_out(MEM_alu_result),
        .mem_read_data_out(MEM_mem_read_data)
    );

wire [31:0] MEM_WB_pc,MEM_WB_instructure;
wire [5:0] MEM_WB_instr_code;
wire [31:0] MEM_WB_alu_result,MEM_WB_mem_read_data;


MEM_WB pipeline_MEM_WB(
           //in
           .clk(clk),
           .reset(reset),
           .pc_in(MEM_pc),
           .instructure_in(MEM_instructure),
           .instr_code_in(MEM_instr_code),
           .alu_result_in(MEM_alu_result),
           .mem_read_data_in(MEM_mem_read_data),
           //out
           .pc_out(MEM_WB_pc),
           .instructure_out(MEM_WB_instructure),
           .instr_code_out(MEM_WB_instr_code),
           .alu_result_out(MEM_WB_alu_result),
           .mem_read_data_out(MEM_WB_mem_read_data)
       );

WB pipeline_WB(
       //in
       .pc_in(MEM_WB_pc),
       .instructure_in(MEM_WB_instructure),
       .instr_code_in(MEM_WB_instr_code),
       .alu_result_in(MEM_WB_alu_result),
       .mem_read_data_in(MEM_WB_mem_read_data),
       //out
       .reg_write_en_out(WB_reg_write_en),
       .reg_write_addr_out(WB_reg_write_addr),
       .reg_write_data_out(WB_reg_write_data),
       .pc_out(WB_pc)
   );

assign WB_forward_data = WB_reg_write_data;

hazard HAZARD (
           //in
           .IF_ID_instructure_in(IF_ID_instructure),
           .IF_ID_instr_code(IF_ID_instr_code),
           .ID_EX_instructure_in(ID_EX_instructure),
           .ID_EX_instr_code(ID_EX_instr_code),
           .EX_MEM_instructure_in(EX_MEM_instructure),
           .EX_MEM_instr_code(EX_MEM_instr_code),
           .MEM_WB_instructure_in(MEM_WB_instructure),
           .MEM_WB_instr_code(MEM_WB_instr_code),
           .busy(busy),
           //out
           .stall(stall),
           .forward_rs_ID(forward_rs_ID_src),
           .forward_rt_ID(forward_rt_ID_src),
           .forward_rs_EX(forward_rs_EX_src),
           .forward_rt_EX(forward_rt_EX_src),
           .forward_rt_MEM(forward_rt_MEM_src)
       );

endmodule
