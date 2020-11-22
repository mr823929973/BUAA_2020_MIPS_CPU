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

reg [31:0] DM_reg[0:1023];
integer i;

initial begin
    for(i=0;i<1024;i=i+1) begin
        DM_reg[i] <= 0;
    end
end

always @(posedge clk) begin
    if(reset) begin
        for(i=0;i<1024;i=i+1) begin
            DM_reg[i] <= 0;
        end
    end
    else if(MemWrite) begin
        DM_reg[addr[11:2]] <= writeData;   
        $display("@%h: *%h <= %h", PC, addr, writeData);
    end
end

assign readData = DM_reg[addr[11:2]];

endmodule
