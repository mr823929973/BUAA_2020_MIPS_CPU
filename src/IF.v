`include "constant.vh"

`timescale 1ns / 1ps

module IF(
           input wire clk,
           input wire reset,
           input wire stall,
           input wire isBranch,
           input wire [31:0] branchAddr,
           input wire isJump,
           input wire [25:0] jumpAddr,
           input wire isJumpReg,
           input wire [31:0] jumpRegAddr,
           output wire [31:0] PC,
           output wire [31:0] instructure
       );

reg [31:0] PC_Reg;
reg [31:0] IM_reg[0:`ROM_MAX];


initial begin
    $readmemh("code.txt",IM_reg);
    PC_Reg <= `PC_START;
end

always @(posedge clk) begin
    if(reset) begin
        PC_Reg <= `PC_START;
    end
    else if(stall) begin
        PC_Reg <= PC_Reg;
    end
    else if(isBranch) begin
        PC_Reg <= PC_Reg + 4 + $signed($signed(branchAddr)<<$signed(2));
    end
    else if(isJump) begin
        PC_Reg <= {PC_Reg[31:28],jumpAddr,2'b0};
    end
    else if(isJumpReg) begin
        PC_Reg <= jumpRegAddr;
    end
    else begin
        PC_Reg <= PC_Reg + 4;
    end
end

assign PC = PC_Reg;
assign instructure = IM_reg[PC_Reg[11:2]];

endmodule