`ifndef BYTE_V
`define BYTE_V

`timescale 1ns / 1ps

module byte_selector (
           input wire [31:0] addr,
           input wire [1:0] save,
           output reg [3:0] byte
       );

always @(*) begin
    case (save)
        2'b11:
            byte = 4'b1111;
        2'b10:
            if(addr[1] == 0)
                byte = 4'b0011;
            else
                byte = 4'b1100;
        2'b01:
        case (addr[1:0])
            2'b00:
                byte = 4'b0001;
            2'b01:
                byte = 4'b0010;
            2'b10:
                byte = 4'b0100;
            2'b11:
                byte = 4'b1000;
            default:
                ;
        endcase
        default:
            byte = 4'b0000;
    endcase
end

endmodule


    module byte_extender(
        input wire [31:0] addr,
        input wire [31:0] data_in,
        input wire [2:0] load,
        output reg [31:0] data_out
    );

always @(*) begin
    case (load)
        3'b011:
            data_out = data_in;
        3'b010:
            if(addr[1] == 0)
                data_out = {{16{data_in[15]}},data_in[15:0]};
            else
                data_out = {{16{data_in[31]}},data_in[31:16]};
        3'b001:
        case (addr[1:0])
            2'b00:
                data_out = {{24{data_in[7]}},data_in[7:0]};
            2'b01:
                data_out = {{24{data_in[15]}},data_in[15:8]};
            2'b10:
                data_out = {{24{data_in[23]}},data_in[23:16]};
            2'b11:
                data_out = {{24{data_in[31]}},data_in[31:24]};
            default:
                ;
        endcase
        3'b110:
            if(addr[1] == 0)
                data_out = {{16'b0},data_in[15:0]};
            else
                data_out = {{16'b0},data_in[31:16]};
        3'b101:
        case (addr[1:0])
            2'b00:
                data_out = {{24'b0},data_in[7:0]};
            2'b01:
                data_out = {{24'b0},data_in[15:8]};
            2'b10:
                data_out = {{24'b0},data_in[23:16]};
            2'b11:
                data_out = {{24'b0},data_in[31:24]};
            default:
                ;
        endcase
        default:
            data_out = data_in;
    endcase
end

endmodule

`endif
