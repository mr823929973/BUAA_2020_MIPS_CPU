# P6

### verilog流水线CPU(二)

CPU代码在./src/目录下,TestBench代码在./testBench/目录下

其中，CPU顶层模块文件名为mips.v

支持以下指令：

+ `define nop  6'd0

  

  `define lb  6'd1

  `define lbu  6'd2

  `define lh  6'd3

  `define lhu  6'd4

  `define lw  6'd5

  

  `define sb  6'd6

  `define sh  6'd7

  `define sw  6'd8

  

  `define add  6'd9

  `define addu 6'd10

  `define sub  6'd11

  `define subu 6'd12

  

  `define mult 6'd13

  `define multu 6'd14

  `define div  6'd15

  `define divu 6'd16

  

  `define sll  6'd0 //17

  `define srl  6'd18

  `define sra  6'd19

  `define sllv 6'd20

  `define srlv 6'd21

  `define srav 6'd22

  

  `define _and 6'd23

  `define _or  6'd24

  `define _xor 6'd25

  `define _nor 6'd26

  

  `define addi 6'd27

  `define addiu 6'd28

  `define andi 6'd29

  `define ori  6'd30

  `define xori 6'd31

  

  `define lui  6'd32

  

  `define slt  6'd33

  `define slti 6'd34

  `define sltiu 6'd35

  `define sltu 6'd36

  

  `define beq  6'd37

  `define bne  6'd38

  `define blez 6'd39

  `define bgtz 6'd40

  `define bltz 6'd41

  `define bgez 6'd42

  

  `define j   6'd43

  `define jal  6'd44

  `define jalr 6'd45

  `define jr  6'd46

  

  `define mfhi 6'd47

  `define mflo 6'd48

  `define mthi 6'd49

  `define mtlo 6'd50