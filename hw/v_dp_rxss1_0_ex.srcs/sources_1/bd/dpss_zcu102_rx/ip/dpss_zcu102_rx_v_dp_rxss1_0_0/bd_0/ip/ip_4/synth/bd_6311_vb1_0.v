// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:dp_videoaxi4s_bridge:1.0
// IP Revision: 1

(* X_CORE_INFO = "dp_videoaxi4s_bridge_v1_0_1,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "bd_6311_vb1_0,dp_videoaxi4s_bridge_v1_0_1,{}" *)
(* CORE_GENERATION_INFO = "bd_6311_vb1_0,dp_videoaxi4s_bridge_v1_0_1,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=dp_videoaxi4s_bridge,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_MAX_BPC=10,C_M_AXIS_VIDEO_TDATA_WIDTH=120,C_PPC=4,C_FAMILY=zynquplus,C_UG934_COMPLIANCE=true,C_ENABLE_DSC=false,C_ENABLE_DSC_DUMMY_BYTES_IN_RX=false}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module bd_6311_vb1_0 (
  vid_pixel_clk,
  vid_reset,
  vid_active_video,
  vid_vsync,
  vid_hsync,
  vid_pixel0,
  vid_pixel1,
  vid_pixel2,
  vid_pixel3,
  dp_hres,
  pixel_mode,
  bpc,
  color_format,
  m_axis_aclk,
  m_axis_video_tdata,
  m_axis_video_tlast,
  m_axis_video_tvalid,
  m_axis_video_tready,
  wr_error,
  rd_error,
  m_axis_video_tuser,
  hres_cntr_out,
  vres_cntr_out,
  debug_port
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_pixel_clk, ASSOCIATED_BUSIF dp_vid, ASSOCIATED_RESET vid_reset, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_pixel_clk CLK" *)
input wire vid_pixel_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_reset RST" *)
input wire vid_reset;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_ENABLE" *)
input wire vid_active_video;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_VSYNC" *)
input wire vid_vsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_HSYNC" *)
input wire vid_hsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_PIXEL0" *)
input wire [47 : 0] vid_pixel0;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_PIXEL1" *)
input wire [47 : 0] vid_pixel1;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_PIXEL2" *)
input wire [47 : 0] vid_pixel2;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_vid TX_VID_PIXEL3" *)
input wire [47 : 0] vid_pixel3;
input wire [15 : 0] dp_hres;
input wire [2 : 0] pixel_mode;
input wire [2 : 0] bpc;
input wire [2 : 0] color_format;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_aclk, ASSOCIATED_BUSIF m_axis_video, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m_axis_aclk CLK" *)
input wire m_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TDATA" *)
output wire [119 : 0] m_axis_video_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TLAST" *)
output wire m_axis_video_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TVALID" *)
output wire m_axis_video_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TREADY" *)
input wire m_axis_video_tready;
output wire wr_error;
output wire rd_error;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_video, TDATA_NUM_BYTES 15, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 300000000, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TUSER" *)
output wire [0 : 0] m_axis_video_tuser;
output wire [15 : 0] hres_cntr_out;
output wire [15 : 0] vres_cntr_out;
output wire [4 : 0] debug_port;

  dp_videoaxi4s_bridge_v1_0_1 #(
    .C_MAX_BPC(10),
    .C_M_AXIS_VIDEO_TDATA_WIDTH(120),
    .C_PPC(4),
    .C_FAMILY("zynquplus"),
    .C_UG934_COMPLIANCE(1'B1),
    .C_ENABLE_DSC(1'B0),
    .C_ENABLE_DSC_DUMMY_BYTES_IN_RX(1'B0)
  ) inst (
    .vid_pixel_clk(vid_pixel_clk),
    .vid_reset(vid_reset),
    .vid_active_video(vid_active_video),
    .vid_valid_per_pixel(12'B0),
    .vid_last(1'B0),
    .vid_vsync(vid_vsync),
    .vid_hsync(vid_hsync),
    .vid_pixel0(vid_pixel0),
    .vid_pixel1(vid_pixel1),
    .vid_pixel2(vid_pixel2),
    .vid_pixel3(vid_pixel3),
    .enable_dsc(1'B0),
    .num_active_lanes(3'B0),
    .dp_hres(dp_hres),
    .pixel_mode(pixel_mode),
    .bpc(bpc),
    .color_format(color_format),
    .m_axis_aclk(m_axis_aclk),
    .m_axis_video_tdata(m_axis_video_tdata),
    .m_axis_video_tlast(m_axis_video_tlast),
    .m_axis_video_tvalid(m_axis_video_tvalid),
    .m_axis_video_tready(m_axis_video_tready),
    .wr_error(wr_error),
    .rd_error(rd_error),
    .m_axis_video_tuser(m_axis_video_tuser),
    .hres_cntr_out(hres_cntr_out),
    .vres_cntr_out(vres_cntr_out),
    .debug_port(debug_port),
    .dsc_debug_bus_bridge()
  );
endmodule
