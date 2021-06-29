module EX(
    input [31:0] IMM_EX,                // MUX_IMM + ADDER
    input [31:0] REG_DATA1_EX,          // MUX_1
    input [31:0] REG_DATA2_EX,          // MUX_2
    input [31:0] PC_EX,                 // ADDER
    input [2:0] FUNCT3_EX,              // ALUctrl
    input [6:0] FUNCT7_EX,              // ALUctrl
    input [4:0] RD_EX,
    input [4:0] RS1_EX,
    input [4:0] RS2_EX,
    input RegWrite_EX,          // WB   ??
    input MemtoReg_EX,          // WB   ??
    input MemRead_EX,           // REG  ??
    input MemWrite_EX,          // REG  ??
    input [1:0] ALUop_EX,               // ALUctrl
    input ALUSrc_EX,                    // MUX_IMM
    input Branch_EX,            // REG
    input [1:0] forwardA,forwardB,      // MUX_1_2
    
    input [31:0] ALU_DATA_WB,           // MUX_1_2
    input [31:0] ALU_OUT_MEM,           // MUX_1_2
    
    output ZERO_EX,                     // ALU
    output [31:0] ALU_OUT_EX,           // ALU
    output [31:0] PC_Branch_EX,         // ADDER
    output [31:0] REG_DATA2_EX_FINAL    // MUX_2_IMM
    );

wire [3:0] ALUwire;
wire [31:0] mux_EX_1_wire, mux_EX_imm_wire;

adder adder(PC_EX, IMM_EX, PC_Branch_EX);

// EX MUX ////////////////////
mux3_1 mux_1(.ina(REG_DATA1_EX), .inb(ALU_DATA_WB), .inc(ALU_OUT_MEM), .sel(forwardA),
                .out(mux_EX_1_wire));

mux3_1 mux_2(.ina(REG_DATA2_EX), .inb(ALU_DATA_WB), .inc(ALU_OUT_MEM), .sel(forwardB),
                .out(REG_DATA2_EX_FINAL));

mux2_1 mux_imm(.ina(REG_DATA2_EX_FINAL), .inb(IMM_EX), .sel(ALUSrc_EX),
              .out(mux_EX_imm_wire));

// ALU ///////////////////////
ALUcontrol alo_controlu(.ALUop(ALUop_EX), .funct7(FUNCT7_EX), .funct3(FUNCT3_EX),
                        .ALUinput(ALUwire));

ALU alo(.ALUop(ALUwire), .ina(mux_EX_1_wire), .inb(mux_EX_imm_wire),
        .zero(ZERO_EX), .out(ALU_OUT_EX));

endmodule
