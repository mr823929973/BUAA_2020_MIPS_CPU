`timescale 1ns / 1ps

module ext (
           input [15:0] in,
           input zero,
           output [31:0] out
       );
assign out = (zero == 1) ? {16'b0,in} : {{16{in[15]}},in};

endmodule
