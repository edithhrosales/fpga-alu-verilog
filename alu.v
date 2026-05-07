`timescale 1ns / 1ps
module alu(
    input [7:0] a,         
    input [7:0] b,         
    input [3:0] opcode,    
    output reg [7:0] result, 
    output wire zero_flag       
);

    always @(*) begin
        case(opcode)
            4'h8: result = a + b;
            4'hA: result = a - b;
            4'hB: result = a & b;
            4'hC: result = a | b;
            default: result = 8'h00;
        endcase
    end

    assign zero_flag = (result == 8'h00);

endmodule

