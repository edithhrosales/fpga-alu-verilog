`timescale 1ns / 1ps

module procesador(
    input clk,
    input reset,
    output reg halted,

    
    output [7:0] pc_addr,
    output [7:0] mar_addr,
    output [7:0] mem_data,
    output [7:0] reg_data1,
    output [7:0] reg_data2,
    output [7:0] alu_result,
    output [7:0] acc_data,
    output [3:0] alu_op,
    output mem_read,
    output mem_write,
    output reg_load,
    output acc_load,
    output halted_flag,
    output loadi,
    output [1:0] dest_reg
);

    reg [7:0] immediate_data;
    reg fetch_immediate = 0;

    wire [7:0] pc_next;
    wire load_pc;

    
    assign pc_next = fetch_immediate ? pc_addr : (pc_addr + 1);

    
    assign load_pc = 1'b1;

    
    contador pc_counter (
        .clk(clk),
        .reset(reset),
        .next_addr(pc_next),
        .load(load_pc),
        .halted(halted),
        .addr(pc_addr)
    );

    mar memory_address_register(
        .clk(clk),
        .addr_in(pc_addr),
        .load(1'b1),  
        .addr_out(mar_addr)
    );

    memory mem(
        .clk(clk),
        .addr(mar_addr),
        .data_out(mem_data),
        .data_in(acc_data),
        .write_enable(mem_write)
    );

    wire [1:0] reg_sel1;
    wire [1:0] reg_sel2;

    decodificador instr_decoder(
        .instruction(mem_data),
        .reg_sel1(reg_sel1),
        .reg_sel2(reg_sel2),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_load),
        .acc_load(acc_load),
        .pc_load(),    
        .mar_load(),   
        .halted_flag(halted_flag),
        .loadi(loadi),
        .dest_reg(dest_reg)
    );

    gpr registers(
        .clk(clk),
        .reset(reset),
        .reg_sel_read1(reg_sel1),
        .reg_sel_read2(reg_sel2),
        .reg_sel_write(dest_reg),
        .data_in(loadi ? immediate_data : alu_result),
        .reg_write(reg_load || loadi),
        .data_out1(reg_data1),
        .data_out2(reg_data2)
    );

    alu arithmetic_logic_unit(
        .a(reg_data1),
        .b(reg_data2),
        .opcode(alu_op),
        .result(alu_result),
        .zero_flag()
    );

    accumulator acc(
        .clk(clk),
        .data_in(alu_result),
        .load(acc_load),
        .data_out(acc_data)
    );

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            halted <= 1'b0;
            immediate_data <= 8'b0;
            fetch_immediate <= 0;
        end else begin
            if (halted_flag)
                halted <= 1'b1;

            if (loadi && !fetch_immediate)
                fetch_immediate <= 1;
            else if (fetch_immediate) begin
                immediate_data <= mem_data;
                fetch_immediate <= 0;
            end
        end
    end

endmodule

