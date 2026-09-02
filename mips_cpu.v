

`timescale 1ns / 1ps



module mips_cpu (
    input  wire clk,
    input  wire rst
);

   
    wire [31:0] pc_out, next_pc, instruction, pc_plus4_IF;
    wire        PCWrite, IF_ID_Write, ControlNOP;

    pc pc_inst (
        .clk(clk), .rst(rst), .enable(PCWrite),
        .next_pc(next_pc), .pc_out(pc_out)
    );

    instr_mem imem (
        .addr(pc_out), .instr(instruction)
    );

    adder pc_adder (
        .a(pc_out), .b(32'd4), .sum(pc_plus4_IF)
    );

    wire [31:0] instruction_ID, pc_plus4_ID;
    if_id if_id_reg (
        .clk(clk), .rst(rst), .enable(IF_ID_Write), .flush(0),
        .instr_in(instruction), .pc_plus4_in(pc_plus4_IF),
        .instr_out(instruction_ID), .pc_plus4_out(pc_plus4_ID)
    );

    
    wire [5:0] opcode = instruction_ID[31:26];
    wire [4:0] rs = instruction_ID[25:21], rt = instruction_ID[20:16], rd = instruction_ID[15:11];
    wire [15:0] imm = instruction_ID[15:0];
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;

    control control_unit (
        .opcode(opcode), .nop(ControlNOP),
        .RegDst(RegDst), .ALUSrc(ALUSrc), .MemToReg(MemToReg),
        .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
        .Branch(Branch), .ALUOp(ALUOp)
    );

    wire [31:0] read_data1, read_data2, sign_ext_out;
    wire [31:0] write_data_WB;
    wire [4:0] write_reg_WB;
    wire       RegWrite_WB;

    reg_file regfile (
        .clk(clk), .reg_write(RegWrite_WB),
        .rs(rs), .rt(rt), .rd(write_reg_WB),
        .write_data(write_data_WB),
        .read_data1(read_data1), .read_data2(read_data2)
    );
    
    sign_extend signext (
        .in(imm), .out(sign_ext_out)
    );

   
    wire [31:0] read_data1_EX, read_data2_EX, sign_ext_ex, pc_plus4_EX;
    wire [4:0] rs_EX, rt_EX, rd_EX;
    wire RegDst_EX, ALUSrc_EX, MemToReg_EX, RegWrite_EX, MemRead_EX, MemWrite_EX;
    wire [1:0] ALUOp_EX;

    id_ex id_ex_reg (
        .clk(clk), .rst(rst), .flush(0),
        .RegDst_in(RegDst), .ALUSrc_in(ALUSrc), .MemtoReg_in(MemToReg),
        .RegWrite_in(RegWrite), .MemRead_in(MemRead), .MemWrite_in(MemWrite), .ALUOp_in(ALUOp),
        .pc_plus4_in(pc_plus4_ID), .read_data1_in(read_data1), .read_data2_in(read_data2),
        .sign_ext_in(sign_ext_out), .rs_in(rs), .rt_in(rt), .rd_in(rd),
        .RegDst_out(RegDst_EX), .ALUSrc_out(ALUSrc_EX), .MemtoReg_out(MemToReg_EX),
        .RegWrite_out(RegWrite_EX), .MemRead_out(MemRead_EX), .MemWrite_out(MemWrite_EX), .ALUOp_out(ALUOp_EX),
        .pc_plus4_out(pc_plus4_EX), .read_data1_out(read_data1_EX), .read_data2_out(read_data2_EX),
        .sign_ext_out(sign_ext_EX), .rs_out(rs_EX), .rt_out(rt_EX), .rd_out(rd_EX)
    );

    
    wire [31:0] mem_data_WB, alu_result_WB;
    wire        MemToReg_WB;

   
    mem_wb mem_wb_reg (
        .clk(clk), .rst(rst),
        .RegWrite_in(RegWrite_MEM), .MemToReg_in(MemToReg_MEM),
        .read_data_in(mem_data_MEM), .alu_result_in(alu_result_MEM),
        .dest_reg_in(write_reg_MEM),
        .RegWrite_out(RegWrite_WB), .MemToReg_out(MemToReg_WB),
        .read_data_out(mem_data_WB), .alu_result_out(alu_result_WB),
        .dest_reg_out(write_reg_WB)
    );

   
    assign write_data_WB= (MemToReg_WB) ? mem_data_WB:alu_result_WB;


    alu_control alu_ctrl_unit (.ALUOp(ALUOp_ex), .funct(sign_ext_ex[5:0]), .alu_ctrl(alu_ctrl));
    alu alu_unit (.A(alu_input1), .B(alu_input2), .alu_ctrl(alu_ctrl), .result(alu_result), .zero());
    wire [31:0] mem_data_mem;

    data_mem dmem (
        .clk(clk),
        .mem_read(MemRead_mem),
        .mem_write(MemWrite_mem),
        .addr(alu_result_mem),
        .write_data(write_data_mem),
        .read_data(mem_data_mem)
    );
endmodule
