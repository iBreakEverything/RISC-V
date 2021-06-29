module ALU(
    input [3:0] ALUop,
    input [31:0] ina,
    input [31:0] inb,
    output zero,
    output reg [31:0] out
    );

assign zero = (out == 32'b0);

always@(*) begin
    casex(ALUop)
        4'b0000: out <= (ina & inb);
        4'b0001: out <= (ina | inb);
        4'b0010: out <= (ina + inb);
        4'b0011: out <= (ina ^ inb);
        4'b0100: out <= (ina << inb);                                   //sll,slli | shift left logical
        4'b0101: out <= (ina >> inb);                                   //srl,srli | shift right logical
        4'b0110: out <= (ina - inb);
        4'b0111: out <= (ina < inb) ? 32'b1 : 32'b0;                    //sltu + bltu,bgeu | set/branch less than
        4'b1000: out <= ($signed(ina) < $signed(inb)) ? 32'b1 : 32'b0;  //slt + blt,bge | set/branch less than
        4'b1001: out <= ($signed(ina) >>> $signed(inb));                //sra,srai | shift right arithmetic
        default: out <= 4'b0;
    endcase
end
endmodule
