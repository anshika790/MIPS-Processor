`timescale 1ns / 1ps


module data_mem (
    input wire clk,
    input wire mem_read,
    input wire mem_write,
    input wire [31:0] addr,           
    input wire [31:0] write_data,     
    output reg [31:0] read_data      
);

    
    reg [31:0] mem_array [0:63];
    

    always @(*) begin
        if (mem_read)
            read_data = mem_array[addr[7:2]];  
        else
            read_data = 32'b0;
    end

    
    always @(posedge clk) begin
        if (mem_write)
            mem_array[addr[7:2]] <= write_data;
    end

endmodule
