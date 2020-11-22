`include "instr.vh"
`timescale 1ns / 1ps

module instrDecoder (
           input [5:0] opCode,
           input [5:0] Funct,
           output [3:0] instr
       );

reg [3:0] instr_reg;
assign instr = instr_reg;

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
