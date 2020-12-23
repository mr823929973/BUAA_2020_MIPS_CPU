`include "../src/mips.v"

`timescale 1ns / 1ps



module mipsTB;

//input
reg clk;
reg reset;

wire [31:0] pc;
//output

mips UUT(
        .clk(clk),
        .reset(reset)
    );




initial begin
    $dumpfile("mips_test.vcd");
    $dumpvars(0,mipsTB);
    clk = 0;
    reset = 1;
    #20
    reset = 0;
    while(UUT.WB_pc < 32'h0000_7000) #20;
    $finish;
end

always #10 clk=~clk;


endmodule
