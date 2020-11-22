`timescale 1ns / 1ps

module mux_5b (
           input [4:0] in0,
           input [4:0] in1,
           input sel,
           output [4:0] out
       );

assign out = (sel == 0) ? in0 : in1;

endmodule

module mux_32b (
           input [31:0] in0,
           input [31:0] in1,
           input sel,
           output [31:0] out
       );

assign out = (sel == 0) ? in0 : in1;

endmodule
