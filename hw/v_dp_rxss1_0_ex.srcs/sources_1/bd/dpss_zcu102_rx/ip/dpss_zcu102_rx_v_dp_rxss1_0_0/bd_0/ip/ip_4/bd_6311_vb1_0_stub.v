// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:45:16 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_v_dp_rxss1_0_0/bd_0/ip/ip_4/bd_6311_vb1_0_stub.v
// Design      : bd_6311_vb1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "dp_videoaxi4s_bridge_v1_0_1,Vivado 2020.1" *)
module bd_6311_vb1_0(vid_pixel_clk, vid_reset, vid_active_video, 
  vid_vsync, vid_hsync, vid_pixel0, vid_pixel1, vid_pixel2, vid_pixel3, dp_hres, pixel_mode, bpc, 
  color_format, m_axis_aclk, m_axis_video_tdata, m_axis_video_tlast, m_axis_video_tvalid, 
  m_axis_video_tready, wr_error, rd_error, m_axis_video_tuser, hres_cntr_out, vres_cntr_out, 
  debug_port)
/* synthesis syn_black_box black_box_pad_pin="vid_pixel_clk,vid_reset,vid_active_video,vid_vsync,vid_hsync,vid_pixel0[47:0],vid_pixel1[47:0],vid_pixel2[47:0],vid_pixel3[47:0],dp_hres[15:0],pixel_mode[2:0],bpc[2:0],color_format[2:0],m_axis_aclk,m_axis_video_tdata[119:0],m_axis_video_tlast,m_axis_video_tvalid,m_axis_video_tready,wr_error,rd_error,m_axis_video_tuser[0:0],hres_cntr_out[15:0],vres_cntr_out[15:0],debug_port[4:0]" */;
  input vid_pixel_clk;
  input vid_reset;
  input vid_active_video;
  input vid_vsync;
  input vid_hsync;
  input [47:0]vid_pixel0;
  input [47:0]vid_pixel1;
  input [47:0]vid_pixel2;
  input [47:0]vid_pixel3;
  input [15:0]dp_hres;
  input [2:0]pixel_mode;
  input [2:0]bpc;
  input [2:0]color_format;
  input m_axis_aclk;
  output [119:0]m_axis_video_tdata;
  output m_axis_video_tlast;
  output m_axis_video_tvalid;
  input m_axis_video_tready;
  output wr_error;
  output rd_error;
  output [0:0]m_axis_video_tuser;
  output [15:0]hres_cntr_out;
  output [15:0]vres_cntr_out;
  output [4:0]debug_port;
endmodule
