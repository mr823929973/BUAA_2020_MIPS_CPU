`ifndef CTRLOR_V
`define CTRLOR_V
`include "instr.vh"
`include "aluctrl.vh"
`include "ctrlor.vh"
`timescale 1ns / 1ps

module ctrlor (
           input wire [5:0] instr,
           output reg RegWrite,
           output reg RegDst,
           output reg ALUSrc,
           output reg Branch,
           output reg MemWrite,
           output reg MemtoReg,
           output reg EXTop,
           output reg MultAns,
           output reg [2:0]load,
           output reg [1:0]save,
           output reg writeR31,
           output reg Jump,
           output reg JumpToReg,
           output reg link,
           output reg [3:0] ALUop
       );




always @(*) begin
    case (instr)
        /*Type: calc_r*/
        `add: begin
            `calc_r
            ALUop = `ALU_ADD;
        end
        `addu: begin
            `calc_r
            ALUop = `ALU_ADD;
        end
        `sub: begin
            `calc_r
            ALUop = `ALU_MINU;
        end
        `subu: begin
            `calc_r
            ALUop = `ALU_MINU;
        end
        `_and: begin
            `calc_r
            ALUop = `ALU_AND;
        end
        `_or: begin
            `calc_r
            ALUop = `ALU_OR;
        end
        `_xor: begin
            `calc_r
            ALUop = `ALU_XOR;
        end
        `_nor: begin
            `calc_r
            ALUop = `ALU_NOR;
        end
        `slt: begin
            `calc_r
            ALUop = `ALU_SLT;
        end
        `sltu: begin
            `calc_r
            ALUop = `ALU_SLTU;
        end
        `sllv: begin
            `calc_r
            ALUop = `ALU_SLLV;
        end
        `srlv: begin
            `calc_r
            ALUop = `ALU_SRLV;
        end
        `srav: begin
            `calc_r
            ALUop = `ALU_SRAV;
        end

        /*Type: calc_i*/
        `addi: begin
            `calc_i
            ALUop = `ALU_ADD;
            EXTop = 0;
        end
        `addiu: begin
            `calc_i
            ALUop = `ALU_ADD;
            EXTop = 0;
        end
        `andi: begin
            `calc_i
            ALUop = `ALU_AND;
            EXTop = 1;
        end
        `ori: begin
            `calc_i
            ALUop = `ALU_OR;
            EXTop = 1;
        end
        `xori: begin
            `calc_i
            ALUop = `ALU_XOR;
            EXTop = 1;
        end
        `slti: begin
            `calc_i
            ALUop = `ALU_SLT;
            EXTop = 0;
        end
        `sltiu: begin
            `calc_i
            ALUop = `ALU_SLTU;
            EXTop = 0;
        end

        /*Type: calc_s*/
        `sll: begin
            `calc_s
            ALUop = `ALU_SLL;
        end
        `srl: begin
            `calc_s
            ALUop = `ALU_SRL;
        end
        `sra: begin
            `calc_s
            ALUop = `ALU_SRA;
        end

        /*Type: load_dm*/
        `lw: begin
            `load_dm
            load = 3'b011;
        end
        `lh: begin
            `load_dm
            load = 3'b010;
        end
        `lb: begin
            `load_dm
            load = 3'b001;
        end
        `lhu: begin
            `load_dm
            load = 3'b110;
        end
        `lbu: begin
            `load_dm
            load = 3'b101;
        end

        /*Type: save_dm*/
        `sw: begin
            `save_dm
            save = 2'b11;
        end
        `sh: begin
            `save_dm
            save = 2'b10;
        end
        `sb: begin
            `save_dm
            save = 2'b01;
        end

        /*Type: branch*/
        `beq,`bne,`blez,`bgtz,`bltz,`bgez: begin
            `branch
        end

        /*Type: calc_mult*/
        `mult,`multu,`div,`divu: begin
            `calc_mult
        end

        /*Type: mf*/
        `mflo,`mfhi: begin
            `mf
        end

        /*Type: mt*/
        `mtlo,`mthi: begin
            `mt
        end

        /*Type: others*/
        `lui: begin
            RegWrite = 1;
            RegDst = 0;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = `ALU_LUI;
            writeR31 = 0;
            Jump = 0;
            JumpToReg = 0;
            MultAns = 0;
            load = 3'b0;
            save = 2'b0;
            link = 0;
        end
        `j: begin
            RegWrite = 0;
            RegDst = 0;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = `ALU_AND;
            writeR31 = 0;
            Jump = 1;
            JumpToReg = 0;
            MultAns = 0;
            load = 3'b0;
            save = 2'b0;
            link = 0;
        end
        `jal: begin
            RegWrite = 1;
            RegDst = 0;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = `ALU_AND;
            writeR31 = 1;
            Jump = 1;
            JumpToReg = 0;
            MultAns = 0;
            load = 3'b0;
            save = 2'b0;
            link = 1;
        end
        `jr: begin
            RegWrite = 0;
            RegDst = 0;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = `ALU_AND;
            writeR31 = 0;
            Jump = 0;
            JumpToReg = 1;
            MultAns = 0;
            load = 3'b0;
            save = 2'b0;
            link = 0;
        end
        `jalr: begin
            RegWrite = 1;
            RegDst = 1;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemtoReg = 0;
            EXTop = 0;
            ALUop = `ALU_AND;
            writeR31 = 0;
            Jump = 0;
            JumpToReg = 1;
            MultAns = 0;
            load = 3'b0;
            save = 2'b0;
            link = 1;
        end
        default:
            ;
    endcase
end

endmodule
`endif
