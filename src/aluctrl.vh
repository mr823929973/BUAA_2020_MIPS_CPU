`ifndef ALUCTRL_VH
`define ALUCTRL_VH

`define ALU_AND  4'b0000
`define ALU_OR   4'b0001
`define ALU_XOR  4'b0010
`define ALU_NOR  4'b0011
`define ALU_ADD  4'b0100
`define ALU_MINU 4'b0101

`define ALU_SLL  4'b1000
`define ALU_SRL  4'b1001
`define ALU_SRA  4'b1010
`define ALU_SLLV 4'b1100
`define ALU_SRLV 4'b1101
`define ALU_SRAV 4'b1110

`define ALU_SLT  4'b0111
`define ALU_SLTU 4'b1111

`define ALU_LUI  4'b1011

`endif