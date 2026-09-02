`timescale 1ns / 1ps


module ex_mem (
    input  wire        clk,
    input  wire        rst,

   
    input  wire        RegWrite_in,
    input  wire        MemtoReg_in,
    input  wire        MemRead_in,
    input  wire        MemWrite_in,
    input  wire [31:0] alu_result_in,
    input  wire [31:0] write_data_in,
    input  wire [4:0]  dest_reg_in,

    
    output reg         RegWrite_out,
    output reg         MemtoReg_out,
    output reg         MemRead_out,
    output reg         MemWrite_out,
    output reg [31:0]  alu_result_out,
    output reg [31:0]  write_data_out,
    output reg [4:0]   dest_reg_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegWrite_out    <= 0;
            MemtoReg_out    <= 0;
            MemRead_out     <= 0;
            MemWrite_out    <= 0;
            alu_result_out  <= 0;
            write_data_out  <= 0;
            dest_reg_out    <= 0;
        end else begin
            RegWrite_out    <= RegWrite_in;
            MemtoReg_out    <= MemtoReg_in;
            MemRead_out     <= MemRead_in;
            MemWrite_out    <= MemWrite_in;
            alu_result_out  <= alu_result_in;
            write_data_out  <= write_data_in;
            dest_reg_out    <= dest_reg_in;
        end
    end

endmodule
