`timescale 1ns / 1ps

module grf(
           input clk,
           input reset,
           input writeEnable,
           input [31:0] PCReg,
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
        if(writeEnable) begin
            $display("%d@%h: $%d <= %h", $time, PCReg, writeReg, writeData);
            if(writeReg != 5'b0) begin
                register[writeReg] <= writeData;
            end
        end
    end
end

assign readData1 = (readReg1 == 0) ? 32'b0 :register[readReg1];
assign readData2 = (readReg2 == 0) ? 32'b0 :register[readReg2];


endmodule
