`timescale 1ns / 1ps


module control (
    input  wire [5:0] opcode,
    input  wire       nop,  

    output reg        RegDst,
    output reg        ALUSrc,
    output reg        MemToReg,
    output reg        RegWrite,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        Branch,
    output reg [1:0]  ALUOp
);

    always @(*) begin
        if (nop) begin
            
            {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                = 11'b0;
        end else begin
            case (opcode)
                6'b000000: 
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};

                6'b100011: 
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00};

                6'b101011: 
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = {1'bx, 1'b1, 1'bx, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00};

                6'b000100:
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = {1'bx, 1'b0, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01};

                6'b001000: 
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00};

                default:
                    {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} 
                        = 11'b0;
            endcase
        end
    end

endmodule
