`timescale 1ns / 1ps

module grf(
           input clk,
           input reset,
           inout writeEnable,
           input [4:0] readReg1,
           input [4:0] readReg2,
           input [4:0] writeReg,
           input [31:0] writeData,
           output [31:0] readData1,
           output [31:0] readData2
       );

reg [31:0] register [31:0];
integer i;

initial begin
    for(i=0;i<32;i=i+1) begin
        register[i] <= 0;
    end
end

always @(posedge clk) begin
    if(reset) begin
        for(i=0;i<32;i=i+1) begin
            register[i] <= 0;
        end
    end
    else begin
        
    end
end


endmodule
