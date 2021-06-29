module hazard_detection(
    input [4:0] rd,
    input [4:0] rs1,
    input [4:0] rs2,
    input MemRead,
    output reg PC_write,
    output reg IF_ID_write,
    output reg control_sel
    );

always @* begin
    if (MemRead & ((rd == rs1) | (rd == rs2))) begin
        PC_write = 0;
        IF_ID_write = 0;
        control_sel = 1;
    end
    else begin
        PC_write = 1;
        IF_ID_write = 1;
        control_sel = 0;
    end
end
endmodule
