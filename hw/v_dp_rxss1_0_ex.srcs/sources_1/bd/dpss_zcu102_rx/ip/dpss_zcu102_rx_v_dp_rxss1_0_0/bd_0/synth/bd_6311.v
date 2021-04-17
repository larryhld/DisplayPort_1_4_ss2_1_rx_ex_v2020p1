//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_6311.bd
//Design : bd_6311
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_6311,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_6311,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "dpss_zcu102_rx_v_dp_rxss1_0_0.hwdef" *) 
module bd_6311
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

  wire aux_rx_data_in_1;
  wire [23:0]dp_acr_m_aud;
  wire [23:0]dp_acr_n_aud;
  wire dp_acr_valid;
  wire [31:0]dp_aud_axi_egress_TDATA;
  wire [7:0]dp_aud_axi_egress_TID;
  wire dp_aud_axi_egress_TREADY;
  wire dp_aud_axi_egress_TVALID;
  wire dp_aux_rx_data_en_out_n;
  wire dp_aux_rx_data_out;
  wire dp_axi_int;
  wire dp_dp_rx_vid_intf_str0_TX_VID_ENABLE;
  wire dp_dp_rx_vid_intf_str0_TX_VID_HSYNC;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2;
  wire [47:0]dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3;
  wire dp_dp_rx_vid_intf_str0_TX_VID_VSYNC;
  wire dp_i2c_edid_SCL_I;
  wire dp_i2c_edid_SCL_O;
  wire dp_i2c_edid_SCL_T;
  wire dp_i2c_edid_SDA_I;
  wire dp_i2c_edid_SDA_O;
  wire dp_i2c_edid_SDA_T;
  wire [7:0]dp_lnk_rx_sb_control_axi4s_TDATA;
  wire dp_lnk_rx_sb_control_axi4s_TREADY;
  wire dp_lnk_rx_sb_control_axi4s_TVALID;
  wire [2:0]dp_rx_bpc;
  wire [2:0]dp_rx_cformat;
  wire dp_rx_hpd;
  wire [15:0]dp_rx_vid_msa_hres;
  wire [2:0]dp_rx_vid_pixel_mode;
  wire iic_IIC_SCL_I;
  wire iic_IIC_SCL_O;
  wire iic_IIC_SCL_T;
  wire iic_IIC_SDA_I;
  wire iic_IIC_SDA_O;
  wire iic_IIC_SDA_T;
  wire [0:0]iic_gpo;
  wire iic_iic2intc_irpt;
  wire m_aud_axis_aclk_1;
  wire m_aud_axis_aresetn_1;
  wire m_axis_aclk_stream1_1;
  wire [0:0]notof_0_Res;
  wire rx_lnk_clk_1;
  wire rx_vid_clk_1;
  wire rx_vid_rst_1;
  wire [12:0]s_axi_1_ARADDR;
  wire [2:0]s_axi_1_ARPROT;
  wire s_axi_1_ARREADY;
  wire [0:0]s_axi_1_ARVALID;
  wire [12:0]s_axi_1_AWADDR;
  wire [2:0]s_axi_1_AWPROT;
  wire s_axi_1_AWREADY;
  wire [0:0]s_axi_1_AWVALID;
  wire [0:0]s_axi_1_BREADY;
  wire [1:0]s_axi_1_BRESP;
  wire s_axi_1_BVALID;
  wire [31:0]s_axi_1_RDATA;
  wire [0:0]s_axi_1_RREADY;
  wire [1:0]s_axi_1_RRESP;
  wire s_axi_1_RVALID;
  wire [31:0]s_axi_1_WDATA;
  wire s_axi_1_WREADY;
  wire [3:0]s_axi_1_WSTRB;
  wire [0:0]s_axi_1_WVALID;
  wire s_axi_aclk_1;
  wire s_axi_aresetn_1;
  wire [31:0]s_axis_lnk_rx_lane0_1_TDATA;
  wire s_axis_lnk_rx_lane0_1_TREADY;
  wire [11:0]s_axis_lnk_rx_lane0_1_TUSER;
  wire s_axis_lnk_rx_lane0_1_TVALID;
  wire [31:0]s_axis_lnk_rx_lane1_1_TDATA;
  wire s_axis_lnk_rx_lane1_1_TREADY;
  wire [11:0]s_axis_lnk_rx_lane1_1_TUSER;
  wire s_axis_lnk_rx_lane1_1_TVALID;
  wire [31:0]s_axis_lnk_rx_lane2_1_TDATA;
  wire s_axis_lnk_rx_lane2_1_TREADY;
  wire [11:0]s_axis_lnk_rx_lane2_1_TUSER;
  wire s_axis_lnk_rx_lane2_1_TVALID;
  wire [31:0]s_axis_lnk_rx_lane3_1_TDATA;
  wire s_axis_lnk_rx_lane3_1_TREADY;
  wire [11:0]s_axis_lnk_rx_lane3_1_TUSER;
  wire s_axis_lnk_rx_lane3_1_TVALID;
  wire [31:0]s_axis_phy_rx_sb_status_1_TDATA;
  wire s_axis_phy_rx_sb_status_1_TREADY;
  wire s_axis_phy_rx_sb_status_1_TVALID;
  wire [119:0]vb1_m_axis_video_TDATA;
  wire vb1_m_axis_video_TLAST;
  wire vb1_m_axis_video_TREADY;
  wire [0:0]vb1_m_axis_video_TUSER;
  wire vb1_m_axis_video_TVALID;
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

  assign acr_m_aud[23:0] = dp_acr_m_aud;
  assign acr_n_aud[23:0] = dp_acr_n_aud;
  assign acr_valid = dp_acr_valid;
  assign aud_axi_egress_tdata[31:0] = dp_aud_axi_egress_TDATA;
  assign aud_axi_egress_tid[7:0] = dp_aud_axi_egress_TID;
  assign aud_axi_egress_tvalid = dp_aud_axi_egress_TVALID;
  assign aux_rx_data_en_out_n = dp_aux_rx_data_en_out_n;
  assign aux_rx_data_in_1 = aux_rx_data_in;
  assign aux_rx_data_out = dp_aux_rx_data_out;
  assign dp_aud_axi_egress_TREADY = aud_axi_egress_tready;
  assign dp_i2c_edid_SCL_I = edid_iic_scl_i;
  assign dp_i2c_edid_SDA_I = edid_iic_sda_i;
  assign dp_lnk_rx_sb_control_axi4s_TREADY = m_axis_phy_rx_sb_control_tready;
  assign dprxss_dp_irq = dp_axi_int;
  assign dprxss_iic_irq = iic_iic2intc_irpt;
  assign edid_iic_scl_o = dp_i2c_edid_SCL_O;
  assign edid_iic_scl_t = dp_i2c_edid_SCL_T;
  assign edid_iic_sda_o = dp_i2c_edid_SDA_O;
  assign edid_iic_sda_t = dp_i2c_edid_SDA_T;
  assign ext_iic_scl_o = iic_IIC_SCL_O;
  assign ext_iic_scl_t = iic_IIC_SCL_T;
  assign ext_iic_sda_o = iic_IIC_SDA_O;
  assign ext_iic_sda_t = iic_IIC_SDA_T;
  assign ext_rst[0] = iic_gpo;
  assign iic_IIC_SCL_I = ext_iic_scl_i;
  assign iic_IIC_SDA_I = ext_iic_sda_i;
  assign m_aud_axis_aclk_1 = m_aud_axis_aclk;
  assign m_aud_axis_aresetn_1 = m_aud_axis_aresetn;
  assign m_axis_aclk_stream1_1 = m_axis_aclk_stream1;
  assign m_axis_phy_rx_sb_control_tdata[7:0] = dp_lnk_rx_sb_control_axi4s_TDATA;
  assign m_axis_phy_rx_sb_control_tvalid = dp_lnk_rx_sb_control_axi4s_TVALID;
  assign m_axis_video_stream1_tdata[119:0] = vb1_m_axis_video_TDATA;
  assign m_axis_video_stream1_tlast = vb1_m_axis_video_TLAST;
  assign m_axis_video_stream1_tuser[0] = vb1_m_axis_video_TUSER;
  assign m_axis_video_stream1_tvalid = vb1_m_axis_video_TVALID;
  assign rx_hpd = dp_rx_hpd;
  assign rx_lnk_clk_1 = rx_lnk_clk;
  assign rx_vid_clk_1 = rx_vid_clk;
  assign rx_vid_rst_1 = rx_vid_rst;
  assign s_axi_1_ARADDR = s_axi_araddr[12:0];
  assign s_axi_1_ARPROT = s_axi_arprot[2:0];
  assign s_axi_1_ARVALID = s_axi_arvalid[0];
  assign s_axi_1_AWADDR = s_axi_awaddr[12:0];
  assign s_axi_1_AWPROT = s_axi_awprot[2:0];
  assign s_axi_1_AWVALID = s_axi_awvalid[0];
  assign s_axi_1_BREADY = s_axi_bready[0];
  assign s_axi_1_RREADY = s_axi_rready[0];
  assign s_axi_1_WDATA = s_axi_wdata[31:0];
  assign s_axi_1_WSTRB = s_axi_wstrb[3:0];
  assign s_axi_1_WVALID = s_axi_wvalid[0];
  assign s_axi_aclk_1 = s_axi_aclk;
  assign s_axi_aresetn_1 = s_axi_aresetn;
  assign s_axi_arready[0] = s_axi_1_ARREADY;
  assign s_axi_awready[0] = s_axi_1_AWREADY;
  assign s_axi_bresp[1:0] = s_axi_1_BRESP;
  assign s_axi_bvalid[0] = s_axi_1_BVALID;
  assign s_axi_rdata[31:0] = s_axi_1_RDATA;
  assign s_axi_rresp[1:0] = s_axi_1_RRESP;
  assign s_axi_rvalid[0] = s_axi_1_RVALID;
  assign s_axi_wready[0] = s_axi_1_WREADY;
  assign s_axis_lnk_rx_lane0_1_TDATA = s_axis_lnk_rx_lane0_tdata[31:0];
  assign s_axis_lnk_rx_lane0_1_TUSER = s_axis_lnk_rx_lane0_tuser[11:0];
  assign s_axis_lnk_rx_lane0_1_TVALID = s_axis_lnk_rx_lane0_tvalid;
  assign s_axis_lnk_rx_lane0_tready = s_axis_lnk_rx_lane0_1_TREADY;
  assign s_axis_lnk_rx_lane1_1_TDATA = s_axis_lnk_rx_lane1_tdata[31:0];
  assign s_axis_lnk_rx_lane1_1_TUSER = s_axis_lnk_rx_lane1_tuser[11:0];
  assign s_axis_lnk_rx_lane1_1_TVALID = s_axis_lnk_rx_lane1_tvalid;
  assign s_axis_lnk_rx_lane1_tready = s_axis_lnk_rx_lane1_1_TREADY;
  assign s_axis_lnk_rx_lane2_1_TDATA = s_axis_lnk_rx_lane2_tdata[31:0];
  assign s_axis_lnk_rx_lane2_1_TUSER = s_axis_lnk_rx_lane2_tuser[11:0];
  assign s_axis_lnk_rx_lane2_1_TVALID = s_axis_lnk_rx_lane2_tvalid;
  assign s_axis_lnk_rx_lane2_tready = s_axis_lnk_rx_lane2_1_TREADY;
  assign s_axis_lnk_rx_lane3_1_TDATA = s_axis_lnk_rx_lane3_tdata[31:0];
  assign s_axis_lnk_rx_lane3_1_TUSER = s_axis_lnk_rx_lane3_tuser[11:0];
  assign s_axis_lnk_rx_lane3_1_TVALID = s_axis_lnk_rx_lane3_tvalid;
  assign s_axis_lnk_rx_lane3_tready = s_axis_lnk_rx_lane3_1_TREADY;
  assign s_axis_phy_rx_sb_status_1_TDATA = s_axis_phy_rx_sb_status_tdata[31:0];
  assign s_axis_phy_rx_sb_status_1_TVALID = s_axis_phy_rx_sb_status_tvalid;
  assign s_axis_phy_rx_sb_status_tready = s_axis_phy_rx_sb_status_1_TREADY;
  assign vb1_m_axis_video_TREADY = m_axis_video_stream1_tready;
  bd_6311_dp_0 dp
       (.acr_m_aud(dp_acr_m_aud),
        .acr_n_aud(dp_acr_n_aud),
        .acr_valid(dp_acr_valid),
        .aud_rst(notof_0_Res),
        .aux_rx_data_en_out_n(dp_aux_rx_data_en_out_n),
        .aux_rx_data_in(aux_rx_data_in_1),
        .aux_rx_data_out(dp_aux_rx_data_out),
        .axi_int(dp_axi_int),
        .i2c_scl_enable_n(dp_i2c_edid_SCL_T),
        .i2c_scl_in(dp_i2c_edid_SCL_I),
        .i2c_scl_o(dp_i2c_edid_SCL_O),
        .i2c_sda_enable_n(dp_i2c_edid_SDA_T),
        .i2c_sda_in(dp_i2c_edid_SDA_I),
        .i2c_sda_o(dp_i2c_edid_SDA_O),
        .lnk_rx_axi4s_lane0_tdata(s_axis_lnk_rx_lane0_1_TDATA),
        .lnk_rx_axi4s_lane0_tready(s_axis_lnk_rx_lane0_1_TREADY),
        .lnk_rx_axi4s_lane0_tuser(s_axis_lnk_rx_lane0_1_TUSER),
        .lnk_rx_axi4s_lane0_tvalid(s_axis_lnk_rx_lane0_1_TVALID),
        .lnk_rx_axi4s_lane1_tdata(s_axis_lnk_rx_lane1_1_TDATA),
        .lnk_rx_axi4s_lane1_tready(s_axis_lnk_rx_lane1_1_TREADY),
        .lnk_rx_axi4s_lane1_tuser(s_axis_lnk_rx_lane1_1_TUSER),
        .lnk_rx_axi4s_lane1_tvalid(s_axis_lnk_rx_lane1_1_TVALID),
        .lnk_rx_axi4s_lane2_tdata(s_axis_lnk_rx_lane2_1_TDATA),
        .lnk_rx_axi4s_lane2_tready(s_axis_lnk_rx_lane2_1_TREADY),
        .lnk_rx_axi4s_lane2_tuser(s_axis_lnk_rx_lane2_1_TUSER),
        .lnk_rx_axi4s_lane2_tvalid(s_axis_lnk_rx_lane2_1_TVALID),
        .lnk_rx_axi4s_lane3_tdata(s_axis_lnk_rx_lane3_1_TDATA),
        .lnk_rx_axi4s_lane3_tready(s_axis_lnk_rx_lane3_1_TREADY),
        .lnk_rx_axi4s_lane3_tuser(s_axis_lnk_rx_lane3_1_TUSER),
        .lnk_rx_axi4s_lane3_tvalid(s_axis_lnk_rx_lane3_1_TVALID),
        .lnk_rx_sb_control_axi4s_tdata(dp_lnk_rx_sb_control_axi4s_TDATA),
        .lnk_rx_sb_control_axi4s_tready(dp_lnk_rx_sb_control_axi4s_TREADY),
        .lnk_rx_sb_control_axi4s_tvalid(dp_lnk_rx_sb_control_axi4s_TVALID),
        .lnk_rx_sb_status_axi4s_tdata(s_axis_phy_rx_sb_status_1_TDATA),
        .lnk_rx_sb_status_axi4s_tready(s_axis_phy_rx_sb_status_1_TREADY),
        .lnk_rx_sb_status_axi4s_tvalid(s_axis_phy_rx_sb_status_1_TVALID),
        .m_aud_axis_aclk(m_aud_axis_aclk_1),
        .m_aud_axis_aresetn(m_aud_axis_aresetn_1),
        .m_axis_audio_egress_tdata(dp_aud_axi_egress_TDATA),
        .m_axis_audio_egress_tid(dp_aud_axi_egress_TID),
        .m_axis_audio_egress_tready(dp_aud_axi_egress_TREADY),
        .m_axis_audio_egress_tvalid(dp_aud_axi_egress_TVALID),
        .rx_bpc(dp_rx_bpc),
        .rx_cformat(dp_rx_cformat),
        .rx_hpd(dp_rx_hpd),
        .rx_lnk_clk(rx_lnk_clk_1),
        .rx_vid_clk(rx_vid_clk_1),
        .rx_vid_enable(dp_dp_rx_vid_intf_str0_TX_VID_ENABLE),
        .rx_vid_hsync(dp_dp_rx_vid_intf_str0_TX_VID_HSYNC),
        .rx_vid_msa_hres(dp_rx_vid_msa_hres),
        .rx_vid_pixel0(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0),
        .rx_vid_pixel1(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1),
        .rx_vid_pixel2(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2),
        .rx_vid_pixel3(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3),
        .rx_vid_pixel_mode(dp_rx_vid_pixel_mode),
        .rx_vid_rst(rx_vid_rst_1),
        .rx_vid_vsync(dp_dp_rx_vid_intf_str0_TX_VID_VSYNC),
        .s_axi_aclk(s_axi_aclk_1),
        .s_axi_araddr(xbar_M01_AXI_ARADDR),
        .s_axi_aresetn(s_axi_aresetn_1),
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
  bd_6311_iic_0 iic
       (.gpo(iic_gpo),
        .iic2intc_irpt(iic_iic2intc_irpt),
        .s_axi_aclk(s_axi_aclk_1),
        .s_axi_araddr(xbar_M00_AXI_ARADDR),
        .s_axi_aresetn(s_axi_aresetn_1),
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
        .scl_i(iic_IIC_SCL_I),
        .scl_o(iic_IIC_SCL_O),
        .scl_t(iic_IIC_SCL_T),
        .sda_i(iic_IIC_SDA_I),
        .sda_o(iic_IIC_SDA_O),
        .sda_t(iic_IIC_SDA_T));
  bd_6311_notof_0_0 notof_0
       (.Op1(m_aud_axis_aresetn_1),
        .Res(notof_0_Res));
  bd_6311_vb1_0 vb1
       (.bpc(dp_rx_bpc),
        .color_format(dp_rx_cformat),
        .dp_hres(dp_rx_vid_msa_hres),
        .m_axis_aclk(m_axis_aclk_stream1_1),
        .m_axis_video_tdata(vb1_m_axis_video_TDATA),
        .m_axis_video_tlast(vb1_m_axis_video_TLAST),
        .m_axis_video_tready(vb1_m_axis_video_TREADY),
        .m_axis_video_tuser(vb1_m_axis_video_TUSER),
        .m_axis_video_tvalid(vb1_m_axis_video_TVALID),
        .pixel_mode(dp_rx_vid_pixel_mode),
        .vid_active_video(dp_dp_rx_vid_intf_str0_TX_VID_ENABLE),
        .vid_hsync(dp_dp_rx_vid_intf_str0_TX_VID_HSYNC),
        .vid_pixel0(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0),
        .vid_pixel1(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1),
        .vid_pixel2(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2),
        .vid_pixel3(dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3),
        .vid_pixel_clk(rx_vid_clk_1),
        .vid_reset(rx_vid_rst_1),
        .vid_vsync(dp_dp_rx_vid_intf_str0_TX_VID_VSYNC));
  bd_6311_xbar_0 xbar
       (.M00_AXI_araddr(xbar_M00_AXI_ARADDR),
        .M00_AXI_arready(xbar_M00_AXI_ARREADY),
        .M00_AXI_arvalid(xbar_M00_AXI_ARVALID),
        .M00_AXI_awaddr(xbar_M00_AXI_AWADDR),
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
        .S00_AXI_araddr(s_axi_1_ARADDR),
        .S00_AXI_arprot(s_axi_1_ARPROT),
        .S00_AXI_arready(s_axi_1_ARREADY),
        .S00_AXI_arvalid(s_axi_1_ARVALID),
        .S00_AXI_awaddr(s_axi_1_AWADDR),
        .S00_AXI_awprot(s_axi_1_AWPROT),
        .S00_AXI_awready(s_axi_1_AWREADY),
        .S00_AXI_awvalid(s_axi_1_AWVALID),
        .S00_AXI_bready(s_axi_1_BREADY),
        .S00_AXI_bresp(s_axi_1_BRESP),
        .S00_AXI_bvalid(s_axi_1_BVALID),
        .S00_AXI_rdata(s_axi_1_RDATA),
        .S00_AXI_rready(s_axi_1_RREADY),
        .S00_AXI_rresp(s_axi_1_RRESP),
        .S00_AXI_rvalid(s_axi_1_RVALID),
        .S00_AXI_wdata(s_axi_1_WDATA),
        .S00_AXI_wready(s_axi_1_WREADY),
        .S00_AXI_wstrb(s_axi_1_WSTRB),
        .S00_AXI_wvalid(s_axi_1_WVALID),
        .aclk(s_axi_aclk_1),
        .aresetn(s_axi_aresetn_1));
  bd_6311_xlconstant_0_0 xlconstant_0
       ();
endmodule
