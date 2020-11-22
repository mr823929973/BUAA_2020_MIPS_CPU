`timescale 1ns / 1ps

module ifu(
           input clk,
           input reset,
           input isBranch,
           input [31:0] branchAddr,
           input isJump,
           input [25:0] jumpAddr,
           input isJumpReg,
           input [31:0] jumpRegAddr,
           output [31:0] PC,
           output [31:0] instructure
       );

reg [31:0] PC_Reg;
reg [31:0] IM_reg[0:1023];


initial begin
    $readmemh("code.txt",IM_reg);
    PC_Reg <= 32'h00003000;
end

always @(posedge clk) begin
    if(reset) begin
        PC_Reg <= 32'h00003000;
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
