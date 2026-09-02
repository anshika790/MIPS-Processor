`timescale 1ns / 1ps



module hazard_unit (
    input  wire        ID_EX_MemRead,
    input  wire [4:0]  ID_EX_Rt,
    input  wire [4:0]  IF_ID_Rs,
    input  wire [4:0]  IF_ID_Rt,

    output reg         PCWrite,
    output reg         IF_ID_Write,
    output reg         ControlNOP
);

    always @(*) begin
       
        PCWrite      = 1;
        IF_ID_Write  = 1;
        ControlNOP   = 0;

        
        if (ID_EX_MemRead &&
            ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt))) begin
           
            PCWrite      = 0;
            IF_ID_Write  = 0;
            ControlNOP   = 1;
        end
    end

endmodule
