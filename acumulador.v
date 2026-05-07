`timescale 1ns / 1ps
module accumulator(
    input clk,
    input [7:0] data_in,
    input load,
    output reg [7:0] data_out
);
    always @(posedge clk) begin
        if (load)
            data_out <= data_in;
    end
endmodule
