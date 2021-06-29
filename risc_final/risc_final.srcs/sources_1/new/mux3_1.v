`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/03/2021 11:05:35 AM
// Design Name: 
// Module Name: mux3_1
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


module mux3_1(
    input [31:0] ina,
    input [31:0] inb,
    input [31:0] inc,
    input [1:0] sel,
    output [31:0] out
    );

    assign out = ( sel == 2'b00 )? ina : ( sel == 2'b01 )? inb : ( sel == 2'b10 )? inc : 32'bx;
  //assign out = ( sel == 2'b01 )? inb : ( sel == 2'b10 )? inc : ina;

endmodule
