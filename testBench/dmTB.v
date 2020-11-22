`include "../src/dm.v"

`timescale 1ns / 1ps



module dmTB;

//input
reg clk;
reg reset;
reg MemWrite;
reg [31:0] PC;
reg [31:0] addr;
reg [31:0] writeData;
//output
wire [31:0] readData;

dm UUT(
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .PC(PC),
        .addr(addr),
        .writeData(writeData),
        .readData(readData)
    );




initial begin
    $dumpfile("dm_test.vcd");
    $dumpvars(0,dmTB);
    clk = 0;
    MemWrite =1;
    //start test
    writeData=1;
    addr = 32'h00000000;
    PC=32'hffffffff;
    writeData=1;
    #20;
    PC=32'h00000000;
    addr = 32'h00000004;
    writeData=3;
    #20;
    MemWrite =0;
    PC=32'h12345678;
    addr = 32'h00000000;
    writeData=16;
    #20;
    reset=1;
    #20;
    $finish;
end

always #10 clk=~clk;


endmodule
