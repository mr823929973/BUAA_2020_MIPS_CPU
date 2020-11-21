`include "./src/grf.v"

`timescale 1ns / 1ps



module grfTB;

//input
reg clk;
reg reset;
reg writeEnable;
reg [31:0] PCReg;
reg [4:0] readReg1;
reg [4:0] readReg2;
reg [4:0] writeReg;
reg [31:0] writeData;
//output
wire [31:0] readData1;
wire [31:0] readData2;

grf UUT(
        .clk(clk),
        .reset(reset),
        .writeEnable(writeEnable),
        .PCReg(PCReg),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );




initial begin
    $dumpfile("grf_test.vcd");
    $dumpvars(0,grfTB);
    clk = 0;
    #100;
    //start test
    writeEnable=1;
    readReg1 = 0;
    readReg2 = 10;
    PCReg=32'hffffffff;
    writeData=1;
    #20;
    PCReg=32'h00000000;
    writeReg=0;
    writeData=3;
    #20;
    PCReg=32'h12345678;
    writeReg=10;
    writeData=16;
    #20;
    reset=1;
    #20;
    $finish;
end

always #10 clk=~clk;


endmodule
