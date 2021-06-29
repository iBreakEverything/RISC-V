`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2021 08:44:17 AM
// Design Name: 
// Module Name: RISC_V
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_V(
    input clk,
    input reset,
    
    output [31:0] PC_EX,                //ok
    output [31:0] ALU_OUT_EX,           //ok
    output [31:0] PC_MEM,               //ok
    output PCSrc,                       //ok
    output [31:0] DATA_MEMORY_MEM,      //ok
    output [31:0] ALU_DATA_WB,          //ok
    output [1:0] forwardA, forwardB,    //ok
    output pipeline_stall               //ok
    );

wire ALUSrc_id, Branch_id, MemRead_id, MemWrite_id, MemtoReg_id, RegWrite_id;
wire ALUSrc_ex, Branch_ex, MemRead_ex, MemWrite_ex, MemtoReg_ex, RegWrite_ex;
wire Branch_mem, MemRead_mem, MemWrite_mem, MemtoReg_mem, RegWrite_mem;
wire MemtoReg_wb, RegWrite_wb;
wire pc_write, if_id_write;
wire zero_ex, zero_mem;
wire [1:0] ALUop_id, ALUop_ex;
wire [2:0] funct3, funct3_ex;
wire [4:0] rd_id, rd_ex, rd_mem, rd_wb, rs1_id, rs1_ex, rs2_id, rs2_ex;
wire [6:0] funct7, funct7_ex, opcode;
wire [31:0] alu_address_mem;
wire [31:0] read_data_wb, write_data_WB;
wire [31:0] reg_data2_ex, reg_data2_mem;
wire [31:0] PC_Branch_ex;
wire [31:0] PC_ID, IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
wire [31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX;

// IF+ID /////////////////////////////////////////////////////////////

RISC_V_IF_ID procesor(
    //input
    .clk(clk),
    .reset(reset),
    .IF_ID_write(if_id_write),
    .PCSrc(PCSrc),
    .PC_write(pc_write),
    .PC_Branch(PC_MEM),
    .RegWrite_WB(RegWrite_wb),
    .ALU_DATA_WB(write_data_WB),
    .RD_WB(rd_wb),
    .control_sel(pipeline_stall),
    //output
    .PC_ID(PC_ID),
    .INSTRUCTION_ID(),
    .IMM_ID(IMM_ID),
    .REG_DATA1_ID(REG_DATA1_ID),
    .REG_DATA2_ID(REG_DATA2_ID),
    .FUNCT3_ID(funct3),
    .FUNCT7_ID(funct7),
    .OPCODE_ID(opcode),
    .RD_ID(rd_id),
    .RS1_ID(rs1_id),
    .RS2_ID(rs2_id),
    .RegWrite_ID(RegWrite_id),
    .MemtoReg_ID(MemtoReg_id),
    .MemRead_ID(MemRead_id),
    .MemWrite_ID(MemWrite_id),
    .ALUop_ID(ALUop_id),
    .ALUSrc_ID(ALUSrc_id),
    .Branch_ID(Branch_id)
);

// ID/EX Pipe ////////////////////////////////////////////////////////

id_ex_pipe pipe_id_ex(
    //input
    .clk(clk),
    .write(1),
    .reset(reset),
    .Branch_in(Branch_id),
    .MemRead_in(MemRead_id),
    .MemtoReg_in(MemtoReg_id),
    .MemWrite_in(MemWrite_id),
    .RegWrite_in(RegWrite_id),
    .ALUSrc_in(ALUSrc_id),
    .ALUop_in(ALUop_id),
    .FUNCT3_in(funct3),
    .FUNCT7_in(funct7),
    .rd_in(rd_id),
    .rs1_in(rs1_id),
    .rs2_in(rs2_id),
    .PC_in(PC_ID),
    .IMM_in(IMM_ID),
    .REG_DATA1_in(REG_DATA1_ID),
    .REG_DATA2_in(REG_DATA2_ID),
    //output
    .Branch_out(Branch_ex),
    .MemRead_out(MemRead_ex),
    .MemtoReg_out(MemtoReg_ex),
    .MemWrite_out(MemWrite_ex),
    .RegWrite_out(RegWrite_ex),
    .ALUSrc_out(ALUSrc_ex),
    .ALUop_out(ALUop_ex),
    .FUNCT3_out(funct3_ex),
    .FUNCT7_out(funct7_ex),
    .rd_out(rd_ex),
    .rs1_out(rs1_ex),
    .rs2_out(rs2_ex),
    .PC_out(PC_EX),
    .IMM_out(IMM_EX),
    .REG_DATA1_out(REG_DATA1_EX),
    .REG_DATA2_out(REG_DATA2_EX)
    );

// EX ////////////////////////////////////////////////////////////////

EX ex(
    //input
    .IMM_EX(IMM_EX),
    .REG_DATA1_EX(REG_DATA1_EX),
    .REG_DATA2_EX(REG_DATA2_EX),
    .PC_EX(PC_EX),
    .FUNCT3_EX(funct3_ex),
    .FUNCT7_EX(funct7_ex),
    .RD_EX(rd_ex),
    .RS1_EX(rs1_ex),
    .RS2_EX(rs2_ex),
    .RegWrite_EX(RegWrite_ex),
    .MemtoReg_EX(MemtoReg_ex),
    .MemRead_EX(MemRead_ex),
    .MemWrite_EX(MemWrite_ex),
    .ALUop_EX(ALUop_ex),
    .ALUSrc_EX(ALUSrc_ex),
    .Branch_EX(Branch_ex),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .ALU_DATA_WB(write_data_WB),
    .ALU_OUT_MEM(alu_address_mem),
    //output
    .ZERO_EX(zero_ex),
    .ALU_OUT_EX(ALU_OUT_EX),
    .PC_Branch_EX(PC_Branch_ex),
    .REG_DATA2_EX_FINAL(reg_data2_ex)
);

hazard_detection hazard(
    //input
    .rd(rd_ex),
    .rs1(rs1_ex),
    .rs2(rs2_ex),
    .MemRead(MemRead_ex),
    //output
    .PC_write(pc_write),
    .IF_ID_write(if_id_write),
    .control_sel(pipeline_stall)  // control_sel
);

forwarding fwd(
    //input
    .rs1(rs1_ex),
    .rs2(rs2_ex),
    .ex_mem_rd(rd_mem),
    .mem_wb_rd(rd_wb),
    .ex_mem_regwrite(RegWrite_mem),
    .mem_wb_regwrite(RegWrite_wb),
    //output
    .forwardA(forwardA),
    .forwardB(forwardB)
);

// EX/MEM Pipe ///////////////////////////////////////////////////////

ex_mem_pipe pipe_ex_mem(
    //input
    .clk(clk),
    .write(1),
    .reset(reset),
    .Branch_in(Branch_ex),
    .MemRead_in(MemRead_ex),
    .MemtoReg_in(MemtoReg_ex),
    .MemWrite_in(MemWrite_ex),
    .RegWrite_in(RegWrite_ex),
    .zero_in(zero_ex),
    .rd_in(rd_ex),
    .ALU_OUT_EX_in(ALU_OUT_EX),
    .write_data_in(reg_data2_ex),
    .PC_Branch_in(PC_Branch_ex),
    //output
    .Branch_out(Branch_mem),
    .MemRead_out(MemRead_mem),
    .MemtoReg_out(MemtoReg_mem),
    .MemWrite_out(MemWrite_mem),
    .RegWrite_out(RegWrite_mem),
    .zero_out(zero_mem),
    .rd_out(rd_mem),
    .ALU_OUT_EX_out(alu_address_mem),
    .write_data_out(reg_data2_mem),
    .PC_Branch_out(PC_MEM)
);

// MEM ///////////////////////////////////////////////////////////////

and(PCSrc, Branch_mem, zero_mem);

data_memory mem_data(
    //input
    .clk(clk),       
    .mem_read(MemRead_mem),
    .mem_write(MemWrite_mem),
    .address(alu_address_mem),
    .write_data(reg_data2_mem),
    //output
    .read_data(DATA_MEMORY_MEM)
);

// MEM/WB Pipe ///////////////////////////////////////////////////////

mem_wb_pipe mem_wb_pipe(
    //input
    .clk(clk),
    .write(1),
    .reset(reset),
    .MemtoReg_in(MemtoReg_mem),
    .RegWrite_in(RegWrite_mem),
    .rd_in(rd_mem),
    .ALU_OUT_EX_in(alu_address_mem),
    .read_data_in(DATA_MEMORY_MEM),
    //output
    .MemtoReg_out(MemtoReg_wb),
    .RegWrite_out(RegWrite_wb),
    .rd_out(rd_wb),
    .ALU_OUT_EX_out(ALU_DATA_WB),
    .read_data_out(read_data_wb)
);

// WB ////////////////////////////////////////////////////////////////

mux2_1 mux_wb(
    //input
    .ina(ALU_DATA_WB),
    .inb(read_data_wb),
    .sel(MemtoReg_wb),
    //output
    .out(write_data_WB)
);

endmodule
