//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr 28 14:36:23 2022
//Host        : LAPTOP-0HL21Q40 running 64-bit major release  (build 9200)
//Command     : generate_target mips_wrapper.bd
//Design      : mips_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mips_wrapper
   (in_clock);
  input in_clock;

  wire in_clock;

  mips mips_i
       (.in_clock(in_clock));
endmodule
