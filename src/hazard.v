`include "timeCal.v"
`timescale 1ns / 1ps

module hazard (
           input wire [31:0] IF_ID_instructure_in,
           input wire [5:0] IF_ID_instr_code,
           input wire [31:0] ID_EX_instructure_in,
           input wire [5:0] ID_EX_instr_code,
           input wire [31:0] EX_MEM_instructure_in,
           input wire [5:0] EX_MEM_instr_code,
           input wire [31:0] MEM_WB_instructure_in,
           input wire [5:0] MEM_WB_instr_code,

           output wire stall,
           output wire forward_rs_ID,
           output wire forward_rt_ID,
           output wire [1:0]forward_rs_EX,
           output wire [1:0]forward_rt_EX,
           output wire forward_rt_MEM
       );

wire [4:0] ID_r_new,ID_r_use1,ID_r_use2;
wire [1:0] ID_t_new,ID_t_use1,ID_t_use2;

timeCal R_T_ID(
            //in
            .instructure_in(IF_ID_instructure_in),
            .instr_code(IF_ID_instr_code),
            //out
            .r_new(ID_r_new),
            .r_use1(ID_r_use1),
            .r_use2(ID_r_use2),
            .t_new(ID_t_new),
            .t_use1(ID_t_use1),
            .t_use2(ID_t_use2)
        );

wire [4:0] EX_r_new,EX_r_use1,EX_r_use2;
wire [1:0] EX_t_new_out,EX_t_new;

timeCal R_T_EX(
            //in
            .instructure_in(ID_EX_instructure_in),
            .instr_code(ID_EX_instr_code),
            //out
            .r_new(EX_r_new),
            .r_use1(EX_r_use1),
            .r_use2(EX_r_use2),
            .t_new(EX_t_new_out),
            .t_use1(),
            .t_use2()
        );

assign EX_t_new =(EX_t_new_out > 1) ? EX_t_new_out -1 :0;

wire [4:0] MEM_r_new,MEM_r_use1,MEM_r_use2;
wire [1:0] MEM_t_new_out,MEM_t_new;

timeCal R_T_MEM(
            //in
            .instructure_in(EX_MEM_instructure_in),
            .instr_code(EX_MEM_instr_code),
            //out
            .r_new(MEM_r_new),
            .r_use1(MEM_r_use1),
            .r_use2(MEM_r_use2),
            .t_new(MEM_t_new_out),
            .t_use1(),
            .t_use2()
        );
assign MEM_t_new =(MEM_t_new_out > 2) ? MEM_t_new_out -2 :0;

wire [4:0] WB_r_new,WB_r_use1,WB_r_use2;
wire [1:0] WB_t_new;
assign WB_t_new = 0;
timeCal R_T_WB(
            //in
            .instructure_in(MEM_WB_instructure_in),
            .instr_code(MEM_WB_instr_code),
            //out
            .r_new(WB_r_new),
            .r_use1(WB_r_use1),
            .r_use2(WB_r_use2),
            .t_new(),
            .t_use1(),
            .t_use2()
        );

//MEM TO ID

assign forward_rs_ID = (MEM_t_new == 0 && ID_r_use1 != 0 && MEM_r_new == ID_r_use1) ? 1 : 0;
assign forward_rt_ID = (MEM_t_new == 0 && ID_r_use2 != 0 && MEM_r_new == ID_r_use2) ? 1 : 0;

//MEM and WB TO EX
assign forward_rs_EX = (MEM_t_new == 0 && EX_r_use1 != 0 && MEM_r_new == EX_r_use1) ? 1:
                        (WB_t_new == 0 && EX_r_use1 != 0 && WB_r_new == EX_r_use1)? 2 : 0;

assign forward_rt_EX = (MEM_t_new == 0 && EX_r_use2 != 0 && MEM_r_new == EX_r_use2) ? 1:
                        (WB_t_new == 0 && EX_r_use2 != 0 && WB_r_new == EX_r_use2)? 2 : 0;

//WB TO MEM
assign forward_rt_MEM = (WB_t_new == 0 && MEM_r_use2 != 0 && WB_r_new == MEM_r_use2) ? 1 : 0;

//STALL
assign stall = ((EX_t_new > ID_t_use1 && ID_r_use1 != 0 && EX_r_new == ID_r_use1) ||
                (EX_t_new > ID_t_use2 && ID_r_use2 != 0 && EX_r_new == ID_r_use2) ||
                (MEM_t_new > ID_t_use1 && ID_r_use1 != 0 && MEM_r_new == ID_r_use1) ||
                (MEM_t_new > ID_t_use2 && ID_r_use2 != 0 && MEM_r_new == ID_r_use2))? 1 : 0 ;

endmodule
