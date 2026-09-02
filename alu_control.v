`timescale 1ns / 1ps

module alu_control (
    input  wire [1:0] ALUOp,
    input  wire [5:0] funct,
    output reg  [3:0] alu_ctrl
);

    always @(*) begin
        case ({ALUOp, funct})
            8'b10_100000: alu_ctrl = 4'b0010; 
            8'b10_100010: alu_ctrl = 4'b0110; 
            8'b10_100100: alu_ctrl = 4'b0000; 
            8'b10_100101: alu_ctrl = 4'b0001; 
            8'b10_101010: alu_ctrl = 4'b0111; 
            8'b10_100111: alu_ctrl = 4'b1100; 

            default: begin
                case (ALUOp)
                    2'b00: alu_ctrl = 4'b0010; 
                    2'b01: alu_ctrl = 4'b0110; 
                    default: alu_ctrl = 4'b0000;
                endcase
            end
        endcase
    end

endmodule
