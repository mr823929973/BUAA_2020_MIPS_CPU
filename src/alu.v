`timescale 1ns / 1ps

module alu(
           input wire [31:0] srcA,
           input wire [31:0] srcB,
           input wire [2:0] ALUop,
           input wire [4:0] s,
           output wire zero,
           output wire [31:0] ALUout
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
            ALUResult = srcB << s;
        3'b100:
            ALUResult = srcA & (~srcB);
        3'b101:
            ALUResult = srcA | (~srcB);
        3'b110:
            ALUResult = srcA - srcB;
        3'b111:
            ALUResult = srcB << 16;
        default:
            ;
    endcase
end


endmodule