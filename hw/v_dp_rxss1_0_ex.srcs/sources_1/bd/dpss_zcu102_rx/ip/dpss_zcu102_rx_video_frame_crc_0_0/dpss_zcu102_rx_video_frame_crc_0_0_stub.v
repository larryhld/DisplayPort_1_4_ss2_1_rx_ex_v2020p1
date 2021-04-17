// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:48:11 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_video_frame_crc_0_0/dpss_zcu102_rx_video_frame_crc_0_0_stub.v
// Design      : dpss_zcu102_rx_video_frame_crc_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "video_frame_crc_v1_0_2,Vivado 2020.1" *)
module dpss_zcu102_rx_video_frame_crc_0_0(s_axi_awaddr, s_axi_awprot, s_axi_awvalid, 
  s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, 
  s_axi_bvalid, s_axi_bready, s_axi_araddr, s_axi_arprot, s_axi_arvalid, s_axi_arready, 
  s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready, s_axi_aclk, s_axi_aresetn, 
  vid_in_axis_tdata, vid_in_axis_tuser, vid_in_axis_tlast, vid_in_axis_tvalid, 
  vid_in_axis_tready, vid_in_axis_aclk, vid_in_axis_aresetn, vid_out_axis_tdata, 
  vid_out_axis_tuser, vid_out_axis_tlast, vid_out_axis_tvalid, vid_out_axis_tready)
/* synthesis syn_black_box black_box_pad_pin="s_axi_awaddr[4:0],s_axi_awprot[2:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid,s_axi_wready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_araddr[4:0],s_axi_arprot[2:0],s_axi_arvalid,s_axi_arready,s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid,s_axi_rready,s_axi_aclk,s_axi_aresetn,vid_in_axis_tdata[119:0],vid_in_axis_tuser,vid_in_axis_tlast,vid_in_axis_tvalid,vid_in_axis_tready,vid_in_axis_aclk,vid_in_axis_aresetn,vid_out_axis_tdata[119:0],vid_out_axis_tuser,vid_out_axis_tlast,vid_out_axis_tvalid,vid_out_axis_tready" */;
  input [4:0]s_axi_awaddr;
  input [2:0]s_axi_awprot;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [4:0]s_axi_araddr;
  input [2:0]s_axi_arprot;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [119:0]vid_in_axis_tdata;
  input vid_in_axis_tuser;
  input vid_in_axis_tlast;
  input vid_in_axis_tvalid;
  output vid_in_axis_tready;
  input vid_in_axis_aclk;
  input vid_in_axis_aresetn;
  output [119:0]vid_out_axis_tdata;
  output vid_out_axis_tuser;
  output vid_out_axis_tlast;
  output vid_out_axis_tvalid;
  input vid_out_axis_tready;
endmodule
