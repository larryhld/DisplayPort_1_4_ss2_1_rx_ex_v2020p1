// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:46:30 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top dpss_zcu102_rx_util_ds_buf_3_0 -prefix
//               dpss_zcu102_rx_util_ds_buf_3_0_ dpss_zcu102_rx_util_ds_buf_2_0_stub.v
// Design      : dpss_zcu102_rx_util_ds_buf_2_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "util_ds_buf,Vivado 2020.1" *)
module dpss_zcu102_rx_util_ds_buf_3_0(IOBUF_IO_T, IOBUF_IO_I, IOBUF_IO_O, 
  IOBUF_IO_IO)
/* synthesis syn_black_box black_box_pad_pin="IOBUF_IO_T[0:0],IOBUF_IO_I[0:0],IOBUF_IO_O[0:0],IOBUF_IO_IO[0:0]" */;
  input [0:0]IOBUF_IO_T;
  input [0:0]IOBUF_IO_I;
  output [0:0]IOBUF_IO_O;
  inout [0:0]IOBUF_IO_IO;
endmodule
