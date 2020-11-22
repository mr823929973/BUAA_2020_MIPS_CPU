`include "instr.vh"
`timescale 1ns / 1ps

module ctrlor (
           input [3:0] instr,
           output reg RegWrite,
           output reg RegDst,
           output reg ALUSrc,
           output reg Branch,
           output reg MemWrite,
           output reg MemtoReg,
           output reg EXTop,
           output reg [2:0] ALUop
       );


always @(*) begin
    case (instr)
        `addu: begin
            RegWrite = 1;
            RegDst = 1;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b010;
        end
        `subu: begin
            RegWrite = 1;
            RegDst = 1;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b110;
        end
        `ori: begin
            RegWrite = 1;
            RegDst = 0;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 1;
            ALUop = 3'b001;
        end
        `lw: begin
            RegWrite = 1;
            RegDst = 0;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 1;
            EXTop = 0;
            ALUop = 3'b010;
        end
        `sw: begin
            RegWrite = 0;
            RegDst = 0;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 1;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b010;
        end
        `beq: begin
            RegWrite = 0;
            RegDst = 0;
            ALUSrc = 0;
            Branch = 1;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b110;
        end
        `lui: begin
            RegWrite = 1;
            RegDst = 0;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b111;
        end
        `jal: begin

        end
        `jr: begin

        end
        `sll: begin
            RegWrite = 1;
            RegDst = 1;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = 3'b011;
        end
        default:
            ;
    endcase
end

endmodule
