`include "src/ifu.v"

`timescale 1ns / 1ps



module ifuTB;

reg clk;
reg reset;
reg isBracnch;
reg [31:0] branchAddr;
reg isJump;
reg [31:0] jumpAddr;
output [31:0] PC;
output [31:0] instructure;

ifu UUT(
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .instructure(instructure)
    );




initial begin
    $dumpfile("ifu_test.vcd");
    $dumpvars(0,ifuTB);
    clk = 0;
    #100;
    reset =1;
    #20;
    reset =0;
    #1000;

    $finish;
end

always #10 begin
    clk=~clk;
end

always #20 begin
    $display("%h,%h",PC,instructure);
end

endmodule
