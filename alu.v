`timescale 1ns / 1ps


module alu (
    input  wire [31:0] A,       
    input  wire [31:0] B,       
    input  wire [3:0] alu_ctrl, 
    output reg  [31:0] result,  
    output wire zero           
);

    
    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = A & B;        
            4'b0001: result = A | B;         
            4'b0010: result = A + B;         
            4'b0110: result = A - B;         
            4'b0111: result = (A < B) ? 32'b1 : 32'b0; 
            4'b1100: result = ~(A | B);      
            default: result = 32'b0;
        endcase
    end

    
    assign zero = (result == 32'b0);

endmodule
