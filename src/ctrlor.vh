`ifndef CTRLOR_VH
`define CTRLOR_VH

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
 *  SHOULD SET ALUOP
 */
`define calc_r  \
    RegWrite = 1;\
    RegDst = 1;\
    ALUSrc = 0;\
    Branch = 0;\
    MemWrite = 0;\
    MemtoReg = 0;\
    EXTop = 0;\
    writeR31 = 0;\
    Jump = 0;\
    JumpToReg = 0;\
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0;


/*
 * addi
 * addiu
 * andi
 * ori
 * xori
 * slti
 * sltiu
 * SHOULD SET EXTOP ALUOP
 */
`define calc_i \
    RegWrite = 1; \
    RegDst = 0;  \
    ALUSrc = 1; \
    Branch = 0; \
    MemWrite = 0; \
    MemtoReg = 0; \
    writeR31 = 0; \
    Jump = 0; \
    JumpToReg = 0; \
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0; \
    link = 0 ;

/*
 * sll
 * srl
 * sra
 * SHOULD SET ALUOP
 */
`define calc_s \
    RegWrite = 1; \
    RegDst = 1; \
    ALUSrc = 0; \
    Branch = 0; \
    MemWrite = 0; \
    MemtoReg = 0; \
    EXTop = 0; \
    writeR31 = 0; \
    Jump = 0; \
    JumpToReg = 0; \
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0; \
    link = 0;


/*
 * lw
 * lh
 * lb
 * lhu
 * lbu
 * SHOULD SET LOAD
 */
`define load_dm \
    RegWrite = 1; \
    RegDst = 0; \
    ALUSrc = 1; \
    Branch = 0; \
    MemWrite = 0; \
    MemtoReg = 1; \
    EXTop = 0;\
    ALUop = `ALU_ADD; \
    writeR31 = 0; \
    Jump = 0; \
    JumpToReg = 0;\
    MultAns = 0;\
    save = 2'b0; \
    link = 0;

/*
 * sw
 * sh
 * sb
 * SHOULD SET SAVE
 */
`define save_dm \
    RegWrite = 0; \
    RegDst = 0; \
    ALUSrc = 1;\
    Branch = 0; \
    MemWrite = 1; \
    MemtoReg = 0; \
    EXTop = 0; \
    ALUop = `ALU_ADD; \
    writeR31 = 0; \
    Jump = 0; \
    JumpToReg = 0; \
    MultAns = 0;\
    load = 3'b0; \
    link = 0;

/*
 * beq  
 * bne   
 * blez
 * bgtz
 * bltz
 * bgez
 */
`define branch \
    RegWrite = 0; \
    RegDst = 0; \
    ALUSrc = 0; \
    Branch = 1; \
    MemWrite = 0; \
    MemtoReg = 0; \
    EXTop = 0; \
    ALUop =`ALU_AND; \
    writeR31 = 0; \
    Jump = 0; \
    JumpToReg = 0; \
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0; \
    link = 0;


/*
 * mult
 * multu  
 * div
 * divu
 */
`define calc_mult \
    RegWrite = 0;\
    RegDst = 0;\
    ALUSrc = 0;\
    Branch = 0;\
    MemWrite = 0;\
    MemtoReg = 0;\
    EXTop = 0;\
    writeR31 = 0;\
    Jump = 0;\
    JumpToReg = 0;\
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0; \
    ALUop =`ALU_AND; 

/*
 * mfhi
 * mflo
 */
`define mf \
    RegWrite = 1;\
    RegDst = 1;\
    ALUSrc = 0;\
    Branch = 0;\
    MemWrite = 0;\
    MemtoReg = 0;\
    EXTop = 0;\
    writeR31 = 0;\
    Jump = 0;\
    JumpToReg = 0;\
    MultAns = 1;\
    load = 3'b0; \
    save = 2'b0; \
    ALUop =`ALU_AND; 

/*
 * mthi
 * mtlo
 */
`define mt \
    RegWrite = 0;\
    RegDst = 0;\
    ALUSrc = 0;\
    Branch = 0;\
    MemWrite = 0;\
    MemtoReg = 0;\
    EXTop = 0;\
    writeR31 = 0;\
    Jump = 0;\
    JumpToReg = 0;\
    MultAns = 0;\
    load = 3'b0; \
    save = 2'b0; \
    ALUop =`ALU_AND; 

`endif
