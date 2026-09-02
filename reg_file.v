`timescale 1ns / 1ps

module reg_file (
    input wire clk,
    input wire reg_write,             
    input wire [4:0] rs, rt, rd,      
    input wire [31:0] write_data,      
    output wire [31:0] read_data1,     
    output wire [31:0] read_data2      
);

   
    reg [31:0] regs[0:31];
    integer i;

   
    initial begin
        
        for (i = 0; i < 32; i = i + 1) begin
            regs[i] = 32'b0;
        end
    end

    
    assign read_data1 = (rs == 5'd0) ? 32'b0 : regs[rs];
    assign read_data2 = (rt == 5'd0) ? 32'b0 : regs[rt];

   
    always @(posedge clk) begin
        if (reg_write && rd != 5'd0) begin
            regs[rd] <= write_data;
        end
       
        regs[0] <= 32'b0;
    end

endmodule
