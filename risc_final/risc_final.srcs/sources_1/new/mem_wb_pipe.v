module mem_wb_pipe(
    input clk, write, reset,
    input MemtoReg_in, RegWrite_in,
    input [4:0] rd_in,
    input [31:0] ALU_OUT_EX_in, read_data_in,

    output reg MemtoReg_out, RegWrite_out,
    output reg [4:0] rd_out,
    output reg [31:0] ALU_OUT_EX_out, read_data_out
    );

always@(posedge clk) begin
    if (reset) begin
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
        rd_out <= 5'b0;
        ALU_OUT_EX_out <= 32'b0;
        read_data_out <= 32'b0;
    end
    else begin
        if(write) begin
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
            rd_out <= rd_in;
            ALU_OUT_EX_out <= ALU_OUT_EX_in;
            read_data_out <= read_data_in;
        end
    end
end
endmodule
