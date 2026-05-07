`timescale 1ns / 1ps


module gpr(
    input clk,
    input reset,
    input [1:0] reg_sel_read1,
    input [1:0] reg_sel_read2,
    input [1:0] reg_sel_write,
    input [7:0] data_in,
    input reg_write,
    output reg [7:0] data_out1,
    output reg [7:0] data_out2
);

    reg [7:0] registers [0:3];

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
                registers[i] <= 8'b0;
        end else if (reg_write) begin
            registers[reg_sel_write] <= data_in;
        end
    end

    always @(*) begin
        data_out1 = registers[reg_sel_read1];
        data_out2 = registers[reg_sel_read2];
    end

endmodule
