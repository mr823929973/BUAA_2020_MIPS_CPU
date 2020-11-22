`include "../src/mips.v"

`timescale 1ns / 1ps



module mipsTB;

//input
reg clk;
reg reset;
//output

mips UUT(
        .clk(clk),
        .reset(reset)
    );




initial begin
    $dumpfile("mips_test.vcd");
    $dumpvars(0,mipsTB);
    clk = 0;
    #200
    $finish;
end

always #10 clk=~clk;


endmodule
