`timescale 1ns / 1ps
`include "aluctrl.vh"

module alu(
           input wire [31:0] srcA,
           input wire [31:0] srcB,
           input wire [3:0] ALUop,
           input wire [4:0] s,
           output wire zero,
           output wire [31:0] ALUout
       );

reg [31:0] ALUResult;
assign zero = (ALUResult == 32'b0)? 1'b1 : 1'b0;
assign ALUout = ALUResult;

always @(*) begin
    case (ALUop)
        `ALU_AND:
            ALUResult = srcA & srcB;
        `ALU_OR:
            ALUResult = srcA | srcB;
        `ALU_XOR:
            ALUResult = srcA ^ srcB;
        `ALU_NOR:
            ALUResult = ~(srcA | srcB);
        `ALU_ADD:
            ALUResult = srcA + srcB;
        `ALU_MINU:
            ALUResult = srcA - srcB;
        `ALU_SLL:
            ALUResult = srcB << s;
        `ALU_SRL:
            ALUResult = srcB >> s;
        `ALU_SRA:
            ALUResult = $signed($signed(srcB) >>> s);
        `ALU_SLLV:
            ALUResult = srcB << srcA[4:0];
        `ALU_SRLV:
            ALUResult = srcB >> srcA[4:0];
        `ALU_SRAV:
            ALUResult = $signed($signed(srcB) >>> srcA[4:0]);
        `ALU_LUI:
            ALUResult = srcB << 16;
        `ALU_SLT:
            ALUResult = ($signed(srcA) < $signed(srcB)) ? 32'b1 : 32'b0; 
        `ALU_SLTU:
            ALUResult = srcA < srcB ? 32'b1 : 32'b0;
        default:
            ;
    endcase
end


endmodule
