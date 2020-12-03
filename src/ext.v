`timescale 1ns / 1ps

module ext (
           input wire [15:0] in,
           input wire zero,
           output wire [31:0] out
       );
assign out = (zero == 1) ? {16'b0,in} : {{16{in[15]}},in};

endmodule
