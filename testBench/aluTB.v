`include "src/alu.v"

`timescale 1ns / 1ps



module aluTB;
//input
reg [31:0] srcA;
reg [31:0] srcB;
reg [2:0] ALUop;
reg [4:0] s;
//output
wire zero;
wire [31:0] ALUout;

alu UUT(
    .srcA(srcA),
    .srcB(srcB),
    .ALUop(ALUop),
    .s(s),
    .zero(zero),
    .ALUout(ALUout)
);

initial begin
    $dumpfile("alu_test.vcd");
    $dumpvars(0,aluTB);
    #10;
    srcA = 200;
    srcB = 200;
    s=5'd3;
    ALUop=3'b110;
    #10;
    $display("%d %d",zero,ALUout);
    $finish;
end



endmodule
