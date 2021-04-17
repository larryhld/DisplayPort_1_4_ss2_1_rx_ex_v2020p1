//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_b784_wrapper.bd
//Design : bd_b784_wrapper
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_b784_wrapper
   (SLOT_0_AXIS_tdata,
    SLOT_0_AXIS_tid,
    SLOT_0_AXIS_tlast,
    SLOT_0_AXIS_tready,
    SLOT_0_AXIS_tvalid,
    clk,
    resetn);
  input [31:0]SLOT_0_AXIS_tdata;
  input [7:0]SLOT_0_AXIS_tid;
  input SLOT_0_AXIS_tlast;
  input SLOT_0_AXIS_tready;
  input SLOT_0_AXIS_tvalid;
  input clk;
  input resetn;

  wire [31:0]SLOT_0_AXIS_tdata;
  wire [7:0]SLOT_0_AXIS_tid;
  wire SLOT_0_AXIS_tlast;
  wire SLOT_0_AXIS_tready;
  wire SLOT_0_AXIS_tvalid;
  wire clk;
  wire resetn;

  bd_b784 bd_b784_i
       (.SLOT_0_AXIS_tdata(SLOT_0_AXIS_tdata),
        .SLOT_0_AXIS_tid(SLOT_0_AXIS_tid),
        .SLOT_0_AXIS_tlast(SLOT_0_AXIS_tlast),
        .SLOT_0_AXIS_tready(SLOT_0_AXIS_tready),
        .SLOT_0_AXIS_tvalid(SLOT_0_AXIS_tvalid),
        .clk(clk),
        .resetn(resetn));
endmodule
