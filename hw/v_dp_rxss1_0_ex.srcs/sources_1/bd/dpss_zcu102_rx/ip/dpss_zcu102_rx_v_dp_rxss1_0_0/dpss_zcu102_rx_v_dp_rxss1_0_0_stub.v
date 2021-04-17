// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:54:48 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_v_dp_rxss1_0_0/dpss_zcu102_rx_v_dp_rxss1_0_0_stub.v
// Design      : dpss_zcu102_rx_v_dp_rxss1_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "bd_6311,Vivado 2020.1" *)
module dpss_zcu102_rx_v_dp_rxss1_0_0(s_axi_aclk, s_axi_aresetn, rx_vid_clk, 
  rx_vid_rst, m_axis_aclk_stream1, aux_rx_data_in, aux_rx_data_out, aux_rx_data_en_out_n, 
  rx_lnk_clk, rx_hpd, dprxss_dp_irq, m_aud_axis_aclk, m_aud_axis_aresetn, acr_m_aud, acr_n_aud, 
  acr_valid, ext_rst, dprxss_iic_irq, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, 
  s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, 
  s_axi_bready, s_axi_araddr, s_axi_arprot, s_axi_arvalid, s_axi_arready, s_axi_rdata, 
  s_axi_rresp, s_axi_rvalid, s_axi_rready, m_axis_video_stream1_tdata, 
  m_axis_video_stream1_tlast, m_axis_video_stream1_tready, m_axis_video_stream1_tuser, 
  m_axis_video_stream1_tvalid, s_axis_lnk_rx_lane0_tdata, s_axis_lnk_rx_lane0_tready, 
  s_axis_lnk_rx_lane0_tuser, s_axis_lnk_rx_lane0_tvalid, 
  m_axis_phy_rx_sb_control_tdata, m_axis_phy_rx_sb_control_tready, 
  m_axis_phy_rx_sb_control_tvalid, s_axis_phy_rx_sb_status_tdata, 
  s_axis_phy_rx_sb_status_tready, s_axis_phy_rx_sb_status_tvalid, 
  s_axis_lnk_rx_lane3_tdata, s_axis_lnk_rx_lane3_tready, s_axis_lnk_rx_lane3_tuser, 
  s_axis_lnk_rx_lane3_tvalid, s_axis_lnk_rx_lane2_tdata, s_axis_lnk_rx_lane2_tready, 
  s_axis_lnk_rx_lane2_tuser, s_axis_lnk_rx_lane2_tvalid, s_axis_lnk_rx_lane1_tdata, 
  s_axis_lnk_rx_lane1_tready, s_axis_lnk_rx_lane1_tuser, s_axis_lnk_rx_lane1_tvalid, 
  edid_iic_scl_i, edid_iic_scl_o, edid_iic_scl_t, edid_iic_sda_i, edid_iic_sda_o, 
  edid_iic_sda_t, ext_iic_scl_i, ext_iic_scl_o, ext_iic_scl_t, ext_iic_sda_i, ext_iic_sda_o, 
  ext_iic_sda_t, aud_axi_egress_tdata, aud_axi_egress_tid, aud_axi_egress_tready, 
  aud_axi_egress_tvalid)
/* synthesis syn_black_box black_box_pad_pin="s_axi_aclk,s_axi_aresetn,rx_vid_clk,rx_vid_rst,m_axis_aclk_stream1,aux_rx_data_in,aux_rx_data_out,aux_rx_data_en_out_n,rx_lnk_clk,rx_hpd,dprxss_dp_irq,m_aud_axis_aclk,m_aud_axis_aresetn,acr_m_aud[23:0],acr_n_aud[23:0],acr_valid,ext_rst[0:0],dprxss_iic_irq,s_axi_awaddr[12:0],s_axi_awprot[2:0],s_axi_awvalid[0:0],s_axi_awready[0:0],s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid[0:0],s_axi_wready[0:0],s_axi_bresp[1:0],s_axi_bvalid[0:0],s_axi_bready[0:0],s_axi_araddr[12:0],s_axi_arprot[2:0],s_axi_arvalid[0:0],s_axi_arready[0:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid[0:0],s_axi_rready[0:0],m_axis_video_stream1_tdata[119:0],m_axis_video_stream1_tlast,m_axis_video_stream1_tready,m_axis_video_stream1_tuser[0:0],m_axis_video_stream1_tvalid,s_axis_lnk_rx_lane0_tdata[31:0],s_axis_lnk_rx_lane0_tready,s_axis_lnk_rx_lane0_tuser[11:0],s_axis_lnk_rx_lane0_tvalid,m_axis_phy_rx_sb_control_tdata[7:0],m_axis_phy_rx_sb_control_tready,m_axis_phy_rx_sb_control_tvalid,s_axis_phy_rx_sb_status_tdata[31:0],s_axis_phy_rx_sb_status_tready,s_axis_phy_rx_sb_status_tvalid,s_axis_lnk_rx_lane3_tdata[31:0],s_axis_lnk_rx_lane3_tready,s_axis_lnk_rx_lane3_tuser[11:0],s_axis_lnk_rx_lane3_tvalid,s_axis_lnk_rx_lane2_tdata[31:0],s_axis_lnk_rx_lane2_tready,s_axis_lnk_rx_lane2_tuser[11:0],s_axis_lnk_rx_lane2_tvalid,s_axis_lnk_rx_lane1_tdata[31:0],s_axis_lnk_rx_lane1_tready,s_axis_lnk_rx_lane1_tuser[11:0],s_axis_lnk_rx_lane1_tvalid,edid_iic_scl_i,edid_iic_scl_o,edid_iic_scl_t,edid_iic_sda_i,edid_iic_sda_o,edid_iic_sda_t,ext_iic_scl_i,ext_iic_scl_o,ext_iic_scl_t,ext_iic_sda_i,ext_iic_sda_o,ext_iic_sda_t,aud_axi_egress_tdata[31:0],aud_axi_egress_tid[7:0],aud_axi_egress_tready,aud_axi_egress_tvalid" */;
  input s_axi_aclk;
  input s_axi_aresetn;
  input rx_vid_clk;
  input rx_vid_rst;
  input m_axis_aclk_stream1;
  input aux_rx_data_in;
  output aux_rx_data_out;
  output aux_rx_data_en_out_n;
  input rx_lnk_clk;
  output rx_hpd;
  output dprxss_dp_irq;
  input m_aud_axis_aclk;
  input m_aud_axis_aresetn;
  output [23:0]acr_m_aud;
  output [23:0]acr_n_aud;
  output acr_valid;
  output [0:0]ext_rst;
  output dprxss_iic_irq;
  input [12:0]s_axi_awaddr;
  input [2:0]s_axi_awprot;
  input [0:0]s_axi_awvalid;
  output [0:0]s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input [0:0]s_axi_wvalid;
  output [0:0]s_axi_wready;
  output [1:0]s_axi_bresp;
  output [0:0]s_axi_bvalid;
  input [0:0]s_axi_bready;
  input [12:0]s_axi_araddr;
  input [2:0]s_axi_arprot;
  input [0:0]s_axi_arvalid;
  output [0:0]s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output [0:0]s_axi_rvalid;
  input [0:0]s_axi_rready;
  output [119:0]m_axis_video_stream1_tdata;
  output m_axis_video_stream1_tlast;
  input m_axis_video_stream1_tready;
  output [0:0]m_axis_video_stream1_tuser;
  output m_axis_video_stream1_tvalid;
  input [31:0]s_axis_lnk_rx_lane0_tdata;
  output s_axis_lnk_rx_lane0_tready;
  input [11:0]s_axis_lnk_rx_lane0_tuser;
  input s_axis_lnk_rx_lane0_tvalid;
  output [7:0]m_axis_phy_rx_sb_control_tdata;
  input m_axis_phy_rx_sb_control_tready;
  output m_axis_phy_rx_sb_control_tvalid;
  input [31:0]s_axis_phy_rx_sb_status_tdata;
  output s_axis_phy_rx_sb_status_tready;
  input s_axis_phy_rx_sb_status_tvalid;
  input [31:0]s_axis_lnk_rx_lane3_tdata;
  output s_axis_lnk_rx_lane3_tready;
  input [11:0]s_axis_lnk_rx_lane3_tuser;
  input s_axis_lnk_rx_lane3_tvalid;
  input [31:0]s_axis_lnk_rx_lane2_tdata;
  output s_axis_lnk_rx_lane2_tready;
  input [11:0]s_axis_lnk_rx_lane2_tuser;
  input s_axis_lnk_rx_lane2_tvalid;
  input [31:0]s_axis_lnk_rx_lane1_tdata;
  output s_axis_lnk_rx_lane1_tready;
  input [11:0]s_axis_lnk_rx_lane1_tuser;
  input s_axis_lnk_rx_lane1_tvalid;
  input edid_iic_scl_i;
  output edid_iic_scl_o;
  output edid_iic_scl_t;
  input edid_iic_sda_i;
  output edid_iic_sda_o;
  output edid_iic_sda_t;
  input ext_iic_scl_i;
  output ext_iic_scl_o;
  output ext_iic_scl_t;
  input ext_iic_sda_i;
  output ext_iic_sda_o;
  output ext_iic_sda_t;
  output [31:0]aud_axi_egress_tdata;
  output [7:0]aud_axi_egress_tid;
  input aud_axi_egress_tready;
  output aud_axi_egress_tvalid;
endmodule
