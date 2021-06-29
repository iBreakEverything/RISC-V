module id_ex_pipe(
    input clk, write, reset,
    input Branch_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, ALUSrc_in,
    input [1:0] ALUop_in,
    input [2:0] FUNCT3_in,
    input [6:0] FUNCT7_in,
    input [4:0] rd_in, rs1_in, rs2_in,
    input [31:0] PC_in, IMM_in, REG_DATA1_in, REG_DATA2_in,
    
    output reg Branch_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, ALUSrc_out,
    output reg [1:0] ALUop_out,
    output reg [2:0] FUNCT3_out,
    output reg [6:0] FUNCT7_out,
    output reg [4:0] rd_out, rs1_out, rs2_out,
    output reg [31:0] PC_out, IMM_out, REG_DATA1_out, REG_DATA2_out
    );

always@(posedge clk) begin
    if (reset) begin
        Branch_out <= 0;
        MemRead_out <= 0;
        MemtoReg_out <= 0;
        MemWrite_out <= 0;
        RegWrite_out <= 0;
        MemtoReg_out <= 0;
        ALUSrc_out <= 0;
        ALUop_out <= 0;
        FUNCT3_out <= 3'b0;
        FUNCT7_out <= 7'b0;
        rd_out <= 5'b0;
        rs1_out <= 5'b0;
        rs2_out <= 5'b0;
        PC_out <= 32'b0;
        IMM_out <= 32'b0;
        REG_DATA1_out <= 32'b0;
        REG_DATA2_out <= 32'b0;
    end
    else begin
        if(write) begin
            Branch_out <= Branch_in;
            MemRead_out <= MemRead_in;
            MemtoReg_out <= MemtoReg_in;
            MemWrite_out <= MemWrite_in;
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            ALUop_out <= ALUop_in;
            ALUSrc_out <= ALUSrc_in;
            FUNCT3_out <= FUNCT3_in;
            FUNCT7_out <= FUNCT7_in;
            rd_out <= rd_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            PC_out <= PC_in;
            IMM_out = IMM_in;
            REG_DATA1_out = REG_DATA1_in;
            REG_DATA2_out = REG_DATA2_in;
        end
    end
end

endmodule