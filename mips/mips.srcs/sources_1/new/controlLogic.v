`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2022 03:21:30 PM
// Design Name: 
// Module Name: controlLogic
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
`define lw    'b100011
`define sw    'b101011
`define addi  'b001000
`define bne   'b000101
`define rtype 'b000000
`define add   'b100000
`define sub   'b100010
`define andOp 'b100100
`define orOp  'b100101
`define slt   'b101010
`define j     'b000010
`define nop   'h00000000
module controlLogic(
input   [31:0] instruction,
//input          zeroFlag,
output reg     regDst,
output reg     regWrite,
output reg     aluSrc,
output reg     jmpdetect,
output reg [2:0]   aluOp,
output reg     memWrite,
output reg     memToReg,
output         pcSrc
);

wire [5:0] opCode;
wire [5:0] func;

assign func = instruction[5:0];
assign opCode = instruction[31:26]; 
assign pcSrc = (opCode == `bne);
always @(*)
begin
    regDst = 0;
    if((opCode == `rtype) & (instruction != `nop))
        regDst = 1'b1;
    else
        regDst = 1'b0;
end

always @(*)
begin
    regWrite = 0;
    if(((opCode == `rtype) & (instruction != `nop))| opCode == `lw | opCode == `addi)
        regWrite = 1'b1;
    else
        regWrite = 1'b0;
end

always @(*)
begin
    aluSrc = 0;
    if(((opCode == `rtype) & (instruction != `nop))| opCode == `bne)
        aluSrc = 1'b0;
    else
        aluSrc = 1'b1;
end

always @(*)
begin
    aluOp = 3'd0;
    if((opCode == `rtype) & (instruction != `nop))
    begin
        case(func)
            `add:aluOp = 3'b010;
            `sub:aluOp = 3'b110;
            `andOp:aluOp = 3'b000;
            `orOp:aluOp = 3'b001;
            `slt:aluOp = 3'b111;
            default:aluOp = 3'b000;
        endcase
    end
    else if(opCode == `lw | opCode == `sw | opCode == `addi)
        aluOp = 3'b010;
    else
        aluOp = 3'b110;
end


always @(*)
begin
    memWrite = 0;
    if(opCode == `sw)
        memWrite = 1'b1;
    else
        memWrite = 1'b0;
end

always @(*)
begin
    memToReg = 0;
    if(opCode == `lw)
        memToReg = 1'b1;
    else
        memToReg = 1'b0;
end

always @(*)
begin
    if(opCode ==`j)
        jmpdetect=1'b1;
    else
        jmpdetect=1'b0;

end

endmodule
