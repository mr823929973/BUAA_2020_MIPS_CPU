`include "instr.vh"
`include "constant.vh"

`timescale 1ns / 1ps

module ID_EX (
           input wire clk,
           input wire reset,
           input wire stall,
           input wire[31:0] pc_in,
           input wire[31:0] instructure_in,
           input wire[5:0] instr_code_in,
           input wire [31:0] reg_read_data1_in,
           input wire [31:0] reg_read_data2_in,
           input wire [31:0] extend_imme_in,

           output wire[31:0] pc_out,
           output wire[31:0] instructure_out,
           output wire[5:0] instr_code_out,
           output wire [31:0] reg_read_data1_out,
           output wire [31:0] reg_read_data2_out,
           output wire [31:0] extend_imme_out
       );

reg [31:0] pc,instructure,
    reg_read_data1,reg_read_data2,extend_imme;
reg[5:0] instr_code;

assign pc_out = pc;
assign instructure_out = instructure;
assign instr_code_out = instr_code;
assign reg_read_data1_out = reg_read_data1;
assign reg_read_data2_out = reg_read_data2;
assign extend_imme_out = extend_imme;



initial begin
    pc <= `PC_START;
    instructure <= 32'h0000_0000;
    instr_code <= `nop;
    reg_read_data1 <= 32'h0000_0000;
    reg_read_data2 <= 32'h0000_0000;
    extend_imme <= 32'h0000_0000;
end

always @(posedge clk) begin
    if(reset | stall) begin
        pc <= `PC_START;
        instructure <= 32'h0000_0000;
        instr_code <= `nop;
        reg_read_data1 <= 32'h0000_0000;
        reg_read_data2 <= 32'h0000_0000;
        extend_imme <= 32'h0000_0000;
    end
    else begin
        pc <= pc_in;
        instructure <= instructure_in;
        instr_code <= instr_code_in;
        reg_read_data1 <= reg_read_data1_in;
        reg_read_data2 <= reg_read_data2_in;
        extend_imme <= extend_imme_in;
    end
end

endmodule
