// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:47:53 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dpss_zcu102_rx_vid_phy_controller_0_0_stub.v
// Design      : dpss_zcu102_rx_vid_phy_controller_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "dpss_zcu102_rx_vid_phy_controller_0_0_top,Vivado 2020.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(mgtrefclk0_in, mgtrefclk1_in, 
  gtnorthrefclk0_in, gtnorthrefclk1_in, gtsouthrefclk0_in, gtsouthrefclk1_in, 
  gtnorthrefclk00_in, gtnorthrefclk01_in, gtnorthrefclk10_in, gtnorthrefclk11_in, 
  gtsouthrefclk00_in, gtsouthrefclk01_in, gtsouthrefclk10_in, gtsouthrefclk11_in, 
  phy_rxn_in, phy_rxp_in, rxoutclk, vid_phy_rx_axi4s_ch0_tdata, vid_phy_rx_axi4s_ch0_tuser, 
  vid_phy_rx_axi4s_ch0_tvalid, vid_phy_rx_axi4s_ch0_tready, vid_phy_rx_axi4s_aclk, 
  vid_phy_rx_axi4s_aresetn, vid_phy_rx_axi4s_ch1_tdata, vid_phy_rx_axi4s_ch1_tuser, 
  vid_phy_rx_axi4s_ch1_tvalid, vid_phy_rx_axi4s_ch1_tready, vid_phy_rx_axi4s_ch2_tdata, 
  vid_phy_rx_axi4s_ch2_tuser, vid_phy_rx_axi4s_ch2_tvalid, vid_phy_rx_axi4s_ch2_tready, 
  vid_phy_rx_axi4s_ch3_tdata, vid_phy_rx_axi4s_ch3_tuser, vid_phy_rx_axi4s_ch3_tvalid, 
  vid_phy_rx_axi4s_ch3_tready, irq, vid_phy_sb_aclk, vid_phy_sb_aresetn, 
  vid_phy_control_sb_rx_tdata, vid_phy_control_sb_rx_tvalid, 
  vid_phy_control_sb_rx_tready, vid_phy_status_sb_rx_tdata, 
  vid_phy_status_sb_rx_tvalid, vid_phy_status_sb_rx_tready, vid_phy_axi4lite_awaddr, 
  vid_phy_axi4lite_awprot, vid_phy_axi4lite_awvalid, vid_phy_axi4lite_awready, 
  vid_phy_axi4lite_wdata, vid_phy_axi4lite_wstrb, vid_phy_axi4lite_wvalid, 
  vid_phy_axi4lite_wready, vid_phy_axi4lite_bresp, vid_phy_axi4lite_bvalid, 
  vid_phy_axi4lite_bready, vid_phy_axi4lite_araddr, vid_phy_axi4lite_arprot, 
  vid_phy_axi4lite_arvalid, vid_phy_axi4lite_arready, vid_phy_axi4lite_rdata, 
  vid_phy_axi4lite_rresp, vid_phy_axi4lite_rvalid, vid_phy_axi4lite_rready, 
  vid_phy_axi4lite_aclk, vid_phy_axi4lite_aresetn, drpclk)
/* synthesis syn_black_box black_box_pad_pin="mgtrefclk0_in,mgtrefclk1_in,gtnorthrefclk0_in,gtnorthrefclk1_in,gtsouthrefclk0_in,gtsouthrefclk1_in,gtnorthrefclk00_in,gtnorthrefclk01_in,gtnorthrefclk10_in,gtnorthrefclk11_in,gtsouthrefclk00_in,gtsouthrefclk01_in,gtsouthrefclk10_in,gtsouthrefclk11_in,phy_rxn_in[3:0],phy_rxp_in[3:0],rxoutclk,vid_phy_rx_axi4s_ch0_tdata[31:0],vid_phy_rx_axi4s_ch0_tuser[11:0],vid_phy_rx_axi4s_ch0_tvalid,vid_phy_rx_axi4s_ch0_tready,vid_phy_rx_axi4s_aclk,vid_phy_rx_axi4s_aresetn,vid_phy_rx_axi4s_ch1_tdata[31:0],vid_phy_rx_axi4s_ch1_tuser[11:0],vid_phy_rx_axi4s_ch1_tvalid,vid_phy_rx_axi4s_ch1_tready,vid_phy_rx_axi4s_ch2_tdata[31:0],vid_phy_rx_axi4s_ch2_tuser[11:0],vid_phy_rx_axi4s_ch2_tvalid,vid_phy_rx_axi4s_ch2_tready,vid_phy_rx_axi4s_ch3_tdata[31:0],vid_phy_rx_axi4s_ch3_tuser[11:0],vid_phy_rx_axi4s_ch3_tvalid,vid_phy_rx_axi4s_ch3_tready,irq,vid_phy_sb_aclk,vid_phy_sb_aresetn,vid_phy_control_sb_rx_tdata[7:0],vid_phy_control_sb_rx_tvalid,vid_phy_control_sb_rx_tready,vid_phy_status_sb_rx_tdata[15:0],vid_phy_status_sb_rx_tvalid,vid_phy_status_sb_rx_tready,vid_phy_axi4lite_awaddr[9:0],vid_phy_axi4lite_awprot[2:0],vid_phy_axi4lite_awvalid,vid_phy_axi4lite_awready,vid_phy_axi4lite_wdata[31:0],vid_phy_axi4lite_wstrb[3:0],vid_phy_axi4lite_wvalid,vid_phy_axi4lite_wready,vid_phy_axi4lite_bresp[1:0],vid_phy_axi4lite_bvalid,vid_phy_axi4lite_bready,vid_phy_axi4lite_araddr[9:0],vid_phy_axi4lite_arprot[2:0],vid_phy_axi4lite_arvalid,vid_phy_axi4lite_arready,vid_phy_axi4lite_rdata[31:0],vid_phy_axi4lite_rresp[1:0],vid_phy_axi4lite_rvalid,vid_phy_axi4lite_rready,vid_phy_axi4lite_aclk,vid_phy_axi4lite_aresetn,drpclk" */;
  input mgtrefclk0_in;
  input mgtrefclk1_in;
  input gtnorthrefclk0_in;
  input gtnorthrefclk1_in;
  input gtsouthrefclk0_in;
  input gtsouthrefclk1_in;
  input gtnorthrefclk00_in;
  input gtnorthrefclk01_in;
  input gtnorthrefclk10_in;
  input gtnorthrefclk11_in;
  input gtsouthrefclk00_in;
  input gtsouthrefclk01_in;
  input gtsouthrefclk10_in;
  input gtsouthrefclk11_in;
  input [3:0]phy_rxn_in;
  input [3:0]phy_rxp_in;
  output rxoutclk;
  output [31:0]vid_phy_rx_axi4s_ch0_tdata;
  output [11:0]vid_phy_rx_axi4s_ch0_tuser;
  output vid_phy_rx_axi4s_ch0_tvalid;
  input vid_phy_rx_axi4s_ch0_tready;
  input vid_phy_rx_axi4s_aclk;
  input vid_phy_rx_axi4s_aresetn;
  output [31:0]vid_phy_rx_axi4s_ch1_tdata;
  output [11:0]vid_phy_rx_axi4s_ch1_tuser;
  output vid_phy_rx_axi4s_ch1_tvalid;
  input vid_phy_rx_axi4s_ch1_tready;
  output [31:0]vid_phy_rx_axi4s_ch2_tdata;
  output [11:0]vid_phy_rx_axi4s_ch2_tuser;
  output vid_phy_rx_axi4s_ch2_tvalid;
  input vid_phy_rx_axi4s_ch2_tready;
  output [31:0]vid_phy_rx_axi4s_ch3_tdata;
  output [11:0]vid_phy_rx_axi4s_ch3_tuser;
  output vid_phy_rx_axi4s_ch3_tvalid;
  input vid_phy_rx_axi4s_ch3_tready;
  output irq;
  input vid_phy_sb_aclk;
  input vid_phy_sb_aresetn;
  input [7:0]vid_phy_control_sb_rx_tdata;
  input vid_phy_control_sb_rx_tvalid;
  output vid_phy_control_sb_rx_tready;
  output [15:0]vid_phy_status_sb_rx_tdata;
  output vid_phy_status_sb_rx_tvalid;
  input vid_phy_status_sb_rx_tready;
  input [9:0]vid_phy_axi4lite_awaddr;
  input [2:0]vid_phy_axi4lite_awprot;
  input vid_phy_axi4lite_awvalid;
  output vid_phy_axi4lite_awready;
  input [31:0]vid_phy_axi4lite_wdata;
  input [3:0]vid_phy_axi4lite_wstrb;
  input vid_phy_axi4lite_wvalid;
  output vid_phy_axi4lite_wready;
  output [1:0]vid_phy_axi4lite_bresp;
  output vid_phy_axi4lite_bvalid;
  input vid_phy_axi4lite_bready;
  input [9:0]vid_phy_axi4lite_araddr;
  input [2:0]vid_phy_axi4lite_arprot;
  input vid_phy_axi4lite_arvalid;
  output vid_phy_axi4lite_arready;
  output [31:0]vid_phy_axi4lite_rdata;
  output [1:0]vid_phy_axi4lite_rresp;
  output vid_phy_axi4lite_rvalid;
  input vid_phy_axi4lite_rready;
  input vid_phy_axi4lite_aclk;
  input vid_phy_axi4lite_aresetn;
  input drpclk;
endmodule
