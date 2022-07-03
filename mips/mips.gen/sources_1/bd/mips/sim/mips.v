//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr 28 14:36:23 2022
//Host        : LAPTOP-0HL21Q40 running 64-bit major release  (build 9200)
//Command     : generate_target mips.bd
//Design      : mips
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module DataHazardUnit_imp_12JJTV5
   (EX_MEM_RegWrite,
    EX_MEM_RegisterRd,
    EX_MEM_memToReg,
    ID_EX_RegisterRs,
    ID_EX_RegisterRt,
    MEM_WB_RegWrite,
    MEM_WB_RegisterRd,
    in0,
    in1,
    in2,
    in3,
    muxOut,
    muxOut1,
    regData1,
    regData2,
    regRdAddr1,
    regRdAddr2,
    regRdData1,
    regRdData2,
    regWrData);
  input EX_MEM_RegWrite;
  input [4:0]EX_MEM_RegisterRd;
  input EX_MEM_memToReg;
  input [4:0]ID_EX_RegisterRs;
  input [4:0]ID_EX_RegisterRt;
  input MEM_WB_RegWrite;
  input [4:0]MEM_WB_RegisterRd;
  input [31:0]in0;
  input [31:0]in1;
  input [31:0]in2;
  input [31:0]in3;
  output [31:0]muxOut;
  output [31:0]muxOut1;
  output [31:0]regData1;
  output [31:0]regData2;
  input [4:0]regRdAddr1;
  input [4:0]regRdAddr2;
  input [31:0]regRdData1;
  input [31:0]regRdData2;
  input [31:0]regWrData;

  wire EX_MEM_RegWrite_1;
  wire [4:0]EX_MEM_RegisterRd_1;
  wire EX_MEM_memToReg_1;
  wire [1:0]FU_0_ForwardA;
  wire [1:0]FU_0_ForwardB;
  wire [4:0]ID_EX_RegisterRs_1;
  wire [4:0]ID_EX_RegisterRt_1;
  wire MEM_WB_RegWrite_1;
  wire [4:0]MEM_WB_RegisterRd_1;
  wire [31:0]in0_1;
  wire [31:0]in1_1;
  wire [31:0]in2_1;
  wire [31:0]in3_1;
  wire [31:0]mux2_0_muxOut;
  wire [31:0]mux2_1_muxOut;
  wire [31:0]regFileFW_0_regData1;
  wire [31:0]regFileFW_0_regData2;
  wire [4:0]regRdAddr1_1;
  wire [4:0]regRdAddr2_1;
  wire [31:0]regRdData1_1;
  wire [31:0]regRdData2_1;
  wire [31:0]regWrData_1;

  assign EX_MEM_RegWrite_1 = EX_MEM_RegWrite;
  assign EX_MEM_RegisterRd_1 = EX_MEM_RegisterRd[4:0];
  assign EX_MEM_memToReg_1 = EX_MEM_memToReg;
  assign ID_EX_RegisterRs_1 = ID_EX_RegisterRs[4:0];
  assign ID_EX_RegisterRt_1 = ID_EX_RegisterRt[4:0];
  assign MEM_WB_RegWrite_1 = MEM_WB_RegWrite;
  assign MEM_WB_RegisterRd_1 = MEM_WB_RegisterRd[4:0];
  assign in0_1 = in0[31:0];
  assign in1_1 = in1[31:0];
  assign in2_1 = in2[31:0];
  assign in3_1 = in3[31:0];
  assign muxOut[31:0] = mux2_1_muxOut;
  assign muxOut1[31:0] = mux2_0_muxOut;
  assign regData1[31:0] = regFileFW_0_regData1;
  assign regData2[31:0] = regFileFW_0_regData2;
  assign regRdAddr1_1 = regRdAddr1[4:0];
  assign regRdAddr2_1 = regRdAddr2[4:0];
  assign regRdData1_1 = regRdData1[31:0];
  assign regRdData2_1 = regRdData2[31:0];
  assign regWrData_1 = regWrData[31:0];
  mips_FU_0_0 FU_0
       (.EX_MEM_RegWrite(EX_MEM_RegWrite_1),
        .EX_MEM_RegisterRd(EX_MEM_RegisterRd_1),
        .EX_MEM_memToReg(EX_MEM_memToReg_1),
        .ForwardA(FU_0_ForwardA),
        .ForwardB(FU_0_ForwardB),
        .ID_EX_RegisterRs(ID_EX_RegisterRs_1),
        .ID_EX_RegisterRt(ID_EX_RegisterRt_1),
        .MEM_WB_RegWrite(MEM_WB_RegWrite_1),
        .MEM_WB_RegisterRd(MEM_WB_RegisterRd_1));
  mips_mux2_0_0 mux2_0
       (.ctrl(FU_0_ForwardA),
        .in0(in3_1),
        .in1(in1_1),
        .in2(in2_1),
        .in3(regWrData_1),
        .muxOut(mux2_0_muxOut));
  mips_mux2_1_0 mux2_1
       (.ctrl(FU_0_ForwardB),
        .in0(in0_1),
        .in1(in1_1),
        .in2(in2_1),
        .in3(regWrData_1),
        .muxOut(mux2_1_muxOut));
  mips_regFileFW_0_0 regFileFW_0
       (.regData1(regFileFW_0_regData1),
        .regData2(regFileFW_0_regData2),
        .regRdAddr1(regRdAddr1_1),
        .regRdAddr2(regRdAddr2_1),
        .regRdData1(regRdData1_1),
        .regRdData2(regRdData2_1),
        .regWrAddr(MEM_WB_RegisterRd_1),
        .regWrData(regWrData_1),
        .regWrEn(MEM_WB_RegWrite_1));
endmodule

module EX_MEM_imp_1V24RCY
   (D,
    D1,
    D2,
    D3,
    D4,
    D5,
    Q,
    Q1,
    Q2,
    Q3,
    Q4,
    Q5,
    in_clock);
  input [31:0]D;
  input [31:0]D1;
  input [4:0]D2;
  input [0:0]D3;
  input [0:0]D4;
  input [0:0]D5;
  output [31:0]Q;
  output [31:0]Q1;
  output [4:0]Q2;
  output [0:0]Q3;
  output [0:0]Q4;
  output [0:0]Q5;
  input in_clock;

  wire [4:0]D2_1;
  wire [0:0]D3_1;
  wire [0:0]D4_1;
  wire [0:0]D5_1;
  wire [31:0]alu_0_zeroFlag;
  wire i_clk_0_1;
  wire [31:0]pipeline_0_Q2;
  wire [31:0]pipeline_1_Q1;
  wire [31:0]pipeline_1_Q2;
  wire [4:0]pipeline_2_Q;
  wire [0:0]pipeline_3_Q;
  wire [0:0]pipeline_4_Q;
  wire [0:0]pipeline_5_Q;
  wire [0:0]xlconstant_0_dout;

  assign D2_1 = D2[4:0];
  assign D3_1 = D3[0];
  assign D4_1 = D4[0];
  assign D5_1 = D5[0];
  assign Q[31:0] = pipeline_0_Q2;
  assign Q1[31:0] = pipeline_1_Q2;
  assign Q2[4:0] = pipeline_2_Q;
  assign Q3[0] = pipeline_3_Q;
  assign Q4[0] = pipeline_4_Q;
  assign Q5[0] = pipeline_5_Q;
  assign alu_0_zeroFlag = D[31:0];
  assign i_clk_0_1 = in_clock;
  assign pipeline_1_Q1 = D1[31:0];
  mips_pipeline_0_2 pipeline_0
       (.D(alu_0_zeroFlag),
        .En(xlconstant_0_dout),
        .Q(pipeline_0_Q2),
        .clk(i_clk_0_1));
  mips_pipeline_1_2 pipeline_1
       (.D(pipeline_1_Q1),
        .En(xlconstant_0_dout),
        .Q(pipeline_1_Q2),
        .clk(i_clk_0_1));
  mips_pipeline_2_3 pipeline_2
       (.D(D2_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_2_Q),
        .clk(i_clk_0_1));
  mips_pipeline_3_1 pipeline_3
       (.D(D3_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_3_Q),
        .clk(i_clk_0_1));
  mips_pipeline_4_0 pipeline_4
       (.D(D4_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_4_Q),
        .clk(i_clk_0_1));
  mips_pipeline_5_1 pipeline_5
       (.D(D5_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_5_Q),
        .clk(i_clk_0_1));
  mips_xlconstant_0_4 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule

module ID_EX_imp_SWED4A
   (D,
    D1,
    D10,
    D11,
    D12,
    D13,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    D8,
    D9,
    Q,
    Q1,
    Q10,
    Q11,
    Q12,
    Q13,
    Q2,
    Q3,
    Q4,
    Q5,
    Q6,
    Q7,
    Q8,
    Q9,
    in_clock);
  input [31:0]D;
  input [31:0]D1;
  input [0:0]D10;
  input [0:0]D11;
  input [0:0]D12;
  input [4:0]D13;
  input [31:0]D2;
  input [31:0]D3;
  input [4:0]D4;
  input [0:0]D5;
  input [0:0]D6;
  input [2:0]D7;
  input [4:0]D8;
  input [0:0]D9;
  output [31:0]Q;
  output [31:0]Q1;
  output [0:0]Q10;
  output [0:0]Q11;
  output [0:0]Q12;
  output [4:0]Q13;
  output [31:0]Q2;
  output [31:0]Q3;
  output [4:0]Q4;
  output [0:0]Q5;
  output [0:0]Q6;
  output [2:0]Q7;
  output [4:0]Q8;
  output [0:0]Q9;
  input in_clock;

  wire [0:0]D10_1;
  wire [0:0]D11_1;
  wire [0:0]D12_1;
  wire [4:0]D13_1;
  wire [4:0]D4_1;
  wire [0:0]D5_1;
  wire [0:0]D6_1;
  wire [2:0]D7_1;
  wire [4:0]D8_1;
  wire [0:0]D9_1;
  wire [31:0]RegFile_0_regRdData1;
  wire [31:0]RegFile_0_regRdData2;
  wire i_clk_0_1;
  wire [31:0]pipeline_0_Q1;
  wire [0:0]pipeline_10_Q;
  wire [0:0]pipeline_11_Q;
  wire [0:0]pipeline_12_Q;
  wire [4:0]pipeline_13_Q;
  wire [31:0]pipeline_1_Q;
  wire [31:0]pipeline_1_Q1;
  wire [31:0]pipeline_2_Q;
  wire [31:0]pipeline_3_Q;
  wire [4:0]pipeline_4_Q;
  wire [0:0]pipeline_5_Q;
  wire [0:0]pipeline_6_Q;
  wire [2:0]pipeline_7_Q;
  wire [4:0]pipeline_8_Q;
  wire [0:0]pipeline_9_Q;
  wire [31:0]signExtern_0_outData;
  wire [0:0]xlconstant_0_dout;

  assign D10_1 = D10[0];
  assign D11_1 = D11[0];
  assign D12_1 = D12[0];
  assign D13_1 = D13[4:0];
  assign D4_1 = D4[4:0];
  assign D5_1 = D5[0];
  assign D6_1 = D6[0];
  assign D7_1 = D7[2:0];
  assign D8_1 = D8[4:0];
  assign D9_1 = D9[0];
  assign Q[31:0] = pipeline_0_Q1;
  assign Q1[31:0] = pipeline_2_Q;
  assign Q10[0] = pipeline_10_Q;
  assign Q11[0] = pipeline_11_Q;
  assign Q12[0] = pipeline_12_Q;
  assign Q13[4:0] = pipeline_13_Q;
  assign Q2[31:0] = pipeline_3_Q;
  assign Q3[31:0] = pipeline_1_Q1;
  assign Q4[4:0] = pipeline_4_Q;
  assign Q5[0] = pipeline_5_Q;
  assign Q6[0] = pipeline_6_Q;
  assign Q7[2:0] = pipeline_7_Q;
  assign Q8[4:0] = pipeline_8_Q;
  assign Q9[0] = pipeline_9_Q;
  assign RegFile_0_regRdData1 = D[31:0];
  assign RegFile_0_regRdData2 = D3[31:0];
  assign i_clk_0_1 = in_clock;
  assign pipeline_1_Q = D2[31:0];
  assign signExtern_0_outData = D1[31:0];
  mips_pipeline_0_1 pipeline_0
       (.D(RegFile_0_regRdData1),
        .En(xlconstant_0_dout),
        .Q(pipeline_0_Q1),
        .clk(i_clk_0_1));
  mips_pipeline_1_1 pipeline_1
       (.D(RegFile_0_regRdData2),
        .En(xlconstant_0_dout),
        .Q(pipeline_1_Q1),
        .clk(i_clk_0_1));
  mips_pipeline_10_0 pipeline_10
       (.D(D10_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_10_Q),
        .clk(i_clk_0_1));
  mips_pipeline_11_0 pipeline_11
       (.D(D11_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_11_Q),
        .clk(i_clk_0_1));
  mips_pipeline_12_0 pipeline_12
       (.D(D12_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_12_Q),
        .clk(i_clk_0_1));
  mips_pipeline_13_0 pipeline_13
       (.D(D13_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_13_Q),
        .clk(i_clk_0_1));
  mips_pipeline_2_0 pipeline_2
       (.D(signExtern_0_outData),
        .En(xlconstant_0_dout),
        .Q(pipeline_2_Q),
        .clk(i_clk_0_1));
  mips_pipeline_3_0 pipeline_3
       (.D(pipeline_1_Q),
        .En(xlconstant_0_dout),
        .Q(pipeline_3_Q),
        .clk(i_clk_0_1));
  mips_pipeline_4_2 pipeline_4
       (.D(D4_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_4_Q),
        .clk(i_clk_0_1));
  mips_pipeline_5_0 pipeline_5
       (.D(D5_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_5_Q),
        .clk(i_clk_0_1));
  mips_pipeline_6_0 pipeline_6
       (.D(D6_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_6_Q),
        .clk(i_clk_0_1));
  mips_pipeline_7_0 pipeline_7
       (.D(D7_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_7_Q),
        .clk(i_clk_0_1));
  mips_pipeline_8_2 pipeline_8
       (.D(D8_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_8_Q),
        .clk(i_clk_0_1));
  mips_pipeline_9_0 pipeline_9
       (.D(D9_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_9_Q),
        .clk(i_clk_0_1));
  mips_xlconstant_0_3 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule

module IF_ID_imp_1X1XVU7
   (D,
    D1,
    D2,
    D3,
    D5,
    D6,
    D7,
    D8,
    En,
    Q,
    Q1,
    Q2,
    Q3,
    Q4,
    Q6,
    Q7,
    Q8,
    Q9,
    in_clock,
    instruction);
  input [31:0]D;
  input [0:0]D1;
  input [0:0]D2;
  input [0:0]D3;
  input [2:0]D5;
  input [0:0]D6;
  input [0:0]D7;
  input [0:0]D8;
  input En;
  output [31:0]Q;
  output [31:0]Q1;
  output [0:0]Q2;
  output [0:0]Q3;
  output [0:0]Q4;
  output [2:0]Q6;
  output [0:0]Q7;
  output [0:0]Q8;
  output [0:0]Q9;
  input in_clock;
  input [31:0]instruction;

  wire [0:0]D1_1;
  wire [0:0]D2_1;
  wire [0:0]D3_1;
  wire [2:0]D5_1;
  wire [0:0]D6_1;
  wire [0:0]D7_1;
  wire [0:0]D8_1;
  wire En_1;
  wire [31:0]adder_0_adderOut;
  wire i_clk_0_1;
  wire [31:0]instructionMemory_0_instruction;
  wire [31:0]pipeline_0_Q;
  wire [31:0]pipeline_1_Q;
  wire [0:0]pipeline_2_Q;
  wire [0:0]pipeline_3_Q;
  wire [0:0]pipeline_4_Q;
  wire [2:0]pipeline_6_Q;
  wire [0:0]pipeline_7_Q;
  wire [0:0]pipeline_8_Q;
  wire [0:0]pipeline_9_Q;

  assign D1_1 = D1[0];
  assign D2_1 = D2[0];
  assign D3_1 = D3[0];
  assign D5_1 = D5[2:0];
  assign D6_1 = D6[0];
  assign D7_1 = D7[0];
  assign D8_1 = D8[0];
  assign En_1 = En;
  assign Q[31:0] = pipeline_0_Q;
  assign Q1[31:0] = pipeline_1_Q;
  assign Q2[0] = pipeline_2_Q;
  assign Q3[0] = pipeline_3_Q;
  assign Q4[0] = pipeline_4_Q;
  assign Q6[2:0] = pipeline_6_Q;
  assign Q7[0] = pipeline_7_Q;
  assign Q8[0] = pipeline_8_Q;
  assign Q9[0] = pipeline_9_Q;
  assign adder_0_adderOut = D[31:0];
  assign i_clk_0_1 = in_clock;
  assign instructionMemory_0_instruction = instruction[31:0];
  mips_pipeline_0_0 pipeline_0
       (.D(instructionMemory_0_instruction),
        .En(En_1),
        .Q(pipeline_0_Q),
        .clk(i_clk_0_1));
  mips_pipeline_1_0 pipeline_1
       (.D(adder_0_adderOut),
        .En(En_1),
        .Q(pipeline_1_Q),
        .clk(i_clk_0_1));
  mips_pipeline_2_2 pipeline_2
       (.D(D1_1),
        .En(En_1),
        .Q(pipeline_2_Q),
        .clk(i_clk_0_1));
  mips_pipeline_3_3 pipeline_3
       (.D(D2_1),
        .En(En_1),
        .Q(pipeline_3_Q),
        .clk(i_clk_0_1));
  mips_pipeline_4_1 pipeline_4
       (.D(D3_1),
        .En(En_1),
        .Q(pipeline_4_Q),
        .clk(i_clk_0_1));
  mips_pipeline_6_1 pipeline_6
       (.D(D5_1),
        .En(En_1),
        .Q(pipeline_6_Q),
        .clk(i_clk_0_1));
  mips_pipeline_7_1 pipeline_7
       (.D(D6_1),
        .En(En_1),
        .Q(pipeline_7_Q),
        .clk(i_clk_0_1));
  mips_pipeline_8_1 pipeline_8
       (.D(D7_1),
        .En(En_1),
        .Q(pipeline_8_Q),
        .clk(i_clk_0_1));
  mips_pipeline_9_1 pipeline_9
       (.D(D8_1),
        .En(En_1),
        .Q(pipeline_9_Q),
        .clk(i_clk_0_1));
endmodule

module Jump_Block_imp_GZ52XL
   (Din,
    Din1,
    address_jump);
  input [31:0]Din;
  input [31:0]Din1;
  output [31:0]address_jump;

  wire [31:0]concat_0_address_jump;
  wire [31:0]pipeline_0_Q;
  wire [31:0]pipeline_1_Q;
  wire [3:0]xlslice_4_Dout;
  wire [25:0]xlslice_5_Dout;

  assign address_jump[31:0] = concat_0_address_jump;
  assign pipeline_0_Q = Din[31:0];
  assign pipeline_1_Q = Din1[31:0];
  mips_concat_0_0 concat_0
       (.address_jump(concat_0_address_jump),
        .instrn_25_to_0(xlslice_5_Dout),
        .pc_plus_four(xlslice_4_Dout));
  mips_xlslice_0_1 xlslice_4
       (.Din(pipeline_1_Q),
        .Dout(xlslice_4_Dout));
  mips_xlslice_4_0 xlslice_5
       (.Din(pipeline_0_Q),
        .Dout(xlslice_5_Dout));
endmodule

module MEM_WB_imp_1GJVWYO
   (D,
    D1,
    D2,
    D3,
    D4,
    Q,
    Q1,
    Q2,
    Q3,
    Q4,
    in_clock);
  input [31:0]D;
  input [31:0]D1;
  input [0:0]D2;
  input [0:0]D3;
  input [4:0]D4;
  output [31:0]Q;
  output [31:0]Q1;
  output [0:0]Q2;
  output [0:0]Q3;
  output [4:0]Q4;
  input in_clock;

  wire [0:0]D2_1;
  wire [0:0]D3_1;
  wire [4:0]D4_1;
  wire [31:0]dataMemory_0_readData;
  wire i_clk_0_1;
  wire [31:0]pipeline_0_Q2;
  wire [31:0]pipeline_0_Q3;
  wire [31:0]pipeline_1_Q3;
  wire [0:0]pipeline_2_Q;
  wire [0:0]pipeline_3_Q;
  wire [4:0]pipeline_4_Q;
  wire [0:0]xlconstant_0_dout;

  assign D2_1 = D2[0];
  assign D3_1 = D3[0];
  assign D4_1 = D4[4:0];
  assign Q[31:0] = pipeline_0_Q3;
  assign Q1[31:0] = pipeline_1_Q3;
  assign Q2[0] = pipeline_2_Q;
  assign Q3[0] = pipeline_3_Q;
  assign Q4[4:0] = pipeline_4_Q;
  assign dataMemory_0_readData = D1[31:0];
  assign i_clk_0_1 = in_clock;
  assign pipeline_0_Q2 = D[31:0];
  mips_pipeline_0_5 pipeline_0
       (.D(pipeline_0_Q2),
        .En(xlconstant_0_dout),
        .Q(pipeline_0_Q3),
        .clk(i_clk_0_1));
  mips_pipeline_1_3 pipeline_1
       (.D(dataMemory_0_readData),
        .En(xlconstant_0_dout),
        .Q(pipeline_1_Q3),
        .clk(i_clk_0_1));
  mips_pipeline_2_1 pipeline_2
       (.D(D2_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_2_Q),
        .clk(i_clk_0_1));
  mips_pipeline_3_2 pipeline_3
       (.D(D3_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_3_Q),
        .clk(i_clk_0_1));
  mips_pipeline_4_3 pipeline_4
       (.D(D4_1),
        .En(xlconstant_0_dout),
        .Q(pipeline_4_Q),
        .clk(i_clk_0_1));
  mips_xlconstant_0_5 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule

module PCplus4Adder_imp_1AL2EPE
   (adderOut,
    op1);
  output [31:0]adderOut;
  input [31:0]op1;

  wire [31:0]adder_0_adderOut;
  wire [31:0]constantFour_dout;
  wire [31:0]programCounter_0_pcOut;

  assign adderOut[31:0] = adder_0_adderOut;
  assign programCounter_0_pcOut = op1[31:0];
  mips_adder_0_0 adder_0
       (.adderOut(adder_0_adderOut),
        .op1(programCounter_0_pcOut),
        .op2(constantFour_dout));
  mips_xlconstant_0_0 constantFour
       (.dout(constantFour_dout));
endmodule

module instructionSlice_imp_1GMHSSO
   (Din,
    Dout,
    Dout1,
    Dout2);
  input [31:0]Din;
  output [4:0]Dout;
  output [4:0]Dout1;
  output [4:0]Dout2;

  wire [31:0]pipeline_0_Q;
  wire [4:0]xlslice_0_Dout;
  wire [4:0]xlslice_1_Dout;
  wire [4:0]xlslice_2_Dout;

  assign Dout[4:0] = xlslice_0_Dout;
  assign Dout1[4:0] = xlslice_1_Dout;
  assign Dout2[4:0] = xlslice_2_Dout;
  assign pipeline_0_Q = Din[31:0];
  mips_xlslice_0_0 xlslice_0
       (.Din(pipeline_0_Q),
        .Dout(xlslice_0_Dout));
  mips_xlslice_1_0 xlslice_1
       (.Din(pipeline_0_Q),
        .Dout(xlslice_1_Dout));
  mips_xlslice_2_0 xlslice_2
       (.Din(pipeline_0_Q),
        .Dout(xlslice_2_Dout));
endmodule

(* CORE_GENERATION_INFO = "mips,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mips,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=75,numReposBlks=66,numNonXlnxBlks=0,numHierBlks=9,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=56,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=2,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "mips.hwdef" *) 
module mips
   (in_clock);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IN_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IN_CLOCK, CLK_DOMAIN mips_in_clock, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input in_clock;

  wire [0:0]D10_1;
  wire [0:0]D11_1;
  wire [31:0]D3_1;
  wire [0:0]D5_1;
  wire [0:0]D6_1;
  wire [2:0]D7_1;
  wire [0:0]D9_1;
  wire [31:0]D_1;
  wire [31:0]DataHazardUnit_muxOut1;
  wire [4:0]EX_MEM_Q2;
  wire [0:0]EX_MEM_Q3;
  wire [0:0]EX_MEM_Q4;
  wire [0:0]EX_MEM_Q5;
  wire [31:0]ID_EX_Q;
  wire [0:0]ID_EX_Q10;
  wire [0:0]ID_EX_Q11;
  wire [0:0]ID_EX_Q12;
  wire [4:0]ID_EX_Q13;
  wire [31:0]ID_EX_Q3;
  wire [4:0]ID_EX_Q4;
  wire [0:0]ID_EX_Q5;
  wire [0:0]ID_EX_Q6;
  wire [2:0]ID_EX_Q7;
  wire [4:0]ID_EX_Q8;
  wire [0:0]ID_EX_Q9;
  wire [0:0]IF_ID_Q2;
  wire [31:0]Jump_Block_address_jump;
  wire [0:0]MEM_WB_Q2;
  wire [0:0]MEM_WB_Q3;
  wire [4:0]MEM_WB_Q4;
  wire [31:0]RegFile_0_regRdData1;
  wire [31:0]RegFile_0_regRdData2;
  wire [31:0]adder_0_adderOut;
  wire [31:0]adder_1_adderOut;
  wire [31:0]alu_0_zeroFlag;
  wire alu_0_zeroFlag1;
  wire andGate_0_branchSignal;
  wire [2:0]controlLogic_0_aluOp;
  wire controlLogic_0_aluSrc;
  wire controlLogic_0_jmpdetect;
  wire controlLogic_0_memToReg;
  wire controlLogic_0_memWrite;
  wire controlLogic_0_pcSrc;
  wire controlLogic_0_regDst;
  wire controlLogic_0_regWrite;
  wire ctrlHDU_0_IF_ID_Write;
  wire ctrlHDU_0_PCSrcOut;
  wire ctrlHDU_0_PCWrite;
  wire [31:0]dataMemory_0_readData;
  wire i_clk_0_1;
  wire [31:0]instructionMemory_0_instruction;
  wire [4:0]instructionSlice_Dout2;
  wire [4:0]mux_0_muxOut;
  wire [31:0]mux_1_muxOut;
  wire [31:0]mux_2_muxOut;
  wire [31:0]mux_3_muxOut;
  wire [31:0]mux_4_muxOut;
  wire [31:0]pipeline_0_Q;
  wire [31:0]pipeline_0_Q2;
  wire [31:0]pipeline_0_Q3;
  wire [31:0]pipeline_1_Q;
  wire [31:0]pipeline_1_Q1;
  wire [31:0]pipeline_1_Q2;
  wire [31:0]pipeline_1_Q3;
  wire [31:0]pipeline_2_Q;
  wire [31:0]pipeline_3_Q;
  wire [31:0]programCounter_0_pcOut;
  wire [31:0]shiftLeft_0_outData;
  wire [31:0]signExtern_0_outData;
  wire [4:0]xlslice_0_Dout;
  wire [4:0]xlslice_1_Dout;

  assign i_clk_0_1 = in_clock;
  DataHazardUnit_imp_12JJTV5 DataHazardUnit
       (.EX_MEM_RegWrite(EX_MEM_Q3),
        .EX_MEM_RegisterRd(EX_MEM_Q2),
        .EX_MEM_memToReg(EX_MEM_Q5),
        .ID_EX_RegisterRs(ID_EX_Q13),
        .ID_EX_RegisterRt(ID_EX_Q4),
        .MEM_WB_RegWrite(MEM_WB_Q2),
        .MEM_WB_RegisterRd(MEM_WB_Q4),
        .in0(ID_EX_Q3),
        .in1(pipeline_0_Q2),
        .in2(dataMemory_0_readData),
        .in3(ID_EX_Q),
        .muxOut(pipeline_1_Q1),
        .muxOut1(DataHazardUnit_muxOut1),
        .regData1(D_1),
        .regData2(D3_1),
        .regRdAddr1(xlslice_0_Dout),
        .regRdAddr2(xlslice_1_Dout),
        .regRdData1(RegFile_0_regRdData1),
        .regRdData2(RegFile_0_regRdData2),
        .regWrData(mux_2_muxOut));
  EX_MEM_imp_1V24RCY EX_MEM
       (.D(alu_0_zeroFlag),
        .D1(pipeline_1_Q1),
        .D2(mux_0_muxOut),
        .D3(ID_EX_Q5),
        .D4(ID_EX_Q9),
        .D5(ID_EX_Q10),
        .Q(pipeline_0_Q2),
        .Q1(pipeline_1_Q2),
        .Q2(EX_MEM_Q2),
        .Q3(EX_MEM_Q3),
        .Q4(EX_MEM_Q4),
        .Q5(EX_MEM_Q5),
        .in_clock(i_clk_0_1));
  ID_EX_imp_SWED4A ID_EX
       (.D(D_1),
        .D1(signExtern_0_outData),
        .D10(D10_1),
        .D11(ctrlHDU_0_PCSrcOut),
        .D12(IF_ID_Q2),
        .D13(xlslice_0_Dout),
        .D2(pipeline_1_Q),
        .D3(D3_1),
        .D4(xlslice_1_Dout),
        .D5(D5_1),
        .D6(D6_1),
        .D7(D7_1),
        .D8(instructionSlice_Dout2),
        .D9(D9_1),
        .Q(ID_EX_Q),
        .Q1(pipeline_2_Q),
        .Q10(ID_EX_Q10),
        .Q11(ID_EX_Q11),
        .Q12(ID_EX_Q12),
        .Q13(ID_EX_Q13),
        .Q2(pipeline_3_Q),
        .Q3(ID_EX_Q3),
        .Q4(ID_EX_Q4),
        .Q5(ID_EX_Q5),
        .Q6(ID_EX_Q6),
        .Q7(ID_EX_Q7),
        .Q8(ID_EX_Q8),
        .Q9(ID_EX_Q9),
        .in_clock(i_clk_0_1));
  IF_ID_imp_1X1XVU7 IF_ID
       (.D(adder_0_adderOut),
        .D1(controlLogic_0_regDst),
        .D2(controlLogic_0_regWrite),
        .D3(controlLogic_0_aluSrc),
        .D5(controlLogic_0_aluOp),
        .D6(controlLogic_0_memWrite),
        .D7(controlLogic_0_memToReg),
        .D8(controlLogic_0_pcSrc),
        .En(ctrlHDU_0_IF_ID_Write),
        .Q(pipeline_0_Q),
        .Q1(pipeline_1_Q),
        .Q2(IF_ID_Q2),
        .Q3(D5_1),
        .Q4(D6_1),
        .Q6(D7_1),
        .Q7(D9_1),
        .Q8(D10_1),
        .Q9(D11_1),
        .in_clock(i_clk_0_1),
        .instruction(instructionMemory_0_instruction));
  Jump_Block_imp_GZ52XL Jump_Block
       (.Din(instructionMemory_0_instruction),
        .Din1(adder_0_adderOut),
        .address_jump(Jump_Block_address_jump));
  MEM_WB_imp_1GJVWYO MEM_WB
       (.D(pipeline_0_Q2),
        .D1(dataMemory_0_readData),
        .D2(EX_MEM_Q3),
        .D3(EX_MEM_Q5),
        .D4(EX_MEM_Q2),
        .Q(pipeline_0_Q3),
        .Q1(pipeline_1_Q3),
        .Q2(MEM_WB_Q2),
        .Q3(MEM_WB_Q3),
        .Q4(MEM_WB_Q4),
        .in_clock(i_clk_0_1));
  PCplus4Adder_imp_1AL2EPE PCplus4Adder
       (.adderOut(adder_0_adderOut),
        .op1(programCounter_0_pcOut));
  mips_RegFile_0_0 RegFile_0
       (.i_clk(i_clk_0_1),
        .regRdAddr1(xlslice_0_Dout),
        .regRdAddr2(xlslice_1_Dout),
        .regRdData1(RegFile_0_regRdData1),
        .regRdData2(RegFile_0_regRdData2),
        .regWrAddr(MEM_WB_Q4),
        .regWrData(mux_2_muxOut),
        .regWrEn(MEM_WB_Q2));
  mips_adder_1_0 adder_1
       (.adderOut(adder_1_adderOut),
        .op1(shiftLeft_0_outData),
        .op2(pipeline_3_Q));
  mips_alu_0_0 alu_0
       (.aluOp(ID_EX_Q7),
        .aluOut(alu_0_zeroFlag),
        .op1(DataHazardUnit_muxOut1),
        .op2(mux_1_muxOut),
        .zeroFlag(alu_0_zeroFlag1));
  mips_andGate_0_0 andGate_0
       (.ZF(alu_0_zeroFlag1),
        .branchSignal(andGate_0_branchSignal),
        .pcSrc(ID_EX_Q11));
  mips_controlLogic_0_0 controlLogic_0
       (.aluOp(controlLogic_0_aluOp),
        .aluSrc(controlLogic_0_aluSrc),
        .instruction(instructionMemory_0_instruction),
        .jmpdetect(controlLogic_0_jmpdetect),
        .memToReg(controlLogic_0_memToReg),
        .memWrite(controlLogic_0_memWrite),
        .pcSrc(controlLogic_0_pcSrc),
        .regDst(controlLogic_0_regDst),
        .regWrite(controlLogic_0_regWrite));
  mips_ctrlHDU_0_0 ctrlHDU_0
       (.IF_ID_PCSrc(D11_1),
        .IF_ID_Write(ctrlHDU_0_IF_ID_Write),
        .PCSrcOut(ctrlHDU_0_PCSrcOut),
        .PCWrite(ctrlHDU_0_PCWrite),
        .branch(andGate_0_branchSignal),
        .clk(i_clk_0_1));
  mips_dataMemory_0_0 dataMemory_0
       (.i_clk(i_clk_0_1),
        .memWrite(EX_MEM_Q4),
        .readAddress(pipeline_0_Q2),
        .readData(dataMemory_0_readData),
        .writeAddress(pipeline_0_Q2),
        .writeData(pipeline_1_Q2));
  mips_instructionMemory_0_0 instructionMemory_0
       (.addressBus(programCounter_0_pcOut),
        .instruction(instructionMemory_0_instruction));
  instructionSlice_imp_1GMHSSO instructionSlice
       (.Din(pipeline_0_Q),
        .Dout(xlslice_0_Dout),
        .Dout1(xlslice_1_Dout),
        .Dout2(instructionSlice_Dout2));
  mips_mux_0_0 mux_0
       (.ctrl(ID_EX_Q12),
        .in0(ID_EX_Q4),
        .in1(ID_EX_Q8),
        .muxOut(mux_0_muxOut));
  mips_mux_1_0 mux_1
       (.ctrl(ID_EX_Q6),
        .in0(pipeline_1_Q1),
        .in1(pipeline_2_Q),
        .muxOut(mux_1_muxOut));
  mips_mux_2_0 mux_2
       (.ctrl(MEM_WB_Q3),
        .in0(pipeline_0_Q3),
        .in1(pipeline_1_Q3),
        .muxOut(mux_2_muxOut));
  mips_mux_3_0 mux_3
       (.ctrl(controlLogic_0_jmpdetect),
        .in0(adder_0_adderOut),
        .in1(Jump_Block_address_jump),
        .muxOut(mux_3_muxOut));
  mips_mux_0_1 mux_4
       (.ctrl(andGate_0_branchSignal),
        .in0(mux_3_muxOut),
        .in1(adder_1_adderOut),
        .muxOut(mux_4_muxOut));
  mips_programCounter_0_0 programCounter_0
       (.PCEn(ctrlHDU_0_PCWrite),
        .i_clk(i_clk_0_1),
        .pcIn(mux_4_muxOut),
        .pcOut(programCounter_0_pcOut));
  mips_shiftLeft_0_0 shiftLeft_0
       (.inData(pipeline_2_Q),
        .outData(shiftLeft_0_outData));
  slice_and_Extend_imp_1WA3XA slice_and_Extend
       (.Din(pipeline_0_Q),
        .outData(signExtern_0_outData));
endmodule

module slice_and_Extend_imp_1WA3XA
   (Din,
    outData);
  input [31:0]Din;
  output [31:0]outData;

  wire [31:0]pipeline_0_Q;
  wire [31:0]signExtern_0_outData;
  wire [15:0]xlslice_3_Dout;

  assign outData[31:0] = signExtern_0_outData;
  assign pipeline_0_Q = Din[31:0];
  mips_signExtern_0_0 signExtern_0
       (.inData(xlslice_3_Dout),
        .outData(signExtern_0_outData));
  mips_xlslice_3_0 xlslice_3
       (.Din(pipeline_0_Q),
        .Dout(xlslice_3_Dout));
endmodule
