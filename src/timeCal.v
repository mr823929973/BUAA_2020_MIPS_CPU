`include "instr.vh"
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
        `addu: begin
            r_new = rd;
            r_use1 = rs;
            r_use2 = rt;
            t_new = 2;
            t_use1 = 1;
            t_use2 = 1;
        end
        `subu: begin
            r_new = rd;
            r_use1 = rs;
            r_use2 = rt;
            t_new = 2;
            t_use1 = 1;
            t_use2 = 1;
        end
        `ori: begin
            r_new = rt;
            r_use1 = rs;
            r_use2 = 0;
            t_new = 2;
            t_use1 = 1;
            t_use2 = 0;
        end
        `lw: begin
            r_new = rt;
            r_use1 = rs;
            r_use2 = 0;
            t_new = 3;
            t_use1 = 1;
            t_use2 = 0;
        end
        `sw: begin
            r_new = 0;
            r_use1 = rs;
            r_use2 = rt;
            t_new = 0;
            t_use1 = 1;
            t_use2 = 2;
        end
        `beq: begin
            r_new = 0;
            r_use1 = rs;
            r_use2 = rt;
            t_new = 0;
            t_use1 = 0;
            t_use2 = 0;
        end
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
        `sll: begin
            r_new = rd;
            r_use1 = 0;
            r_use2 = rt;
            t_new = 2;
            t_use1 = 1;
            t_use2 = 1;
        end
        `andi: begin
            r_new = rt;
            r_use1 = rs;
            r_use2 = 0;
            t_new = 2;
            t_use1 = 1;
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
