module ex_mem_pipe(
    input clk, write, reset,
    input Branch_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in,
    input zero_in,
    input [4:0] rd_in,
    input [31:0] ALU_OUT_EX_in,
    input [31:0] write_data_in,
    input [31:0] PC_Branch_in,

    output reg Branch_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out,
    output reg zero_out,
    output reg [4:0] rd_out,
    output reg [31:0] ALU_OUT_EX_out,
    output reg [31:0] write_data_out,
    output reg [31:0] PC_Branch_out
    );

always@(posedge clk) begin
    if (reset) begin
        Branch_out <= 0;
        MemRead_out <= 0;
        MemtoReg_out <= 0;
        MemWrite_out <= 0;
        RegWrite_out <= 0;
        MemtoReg_out <= 0;
        zero_out <= 0;
        rd_out <= 5'b0;
        ALU_OUT_EX_out <= 32'b0;
        write_data_out <= 32'b0;
        PC_Branch_out <= 32'b0;
    end
    else begin
        if(write) begin
            Branch_out <= Branch_in;
            MemRead_out <= MemRead_in;
            MemtoReg_out <= MemtoReg_in;
            MemWrite_out <= MemWrite_in;
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            zero_out <= zero_in;
            rd_out <= rd_in;
            ALU_OUT_EX_out <= ALU_OUT_EX_in;
            write_data_out <= write_data_in;
            PC_Branch_out <= PC_Branch_in;
        end
    end
end

endmodule