`ifndef DM_V
`define DM_V
`include "constant.vh"
`timescale 1ns / 1ps


module dm(
           input clk,
           input reset,
           input MemWrite,
           input [31:0] PC,
           input [31:0] addr,
           input [31:0] writeData,
           output [31:0] readData
       );

reg [31:0] DM_reg[0:`RAM_MAX];
integer i;

initial begin
    for(i=0;i<`RAM_MAX+1;i=i+1) begin
        DM_reg[i] <= 0;
    end
end

always @(posedge clk) begin
    if(reset) begin
        for(i=0;i<`RAM_MAX+1;i=i+1) begin
            DM_reg[i] <= 0;
        end
    end
    else if(MemWrite) begin
        DM_reg[addr[13:2]] <= writeData;   
        if(writeData !== 32'hxxxx_xxxx)
        $display("%d@%h: *%h <= %h",$time , PC, addr, writeData);
    end
end

assign readData = DM_reg[addr[11:2]];

endmodule
`endif