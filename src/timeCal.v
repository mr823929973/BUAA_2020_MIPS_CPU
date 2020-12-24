`include "instr.vh"
`include "timeCal.vh"
`timescale 1ns / 1ps

module timeCal (
           input wire [31:0] instructure_in,
           input wire [5:0] instr_code,

           output reg [4:0] r_new,
           output reg [4:0] r_use1,
           output reg [4:0] r_use2,
           output reg [1:0] t_new,
           output reg [1:0] t_use1,
           output reg [1:0] t_use2
       );

wire [4:0] rs,rt,rd;
assign rs = instructure_in[25:21];
assign rt = instructure_in[20:16];
assign rd = instructure_in[15:11];

always @(*) begin
    case (instr_code)

        /*calc_r*/
        `add,`addu,`sub,`subu,
        `_and,`_or,`_xor,`_nor,
        `slt,`sltu,`sllv,`srlv,
        `srav: begin
            `calc_r
        end

        /*calc_i*/
        `addi,`addiu,`andi,`ori,
        `xori,`slti,`sltiu: begin
            `calc_i
        end

        /*calc_s*/
        `sll,`srl,`sra: begin
            `calc_s
        end

        /*load_dm*/
        `lw,`lh,`lb,
        `lhu,`lbu: begin
            `load_dm
        end

        /*save_dm*/
        `sw,`sh,`sb: begin
            `save_dm
        end

        `beq,`bne,`blez,
        `bgtz,`bltz,`bgez: begin
            `branch
        end

        /*others*/
        `lui: begin
            r_new = rt;
            r_use1 = 0;
            r_use2 = 0;
            t_new = 2;
            t_use1 = 0;
            t_use2 = 0;
        end
        `j: begin
            r_new = 0;
            r_use1 = 0;
            r_use2 = 0;
            t_new = 0;
            t_use1 = 0;
            t_use2 = 0;
        end
        `jal: begin
            r_new = 5'd31;
            r_use1 = 0;
            r_use2 = 0;
            t_new = 2;
            t_use1 = 0;
            t_use2 = 0;
        end
        `jr: begin
            r_new = 0;
            r_use1 = rs;
            r_use2 = 0;
            t_new = 0;
            t_use1 = 0;
            t_use2 = 0;
        end
        `jalr: begin
            r_new = rd;
            r_use1 = rs;
            r_use2 = 0;
            t_new = 2;
            t_use1 = 0;
            t_use2 = 0;
        end
        default: begin
            r_new = 0;
            r_use1 = 0;
            r_use2 = 0;
            t_new = 0;
            t_use1 = 0;
            t_use2 = 0;
        end
    endcase
end

endmodule
