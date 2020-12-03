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

           input wire [1:0] forward_rs_src,
           input wire [1:0] forward_rt_src,
           input wire [31:0] forward_data_MEM,
           input wire [31:0] forward_data_WB,
           
           output wire [31:0] pc_out,
           output wire [31:0] instructure_out,
           output wire [5:0] instr_code_out,
           output wire [31:0] alu_result_out,
           output wire [31:0] reg_read_data2_out
       );

wire [2:0] alu_op;
wire alu_src,write_r31;
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
           .writeR31(write_r31),
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

wire [31:0] forward_rs_mux_out,forward_rt_mux_out;


mux_32b_4 forward_rs_mux(
            .in0(reg_read_data1_in),
            .in1(forward_data_MEM),
            .in2(forward_data_WB),
            .in3(32'hxxxx_xxxx),
            .sel(forward_rs_src),

            .out(forward_rs_mux_out)
        );

mux_32b_4 forward_rt_mux(
            .in0(alu_src_mux_out),
            .in1(forward_data_MEM),
            .in2(forward_data_WB),
            .in3(32'hxxxx_xxxx),
            .sel(forward_rt_src),

            .out(forward_rt_mux_out)
        );

wire[31:0] alu_out;

alu ALU(
        //in
        .srcA(forward_rs_mux_out),
        .srcB(forward_rt_mux_out),
        .s(s),
        .ALUop(alu_op),
        //out
        .zero(),
        .ALUout(alu_out)
    );

mux_32b alu_result_mux(
            .in0(alu_out),
            .in1(pc_in + 8),
            .sel(write_r31),
            .out(alu_result)
        );

assign pc_out = pc_in;
assign instructure_out = instructure_in;
assign instr_code_out = instr_code_in;
assign reg_read_data2_out = reg_read_data2_in;
assign alu_result_out = alu_result;

endmodule
