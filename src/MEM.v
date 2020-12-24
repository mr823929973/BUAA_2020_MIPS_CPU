`include "dm.v"
`include "ctrlor.v"
`include "mux.v"
`include "byte.v"

`timescale 1ns / 1ps

module MEM (
           input wire clk,
           input wire reset,
           input wire [31:0] pc_in,
           input wire [31:0] instructure_in,
           input wire [5:0] instr_code_in,
           input wire [31:0] alu_result_in,
           input wire [31:0] reg_read_data2_in,

           input wire forward_rt_src,
           input wire [31:0] forward_data_WB,

           output wire [31:0] pc_out,
           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire [31:0] alu_result_out,
           output wire [31:0] mem_read_data_out
       );

wire mem_write_en;
wire [31:0] mem_read_data;
wire [2:0] load;
wire [1:0] save;

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
           .ALUop(),
           .load(load),
           .save(save)
       );

wire [31:0] forward_rt_mux_out;

mux_32b forward_rt_mux(
            .in0(reg_read_data2_in),
            .in1(forward_data_WB),
            .sel(forward_rt_src),

            .out(forward_rt_mux_out)
        );

wire[3:0] byte_select;

dm DM(
       //in
       .clk(clk),
       .reset(reset),
       .MemWrite(mem_write_en),
       .PC(pc_in),
       .addr(alu_result_in),
       .writeData(forward_rt_mux_out),
       .byte_select(byte_select),
       //out
       .readData(mem_read_data)
   );

byte_selector BYTE_SLT(
    .addr(alu_result_in),
    .save(save),

    .byte(byte_select)
);

wire [31:0] byte_ext_out;

byte_extender BYTE_EXT(
    .addr(alu_result_in),
    .data_in(mem_read_data),
    .load(load),

    .data_out(byte_ext_out)
);


assign pc_out = pc_in;
assign instructure_out = instructure_in;
assign instr_code_out = instr_code_in;
assign alu_result_out = alu_result_in;
assign mem_read_data_out = byte_ext_out;


endmodule
