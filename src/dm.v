`ifndef DM_V
`define DM_V
`include "constant.vh"
`timescale 1ns / 1ps


module dm(
           input wire clk,
           input wire reset,
           input wire MemWrite,
           input wire [31:0] PC,
           input wire [31:0] addr,
           input wire [31:0] writeData,
           input wire [3:0] byte_select,
           output wire [31:0] readData
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
        case (byte_select)
            4'b0001: begin
                DM_reg[addr[13:2]] <= {DM_reg[addr[13:2]][31:8],writeData[7:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0}, {DM_reg[addr[13:2]][31:8],writeData[7:0]});
            end
            4'b0010: begin
                DM_reg[addr[13:2]] <= {DM_reg[addr[13:2]][31:16],writeData[7:0],DM_reg[addr[13:2]][7:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0},{DM_reg[addr[13:2]][31:16],writeData[7:0],DM_reg[addr[13:2]][7:0]});
            end
            4'b0100: begin
                DM_reg[addr[13:2]] <= {DM_reg[addr[13:2]][31:24],writeData[7:0],DM_reg[addr[13:2]][15:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0},{DM_reg[addr[13:2]][31:24],writeData[7:0],DM_reg[addr[13:2]][15:0]});
            end
            4'b1000: begin
                DM_reg[addr[13:2]] <= {writeData[7:0],DM_reg[addr[13:2]][23:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0},{writeData[7:0],DM_reg[addr[13:2]][23:0]});
            end
            4'b0011: begin
                DM_reg[addr[13:2]] <= {DM_reg[addr[13:2]][31:16],writeData[15:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0}, {DM_reg[addr[13:2]][31:16],writeData[15:0]});
            end
            4'b1100: begin
                DM_reg[addr[13:2]] <= {writeData[15:0],DM_reg[addr[13:2]][15:0]};
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0}, {writeData[15:0],DM_reg[addr[13:2]][15:0]});
            end
            4'b1111: begin
                DM_reg[addr[13:2]] <= writeData;
                if(writeData == writeData)
                    $display("%d@%h: *%h <= %h",$time , PC, {addr[31:2],2'b0},writeData);
            end
            default:
                ;
        endcase
    end
end

assign readData = DM_reg[addr[13:2]];

endmodule
`endif
