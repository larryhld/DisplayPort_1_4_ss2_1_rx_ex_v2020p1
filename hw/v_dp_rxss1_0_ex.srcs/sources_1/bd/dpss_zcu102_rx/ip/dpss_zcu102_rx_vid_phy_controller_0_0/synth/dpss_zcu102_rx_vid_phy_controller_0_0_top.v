
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

`include "vid_phy_controller_v2_2_5_defs.v"
`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************
(* DowngradeIPIdentifiedWarnings="yes" *)
module dpss_zcu102_rx_vid_phy_controller_0_0_top #
    (

        parameter         C_COMPONENT_NAME              = "vid_phy_controller_v",
        parameter         C_FAMILY                      = "kintex8",
        parameter         C_DEVICE                      = "xc7k325t",
        parameter         C_SPEEDGRADE                  = "-3",
        parameter         C_SILICON_REVISION            = "0",
        
        // HDMI
        parameter integer C_NIDRU                       = 0,
        parameter integer C_NIDRU_REFCLK_SEL            = 0,
        parameter integer C_TX_REFCLK_SEL               = 0,
        parameter integer C_RX_REFCLK_SEL               = 1,        
    
        parameter integer C_SupportLevel                = 0,
        parameter integer C_TransceiverControl          = "false",
        parameter         c_sub_core_name               = "subcore",
        // GT Specific Parameters       
        parameter integer C_Tx_No_Of_Channels           =  4,   // baoshan: get from modelparam
        parameter integer C_Rx_No_Of_Channels           =  4,   // baoshan: get from modelparam
        parameter integer C_Tx_Protocol                 =  3,         // baoshan: get from modelparam
        parameter integer C_Rx_Protocol                 =  0,         // baoshan: get from modelparam
        parameter integer C_TX_PLL_SELECTION            =  2,                // baoshan: get from modelparam
        parameter integer C_RX_PLL_SELECTION            =  0,                // baoshan: get from modelparam
        parameter integer C_INPUT_PIXELS_PER_CLOCK          =  4,                           // for HDMI only - value directly propagated from XGUI

        parameter integer Tx_Buffer_Bypass              = 0,
        parameter integer C_Hdmi_Fast_Switch            = 1,
        parameter integer C_Err_Irq_En                  = 0,
        
        parameter integer C_Txrefclk_Rdy_Invert         = 0,
        parameter integer C_Use_GT_CH4_HDMI             = 0,
        
        // Parameters of Axi Slave Bus Interface vid_phy_axi4lite
        parameter integer C_vid_phy_axi4lite_DATA_WIDTH         = 32,
        parameter integer C_vid_phy_axi4lite_ADDR_WIDTH         = 10,   // baoshan: 1 bit added on addr width for HDMI - review this with Vamsi
        parameter integer C_vid_phy_tx_axi4s_ch_TDATA_WIDTH     = 32,
        parameter integer C_vid_phy_tx_axi4s_ch_INT_TDATA_WIDTH = 40,
        parameter integer C_vid_phy_tx_axi4s_ch_TUSER_WIDTH     = 4,
        parameter integer C_vid_phy_rx_axi4s_ch_TDATA_WIDTH     = 32,
        parameter integer C_vid_phy_rx_axi4s_ch_INT_TDATA_WIDTH = 40,
        parameter integer C_vid_phy_rx_axi4s_ch_TUSER_WIDTH     = 4,
        parameter integer C_vid_phy_control_sb_tx_TDATA_WIDTH   = 32,
        parameter integer C_vid_phy_status_sb_tx_TDATA_WIDTH    = 32,
        parameter integer C_vid_phy_control_sb_rx_TDATA_WIDTH   = 32,
        parameter integer C_vid_phy_status_sb_rx_TDATA_WIDTH    = 32

    )
    (
        // Ports of GT
        input wire  mgtrefclk0_pad_n_in,
        input wire  mgtrefclk0_pad_p_in,
        input wire  mgtrefclk1_pad_n_in,
        input wire  mgtrefclk1_pad_p_in,
        input wire  mgtrefclk0_in,
        input wire  mgtrefclk1_in,

        input wire  drpclk,

        //7-series clocks AND 8-series CPLL clocks
        //input wire  gtgrefclk_in,
        input wire  gtnorthrefclk0_in,
        input wire  gtnorthrefclk1_in,
        input wire  gtsouthrefclk0_in,
        input wire  gtsouthrefclk1_in,
        //gtp ports
        input wire  gteastrefclk0_in,
        input wire  gteastrefclk1_in,
        input wire  gtwestrefclk0_in,
        input wire  gtwestrefclk1_in,

        // 8-series QPLL clocks
        //input wire  gtgrefclk0_in,
        //input wire  gtgrefclk1_in,
        input wire  gtnorthrefclk00_in,
        input wire  gtnorthrefclk01_in,
        input wire  gtnorthrefclk10_in,
        input wire  gtnorthrefclk11_in,
        input wire  gtsouthrefclk00_in,
        input wire  gtsouthrefclk01_in,
        input wire  gtsouthrefclk10_in,
        input wire  gtsouthrefclk11_in,

        input wire [C_Rx_No_Of_Channels-1 : 0]  phy_rxn_in,
        input wire [C_Rx_No_Of_Channels-1 : 0]  phy_rxp_in,
        output wire [C_Tx_No_Of_Channels-1 : 0]  phy_txn_out,
        output wire [C_Tx_No_Of_Channels-1 : 0]  phy_txp_out,

        // Ports of Axi Slave Bus Interface vid_phy_axi4lite
        input wire  vid_phy_axi4lite_aclk,
        input wire  vid_phy_axi4lite_aresetn,
        input wire [C_vid_phy_axi4lite_ADDR_WIDTH-1 : 0] vid_phy_axi4lite_awaddr,
        input wire [2 : 0] vid_phy_axi4lite_awprot,
        input wire  vid_phy_axi4lite_awvalid,
        output wire  vid_phy_axi4lite_awready,
        input wire [C_vid_phy_axi4lite_DATA_WIDTH-1 : 0] vid_phy_axi4lite_wdata,
        input wire [(C_vid_phy_axi4lite_DATA_WIDTH/8)-1 : 0] vid_phy_axi4lite_wstrb,
        input wire  vid_phy_axi4lite_wvalid,
        output wire  vid_phy_axi4lite_wready,
        output wire [1 : 0] vid_phy_axi4lite_bresp,
        output wire  vid_phy_axi4lite_bvalid,
        input wire  vid_phy_axi4lite_bready,
        input wire [C_vid_phy_axi4lite_ADDR_WIDTH-1 : 0] vid_phy_axi4lite_araddr,
        input wire [2 : 0] vid_phy_axi4lite_arprot,
        input wire  vid_phy_axi4lite_arvalid,
        output wire  vid_phy_axi4lite_arready,
        output wire [C_vid_phy_axi4lite_DATA_WIDTH-1 : 0] vid_phy_axi4lite_rdata,
        output wire [1 : 0] vid_phy_axi4lite_rresp,
        output wire  vid_phy_axi4lite_rvalid,
        input wire  vid_phy_axi4lite_rready,

        // Ports of Axi Slave Bus Interface vid_phy_tx_axi4s_ch0
        input wire  vid_phy_tx_axi4s_aclk,
        input wire  vid_phy_tx_axi4s_aresetn,
        
        output wire  vid_phy_tx_axi4s_ch0_tready,
        input wire [C_vid_phy_tx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_tx_axi4s_ch0_tdata,
        input wire [C_vid_phy_tx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_tx_axi4s_ch0_tuser,
        input wire  vid_phy_tx_axi4s_ch0_tvalid,

        // Ports of Axi Slave Bus Interface vid_phy_tx_axi4s_ch1
        output wire  vid_phy_tx_axi4s_ch1_tready,
        input wire [C_vid_phy_tx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_tx_axi4s_ch1_tdata,
        input wire [C_vid_phy_tx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_tx_axi4s_ch1_tuser,
        input wire  vid_phy_tx_axi4s_ch1_tvalid,

        // Ports of Axi Slave Bus Interface vid_phy_tx_axi4s_ch2
        output wire  vid_phy_tx_axi4s_ch2_tready,
        input wire [C_vid_phy_tx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_tx_axi4s_ch2_tdata,
        input wire [C_vid_phy_tx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_tx_axi4s_ch2_tuser,
        input wire  vid_phy_tx_axi4s_ch2_tvalid,

        // Ports of Axi Slave Bus Interface vid_phy_tx_axi4s_ch3
        output wire  vid_phy_tx_axi4s_ch3_tready,
        input wire [C_vid_phy_tx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_tx_axi4s_ch3_tdata,
        input wire [C_vid_phy_tx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_tx_axi4s_ch3_tuser,
        input wire  vid_phy_tx_axi4s_ch3_tvalid,

        // Ports of Axi Master Bus Interface vid_phy_rx_axi4s_ch0
        input wire  vid_phy_rx_axi4s_aclk,
        input wire  vid_phy_rx_axi4s_aresetn,
        
        output wire  vid_phy_rx_axi4s_ch0_tvalid,
        output wire [C_vid_phy_rx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_rx_axi4s_ch0_tdata,
        output wire [C_vid_phy_rx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_rx_axi4s_ch0_tuser,
        input wire  vid_phy_rx_axi4s_ch0_tready,

        // Ports of Axi Master Bus Interface vid_phy_rx_axi4s_ch1
        output wire  vid_phy_rx_axi4s_ch1_tvalid,
        output wire [C_vid_phy_rx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_rx_axi4s_ch1_tdata,
        output wire [C_vid_phy_rx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_rx_axi4s_ch1_tuser,
        input wire  vid_phy_rx_axi4s_ch1_tready,

        // Ports of Axi Master Bus Interface vid_phy_rx_axi4s_ch2
        output wire  vid_phy_rx_axi4s_ch2_tvalid,
        output wire [C_vid_phy_rx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_rx_axi4s_ch2_tdata,
        output wire [C_vid_phy_rx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_rx_axi4s_ch2_tuser,
        input wire  vid_phy_rx_axi4s_ch2_tready,

        // Ports of Axi Master Bus Interface vid_phy_rx_axi4s_ch3
        output wire  vid_phy_rx_axi4s_ch3_tvalid,
        output wire [C_vid_phy_rx_axi4s_ch_TDATA_WIDTH-1 : 0] vid_phy_rx_axi4s_ch3_tdata,
        output wire [C_vid_phy_rx_axi4s_ch_TUSER_WIDTH-1 : 0] vid_phy_rx_axi4s_ch3_tuser,
        input wire  vid_phy_rx_axi4s_ch3_tready,

        // Ports of Axi Slave Bus Interface vid_phy_control_sb_tx
        input wire  vid_phy_sb_aclk,
        input wire  vid_phy_sb_aresetn,

        output wire  vid_phy_control_sb_tx_tready,
        input wire [C_vid_phy_control_sb_tx_TDATA_WIDTH-1 : 0] vid_phy_control_sb_tx_tdata,
        input wire  vid_phy_control_sb_tx_tvalid,

        // Ports of Axi Master Bus Interface vid_phy_status_sb_tx
        output wire  vid_phy_status_sb_tx_tvalid,
        output wire [C_vid_phy_status_sb_tx_TDATA_WIDTH-1 : 0] vid_phy_status_sb_tx_tdata,
        input wire  vid_phy_status_sb_tx_tready,

        // Ports of Axi Slave Bus Interface vid_phy_control_sb_rx
        output wire  vid_phy_control_sb_rx_tready,
        input wire [C_vid_phy_control_sb_rx_TDATA_WIDTH-1 : 0] vid_phy_control_sb_rx_tdata,
        input wire  vid_phy_control_sb_rx_tvalid,

        // Ports of Axi Master Bus Interface vid_phy_status_sb_rx
        output wire  vid_phy_status_sb_rx_tvalid,
        output wire [C_vid_phy_status_sb_rx_TDATA_WIDTH-1 : 0] vid_phy_status_sb_rx_tdata,
        input wire  vid_phy_status_sb_rx_tready,

        // HDMI sideband
        input wire   tx_refclk_rdy,
        output wire  tx_tmds_clk, 
        output wire  tx_video_clk, 
        output wire  rx_tmds_clk,  
        output wire  rx_video_clk, 
        output wire  tx_tmds_clk_p,  
        output wire  tx_tmds_clk_n,         
        output wire  rx_tmds_clk_p,  
        output wire  rx_tmds_clk_n,         
        
        input wire  mgtrefclk0_odiv2_in,
        input wire  mgtrefclk1_odiv2_in,
        input wire  gtnorthrefclk0_odiv2_in,
        input wire  gtnorthrefclk1_odiv2_in,
        input wire  gtsouthrefclk0_odiv2_in,
        input wire  gtsouthrefclk1_odiv2_in,
                
        output wire  txrefclk_ceb, //To Mak: activate only if txrefclk is outside the quad i.e. NORTH, SOUTH, WEST and EAST
        output wire  rxrefclk_ceb, //To Mak: activate only if rxrefclk is outside the quad i.e. NORTH, SOUTH, WEST and EAST

                input wire  [C_Tx_No_Of_Channels   -1 : 0] gttxpippmen_in,
                input wire  [C_Tx_No_Of_Channels   -1 : 0] gttxpippmovrden_in,
                input wire  [C_Tx_No_Of_Channels   -1 : 0] gttxpippmpd_in,
                input wire  [C_Tx_No_Of_Channels   -1 : 0] gttxpippmsel_in,
                input wire  [C_Tx_No_Of_Channels*5 -1 : 0] gttxpippmstepsize_in,
        output wire err_irq,

        output wire  txoutclk,
        output wire  rxoutclk,
        output wire  irq
    );

    wire [2:0] gthtxn_out_dummy;
    wire [2:0] gthtxp_out_dummy;
    wire mgtrefclk0_i;
    wire mgtrefclk1_i;
    wire mgtrefclk0_odiv2_i;
    wire mgtrefclk1_odiv2_i;
    wire vid_phy_axi4lite_areset = ~vid_phy_axi4lite_aresetn;

    wire drpclk_i = drpclk;

    localparam pBANK0 = 5'h00;
    localparam pBANK1 = 5'h01;
    localparam pBANK2 = 5'h02;
    localparam pBANK3 = 5'h03;
    localparam GTREFCLK0 = 0;
    localparam GTREFCLK1 = 1;
    localparam GTNORTHREFCLK0 = 2;
    localparam GTNORTHREFCLK1 = 3;
    localparam GTSOUTHREFCLK0 = 4;
    localparam GTSOUTHREFCLK1 = 5;
    localparam GTEASTREFCLK0  = 6;
    localparam GTEASTREFCLK1  = 7;
    localparam GTWESTREFCLK0  = 8;
    localparam GTWESTREFCLK1  = 9;
    
    wire [2 : 0] vid_phy_rx_axi4s_tvalid;   // for NIDRU usage
    wire `tPHY_MEM_MAP_FIELDS_CONTROL   cfg_phy_mem_map_control;
    reg  `tPHY_MEM_MAP_FIELDS_STATUS    cfg_phy_mem_map_status;  
    wire [6:0] drp_txn_available;
    wire [6:0] drp_rsp_read; 
    wire [3:0] rx_sym_err_cntr_read; 

  wire i_dp_train_itr_reset;    //resets for every TP lane set access
  wire i_dp_start_of_tp1_reset; //resets GT for every start of TP1 event

    reg  `tPHY_MEM_MAP_FIELDS_CONTROL   cfg_phy_mem_map_control_b0;
    wire `tPHY_MEM_MAP_FIELDS_STATUS    cfg_phy_mem_map_status_b0;  




//Async control inputs are assigned directly to wires
wire [0 : 0] gtwiz_userclk_tx_reset_in               =  cfg_phy_mem_map_control_b0[`BUFGT_TXUSRCLK_CLEAR];
wire [0 : 0] gtwiz_userclk_tx_active_in;
wire [0 : 0] gtwiz_userclk_rx_reset_in               =  cfg_phy_mem_map_control_b0[`BUFGT_RXUSRCLK_CLEAR];
wire [0 : 0] gtwiz_userclk_rx_active_in;
    wire [0 : 0] gtwiz_buffbypass_tx_reset_in;
    wire [0 : 0] gtwiz_buffbypass_tx_start_user_in;
    wire [0 : 0] gtwiz_reset_rx_datapath_in              =  cfg_phy_mem_map_control_b0[`CH1_GTRXRESET] | i_dp_train_itr_reset | i_dp_start_of_tp1_reset;
wire [0 : 0] gtwiz_reset_rx_datapath_in_sync_drpclk;
wire [0 : 0] gtwiz_buffbypass_tx_done_out;
wire [0 : 0] gtwiz_buffbypass_tx_done_out_sync;
wire [0 : 0] gtwiz_buffbypass_tx_error_out;
wire [0 : 0] gtwiz_reset_clk_freerun_in              =  drpclk_i;
wire [0 : 0] gtwiz_reset_all_in                      =  vid_phy_axi4lite_areset;
wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in      =  cfg_phy_mem_map_control_b0[`CH1_TX_PLL_GT_RST];
wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in_sync_drpclk;
wire [0 : 0] gtwiz_reset_tx_datapath_in              =  cfg_phy_mem_map_control_b0[`CH1_GTTXRESET];
wire [0 : 0] gtwiz_reset_tx_datapath_in_sync_drpclk;
wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in      =  cfg_phy_mem_map_control_b0[`CH1_RX_PLL_GT_RST];
wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in_sync_drpclk;
wire [0 : 0] gtwiz_reset_rx_cdr_stable_out;
wire [0 : 0] gtwiz_reset_tx_done_out;
wire [0 : 0] gtwiz_reset_rx_done_out;
wire [17 : 0] gtwiz_gte4_cpll_cal_txoutclk_period_sync;
wire [17 : 0] gtwiz_gte4_cpll_cal_cnt_tol_in_sync;        
wire [71 : 0] gtwiz_gte4_cpll_cal_txoutclk_period_in;
wire [71 : 0] gtwiz_gte4_cpll_cal_cnt_tol_in;        
wire [3 : 0] gtwiz_gte4_cpll_cal_bufg_ce_in             = {4 {1'b1}};        
wire [3 : 0] gtrefclk0_in_int;
wire [3 : 0] gtrefclk1_in_int;
wire [3 : 0] gtgrefclk_in_int;     
wire [3 : 0] gtnorthrefclk0_in_int;
wire [3 : 0] gtnorthrefclk1_in_int;
wire [3 : 0] gtsouthrefclk0_in_int;
wire [3 : 0] gtsouthrefclk1_in_int;
wire [127: 0] gtwiz_userdata_tx_in;
wire [127: 0] gtwiz_userdata_rx_out;
wire [127: 0] gtwiz_userdata_rx_out_i;   // for HDMI
wire [16-1 : 0] drpaddr_common_in;
wire [0 : 0] drpclk_common_in                        = drpclk_i;
wire [15 : 0] drpdi_common_in;
wire [0 : 0] drpen_common_in;
wire [0 : 0] drpwe_common_in;
wire [0 : 0] qpll0pd_in                              =  cfg_phy_mem_map_control_b0[`CH1_QPLL0PD];
wire [2 : 0] qpll0refclksel_in                       =  cfg_phy_mem_map_control_b0[`QPLL0REFCLKSEL];
wire [0 : 0] qpll1pd_in                              =  cfg_phy_mem_map_control_b0[`CH1_QPLL1PD];
wire [2 : 0] qpll1refclksel_in                       =  cfg_phy_mem_map_control_b0[`QPLL1REFCLKSEL];
wire [15 : 0] drpdo_common_out;
wire [0 : 0] drprdy_common_out;
wire [3 : 0] cplllock_out;
wire [0 : 0] cplllock_out_dly;
wire [0 : 0] qpll0lock_out;
wire [0 : 0] qpll0lock_out_dly;
wire [0 : 0] qpll1lock_out;
wire [0 : 0] qpll1lock_out_dly;
wire [0 : 0] qpll1outclk_out;
wire [0 : 0] qpll1outrefclk_out;
wire [0 : 0] refclkoutmonitor0_out;
wire [0 : 0] refclkoutmonitor1_out;

    // HDMI does not use these signals
    wire [3 : 0] cplllockdetclk_in    =  vid_phy_axi4lite_aclk;
    wire [3 : 0] cplllocken_in        = {4{1'b1}};
    wire [3 : 0] cpllreset_in;
    wire [3 : 0] rx8b10ben_in; //sync to rxusrclk2_in
    wire [3 : 0] rxbufreset_in;
    wire [3 : 0] rxmcommaalignen_in;
    wire [3 : 0] rxpcommaalignen_in;
    wire [7 : 0] rxpd_in;   
    wire [3 : 0] rxpmareset_in;
    wire [3 : 0] rxpolarity_in;
    wire [31 : 0] tx8b10bbypass_in;
    wire [3 : 0] tx8b10ben_in;
    wire [63 : 0] txctrl0_in;
    wire [63 : 0] txctrl1_in;
    wire [31 : 0] txctrl2_in;
    wire [19 : 0] txdiffctrl_in;
    wire [3 : 0] txinhibit_in;
    wire [3 : 0] txpcsreset_in;
    wire [7 : 0] txpd_in;
    wire [3 : 0] txpmareset_in;
    wire [3 : 0] txpolarity_in;
    wire [19 : 0] txpostcursor_in;
    wire [3 : 0] rxbyteisaligned_out;
    wire [3 : 0] rxbyteisaligned_out_sync;
    wire [3 : 0] rxbyterealign_out;
    wire [3 : 0] rxcommadet_out;
    wire [63 : 0] rxctrl0_out;
    wire [63 : 0] rxctrl1_out;
    wire [31 : 0] rxctrl2_out;
    wire [31 : 0] rxctrl3_out;

wire [11 : 0] cpllrefclksel_in;
wire [39 : 0] drpaddr_in;
wire [3 : 0] drpclk_in;
wire [63 : 0] drpdi_in;
wire [3 : 0] drpen_in;
wire [3 : 0] drpwe_in;
wire [11 : 0] loopback_in;

wire [3 : 0] rxcommadeten_in;
wire [3 : 0] rxlpmen_in;
wire [7 : 0] rxpllclksel_in;
wire [3 : 0] rxprbscntreset_in;
wire [15 : 0] rxprbssel_in;
wire [7 : 0] rxsysclksel_in;
wire [3 : 0] rxusrclk_in;
wire [3 : 0] rxusrclk2_in;

wire [7 : 0] txpllclksel_in;
wire [3 : 0] txprbsforceerr_in;
wire [15 : 0] txprbssel_in;
wire [19 : 0] txprecursor_in;
wire [7 : 0] txsysclksel_in;
wire [3 : 0] txusrclk_in;
wire [3 : 0] txusrclk2_in;
wire [3 : 0] cpllfbclklost_out;
wire [3 : 0] cpllrefclklost_out;
wire [63 : 0] drpdo_out;
wire [3 : 0] drprdy_out;
wire [3 : 0] gtpowergood_out;        
wire [3 : 0] gtrefclkmonitor_out;
wire [11 : 0] rxbufstatus_out;
wire [3 : 0] rxpmaresetdone_out;
wire [3 : 0] rxprbserr_out;
wire [3 : 0] rxprbserr_out_sync;
wire [3 : 0] rxprbslocked_out;
wire [3 : 0] rxresetdone_out;
wire [7 : 0] txbufstatus_out;
wire [3 : 0] txphaligndone_out;
wire [3 : 0] txpmaresetdone_out;
wire [3 : 0] txresetdone_out;
wire [3 : 0] txoutclk_out;
wire [3 : 0] rxoutclk_out;
    



    // ---------------------- Bank 0, GT Channel 0 ------------------------------
    assign gtwiz_userdata_tx_in[31: 0] = vid_phy_tx_axi4s_ch0_tdata;
    assign txctrl1_in[15: 0]  = {12'h000, vid_phy_tx_axi4s_ch0_tuser[7:4]};
    assign txctrl0_in[15: 0]  = {12'h000, vid_phy_tx_axi4s_ch0_tuser[11:8]};
    assign txctrl2_in[7: 0]    = {4'h0,vid_phy_tx_axi4s_ch0_tuser[3:0]};
    assign vid_phy_tx_axi4s_ch0_tready    = 1'b1;
    assign vid_phy_rx_axi4s_ch0_tdata        = gtwiz_userdata_rx_out[31: 0];
    assign vid_phy_rx_axi4s_ch0_tuser[3:0] = rxctrl0_out[15: 0];
    assign vid_phy_rx_axi4s_ch0_tuser[7:4] = rxctrl1_out[15: 0];
    assign vid_phy_rx_axi4s_ch0_tuser[11:8] = rxctrl3_out[7: 0];
    assign vid_phy_rx_axi4s_ch0_tvalid       = 1'b1;

    // ---------------------- Bank 0, GT Channel 1 ------------------------------
    assign gtwiz_userdata_tx_in[63: 32] = vid_phy_tx_axi4s_ch1_tdata;
    assign txctrl1_in[31: 16]  = {12'h000, vid_phy_tx_axi4s_ch1_tuser[7:4]};
    assign txctrl0_in[31: 16]  = {12'h000, vid_phy_tx_axi4s_ch1_tuser[11:8]};
    assign txctrl2_in[15: 8]    = {4'h0,vid_phy_tx_axi4s_ch1_tuser[3:0]};
    assign vid_phy_tx_axi4s_ch1_tready    = 1'b1;
    assign vid_phy_rx_axi4s_ch1_tdata        = gtwiz_userdata_rx_out[63: 32];
    assign vid_phy_rx_axi4s_ch1_tuser[3:0] = rxctrl0_out[31: 16];
    assign vid_phy_rx_axi4s_ch1_tuser[7:4] = rxctrl1_out[31: 16];
    assign vid_phy_rx_axi4s_ch1_tuser[11:8] = rxctrl3_out[15: 8];
    assign vid_phy_rx_axi4s_ch1_tvalid       = 1'b1;

    // ---------------------- Bank 0, GT Channel 2 ------------------------------
    assign gtwiz_userdata_tx_in[95: 64] = vid_phy_tx_axi4s_ch2_tdata;
    assign txctrl1_in[47: 32]  = {12'h000, vid_phy_tx_axi4s_ch2_tuser[7:4]};
    assign txctrl0_in[47: 32]  = {12'h000, vid_phy_tx_axi4s_ch2_tuser[11:8]};
    assign txctrl2_in[23: 16]    = {4'h0,vid_phy_tx_axi4s_ch2_tuser[3:0]};
    assign vid_phy_tx_axi4s_ch2_tready    = 1'b1;
    assign vid_phy_rx_axi4s_ch2_tdata        = gtwiz_userdata_rx_out[95: 64];
    assign vid_phy_rx_axi4s_ch2_tuser[3:0] = rxctrl0_out[47: 32];
    assign vid_phy_rx_axi4s_ch2_tuser[7:4] = rxctrl1_out[47: 32];
    assign vid_phy_rx_axi4s_ch2_tuser[11:8] = rxctrl3_out[23: 16];
    assign vid_phy_rx_axi4s_ch2_tvalid       = 1'b1;

    // ---------------------- Bank 0, GT Channel 3 ------------------------------
    assign gtwiz_userdata_tx_in[127: 96] = vid_phy_tx_axi4s_ch3_tdata;
    assign txctrl1_in[63: 48]  = {12'h000, vid_phy_tx_axi4s_ch3_tuser[7:4]};
    assign txctrl0_in[63: 48]  = {12'h000, vid_phy_tx_axi4s_ch3_tuser[11:8]};
    assign txctrl2_in[31: 24]    = {4'h0,vid_phy_tx_axi4s_ch3_tuser[3:0]};
    assign vid_phy_tx_axi4s_ch3_tready    = 1'b1;
    assign vid_phy_rx_axi4s_ch3_tdata        = gtwiz_userdata_rx_out[127: 96];
    assign vid_phy_rx_axi4s_ch3_tuser[3:0] = rxctrl0_out[63: 48];
    assign vid_phy_rx_axi4s_ch3_tuser[7:4] = rxctrl1_out[63: 48];
    assign vid_phy_rx_axi4s_ch3_tuser[11:8] = rxctrl3_out[31: 24];
    assign vid_phy_rx_axi4s_ch3_tvalid       = 1'b1;

    // ---------------------------------- Symbol Error Counter: Bank 1, GT Channel 0   ------------------------------

    //Sync read pulse to GT clock domain
    reg  rx_sym_err_cntr_read_0_toggle;
    wire rx_sym_err_cntr_read_0;
    wire rx_sym_err_cntr_read_0_q;
    reg  rx_sym_err_cntr_read_0_q1;
    always@(posedge vid_phy_axi4lite_aclk) begin: rx_sync_rd_pulse_gt0_process
      if(vid_phy_axi4lite_areset) begin
        rx_sym_err_cntr_read_0_toggle <= 1'b0;
      end else if(rx_sym_err_cntr_read[0]) begin
        rx_sym_err_cntr_read_0_toggle <= ~rx_sym_err_cntr_read_0_toggle;
      end
    end 

    xpm_cdc_single #(
      .VERSION        (`XPM_CDC_VERSION       ),
      .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
      .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
      .SRC_INPUT_REG  (0                      )
    ) xpm_single_rx_sym_err_cntr_toggle_ch0_inst (
      .src_clk         ( vid_phy_axi4lite_aclk    ),
      .src_in          ( rx_sym_err_cntr_read_0_toggle ),
      .dest_clk        ( rxusrclk2_in[0] ),
      .dest_out        ( rx_sym_err_cntr_read_0_q )
    );

    assign rx_sym_err_cntr_read_0 = (rx_sym_err_cntr_read_0_q != rx_sym_err_cntr_read_0_q1);

    reg [15:0] rx_sym_err_ch_gt0 = 0;
    reg [15:0] rx_sym_err_ch_gt0_latch = 0;
    wire[15:0] rx_sym_err_ch_gt0_latch_sync;
    wire       rx_sym_err_max_0 = &rx_sym_err_ch_gt0;
    always@(posedge rxusrclk2_in[0]) begin : rx_sym_err_counter_gt0_process
      rx_sym_err_cntr_read_0_q1 <= rx_sym_err_cntr_read_0_q;
      // {Reg Read, Disparity Error, 8b10b Symbol error}
      // Errors are ORed per word. If data width is 4 bytes then any combination of disp error in those word will count as 1 error. Same for 8b10b error.
      case({rx_sym_err_cntr_read_0,|rxctrl1_out[1 : 0], |rxctrl3_out[1: 0]})
        3'b000: begin rx_sym_err_ch_gt0 <= rx_sym_err_ch_gt0; end
        3'b001: begin if(rx_sym_err_max_0==1'b0) rx_sym_err_ch_gt0 <= rx_sym_err_ch_gt0 + 1'b1; end
        3'b010: begin if(rx_sym_err_max_0==1'b0) rx_sym_err_ch_gt0 <= rx_sym_err_ch_gt0 + 1'b1; end
        3'b011: begin if(rx_sym_err_max_0==1'b0) rx_sym_err_ch_gt0 <= rx_sym_err_ch_gt0 + 2'b10; end
        3'b100, 3'b101, 3'b110, 3'b111: begin
          rx_sym_err_ch_gt0 <= 16'h0000; //Read to clear
          rx_sym_err_ch_gt0_latch <= rx_sym_err_ch_gt0;
        end 
        default: begin
          rx_sym_err_ch_gt0 <= rx_sym_err_ch_gt0;
          rx_sym_err_ch_gt0_latch <= rx_sym_err_ch_gt0_latch;
        end
      endcase
    end


  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 16      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rx_sym_err_ch0_inst (
    .src_clk         (rxusrclk2_in[0]        ),
    .src_in          (rx_sym_err_ch_gt0_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (rx_sym_err_ch_gt0_latch_sync)
  );

    // ---------------------------------- Symbol Error Counter: Bank 1, GT Channel 1   ------------------------------

    //Sync read pulse to GT clock domain
    reg  rx_sym_err_cntr_read_1_toggle;
    wire rx_sym_err_cntr_read_1;
    wire rx_sym_err_cntr_read_1_q;
    reg  rx_sym_err_cntr_read_1_q1;
    always@(posedge vid_phy_axi4lite_aclk) begin: rx_sync_rd_pulse_gt1_process
      if(vid_phy_axi4lite_areset) begin
        rx_sym_err_cntr_read_1_toggle <= 1'b0;
      end else if(rx_sym_err_cntr_read[1]) begin
        rx_sym_err_cntr_read_1_toggle <= ~rx_sym_err_cntr_read_1_toggle;
      end
    end 

    xpm_cdc_single #(
      .VERSION        (`XPM_CDC_VERSION       ),
      .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
      .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
      .SRC_INPUT_REG  (0                      )
    ) xpm_single_rx_sym_err_cntr_toggle_ch1_inst (
      .src_clk         ( vid_phy_axi4lite_aclk    ),
      .src_in          ( rx_sym_err_cntr_read_1_toggle ),
      .dest_clk        ( rxusrclk2_in[1] ),
      .dest_out        ( rx_sym_err_cntr_read_1_q )
    );

    assign rx_sym_err_cntr_read_1 = (rx_sym_err_cntr_read_1_q != rx_sym_err_cntr_read_1_q1);

    reg [15:0] rx_sym_err_ch_gt1 = 0;
    reg [15:0] rx_sym_err_ch_gt1_latch = 0;
    wire[15:0] rx_sym_err_ch_gt1_latch_sync;
    wire       rx_sym_err_max_1 = &rx_sym_err_ch_gt1;
    always@(posedge rxusrclk2_in[1]) begin : rx_sym_err_counter_gt1_process
      rx_sym_err_cntr_read_1_q1 <= rx_sym_err_cntr_read_1_q;
      // {Reg Read, Disparity Error, 8b10b Symbol error}
      // Errors are ORed per word. If data width is 4 bytes then any combination of disp error in those word will count as 1 error. Same for 8b10b error.
      case({rx_sym_err_cntr_read_1,|rxctrl1_out[17 : 16], |rxctrl3_out[9: 8]})
        3'b000: begin rx_sym_err_ch_gt1 <= rx_sym_err_ch_gt1; end
        3'b001: begin if(rx_sym_err_max_1==1'b0) rx_sym_err_ch_gt1 <= rx_sym_err_ch_gt1 + 1'b1; end
        3'b010: begin if(rx_sym_err_max_1==1'b0) rx_sym_err_ch_gt1 <= rx_sym_err_ch_gt1 + 1'b1; end
        3'b011: begin if(rx_sym_err_max_1==1'b0) rx_sym_err_ch_gt1 <= rx_sym_err_ch_gt1 + 2'b10; end
        3'b100, 3'b101, 3'b110, 3'b111: begin
          rx_sym_err_ch_gt1 <= 16'h0000; //Read to clear
          rx_sym_err_ch_gt1_latch <= rx_sym_err_ch_gt1;
        end 
        default: begin
          rx_sym_err_ch_gt1 <= rx_sym_err_ch_gt1;
          rx_sym_err_ch_gt1_latch <= rx_sym_err_ch_gt1_latch;
        end
      endcase
    end


  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 16      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rx_sym_err_ch1_inst (
    .src_clk         (rxusrclk2_in[1]        ),
    .src_in          (rx_sym_err_ch_gt1_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (rx_sym_err_ch_gt1_latch_sync)
  );

    // ---------------------------------- Symbol Error Counter: Bank 1, GT Channel 2   ------------------------------

    //Sync read pulse to GT clock domain
    reg  rx_sym_err_cntr_read_2_toggle;
    wire rx_sym_err_cntr_read_2;
    wire rx_sym_err_cntr_read_2_q;
    reg  rx_sym_err_cntr_read_2_q1;
    always@(posedge vid_phy_axi4lite_aclk) begin: rx_sync_rd_pulse_gt2_process
      if(vid_phy_axi4lite_areset) begin
        rx_sym_err_cntr_read_2_toggle <= 1'b0;
      end else if(rx_sym_err_cntr_read[2]) begin
        rx_sym_err_cntr_read_2_toggle <= ~rx_sym_err_cntr_read_2_toggle;
      end
    end 

    xpm_cdc_single #(
      .VERSION        (`XPM_CDC_VERSION       ),
      .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
      .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
      .SRC_INPUT_REG  (0                      )
    ) xpm_single_rx_sym_err_cntr_toggle_ch2_inst (
      .src_clk         ( vid_phy_axi4lite_aclk    ),
      .src_in          ( rx_sym_err_cntr_read_2_toggle ),
      .dest_clk        ( rxusrclk2_in[2] ),
      .dest_out        ( rx_sym_err_cntr_read_2_q )
    );

    assign rx_sym_err_cntr_read_2 = (rx_sym_err_cntr_read_2_q != rx_sym_err_cntr_read_2_q1);

    reg [15:0] rx_sym_err_ch_gt2 = 0;
    reg [15:0] rx_sym_err_ch_gt2_latch = 0;
    wire[15:0] rx_sym_err_ch_gt2_latch_sync;
    wire       rx_sym_err_max_2 = &rx_sym_err_ch_gt2;
    always@(posedge rxusrclk2_in[2]) begin : rx_sym_err_counter_gt2_process
      rx_sym_err_cntr_read_2_q1 <= rx_sym_err_cntr_read_2_q;
      // {Reg Read, Disparity Error, 8b10b Symbol error}
      // Errors are ORed per word. If data width is 4 bytes then any combination of disp error in those word will count as 1 error. Same for 8b10b error.
      case({rx_sym_err_cntr_read_2,|rxctrl1_out[33 : 32], |rxctrl3_out[17: 16]})
        3'b000: begin rx_sym_err_ch_gt2 <= rx_sym_err_ch_gt2; end
        3'b001: begin if(rx_sym_err_max_2==1'b0) rx_sym_err_ch_gt2 <= rx_sym_err_ch_gt2 + 1'b1; end
        3'b010: begin if(rx_sym_err_max_2==1'b0) rx_sym_err_ch_gt2 <= rx_sym_err_ch_gt2 + 1'b1; end
        3'b011: begin if(rx_sym_err_max_2==1'b0) rx_sym_err_ch_gt2 <= rx_sym_err_ch_gt2 + 2'b10; end
        3'b100, 3'b101, 3'b110, 3'b111: begin
          rx_sym_err_ch_gt2 <= 16'h0000; //Read to clear
          rx_sym_err_ch_gt2_latch <= rx_sym_err_ch_gt2;
        end 
        default: begin
          rx_sym_err_ch_gt2 <= rx_sym_err_ch_gt2;
          rx_sym_err_ch_gt2_latch <= rx_sym_err_ch_gt2_latch;
        end
      endcase
    end


  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 16      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rx_sym_err_ch2_inst (
    .src_clk         (rxusrclk2_in[2]        ),
    .src_in          (rx_sym_err_ch_gt2_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (rx_sym_err_ch_gt2_latch_sync)
  );

    // ---------------------------------- Symbol Error Counter: Bank 1, GT Channel 3   ------------------------------

    //Sync read pulse to GT clock domain
    reg  rx_sym_err_cntr_read_3_toggle;
    wire rx_sym_err_cntr_read_3;
    wire rx_sym_err_cntr_read_3_q;
    reg  rx_sym_err_cntr_read_3_q1;
    always@(posedge vid_phy_axi4lite_aclk) begin: rx_sync_rd_pulse_gt3_process
      if(vid_phy_axi4lite_areset) begin
        rx_sym_err_cntr_read_3_toggle <= 1'b0;
      end else if(rx_sym_err_cntr_read[3]) begin
        rx_sym_err_cntr_read_3_toggle <= ~rx_sym_err_cntr_read_3_toggle;
      end
    end 

    xpm_cdc_single #(
      .VERSION        (`XPM_CDC_VERSION       ),
      .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
      .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
      .SRC_INPUT_REG  (0                      )
    ) xpm_single_rx_sym_err_cntr_toggle_ch3_inst (
      .src_clk         ( vid_phy_axi4lite_aclk    ),
      .src_in          ( rx_sym_err_cntr_read_3_toggle ),
      .dest_clk        ( rxusrclk2_in[3] ),
      .dest_out        ( rx_sym_err_cntr_read_3_q )
    );

    assign rx_sym_err_cntr_read_3 = (rx_sym_err_cntr_read_3_q != rx_sym_err_cntr_read_3_q1);

    reg [15:0] rx_sym_err_ch_gt3 = 0;
    reg [15:0] rx_sym_err_ch_gt3_latch = 0;
    wire[15:0] rx_sym_err_ch_gt3_latch_sync;
    wire       rx_sym_err_max_3 = &rx_sym_err_ch_gt3;
    always@(posedge rxusrclk2_in[3]) begin : rx_sym_err_counter_gt3_process
      rx_sym_err_cntr_read_3_q1 <= rx_sym_err_cntr_read_3_q;
      // {Reg Read, Disparity Error, 8b10b Symbol error}
      // Errors are ORed per word. If data width is 4 bytes then any combination of disp error in those word will count as 1 error. Same for 8b10b error.
      case({rx_sym_err_cntr_read_3,|rxctrl1_out[49 : 48], |rxctrl3_out[25: 24]})
        3'b000: begin rx_sym_err_ch_gt3 <= rx_sym_err_ch_gt3; end
        3'b001: begin if(rx_sym_err_max_3==1'b0) rx_sym_err_ch_gt3 <= rx_sym_err_ch_gt3 + 1'b1; end
        3'b010: begin if(rx_sym_err_max_3==1'b0) rx_sym_err_ch_gt3 <= rx_sym_err_ch_gt3 + 1'b1; end
        3'b011: begin if(rx_sym_err_max_3==1'b0) rx_sym_err_ch_gt3 <= rx_sym_err_ch_gt3 + 2'b10; end
        3'b100, 3'b101, 3'b110, 3'b111: begin
          rx_sym_err_ch_gt3 <= 16'h0000; //Read to clear
          rx_sym_err_ch_gt3_latch <= rx_sym_err_ch_gt3;
        end 
        default: begin
          rx_sym_err_ch_gt3 <= rx_sym_err_ch_gt3;
          rx_sym_err_ch_gt3_latch <= rx_sym_err_ch_gt3_latch;
        end
      endcase
    end


  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 16      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rx_sym_err_ch3_inst (
    .src_clk         (rxusrclk2_in[3]        ),
    .src_in          (rx_sym_err_ch_gt3_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (rx_sym_err_ch_gt3_latch_sync)
  );




  // ---------- Channel # 0 Assignments...
  assign cpllreset_in[0] = cfg_phy_mem_map_control_b0[`CPLLRESET]; 
  assign rxbufreset_in[0] = cfg_phy_mem_map_control_b0[`CH1_RXBUFRESET]; 
  assign rxcommadeten_in[0] = 1'b1;
  assign rxmcommaalignen_in[0] = 1'b1;
  assign rxpcommaalignen_in[0] = 1'b1;
  assign rxpd_in[1: 0] = cfg_phy_mem_map_control_b0[`CH1_RXPD]; 
  assign rxpmareset_in[0: 0] = cfg_phy_mem_map_control_b0[`CH1_RXPMARESET];
  assign tx8b10bbypass_in[7: 0] = 8'h00; 
  assign txpcsreset_in[0] = cfg_phy_mem_map_control_b0[`CH1_TXPCSRESET];  
  assign txpmareset_in[0: 0] = cfg_phy_mem_map_control_b0[`CH1_TXPMARESET]; 
  assign txpostcursor_in[4: 0] = cfg_phy_mem_map_control_b0[`CH1_TXPOSTCURSOR]; 
  assign cpllrefclksel_in[2: 0] = cfg_phy_mem_map_control_b0[`CPLLREFCLKSEL];
  assign loopback_in[2: 0] = cfg_phy_mem_map_control_b0[`CH1_LOOPBACK]; 
  assign rxlpmen_in[0] = cfg_phy_mem_map_control_b0[`CH1_RXLPMEN]; //Removed dependency with RXUSRCLK2 sync
  assign rxpllclksel_in[1: 0] = cfg_phy_mem_map_control_b0[`RXPLLCLKSEL]; 
  assign rxsysclksel_in[1: 0] = cfg_phy_mem_map_control_b0[`RXSYSCLKSEL];  
  assign txpllclksel_in[1: 0] = cfg_phy_mem_map_control_b0[`TXPLLCLKSEL]; 
  assign txprecursor_in[4: 0] = cfg_phy_mem_map_control_b0[`CH1_TXPRECURSOR]; 
  assign txsysclksel_in[1: 0] = cfg_phy_mem_map_control_b0[`TXSYSCLKSEL]; 
  assign drpclk_in[0] = drpclk_i;

  // ---------- Channel # 1 Assignments...
  assign cpllreset_in[1] = cfg_phy_mem_map_control_b0[`CPLLRESET]; 
  assign rxbufreset_in[1] = cfg_phy_mem_map_control_b0[`CH2_RXBUFRESET]; 
  assign rxcommadeten_in[1] = 1'b1;
  assign rxmcommaalignen_in[1] = 1'b1;
  assign rxpcommaalignen_in[1] = 1'b1;
  assign rxpd_in[3: 2] = cfg_phy_mem_map_control_b0[`CH2_RXPD]; 
  assign rxpmareset_in[1: 1] = cfg_phy_mem_map_control_b0[`CH2_RXPMARESET];
  assign tx8b10bbypass_in[15: 8] = 8'h00; 
  assign txpcsreset_in[1] = cfg_phy_mem_map_control_b0[`CH2_TXPCSRESET];  
  assign txpmareset_in[1: 1] = cfg_phy_mem_map_control_b0[`CH2_TXPMARESET]; 
  assign txpostcursor_in[9: 5] = cfg_phy_mem_map_control_b0[`CH2_TXPOSTCURSOR]; 
  assign cpllrefclksel_in[5: 3] = cfg_phy_mem_map_control_b0[`CPLLREFCLKSEL];
  assign loopback_in[5: 3] = cfg_phy_mem_map_control_b0[`CH2_LOOPBACK]; 
  assign rxlpmen_in[1] = cfg_phy_mem_map_control_b0[`CH2_RXLPMEN]; //Removed dependency with RXUSRCLK2 sync
  assign rxpllclksel_in[3: 2] = cfg_phy_mem_map_control_b0[`RXPLLCLKSEL]; 
  assign rxsysclksel_in[3: 2] = cfg_phy_mem_map_control_b0[`RXSYSCLKSEL];  
  assign txpllclksel_in[3: 2] = cfg_phy_mem_map_control_b0[`TXPLLCLKSEL]; 
  assign txprecursor_in[9: 5] = cfg_phy_mem_map_control_b0[`CH2_TXPRECURSOR]; 
  assign txsysclksel_in[3: 2] = cfg_phy_mem_map_control_b0[`TXSYSCLKSEL]; 
  assign drpclk_in[1] = drpclk_i;

  // ---------- Channel # 2 Assignments...
  assign cpllreset_in[2] = cfg_phy_mem_map_control_b0[`CPLLRESET]; 
  assign rxbufreset_in[2] = cfg_phy_mem_map_control_b0[`CH3_RXBUFRESET]; 
  assign rxcommadeten_in[2] = 1'b1;
  assign rxmcommaalignen_in[2] = 1'b1;
  assign rxpcommaalignen_in[2] = 1'b1;
  assign rxpd_in[5: 4] = cfg_phy_mem_map_control_b0[`CH3_RXPD]; 
  assign rxpmareset_in[2: 2] = cfg_phy_mem_map_control_b0[`CH3_RXPMARESET];
  assign tx8b10bbypass_in[23: 16] = 8'h00; 
  assign txpcsreset_in[2] = cfg_phy_mem_map_control_b0[`CH3_TXPCSRESET];  
  assign txpmareset_in[2: 2] = cfg_phy_mem_map_control_b0[`CH3_TXPMARESET]; 
  assign txpostcursor_in[14: 10] = cfg_phy_mem_map_control_b0[`CH3_TXPOSTCURSOR]; 
  assign cpllrefclksel_in[8: 6] = cfg_phy_mem_map_control_b0[`CPLLREFCLKSEL];
  assign loopback_in[8: 6] = cfg_phy_mem_map_control_b0[`CH3_LOOPBACK]; 
  assign rxlpmen_in[2] = cfg_phy_mem_map_control_b0[`CH3_RXLPMEN]; //Removed dependency with RXUSRCLK2 sync
  assign rxpllclksel_in[5: 4] = cfg_phy_mem_map_control_b0[`RXPLLCLKSEL]; 
  assign rxsysclksel_in[5: 4] = cfg_phy_mem_map_control_b0[`RXSYSCLKSEL];  
  assign txpllclksel_in[5: 4] = cfg_phy_mem_map_control_b0[`TXPLLCLKSEL]; 
  assign txprecursor_in[14: 10] = cfg_phy_mem_map_control_b0[`CH3_TXPRECURSOR]; 
  assign txsysclksel_in[5: 4] = cfg_phy_mem_map_control_b0[`TXSYSCLKSEL]; 
  assign drpclk_in[2] = drpclk_i;

  // ---------- Channel # 3 Assignments...
  assign cpllreset_in[3] = cfg_phy_mem_map_control_b0[`CPLLRESET]; 
  assign rxbufreset_in[3] = cfg_phy_mem_map_control_b0[`CH4_RXBUFRESET]; 
  assign rxcommadeten_in[3] = 1'b1;
  assign rxmcommaalignen_in[3] = 1'b1;
  assign rxpcommaalignen_in[3] = 1'b1;
  assign rxpd_in[7: 6] = cfg_phy_mem_map_control_b0[`CH4_RXPD]; 
  assign rxpmareset_in[3: 3] = cfg_phy_mem_map_control_b0[`CH4_RXPMARESET];
  assign tx8b10bbypass_in[31: 24] = 8'h00; 
  assign txpcsreset_in[3] = cfg_phy_mem_map_control_b0[`CH4_TXPCSRESET];  
  assign txpmareset_in[3: 3] = cfg_phy_mem_map_control_b0[`CH4_TXPMARESET]; 
  assign txpostcursor_in[19: 15] = cfg_phy_mem_map_control_b0[`CH4_TXPOSTCURSOR]; 
  assign cpllrefclksel_in[11: 9] = cfg_phy_mem_map_control_b0[`CPLLREFCLKSEL];
  assign loopback_in[11: 9] = cfg_phy_mem_map_control_b0[`CH4_LOOPBACK]; 
  assign rxlpmen_in[3] = cfg_phy_mem_map_control_b0[`CH4_RXLPMEN]; //Removed dependency with RXUSRCLK2 sync
  assign rxpllclksel_in[7: 6] = cfg_phy_mem_map_control_b0[`RXPLLCLKSEL]; 
  assign rxsysclksel_in[7: 6] = cfg_phy_mem_map_control_b0[`RXSYSCLKSEL];  
  assign txpllclksel_in[7: 6] = cfg_phy_mem_map_control_b0[`TXPLLCLKSEL]; 
  assign txprecursor_in[19: 15] = cfg_phy_mem_map_control_b0[`CH4_TXPRECURSOR]; 
  assign txsysclksel_in[7: 6] = cfg_phy_mem_map_control_b0[`TXSYSCLKSEL]; 
  assign drpclk_in[3] = drpclk_i;


  assign gtrefclk0_in_int[0]        = mgtrefclk0_i;
  assign gtrefclk1_in_int[0]        = mgtrefclk1_i;
  assign gtgrefclk_in_int[0]        = 1'b0;//gtgrefclk_in;     
  assign gtnorthrefclk0_in_int[0]   = gtnorthrefclk0_in;
  assign gtnorthrefclk1_in_int[0]   = gtnorthrefclk1_in;
  assign gtsouthrefclk0_in_int[0]   = gtsouthrefclk0_in;
  assign gtsouthrefclk1_in_int[0]   = gtsouthrefclk1_in;
  assign gtrefclk0_in_int[1]        = mgtrefclk0_i;
  assign gtrefclk1_in_int[1]        = mgtrefclk1_i;
  assign gtgrefclk_in_int[1]        = 1'b0;//gtgrefclk_in;     
  assign gtnorthrefclk0_in_int[1]   = gtnorthrefclk0_in;
  assign gtnorthrefclk1_in_int[1]   = gtnorthrefclk1_in;
  assign gtsouthrefclk0_in_int[1]   = gtsouthrefclk0_in;
  assign gtsouthrefclk1_in_int[1]   = gtsouthrefclk1_in;
  assign gtrefclk0_in_int[2]        = mgtrefclk0_i;
  assign gtrefclk1_in_int[2]        = mgtrefclk1_i;
  assign gtgrefclk_in_int[2]        = 1'b0;//gtgrefclk_in;     
  assign gtnorthrefclk0_in_int[2]   = gtnorthrefclk0_in;
  assign gtnorthrefclk1_in_int[2]   = gtnorthrefclk1_in;
  assign gtsouthrefclk0_in_int[2]   = gtsouthrefclk0_in;
  assign gtsouthrefclk1_in_int[2]   = gtsouthrefclk1_in;
  assign gtrefclk0_in_int[3]        = mgtrefclk0_i;
  assign gtrefclk1_in_int[3]        = mgtrefclk1_i;
  assign gtgrefclk_in_int[3]        = 1'b0;//gtgrefclk_in;     
  assign gtnorthrefclk0_in_int[3]   = gtnorthrefclk0_in;
  assign gtnorthrefclk1_in_int[3]   = gtnorthrefclk1_in;
  assign gtsouthrefclk0_in_int[3]   = gtsouthrefclk0_in;
  assign gtsouthrefclk1_in_int[3]   = gtsouthrefclk1_in;

    // Sync GT Wizard Resets
    xpm_cdc_array_single #(
      .VERSION        (`XPM_CDC_VERSION       ),
      .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
      .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
      .WIDTH          (4                      ),
      .SRC_INPUT_REG  (0                      )
    ) xpm_array_gtwiz_reset_sync_inst (
      .src_clk         (vid_phy_axi4lite_aclk        ),
      .src_in          ({
                         gtwiz_reset_tx_pll_and_datapath_in,
                         gtwiz_reset_tx_datapath_in,
                         gtwiz_reset_rx_pll_and_datapath_in,
                         gtwiz_reset_rx_datapath_in
                        }),
      .dest_clk        (drpclk_i       ),
      .dest_out        ({
                         gtwiz_reset_tx_pll_and_datapath_in_sync_drpclk,
                         gtwiz_reset_tx_datapath_in_sync_drpclk,
                         gtwiz_reset_rx_pll_and_datapath_in_sync_drpclk,
                         gtwiz_reset_rx_datapath_in_sync_drpclk
                        })
    );

    // ---------------------------------- GTHE3/4 Wrapper Instance  ------------------------------
    dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper
    gt_wrapper_inst
    (
       .gtwiz_userclk_tx_reset_in                  (gtwiz_userclk_tx_reset_in             ),
       .gtwiz_userclk_tx_active_in                 (gtwiz_userclk_tx_active_in            ),
       .gtwiz_userclk_rx_reset_in                  (gtwiz_userclk_rx_reset_in             ),
       .gtwiz_userclk_rx_active_in                 (gtwiz_userclk_rx_active_in            ),
       .gtwiz_reset_clk_freerun_in                 (gtwiz_reset_clk_freerun_in            ),
       .gtwiz_reset_all_in                         (gtwiz_reset_all_in                    ),
       .gtwiz_reset_tx_pll_and_datapath_in         (gtwiz_reset_tx_pll_and_datapath_in_sync_drpclk),
       .gtwiz_reset_tx_datapath_in                 (gtwiz_reset_tx_datapath_in_sync_drpclk),
       .gtwiz_reset_rx_pll_and_datapath_in         (gtwiz_reset_rx_pll_and_datapath_in_sync_drpclk),
       .gtwiz_reset_rx_datapath_in                 (gtwiz_reset_rx_datapath_in_sync_drpclk),
       .gtwiz_reset_rx_cdr_stable_out              (gtwiz_reset_rx_cdr_stable_out         ),
       .gtwiz_reset_tx_done_out                    (gtwiz_reset_tx_done_out               ),
       .gtwiz_reset_rx_done_out                    (gtwiz_reset_rx_done_out               ),
       .gtwiz_gthe4_cpll_cal_txoutclk_period_in    (gtwiz_gte4_cpll_cal_txoutclk_period_in),
       .gtwiz_gthe4_cpll_cal_cnt_tol_in            (gtwiz_gte4_cpll_cal_cnt_tol_in       ),
       .gtwiz_gthe4_cpll_cal_bufg_ce_in            (gtwiz_gte4_cpll_cal_bufg_ce_in       ),
       .gtwiz_userdata_tx_in                       (gtwiz_userdata_tx_in                  ),
       .gtwiz_userdata_rx_out                      (gtwiz_userdata_rx_out                 ),
       .drpaddr_common_in                          (drpaddr_common_in                     ),
       .drpclk_common_in                           (drpclk_common_in                      ),
       .drpdi_common_in                            (drpdi_common_in                       ),
       .drpen_common_in                            (drpen_common_in                       ),
       .drpwe_common_in                            (drpwe_common_in                       ),
       .gtrefclk0_in                               (gtrefclk0_in_int                      ),
       .gtrefclk1_in                               (gtrefclk1_in_int                      ),
       .gtgrefclk_in                               (gtgrefclk_in_int                      ),
       .gtnorthrefclk0_in                          (gtnorthrefclk0_in_int                 ),
       .gtnorthrefclk1_in                          (gtnorthrefclk1_in_int                 ),
       .gtsouthrefclk0_in                          (gtsouthrefclk0_in_int                 ),
       .gtsouthrefclk1_in                          (gtsouthrefclk1_in_int                 ),
       .gtrefclk00_in                              (mgtrefclk0_i                          ),
       .gtrefclk01_in                              (mgtrefclk0_i                          ),
       .gtrefclk10_in                              (mgtrefclk1_i                          ),
       .gtrefclk11_in                              (mgtrefclk1_i                          ),
       .gtgrefclk0_in                              ( 1'b0                                 ),
       .gtgrefclk1_in                              ( 1'b0                                 ),
       .gtnorthrefclk00_in                         (gtnorthrefclk00_in                    ),
       .gtnorthrefclk01_in                         (gtnorthrefclk01_in                    ),
       .gtnorthrefclk10_in                         (gtnorthrefclk10_in                    ),
       .gtnorthrefclk11_in                         (gtnorthrefclk11_in                    ),
       .gtsouthrefclk00_in                         (gtsouthrefclk00_in                    ),
       .gtsouthrefclk01_in                         (gtsouthrefclk01_in                    ),
       .gtsouthrefclk10_in                         (gtsouthrefclk10_in                    ),
       .gtsouthrefclk11_in                         (gtsouthrefclk11_in                    ),
       .qpll0pd_in                                 (qpll0pd_in                            ),
       .qpll0refclksel_in                          (qpll0refclksel_in                     ),
       .qpll1pd_in                                 (qpll1pd_in                            ),
       .qpll1refclksel_in                          (qpll1refclksel_in                     ),
       .drpdo_common_out                           (drpdo_common_out                      ),
       .drprdy_common_out                          (drprdy_common_out                     ),
       .qpll0lock_out                              (qpll0lock_out                         ),
       .qpll1lock_out                              (qpll1lock_out                         ),
       .qpll1outclk_out                            (qpll1outclk_out                       ),
       .qpll1outrefclk_out                         (qpll1outrefclk_out                    ),
       .refclkoutmonitor0_out                      (refclkoutmonitor0_out                 ),
       .refclkoutmonitor1_out                      (refclkoutmonitor1_out                 ),
       .cplllockdetclk_in                          (cplllockdetclk_in                     ),
       .cplllocken_in                              (cplllocken_in                         ),
       .cpllreset_in                               (cpllreset_in                          ),
       .cplllock_out                               (cplllock_out                          ),
       .cpllrefclksel_in                           (cpllrefclksel_in                      ),
       .drpaddr_in                                 (drpaddr_in                            ),
       .drpclk_in                                  (drpclk_in                             ),
       .drpdi_in                                   (drpdi_in                              ),
       .drpen_in                                   (drpen_in                              ),
       .drpwe_in                                   (drpwe_in                              ),
       .gthrxn_in                                  (phy_rxn_in                            ),
       .gthrxp_in                                  (phy_rxp_in                            ),
       .loopback_in                                (loopback_in                           ),
       .rx8b10ben_in                               (rx8b10ben_in                          ),
       .rxbufreset_in                              (rxbufreset_in                         ),
       .rxcommadeten_in                            (rxcommadeten_in                       ),
       .rxmcommaalignen_in                         (rxmcommaalignen_in                    ),
       .rxpcommaalignen_in                         (rxpcommaalignen_in                    ),
       .rxpd_in                                    (rxpd_in                               ),
       .rxpmareset_in                              (rxpmareset_in                         ),
       .rxpolarity_in                              (rxpolarity_in                         ),
       .rxlpmen_in                                 (rxlpmen_in                            ),
       .rxpllclksel_in                             (rxpllclksel_in                        ),
       .rxprbscntreset_in                          (rxprbscntreset_in                     ),
       .rxprbssel_in                               (rxprbssel_in                          ),
       .rxsysclksel_in                             (rxsysclksel_in                        ),
       .rxusrclk_in                                (rxusrclk_in                           ),
       .rxusrclk2_in                               (rxusrclk2_in                          ),
       .tx8b10bbypass_in                           (tx8b10bbypass_in                      ),
       .tx8b10ben_in                               (tx8b10ben_in                          ),
       .txctrl0_in                                 (txctrl0_in                            ),
       .txctrl1_in                                 (txctrl1_in                            ),
       .txctrl2_in                                 (txctrl2_in                            ),
       .txpcsreset_in                              (txpcsreset_in                         ),
       .txpd_in                                    (txpd_in                               ),
       .txpmareset_in                              (txpmareset_in                         ),
       .txdiffctrl_in                              (txdiffctrl_in                         ),
       .txpolarity_in                              (txpolarity_in                         ),
       .txinhibit_in                               (txinhibit_in                          ),
       .txpostcursor_in                            (txpostcursor_in                       ),
       .txpllclksel_in                             (txpllclksel_in                        ),
       .txprbsforceerr_in                          (txprbsforceerr_in                     ),
       .txprbssel_in                               (txprbssel_in                          ),
       .txprecursor_in                             (txprecursor_in                        ),
       .txsysclksel_in                             (txsysclksel_in                        ),
        //RX Only use-case connect txusrclk to rxusrclk to avoid critical warnings
       .txusrclk_in                                (rxusrclk2_in                          ),
       .txusrclk2_in                               (rxusrclk2_in                          ),
       .cpllfbclklost_out                          (cpllfbclklost_out                     ),
       .cpllrefclklost_out                         (cpllrefclklost_out                    ),
       .drpdo_out                                  (drpdo_out                             ),
       .drprdy_out                                 (drprdy_out                            ),
       .gtpowergood_out                            (gtpowergood_out                       ),
       .gtrefclkmonitor_out                        (gtrefclkmonitor_out                   ),
       .rxbufstatus_out                            (rxbufstatus_out                       ),
       .rxbyteisaligned_out                        (rxbyteisaligned_out                   ),
       .rxbyterealign_out                          (rxbyterealign_out                     ),
       .rxcommadet_out                             (rxcommadet_out                        ),
       .rxctrl0_out                                (rxctrl0_out                           ),
       .rxctrl1_out                                (rxctrl1_out                           ),
       .rxctrl2_out                                (rxctrl2_out                           ),
       .rxctrl3_out                                (rxctrl3_out                           ),
       .rxoutclk_out                               (rxoutclk_out                          ),
       .rxpmaresetdone_out                         (rxpmaresetdone_out                    ),
       .rxprbserr_out                              (rxprbserr_out                         ),
       .rxprbslocked_out                           (rxprbslocked_out                      ),
       .rxresetdone_out                            (rxresetdone_out                       ),
       .txbufstatus_out                            (txbufstatus_out                       ),
       .txoutclk_out                               (txoutclk_out                          ),
       .txphaligndone_out                          (txphaligndone_out                     ),
       .txpmaresetdone_out                         (txpmaresetdone_out                    ),
       .txresetdone_out                            (txresetdone_out                       )
    );
    // ------------------------------------------------------------------------------------------------------------

   wire       b0_MMCM_DRP_LOCKED;
   wire       b0_MMCM_DRP_LOCKED_sync;
   wire       b0_MMCM_DRP_RESET;

   assign b0_MMCM_DRP_RESET      = cfg_phy_mem_map_control_b0[`MMCM_TXUSRCLK_CONFIG_RESET];
   assign cfg_phy_mem_map_status_b0[`MMCM_TXUSRCLK_LOCKED]       =  b0_MMCM_DRP_LOCKED_sync;

  //------------------------------------------------------------------------
  // User Clock Source
  //------------------------------------------------------------------------

  assign txoutclk = txusrclk2_in[0]; //Buffer version of txout clk
  assign rxoutclk = rxusrclk2_in[0]; //Buffer version of rxout clk

  wire txusrclk_in_ch0;
  wire txusrclk2_in_ch0;
  wire rxusrclk_in_ch0;
  wire rxusrclk2_in_ch0;

  assign txusrclk_in[0]  = txusrclk_in_ch0;
  assign txusrclk2_in[0] = txusrclk2_in_ch0;
  assign rxusrclk_in[0]  = rxusrclk_in_ch0;
  assign rxusrclk2_in[0] = rxusrclk2_in_ch0;
  assign txusrclk_in[1]  = txusrclk_in_ch0;
  assign txusrclk2_in[1] = txusrclk2_in_ch0;
  assign rxusrclk_in[1]  = rxusrclk_in_ch0;
  assign rxusrclk2_in[1] = rxusrclk2_in_ch0;
  assign txusrclk_in[2]  = txusrclk_in_ch0;
  assign txusrclk2_in[2] = txusrclk2_in_ch0;
  assign rxusrclk_in[2]  = rxusrclk_in_ch0;
  assign rxusrclk2_in[2] = rxusrclk2_in_ch0;
  assign txusrclk_in[3]  = txusrclk_in_ch0;
  assign txusrclk2_in[3] = txusrclk2_in_ch0;
  assign rxusrclk_in[3]  = rxusrclk_in_ch0;
  assign rxusrclk2_in[3] = rxusrclk2_in_ch0;

   dpss_zcu102_rx_vid_phy_controller_0_0_gt_usrclk_source_8series  #
   (
     .TX_BUFFER_BYPASS  (0),
     .ADV_CLOCK_MODE    (1),
     .GTH_TYPE          (4)
   )
   gt_usrclk_source_inst
   (
    .MMCM_DRP_SCLK              (vid_phy_axi4lite_aclk),
    .MMCM_DRP_RST               (vid_phy_axi4lite_areset),
    .MMCM_DRP_TXN_AVAILABLE     (drp_txn_available[5]),
    .MMCM_DRP_RSP_READ          (drp_rsp_read[5]),
    .MMCM_DRPADDR               (cfg_phy_mem_map_control_b0[`MMCM_TXUSRCLK_DRPADDR]),
    .MMCM_DRPEN                 (cfg_phy_mem_map_control_b0[`MMCM_TXUSRCLK_DRPEN]),
    .MMCM_DRPWE                 (cfg_phy_mem_map_control_b0[`MMCM_TXUSRCLK_DRPWE]),
    .MMCM_DRPDI                 (cfg_phy_mem_map_control_b0[`MMCM_TXUSRCLK_DRPDI]),
    .MMCM_DRPBUSY               (cfg_phy_mem_map_status_b0[`MMCM_TXUSRCLK_DRPBUSY]),
    .MMCM_DRPRDY                (cfg_phy_mem_map_status_b0[`MMCM_TXUSRCLK_DRPRDY]),
    .MMCM_DRPDO                 (cfg_phy_mem_map_status_b0[`MMCM_TXUSRCLK_DRPDO]),

    .GT0_TXUSRCLK_OUT           (txusrclk_in_ch0),
    .GT0_TXUSRCLK2_OUT          (txusrclk2_in_ch0),
    .GT0_TXOUTCLK_IN            (txoutclk_out[0]),
    .GT0_RXUSRCLK_OUT           (rxusrclk_in_ch0),
    .GT0_RXUSRCLK2_OUT          (rxusrclk2_in_ch0),
    .GT0_RXOUTCLK_IN            (rxoutclk_out[0]),
    .GT0_TXCLK_LOCK_OUT         (b0_MMCM_DRP_LOCKED),
    .GT0_TX_MMCM_RESET_IN       (b0_MMCM_DRP_RESET),
    .BUFGT_TXUSRCLK_CLEAR       (gtwiz_userclk_tx_reset_in),
    .BUFGT_TXUSRCLK_DIV         (cfg_phy_mem_map_control_b0[`BUFGT_TXUSRCLK_DIV]),
    .BUFGT_RXUSRCLK_CLEAR       (gtwiz_userclk_rx_reset_in),
    .BUFGT_RXUSRCLK_DIV         (cfg_phy_mem_map_control_b0[`BUFGT_RXUSRCLK_DIV]),
    .TXUSRCLK_ACTIVE_OUT        (gtwiz_userclk_tx_active_in),
    .RXUSRCLK_ACTIVE_OUT        (gtwiz_userclk_rx_active_in),

    .mgtrefclk0_in              (mgtrefclk0_in), //used in advanced clock mode
    .mgtrefclk1_in              (mgtrefclk1_in),
    .Q0_CLK0_GTREFCLK_PAD_N_IN  (mgtrefclk0_pad_n_in),
    .Q0_CLK0_GTREFCLK_PAD_P_IN  (mgtrefclk0_pad_p_in),
    .Q0_CLK0_GTREFCLK_OUT       (mgtrefclk0_i),
    .Q0_CLK1_GTREFCLK_PAD_N_IN  (mgtrefclk1_pad_n_in),
    .Q0_CLK1_GTREFCLK_PAD_P_IN  (mgtrefclk1_pad_p_in),
    .Q0_CLK1_GTREFCLK_OUT       (mgtrefclk1_i)

  );



    //------------------------------------------------------------------------
    // Instantiation of Axi Bus Interface vid_phy_axi4lite
    //------------------------------------------------------------------------

    vid_phy_controller_v2_2_5_axi4lite # ( 
        .C_S_AXI_DATA_WIDTH(C_vid_phy_axi4lite_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_vid_phy_axi4lite_ADDR_WIDTH),
        .C_Tx_No_Of_Channels(C_Tx_No_Of_Channels),
        .C_Rx_No_Of_Channels(C_Rx_No_Of_Channels),
        .C_TX_PLL_SELECTION(C_TX_PLL_SELECTION),
        .C_RX_PLL_SELECTION(C_RX_PLL_SELECTION),
        .C_Err_Irq_En(0),
        .C_Use_GT_CH4_HDMI(0)
    ) vid_phy_controller_v2_2_5_vid_phy_axi4lite_inst (
        .S_AXI_ACLK(vid_phy_axi4lite_aclk),
        .S_AXI_ARESETN(vid_phy_axi4lite_aresetn),
        .S_AXI_AWADDR(vid_phy_axi4lite_awaddr),
        .S_AXI_AWPROT(vid_phy_axi4lite_awprot),
        .S_AXI_AWVALID(vid_phy_axi4lite_awvalid),
        .S_AXI_AWREADY(vid_phy_axi4lite_awready),
        .S_AXI_WDATA(vid_phy_axi4lite_wdata),
        .S_AXI_WSTRB(vid_phy_axi4lite_wstrb),
        .S_AXI_WVALID(vid_phy_axi4lite_wvalid),
        .S_AXI_WREADY(vid_phy_axi4lite_wready),
        .S_AXI_BRESP(vid_phy_axi4lite_bresp),
        .S_AXI_BVALID(vid_phy_axi4lite_bvalid),
        .S_AXI_BREADY(vid_phy_axi4lite_bready),
        .S_AXI_ARADDR(vid_phy_axi4lite_araddr),
        .S_AXI_ARPROT(vid_phy_axi4lite_arprot),
        .S_AXI_ARVALID(vid_phy_axi4lite_arvalid),
        .S_AXI_ARREADY(vid_phy_axi4lite_arready),
        .S_AXI_RDATA(vid_phy_axi4lite_rdata),
        .S_AXI_RRESP(vid_phy_axi4lite_rresp),
        .S_AXI_RVALID(vid_phy_axi4lite_rvalid),
        .S_AXI_RREADY(vid_phy_axi4lite_rready),
        .irq(irq),
        .err_irq(err_irq),
        .drp_txn_available(drp_txn_available),
        .drp_rsp_read(drp_rsp_read),
        .rx_sym_err_cntr_read(rx_sym_err_cntr_read),
        .cfg_phy_mem_map_control(cfg_phy_mem_map_control),
        .cfg_phy_mem_map_status(cfg_phy_mem_map_status) 
    );

    always@(posedge vid_phy_axi4lite_aclk) begin: bank_based_control
      case(cfg_phy_mem_map_control[`TX_BANK_SEL])
        pBANK0: begin 
                        cfg_phy_mem_map_control_b0 <= cfg_phy_mem_map_control;
                        cfg_phy_mem_map_status <= cfg_phy_mem_map_status_b0;  
                      end
        default: begin end      
      endcase
    end


  //----------------- DRP Control, Bank 0, GT 0 ----------------

  wire [31:0] DRP_Config_b0gt0; 
  wire [31:0] DRP_Status_b0gt0; 

  assign DRP_Config_b0gt0[11:0] = {cfg_phy_mem_map_control_b0[`CH1_DRPADDR_US_MSB], cfg_phy_mem_map_control_b0[`CH1_DRPADDR]};
  assign DRP_Config_b0gt0[12]   = cfg_phy_mem_map_control_b0[`CH1_DRPEN];
  assign DRP_Config_b0gt0[13]   = cfg_phy_mem_map_control_b0[`CH1_DRPWE];
  assign DRP_Config_b0gt0[31:16]= cfg_phy_mem_map_control_b0[`CH1_DRPDI];

   vid_phy_controller_v2_2_5_drp_control_8series #
   (
    .DRP_ADDR_WIDTH (10)
   )
   drp_control_b0gt0_inst
   (
     .Config_Clk          (vid_phy_axi4lite_aclk),
     .Config_Rst          (vid_phy_axi4lite_areset),
     .DRP_Config          (DRP_Config_b0gt0),
     .DRP_Status          (DRP_Status_b0gt0),
     .drp_txn_available   (drp_txn_available[0]),
     .drp_rsp_read        (drp_rsp_read[0]),
     .DRPCLK              (drpclk_in[0]),
     .DRPBUSY             (1'b0),
     .DRPEN               (drpen_in[0]),
     .DRPWE               (drpwe_in[0]),
     .DRPADDR             (drpaddr_in[9: 0]),
     .DRPDI               (drpdi_in[15: 0]),
     .DRPDO               (drpdo_out[15: 0]),
     .DRPRDY              (drprdy_out[0])  
   );

   wire DRP_Status_b0gt0_16_sync;
   xpm_cdc_single #(
     .VERSION        (`XPM_CDC_VERSION       ),
     .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
     .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
     .SRC_INPUT_REG  (0                      )
   ) xpm_single_drp_rdy_b0gt0_inst (
     .src_clk         ( drpclk_in[0]    ),
     .src_in          ( DRP_Status_b0gt0[16] ),
     .dest_clk        ( vid_phy_axi4lite_aclk ),
     .dest_out        ( DRP_Status_b0gt0_16_sync )
   );

    assign cfg_phy_mem_map_status_b0[`CH1_DRPDO]   =  DRP_Status_b0gt0[15:0];
    assign cfg_phy_mem_map_status_b0[`CH1_DRPRDY]  =  DRP_Status_b0gt0_16_sync;
    assign cfg_phy_mem_map_status_b0[`CH1_DRPBUSY] =  DRP_Status_b0gt0[17];

  //----------------- DRP Control, Bank 0, GT 1 ----------------

  wire [31:0] DRP_Config_b0gt1; 
  wire [31:0] DRP_Status_b0gt1; 

  assign DRP_Config_b0gt1[11:0] = {cfg_phy_mem_map_control_b0[`CH2_DRPADDR_US_MSB], cfg_phy_mem_map_control_b0[`CH2_DRPADDR]};
  assign DRP_Config_b0gt1[12]   = cfg_phy_mem_map_control_b0[`CH2_DRPEN];
  assign DRP_Config_b0gt1[13]   = cfg_phy_mem_map_control_b0[`CH2_DRPWE];
  assign DRP_Config_b0gt1[31:16]= cfg_phy_mem_map_control_b0[`CH2_DRPDI];

   vid_phy_controller_v2_2_5_drp_control_8series #
   (
    .DRP_ADDR_WIDTH (10)
   )
   drp_control_b0gt1_inst
   (
     .Config_Clk          (vid_phy_axi4lite_aclk),
     .Config_Rst          (vid_phy_axi4lite_areset),
     .DRP_Config          (DRP_Config_b0gt1),
     .DRP_Status          (DRP_Status_b0gt1),
     .drp_txn_available   (drp_txn_available[1]),
     .drp_rsp_read        (drp_rsp_read[1]),
     .DRPCLK              (drpclk_in[1]),
     .DRPBUSY             (1'b0),
     .DRPEN               (drpen_in[1]),
     .DRPWE               (drpwe_in[1]),
     .DRPADDR             (drpaddr_in[19: 10]),
     .DRPDI               (drpdi_in[31: 16]),
     .DRPDO               (drpdo_out[31: 16]),
     .DRPRDY              (drprdy_out[1])  
   );

   wire DRP_Status_b0gt1_16_sync;
   xpm_cdc_single #(
     .VERSION        (`XPM_CDC_VERSION       ),
     .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
     .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
     .SRC_INPUT_REG  (0                      )
   ) xpm_single_drp_rdy_b0gt1_inst (
     .src_clk         ( drpclk_in[1]    ),
     .src_in          ( DRP_Status_b0gt1[16] ),
     .dest_clk        ( vid_phy_axi4lite_aclk ),
     .dest_out        ( DRP_Status_b0gt1_16_sync )
   );

    assign cfg_phy_mem_map_status_b0[`CH2_DRPDO]   =  DRP_Status_b0gt1[15:0];
    assign cfg_phy_mem_map_status_b0[`CH2_DRPRDY]  =  DRP_Status_b0gt1_16_sync;
    assign cfg_phy_mem_map_status_b0[`CH2_DRPBUSY] =  DRP_Status_b0gt1[17];

  //----------------- DRP Control, Bank 0, GT 2 ----------------

  wire [31:0] DRP_Config_b0gt2; 
  wire [31:0] DRP_Status_b0gt2; 

  assign DRP_Config_b0gt2[11:0] = {cfg_phy_mem_map_control_b0[`CH3_DRPADDR_US_MSB], cfg_phy_mem_map_control_b0[`CH3_DRPADDR]};
  assign DRP_Config_b0gt2[12]   = cfg_phy_mem_map_control_b0[`CH3_DRPEN];
  assign DRP_Config_b0gt2[13]   = cfg_phy_mem_map_control_b0[`CH3_DRPWE];
  assign DRP_Config_b0gt2[31:16]= cfg_phy_mem_map_control_b0[`CH3_DRPDI];

   vid_phy_controller_v2_2_5_drp_control_8series #
   (
    .DRP_ADDR_WIDTH (10)
   )
   drp_control_b0gt2_inst
   (
     .Config_Clk          (vid_phy_axi4lite_aclk),
     .Config_Rst          (vid_phy_axi4lite_areset),
     .DRP_Config          (DRP_Config_b0gt2),
     .DRP_Status          (DRP_Status_b0gt2),
     .drp_txn_available   (drp_txn_available[2]),
     .drp_rsp_read        (drp_rsp_read[2]),
     .DRPCLK              (drpclk_in[2]),
     .DRPBUSY             (1'b0),
     .DRPEN               (drpen_in[2]),
     .DRPWE               (drpwe_in[2]),
     .DRPADDR             (drpaddr_in[29: 20]),
     .DRPDI               (drpdi_in[47: 32]),
     .DRPDO               (drpdo_out[47: 32]),
     .DRPRDY              (drprdy_out[2])  
   );

   wire DRP_Status_b0gt2_16_sync;
   xpm_cdc_single #(
     .VERSION        (`XPM_CDC_VERSION       ),
     .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
     .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
     .SRC_INPUT_REG  (0                      )
   ) xpm_single_drp_rdy_b0gt2_inst (
     .src_clk         ( drpclk_in[2]    ),
     .src_in          ( DRP_Status_b0gt2[16] ),
     .dest_clk        ( vid_phy_axi4lite_aclk ),
     .dest_out        ( DRP_Status_b0gt2_16_sync )
   );

    assign cfg_phy_mem_map_status_b0[`CH3_DRPDO]   =  DRP_Status_b0gt2[15:0];
    assign cfg_phy_mem_map_status_b0[`CH3_DRPRDY]  =  DRP_Status_b0gt2_16_sync;
    assign cfg_phy_mem_map_status_b0[`CH3_DRPBUSY] =  DRP_Status_b0gt2[17];

  //----------------- DRP Control, Bank 0, GT 3 ----------------

  wire [31:0] DRP_Config_b0gt3; 
  wire [31:0] DRP_Status_b0gt3; 

  assign DRP_Config_b0gt3[11:0] = {cfg_phy_mem_map_control_b0[`CH4_DRPADDR_US_MSB], cfg_phy_mem_map_control_b0[`CH4_DRPADDR]};
  assign DRP_Config_b0gt3[12]   = cfg_phy_mem_map_control_b0[`CH4_DRPEN];
  assign DRP_Config_b0gt3[13]   = cfg_phy_mem_map_control_b0[`CH4_DRPWE];
  assign DRP_Config_b0gt3[31:16]= cfg_phy_mem_map_control_b0[`CH4_DRPDI];

   vid_phy_controller_v2_2_5_drp_control_8series #
   (
    .DRP_ADDR_WIDTH (10)
   )
   drp_control_b0gt3_inst
   (
     .Config_Clk          (vid_phy_axi4lite_aclk),
     .Config_Rst          (vid_phy_axi4lite_areset),
     .DRP_Config          (DRP_Config_b0gt3),
     .DRP_Status          (DRP_Status_b0gt3),
     .drp_txn_available   (drp_txn_available[3]),
     .drp_rsp_read        (drp_rsp_read[3]),
     .DRPCLK              (drpclk_in[3]),
     .DRPBUSY             (1'b0),
     .DRPEN               (drpen_in[3]),
     .DRPWE               (drpwe_in[3]),
     .DRPADDR             (drpaddr_in[39: 30]),
     .DRPDI               (drpdi_in[63: 48]),
     .DRPDO               (drpdo_out[63: 48]),
     .DRPRDY              (drprdy_out[3])  
   );

   wire DRP_Status_b0gt3_16_sync;
   xpm_cdc_single #(
     .VERSION        (`XPM_CDC_VERSION       ),
     .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
     .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
     .SRC_INPUT_REG  (0                      )
   ) xpm_single_drp_rdy_b0gt3_inst (
     .src_clk         ( drpclk_in[3]    ),
     .src_in          ( DRP_Status_b0gt3[16] ),
     .dest_clk        ( vid_phy_axi4lite_aclk ),
     .dest_out        ( DRP_Status_b0gt3_16_sync )
   );

    assign cfg_phy_mem_map_status_b0[`CH4_DRPDO]   =  DRP_Status_b0gt3[15:0];
    assign cfg_phy_mem_map_status_b0[`CH4_DRPRDY]  =  DRP_Status_b0gt3_16_sync;
    assign cfg_phy_mem_map_status_b0[`CH4_DRPBUSY] =  DRP_Status_b0gt3[17];

  //--------------------------- DRP Control, Common ----------------------------

  wire [31:0] DRP_Config_common; 
  wire [31:0] DRP_Status_common; 

  assign DRP_Config_common[11:0] = cfg_phy_mem_map_control[`COMMON_DRPADDR];
  assign DRP_Config_common[12]   = cfg_phy_mem_map_control[`COMMON_DRPEN];
  assign DRP_Config_common[13]   = cfg_phy_mem_map_control[`COMMON_DRPWE];
  assign DRP_Config_common[31:16]= cfg_phy_mem_map_control[`COMMON_DRPDI];
 
  wire [10-1 : 0] drpaddr_common_int;
   vid_phy_controller_v2_2_5_drp_control_8series #
   (
    .DRP_ADDR_WIDTH (10)
   )
   drp_control_b0gtcommon_inst
   (
     .Config_Clk          (vid_phy_axi4lite_aclk),
     .Config_Rst          (vid_phy_axi4lite_areset),
     .DRP_Config          (DRP_Config_common),
     .DRP_Status          (DRP_Status_common),
     .drp_txn_available   (drp_txn_available[4]),
     .drp_rsp_read        (drp_rsp_read[4]),
     .DRPCLK              (drpclk_common_in),
     .DRPBUSY             (1'b0),
     .DRPEN               (drpen_common_in),
     .DRPWE               (drpwe_common_in),
     .DRPADDR             (drpaddr_common_int),
     .DRPDI               (drpdi_common_in),
     .DRPDO               (drpdo_common_out),
     .DRPRDY              (drprdy_common_out)  
   );

   wire DRP_Status_common_16_sync;
   xpm_cdc_single #(
     .VERSION        (`XPM_CDC_VERSION       ),
     .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
     .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
     .SRC_INPUT_REG  (0                      )
   ) xpm_single_drp_rdy_b0_common_inst (
     .src_clk         ( drpclk_common_in   ),
     .src_in          ( DRP_Status_common[16] ),
     .dest_clk        ( vid_phy_axi4lite_aclk ),
     .dest_out        ( DRP_Status_common_16_sync )
   );

    assign cfg_phy_mem_map_status_b0[`COMMON_DRPBUSY] =  DRP_Status_common[17];
    assign cfg_phy_mem_map_status_b0[`COMMON_DRPRDY]  =  DRP_Status_common_16_sync;
    assign cfg_phy_mem_map_status_b0[`COMMON_DRPDO]   =  DRP_Status_common[15:0];
    assign drpaddr_common_in   =  {6'b0, drpaddr_common_int};


    assign cfg_phy_mem_map_status_b0[`CLKDET_TX_TMR_EVENT] = 1'b0;
    assign cfg_phy_mem_map_status_b0[`CLKDET_TX_FREQ_EVENT] = 1'b0;
    assign cfg_phy_mem_map_status_b0[`CLKDET_RX_TMR_EVENT] = 1'b0;
    assign cfg_phy_mem_map_status_b0[`CLKDET_RX_FREQ_EVENT] = 1'b0;

// baoshan://
  
    assign cfg_phy_mem_map_status_b0[`CH1_TXGTPOWERGOOD]      =  gtpowergood_out[0];
    assign cfg_phy_mem_map_status_b0[`CH1_RXGTPOWERGOOD]      =  gtpowergood_out[0];
    assign cfg_phy_mem_map_status_b0[`CH2_TXGTPOWERGOOD]      =  gtpowergood_out[1];
    assign cfg_phy_mem_map_status_b0[`CH2_RXGTPOWERGOOD]      =  gtpowergood_out[1];
    assign cfg_phy_mem_map_status_b0[`CH3_TXGTPOWERGOOD]      =  gtpowergood_out[2];
    assign cfg_phy_mem_map_status_b0[`CH3_RXGTPOWERGOOD]      =  gtpowergood_out[2];
    assign cfg_phy_mem_map_status_b0[`CH4_TXGTPOWERGOOD]      =  gtpowergood_out[3];
    assign cfg_phy_mem_map_status_b0[`CH4_RXGTPOWERGOOD]      =  gtpowergood_out[3];
  //Unused Status Bits
    assign cfg_phy_mem_map_status_b0[`CH1_TXPHINITDONE]       =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH1_TXDLYRESETDONE]     =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH1_RXCDRLOCK]          =  1'b0; //Not Available
    assign cfg_phy_mem_map_status_b0[`CH2_TXPHINITDONE]       =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH2_TXDLYRESETDONE]     =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH2_RXCDRLOCK]          =  1'b0; //Not Available
    assign cfg_phy_mem_map_status_b0[`CH3_TXPHINITDONE]       =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH3_TXDLYRESETDONE]     =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH3_RXCDRLOCK]          =  1'b0; //Not Available
    assign cfg_phy_mem_map_status_b0[`CH4_TXPHINITDONE]       =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH4_TXDLYRESETDONE]     =  1'b0; // Not Available
    assign cfg_phy_mem_map_status_b0[`CH4_RXCDRLOCK]          =  1'b0; //Not Available

  // ------------------------------------------- Synchronizers ------------------------------------------

  // ---------------------- Synchronizer: CPLL Calibration ----------------------------
  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 18                    ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_cpll_cal_txoutclk_period_b0_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          (cfg_phy_mem_map_control_b0[`CPLL_CAL_CLK_PERIOD]),
    .dest_clk        (drpclk_i       ),
    .dest_out        (gtwiz_gte4_cpll_cal_txoutclk_period_sync)
  );
  assign gtwiz_gte4_cpll_cal_txoutclk_period_in = {4 {gtwiz_gte4_cpll_cal_txoutclk_period_sync}};
  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 18                    ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_cpll_cal_cnt_tol_b0_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          (cfg_phy_mem_map_control_b0[`CPLL_CAL_CLK_CNT_TOL]),
    .dest_clk        (drpclk_i       ),
    .dest_out        (gtwiz_gte4_cpll_cal_cnt_tol_in_sync)
  );
  assign gtwiz_gte4_cpll_cal_cnt_tol_in = {4 {gtwiz_gte4_cpll_cal_cnt_tol_in_sync}};
  // ---------------------- Synchronizer: User Clocking ----------------------------
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_tx_mmcm_drp_locked_b0_inst (
    .src_clk         ( txusrclk2_in[0]    ),
    .src_in          ( b0_MMCM_DRP_LOCKED ),
    .dest_clk        ( vid_phy_axi4lite_aclk ),
    .dest_out        ( b0_MMCM_DRP_LOCKED_sync )
  );
  

  

  assign cfg_phy_mem_map_status_b0[`CH1_BUFF_BYPASS_TX_ERR] = 1'b0;
  assign cfg_phy_mem_map_status_b0[`CH2_BUFF_BYPASS_TX_ERR] = 1'b0;
  assign cfg_phy_mem_map_status_b0[`CH3_BUFF_BYPASS_TX_ERR] = 1'b0;
  assign cfg_phy_mem_map_status_b0[`CH4_BUFF_BYPASS_TX_ERR] = 1'b0;



  // ---------------------- Synchronizer: GT Channel 0 :: Control Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rx8b10ben_b00_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH1_RX8B10BEN] ),
    .dest_clk        ( rxusrclk2_in[0] ),
    .dest_out        ( rx8b10ben_in[0] )
  );

  //xpm_cdc_single #(
  //  .VERSION        (`XPM_CDC_VERSION       ),
  //  .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
  //  .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
  //  .SRC_INPUT_REG  (0                      )
  //) xpm_single_rxlpmen_b00_inst (
  //  .src_clk         ( vid_phy_axi4lite_aclk    ),
  //  .src_in          ( cfg_phy_mem_map_control_b0[`CH1_RXLPMEN] ),
  //  .dest_clk        ( rxusrclk2_in[0] ),
  //  .dest_out        ( rxlpmen_in[0] )
  //);
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxpolarity_b00_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH1_RXPOLARITY] ),
    .dest_clk        ( rxusrclk2_in[0] ),
    .dest_out        ( rxpolarity_in[0] )
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxprbscntreset_b00_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH1_RXPRBSCNTRESET] ),
    .dest_clk        ( rxusrclk2_in[0] ),
    .dest_out        ( rxprbscntreset_in[0] )
  );
  
  //Latch the PRBS error after tolerance window is lapsed
  //User has to read PRBS Error Counter value using DRP access from GT (through SW)
  reg [3:0] b0gt0_rxprbserr_out_cntr;
  reg       b0gt0_rxprbserr_out_latch;
  always@(posedge rxusrclk2_in[0]) begin
    if(rxprbscntreset_in[0]) begin
      b0gt0_rxprbserr_out_latch <= 1'b0;
      b0gt0_rxprbserr_out_cntr  <= 'h0;
    end else begin
      if(rxprbserr_out[0]) begin
        b0gt0_rxprbserr_out_cntr <= b0gt0_rxprbserr_out_cntr + 1'b1;  
      end
      if(&b0gt0_rxprbserr_out_cntr) begin
        b0gt0_rxprbserr_out_latch <= 1'b1;
      end
    end
  end

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_prbserr_out_sync_b0gt0inst (
    .src_clk         (b0gt0_rxusrclk2_in        ),
    .src_in          (b0gt0_rxprbserr_out_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_RXPRBSERR])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 4                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxprbssel_b00_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          ({cfg_phy_mem_map_control_b0[`CH1_RXPRBSSEL_US_MSB], cfg_phy_mem_map_control_b0[`CH1_RXPRBSSEL]}),
    .dest_clk        (rxusrclk2_in[0]       ),
    .dest_out        (rxprbssel_in[3 : 0])
  );

//RX Only VPHY 
assign txdiffctrl_in[4 : 0] = 5'b0;

//RX Only VPHY 
assign tx8b10ben_in[0] = 1'b0;
assign txpd_in[1 : 0] = 2'b0;

//RX Only VPHY
assign txinhibit_in = 1'b0;
assign txpolarity_in = 1'b0;
assign txprbsforceerr_in = 1'b0;
assign txprbssel_in[3 : 0] = 4'b0;
assign txelecidle_in = 1'b0;

  // ---------------------- Synchronizer: GT Channel 0 :: Status Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxpmaresetdone_b00_inst (
    .src_clk         (rxusrclk2_in[0]       ),
    .src_in          (rxpmaresetdone_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_RXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_rx_done_b00_inst (
    .src_clk         (rxusrclk2_in[0]       ),
    .src_in          (rxresetdone_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_RXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 3                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxbufstatus_b00_inst (
    .src_clk         (rxusrclk2_in[0]        ),
    .src_in          (rxbufstatus_out[2 : 0]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_RXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_tx_done_b00_inst (
    .src_clk         (txusrclk2_in[0]       ),
    .src_in          (txresetdone_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_TXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 2                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_txbufstatus_b00_inst (
    .src_clk         (txusrclk2_in[0]        ),
    .src_in          (txbufstatus_out[1 : 0]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_TXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txpmaresetdone_b00_inst (
    .src_clk         (txusrclk2_in[0]       ),
    .src_in          (txpmaresetdone_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_TXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txphaligndone_b00_inst (
    .src_clk         (txusrclk2_in[0]       ),
    .src_in          (txphaligndone_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_TXPHALIGNDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_cplllock_b00_inst (
    .src_clk         (drpclk_in[0]),
    .src_in          (cplllock_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH1_CPLLLOCK])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxbyteisaligned_b00_inst (
    .src_clk         (rxusrclk2_in[0]),
    .src_in          (rxbyteisaligned_out[0]),
    .dest_clk        (vid_phy_axi4lite_aclk),
    .dest_out        (rxbyteisaligned_out_sync[0])
  );
  

  // ---------------------- Synchronizer: GT Channel 1 :: Control Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rx8b10ben_b01_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH2_RX8B10BEN] ),
    .dest_clk        ( rxusrclk2_in[1] ),
    .dest_out        ( rx8b10ben_in[1] )
  );

  //xpm_cdc_single #(
  //  .VERSION        (`XPM_CDC_VERSION       ),
  //  .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
  //  .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
  //  .SRC_INPUT_REG  (0                      )
  //) xpm_single_rxlpmen_b01_inst (
  //  .src_clk         ( vid_phy_axi4lite_aclk    ),
  //  .src_in          ( cfg_phy_mem_map_control_b0[`CH2_RXLPMEN] ),
  //  .dest_clk        ( rxusrclk2_in[1] ),
  //  .dest_out        ( rxlpmen_in[1] )
  //);
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxpolarity_b01_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH2_RXPOLARITY] ),
    .dest_clk        ( rxusrclk2_in[1] ),
    .dest_out        ( rxpolarity_in[1] )
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxprbscntreset_b01_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH2_RXPRBSCNTRESET] ),
    .dest_clk        ( rxusrclk2_in[1] ),
    .dest_out        ( rxprbscntreset_in[1] )
  );
  
  //Latch the PRBS error after tolerance window is lapsed
  //User has to read PRBS Error Counter value using DRP access from GT (through SW)
  reg [3:0] b0gt1_rxprbserr_out_cntr;
  reg       b0gt1_rxprbserr_out_latch;
  always@(posedge rxusrclk2_in[1]) begin
    if(rxprbscntreset_in[1]) begin
      b0gt1_rxprbserr_out_latch <= 1'b0;
      b0gt1_rxprbserr_out_cntr  <= 'h0;
    end else begin
      if(rxprbserr_out[1]) begin
        b0gt1_rxprbserr_out_cntr <= b0gt1_rxprbserr_out_cntr + 1'b1;  
      end
      if(&b0gt1_rxprbserr_out_cntr) begin
        b0gt1_rxprbserr_out_latch <= 1'b1;
      end
    end
  end

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_prbserr_out_sync_b0gt1inst (
    .src_clk         (b0gt0_rxusrclk2_in        ),
    .src_in          (b0gt1_rxprbserr_out_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_RXPRBSERR])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 4                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxprbssel_b01_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          ({cfg_phy_mem_map_control_b0[`CH2_RXPRBSSEL_US_MSB], cfg_phy_mem_map_control_b0[`CH2_RXPRBSSEL]}),
    .dest_clk        (rxusrclk2_in[1]       ),
    .dest_out        (rxprbssel_in[7 : 4])
  );

//RX Only VPHY 
assign txdiffctrl_in[9 : 5] = 5'b0;

//RX Only VPHY 
assign tx8b10ben_in[1] = 1'b0;
assign txpd_in[3 : 2] = 2'b0;

//RX Only VPHY
assign txinhibit_in = 1'b0;
assign txpolarity_in = 1'b0;
assign txprbsforceerr_in = 1'b0;
assign txprbssel_in[7 : 4] = 4'b0;
assign txelecidle_in = 1'b0;

  // ---------------------- Synchronizer: GT Channel 1 :: Status Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxpmaresetdone_b01_inst (
    .src_clk         (rxusrclk2_in[1]       ),
    .src_in          (rxpmaresetdone_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_RXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_rx_done_b01_inst (
    .src_clk         (rxusrclk2_in[1]       ),
    .src_in          (rxresetdone_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_RXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 3                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxbufstatus_b01_inst (
    .src_clk         (rxusrclk2_in[1]        ),
    .src_in          (rxbufstatus_out[5 : 3]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_RXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_tx_done_b01_inst (
    .src_clk         (txusrclk2_in[1]       ),
    .src_in          (txresetdone_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_TXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 2                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_txbufstatus_b01_inst (
    .src_clk         (txusrclk2_in[1]        ),
    .src_in          (txbufstatus_out[3 : 2]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_TXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txpmaresetdone_b01_inst (
    .src_clk         (txusrclk2_in[1]       ),
    .src_in          (txpmaresetdone_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_TXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txphaligndone_b01_inst (
    .src_clk         (txusrclk2_in[1]       ),
    .src_in          (txphaligndone_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_TXPHALIGNDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_cplllock_b01_inst (
    .src_clk         (drpclk_in[1]),
    .src_in          (cplllock_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH2_CPLLLOCK])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxbyteisaligned_b01_inst (
    .src_clk         (rxusrclk2_in[1]),
    .src_in          (rxbyteisaligned_out[1]),
    .dest_clk        (vid_phy_axi4lite_aclk),
    .dest_out        (rxbyteisaligned_out_sync[1])
  );
  

  // ---------------------- Synchronizer: GT Channel 2 :: Control Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rx8b10ben_b02_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH3_RX8B10BEN] ),
    .dest_clk        ( rxusrclk2_in[2] ),
    .dest_out        ( rx8b10ben_in[2] )
  );

  //xpm_cdc_single #(
  //  .VERSION        (`XPM_CDC_VERSION       ),
  //  .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
  //  .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
  //  .SRC_INPUT_REG  (0                      )
  //) xpm_single_rxlpmen_b02_inst (
  //  .src_clk         ( vid_phy_axi4lite_aclk    ),
  //  .src_in          ( cfg_phy_mem_map_control_b0[`CH3_RXLPMEN] ),
  //  .dest_clk        ( rxusrclk2_in[2] ),
  //  .dest_out        ( rxlpmen_in[2] )
  //);
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxpolarity_b02_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH3_RXPOLARITY] ),
    .dest_clk        ( rxusrclk2_in[2] ),
    .dest_out        ( rxpolarity_in[2] )
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxprbscntreset_b02_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH3_RXPRBSCNTRESET] ),
    .dest_clk        ( rxusrclk2_in[2] ),
    .dest_out        ( rxprbscntreset_in[2] )
  );
  
  //Latch the PRBS error after tolerance window is lapsed
  //User has to read PRBS Error Counter value using DRP access from GT (through SW)
  reg [3:0] b0gt2_rxprbserr_out_cntr;
  reg       b0gt2_rxprbserr_out_latch;
  always@(posedge rxusrclk2_in[2]) begin
    if(rxprbscntreset_in[2]) begin
      b0gt2_rxprbserr_out_latch <= 1'b0;
      b0gt2_rxprbserr_out_cntr  <= 'h0;
    end else begin
      if(rxprbserr_out[2]) begin
        b0gt2_rxprbserr_out_cntr <= b0gt2_rxprbserr_out_cntr + 1'b1;  
      end
      if(&b0gt2_rxprbserr_out_cntr) begin
        b0gt2_rxprbserr_out_latch <= 1'b1;
      end
    end
  end

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_prbserr_out_sync_b0gt2inst (
    .src_clk         (b0gt0_rxusrclk2_in        ),
    .src_in          (b0gt2_rxprbserr_out_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_RXPRBSERR])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 4                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxprbssel_b02_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          ({cfg_phy_mem_map_control_b0[`CH3_RXPRBSSEL_US_MSB], cfg_phy_mem_map_control_b0[`CH3_RXPRBSSEL]}),
    .dest_clk        (rxusrclk2_in[2]       ),
    .dest_out        (rxprbssel_in[11 : 8])
  );

//RX Only VPHY 
assign txdiffctrl_in[14 : 10] = 5'b0;

//RX Only VPHY 
assign tx8b10ben_in[2] = 1'b0;
assign txpd_in[5 : 4] = 2'b0;

//RX Only VPHY
assign txinhibit_in = 1'b0;
assign txpolarity_in = 1'b0;
assign txprbsforceerr_in = 1'b0;
assign txprbssel_in[11 : 8] = 4'b0;
assign txelecidle_in = 1'b0;

  // ---------------------- Synchronizer: GT Channel 2 :: Status Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxpmaresetdone_b02_inst (
    .src_clk         (rxusrclk2_in[2]       ),
    .src_in          (rxpmaresetdone_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_RXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_rx_done_b02_inst (
    .src_clk         (rxusrclk2_in[2]       ),
    .src_in          (rxresetdone_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_RXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 3                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxbufstatus_b02_inst (
    .src_clk         (rxusrclk2_in[2]        ),
    .src_in          (rxbufstatus_out[8 : 6]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_RXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_tx_done_b02_inst (
    .src_clk         (txusrclk2_in[2]       ),
    .src_in          (txresetdone_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_TXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 2                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_txbufstatus_b02_inst (
    .src_clk         (txusrclk2_in[2]        ),
    .src_in          (txbufstatus_out[5 : 4]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_TXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txpmaresetdone_b02_inst (
    .src_clk         (txusrclk2_in[2]       ),
    .src_in          (txpmaresetdone_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_TXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txphaligndone_b02_inst (
    .src_clk         (txusrclk2_in[2]       ),
    .src_in          (txphaligndone_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_TXPHALIGNDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_cplllock_b02_inst (
    .src_clk         (drpclk_in[2]),
    .src_in          (cplllock_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH3_CPLLLOCK])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxbyteisaligned_b02_inst (
    .src_clk         (rxusrclk2_in[2]),
    .src_in          (rxbyteisaligned_out[2]),
    .dest_clk        (vid_phy_axi4lite_aclk),
    .dest_out        (rxbyteisaligned_out_sync[2])
  );
  

  // ---------------------- Synchronizer: GT Channel 3 :: Control Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rx8b10ben_b03_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH4_RX8B10BEN] ),
    .dest_clk        ( rxusrclk2_in[3] ),
    .dest_out        ( rx8b10ben_in[3] )
  );

  //xpm_cdc_single #(
  //  .VERSION        (`XPM_CDC_VERSION       ),
  //  .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
  //  .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
  //  .SRC_INPUT_REG  (0                      )
  //) xpm_single_rxlpmen_b03_inst (
  //  .src_clk         ( vid_phy_axi4lite_aclk    ),
  //  .src_in          ( cfg_phy_mem_map_control_b0[`CH4_RXLPMEN] ),
  //  .dest_clk        ( rxusrclk2_in[3] ),
  //  .dest_out        ( rxlpmen_in[3] )
  //);
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxpolarity_b03_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH4_RXPOLARITY] ),
    .dest_clk        ( rxusrclk2_in[3] ),
    .dest_out        ( rxpolarity_in[3] )
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_rxprbscntreset_b03_inst (
    .src_clk         ( vid_phy_axi4lite_aclk    ),
    .src_in          ( cfg_phy_mem_map_control_b0[`CH4_RXPRBSCNTRESET] ),
    .dest_clk        ( rxusrclk2_in[3] ),
    .dest_out        ( rxprbscntreset_in[3] )
  );
  
  //Latch the PRBS error after tolerance window is lapsed
  //User has to read PRBS Error Counter value using DRP access from GT (through SW)
  reg [3:0] b0gt3_rxprbserr_out_cntr;
  reg       b0gt3_rxprbserr_out_latch;
  always@(posedge rxusrclk2_in[3]) begin
    if(rxprbscntreset_in[3]) begin
      b0gt3_rxprbserr_out_latch <= 1'b0;
      b0gt3_rxprbserr_out_cntr  <= 'h0;
    end else begin
      if(rxprbserr_out[3]) begin
        b0gt3_rxprbserr_out_cntr <= b0gt3_rxprbserr_out_cntr + 1'b1;  
      end
      if(&b0gt3_rxprbserr_out_cntr) begin
        b0gt3_rxprbserr_out_latch <= 1'b1;
      end
    end
  end

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_single_prbserr_out_sync_b0gt3inst (
    .src_clk         (b0gt0_rxusrclk2_in        ),
    .src_in          (b0gt3_rxprbserr_out_latch),
    .dest_clk        (vid_phy_axi4lite_aclk       ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_RXPRBSERR])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 4                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxprbssel_b03_inst (
    .src_clk         (vid_phy_axi4lite_aclk        ),
    .src_in          ({cfg_phy_mem_map_control_b0[`CH4_RXPRBSSEL_US_MSB], cfg_phy_mem_map_control_b0[`CH4_RXPRBSSEL]}),
    .dest_clk        (rxusrclk2_in[3]       ),
    .dest_out        (rxprbssel_in[15 : 12])
  );

//RX Only VPHY 
assign txdiffctrl_in[19 : 15] = 5'b0;

//RX Only VPHY 
assign tx8b10ben_in[3] = 1'b0;
assign txpd_in[7 : 6] = 2'b0;

//RX Only VPHY
assign txinhibit_in = 1'b0;
assign txpolarity_in = 1'b0;
assign txprbsforceerr_in = 1'b0;
assign txprbssel_in[15 : 12] = 4'b0;
assign txelecidle_in = 1'b0;

  // ---------------------- Synchronizer: GT Channel 3 :: Status Path ----------------------------

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxpmaresetdone_b03_inst (
    .src_clk         (rxusrclk2_in[3]       ),
    .src_in          (rxpmaresetdone_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_RXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_rx_done_b03_inst (
    .src_clk         (rxusrclk2_in[3]       ),
    .src_in          (rxresetdone_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_RXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 3                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_rxbufstatus_b03_inst (
    .src_clk         (rxusrclk2_in[3]        ),
    .src_in          (rxbufstatus_out[11 : 9]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_RXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_reset_tx_done_b03_inst (
    .src_clk         (txusrclk2_in[3]       ),
    .src_in          (txresetdone_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_TXRESETDONE])
  );

  xpm_cdc_array_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .WIDTH          ( 2                     ),
    .SRC_INPUT_REG  ( 0                     )
  ) xpm_array_single_txbufstatus_b03_inst (
    .src_clk         (txusrclk2_in[3]        ),
    .src_in          (txbufstatus_out[7 : 6]),
    .dest_clk        (vid_phy_axi4lite_aclk   ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_TXBUFSTATUS])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txpmaresetdone_b03_inst (
    .src_clk         (txusrclk2_in[3]       ),
    .src_in          (txpmaresetdone_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_TXPMARESETDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_txphaligndone_b03_inst (
    .src_clk         (txusrclk2_in[3]       ),
    .src_in          (txphaligndone_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_TXPHALIGNDONE])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_cplllock_b03_inst (
    .src_clk         (drpclk_in[3]),
    .src_in          (cplllock_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`CH4_CPLLLOCK])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_rxbyteisaligned_b03_inst (
    .src_clk         (rxusrclk2_in[3]),
    .src_in          (rxbyteisaligned_out[3]),
    .dest_clk        (vid_phy_axi4lite_aclk),
    .dest_out        (rxbyteisaligned_out_sync[3])
  );
  

  // ---------------------- Synchronizer: GT Common 4 :: Status Path ----------------------------
  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_qpll0lock_b0_inst (
    .src_clk         (vid_phy_axi4lite_aclk  ),
    .src_in          (qpll0lock_out),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`QPLLLOCK])
  );

  xpm_cdc_single #(
    .VERSION        (`XPM_CDC_VERSION       ),
    .SIM_ASSERT_CHK (`XPM_CDC_SIM_ASSERT_CHK),
    .DEST_SYNC_FF   (`XPM_CDC_MTBF_FFS      ),
    .SRC_INPUT_REG  (0                      )
  ) xpm_array_single_qpll1lock_b0_inst (
    .src_clk         (vid_phy_axi4lite_aclk  ),
    .src_in          (qpll1lock_out),
    .dest_clk        (vid_phy_axi4lite_aclk  ),
    .dest_out        (cfg_phy_mem_map_status_b0[`QPLL1LOCK])
  );




  // ----------------------------------- Rx Sideband Connections (Uses AXI4Lite Clock) -----------------------------

  // Control Inputs - Driven from Link Layer to add protocol specific control
  assign vid_phy_control_sb_rx_tready   = 1'b1;
  assign i_dp_train_itr_reset           = vid_phy_control_sb_rx_tdata[0] & vid_phy_control_sb_rx_tvalid; //resets for every TP lane set access
  assign i_dp_start_of_tp1_reset        = vid_phy_control_sb_rx_tdata[1] & vid_phy_control_sb_rx_tvalid; //resets GT for every start of TP1 event

  // Status Outputs - Will be used by link layer
  assign vid_phy_status_sb_rx_tvalid    = 1'b1;



  assign vid_phy_status_sb_rx_tdata[0]  = cfg_phy_mem_map_status_b0[`CH1_RXRESETDONE];
  assign vid_phy_status_sb_rx_tdata[1]  = ((rxsysclksel_in[1:0]==2'b00) & cfg_phy_mem_map_status_b0[`CH1_CPLLLOCK]) |
                                          ((rxsysclksel_in[1:0]==2'b10) & cfg_phy_mem_map_status_b0[`QPLLLOCK]) |
                                          ((rxsysclksel_in[1:0]==2'b11) & cfg_phy_mem_map_status_b0[`QPLL1LOCK]);
                                                                                                            
  assign vid_phy_status_sb_rx_tdata[2]  = rxbyteisaligned_out_sync[0];

    assign vid_phy_status_sb_rx_tdata[3]  = cfg_phy_mem_map_status_b0[`CH2_RXRESETDONE];
    assign vid_phy_status_sb_rx_tdata[4]  = ((rxsysclksel_in[1:0]==2'b00) & cfg_phy_mem_map_status_b0[`CH2_CPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b10) & cfg_phy_mem_map_status_b0[`QPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b11) & cfg_phy_mem_map_status_b0[`QPLL1LOCK]);
    assign vid_phy_status_sb_rx_tdata[5]  = rxbyteisaligned_out_sync[1];

    assign vid_phy_status_sb_rx_tdata[6]  = cfg_phy_mem_map_status_b0[`CH3_RXRESETDONE];
    assign vid_phy_status_sb_rx_tdata[7]  = ((rxsysclksel_in[1:0]==2'b00) & cfg_phy_mem_map_status_b0[`CH3_CPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b10) & cfg_phy_mem_map_status_b0[`QPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b11) & cfg_phy_mem_map_status_b0[`QPLL1LOCK]);
    assign vid_phy_status_sb_rx_tdata[8]  = rxbyteisaligned_out_sync[2];  

    assign vid_phy_status_sb_rx_tdata[9]  = cfg_phy_mem_map_status_b0[`CH4_RXRESETDONE];
    assign vid_phy_status_sb_rx_tdata[10] = ((rxsysclksel_in[1:0]==2'b00) & cfg_phy_mem_map_status_b0[`CH4_CPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b10) & cfg_phy_mem_map_status_b0[`QPLLLOCK]) |
                                            ((rxsysclksel_in[1:0]==2'b11) & cfg_phy_mem_map_status_b0[`QPLL1LOCK]);
    assign vid_phy_status_sb_rx_tdata[11] = rxbyteisaligned_out_sync[3];  



endmodule

