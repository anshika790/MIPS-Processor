`timescale 1ns / 1ps


module id_ex (
    input  wire        clk,
    input  wire        rst,
    input  wire        flush, 

   
    input  wire        RegDst_in,
    input  wire        ALUSrc_in,
    input  wire        MemtoReg_in,
    input  wire        RegWrite_in,
    input  wire        MemRead_in,
    input  wire        MemWrite_in,
    input  wire [1:0]  ALUOp_in,

    input  wire [31:0] pc_plus4_in,
    input  wire [31:0] read_data1_in,
    input  wire [31:0] read_data2_in,
    input  wire [31:0] sign_ext_in,
    input  wire [4:0]  rs_in,
    input  wire [4:0]  rt_in,
    input  wire [4:0]  rd_in,

    
    output reg         RegDst_out,
    output reg         ALUSrc_out,
    output reg         MemtoReg_out,
    output reg         RegWrite_out,
    output reg         MemRead_out,
    output reg         MemWrite_out,
    output reg [1:0]   ALUOp_out,

    output reg [31:0]  pc_plus4_out,
    output reg [31:0]  read_data1_out,
    output reg [31:0]  read_data2_out,
    output reg [31:0]  sign_ext_out,
    output reg [4:0]   rs_out,
    output reg [4:0]   rt_out,
    output reg [4:0]   rd_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            
            RegDst_out     <= 0;
            ALUSrc_out     <= 0;
            MemtoReg_out   <= 0;
            RegWrite_out   <= 0;
            MemRead_out    <= 0;
            MemWrite_out   <= 0;
            ALUOp_out      <= 2'b00;
            pc_plus4_out   <= 0;
            read_data1_out <= 0;
            read_data2_out <= 0;
            sign_ext_out   <= 0;
            rs_out         <= 0;
            rt_out         <= 0;
            rd_out         <= 0;
        end else begin
            RegDst_out     <= RegDst_in;
            ALUSrc_out     <= ALUSrc_in;
            MemtoReg_out   <= MemtoReg_in;
            RegWrite_out   <= RegWrite_in;
            MemRead_out    <= MemRead_in;
            MemWrite_out   <= MemWrite_in;
            ALUOp_out      <= ALUOp_in;

            pc_plus4_out   <= pc_plus4_in;
            read_data1_out <= read_data1_in;
            read_data2_out <= read_data2_in;
            sign_ext_out   <= sign_ext_in;

            rs_out         <= rs_in;
            rt_out         <= rt_in;
            rd_out         <= rd_in;
        end
    end

endmodule
