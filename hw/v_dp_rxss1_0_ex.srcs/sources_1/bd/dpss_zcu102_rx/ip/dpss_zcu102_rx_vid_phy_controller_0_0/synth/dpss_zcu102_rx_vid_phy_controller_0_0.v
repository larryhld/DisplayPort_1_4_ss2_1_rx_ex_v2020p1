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


// IP VLNV: xilinx.com:ip:vid_phy_controller:2.2
// IP Revision: 5

(* X_CORE_INFO = "dpss_zcu102_rx_vid_phy_controller_0_0_top,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "dpss_zcu102_rx_vid_phy_controller_0_0,dpss_zcu102_rx_vid_phy_controller_0_0_top,{}" *)
(* CORE_GENERATION_INFO = "dpss_zcu102_rx_vid_phy_controller_0_0,dpss_zcu102_rx_vid_phy_controller_0_0_top,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=vid_phy_controller,x_ipVersion=2.2,x_ipCoreRevision=5,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_COMPONENT_NAME=dpss_zcu102_rx_vid_phy_controller_0_0,C_FAMILY=zynquplus,C_DEVICE=xczu9eg,C_SILICON_REVISION=0,C_SPEEDGRADE=-2,C_SupportLevel=1,C_TransceiverControl=false,c_sub_core_name=dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper,C_Tx_Protocol=\
3,C_Rx_Protocol=0,C_Tx_No_Of_Channels=4,C_Rx_No_Of_Channels=4,C_TX_PLL_SELECTION=2,C_TX_REFCLK_SEL=0,C_RX_PLL_SELECTION=0,C_RX_REFCLK_SEL=1,C_NIDRU_REFCLK_SEL=0,C_vid_phy_tx_axi4s_ch_TDATA_WIDTH=32,C_vid_phy_tx_axi4s_ch_INT_TDATA_WIDTH=40,C_vid_phy_tx_axi4s_ch_TUSER_WIDTH=12,C_vid_phy_rx_axi4s_ch_TDATA_WIDTH=32,C_vid_phy_rx_axi4s_ch_INT_TDATA_WIDTH=40,C_vid_phy_rx_axi4s_ch_TUSER_WIDTH=12,C_vid_phy_control_sb_tx_TDATA_WIDTH=1,C_vid_phy_status_sb_tx_TDATA_WIDTH=1,C_vid_phy_control_sb_rx_TDATA_WIDT\
H=8,C_vid_phy_status_sb_rx_TDATA_WIDTH=16,C_vid_phy_axi4lite_DATA_WIDTH=32,C_vid_phy_axi4lite_ADDR_WIDTH=10,C_NIDRU=0,Tx_Buffer_Bypass=0,C_Txrefclk_Rdy_Invert=0,C_INPUT_PIXELS_PER_CLOCK=4,C_Hdmi_Fast_Switch=1,C_Err_Irq_En=0,C_Use_GT_CH4_HDMI=0}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module dpss_zcu102_rx_vid_phy_controller_0_0 (
  mgtrefclk0_in,
  mgtrefclk1_in,
  gtnorthrefclk0_in,
  gtnorthrefclk1_in,
  gtsouthrefclk0_in,
  gtsouthrefclk1_in,
  gtnorthrefclk00_in,
  gtnorthrefclk01_in,
  gtnorthrefclk10_in,
  gtnorthrefclk11_in,
  gtsouthrefclk00_in,
  gtsouthrefclk01_in,
  gtsouthrefclk10_in,
  gtsouthrefclk11_in,
  phy_rxn_in,
  phy_rxp_in,
  rxoutclk,
  vid_phy_rx_axi4s_ch0_tdata,
  vid_phy_rx_axi4s_ch0_tuser,
  vid_phy_rx_axi4s_ch0_tvalid,
  vid_phy_rx_axi4s_ch0_tready,
  vid_phy_rx_axi4s_aclk,
  vid_phy_rx_axi4s_aresetn,
  vid_phy_rx_axi4s_ch1_tdata,
  vid_phy_rx_axi4s_ch1_tuser,
  vid_phy_rx_axi4s_ch1_tvalid,
  vid_phy_rx_axi4s_ch1_tready,
  vid_phy_rx_axi4s_ch2_tdata,
  vid_phy_rx_axi4s_ch2_tuser,
  vid_phy_rx_axi4s_ch2_tvalid,
  vid_phy_rx_axi4s_ch2_tready,
  vid_phy_rx_axi4s_ch3_tdata,
  vid_phy_rx_axi4s_ch3_tuser,
  vid_phy_rx_axi4s_ch3_tvalid,
  vid_phy_rx_axi4s_ch3_tready,
  irq,
  vid_phy_sb_aclk,
  vid_phy_sb_aresetn,
  vid_phy_control_sb_rx_tdata,
  vid_phy_control_sb_rx_tvalid,
  vid_phy_control_sb_rx_tready,
  vid_phy_status_sb_rx_tdata,
  vid_phy_status_sb_rx_tvalid,
  vid_phy_status_sb_rx_tready,
  vid_phy_axi4lite_awaddr,
  vid_phy_axi4lite_awprot,
  vid_phy_axi4lite_awvalid,
  vid_phy_axi4lite_awready,
  vid_phy_axi4lite_wdata,
  vid_phy_axi4lite_wstrb,
  vid_phy_axi4lite_wvalid,
  vid_phy_axi4lite_wready,
  vid_phy_axi4lite_bresp,
  vid_phy_axi4lite_bvalid,
  vid_phy_axi4lite_bready,
  vid_phy_axi4lite_araddr,
  vid_phy_axi4lite_arprot,
  vid_phy_axi4lite_arvalid,
  vid_phy_axi4lite_arready,
  vid_phy_axi4lite_rdata,
  vid_phy_axi4lite_rresp,
  vid_phy_axi4lite_rvalid,
  vid_phy_axi4lite_rready,
  vid_phy_axi4lite_aclk,
  vid_phy_axi4lite_aresetn,
  drpclk
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME mgtrefclk0_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_IBUF_DS_N, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 mgtrefclk0_in CLK" *)
input wire mgtrefclk0_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME mgtrefclk1_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 mgtrefclk1_in CLK" *)
input wire mgtrefclk1_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk0_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_IBUF_DS_N1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk0_in CLK" *)
input wire gtnorthrefclk0_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk1_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk1_in CLK" *)
input wire gtnorthrefclk1_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk0_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk0_in CLK" *)
input wire gtsouthrefclk0_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk1_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk1_in CLK" *)
input wire gtsouthrefclk1_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk00_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk00_in CLK" *)
input wire gtnorthrefclk00_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk01_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk01_in CLK" *)
input wire gtnorthrefclk01_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk10_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk10_in CLK" *)
input wire gtnorthrefclk10_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtnorthrefclk11_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtnorthrefclk11_in CLK" *)
input wire gtnorthrefclk11_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk00_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk00_in CLK" *)
input wire gtsouthrefclk00_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk01_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk01_in CLK" *)
input wire gtsouthrefclk01_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk10_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk10_in CLK" *)
input wire gtsouthrefclk10_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtsouthrefclk11_in, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 gtsouthrefclk11_in CLK" *)
input wire gtsouthrefclk11_in;
input wire [3 : 0] phy_rxn_in;
input wire [3 : 0] phy_rxp_in;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rxoutclk, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 rxoutclk CLK" *)
output wire rxoutclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch0 TDATA" *)
output wire [31 : 0] vid_phy_rx_axi4s_ch0_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch0 TUSER" *)
output wire [11 : 0] vid_phy_rx_axi4s_ch0_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch0 TVALID" *)
output wire vid_phy_rx_axi4s_ch0_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_ch0, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch0 TREADY" *)
input wire vid_phy_rx_axi4s_ch0_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_CLK, ASSOCIATED_BUSIF vid_phy_rx_axi4s_ch0:vid_phy_rx_axi4s_ch1:vid_phy_rx_axi4s_ch2:vid_phy_rx_axi4s_ch3, ASSOCIATED_RESET vid_phy_rx_axi4s_aresetn, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_phy_rx_axi4s_CLK CLK" *)
input wire vid_phy_rx_axi4s_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_phy_rx_axi4s_RST RST" *)
input wire vid_phy_rx_axi4s_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch1 TDATA" *)
output wire [31 : 0] vid_phy_rx_axi4s_ch1_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch1 TUSER" *)
output wire [11 : 0] vid_phy_rx_axi4s_ch1_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch1 TVALID" *)
output wire vid_phy_rx_axi4s_ch1_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_ch1, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch1 TREADY" *)
input wire vid_phy_rx_axi4s_ch1_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch2 TDATA" *)
output wire [31 : 0] vid_phy_rx_axi4s_ch2_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch2 TUSER" *)
output wire [11 : 0] vid_phy_rx_axi4s_ch2_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch2 TVALID" *)
output wire vid_phy_rx_axi4s_ch2_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_ch2, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch2 TREADY" *)
input wire vid_phy_rx_axi4s_ch2_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch3 TDATA" *)
output wire [31 : 0] vid_phy_rx_axi4s_ch3_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch3 TUSER" *)
output wire [11 : 0] vid_phy_rx_axi4s_ch3_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch3 TVALID" *)
output wire vid_phy_rx_axi4s_ch3_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_rx_axi4s_ch3, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_rx_axi4s_ch3 TREADY" *)
input wire vid_phy_rx_axi4s_ch3_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IRQ, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT" *)
output wire irq;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_sb_CLK, ASSOCIATED_BUSIF vid_phy_control_sb_tx:vid_phy_status_sb_tx:vid_phy_control_sb_rx:vid_phy_status_sb_rx, ASSOCIATED_RESET vid_phy_sb_aresetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_phy_sb_CLK CLK" *)
input wire vid_phy_sb_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_sb_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_phy_sb_RST RST" *)
input wire vid_phy_sb_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_control_sb_rx TDATA" *)
input wire [7 : 0] vid_phy_control_sb_rx_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_control_sb_rx TVALID" *)
input wire vid_phy_control_sb_rx_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_control_sb_rx, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_control_sb_rx TREADY" *)
output wire vid_phy_control_sb_rx_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_status_sb_rx TDATA" *)
output wire [15 : 0] vid_phy_status_sb_rx_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_status_sb_rx TVALID" *)
output wire vid_phy_status_sb_rx_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_status_sb_rx, WIZ.DATA_WIDTH 32, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 vid_phy_status_sb_rx TREADY" *)
input wire vid_phy_status_sb_rx_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite AWADDR" *)
input wire [9 : 0] vid_phy_axi4lite_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite AWPROT" *)
input wire [2 : 0] vid_phy_axi4lite_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite AWVALID" *)
input wire vid_phy_axi4lite_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite AWREADY" *)
output wire vid_phy_axi4lite_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite WDATA" *)
input wire [31 : 0] vid_phy_axi4lite_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite WSTRB" *)
input wire [3 : 0] vid_phy_axi4lite_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite WVALID" *)
input wire vid_phy_axi4lite_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite WREADY" *)
output wire vid_phy_axi4lite_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite BRESP" *)
output wire [1 : 0] vid_phy_axi4lite_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite BVALID" *)
output wire vid_phy_axi4lite_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite BREADY" *)
input wire vid_phy_axi4lite_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite ARADDR" *)
input wire [9 : 0] vid_phy_axi4lite_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite ARPROT" *)
input wire [2 : 0] vid_phy_axi4lite_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite ARVALID" *)
input wire vid_phy_axi4lite_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite ARREADY" *)
output wire vid_phy_axi4lite_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite RDATA" *)
output wire [31 : 0] vid_phy_axi4lite_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite RRESP" *)
output wire [1 : 0] vid_phy_axi4lite_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite RVALID" *)
output wire vid_phy_axi4lite_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_axi4lite, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 10, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, NUM_\
READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 vid_phy_axi4lite RREADY" *)
input wire vid_phy_axi4lite_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_axi4lite_CLK, ASSOCIATED_BUSIF vid_phy_axi4lite, ASSOCIATED_RESET vid_phy_axi4lite_aresetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_phy_axi4lite_CLK CLK" *)
input wire vid_phy_axi4lite_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_phy_axi4lite_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_phy_axi4lite_RST RST" *)
input wire vid_phy_axi4lite_aresetn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME drpclk, FREQ_HZ 40000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 drpclk CLK" *)
input wire drpclk;

  dpss_zcu102_rx_vid_phy_controller_0_0_top #(
    .C_COMPONENT_NAME("dpss_zcu102_rx_vid_phy_controller_0_0"),
    .C_FAMILY("zynquplus"),
    .C_DEVICE("xczu9eg"),
    .C_SILICON_REVISION("0"),
    .C_SPEEDGRADE("-2"),
    .C_SupportLevel(1),
    .C_TransceiverControl(1'B0),
    .c_sub_core_name("dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper"),
    .C_Tx_Protocol(3),  // Tx Protocol
    .C_Rx_Protocol(0),  // Rx Protocol
    .C_Tx_No_Of_Channels(4),  // No Of Tx Channels
    .C_Rx_No_Of_Channels(4),  // No Of Rx Channels
    .C_TX_PLL_SELECTION(2),  // Tx PLL Selection
    .C_TX_REFCLK_SEL(0),  // Tx Ref Clk Selection
    .C_RX_PLL_SELECTION(0),  // Rx PLL Selection
    .C_RX_REFCLK_SEL(1),  // Rx Ref Clk Selection
    .C_NIDRU_REFCLK_SEL(0),  // Ni DRU Ref Clk Selection
    .C_vid_phy_tx_axi4s_ch_TDATA_WIDTH(32),  // Tx Data Width
    .C_vid_phy_tx_axi4s_ch_INT_TDATA_WIDTH(40),  // Tx Int Data Width
    .C_vid_phy_tx_axi4s_ch_TUSER_WIDTH(12),  // Tx Data Width
    .C_vid_phy_rx_axi4s_ch_TDATA_WIDTH(32),  // Rx Data Width
    .C_vid_phy_rx_axi4s_ch_INT_TDATA_WIDTH(40),  // Rx Int Data Width
    .C_vid_phy_rx_axi4s_ch_TUSER_WIDTH(12),  // Rx Data Width
    .C_vid_phy_control_sb_tx_TDATA_WIDTH(1),  // Tx Control Data Width
    .C_vid_phy_status_sb_tx_TDATA_WIDTH(1),  // Tx Status Data Width
    .C_vid_phy_control_sb_rx_TDATA_WIDTH(8),  // Rx Control Data Width
    .C_vid_phy_status_sb_rx_TDATA_WIDTH(16),  // Rx Status Data Width
    .C_vid_phy_axi4lite_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_vid_phy_axi4lite_ADDR_WIDTH(10),  // Width of S_AXI address bus
    .C_NIDRU(0),  // Include NIDRU
    .Tx_Buffer_Bypass(0),  // Bypass TX Buffer
    .C_Txrefclk_Rdy_Invert(0),  // Tx RefClk Rdy Invert
    .C_INPUT_PIXELS_PER_CLOCK(4),  // Number of pixels per clock
    .C_Hdmi_Fast_Switch(1),  // HDMI Fast Switching
    .C_Err_Irq_En(0),  // Enable Error irq port
    .C_Use_GT_CH4_HDMI(0)  // Enable GT Channel for TMDS Clock
  ) inst (
    .tx_refclk_rdy(1'B0),
    .tx_tmds_clk(),
    .tx_video_clk(),
    .tx_tmds_clk_p(),
    .tx_tmds_clk_n(),
    .rx_tmds_clk(),
    .rx_video_clk(),
    .rx_tmds_clk_p(),
    .rx_tmds_clk_n(),
    .mgtrefclk0_pad_p_in(1'B0),
    .mgtrefclk0_pad_n_in(1'B0),
    .mgtrefclk1_pad_p_in(1'B0),
    .mgtrefclk1_pad_n_in(1'B0),
    .mgtrefclk0_in(mgtrefclk0_in),
    .mgtrefclk1_in(mgtrefclk1_in),
    .mgtrefclk0_odiv2_in(1'B0),
    .mgtrefclk1_odiv2_in(1'B0),
    .gtnorthrefclk0_in(gtnorthrefclk0_in),
    .gtnorthrefclk0_odiv2_in(1'B0),
    .gtnorthrefclk1_in(gtnorthrefclk1_in),
    .gtnorthrefclk1_odiv2_in(1'B0),
    .gtsouthrefclk0_in(gtsouthrefclk0_in),
    .gtsouthrefclk0_odiv2_in(1'B0),
    .gtsouthrefclk1_in(gtsouthrefclk1_in),
    .gtsouthrefclk1_odiv2_in(1'B0),
    .gtnorthrefclk00_in(gtnorthrefclk00_in),
    .gtnorthrefclk01_in(gtnorthrefclk01_in),
    .gtnorthrefclk10_in(gtnorthrefclk10_in),
    .gtnorthrefclk11_in(gtnorthrefclk11_in),
    .gtsouthrefclk00_in(gtsouthrefclk00_in),
    .gtsouthrefclk01_in(gtsouthrefclk01_in),
    .gtsouthrefclk10_in(gtsouthrefclk10_in),
    .gtsouthrefclk11_in(gtsouthrefclk11_in),
    .gteastrefclk0_in(1'B0),
    .gteastrefclk1_in(1'B0),
    .gtwestrefclk0_in(1'B0),
    .gtwestrefclk1_in(1'B0),
    .txrefclk_ceb(),
    .rxrefclk_ceb(),
    .phy_rxn_in(phy_rxn_in),
    .phy_rxp_in(phy_rxp_in),
    .phy_txn_out(),
    .phy_txp_out(),
    .rxoutclk(rxoutclk),
    .txoutclk(),
    .vid_phy_tx_axi4s_aclk(1'B0),
    .vid_phy_tx_axi4s_aresetn(1'B1),
    .vid_phy_tx_axi4s_ch0_tdata(32'B0),
    .vid_phy_tx_axi4s_ch0_tuser(12'B0),
    .vid_phy_tx_axi4s_ch0_tvalid(1'B0),
    .vid_phy_tx_axi4s_ch0_tready(),
    .vid_phy_tx_axi4s_ch1_tdata(32'B0),
    .vid_phy_tx_axi4s_ch1_tuser(12'B0),
    .vid_phy_tx_axi4s_ch1_tvalid(1'B0),
    .vid_phy_tx_axi4s_ch1_tready(),
    .vid_phy_tx_axi4s_ch2_tdata(32'B0),
    .vid_phy_tx_axi4s_ch2_tuser(12'B0),
    .vid_phy_tx_axi4s_ch2_tvalid(1'B0),
    .vid_phy_tx_axi4s_ch2_tready(),
    .vid_phy_tx_axi4s_ch3_tdata(32'B0),
    .vid_phy_tx_axi4s_ch3_tuser(12'B0),
    .vid_phy_tx_axi4s_ch3_tvalid(1'B0),
    .vid_phy_tx_axi4s_ch3_tready(),
    .vid_phy_rx_axi4s_ch0_tdata(vid_phy_rx_axi4s_ch0_tdata),
    .vid_phy_rx_axi4s_ch0_tuser(vid_phy_rx_axi4s_ch0_tuser),
    .vid_phy_rx_axi4s_ch0_tvalid(vid_phy_rx_axi4s_ch0_tvalid),
    .vid_phy_rx_axi4s_ch0_tready(vid_phy_rx_axi4s_ch0_tready),
    .vid_phy_rx_axi4s_aclk(vid_phy_rx_axi4s_aclk),
    .vid_phy_rx_axi4s_aresetn(vid_phy_rx_axi4s_aresetn),
    .vid_phy_rx_axi4s_ch1_tdata(vid_phy_rx_axi4s_ch1_tdata),
    .vid_phy_rx_axi4s_ch1_tuser(vid_phy_rx_axi4s_ch1_tuser),
    .vid_phy_rx_axi4s_ch1_tvalid(vid_phy_rx_axi4s_ch1_tvalid),
    .vid_phy_rx_axi4s_ch1_tready(vid_phy_rx_axi4s_ch1_tready),
    .vid_phy_rx_axi4s_ch2_tdata(vid_phy_rx_axi4s_ch2_tdata),
    .vid_phy_rx_axi4s_ch2_tuser(vid_phy_rx_axi4s_ch2_tuser),
    .vid_phy_rx_axi4s_ch2_tvalid(vid_phy_rx_axi4s_ch2_tvalid),
    .vid_phy_rx_axi4s_ch2_tready(vid_phy_rx_axi4s_ch2_tready),
    .vid_phy_rx_axi4s_ch3_tdata(vid_phy_rx_axi4s_ch3_tdata),
    .vid_phy_rx_axi4s_ch3_tuser(vid_phy_rx_axi4s_ch3_tuser),
    .vid_phy_rx_axi4s_ch3_tvalid(vid_phy_rx_axi4s_ch3_tvalid),
    .vid_phy_rx_axi4s_ch3_tready(vid_phy_rx_axi4s_ch3_tready),
    .irq(irq),
    .vid_phy_control_sb_tx_tdata(1'B0),
    .vid_phy_control_sb_tx_tvalid(1'B0),
    .vid_phy_control_sb_tx_tready(),
    .vid_phy_sb_aclk(vid_phy_sb_aclk),
    .vid_phy_sb_aresetn(vid_phy_sb_aresetn),
    .vid_phy_status_sb_tx_tdata(),
    .vid_phy_status_sb_tx_tvalid(),
    .vid_phy_status_sb_tx_tready(1'B0),
    .vid_phy_control_sb_rx_tdata(vid_phy_control_sb_rx_tdata),
    .vid_phy_control_sb_rx_tvalid(vid_phy_control_sb_rx_tvalid),
    .vid_phy_control_sb_rx_tready(vid_phy_control_sb_rx_tready),
    .vid_phy_status_sb_rx_tdata(vid_phy_status_sb_rx_tdata),
    .vid_phy_status_sb_rx_tvalid(vid_phy_status_sb_rx_tvalid),
    .vid_phy_status_sb_rx_tready(vid_phy_status_sb_rx_tready),
    .vid_phy_axi4lite_awaddr(vid_phy_axi4lite_awaddr),
    .vid_phy_axi4lite_awprot(vid_phy_axi4lite_awprot),
    .vid_phy_axi4lite_awvalid(vid_phy_axi4lite_awvalid),
    .vid_phy_axi4lite_awready(vid_phy_axi4lite_awready),
    .vid_phy_axi4lite_wdata(vid_phy_axi4lite_wdata),
    .vid_phy_axi4lite_wstrb(vid_phy_axi4lite_wstrb),
    .vid_phy_axi4lite_wvalid(vid_phy_axi4lite_wvalid),
    .vid_phy_axi4lite_wready(vid_phy_axi4lite_wready),
    .vid_phy_axi4lite_bresp(vid_phy_axi4lite_bresp),
    .vid_phy_axi4lite_bvalid(vid_phy_axi4lite_bvalid),
    .vid_phy_axi4lite_bready(vid_phy_axi4lite_bready),
    .vid_phy_axi4lite_araddr(vid_phy_axi4lite_araddr),
    .vid_phy_axi4lite_arprot(vid_phy_axi4lite_arprot),
    .vid_phy_axi4lite_arvalid(vid_phy_axi4lite_arvalid),
    .vid_phy_axi4lite_arready(vid_phy_axi4lite_arready),
    .vid_phy_axi4lite_rdata(vid_phy_axi4lite_rdata),
    .vid_phy_axi4lite_rresp(vid_phy_axi4lite_rresp),
    .vid_phy_axi4lite_rvalid(vid_phy_axi4lite_rvalid),
    .vid_phy_axi4lite_rready(vid_phy_axi4lite_rready),
    .vid_phy_axi4lite_aclk(vid_phy_axi4lite_aclk),
    .vid_phy_axi4lite_aresetn(vid_phy_axi4lite_aresetn),
    .drpclk(drpclk),
    .gttxpippmen_in(4'B0),
    .gttxpippmovrden_in(4'B0),
    .gttxpippmpd_in(4'B0),
    .gttxpippmsel_in(4'B0),
    .gttxpippmstepsize_in(20'B0),
    .err_irq()
  );
endmodule
