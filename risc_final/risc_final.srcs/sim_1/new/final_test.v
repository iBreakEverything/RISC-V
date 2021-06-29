///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module final_test;

    reg clk,reset;

    wire [31:0] PC_EX;
    wire [31:0] ALU_OUT_EX;
    wire [31:0] PC_MEM;
    wire PCSrc;
    wire [31:0] DATA_MEMORY_MEM;
    wire [31:0] ALU_DATA_WB;
    wire [1:0] forwardA;
    wire [1:0] forwardB;
    wire pipeline_stall;



RISC_V procesor_final(
    clk,
    reset,
    PC_EX,
    ALU_OUT_EX,
    PC_MEM,
    PCSrc,
    DATA_MEMORY_MEM,
    ALU_DATA_WB,
    forwardA,
    forwardB,
    pipeline_stall
    );

    always #5 clk=~clk;
  
initial begin
    #5 
    clk=1'b0;
    reset=1'b1;
    #10 reset=1'b0;
    #120 $finish;
  end
endmodule