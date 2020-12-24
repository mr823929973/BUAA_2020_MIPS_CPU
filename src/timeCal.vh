`ifndef TIMECAL_VH
`define TIMECAL_VH

/*
 * add
 * addu
 * sub
 * subu
 * _and
 * _or
 * _xor
 * _nor
 * slt
 * sltu
 * sllv
 * srlv
 * srav
 * 
 */
`define calc_r  \
    r_new = rd; \
    r_use1 = rs; \
    r_use2 = rt; \
    t_new = 2;  \
    t_use1 = 1;  \
    t_use2 = 1;  


/*
 * addi
 * addiu
 * andi
 * ori
 * xori
 * slti
 * sltiu
 *
 */
`define calc_i \
    r_new = rt; \
    r_use1 = rs; \
    r_use2 = 0; \
    t_new = 2; \
    t_use1 = 1; \
    t_use2 = 0; 

/*
 * sll
 * srl
 * sra
 * 
 */
`define calc_s \
    r_new = rd; \
    r_use1 = 0; \
    r_use2 = rt; \
    t_new = 2; \
    t_use1 = 1; \
    t_use2 = 1;

/*
 * lw
 * lh
 * lb
 * lhu
 * lbu
 * 
 */
`define load_dm \
    r_new = rt; \
    r_use1 = rs; \
    r_use2 = 0; \
    t_new = 3; \
    t_use1 = 1; \
    t_use2 = 0;

/*
 * sw
 * sh
 * sb
 * SHOULD SET SAVE
 */
`define save_dm \
    r_new = 0; \
    r_use1 = rs; \
    r_use2 = rt; \
    t_new = 0; \
    t_use1 = 1; \
    t_use2 = 2;

/*
 * beq  
 * bne   
 * blez
 * bgtz
 * bltz
 * bgez
 */
`define branch \
    r_new = 0; \
    r_use1 = rs; \
    r_use2 = rt; \
    t_new = 0; \
    t_use1 = 0; \
    t_use2 = 0; \

`define calc_mult \
    r_new = 0; \
    r_use1 = rs; \
    r_use2 = rt; \
    t_new = 0; \
    t_use1 = 2; \
    t_use2 = 2; \

`define mf \
    r_new = rd; \
    r_use1 = 0; \
    r_use2 = 0; \
    t_new = 2; \
    t_use1 = 0; \
    t_use2 = 0; \

`define mt \
    r_new = 0; \
    r_use1 = rs; \
    r_use2 = 0; \
    t_new = 0; \
    t_use1 = 2; \
    t_use2 = 0; \


`endif
