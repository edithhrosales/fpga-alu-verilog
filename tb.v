`timescale 1ns / 1ps
module tb_procesador;

    
    reg clk;
    reg reset;
    wire halted;

    wire [7:0] pc_addr, mar_addr, mem_data, reg_data1, reg_data2, alu_result, acc_data;
    wire [3:0] alu_op;
    wire mem_read, mem_write, reg_load, acc_load, halted_flag, loadi;
    wire [1:0] dest_reg;

    procesador uut (
        .clk(clk),
        .reset(reset),
        .halted(halted),
        .pc_addr(pc_addr),
        .mar_addr(mar_addr),
        .mem_data(mem_data),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .alu_result(alu_result),
        .acc_data(acc_data),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_load(reg_load),
        .acc_load(acc_load),
        .halted_flag(halted_flag),
        .loadi(loadi),
        .dest_reg(dest_reg)
    );

   
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    
    always @(posedge clk) begin
        if (mem_data === 8'hXX) begin
            $display("?? Advertencia: acceso a memoria no inicializada en dirección %h", mar_addr);
        end
    end

    
    always @(posedge clk) begin
        if (halted) begin
            $display("? Simulación detenida: Procesador ha finalizado la ejecución.");
            $finish;
        end

        if (mar_addr > 8'h20) begin
            $display("? Simulación detenida: Dirección fuera de rango detectada (%h).", mar_addr);
            $finish;
        end
    end

endmodule



