// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:54:48 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top dpss_zcu102_rx_v_dp_rxss1_0_0 -prefix
//               dpss_zcu102_rx_v_dp_rxss1_0_0_ dpss_zcu102_rx_v_dp_rxss1_0_0_sim_netlist.v
// Design      : dpss_zcu102_rx_v_dp_rxss1_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* HW_HANDOFF = "dpss_zcu102_rx_v_dp_rxss1_0_0.hwdef" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311
   (acr_m_aud,
    acr_n_aud,
    acr_valid,
    aud_axi_egress_tdata,
    aud_axi_egress_tid,
    aud_axi_egress_tready,
    aud_axi_egress_tvalid,
    aux_rx_data_en_out_n,
    aux_rx_data_in,
    aux_rx_data_out,
    dprxss_dp_irq,
    dprxss_iic_irq,
    edid_iic_scl_i,
    edid_iic_scl_o,
    edid_iic_scl_t,
    edid_iic_sda_i,
    edid_iic_sda_o,
    edid_iic_sda_t,
    ext_iic_scl_i,
    ext_iic_scl_o,
    ext_iic_scl_t,
    ext_iic_sda_i,
    ext_iic_sda_o,
    ext_iic_sda_t,
    ext_rst,
    m_aud_axis_aclk,
    m_aud_axis_aresetn,
    m_axis_aclk_stream1,
    m_axis_phy_rx_sb_control_tdata,
    m_axis_phy_rx_sb_control_tready,
    m_axis_phy_rx_sb_control_tvalid,
    m_axis_video_stream1_tdata,
    m_axis_video_stream1_tlast,
    m_axis_video_stream1_tready,
    m_axis_video_stream1_tuser,
    m_axis_video_stream1_tvalid,
    rx_hpd,
    rx_lnk_clk,
    rx_vid_clk,
    rx_vid_rst,
    s_axi_aclk,
    s_axi_araddr,
    s_axi_aresetn,
    s_axi_arprot,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axis_lnk_rx_lane0_tdata,
    s_axis_lnk_rx_lane0_tready,
    s_axis_lnk_rx_lane0_tuser,
    s_axis_lnk_rx_lane0_tvalid,
    s_axis_lnk_rx_lane1_tdata,
    s_axis_lnk_rx_lane1_tready,
    s_axis_lnk_rx_lane1_tuser,
    s_axis_lnk_rx_lane1_tvalid,
    s_axis_lnk_rx_lane2_tdata,
    s_axis_lnk_rx_lane2_tready,
    s_axis_lnk_rx_lane2_tuser,
    s_axis_lnk_rx_lane2_tvalid,
    s_axis_lnk_rx_lane3_tdata,
    s_axis_lnk_rx_lane3_tready,
    s_axis_lnk_rx_lane3_tuser,
    s_axis_lnk_rx_lane3_tvalid,
    s_axis_phy_rx_sb_status_tdata,
    s_axis_phy_rx_sb_status_tready,
    s_axis_phy_rx_sb_status_tvalid);
  output [23:0]acr_m_aud;
  output [23:0]acr_n_aud;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.ACR_VALID DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.ACR_VALID, LAYERED_METADATA undef" *) output acr_valid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aud_axi_egress, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0" *) output [31:0]aud_axi_egress_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TID" *) output [7:0]aud_axi_egress_tid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TREADY" *) input aud_axi_egress_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TVALID" *) output aud_axi_egress_tvalid;
  output aux_rx_data_en_out_n;
  input aux_rx_data_in;
  output aux_rx_data_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.DPRXSS_DP_IRQ INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.DPRXSS_DP_IRQ, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output dprxss_dp_irq;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.DPRXSS_IIC_IRQ INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.DPRXSS_IIC_IRQ, PortWidth 1, SENSITIVITY LEVEL_HIGH" *) output dprxss_iic_irq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_I" *) input edid_iic_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_O" *) output edid_iic_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_T" *) output edid_iic_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_I" *) input edid_iic_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_O" *) output edid_iic_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_T" *) output edid_iic_sda_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_I" *) input ext_iic_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_O" *) output ext_iic_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_T" *) output ext_iic_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_I" *) input ext_iic_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_O" *) output ext_iic_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_T" *) output ext_iic_sda_t;
  output [0:0]ext_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.M_AUD_AXIS_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.M_AUD_AXIS_ACLK, ASSOCIATED_BUSIF aud_axi_egress, ASSOCIATED_RESET m_aud_axis_aresetn, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input m_aud_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.M_AUD_AXIS_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.M_AUD_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input m_aud_axis_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.M_AXIS_ACLK_STREAM1 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.M_AXIS_ACLK_STREAM1, ASSOCIATED_BUSIF m_axis_video_stream1, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input m_axis_aclk_stream1;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_phy_rx_sb_control, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [7:0]m_axis_phy_rx_sb_control_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TREADY" *) input m_axis_phy_rx_sb_control_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TVALID" *) output m_axis_phy_rx_sb_control_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_video_stream1, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 15, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1" *) output [119:0]m_axis_video_stream1_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TLAST" *) output m_axis_video_stream1_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TREADY" *) input m_axis_video_stream1_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TUSER" *) output [0:0]m_axis_video_stream1_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TVALID" *) output m_axis_video_stream1_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.RX_HPD DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.RX_HPD, LAYERED_METADATA undef" *) output rx_hpd;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.RX_LNK_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.RX_LNK_CLK, ASSOCIATED_BUSIF s_axis_lnk_rx_lane0:s_axis_lnk_rx_lane1:s_axis_lnk_rx_lane2:s_axis_lnk_rx_lane3, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input rx_lnk_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.RX_VID_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.RX_VID_CLK, ASSOCIATED_RESET rx_vid_rst, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input rx_vid_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RX_VID_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RX_VID_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input rx_vid_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXI_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXI_ACLK, ASSOCIATED_BUSIF m_axis_phy_rx_sb_control:s_axi:s_axis_phy_rx_sb_status, ASSOCIATED_CLKEN s_sc_aclken, ASSOCIATED_RESET s_axi_aresetn, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, ADDR_WIDTH 13, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, DATA_WIDTH 32, FREQ_HZ 99999001, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 8, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 8, NUM_WRITE_THREADS 1, PHASE 0.000, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [12:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXI_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output [0:0]s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input [0:0]s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [12:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *) input [2:0]s_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output [0:0]s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input [0:0]s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input [0:0]s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output [0:0]s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input [0:0]s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output [0:0]s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output [0:0]s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input [0:0]s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane0, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12" *) input [31:0]s_axis_lnk_rx_lane0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TREADY" *) output s_axis_lnk_rx_lane0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TUSER" *) input [11:0]s_axis_lnk_rx_lane0_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TVALID" *) input s_axis_lnk_rx_lane0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane1, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12" *) input [31:0]s_axis_lnk_rx_lane1_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TREADY" *) output s_axis_lnk_rx_lane1_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TUSER" *) input [11:0]s_axis_lnk_rx_lane1_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TVALID" *) input s_axis_lnk_rx_lane1_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane2, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12" *) input [31:0]s_axis_lnk_rx_lane2_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TREADY" *) output s_axis_lnk_rx_lane2_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TUSER" *) input [11:0]s_axis_lnk_rx_lane2_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TVALID" *) input s_axis_lnk_rx_lane2_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane3, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12" *) input [31:0]s_axis_lnk_rx_lane3_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TREADY" *) output s_axis_lnk_rx_lane3_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TUSER" *) input [11:0]s_axis_lnk_rx_lane3_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TVALID" *) input s_axis_lnk_rx_lane3_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_phy_rx_sb_status, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]s_axis_phy_rx_sb_status_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TREADY" *) output s_axis_phy_rx_sb_status_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TVALID" *) input s_axis_phy_rx_sb_status_tvalid;

  wire [23:0]acr_m_aud;
  wire [23:0]acr_n_aud;
  wire acr_valid;
  wire [31:0]aud_axi_egress_tdata;
  wire [7:0]aud_axi_egress_tid;
  wire aud_axi_egress_tready;
  wire aud_axi_egress_tvalid;
  wire aux_rx_data_en_out_n;
  wire aux_rx_data_in;
  wire aux_rx_data_out;
  wire dp_dp_rx_vid_intf_str0_TX_VID_ENABLE;
  wire dp_dp_rx_vid_intf_str0_TX_VID_HSYNC;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3;
  wire dp_dp_rx_vid_intf_str0_TX_VID_VSYNC;
  wire [2:0]dp_rx_bpc;
  wire [2:0]dp_rx_cformat;
  wire [15:0]dp_rx_vid_msa_hres;
  wire [2:0]dp_rx_vid_pixel_mode;
  wire dprxss_dp_irq;
  wire dprxss_iic_irq;
  wire edid_iic_scl_i;
  wire edid_iic_scl_o;
  wire edid_iic_scl_t;
  wire edid_iic_sda_i;
  wire edid_iic_sda_o;
  wire edid_iic_sda_t;
  wire ext_iic_scl_i;
  wire ext_iic_scl_o;
  wire ext_iic_scl_t;
  wire ext_iic_sda_i;
  wire ext_iic_sda_o;
  wire ext_iic_sda_t;
  wire [0:0]ext_rst;
  wire m_aud_axis_aclk;
  wire m_aud_axis_aresetn;
  wire m_axis_aclk_stream1;
  wire [7:0]m_axis_phy_rx_sb_control_tdata;
  wire m_axis_phy_rx_sb_control_tready;
  wire m_axis_phy_rx_sb_control_tvalid;
  wire [119:0]m_axis_video_stream1_tdata;
  wire m_axis_video_stream1_tlast;
  wire m_axis_video_stream1_tready;
  wire [0:0]m_axis_video_stream1_tuser;
  wire m_axis_video_stream1_tvalid;
  wire notof_0_Res;
  wire rx_hpd;
  wire rx_lnk_clk;
  wire rx_vid_clk;
  wire rx_vid_rst;
  wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire [2:0]s_axi_arprot;
  wire [0:0]s_axi_arready;
  wire [0:0]s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire [2:0]s_axi_awprot;
  wire [0:0]s_axi_awready;
  wire [0:0]s_axi_awvalid;
  wire [0:0]s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire [0:0]s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire [0:0]s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire [0:0]s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [0:0]s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire [0:0]s_axi_wvalid;
  wire [31:0]s_axis_lnk_rx_lane0_tdata;
  wire s_axis_lnk_rx_lane0_tready;
  wire [11:0]s_axis_lnk_rx_lane0_tuser;
  wire s_axis_lnk_rx_lane0_tvalid;
  wire [31:0]s_axis_lnk_rx_lane1_tdata;
  wire s_axis_lnk_rx_lane1_tready;
  wire [11:0]s_axis_lnk_rx_lane1_tuser;
  wire s_axis_lnk_rx_lane1_tvalid;
  wire [31:0]s_axis_lnk_rx_lane2_tdata;
  wire s_axis_lnk_rx_lane2_tready;
  wire [11:0]s_axis_lnk_rx_lane2_tuser;
  wire s_axis_lnk_rx_lane2_tvalid;
  wire [31:0]s_axis_lnk_rx_lane3_tdata;
  wire s_axis_lnk_rx_lane3_tready;
  wire [11:0]s_axis_lnk_rx_lane3_tuser;
  wire s_axis_lnk_rx_lane3_tvalid;
  wire [31:0]s_axis_phy_rx_sb_status_tdata;
  wire s_axis_phy_rx_sb_status_tready;
  wire s_axis_phy_rx_sb_status_tvalid;
  wire [8:0]xbar_M00_AXI_ARADDR;
  wire xbar_M00_AXI_ARREADY;
  wire xbar_M00_AXI_ARVALID;
  wire [8:0]xbar_M00_AXI_AWADDR;
  wire xbar_M00_AXI_AWREADY;
  wire xbar_M00_AXI_AWVALID;
  wire xbar_M00_AXI_BREADY;
  wire [1:0]xbar_M00_AXI_BRESP;
  wire xbar_M00_AXI_BVALID;
  wire [31:0]xbar_M00_AXI_RDATA;
  wire xbar_M00_AXI_RREADY;
  wire [1:0]xbar_M00_AXI_RRESP;
  wire xbar_M00_AXI_RVALID;
  wire [31:0]xbar_M00_AXI_WDATA;
  wire xbar_M00_AXI_WREADY;
  wire [3:0]xbar_M00_AXI_WSTRB;
  wire xbar_M00_AXI_WVALID;
  wire [31:0]xbar_M01_AXI_ARADDR;
  wire [2:0]xbar_M01_AXI_ARPROT;
  wire xbar_M01_AXI_ARREADY;
  wire xbar_M01_AXI_ARVALID;
  wire [31:0]xbar_M01_AXI_AWADDR;
  wire [2:0]xbar_M01_AXI_AWPROT;
  wire xbar_M01_AXI_AWREADY;
  wire xbar_M01_AXI_AWVALID;
  wire xbar_M01_AXI_BREADY;
  wire [1:0]xbar_M01_AXI_BRESP;
  wire xbar_M01_AXI_BVALID;
  wire [31:0]xbar_M01_AXI_RDATA;
  wire xbar_M01_AXI_RREADY;
  wire [1:0]xbar_M01_AXI_RRESP;
  wire xbar_M01_AXI_RVALID;
  wire [31:0]xbar_M01_AXI_WDATA;
  wire xbar_M01_AXI_WREADY;
  wire [3:0]xbar_M01_AXI_WSTRB;
  wire xbar_M01_AXI_WVALID;
  wire NLW_dp_bw_changed_out_UNCONNECTED;
  wire NLW_dp_link_bw_hbr2_out_UNCONNECTED;
  wire NLW_dp_link_bw_high_out_UNCONNECTED;
  wire NLW_dp_rx_vid_oddeven_UNCONNECTED;
  wire [23:0]NLW_dp_lnk_m_aud_UNCONNECTED;
  wire [23:0]NLW_dp_lnk_m_vid_UNCONNECTED;
  wire [23:0]NLW_dp_lnk_n_aud_UNCONNECTED;
  wire [23:0]NLW_dp_lnk_n_vid_UNCONNECTED;
  wire [15:0]NLW_dp_rx_vid_msa_vres_UNCONNECTED;
  wire NLW_vb1_rd_error_UNCONNECTED;
  wire NLW_vb1_wr_error_UNCONNECTED;
  wire [4:0]NLW_vb1_debug_port_UNCONNECTED;
  wire [15:0]NLW_vb1_hres_cntr_out_UNCONNECTED;
  wire [15:0]NLW_vb1_vres_cntr_out_UNCONNECTED;
  wire [2:0]NLW_xbar_M00_AXI_arprot_UNCONNECTED;
  wire [2:0]NLW_xbar_M00_AXI_awprot_UNCONNECTED;

  (* X_CORE_INFO = "bd_6311_dp_0_dport_wrapper,Vivado 2020.1" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_dp_0 dp
       (.acr_m_aud(acr_m_aud),
        .acr_n_aud(acr_n_aud),
        .acr_valid(acr_valid),
        .aud_rst(notof_0_Res),
        .aux_rx_data_en_out_n(aux_rx_data_en_out_n),
        .aux_rx_data_in(aux_rx_data_in),
        .aux_rx_data_out(aux_rx_data_out),
        .axi_int(dprxss_dp_irq),
        .bw_changed_out(NLW_dp_bw_changed_out_UNCONNECTED),
        .i2c_scl_enable_n(edid_iic_scl_t),
        .i2c_scl_in(edid_iic_scl_i),
        .i2c_scl_o(edid_iic_scl_o),
        .i2c_sda_enable_n(edid_iic_sda_t),
        .i2c_sda_in(edid_iic_sda_i),
        .i2c_sda_o(edid_iic_sda_o),
        .link_bw_hbr2_out(NLW_dp_link_bw_hbr2_out_UNCONNECTED),
        .link_bw_high_out(NLW_dp_link_bw_high_out_UNCONNECTED),
        .lnk_m_aud(NLW_dp_lnk_m_aud_UNCONNECTED[23:0]),
        .lnk_m_vid(NLW_dp_lnk_m_vid_UNCONNECTED[23:0]),
        .lnk_n_aud(NLW_dp_lnk_n_aud_UNCONNECTED[23:0]),
        .lnk_n_vid(NLW_dp_lnk_n_vid_UNCONNECTED[23:0]),
        .lnk_rx_axi4s_lane0_tdata(s_axis_lnk_rx_lane0_tdata),
        .lnk_rx_axi4s_lane0_tready(s_axis_lnk_rx_lane0_tready),
        .lnk_rx_axi4s_lane0_tuser(s_axis_lnk_rx_lane0_tuser),
        .lnk_rx_axi4s_lane0_tvalid(s_axis_lnk_rx_lane0_tvalid),
        .lnk_rx_axi4s_lane1_tdata(s_axis_lnk_rx_lane1_tdata),
        .lnk_rx_axi4s_lane1_tready(s_axis_lnk_rx_lane1_tready),
        .lnk_rx_axi4s_lane1_tuser(s_axis_lnk_rx_lane1_tuser),
        .lnk_rx_axi4s_lane1_tvalid(s_axis_lnk_rx_lane1_tvalid),
        .lnk_rx_axi4s_lane2_tdata(s_axis_lnk_rx_lane2_tdata),
        .lnk_rx_axi4s_lane2_tready(s_axis_lnk_rx_lane2_tready),
        .lnk_rx_axi4s_lane2_tuser(s_axis_lnk_rx_lane2_tuser),
        .lnk_rx_axi4s_lane2_tvalid(s_axis_lnk_rx_lane2_tvalid),
        .lnk_rx_axi4s_lane3_tdata(s_axis_lnk_rx_lane3_tdata),
        .lnk_rx_axi4s_lane3_tready(s_axis_lnk_rx_lane3_tready),
        .lnk_rx_axi4s_lane3_tuser(s_axis_lnk_rx_lane3_tuser),
        .lnk_rx_axi4s_lane3_tvalid(s_axis_lnk_rx_lane3_tvalid),
        .lnk_rx_sb_control_axi4s_tdata(m_axis_phy_rx_sb_control_tdata),
        .lnk_rx_sb_control_axi4s_tready(m_axis_phy_rx_sb_control_tready),
        .lnk_rx_sb_control_axi4s_tvalid(m_axis_phy_rx_sb_control_tvalid),
        .lnk_rx_sb_status_axi4s_tdata(s_axis_phy_rx_sb_status_tdata),
        .lnk_rx_sb_status_axi4s_tready(s_axis_phy_rx_sb_status_tready),
        .lnk_rx_sb_status_axi4s_tvalid(s_axis_phy_rx_sb_status_tvalid),
        .m_aud_axis_aclk(m_aud_axis_aclk),
        .m_aud_axis_aresetn(m_aud_axis_aresetn),
        .m_axis_audio_egress_tdata(aud_axi_egress_tdata),
        .m_axis_audio_egress_tid(aud_axi_egress_tid),
        .m_axis_audio_egress_tready(aud_axi_egress_tready),
        .m_axis_audio_egress_tvalid(aud_axi_egress_tvalid),
        .rx_bpc(dp_rx_bpc),
        .rx_cformat(dp_rx_cformat),
        .rx_hpd(rx_hpd),
        .rx_lnk_clk(rx_lnk_clk),
        .rx_vid_clk(rx_vid_clk),
        .rx_vid_enable(dp_dp_rx_vid_intf_str0_TX_VID_ENABLE),
        .rx_vid_hsync(dp_dp_rx_vid_intf_str0_TX_VID_HSYNC),
        .rx_vid_msa_hres(dp_rx_vid_msa_hres),
        .rx_vid_msa_vres(NLW_dp_rx_vid_msa_vres_UNCONNECTED[15:0]),
        .rx_vid_oddeven(NLW_dp_rx_vid_oddeven_UNCONNECTED),
        .rx_vid_pixel0(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0),
        .rx_vid_pixel1(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1),
        .rx_vid_pixel2(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2),
        .rx_vid_pixel3(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3),
        .rx_vid_pixel_mode(dp_rx_vid_pixel_mode),
        .rx_vid_rst(rx_vid_rst),
        .rx_vid_vsync(dp_dp_rx_vid_intf_str0_TX_VID_VSYNC),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(xbar_M01_AXI_ARADDR),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arprot(xbar_M01_AXI_ARPROT),
        .s_axi_arready(xbar_M01_AXI_ARREADY),
        .s_axi_arvalid(xbar_M01_AXI_ARVALID),
        .s_axi_awaddr(xbar_M01_AXI_AWADDR),
        .s_axi_awprot(xbar_M01_AXI_AWPROT),
        .s_axi_awready(xbar_M01_AXI_AWREADY),
        .s_axi_awvalid(xbar_M01_AXI_AWVALID),
        .s_axi_bready(xbar_M01_AXI_BREADY),
        .s_axi_bresp(xbar_M01_AXI_BRESP),
        .s_axi_bvalid(xbar_M01_AXI_BVALID),
        .s_axi_rdata(xbar_M01_AXI_RDATA),
        .s_axi_rready(xbar_M01_AXI_RREADY),
        .s_axi_rresp(xbar_M01_AXI_RRESP),
        .s_axi_rvalid(xbar_M01_AXI_RVALID),
        .s_axi_wdata(xbar_M01_AXI_WDATA),
        .s_axi_wready(xbar_M01_AXI_WREADY),
        .s_axi_wstrb(xbar_M01_AXI_WSTRB),
        .s_axi_wvalid(xbar_M01_AXI_WVALID));
  (* X_CORE_INFO = "axi_iic,Vivado 2020.1" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_iic_0 iic
       (.gpo(ext_rst),
        .iic2intc_irpt(dprxss_iic_irq),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(xbar_M00_AXI_ARADDR),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(xbar_M00_AXI_ARREADY),
        .s_axi_arvalid(xbar_M00_AXI_ARVALID),
        .s_axi_awaddr(xbar_M00_AXI_AWADDR),
        .s_axi_awready(xbar_M00_AXI_AWREADY),
        .s_axi_awvalid(xbar_M00_AXI_AWVALID),
        .s_axi_bready(xbar_M00_AXI_BREADY),
        .s_axi_bresp(xbar_M00_AXI_BRESP),
        .s_axi_bvalid(xbar_M00_AXI_BVALID),
        .s_axi_rdata(xbar_M00_AXI_RDATA),
        .s_axi_rready(xbar_M00_AXI_RREADY),
        .s_axi_rresp(xbar_M00_AXI_RRESP),
        .s_axi_rvalid(xbar_M00_AXI_RVALID),
        .s_axi_wdata(xbar_M00_AXI_WDATA),
        .s_axi_wready(xbar_M00_AXI_WREADY),
        .s_axi_wstrb(xbar_M00_AXI_WSTRB),
        .s_axi_wvalid(xbar_M00_AXI_WVALID),
        .scl_i(ext_iic_scl_i),
        .scl_o(ext_iic_scl_o),
        .scl_t(ext_iic_scl_t),
        .sda_i(ext_iic_sda_i),
        .sda_o(ext_iic_sda_o),
        .sda_t(ext_iic_sda_t));
  (* X_CORE_INFO = "util_vector_logic_v2_0_1_util_vector_logic,Vivado 2020.1" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_notof_0_0 notof_0
       (.Op1(m_aud_axis_aresetn),
        .Res(notof_0_Res));
  (* X_CORE_INFO = "dp_videoaxi4s_bridge_v1_0_1,Vivado 2020.1" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_vb1_0 vb1
       (.bpc(dp_rx_bpc),
        .color_format(dp_rx_cformat),
        .debug_port(NLW_vb1_debug_port_UNCONNECTED[4:0]),
        .dp_hres(dp_rx_vid_msa_hres),
        .hres_cntr_out(NLW_vb1_hres_cntr_out_UNCONNECTED[15:0]),
        .m_axis_aclk(m_axis_aclk_stream1),
        .m_axis_video_tdata(m_axis_video_stream1_tdata),
        .m_axis_video_tlast(m_axis_video_stream1_tlast),
        .m_axis_video_tready(m_axis_video_stream1_tready),
        .m_axis_video_tuser(m_axis_video_stream1_tuser),
        .m_axis_video_tvalid(m_axis_video_stream1_tvalid),
        .pixel_mode(dp_rx_vid_pixel_mode),
        .rd_error(NLW_vb1_rd_error_UNCONNECTED),
        .vid_active_video(dp_dp_rx_vid_intf_str0_TX_VID_ENABLE),
        .vid_hsync(dp_dp_rx_vid_intf_str0_TX_VID_HSYNC),
        .vid_pixel0(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0),
        .vid_pixel1(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1),
        .vid_pixel2(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2),
        .vid_pixel3(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3),
        .vid_pixel_clk(rx_vid_clk),
        .vid_reset(rx_vid_rst),
        .vid_vsync(dp_dp_rx_vid_intf_str0_TX_VID_VSYNC),
        .vres_cntr_out(NLW_vb1_vres_cntr_out_UNCONNECTED[15:0]),
        .wr_error(NLW_vb1_wr_error_UNCONNECTED));
  (* X_CORE_INFO = "bd_6050,Vivado 2020.1" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_xbar_0 xbar
       (.M00_AXI_araddr(xbar_M00_AXI_ARADDR),
        .M00_AXI_arprot(NLW_xbar_M00_AXI_arprot_UNCONNECTED[2:0]),
        .M00_AXI_arready(xbar_M00_AXI_ARREADY),
        .M00_AXI_arvalid(xbar_M00_AXI_ARVALID),
        .M00_AXI_awaddr(xbar_M00_AXI_AWADDR),
        .M00_AXI_awprot(NLW_xbar_M00_AXI_awprot_UNCONNECTED[2:0]),
        .M00_AXI_awready(xbar_M00_AXI_AWREADY),
        .M00_AXI_awvalid(xbar_M00_AXI_AWVALID),
        .M00_AXI_bready(xbar_M00_AXI_BREADY),
        .M00_AXI_bresp(xbar_M00_AXI_BRESP),
        .M00_AXI_bvalid(xbar_M00_AXI_BVALID),
        .M00_AXI_rdata(xbar_M00_AXI_RDATA),
        .M00_AXI_rready(xbar_M00_AXI_RREADY),
        .M00_AXI_rresp(xbar_M00_AXI_RRESP),
        .M00_AXI_rvalid(xbar_M00_AXI_RVALID),
        .M00_AXI_wdata(xbar_M00_AXI_WDATA),
        .M00_AXI_wready(xbar_M00_AXI_WREADY),
        .M00_AXI_wstrb(xbar_M00_AXI_WSTRB),
        .M00_AXI_wvalid(xbar_M00_AXI_WVALID),
        .M01_AXI_araddr(xbar_M01_AXI_ARADDR),
        .M01_AXI_arprot(xbar_M01_AXI_ARPROT),
        .M01_AXI_arready(xbar_M01_AXI_ARREADY),
        .M01_AXI_arvalid(xbar_M01_AXI_ARVALID),
        .M01_AXI_awaddr(xbar_M01_AXI_AWADDR),
        .M01_AXI_awprot(xbar_M01_AXI_AWPROT),
        .M01_AXI_awready(xbar_M01_AXI_AWREADY),
        .M01_AXI_awvalid(xbar_M01_AXI_AWVALID),
        .M01_AXI_bready(xbar_M01_AXI_BREADY),
        .M01_AXI_bresp(xbar_M01_AXI_BRESP),
        .M01_AXI_bvalid(xbar_M01_AXI_BVALID),
        .M01_AXI_rdata(xbar_M01_AXI_RDATA),
        .M01_AXI_rready(xbar_M01_AXI_RREADY),
        .M01_AXI_rresp(xbar_M01_AXI_RRESP),
        .M01_AXI_rvalid(xbar_M01_AXI_RVALID),
        .M01_AXI_wdata(xbar_M01_AXI_WDATA),
        .M01_AXI_wready(xbar_M01_AXI_WREADY),
        .M01_AXI_wstrb(xbar_M01_AXI_WSTRB),
        .M01_AXI_wvalid(xbar_M01_AXI_WVALID),
        .S00_AXI_araddr(s_axi_araddr),
        .S00_AXI_arprot(s_axi_arprot),
        .S00_AXI_arready(s_axi_arready),
        .S00_AXI_arvalid(s_axi_arvalid),
        .S00_AXI_awaddr(s_axi_awaddr),
        .S00_AXI_awprot(s_axi_awprot),
        .S00_AXI_awready(s_axi_awready),
        .S00_AXI_awvalid(s_axi_awvalid),
        .S00_AXI_bready(s_axi_bready),
        .S00_AXI_bresp(s_axi_bresp),
        .S00_AXI_bvalid(s_axi_bvalid),
        .S00_AXI_rdata(s_axi_rdata),
        .S00_AXI_rready(s_axi_rready),
        .S00_AXI_rresp(s_axi_rresp),
        .S00_AXI_rvalid(s_axi_rvalid),
        .S00_AXI_wdata(s_axi_wdata),
        .S00_AXI_wready(s_axi_wready),
        .S00_AXI_wstrb(s_axi_wstrb),
        .S00_AXI_wvalid(s_axi_wvalid),
        .aclk(s_axi_aclk),
        .aresetn(s_axi_aresetn));
endmodule

(* X_CORE_INFO = "bd_6311_dp_0_dport_wrapper,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_dp_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    axi_int,
    rx_vid_clk,
    rx_vid_rst,
    rx_vid_vsync,
    rx_vid_hsync,
    rx_vid_oddeven,
    rx_vid_enable,
    rx_vid_pixel0,
    rx_vid_pixel1,
    rx_vid_pixel2,
    rx_vid_pixel3,
    lnk_m_vid,
    lnk_n_vid,
    aux_rx_data_in,
    aux_rx_data_out,
    aux_rx_data_en_out_n,
    rx_hpd,
    i2c_sda_in,
    i2c_sda_enable_n,
    i2c_sda_o,
    i2c_scl_in,
    i2c_scl_enable_n,
    i2c_scl_o,
    aud_rst,
    rx_lnk_clk,
    lnk_rx_axi4s_lane0_tdata,
    lnk_rx_axi4s_lane0_tuser,
    lnk_rx_axi4s_lane0_tvalid,
    lnk_rx_axi4s_lane0_tready,
    lnk_rx_axi4s_lane1_tdata,
    lnk_rx_axi4s_lane1_tuser,
    lnk_rx_axi4s_lane1_tvalid,
    lnk_rx_axi4s_lane1_tready,
    lnk_rx_axi4s_lane2_tdata,
    lnk_rx_axi4s_lane2_tuser,
    lnk_rx_axi4s_lane2_tvalid,
    lnk_rx_axi4s_lane2_tready,
    lnk_rx_axi4s_lane3_tdata,
    lnk_rx_axi4s_lane3_tuser,
    lnk_rx_axi4s_lane3_tvalid,
    lnk_rx_axi4s_lane3_tready,
    lnk_rx_sb_status_axi4s_tdata,
    lnk_rx_sb_status_axi4s_tvalid,
    lnk_rx_sb_status_axi4s_tready,
    lnk_rx_sb_control_axi4s_tdata,
    lnk_rx_sb_control_axi4s_tvalid,
    lnk_rx_sb_control_axi4s_tready,
    lnk_m_aud,
    lnk_n_aud,
    m_aud_axis_aclk,
    m_aud_axis_aresetn,
    m_axis_audio_egress_tdata,
    m_axis_audio_egress_tid,
    m_axis_audio_egress_tvalid,
    m_axis_audio_egress_tready,
    link_bw_high_out,
    link_bw_hbr2_out,
    bw_changed_out,
    rx_vid_pixel_mode,
    rx_vid_msa_hres,
    rx_vid_msa_vres,
    rx_bpc,
    rx_cformat,
    acr_m_aud,
    acr_n_aud,
    acr_valid);
  input s_axi_aclk;
  input s_axi_aresetn;
  input [31:0]s_axi_awaddr;
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
  input [31:0]s_axi_araddr;
  input [2:0]s_axi_arprot;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  output axi_int;
  input rx_vid_clk;
  input rx_vid_rst;
  output rx_vid_vsync;
  output rx_vid_hsync;
  output rx_vid_oddeven;
  output rx_vid_enable;
  output [47:0]rx_vid_pixel0;
  output [47:0]rx_vid_pixel1;
  output [47:0]rx_vid_pixel2;
  output [47:0]rx_vid_pixel3;
  output [23:0]lnk_m_vid;
  output [23:0]lnk_n_vid;
  input aux_rx_data_in;
  output aux_rx_data_out;
  output aux_rx_data_en_out_n;
  output rx_hpd;
  input i2c_sda_in;
  output i2c_sda_enable_n;
  output i2c_sda_o;
  input i2c_scl_in;
  output i2c_scl_enable_n;
  output i2c_scl_o;
  input aud_rst;
  input rx_lnk_clk;
  input [31:0]lnk_rx_axi4s_lane0_tdata;
  input [11:0]lnk_rx_axi4s_lane0_tuser;
  input lnk_rx_axi4s_lane0_tvalid;
  output lnk_rx_axi4s_lane0_tready;
  input [31:0]lnk_rx_axi4s_lane1_tdata;
  input [11:0]lnk_rx_axi4s_lane1_tuser;
  input lnk_rx_axi4s_lane1_tvalid;
  output lnk_rx_axi4s_lane1_tready;
  input [31:0]lnk_rx_axi4s_lane2_tdata;
  input [11:0]lnk_rx_axi4s_lane2_tuser;
  input lnk_rx_axi4s_lane2_tvalid;
  output lnk_rx_axi4s_lane2_tready;
  input [31:0]lnk_rx_axi4s_lane3_tdata;
  input [11:0]lnk_rx_axi4s_lane3_tuser;
  input lnk_rx_axi4s_lane3_tvalid;
  output lnk_rx_axi4s_lane3_tready;
  input [31:0]lnk_rx_sb_status_axi4s_tdata;
  input lnk_rx_sb_status_axi4s_tvalid;
  output lnk_rx_sb_status_axi4s_tready;
  output [7:0]lnk_rx_sb_control_axi4s_tdata;
  output lnk_rx_sb_control_axi4s_tvalid;
  input lnk_rx_sb_control_axi4s_tready;
  output [23:0]lnk_m_aud;
  output [23:0]lnk_n_aud;
  input m_aud_axis_aclk;
  input m_aud_axis_aresetn;
  output [31:0]m_axis_audio_egress_tdata;
  output [7:0]m_axis_audio_egress_tid;
  output m_axis_audio_egress_tvalid;
  input m_axis_audio_egress_tready;
  output link_bw_high_out;
  output link_bw_hbr2_out;
  output bw_changed_out;
  output [2:0]rx_vid_pixel_mode;
  output [15:0]rx_vid_msa_hres;
  output [15:0]rx_vid_msa_vres;
  output [2:0]rx_bpc;
  output [2:0]rx_cformat;
  output [23:0]acr_m_aud;
  output [23:0]acr_n_aud;
  output acr_valid;


endmodule

(* X_CORE_INFO = "axi_iic,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_iic_0
   (s_axi_aclk,
    s_axi_aresetn,
    iic2intc_irpt,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    sda_i,
    sda_o,
    sda_t,
    scl_i,
    scl_o,
    scl_t,
    gpo);
  input s_axi_aclk;
  input s_axi_aresetn;
  output iic2intc_irpt;
  input [8:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [8:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  input sda_i;
  output sda_o;
  output sda_t;
  input scl_i;
  output scl_o;
  output scl_t;
  output [0:0]gpo;


endmodule

(* X_CORE_INFO = "util_vector_logic_v2_0_1_util_vector_logic,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_notof_0_0
   (Op1,
    Res);
  input [0:0]Op1;
  output [0:0]Res;


endmodule

(* X_CORE_INFO = "dp_videoaxi4s_bridge_v1_0_1,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_vb1_0
   (vid_pixel_clk,
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
    debug_port);
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

(* X_CORE_INFO = "bd_6050,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_xbar_0
   (aclk,
    aresetn,
    S00_AXI_awaddr,
    S00_AXI_awprot,
    S00_AXI_awvalid,
    S00_AXI_awready,
    S00_AXI_wdata,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    S00_AXI_wready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_bready,
    S00_AXI_araddr,
    S00_AXI_arprot,
    S00_AXI_arvalid,
    S00_AXI_arready,
    S00_AXI_rdata,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_rready,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awvalid,
    M00_AXI_awready,
    M00_AXI_wdata,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M00_AXI_wready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_bready,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arvalid,
    M00_AXI_arready,
    M00_AXI_rdata,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_rready,
    M01_AXI_awaddr,
    M01_AXI_awprot,
    M01_AXI_awvalid,
    M01_AXI_awready,
    M01_AXI_wdata,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M01_AXI_wready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_bready,
    M01_AXI_araddr,
    M01_AXI_arprot,
    M01_AXI_arvalid,
    M01_AXI_arready,
    M01_AXI_rdata,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_rready);
  input aclk;
  input aresetn;
  input [12:0]S00_AXI_awaddr;
  input [2:0]S00_AXI_awprot;
  input S00_AXI_awvalid;
  output S00_AXI_awready;
  input [31:0]S00_AXI_wdata;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;
  output S00_AXI_wready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  input S00_AXI_bready;
  input [12:0]S00_AXI_araddr;
  input [2:0]S00_AXI_arprot;
  input S00_AXI_arvalid;
  output S00_AXI_arready;
  output [31:0]S00_AXI_rdata;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input S00_AXI_rready;
  output [8:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  output M00_AXI_awvalid;
  input M00_AXI_awready;
  output [31:0]M00_AXI_wdata;
  output [3:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input M00_AXI_wready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  output M00_AXI_bready;
  output [8:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  output M00_AXI_arvalid;
  input M00_AXI_arready;
  input [31:0]M00_AXI_rdata;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output M00_AXI_rready;
  output [31:0]M01_AXI_awaddr;
  output [2:0]M01_AXI_awprot;
  output M01_AXI_awvalid;
  input M01_AXI_awready;
  output [31:0]M01_AXI_wdata;
  output [3:0]M01_AXI_wstrb;
  output M01_AXI_wvalid;
  input M01_AXI_wready;
  input [1:0]M01_AXI_bresp;
  input M01_AXI_bvalid;
  output M01_AXI_bready;
  output [31:0]M01_AXI_araddr;
  output [2:0]M01_AXI_arprot;
  output M01_AXI_arvalid;
  input M01_AXI_arready;
  input [31:0]M01_AXI_rdata;
  input [1:0]M01_AXI_rresp;
  input M01_AXI_rvalid;
  output M01_AXI_rready;


endmodule

(* CHECK_LICENSE_TYPE = "bd_6311_xlconstant_0_0,xlconstant_v1_1_7_xlconstant,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "xlconstant_v1_1_7_xlconstant,Vivado 2020.1" *) 
module dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311_xlconstant_0_0
   (dout);
  output [0:0]dout;

  wire \<const0> ;

  assign dout[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
endmodule

(* CHECK_LICENSE_TYPE = "dpss_zcu102_rx_v_dp_rxss1_0_0,bd_6311,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "bd_6311,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module dpss_zcu102_rx_v_dp_rxss1_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    rx_vid_clk,
    rx_vid_rst,
    m_axis_aclk_stream1,
    aux_rx_data_in,
    aux_rx_data_out,
    aux_rx_data_en_out_n,
    rx_lnk_clk,
    rx_hpd,
    dprxss_dp_irq,
    m_aud_axis_aclk,
    m_aud_axis_aresetn,
    acr_m_aud,
    acr_n_aud,
    acr_valid,
    ext_rst,
    dprxss_iic_irq,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    m_axis_video_stream1_tdata,
    m_axis_video_stream1_tlast,
    m_axis_video_stream1_tready,
    m_axis_video_stream1_tuser,
    m_axis_video_stream1_tvalid,
    s_axis_lnk_rx_lane0_tdata,
    s_axis_lnk_rx_lane0_tready,
    s_axis_lnk_rx_lane0_tuser,
    s_axis_lnk_rx_lane0_tvalid,
    m_axis_phy_rx_sb_control_tdata,
    m_axis_phy_rx_sb_control_tready,
    m_axis_phy_rx_sb_control_tvalid,
    s_axis_phy_rx_sb_status_tdata,
    s_axis_phy_rx_sb_status_tready,
    s_axis_phy_rx_sb_status_tvalid,
    s_axis_lnk_rx_lane3_tdata,
    s_axis_lnk_rx_lane3_tready,
    s_axis_lnk_rx_lane3_tuser,
    s_axis_lnk_rx_lane3_tvalid,
    s_axis_lnk_rx_lane2_tdata,
    s_axis_lnk_rx_lane2_tready,
    s_axis_lnk_rx_lane2_tuser,
    s_axis_lnk_rx_lane2_tvalid,
    s_axis_lnk_rx_lane1_tdata,
    s_axis_lnk_rx_lane1_tready,
    s_axis_lnk_rx_lane1_tuser,
    s_axis_lnk_rx_lane1_tvalid,
    edid_iic_scl_i,
    edid_iic_scl_o,
    edid_iic_scl_t,
    edid_iic_sda_i,
    edid_iic_sda_o,
    edid_iic_sda_t,
    ext_iic_scl_i,
    ext_iic_scl_o,
    ext_iic_scl_t,
    ext_iic_sda_i,
    ext_iic_sda_o,
    ext_iic_sda_t,
    aud_axi_egress_tdata,
    aud_axi_egress_tid,
    aud_axi_egress_tready,
    aud_axi_egress_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.s_axi_aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.s_axi_aclk, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, ASSOCIATED_BUSIF m_axis_phy_rx_sb_control:s_axi:s_axis_phy_rx_sb_status, ASSOCIATED_RESET s_axi_aresetn, INSERT_VIP 0, ASSOCIATED_CLKEN s_sc_aclken" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.s_axi_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.rx_vid_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.rx_vid_clk, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, ASSOCIATED_RESET rx_vid_rst, INSERT_VIP 0" *) input rx_vid_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.rx_vid_rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.rx_vid_rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input rx_vid_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.m_axis_aclk_stream1 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.m_axis_aclk_stream1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, ASSOCIATED_BUSIF m_axis_video_stream1, INSERT_VIP 0" *) input m_axis_aclk_stream1;
  input aux_rx_data_in;
  output aux_rx_data_out;
  output aux_rx_data_en_out_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.rx_lnk_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.rx_lnk_clk, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, ASSOCIATED_BUSIF s_axis_lnk_rx_lane0:s_axis_lnk_rx_lane1:s_axis_lnk_rx_lane2:s_axis_lnk_rx_lane3, INSERT_VIP 0" *) input rx_lnk_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.rx_hpd DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.rx_hpd, LAYERED_METADATA undef" *) output rx_hpd;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.dprxss_dp_irq INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.dprxss_dp_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output dprxss_dp_irq;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.m_aud_axis_aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.m_aud_axis_aclk, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, ASSOCIATED_BUSIF aud_axi_egress, ASSOCIATED_RESET m_aud_axis_aresetn, INSERT_VIP 0" *) input m_aud_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.m_aud_axis_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.m_aud_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input m_aud_axis_aresetn;
  output [23:0]acr_m_aud;
  output [23:0]acr_n_aud;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.acr_valid DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.acr_valid, LAYERED_METADATA undef" *) output acr_valid;
  output [0:0]ext_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.dprxss_iic_irq INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.dprxss_iic_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output dprxss_iic_irq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [12:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWPROT" *) input [2:0]s_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input [0:0]s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output [0:0]s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input [0:0]s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output [0:0]s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output [0:0]s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input [0:0]s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [12:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input [0:0]s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output [0:0]s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output [0:0]s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 13, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [0:0]s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TDATA" *) output [119:0]m_axis_video_stream1_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TLAST" *) output m_axis_video_stream1_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TREADY" *) input m_axis_video_stream1_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TUSER" *) output [0:0]m_axis_video_stream1_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_video_stream1, TDATA_NUM_BYTES 15, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 300000000, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_video_stream1_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TDATA" *) input [31:0]s_axis_lnk_rx_lane0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TREADY" *) output s_axis_lnk_rx_lane0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TUSER" *) input [11:0]s_axis_lnk_rx_lane0_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_lnk_rx_lane0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TDATA" *) output [7:0]m_axis_phy_rx_sb_control_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TREADY" *) input m_axis_phy_rx_sb_control_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_phy_rx_sb_control, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_phy_rx_sb_control_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TDATA" *) input [31:0]s_axis_phy_rx_sb_status_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TREADY" *) output s_axis_phy_rx_sb_status_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_phy_rx_sb_status, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_phy_rx_sb_status_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TDATA" *) input [31:0]s_axis_lnk_rx_lane3_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TREADY" *) output s_axis_lnk_rx_lane3_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TUSER" *) input [11:0]s_axis_lnk_rx_lane3_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane3, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_lnk_rx_lane3_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TDATA" *) input [31:0]s_axis_lnk_rx_lane2_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TREADY" *) output s_axis_lnk_rx_lane2_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TUSER" *) input [11:0]s_axis_lnk_rx_lane2_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane2, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_lnk_rx_lane2_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TDATA" *) input [31:0]s_axis_lnk_rx_lane1_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TREADY" *) output s_axis_lnk_rx_lane1_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TUSER" *) input [11:0]s_axis_lnk_rx_lane1_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_lnk_rx_lane1, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_lnk_rx_lane1_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_I" *) input edid_iic_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_O" *) output edid_iic_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SCL_T" *) output edid_iic_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_I" *) input edid_iic_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_O" *) output edid_iic_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 edid_iic SDA_T" *) output edid_iic_sda_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_I" *) input ext_iic_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_O" *) output ext_iic_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SCL_T" *) output ext_iic_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_I" *) input ext_iic_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_O" *) output ext_iic_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 ext_iic SDA_T" *) output ext_iic_sda_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TDATA" *) output [31:0]aud_axi_egress_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TID" *) output [7:0]aud_axi_egress_tid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TREADY" *) input aud_axi_egress_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 aud_axi_egress TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aud_axi_egress, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *) output aud_axi_egress_tvalid;

  wire [23:0]acr_m_aud;
  wire [23:0]acr_n_aud;
  wire acr_valid;
  wire [31:0]aud_axi_egress_tdata;
  wire [7:0]aud_axi_egress_tid;
  wire aud_axi_egress_tready;
  wire aud_axi_egress_tvalid;
  wire aux_rx_data_en_out_n;
  wire aux_rx_data_in;
  wire aux_rx_data_out;
  wire dprxss_dp_irq;
  wire dprxss_iic_irq;
  wire edid_iic_scl_i;
  wire edid_iic_scl_o;
  wire edid_iic_scl_t;
  wire edid_iic_sda_i;
  wire edid_iic_sda_o;
  wire edid_iic_sda_t;
  wire ext_iic_scl_i;
  wire ext_iic_scl_o;
  wire ext_iic_scl_t;
  wire ext_iic_sda_i;
  wire ext_iic_sda_o;
  wire ext_iic_sda_t;
  wire [0:0]ext_rst;
  wire m_aud_axis_aclk;
  wire m_aud_axis_aresetn;
  wire m_axis_aclk_stream1;
  wire [7:0]m_axis_phy_rx_sb_control_tdata;
  wire m_axis_phy_rx_sb_control_tready;
  wire m_axis_phy_rx_sb_control_tvalid;
  wire [119:0]m_axis_video_stream1_tdata;
  wire m_axis_video_stream1_tlast;
  wire m_axis_video_stream1_tready;
  wire [0:0]m_axis_video_stream1_tuser;
  wire m_axis_video_stream1_tvalid;
  wire rx_hpd;
  wire rx_lnk_clk;
  wire rx_vid_clk;
  wire rx_vid_rst;
  wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire [2:0]s_axi_arprot;
  wire [0:0]s_axi_arready;
  wire [0:0]s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire [2:0]s_axi_awprot;
  wire [0:0]s_axi_awready;
  wire [0:0]s_axi_awvalid;
  wire [0:0]s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire [0:0]s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire [0:0]s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire [0:0]s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [0:0]s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire [0:0]s_axi_wvalid;
  wire [31:0]s_axis_lnk_rx_lane0_tdata;
  wire s_axis_lnk_rx_lane0_tready;
  wire [11:0]s_axis_lnk_rx_lane0_tuser;
  wire s_axis_lnk_rx_lane0_tvalid;
  wire [31:0]s_axis_lnk_rx_lane1_tdata;
  wire s_axis_lnk_rx_lane1_tready;
  wire [11:0]s_axis_lnk_rx_lane1_tuser;
  wire s_axis_lnk_rx_lane1_tvalid;
  wire [31:0]s_axis_lnk_rx_lane2_tdata;
  wire s_axis_lnk_rx_lane2_tready;
  wire [11:0]s_axis_lnk_rx_lane2_tuser;
  wire s_axis_lnk_rx_lane2_tvalid;
  wire [31:0]s_axis_lnk_rx_lane3_tdata;
  wire s_axis_lnk_rx_lane3_tready;
  wire [11:0]s_axis_lnk_rx_lane3_tuser;
  wire s_axis_lnk_rx_lane3_tvalid;
  wire [31:0]s_axis_phy_rx_sb_status_tdata;
  wire s_axis_phy_rx_sb_status_tready;
  wire s_axis_phy_rx_sb_status_tvalid;

  (* HW_HANDOFF = "dpss_zcu102_rx_v_dp_rxss1_0_0.hwdef" *) 
  dpss_zcu102_rx_v_dp_rxss1_0_0_bd_6311 inst
       (.acr_m_aud(acr_m_aud),
        .acr_n_aud(acr_n_aud),
        .acr_valid(acr_valid),
        .aud_axi_egress_tdata(aud_axi_egress_tdata),
        .aud_axi_egress_tid(aud_axi_egress_tid),
        .aud_axi_egress_tready(aud_axi_egress_tready),
        .aud_axi_egress_tvalid(aud_axi_egress_tvalid),
        .aux_rx_data_en_out_n(aux_rx_data_en_out_n),
        .aux_rx_data_in(aux_rx_data_in),
        .aux_rx_data_out(aux_rx_data_out),
        .dprxss_dp_irq(dprxss_dp_irq),
        .dprxss_iic_irq(dprxss_iic_irq),
        .edid_iic_scl_i(edid_iic_scl_i),
        .edid_iic_scl_o(edid_iic_scl_o),
        .edid_iic_scl_t(edid_iic_scl_t),
        .edid_iic_sda_i(edid_iic_sda_i),
        .edid_iic_sda_o(edid_iic_sda_o),
        .edid_iic_sda_t(edid_iic_sda_t),
        .ext_iic_scl_i(ext_iic_scl_i),
        .ext_iic_scl_o(ext_iic_scl_o),
        .ext_iic_scl_t(ext_iic_scl_t),
        .ext_iic_sda_i(ext_iic_sda_i),
        .ext_iic_sda_o(ext_iic_sda_o),
        .ext_iic_sda_t(ext_iic_sda_t),
        .ext_rst(ext_rst),
        .m_aud_axis_aclk(m_aud_axis_aclk),
        .m_aud_axis_aresetn(m_aud_axis_aresetn),
        .m_axis_aclk_stream1(m_axis_aclk_stream1),
        .m_axis_phy_rx_sb_control_tdata(m_axis_phy_rx_sb_control_tdata),
        .m_axis_phy_rx_sb_control_tready(m_axis_phy_rx_sb_control_tready),
        .m_axis_phy_rx_sb_control_tvalid(m_axis_phy_rx_sb_control_tvalid),
        .m_axis_video_stream1_tdata(m_axis_video_stream1_tdata),
        .m_axis_video_stream1_tlast(m_axis_video_stream1_tlast),
        .m_axis_video_stream1_tready(m_axis_video_stream1_tready),
        .m_axis_video_stream1_tuser(m_axis_video_stream1_tuser),
        .m_axis_video_stream1_tvalid(m_axis_video_stream1_tvalid),
        .rx_hpd(rx_hpd),
        .rx_lnk_clk(rx_lnk_clk),
        .rx_vid_clk(rx_vid_clk),
        .rx_vid_rst(rx_vid_rst),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arprot(s_axi_arprot),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awprot(s_axi_awprot),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axis_lnk_rx_lane0_tdata(s_axis_lnk_rx_lane0_tdata),
        .s_axis_lnk_rx_lane0_tready(s_axis_lnk_rx_lane0_tready),
        .s_axis_lnk_rx_lane0_tuser(s_axis_lnk_rx_lane0_tuser),
        .s_axis_lnk_rx_lane0_tvalid(s_axis_lnk_rx_lane0_tvalid),
        .s_axis_lnk_rx_lane1_tdata(s_axis_lnk_rx_lane1_tdata),
        .s_axis_lnk_rx_lane1_tready(s_axis_lnk_rx_lane1_tready),
        .s_axis_lnk_rx_lane1_tuser(s_axis_lnk_rx_lane1_tuser),
        .s_axis_lnk_rx_lane1_tvalid(s_axis_lnk_rx_lane1_tvalid),
        .s_axis_lnk_rx_lane2_tdata(s_axis_lnk_rx_lane2_tdata),
        .s_axis_lnk_rx_lane2_tready(s_axis_lnk_rx_lane2_tready),
        .s_axis_lnk_rx_lane2_tuser(s_axis_lnk_rx_lane2_tuser),
        .s_axis_lnk_rx_lane2_tvalid(s_axis_lnk_rx_lane2_tvalid),
        .s_axis_lnk_rx_lane3_tdata(s_axis_lnk_rx_lane3_tdata),
        .s_axis_lnk_rx_lane3_tready(s_axis_lnk_rx_lane3_tready),
        .s_axis_lnk_rx_lane3_tuser(s_axis_lnk_rx_lane3_tuser),
        .s_axis_lnk_rx_lane3_tvalid(s_axis_lnk_rx_lane3_tvalid),
        .s_axis_phy_rx_sb_status_tdata(s_axis_phy_rx_sb_status_tdata),
        .s_axis_phy_rx_sb_status_tready(s_axis_phy_rx_sb_status_tready),
        .s_axis_phy_rx_sb_status_tvalid(s_axis_phy_rx_sb_status_tvalid));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
