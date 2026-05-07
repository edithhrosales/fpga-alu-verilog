`timescale 1ns / 1ps
module mar(
    input clk,
    input [7:0] addr_in,
    input load,
    output reg [7:0] addr_out
);
    always @(posedge clk) begin
        if (load)
            addr_out <= addr_in;
    end
endmodule
