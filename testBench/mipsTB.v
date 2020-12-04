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
        .reset(reset),

        .pc_test(pc)
    );




initial begin
    $dumpfile("mips_test.vcd");
    $dumpvars(0,mipsTB);
    clk = 0;
    reset = 1;
    #20

    reset = 0;
    while(pc < 32'h0000_4000) #20;
    $finish;
end

always #10 clk=~clk;


endmodule
