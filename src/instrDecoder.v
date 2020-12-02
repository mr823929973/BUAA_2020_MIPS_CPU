`include "instr.vh"

`timescale 1ns / 1ps

module instrDecoder (
           input [31:0] instructure_in,
           output [5:0] instrCode_out
       );

reg [5:0] instr_reg;
wire [5:0] opCode,Funct;

assign instrCode_out = instr_reg;
assign opCode = instructure_in[31:26];
assign Funct = instructure_in[5:0];

always @(*) begin
    case (opCode)
        6'b000000:
        case (Funct)
            6'b100001:
                instr_reg = `addu;
            6'b100011:
                instr_reg = `subu;
            6'b001000:
                instr_reg = `jr;
            6'b000000:
                instr_reg = `sll;
            default:
                ;
        endcase
        6'b001101:
            instr_reg = `ori;
        6'b100011:
            instr_reg = `lw;
        6'b101011:
            instr_reg = `sw;
        6'b000100:
            instr_reg = `beq;
        6'b001111:
            instr_reg = `lui;
        6'b000011:
            instr_reg = `jal;
        default:
            ;
    endcase
end

endmodule
