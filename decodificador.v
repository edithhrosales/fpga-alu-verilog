`timescale 1ns / 1ps
module decodificador(
    input [7:0] instruction,
    output reg [1:0] reg_sel1,
    output reg [1:0] reg_sel2,
    output reg [3:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg acc_load,
    output reg pc_load,
    output reg mar_load,
    output reg halted_flag,  
    output reg loadi,
    output reg [1:0] dest_reg
);
    always @(*) begin
        
        reg_sel1 = 2'b00;
        reg_sel2 = 2'b00;
        alu_op = 4'b0000;
        mem_read = 1'b0;
        mem_write = 1'b0;
        reg_write = 1'b0;
        acc_load = 1'b0;
        pc_load = 1'b0;
        mar_load = 1'b0;
        halted_flag = 1'b0;  
        loadi = 1'b0;
        dest_reg = 2'b00;

        case (instruction)
            // ALU operations
            8'h08: begin // SUMA R1 + R2 ? ACC
                reg_sel1 = 2'b01;
                reg_sel2 = 2'b10;
                alu_op = 4'h8;
                acc_load = 1'b1;
            end
            8'h0A: begin // RESTA
                reg_sel1 = 2'b01;
                reg_sel2 = 2'b10;
                alu_op = 4'hA;
                acc_load = 1'b1;
            end
            8'h0B: begin // AND
                reg_sel1 = 2'b01;
                reg_sel2 = 2'b10;
                alu_op = 4'hB;
                acc_load = 1'b1;
            end
            8'h0C: begin // OR
                reg_sel1 = 2'b01;
                reg_sel2 = 2'b10;
                alu_op = 4'hC;
                acc_load = 1'b1;
            end
            
            8'h80: begin 
                loadi = 1'b1;
                reg_write = 1'b1;
                dest_reg = 2'b00;
            end
            8'h81: begin 
                loadi = 1'b1;
                reg_write = 1'b1;
                dest_reg = 2'b01;
            end
            8'h82: begin 
                loadi = 1'b1;
                reg_write = 1'b1;
                dest_reg = 2'b10;
            end
            8'h83: begin 
                loadi = 1'b1;
                reg_write = 1'b1;
                dest_reg = 2'b11;
            end
            
            8'h20: begin 
                halted_flag = 1'b1;  
            end
            
            8'h10: begin
              
            end
        endcase
    end
endmodule

