`timescale 1ns / 1ps



module pc (
    input  wire        clk,
    input  wire        rst,
    input  wire        enable,       
    input  wire [31:0] next_pc,
    output reg  [31:0] pc_out
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_out <= 32'b0;         
        else if (enable)
            pc_out <= next_pc;       
      
    end

endmodule
