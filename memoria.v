module memory(
    input clk,
    input [7:0] addr,
    output reg [7:0] data_out,
    input [7:0] data_in,        
    input write_enable 
);

    reg [7:0] mem [0:255]; 

    initial begin
        $readmemh("ini.txt", mem);
    end

    always @(posedge clk) begin
        if (write_enable)
            mem[addr] <= data_in;
        data_out <= mem[addr]; 
    end

endmodule



