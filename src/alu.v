`timescale 1ns / 1ps

module alu(
           input [31:0] srcA,
           input [31:0] srcB,
           input [2:0] ALUop,
           output zero,
           output [31:0] ALUout
       );

reg [31:0] ALUResult;
assign zero = (ALUResult == 32'b0)? 1'b1 : 1'b0;
assign ALUout = ALUResult;

always @(*) begin
    case (ALUop)
        3'b000:
            ALUResult = srcA & srcB;
        3'b001:
            ALUResult = srcA | srcB;
        3'b010:
            ALUResult = srcA + srcB;
        3'b011:
            ;
        3'b100:
            ALUResult = srcA & (~srcB);
        3'b101:
            ALUResult = srcA | (~srcB);
        3'b110:
            ALUResult = srcA - (~srcB);
        3'b111:
            ;
        default:
            ;
    endcase
end


endmodule
