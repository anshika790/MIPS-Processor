`timescale 1ns / 1ps


module mem_wb (
    input  wire        clk,
    input  wire        rst,

   
    input  wire        RegWrite_in,
    input  wire        MemToReg_in,
    input  wire [31:0] read_data_in,
    input  wire [31:0] alu_result_in,
    input  wire [4:0]  dest_reg_in,

    
    output reg         RegWrite_out,
    output reg         MemToReg_out,
    output reg [31:0]  read_data_out,
    output reg [31:0]  alu_result_out,
    output reg [4:0]   dest_reg_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWrite_out    <= 0;
            MemToReg_out    <= 0;
            read_data_out   <= 0;
            alu_result_out  <= 0;
            dest_reg_out    <= 0;
        end else begin
            RegWrite_out    <= RegWrite_in;
            MemToReg_out    <= MemToReg_in;
            read_data_out   <= read_data_in;
            alu_result_out  <= alu_result_in;
            dest_reg_out    <= dest_reg_in;
        end
    end

endmodule
 
