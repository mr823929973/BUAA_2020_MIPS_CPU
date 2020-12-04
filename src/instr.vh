`ifndef INSTR_VH
`define INSTR_VH

`define sll  6'd0
`define nop  6'd0

`define addu 6'd1
`define subu 6'd2
`define ori  6'd3

`define lw   6'd4
`define sw   6'd5

`define beq  6'd6
`define lui  6'd7

`define j    6'd8
`define jal  6'd9
`define jr   6'd10

`define andi 6'd11

`endif