`timescale 1ns / 1ps


module if_id (
    input  wire        clk,
    input  wire        rst,
    input  wire        enable,       
    input  wire        flush,        
    input  wire [31:0] instr_in,
    input  wire [31:0] pc_plus4_in,
    output reg  [31:0] instr_out,
    output reg  [31:0] pc_plus4_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instr_out      <= 32'b0;
            pc_plus4_out   <= 32'b0;
        end else if (flush) begin
            instr_out      <= 32'b0; 
            pc_plus4_out   <= 32'b0;
        end else if (enable) begin
            instr_out      <= instr_in;
            pc_plus4_out   <= pc_plus4_in;
        end
        
    end

endmodule
