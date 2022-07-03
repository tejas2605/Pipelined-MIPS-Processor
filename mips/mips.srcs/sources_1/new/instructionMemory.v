module instructionMemory(
input   [31:0] addressBus,
output  [31:0] instruction
);

reg [31:0] mem [1023:0];

initial
begin
    /*mem[0] = 32'h20020032;
    mem[1] = 32'h2001000a;
    mem[2] = 32'h14220001;
    mem[3] = 32'h08000006;
    mem[4] = 32'h2021000a;
    mem[5] = 32'h08000002;
    mem[6] = 32'hac220064;
    mem[7] = 32'h00411020;
    mem[8] = 32'h8c420032;
    mem[9] = 32'h0023102a;
    mem[10] = 32'hac41000a;*/
    mem[0] = 32'h2002000a;
    mem[1] = 32'h2001000a;
    mem[2] = 32'h2003000e;
    mem[3] = 32'h14220000;
    mem[4] = 32'h1423fffe;

end

assign instruction =  mem[addressBus[31:2]];


endmodule