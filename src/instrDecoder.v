`ifndef INSTRDECODER_V
`define INSTRDECODER_V

`include "instr.vh"

`timescale 1ns / 1ps

module instrDecoder (
           input wire [31:0] instructure_in,
           output wire [5:0] instrCode_out
       );

reg [5:0] instr_reg;
wire [5:0] opCode,Funct;
wire [4:0] bCode;

assign instrCode_out = instr_reg;
assign opCode = instructure_in[31:26];
assign Funct = instructure_in[5:0];
assign bCode = instructure_in[20:16];

always @(*) begin
    case (opCode)
        6'b000000:
        case (Funct)
            6'b100000:
                instr_reg = `add;
            6'b100001:
                instr_reg = `addu;
            6'b100010:
                instr_reg = `sub;
            6'b100011:
                instr_reg = `subu;
            6'b011000:
                instr_reg = `mult;
            6'b011001:
                instr_reg = `multu;
            6'b011010:
                instr_reg = `div;
            6'b011011:
                instr_reg = `divu;

            6'b000000:
                instr_reg = `sll;
            6'b000010:
                instr_reg = `srl;
            6'b000011:
                instr_reg = `sra;
            6'b000100:
                instr_reg = `sllv;
            6'b000110:
                instr_reg = `srlv;
            6'b000111:
                instr_reg = `srav;

            6'b100100:
                instr_reg = `_and;
            6'b100101:
                instr_reg = `_or;
            6'b100110:
                instr_reg = `_xor;
            6'b100111:
                instr_reg = `_nor;

            6'b101010:
                instr_reg = `slt;
            6'b101011:
                instr_reg = `sltu;
            
            6'b001001:
                instr_reg = `jalr;
            6'b001000:
                instr_reg = `jr;

            6'b010000:
                instr_reg = `mfhi;
            6'b010010:
                instr_reg = `mflo;
            6'b010001:
                instr_reg = `mthi;
            6'b010011:
                instr_reg = `mtlo;
            default:
                ;
        endcase
        6'b100000:
            instr_reg = `lb;
        6'b100100:
            instr_reg = `lbu;
        6'b100001:
            instr_reg = `lh;
        6'b100101:
            instr_reg = `lhu;
        6'b100011:
            instr_reg = `lw;
        6'b101000:
            instr_reg = `sb;
        6'b101001:
            instr_reg = `sh;
        6'b101011:
            instr_reg = `sw;

        6'b001000:
            instr_reg = `addi;
        6'b001001:
            instr_reg = `addiu;
        6'b001100:
            instr_reg = `andi;
        6'b001101:
            instr_reg = `ori;
        6'b001110:
            instr_reg = `xori;

        6'b001111:
            instr_reg = `lui;

        6'b001010:
            instr_reg = `slti;
        6'b001011:
            instr_reg = `sltiu;

        6'b000100:
            instr_reg = `beq;
        6'b000101:
            instr_reg = `bne;
        6'b000110:
            instr_reg = `blez;
        6'b000111:
            instr_reg = `bgtz;
        6'b000001:
        case (bCode)
            5'b00000:
                instr_reg = `bltz;
            5'b00001:
                instr_reg = `bgez;
            default:
                ;
        endcase

        6'b000010:
            instr_reg = `j;
        6'b000011:
            instr_reg = `jal;
        default:
            ;
    endcase
end

endmodule

`endif
