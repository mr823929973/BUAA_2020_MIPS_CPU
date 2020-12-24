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

           output wire reg_write_en_out,
           output wire [4:0] reg_write_addr_out,
           output wire [31:0] reg_write_data_out,
           output wire [31:0] pc_out
       );

wire reg_dst,write_r31,reg_write,mem_to_reg;
wire[4:0] rt,rd;

assign rt = instructure_in[20:16];
assign rd = instructure_in[15:11];

ctrlor CTR(
           //in
           .instr(instr_code_in),
           //out
           .RegWrite(reg_write),
           .RegDst(reg_dst),
           .ALUSrc(),
           .Branch(),
           .MemWrite(),
           .MemtoReg(mem_to_reg),
           .EXTop(),
           .writeR31(write_r31),
           .Jump(),
           .JumpToReg(),
           .ALUop()
       );

wire [4:0] reg_dst_mux_out;

mux_5b reg_dst_mux(
           .in0(rt),
           .in1(rd),
           .sel(reg_dst),

           .out(reg_dst_mux_out)
       );

wire [4:0] reg_write_addr;

mux_5b write_r31_mux(
           .in0(reg_dst_mux_out),
           .in1(5'd31),
           .sel(write_r31),

           .out(reg_write_addr)
       );

wire [31:0] mem_to_reg_mux_out;

mux_32b mem_to_reg_mux(
            .in0(alu_result_in),
            .in1(mem_read_data_in),
            .sel(mem_to_reg),

            .out(mem_to_reg_mux_out)
        );

wire [31:0] reg_write_data;

mux_32b write_r31_data_mux(
            .in0(mem_to_reg_mux_out),
            .in1(mem_to_reg_mux_out),
            .sel(write_r31),

            .out(reg_write_data)
        );
     


assign reg_write_en_out = reg_write;
assign reg_write_addr_out = reg_write_addr;
assign reg_write_data_out = reg_write_data;
assign pc_out = pc_in;

endmodule
