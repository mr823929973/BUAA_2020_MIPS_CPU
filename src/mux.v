`ifndef MUX_V
`define MUX_V

`timescale 1ns / 1ps

module mux_5b (
           input wire [4:0] in0,
           input wire [4:0] in1,
           input wire sel,
           output wire [4:0] out
       );

assign out = (sel == 0) ? in0 : in1;

endmodule

module mux_32b (
           input wire [31:0] in0,
           input wire [31:0] in1,
           input wire sel,
           output wire [31:0] out
       );

assign out = (sel == 0) ? in0 : in1;

endmodule

module mux_32b_4 (
           input wire [31:0] in0,
           input wire [31:0] in1,
           input wire [31:0] in2,
           input wire [31:0] in3,
           input wire [1:0] sel,
           output wire [31:0] out
       );

assign out = (sel == 0) ? in0 : 
                (sel == 1)? in1 :
                (sel == 2)? in2 :
                in3;

endmodule

`endif