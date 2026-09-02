`timescale 1ns / 1ps



module instr_mem (
    input  wire [31:0] addr,       
    output wire [31:0] instr      
);

   
    reg [31:0] memory_array [0:63];

    
    assign instr = memory_array[addr[7:2]];

endmodule
