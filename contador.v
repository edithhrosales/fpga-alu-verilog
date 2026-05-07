`timescale 1ns / 1ps
module contador(
    input clk,
    input reset,
    input [7:0] next_addr,
    input load,
    input halted,
    output reg [7:0] addr
    );
always @(posedge clk or posedge reset) begin
    if (reset)
        addr <= 8'b0;
    else if (halted)       
        addr <= addr;    
    else if (load)
        addr <= next_addr;
    else
        addr <= addr + 1;
end
endmodule
