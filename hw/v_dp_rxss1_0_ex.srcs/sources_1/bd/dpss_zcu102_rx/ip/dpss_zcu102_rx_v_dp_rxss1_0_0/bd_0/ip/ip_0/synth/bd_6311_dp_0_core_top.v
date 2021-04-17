
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved. 
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


//----------------------------------------------
// Directives
//----------------------------------------------
`timescale 1 ps / 1 ps

//----------------------------------------------
// Includes
//----------------------------------------------
`include "displayport_v8_1_2_tx_defs.v"                         
`include "displayport_v8_1_2_rx_defs.v"
`include "displayport_v8_1_2_rx_dpcd_defs.v"

(* DowngradeIPIdentifiedWarnings = "yes" *)
module bd_6311_dp_0_core_top
#(
  parameter  C_FAMILY                 = "virtex7",
  parameter  C_COMPONENT_NAME         = "displayport_v4",
  parameter  C_LANE_COUNT             = 4,
  parameter  C_FLOW_DIRECTION         = 1,
  parameter  C_PHY_TYPE_EXTERNAL      = 1,
  parameter  C_INCLUDE_HDCP           = 0,
  parameter  C_INCLUDE_HDCP22         = 1,
  parameter  C_SECONDARY_SUPPORT      = 0,
  parameter  C_IEEE_OUI               = "000A35",
  parameter  C_AUDIO_CHANNELS         = 8,
  parameter  C_S_BASEADDR             = "CA400000",
  parameter  C_S_HIGHADDR             = "CA40FFFF",
  parameter  C_PROTOCOL_SELECTION     = 0,
  parameter  C_LINK_RATE              = 6,
  parameter  C_MST_ENABLE             = 0,
  parameter  C_NUMBER_OF_MST_STREAMS  = 2,
  parameter  C_MAX_BITS_PER_COLOR     = 16,
  parameter  C_QUAD_PIXEL_ENABLE      = 1,
  parameter  C_DUAL_PIXEL_ENABLE      = 1,
  parameter  C_YCRCB_ENABLE           = 1,
  parameter  C_YONLY_ENABLE           = 0,
  parameter  C_VENDOR_SPECIFIC        = 0,
  parameter  C_DATA_WIDTH             = 2,
  parameter  C_BUF_BYPASS             = 0,
  parameter  C_EDP_EN                 = 0,
  parameter  C_IS_VERSAL              = 0,
  parameter  C_SIM_MODE               = 0
)
(
   input  wire                    s_axi_aclk           , // group DP_S_AXILITE
   input  wire                    s_axi_aresetn        , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_awaddr         , // group DP_S_AXILITE
   input  wire    [2:0]           s_axi_awprot         , // group DP_S_AXILITE
   input  wire                    s_axi_awvalid        , // group DP_S_AXILITE
   output wire                    s_axi_awready        , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_wdata          , // group DP_S_AXILITE
   input  wire    [3:0]           s_axi_wstrb          , // group DP_S_AXILITE
   input  wire                    s_axi_wvalid         , // group DP_S_AXILITE
   output wire                    s_axi_wready         , // group DP_S_AXILITE
   output wire    [1:0]           s_axi_bresp          , // group DP_S_AXILITE
   output wire                    s_axi_bvalid         , // group DP_S_AXILITE
   input  wire                    s_axi_bready         , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_araddr         , // group DP_S_AXILITE
   input  wire    [2:0]           s_axi_arprot         , // group DP_S_AXILITE
   input  wire                    s_axi_arvalid        , // group DP_S_AXILITE
   output wire                    s_axi_arready        , // group DP_S_AXILITE
   output wire    [31:0]          s_axi_rdata          , // group DP_S_AXILITE
   output wire    [1:0]           s_axi_rresp          , // group DP_S_AXILITE
   output wire                    s_axi_rvalid         , // group DP_S_AXILITE
   input  wire                    s_axi_rready         , // group DP_S_AXILITE
   output wire                    axi_int              , // group DP_S_AXILITE

   input  wire                    tx_vid_clk           , // group VIDEO_IF
   input  wire                    tx_vid_rst           , // group VIDEO_IF
   input  wire                    tx_vid_vsync         , // group VIDEO_IF
   input  wire                    tx_vid_hsync         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven       , // group VIDEO_IF
   input  wire                    tx_vid_enable        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream2           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream2           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream2         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream2         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream2       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream2        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream3           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream3           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream3         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream3         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream3       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream3        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream4           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream4           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream4         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream4         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream4       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream4        , // group VIDEO_IF
   
   input wire     [31:0]          txss_axi_status,  //Status from TX Subsystem sub Ip's
   output wire    [31:0]          txss_axi_control, //Control to TX Subsystem sub Ip's
   
   input  wire                    tx_lnk_clk                      ,
   output wire [31:0]             lnk_tx_axi4s_lane0_tdata        , // 4 byte interface
   output wire [11:0]             lnk_tx_axi4s_lane0_tuser        , // DISPMODE,DISPVAL,CHARISK - each per byte
   output wire                    lnk_tx_axi4s_lane0_tvalid       , 
   input  wire                    lnk_tx_axi4s_lane0_tready       ,  

   input  wire [31:0]             lnk_tx_sb_status_axi4s_tdata,
   input  wire                    lnk_tx_sb_status_axi4s_tvalid,
   output wire                    lnk_tx_sb_status_axi4s_tready,
   output wire [31:0]             lnk_tx_axi4s_lane1_tdata        ,
   output wire [11:0]             lnk_tx_axi4s_lane1_tuser        ,
   output wire                    lnk_tx_axi4s_lane1_tvalid       , 
   input  wire                    lnk_tx_axi4s_lane1_tready       , 
   output wire [31:0]             lnk_tx_axi4s_lane2_tdata        ,
   output wire [11:0]             lnk_tx_axi4s_lane2_tuser        ,
   output wire                    lnk_tx_axi4s_lane2_tvalid       , 
   input  wire                    lnk_tx_axi4s_lane2_tready       , 
   
   output wire [31:0]             lnk_tx_axi4s_lane3_tdata        ,
   output wire [11:0]             lnk_tx_axi4s_lane3_tuser        ,
   output wire                    lnk_tx_axi4s_lane3_tvalid       , 
   input  wire                    lnk_tx_axi4s_lane3_tready       , 




   input  wire                    aux_tx_data_in          , // group AUXIO
   output wire                    aux_tx_data_out         , // group AUXIO
   output wire                    aux_tx_data_en_out_n      , // group AUXIO
   input  wire                    tx_hpd               ,
   output wire [31:0]  tx_gt_ctrl_out,
   output wire [2:0]   tx_bpc,
   output wire [1:0]   tx_video_format,
   output wire [2:0]   tx_ppc,
   output wire [1:0]   tx_video_format_stream2,
   output wire [2:0]   tx_ppc_stream2,
   output wire [1:0]   tx_video_format_stream3,
   output wire [2:0]   tx_ppc_stream3,
   output wire [1:0]   tx_video_format_stream4,
   output wire [2:0]   tx_ppc_stream4,

   input  wire                    rx_vid_clk           , // group VIDEO_IF
   input  wire                    rx_vid_rst           , // group VIDEO_IF
   output wire  [2:0]             rx_vid_pixel_mode    ,                   
   output wire                    rx_vid_vsync         , // group VIDEO_IF
   output wire                    rx_vid_hsync         , // group VIDEO_IF
   output wire                    rx_vid_oddeven       , // group VIDEO_IF
   output wire                    rx_vid_enable        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream2           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream2           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream2         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream2         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream2       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream2        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream3           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream3           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream3         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream3         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream3       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream3        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream4           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream4           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream4         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream4         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream4       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream4        , // group VIDEO_IF

   output wire    [15:0]          rx_vid_msa_hres,
   output wire    [15:0]          rx_vid_msa_vres,
   output wire    [15:0]          rx_vid_msa_hres_stream2,
   output wire    [15:0]          rx_vid_msa_vres_stream2,
   output wire    [15:0]          rx_vid_msa_hres_stream3,
   output wire    [15:0]          rx_vid_msa_vres_stream3,
   output wire    [15:0]          rx_vid_msa_hres_stream4,
   output wire    [15:0]          rx_vid_msa_vres_stream4,

   output wire    [2:0]           rx_bpc,
   output wire    [2:0]           rx_bpc_stream2,
   output wire    [2:0]           rx_bpc_stream3,
   output wire    [2:0]           rx_bpc_stream4,

   output wire    [2:0]           rx_cformat,
   output wire    [2:0]           rx_cformat_stream2,
   output wire    [2:0]           rx_cformat_stream3,
   output wire    [2:0]           rx_cformat_stream4,

   output wire    [23:0]          lnk_m_vid            ,
   output wire    [23:0]          lnk_n_vid            ,
   input  wire                    aux_rx_data_in          , // group AUXIO
   output wire                    aux_rx_data_out         , // group AUXIO
   output wire                    aux_rx_data_en_out_n      , // group AUXIO
   // Rx Signals
   input  wire                    rx_lnk_clk                      ,
   input  wire [31:0]             lnk_rx_axi4s_lane0_tdata        , // 4 byte interface
   input  wire [11:0]             lnk_rx_axi4s_lane0_tuser        , // SYMBERR,DISPERR,CHARISK - each per byte
   input  wire                    lnk_rx_axi4s_lane0_tvalid       , 
   output wire                    lnk_rx_axi4s_lane0_tready       ,  

   output wire [7:0]              lnk_rx_sb_control_axi4s_tdata,
   output wire                    lnk_rx_sb_control_axi4s_tvalid,
   input  wire                    lnk_rx_sb_control_axi4s_tready,
   input  wire [31:0]             lnk_rx_sb_status_axi4s_tdata,
   input  wire                    lnk_rx_sb_status_axi4s_tvalid,
   output wire                    lnk_rx_sb_status_axi4s_tready,
   input  wire [31:0]             lnk_rx_axi4s_lane1_tdata        ,
   input  wire [11:0]             lnk_rx_axi4s_lane1_tuser        ,
   input  wire                    lnk_rx_axi4s_lane1_tvalid       , 
   output wire                    lnk_rx_axi4s_lane1_tready       , 
   input  wire [31:0]             lnk_rx_axi4s_lane2_tdata        ,
   input  wire [11:0]             lnk_rx_axi4s_lane2_tuser        ,
   input  wire                    lnk_rx_axi4s_lane2_tvalid       , 
   output wire                    lnk_rx_axi4s_lane2_tready       , 
   
   input  wire [31:0]             lnk_rx_axi4s_lane3_tdata        ,
   input  wire [11:0]             lnk_rx_axi4s_lane3_tuser        ,
   input  wire                    lnk_rx_axi4s_lane3_tvalid       , 
   output wire                    lnk_rx_axi4s_lane3_tready       , 


   output wire [31:0]  rx_gt_ctrl_out,
   output wire                    rx_hpd               ,
   input  wire                    i2c_sda_in           ,
   output wire                    i2c_sda_enable_n     ,
   input  wire                    i2c_scl_in           ,
   output wire                    i2c_scl_enable_n     ,

   input  wire                    aud_clk              ,
   input  wire                    aud_rst              ,
   input  wire                    aud_axis_aclk        ,
   input  wire                    aud_axis_aresetn     ,
   input wire [31:0]              s_axis_audio_ingress_tdata,
   input wire [7:0]               s_axis_audio_ingress_tid,
   input wire                     s_axis_audio_ingress_tvalid,
   output wire                    s_axis_audio_ingress_tready,
   output wire [7:0]              m_axis_audio_egress_tid,
   output wire [31:0]             m_axis_audio_egress_tdata,
   input  wire                    m_axis_audio_egress_tready,
   output wire                    m_axis_audio_egress_tvalid,

   output wire    [23:0]          lnk_m_aud            ,
   output wire    [23:0]          lnk_n_aud            ,
   output wire                    link_bw_high_out     ,
   output wire                    link_bw_hbr2_out     ,
   output wire                    bw_changed_out       ,

   // HDCP Data path signals 
   output wire                    hdcp_egress_clk      ,
   input  wire                    hdcp_ingress_clk     ,
   input  wire                    hdcp_ext_clk         ,
   input  wire                    hdcp_ingress_clken   ,
   output wire                    hdcp_egress_clken    ,
   output wire                    hdcp_rst             ,
   output wire                    hdcp13_soft_rst      ,
   output wire                    hdcp22_soft_rst      ,

   input  wire [7:0]              hdcp_status          ,

   output wire [127:0]            hdcp_egress_data     ,
   output wire [15:0]             hdcp_egress_tuser    ,
   input  wire                    hdcp_egress_tready   ,
   output wire                    hdcp_egress_tvalid   ,

   input  wire [127:0]            hdcp_ingress_data    ,
   input  wire [15:0]             hdcp_ingress_tuser   ,
   output wire                    hdcp_ingress_tready  ,
   input  wire                    hdcp_ingress_tvalid  ,

   output wire                    hdcp_egress_fifo_afull,
   // ACR (Audio Clock Regeneration) Interface
   output wire [23:0]             acr_m_aud, 
   output wire [23:0]             acr_n_aud, 
   output wire                    acr_valid
  );

    //---------------------------------------------
    // global internal wires
    //---------------------------------------------
    wire            axi_reset;
    //---------------------------------------------
    // tx internal wires
    //---------------------------------------------
    wire [7:0]      lnk_tx_lane0_override_disparity;
    wire [3:0]      lnk_tx_lane0_k_char;           
    wire [31:0]     lnk_tx_lane0_data;             
    wire [7:0]      lnk_tx_lane1_override_disparity;
    wire [3:0]      lnk_tx_lane1_k_char;          
    wire [31:0]     lnk_tx_lane1_data;           
    wire [7:0]      lnk_tx_lane2_override_disparity;
    wire [3:0]      lnk_tx_lane2_k_char;
    wire [31:0]     lnk_tx_lane2_data;             
    wire [7:0]      lnk_tx_lane3_override_disparity;
    wire [3:0]      lnk_tx_lane3_k_char; 
    wire [31:0]     lnk_tx_lane3_data;           
    wire            tx_aux_data_out;
    wire            tx_aux_data_in;
    wire            tx_aux_data_enable_n;
    wire `tDPORT_TX_PHY_CONFIG  cfg_tx_phy_config;
    wire `tDPORT_TX_PHY_STATUS  cfg_tx_phy_status;
    localparam CFG_STATUS_WIDTH = 50;
    wire            tx_hot_plug_detect;
    wire [3:0]      lnk_tx_disp_lane0_value;           
    wire [3:0]      lnk_tx_disp_lane0_mode;           
    wire [3:0]      lnk_tx_disp_lane1_value;           
    wire [3:0]      lnk_tx_disp_lane1_mode;           
    wire [3:0]      lnk_tx_disp_lane2_value;           
    wire [3:0]      lnk_tx_disp_lane2_mode;           
    wire [3:0]      lnk_tx_disp_lane3_value;           
    wire [3:0]      lnk_tx_disp_lane3_mode;           




    //---------------------------------------------
    // rx internal wires
    //---------------------------------------------
    wire            rx_aux_data_in;
    wire            rx_aux_data_out;
    wire            rx_aux_data_enable_n;
    wire            access_train_lane_set;
    wire            access_link_bw_set;
    wire            rx_hot_plug_detect;
    wire [3:0]      lnk_rx_lane0_k_char;
    wire [31:0]     lnk_rx_lane0_data;
    wire [3:0]      lnk_rx_lane0_symbol_error;
    wire [3:0]      lnk_rx_lane0_disparity_error;
    wire [3:0]      lnk_rx_lane1_k_char;
    wire [31:0]     lnk_rx_lane1_data;
    wire [3:0]      lnk_rx_lane1_symbol_error;
    wire [3:0]      lnk_rx_lane1_disparity_error;
    wire [3:0]      lnk_rx_lane2_k_char;
    wire [31:0]     lnk_rx_lane2_data;
    wire [3:0]      lnk_rx_lane2_symbol_error;
    wire [3:0]      lnk_rx_lane2_disparity_error;
    wire [3:0]      lnk_rx_lane3_k_char;
    wire [31:0]     lnk_rx_lane3_data;
    wire [3:0]      lnk_rx_lane3_symbol_error;
    wire [3:0]      lnk_rx_lane3_disparity_error;
    wire            lnk_rx_gt_buf_rst;
    wire `tDPORT_RX_PHY_CONFIG   cfg_rx_phy_config;
    wire `tDPORT_RX_PHY_STATUS   cfg_rx_phy_status;
    wire `tDPORT_RX_DPCD_REGS    cfg_rx_dpcd_regs;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream2;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream3;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream4;


generate if ( C_FLOW_DIRECTION == 0 )
begin
    // TDATA 
    assign lnk_tx_axi4s_lane0_tdata = lnk_tx_lane0_data;
    assign lnk_tx_axi4s_lane1_tdata = lnk_tx_lane1_data;
    assign lnk_tx_axi4s_lane2_tdata = lnk_tx_lane2_data;
    assign lnk_tx_axi4s_lane3_tdata = lnk_tx_lane3_data;

    // TUSER 
    assign lnk_tx_disp_lane0_value  = {lnk_tx_lane0_override_disparity[6], lnk_tx_lane0_override_disparity[4], lnk_tx_lane0_override_disparity[2], lnk_tx_lane0_override_disparity[0]};
    assign lnk_tx_disp_lane0_mode   = {lnk_tx_lane0_override_disparity[7], lnk_tx_lane0_override_disparity[5], lnk_tx_lane0_override_disparity[3], lnk_tx_lane0_override_disparity[1]};
    assign lnk_tx_axi4s_lane0_tuser =  {lnk_tx_disp_lane0_value,lnk_tx_disp_lane0_mode,lnk_tx_lane0_k_char};

    assign lnk_tx_disp_lane1_value  = {lnk_tx_lane1_override_disparity[6], lnk_tx_lane1_override_disparity[4], lnk_tx_lane1_override_disparity[2], lnk_tx_lane1_override_disparity[0]};
    assign lnk_tx_disp_lane1_mode   = {lnk_tx_lane1_override_disparity[7], lnk_tx_lane1_override_disparity[5], lnk_tx_lane1_override_disparity[3], lnk_tx_lane1_override_disparity[1]};
    assign lnk_tx_axi4s_lane1_tuser =  {lnk_tx_disp_lane1_value,lnk_tx_disp_lane1_mode,lnk_tx_lane1_k_char};

    assign lnk_tx_disp_lane2_value  = {lnk_tx_lane2_override_disparity[6], lnk_tx_lane2_override_disparity[4], lnk_tx_lane2_override_disparity[2], lnk_tx_lane2_override_disparity[0]};
    assign lnk_tx_disp_lane2_mode   = {lnk_tx_lane2_override_disparity[7], lnk_tx_lane2_override_disparity[5], lnk_tx_lane2_override_disparity[3], lnk_tx_lane2_override_disparity[1]};
    assign lnk_tx_axi4s_lane2_tuser =  {lnk_tx_disp_lane2_value,lnk_tx_disp_lane2_mode,lnk_tx_lane2_k_char};

    assign lnk_tx_disp_lane3_value  = {lnk_tx_lane3_override_disparity[6], lnk_tx_lane3_override_disparity[4], lnk_tx_lane3_override_disparity[2], lnk_tx_lane3_override_disparity[0]};
    assign lnk_tx_disp_lane3_mode   = {lnk_tx_lane3_override_disparity[7], lnk_tx_lane3_override_disparity[5], lnk_tx_lane3_override_disparity[3], lnk_tx_lane3_override_disparity[1]};
    assign lnk_tx_axi4s_lane3_tuser =  {lnk_tx_disp_lane3_value,lnk_tx_disp_lane3_mode,lnk_tx_lane3_k_char};

    // TVALID
      assign lnk_tx_axi4s_lane0_tvalid = 1;
      assign lnk_tx_axi4s_lane1_tvalid = 1;
      assign lnk_tx_axi4s_lane2_tvalid = 1;
      assign lnk_tx_axi4s_lane3_tvalid = 1;
   
    // Sideband
    localparam TX_CH0_PLL_LOCK = 1;
    localparam TX_CH1_PLL_LOCK = 3;
    localparam TX_CH2_PLL_LOCK = 5;
    localparam TX_CH3_PLL_LOCK = 7;
    localparam TX_CH0_RESET_DONE = 0;
    localparam TX_CH1_RESET_DONE = 2;
    localparam TX_CH2_RESET_DONE = 4;
    localparam TX_CH3_RESET_DONE = 6;


  // PLL lock status
       assign i_tx_pll_lock_lane1 = lnk_tx_sb_status_axi4s_tdata[TX_CH1_PLL_LOCK];
       assign i_tx_pll_lock_lane3 = lnk_tx_sb_status_axi4s_tdata[TX_CH3_PLL_LOCK];
       assign i_tx_pll_lock_lane2 = lnk_tx_sb_status_axi4s_tdata[TX_CH2_PLL_LOCK];


    // No Back pressure on Sideband interface
      assign lnk_tx_sb_status_axi4s_tready = 1'b1;

 assign i_pll_lock_detect_tile_0 = lnk_tx_sb_status_axi4s_tdata[TX_CH0_PLL_LOCK]& i_tx_pll_lock_lane1;
 assign i_pll_lock_detect_tile_1 = i_tx_pll_lock_lane2 & i_tx_pll_lock_lane3;
 assign  cfg_tx_phy_status[3:0]    = {lnk_tx_sb_status_axi4s_tdata[TX_CH3_RESET_DONE],lnk_tx_sb_status_axi4s_tdata[TX_CH2_RESET_DONE],
                                      lnk_tx_sb_status_axi4s_tdata[TX_CH1_RESET_DONE],lnk_tx_sb_status_axi4s_tdata[TX_CH0_RESET_DONE]};
 assign  cfg_tx_phy_status[4]      = i_pll_lock_detect_tile_0;
 assign  cfg_tx_phy_status[5]      = i_pll_lock_detect_tile_1;
 assign  cfg_tx_phy_status[6]      = 1'b1; 
 assign  cfg_tx_phy_status[7]      = 1'b0; 
 assign  cfg_tx_phy_status[11:8]   = lnk_tx_sb_status_axi4s_tdata[11:8]; 
 assign  cfg_tx_phy_status[CFG_STATUS_WIDTH-1:12] = 0; 
 assign lnk_clk = tx_lnk_clk;
    //----------------------------------------------
    // Hot Plug Detect
    //----------------------------------------------
    IBUF  hot_plug_detect_inst (
        .O (tx_hot_plug_detect),
        .I (tx_hpd)
    );

    //----------------------------------------------
    // AUX Channel
    //----------------------------------------------




    //----------------------------------------------
    // Displayport TX link component
    //----------------------------------------------
    displayport_v8_1_2_txlink_top #(
        .C_FAMILY                ( C_FAMILY                ),
        .C_COMPONENT_NAME        ( C_COMPONENT_NAME        ),
        .C_LANE_COUNT            ( C_LANE_COUNT            ),
        .C_FLOW_DIRECTION        ( C_FLOW_DIRECTION        ),
        .C_INCLUDE_HDCP          ( C_INCLUDE_HDCP          ),
        .C_INCLUDE_HDCP22        ( C_INCLUDE_HDCP22        ),
        .C_SECONDARY_SUPPORT     ( C_SECONDARY_SUPPORT     ),
        .C_IEEE_OUI              ( C_IEEE_OUI              ),
        .C_AUDIO_CHANNELS        ( C_AUDIO_CHANNELS        ),
        .C_S_BASEADDR            ( C_S_BASEADDR            ),
        .C_S_HIGHADDR            ( C_S_HIGHADDR            ),
        .C_PROTOCOL_SELECTION    ( C_PROTOCOL_SELECTION    ),
        .C_LINK_RATE             ( C_LINK_RATE             ),
        .C_MST_ENABLE            ( C_MST_ENABLE            ),
        .C_NUMBER_OF_MST_STREAMS ( C_NUMBER_OF_MST_STREAMS ),
        .C_MAX_BITS_PER_COLOR    ( C_MAX_BITS_PER_COLOR    ),
        .C_QUAD_PIXEL_ENABLE     ( C_QUAD_PIXEL_ENABLE     ),
        .C_DUAL_PIXEL_ENABLE     ( C_DUAL_PIXEL_ENABLE     ),
        .C_YCRCB_ENABLE          ( C_YCRCB_ENABLE          ),
        .C_YONLY_ENABLE          ( C_YONLY_ENABLE          ),
        .C_VENDOR_SPECIFIC       ( C_VENDOR_SPECIFIC       ),
        .C_DATA_WIDTH            ( C_DATA_WIDTH            ),
	.C_EDP_EN                ( C_EDP_EN                ),
	.C_IS_VERSAL             ( C_IS_VERSAL             ),
	.C_SIM_MODE              ( C_SIM_MODE              )
    ) dport_link_inst (
        .axi_reset                             (axi_reset),
        .s_axi_aclk                            (s_axi_aclk),   
        .s_axi_aresetn                         (s_axi_aresetn),
        .s_axi_awaddr                          (s_axi_awaddr), 
        .s_axi_awprot                          (s_axi_awprot), 
        .s_axi_awvalid                         (s_axi_awvalid),
        .s_axi_awready                         (s_axi_awready),
        .s_axi_wdata                           (s_axi_wdata),  
        .s_axi_wstrb                           (s_axi_wstrb),  
        .s_axi_wvalid                          (s_axi_wvalid), 
        .s_axi_wready                          (s_axi_wready), 
        .s_axi_bresp                           (s_axi_bresp),  
        .s_axi_bvalid                          (s_axi_bvalid), 
        .s_axi_bready                          (s_axi_bready), 
        .s_axi_araddr                          (s_axi_araddr), 
        .s_axi_arprot                          (s_axi_arprot), 
        .s_axi_arvalid                         (s_axi_arvalid),
        .s_axi_arready                         (s_axi_arready),
        .s_axi_rdata                           (s_axi_rdata),  
        .s_axi_rresp                           (s_axi_rresp),  
        .s_axi_rvalid                          (s_axi_rvalid), 
        .s_axi_rready                          (s_axi_rready), 
        .axi_int                               (axi_int),

        .tx_vid_clk                            (tx_vid_clk),
        .tx_vid_rst                            (tx_vid_rst),
        .tx_vid_vsync                          (tx_vid_vsync),
        .tx_vid_hsync                          (tx_vid_hsync),
        .tx_vid_oddeven                        (tx_vid_oddeven),
        .tx_vid_enable                         (tx_vid_enable),
        .tx_vid_pixel0                         (tx_vid_pixel0),
        .tx_vid_pixel1                         (tx_vid_pixel1),
        .tx_vid_pixel2                         (tx_vid_pixel2),
        .tx_vid_pixel3                         (tx_vid_pixel3),

        .tx_vid_clk_stream2                    (tx_vid_clk_stream2    ),   
        .tx_vid_rst_stream2                    (tx_vid_rst_stream2    ), 
        .tx_vid_vsync_stream2                  (tx_vid_vsync_stream2  ), 
        .tx_vid_hsync_stream2                  (tx_vid_hsync_stream2  ),
        .tx_vid_oddeven_stream2                (tx_vid_oddeven_stream2),
        .tx_vid_enable_stream2                 (tx_vid_enable_stream2 ),
        .tx_vid_pixel0_stream2                 (tx_vid_pixel0_stream2 ),
        .tx_vid_pixel1_stream2                 (tx_vid_pixel1_stream2 ),
        .tx_vid_pixel2_stream2                 (tx_vid_pixel2_stream2 ),
        .tx_vid_pixel3_stream2                 (tx_vid_pixel3_stream2 ),
   
        .tx_vid_clk_stream3                    (tx_vid_clk_stream3    ),   
        .tx_vid_rst_stream3                    (tx_vid_rst_stream3    ), 
        .tx_vid_vsync_stream3                  (tx_vid_vsync_stream3  ), 
        .tx_vid_hsync_stream3                  (tx_vid_hsync_stream3  ),
        .tx_vid_oddeven_stream3                (tx_vid_oddeven_stream3),
        .tx_vid_enable_stream3                 (tx_vid_enable_stream3 ),
        .tx_vid_pixel0_stream3                 (tx_vid_pixel0_stream3 ),
        .tx_vid_pixel1_stream3                 (tx_vid_pixel1_stream3 ),
        .tx_vid_pixel2_stream3                 (tx_vid_pixel2_stream3 ),
        .tx_vid_pixel3_stream3                 (tx_vid_pixel3_stream3 ),
                                            
        .tx_vid_clk_stream4                    (tx_vid_clk_stream4    ),   
        .tx_vid_rst_stream4                    (tx_vid_rst_stream4    ), 
        .tx_vid_vsync_stream4                  (tx_vid_vsync_stream4  ), 
        .tx_vid_hsync_stream4                  (tx_vid_hsync_stream4  ),
        .tx_vid_oddeven_stream4                (tx_vid_oddeven_stream4),
        .tx_vid_enable_stream4                 (tx_vid_enable_stream4 ),
        .tx_vid_pixel0_stream4                 (tx_vid_pixel0_stream4 ),
        .tx_vid_pixel1_stream4                 (tx_vid_pixel1_stream4 ),
        .tx_vid_pixel2_stream4                 (tx_vid_pixel2_stream4 ),
        .tx_vid_pixel3_stream4                 (tx_vid_pixel3_stream4 ),

        .hdcp_ext_clk                          (hdcp_ext_clk          ),
        .hdcp_ingress_clk                      (hdcp_ingress_clk      ),
        .hdcp_egress_clk                       (hdcp_egress_clk       ),
        .hdcp_ingress_clken                    (hdcp_ingress_clken    ),
        .hdcp_egress_clken                     (hdcp_egress_clken     ),
        .hdcp_rst                              (hdcp_rst              ),
        .hdcp_soft_rst                         (hdcp22_soft_rst       ),
        .hdcp_status                           (hdcp_status           ),
        .hdcp_egress_data                      (hdcp_egress_data      ),
        .hdcp_egress_tuser                     (hdcp_egress_tuser     ),
        .hdcp_egress_tready                    (hdcp_egress_tready    ),
        .hdcp_egress_tvalid                    (hdcp_egress_tvalid    ),
        .hdcp_ingress_data                     (hdcp_ingress_data     ),
        .hdcp_ingress_tuser                    (hdcp_ingress_tuser    ),
        .hdcp_ingress_tready                   (hdcp_ingress_tready   ),
        .hdcp_ingress_tvalid                   (hdcp_ingress_tvalid   ),
        .hdcp_egress_fifo_afull                (hdcp_egress_fifo_afull),

        .tx_lnk_clk                            (lnk_clk),
        .tx_lnk_tx_lane0_override_disparity    (lnk_tx_lane0_override_disparity),
        .tx_lnk_tx_lane0_k_char                (lnk_tx_lane0_k_char),
        .tx_lnk_tx_lane0_data                  (lnk_tx_lane0_data),              
        .tx_lnk_tx_lane1_override_disparity    (lnk_tx_lane1_override_disparity),
        .tx_lnk_tx_lane1_k_char                (lnk_tx_lane1_k_char),            
        .tx_lnk_tx_lane1_data                  (lnk_tx_lane1_data),              
        .tx_lnk_tx_lane2_override_disparity    (lnk_tx_lane2_override_disparity),
        .tx_lnk_tx_lane2_k_char                (lnk_tx_lane2_k_char),            
        .tx_lnk_tx_lane2_data                  (lnk_tx_lane2_data),              
        .tx_lnk_tx_lane3_override_disparity    (lnk_tx_lane3_override_disparity),
        .tx_lnk_tx_lane3_k_char                (lnk_tx_lane3_k_char),            
        .tx_lnk_tx_lane3_data                  (lnk_tx_lane3_data),              
        .tx_cfg_tx_phy_config                  (cfg_tx_phy_config),
        .tx_cfg_tx_phy_status                  (cfg_tx_phy_status),
        .tx_aux_data_in                        (tx_aux_data_in),
        .tx_aux_data_out                       (tx_aux_data_out),
        .tx_aux_data_enable_n                  (tx_aux_data_enable_n),
        .tx_hot_plug_detect                    (tx_hot_plug_detect),
        .tx_gt_ctrl_out                        (tx_gt_ctrl_out),
        .tx_bpc                                (tx_bpc),
        .tx_video_format                       (tx_video_format),
        .tx_ppc                                (tx_ppc),
	     .txss_axi_control                      (txss_axi_control),
	     .txss_axi_status                       (txss_axi_status),
        .tx_video_format_stream2               (tx_video_format_stream2),
        .tx_ppc_stream2                        (tx_ppc_stream2),
        .tx_video_format_stream3               (tx_video_format_stream3),
        .tx_ppc_stream3                        (tx_ppc_stream3),
        .tx_video_format_stream4               (tx_video_format_stream4),
        .tx_ppc_stream4                        (tx_ppc_stream4),

        .tx_aud_clk                            (aud_clk),
        .tx_s_axis_audio_ingress_aclk          (aud_axis_aclk),
        .tx_s_axis_audio_ingress_aresetn       (aud_axis_aresetn),
        .tx_s_axis_audio_ingress_tdata         (s_axis_audio_ingress_tdata),
        .tx_s_axis_audio_ingress_tid           (s_axis_audio_ingress_tid),
        .tx_s_axis_audio_ingress_tvalid        (s_axis_audio_ingress_tvalid),
        .tx_s_axis_audio_ingress_tready        (s_axis_audio_ingress_tready),

        .tx_s_axis_audio_ingress_aclk_stream2          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream2       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream2         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream2           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream2        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream2        (       ),

        .tx_s_axis_audio_ingress_aclk_stream3          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream3       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream3         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream3           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream3        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream3        (       ),

        .tx_s_axis_audio_ingress_aclk_stream4          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream4       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream4         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream4           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream4        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream4        (       )
    );
    assign tx_aux_data_in = aux_tx_data_in;
    assign aux_tx_data_out = tx_aux_data_out;
    assign aux_tx_data_en_out_n = tx_aux_data_enable_n;


    //Driver 0's to Rx ports
    assign  rx_vid_pixel_mode =  3'h0;    
    assign  rx_vid_vsync     =  1'b0;    
    assign  rx_vid_hsync     =  1'b0;
    assign  rx_vid_oddeven   =  1'b0;
    assign  rx_vid_enable    =  1'b0;
    assign  rx_vid_pixel0    = 48'h0;
    assign  rx_vid_pixel1    = 48'h0;
    assign  rx_vid_pixel2    = 48'h0;
    assign  rx_vid_pixel3    = 48'h0;

    assign  rx_vid_vsync_stream2     =  1'b0;    
    assign  rx_vid_hsync_stream2     =  1'b0;
    assign  rx_vid_oddeven_stream2   =  1'b0;
    assign  rx_vid_enable_stream2    =  1'b0;
    assign  rx_vid_pixel0_stream2    = 48'h0;
    assign  rx_vid_pixel1_stream2    = 48'h0;
    assign  rx_vid_pixel2_stream2    = 48'h0;
    assign  rx_vid_pixel3_stream2    = 48'h0;

    assign  rx_vid_vsync_stream3     =  1'b0;    
    assign  rx_vid_hsync_stream3     =  1'b0;
    assign  rx_vid_oddeven_stream3   =  1'b0;
    assign  rx_vid_enable_stream3    =  1'b0;
    assign  rx_vid_pixel0_stream3    = 48'h0;
    assign  rx_vid_pixel1_stream3    = 48'h0;
    assign  rx_vid_pixel2_stream3    = 48'h0;
    assign  rx_vid_pixel3_stream3    = 48'h0;

    assign  rx_vid_vsync_stream4     =  1'b0;    
    assign  rx_vid_hsync_stream4     =  1'b0;
    assign  rx_vid_oddeven_stream4   =  1'b0;
    assign  rx_vid_enable_stream4    =  1'b0;
    assign  rx_vid_pixel0_stream4    = 48'h0;
    assign  rx_vid_pixel1_stream4    = 48'h0;
    assign  rx_vid_pixel2_stream4    = 48'h0;
    assign  rx_vid_pixel3_stream4    = 48'h0;

    assign  rx_vid_msa_hres          = 16'h0;
    assign  rx_vid_msa_vres          = 16'h0;
    assign  rx_vid_msa_hres_stream2  = 16'h0;
    assign  rx_vid_msa_vres_stream2  = 16'h0;
    assign  rx_vid_msa_hres_stream3  = 16'h0;
    assign  rx_vid_msa_vres_stream3  = 16'h0;
    assign  rx_vid_msa_hres_stream4  = 16'h0;
    assign  rx_vid_msa_vres_stream4  = 16'h0;

    assign  lnk_m_vid  = 24'h0;
    assign  lnk_n_vid  = 24'h0;
    assign  rx_hpd     =  1'b0;
    assign  i2c_sda_enable_n   =  1'b1;
    assign  i2c_scl_enable_n   =  1'b1;
  
   assign lnk_m_aud            = 24'h0; 
   assign lnk_n_aud            = 24'h0; 

   assign rx_bpc         = 3'd0;
   assign rx_bpc_stream2 = 3'd0;
   assign rx_bpc_stream3 = 3'd0;
   assign rx_bpc_stream4 = 3'd0;
   assign rx_cformat         = 3'd0;
   assign rx_cformat_stream2 = 3'd0;
   assign rx_cformat_stream3 = 3'd0;
   assign rx_cformat_stream4 = 3'd0;

end

else if ( C_FLOW_DIRECTION == 1 )
begin

 

    // TDATA 
    assign lnk_rx_lane0_data = lnk_rx_axi4s_lane0_tdata;
    assign lnk_rx_lane1_data = lnk_rx_axi4s_lane1_tdata;
    assign {lnk_rx_lane1_symbol_error,lnk_rx_lane1_disparity_error,lnk_rx_lane1_k_char} = lnk_rx_axi4s_lane1_tuser;
    assign lnk_rx_lane2_data = lnk_rx_axi4s_lane2_tdata;
    assign lnk_rx_lane3_data = lnk_rx_axi4s_lane3_tdata;
    assign {lnk_rx_lane2_symbol_error,lnk_rx_lane2_disparity_error,lnk_rx_lane2_k_char} = lnk_rx_axi4s_lane2_tuser;
    assign {lnk_rx_lane3_symbol_error,lnk_rx_lane3_disparity_error,lnk_rx_lane3_k_char} = lnk_rx_axi4s_lane3_tuser;

    // TUSER 
    assign {lnk_rx_lane0_symbol_error,lnk_rx_lane0_disparity_error,lnk_rx_lane0_k_char} = lnk_rx_axi4s_lane0_tuser;

    // TREADY
    assign lnk_rx_axi4s_lane0_tready = 1'b1;
    assign lnk_rx_axi4s_lane1_tready = 1'b1;
    assign lnk_rx_axi4s_lane2_tready = 1'b1;
    assign lnk_rx_axi4s_lane3_tready = 1'b1;
    assign lnk_rx_sb_status_axi4s_tready = 1'b1;

    // sideband handling
    localparam CH0_PLL_LOCK = 1;
    localparam CH1_PLL_LOCK = 4;
    localparam CH2_PLL_LOCK = 7;
    localparam CH3_PLL_LOCK = 10;
    localparam CH0_RESET_DONE = 0;
    localparam CH1_RESET_DONE = 3;
    localparam CH2_RESET_DONE = 6;
    localparam CH3_RESET_DONE = 9;
    localparam CH0_ALIGNED = 2;
    localparam CH1_ALIGNED = 5;
    localparam CH2_ALIGNED = 8;
    localparam CH3_ALIGNED = 11;
    localparam CH0_PRBS_ERR = 12;
    localparam CH1_PRBS_ERR = 13;
    localparam CH2_PRBS_ERR = 14;
    localparam CH3_PRBS_ERR = 15;

       assign i_rx_pll_lock_lane1 = lnk_rx_sb_status_axi4s_tdata[CH1_PLL_LOCK];
       assign i_rx_pll_lock_lane3 = lnk_rx_sb_status_axi4s_tdata[CH3_PLL_LOCK];
       assign i_rx_pll_lock_lane2 = lnk_rx_sb_status_axi4s_tdata[CH2_PLL_LOCK];

    assign i_pll_lock_detect_tile_0 = lnk_rx_sb_status_axi4s_tdata[1]& i_rx_pll_lock_lane1;
    assign i_pll_lock_detect_tile_1 = i_rx_pll_lock_lane2 & i_rx_pll_lock_lane3;
   
    assign i_lane0_aligned = lnk_rx_sb_status_axi4s_tdata[CH0_ALIGNED];
    assign i_lane1_aligned = lnk_rx_sb_status_axi4s_tdata[CH1_ALIGNED];
    assign i_lane2_aligned = lnk_rx_sb_status_axi4s_tdata[CH2_ALIGNED];
    assign i_lane3_aligned = lnk_rx_sb_status_axi4s_tdata[CH3_ALIGNED];

    assign  cfg_rx_phy_status[1:0]         = {lnk_rx_sb_status_axi4s_tdata[CH1_RESET_DONE],
                                             lnk_rx_sb_status_axi4s_tdata[CH0_RESET_DONE]};
    assign  cfg_rx_phy_status[3:2]         = {lnk_rx_sb_status_axi4s_tdata[CH3_RESET_DONE],
                                              lnk_rx_sb_status_axi4s_tdata[CH2_RESET_DONE]};
    assign  cfg_rx_phy_status[4]           = i_pll_lock_detect_tile_0;
    assign  cfg_rx_phy_status[5]           = i_pll_lock_detect_tile_1;
    assign  cfg_rx_phy_status[6]           = 'h1;
    assign  cfg_rx_phy_status[7]           = 'h1;
    assign  cfg_rx_phy_status[8]           = lnk_rx_sb_status_axi4s_tdata[CH0_PRBS_ERR];
    assign  cfg_rx_phy_status[9]           = lnk_rx_sb_status_axi4s_tdata[CH1_PRBS_ERR];
    assign  cfg_rx_phy_status[10]          = lnk_rx_sb_status_axi4s_tdata[CH2_PRBS_ERR];
    assign  cfg_rx_phy_status[11]          = lnk_rx_sb_status_axi4s_tdata[CH3_PRBS_ERR];
    assign  cfg_rx_phy_status[15:12]       = 0;
    assign  cfg_rx_phy_status[19:16]       = lnk_rx_sb_status_axi4s_tdata[19:16];
    assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE0_SYMBOL_LOCKED]       = i_lane0_aligned;
    assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE1_SYMBOL_LOCKED]       = i_lane1_aligned;
    assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE2_SYMBOL_LOCKED]       = i_lane2_aligned;
    assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE3_SYMBOL_LOCKED]       = i_lane3_aligned;

    assign lnk_clk = rx_lnk_clk; 

 //----------------------------------------------
 // GT reset generation logic, based on tp1
 //----------------------------------------------

  reg       tp1_reset_pulse;
  reg [1:0] i_training_pattern_q;
  reg       access_train_lane_set_q;
  reg       itr_reset_pulse;

  reg [7:0] tp1_rst_del;
  reg [7:0] itr_rst_del;

 always @ (posedge s_axi_aclk)
 begin
    if (axi_reset == 1'b1)
    begin
       i_training_pattern_q     <= #100 2'b 0;
       access_train_lane_set_q  <= #100 1'b 0;
    end
    else
    begin
       // store the value of the previous tp to detect a change
       i_training_pattern_q     <= #100 cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET];
       access_train_lane_set_q  <= #100 access_train_lane_set;

       // detect TP1 start
       if (i_training_pattern_q != 2'b01 && cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET] == 2'b01)
       begin
         tp1_reset_pulse   <= #100 1'b1;
       end
       else
       begin
          tp1_reset_pulse  <= #100 1'b0;
       end
       itr_reset_pulse <= #100 ((!access_train_lane_set_q) & access_train_lane_set);
    end
 end

 always @ (posedge s_axi_aclk)
 begin
    if (axi_reset == 1'b1)
    begin
       tp1_rst_del <= 8'b0;
       itr_rst_del <= 8'b0;
    end
    else
    begin
      tp1_rst_del  <= { tp1_rst_del [6:0], tp1_reset_pulse }; 
      itr_rst_del  <= { itr_rst_del [6:0], itr_reset_pulse }; 

    end
 end


    assign lnk_rx_sb_control_axi4s_tdata[0] = itr_reset_pulse;
    assign lnk_rx_sb_control_axi4s_tdata[1] = |tp1_rst_del;
    assign lnk_rx_sb_control_axi4s_tdata[7:2] = 'h0;
    assign lnk_rx_sb_control_axi4s_tvalid   = 1'b1;
    //----------------------------------------------
    // AUX Channel
    //----------------------------------------------
   //----------------------------------------------
   // Hot Plug Detect
   //----------------------------------------------
   OBUF hot_plug_detect_inst (
       .O (rx_hpd),
       .I (rx_hot_plug_detect)
   );



    

   assign rx_vid_msa_hres         = cfg_rx_vidmode_regs[`kCFG_RX_VIDMODE_HRES];
   assign rx_vid_msa_vres         = cfg_rx_vidmode_regs[`kCFG_RX_VIDMODE_VRES];
   assign rx_vid_msa_hres_stream2 = 16'h0000;
   assign rx_vid_msa_vres_stream2 = 16'h0000;
   assign rx_vid_msa_hres_stream3 = 16'h0000;
   assign rx_vid_msa_vres_stream3 = 16'h0000;
   assign rx_vid_msa_hres_stream4 = 16'h0000;
   assign rx_vid_msa_vres_stream4 = 16'h0000;
   assign rx_bpc                  = cfg_rx_vidmode_regs[135:133];
   assign rx_bpc_stream2          = 3'd0;
   assign rx_bpc_stream3          = 3'd0;
   assign rx_bpc_stream4          = 3'd0;
   assign rx_cformat              = {cfg_rx_vidmode_regs[143],cfg_rx_vidmode_regs[130:129]};
   assign rx_cformat_stream2      = 3'd0;
   assign rx_cformat_stream3      = 3'd0;
   assign rx_cformat_stream4      = 3'd0;
    //----------------------------------------------
    // DisplayPort RX link controller
    //----------------------------------------------
    displayport_v8_1_2_rxlink_top #(
        .C_FAMILY                ( C_FAMILY                ),
        .C_COMPONENT_NAME        ( C_COMPONENT_NAME        ),
        .C_LANE_COUNT            ( C_LANE_COUNT            ),
        .C_FLOW_DIRECTION        ( C_FLOW_DIRECTION        ),
        .C_INCLUDE_HDCP          ( C_INCLUDE_HDCP          ),
        .C_INCLUDE_HDCP22        ( C_INCLUDE_HDCP22        ),
        .C_SECONDARY_SUPPORT     ( C_SECONDARY_SUPPORT     ),
        .C_IEEE_OUI              ( C_IEEE_OUI              ),
        .C_AUDIO_CHANNELS        ( C_AUDIO_CHANNELS        ),
        .C_S_BASEADDR            ( C_S_BASEADDR            ),
        .C_S_HIGHADDR            ( C_S_HIGHADDR            ),
        .C_PROTOCOL_SELECTION    ( C_PROTOCOL_SELECTION    ),
        .C_LINK_RATE             ( C_LINK_RATE             ),
        .C_MST_ENABLE            ( C_MST_ENABLE            ),
        .C_NUMBER_OF_MST_STREAMS ( C_NUMBER_OF_MST_STREAMS ),
        .C_MAX_BITS_PER_COLOR    ( C_MAX_BITS_PER_COLOR    ),
        .C_QUAD_PIXEL_ENABLE     ( C_QUAD_PIXEL_ENABLE     ),
        .C_DUAL_PIXEL_ENABLE     ( C_DUAL_PIXEL_ENABLE     ),
        .C_YCRCB_ENABLE          ( C_YCRCB_ENABLE          ),
        .C_YONLY_ENABLE          ( C_YONLY_ENABLE          ),
        .C_VENDOR_SPECIFIC       ( C_VENDOR_SPECIFIC       ),
        .C_DATA_WIDTH            ( C_DATA_WIDTH            ),
	.C_EDP_EN                ( C_EDP_EN                ),
	.C_IS_VERSAL             ( C_IS_VERSAL             ),
	.C_SIM_MODE              ( C_SIM_MODE              )
    ) dport_link_inst (
        .axi_reset                       (axi_reset),
        .s_axi_aclk                      (s_axi_aclk),   
        .s_axi_aresetn                   (s_axi_aresetn),
        .s_axi_awaddr                    (s_axi_awaddr), 
        .s_axi_awprot                    (s_axi_awprot), 
        .s_axi_awvalid                   (s_axi_awvalid),
        .s_axi_awready                   (s_axi_awready),
        .s_axi_wdata                     (s_axi_wdata),  
        .s_axi_wstrb                     (s_axi_wstrb),  
        .s_axi_wvalid                    (s_axi_wvalid), 
        .s_axi_wready                    (s_axi_wready), 
        .s_axi_bresp                     (s_axi_bresp),  
        .s_axi_bvalid                    (s_axi_bvalid), 
        .s_axi_bready                    (s_axi_bready), 
        .s_axi_araddr                    (s_axi_araddr), 
        .s_axi_arprot                    (s_axi_arprot), 
        .s_axi_arvalid                   (s_axi_arvalid),
        .s_axi_arready                   (s_axi_arready),
        .s_axi_rdata                     (s_axi_rdata),  
        .s_axi_rresp                     (s_axi_rresp),  
        .s_axi_rvalid                    (s_axi_rvalid), 
        .s_axi_rready                    (s_axi_rready), 
        .axi_int                         (axi_int),

        .rx_vid_clk                      (rx_vid_clk),
        .rx_vid_rst                      (rx_vid_rst),
        .rx_vid_pixel_mode             	 (rx_vid_pixel_mode), 
        .rx_vid_vsync                    (rx_vid_vsync),
        .rx_vid_hsync                    (rx_vid_hsync),
        .rx_vid_oddeven                  (rx_vid_oddeven),
        .rx_vid_enable                   (rx_vid_enable),
        .rx_vid_pixel0                   (rx_vid_pixel0),
        .rx_vid_pixel1                   (rx_vid_pixel1),
        .rx_vid_pixel2                   (rx_vid_pixel2),
        .rx_vid_pixel3                   (rx_vid_pixel3),

        .rx_vid_clk_stream2 			(rx_vid_clk),
        .rx_vid_rst_stream2              	(rx_vid_rst),
        .rx_vid_vsync_stream2                  	(rx_vid_vsync_stream2  ), 
        .rx_vid_hsync_stream2                  	(rx_vid_hsync_stream2  ),
        .rx_vid_oddeven_stream2                	(rx_vid_oddeven_stream2),
        .rx_vid_enable_stream2                 	(rx_vid_enable_stream2 ),
        .rx_vid_pixel0_stream2                 	(rx_vid_pixel0_stream2 ),
        .rx_vid_pixel1_stream2                 	(rx_vid_pixel1_stream2 ),
        .rx_vid_pixel2_stream2                 	(rx_vid_pixel2_stream2 ),
        .rx_vid_pixel3_stream2                 	(rx_vid_pixel3_stream2 ),

        .rx_vid_clk_stream3              	(rx_vid_clk),
        .rx_vid_rst_stream3              	(rx_vid_rst),
        .rx_vid_vsync_stream3                  	(rx_vid_vsync_stream3  ), 
        .rx_vid_hsync_stream3                  	(rx_vid_hsync_stream3  ),
        .rx_vid_oddeven_stream3                	(rx_vid_oddeven_stream3),
        .rx_vid_enable_stream3                 	(rx_vid_enable_stream3 ),
        .rx_vid_pixel0_stream3                 	(rx_vid_pixel0_stream3 ),
        .rx_vid_pixel1_stream3                 	(rx_vid_pixel1_stream3 ),
        .rx_vid_pixel2_stream3                 	(rx_vid_pixel2_stream3 ),
        .rx_vid_pixel3_stream3                 	(rx_vid_pixel3_stream3 ),
 
        .rx_vid_clk_stream4                  	(rx_vid_clk),
        .rx_vid_rst_stream4                     (rx_vid_rst),
        .rx_vid_vsync_stream4                  	(rx_vid_vsync_stream4  ), 
        .rx_vid_hsync_stream4                  	(rx_vid_hsync_stream4  ),
        .rx_vid_oddeven_stream4                	(rx_vid_oddeven_stream4),
        .rx_vid_enable_stream4                 	(rx_vid_enable_stream4 ),
        .rx_vid_pixel0_stream4                 	(rx_vid_pixel0_stream4 ),
        .rx_vid_pixel1_stream4                 	(rx_vid_pixel1_stream4 ),
        .rx_vid_pixel2_stream4                 	(rx_vid_pixel2_stream4 ),
        .rx_vid_pixel3_stream4                 	(rx_vid_pixel3_stream4 ),
 

        .hdcp_ext_clk                          (hdcp_ext_clk          ),
        .hdcp_ingress_clk                      (hdcp_ingress_clk      ),
        .hdcp_egress_clk                       (hdcp_egress_clk       ),
        .hdcp_ingress_clken                    (hdcp_ingress_clken    ),
        .hdcp_egress_clken                     (hdcp_egress_clken     ),
        .hdcp_rst                              (hdcp_rst              ),
        .hdcp13_soft_rst                       (hdcp13_soft_rst       ),
        .hdcp22_soft_rst                       (hdcp22_soft_rst       ),
        .hdcp_status                           (hdcp_status           ),
        .hdcp_egress_data                      (hdcp_egress_data      ),
        .hdcp_egress_tuser                     (hdcp_egress_tuser     ),
        .hdcp_egress_tready                    (hdcp_egress_tready    ),
        .hdcp_egress_tvalid                    (hdcp_egress_tvalid    ),
        .hdcp_ingress_data                     (hdcp_ingress_data     ),
        .hdcp_ingress_tuser                    (hdcp_ingress_tuser    ),
        .hdcp_ingress_tready                   (hdcp_ingress_tready   ),
        .hdcp_ingress_tvalid                   (hdcp_ingress_tvalid   ),
        .hdcp_egress_fifo_afull                (hdcp_egress_fifo_afull),
 
        .rx_gt_ctrl_out                  (rx_gt_ctrl_out),
        .rx_lnk_m_vid                    (lnk_m_vid),
        .rx_lnk_n_vid                    (lnk_n_vid),
        .rx_lnk_m_aud                    (lnk_m_aud),
        .rx_lnk_n_aud                    (lnk_n_aud),
        .rx_lnk_clk                      (lnk_clk),
        .rx_lnk_rx_lane0_k_char          (lnk_rx_lane0_k_char),
        .rx_lnk_rx_lane0_data            (lnk_rx_lane0_data),
        .rx_lnk_rx_lane0_symbol_error    (lnk_rx_lane0_symbol_error),
        .rx_lnk_rx_lane0_disparity_error (lnk_rx_lane0_disparity_error),
        .rx_lnk_rx_lane1_k_char          (lnk_rx_lane1_k_char),
        .rx_lnk_rx_lane1_data            (lnk_rx_lane1_data),
        .rx_lnk_rx_lane1_symbol_error    (lnk_rx_lane1_symbol_error),
        .rx_lnk_rx_lane1_disparity_error (lnk_rx_lane1_disparity_error),
        .rx_lnk_rx_lane2_k_char          (lnk_rx_lane2_k_char),
        .rx_lnk_rx_lane2_data            (lnk_rx_lane2_data),
        .rx_lnk_rx_lane2_symbol_error    (lnk_rx_lane2_symbol_error),
        .rx_lnk_rx_lane2_disparity_error (lnk_rx_lane2_disparity_error),
        .rx_lnk_rx_lane3_k_char          (lnk_rx_lane3_k_char),
        .rx_lnk_rx_lane3_data            (lnk_rx_lane3_data),
        .rx_lnk_rx_lane3_symbol_error    (lnk_rx_lane3_symbol_error),
        .rx_lnk_rx_lane3_disparity_error (lnk_rx_lane3_disparity_error),
        .rx_lnk_rx_gt_buf_rst            (lnk_rx_gt_buf_rst),
        .rx_dpcd_write_synchronize       (),
        .rx_cfg_rx_dpcd_regs             (cfg_rx_dpcd_regs),
        .rx_cfg_rx_phy_config            (cfg_rx_phy_config),
        .rx_cfg_rx_phy_status            (cfg_rx_phy_status),
        .rx_cfg_rx_vidmode_regs          (cfg_rx_vidmode_regs),
        .rx_cfg_rx_vidmode_regs_stream2  (cfg_rx_vidmode_regs_stream2),
        .rx_cfg_rx_vidmode_regs_stream3  (cfg_rx_vidmode_regs_stream3),
        .rx_cfg_rx_vidmode_regs_stream4  (cfg_rx_vidmode_regs_stream4),
        .rx_aux_data_in                  (rx_aux_data_in),
        .rx_aux_data_out                 (rx_aux_data_out),
        .rx_aux_data_enable_n            (rx_aux_data_enable_n),
        .rx_i2c_sda_in                   (i2c_sda_in),
        .rx_i2c_sda_enable_n             (i2c_sda_enable_n),
        .rx_i2c_scl_in                   (i2c_scl_in),
        .rx_i2c_scl_enable_n             (i2c_scl_enable_n),
        .rx_hot_plug_detect              (rx_hot_plug_detect),
        .access_link_bw_set              (access_link_bw_set),
        .access_train_lane_set           (access_train_lane_set),

        .rx_aud_rst                      (aud_rst),
        .rx_m_axis_audio_egress_aclk     (aud_axis_aclk),
        .rx_m_axis_audio_egress_tdata    (m_axis_audio_egress_tdata),
        .rx_m_axis_audio_egress_tid      (m_axis_audio_egress_tid),
        .rx_m_axis_audio_egress_tvalid   (m_axis_audio_egress_tvalid),
        .rx_m_axis_audio_egress_tready   (m_axis_audio_egress_tready),

        .rx_m_axis_audio_egress_aclk_stream2     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream2    (),
        .rx_m_axis_audio_egress_tid_stream2      (),
        .rx_m_axis_audio_egress_tvalid_stream2   (),
        .rx_m_axis_audio_egress_tready_stream2   (1'b0),

        .rx_m_axis_audio_egress_aclk_stream3     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream3    (),
        .rx_m_axis_audio_egress_tid_stream3      (),
        .rx_m_axis_audio_egress_tvalid_stream3   (),
        .rx_m_axis_audio_egress_tready_stream3   (1'b0),

        .rx_m_axis_audio_egress_aclk_stream4     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream4    (),
        .rx_m_axis_audio_egress_tid_stream4      (),
        .rx_m_axis_audio_egress_tvalid_stream4   (),
        .rx_m_axis_audio_egress_tready_stream4   (1'b0),

        .debug_sec_port                          (),
        .acr_m_aud                               (acr_m_aud),
        .acr_n_aud                               (acr_n_aud),
        .acr_valid                               (acr_valid)        
    );
    assign rx_aux_data_in = aux_rx_data_in;
    assign aux_rx_data_out = rx_aux_data_out;
    assign aux_rx_data_en_out_n = rx_aux_data_enable_n;

end
endgenerate

generate if (( C_FLOW_DIRECTION == 0 ) && (C_PHY_TYPE_EXTERNAL == 0 ))
begin
    //----------------------------------------------
    // PHY component
    //----------------------------------------------
    bd_6311_dp_0_tx_phy
    #(
        .pDEVICE_FAMILY     (C_FAMILY),
        .pTCQ               (100),
        .pLANE_COUNT        (C_LANE_COUNT),
        .pAC_CAP_DISABLE    ("TRUE"),
        .pDATA_WIDTH        (C_DATA_WIDTH),
	.pBUF_BYPASS        (C_BUF_BYPASS)
    ) dport_tx_phy_inst
    (    
        .lnk_clk_ibufds                       (lnk_clk_ibufds),
        .lnk_clk                              (lnk_clk),
        .lnk_tx_lane0_override_disparity      (lnk_tx_lane0_override_disparity),
        .lnk_tx_lane0_k_char                  (lnk_tx_lane0_k_char),
        .lnk_tx_lane0_data                    (lnk_tx_lane0_data),              
        .lnk_tx_lane1_override_disparity      (lnk_tx_lane1_override_disparity),
        .lnk_tx_lane1_k_char                  (lnk_tx_lane1_k_char),            
        .lnk_tx_lane1_data                    (lnk_tx_lane1_data),              
        .lnk_tx_lane2_override_disparity      (lnk_tx_lane2_override_disparity),
        .lnk_tx_lane2_k_char                  (lnk_tx_lane2_k_char),            
        .lnk_tx_lane2_data                    (lnk_tx_lane2_data),              
        .lnk_tx_lane3_override_disparity      (lnk_tx_lane3_override_disparity),
        .lnk_tx_lane3_k_char                  (lnk_tx_lane3_k_char),            
        .lnk_tx_lane3_data                    (lnk_tx_lane3_data),
        .lnk_tx_lane_p                        (lnk_tx_lane_p),
        .lnk_tx_lane_n                        (lnk_tx_lane_n),
        .cfg_tx_phy_config                    (cfg_tx_phy_config),
        .cfg_tx_phy_status                    (cfg_tx_phy_status),
        .apb_clk                              (s_axi_aclk),
        .apb_reset                            (axi_reset),

        .aux_data_out                         (tx_aux_data_out),
        .aux_data_in                          (tx_aux_data_in),
        .aux_data_enable_n                    (tx_aux_data_enable_n),
        .hpd                                  (tx_hpd),
        .hot_plug_detect                      (tx_hot_plug_detect),
        .link_bw_high_out                     (link_bw_high_out),
        .link_bw_hbr2_out                     (link_bw_hbr2_out),
        .bw_changed_out                       (bw_changed_out),
        .phy_pll_reset_out                    (phy_pll_reset_out),


        .gt0_qpllclk_in                       (common_qpll_clk),
        .gt0_qpllclk_lock                     (common_qpll_lock),
        .gt0_qpllrefclk_in                    (common_qpll_ref_clk)
    );
end
endgenerate

generate if (( C_FLOW_DIRECTION == 1 ) && (C_PHY_TYPE_EXTERNAL == 0 ) )
begin 
    assign lnk_tx_lane_p = 'h0;
    assign lnk_tx_lane_n = 'h0;
    //----------------------------------------------
    // DisplayPort PHY
    //----------------------------------------------
    bd_6311_dp_0_rx_phy
    #(
        .pDEVICE_FAMILY     (C_FAMILY),
        .pTCQ               (100),
        .pLANE_COUNT        (C_LANE_COUNT),
        .pAC_CAP_DISABLE    ("TRUE"),
        .pDATA_WIDTH        (C_DATA_WIDTH)
    ) dport_rx_phy_inst
    (    
        // main link transceiver interface
        .lnk_clk_ibufds                 (lnk_clk_ibufds),
        .lnk_fwdclk_ibufds              (lnk_fwdclk_ibufds),
        .lnk_clk                        (lnk_clk),
        .lnk_rx_lane0_kchar             (lnk_rx_lane0_k_char),          
        .lnk_rx_lane0_data              (lnk_rx_lane0_data),            
        .lnk_rx_lane0_symbol_error      (lnk_rx_lane0_symbol_error),    
        .lnk_rx_lane0_disparity_error   (lnk_rx_lane0_disparity_error), 
        .lnk_rx_lane1_kchar             (lnk_rx_lane1_k_char),          
        .lnk_rx_lane1_data              (lnk_rx_lane1_data),            
        .lnk_rx_lane1_symbol_error      (lnk_rx_lane1_symbol_error),    
        .lnk_rx_lane1_disparity_error   (lnk_rx_lane1_disparity_error), 
        .lnk_rx_lane2_kchar             (lnk_rx_lane2_k_char),          
        .lnk_rx_lane2_data              (lnk_rx_lane2_data),            
        .lnk_rx_lane2_symbol_error      (lnk_rx_lane2_symbol_error),    
        .lnk_rx_lane2_disparity_error   (lnk_rx_lane2_disparity_error), 
        .lnk_rx_lane3_kchar             (lnk_rx_lane3_k_char),          
        .lnk_rx_lane3_data              (lnk_rx_lane3_data),            
        .lnk_rx_lane3_symbol_error      (lnk_rx_lane3_symbol_error),    
        .lnk_rx_lane3_disparity_error   (lnk_rx_lane3_disparity_error), 
        .lnk_rx_gt_buf_rst              (lnk_rx_gt_buf_rst), 
        .lnk_rx_lane_p                  (lnk_rx_lane_p),
        .lnk_rx_lane_n                  (lnk_rx_lane_n),
        // control signals
        .access_link_bw_set             (access_link_bw_set),
        .access_train_lane_set          (access_train_lane_set),
        // configuration and status
        .cfg_rx_dpcd_regs               (cfg_rx_dpcd_regs),
        .cfg_rx_phy_config              (cfg_rx_phy_config),
        .cfg_rx_phy_status              (cfg_rx_phy_status),
        .apb_clk                        (s_axi_aclk),
        .apb_reset                      (axi_reset),

        // AUX channel interface
        .aux_data_out                   (rx_aux_data_out),
        .aux_data_in                    (rx_aux_data_in),
        .aux_data_enable_n              (rx_aux_data_enable_n),
       // HPD interface
        .hpd                            (rx_hpd),
        .hot_plug_detect                (rx_hot_plug_detect),
        .link_bw_high_out               (link_bw_high_out),
        .link_bw_hbr2_out               (link_bw_hbr2_out),
        .bw_changed_out                 (bw_changed_out),
        .phy_pll_reset_out              (phy_pll_reset_out),

        .gt0_qpllclk_in                 (common_qpll_clk),
        .gt0_qpllclk_lock               (common_qpll_lock),
        .gt0_qpllrefclk_in              (common_qpll_ref_clk)
    );

end
endgenerate

  assign aux_debug_bus      = 4'h0;
  assign link_debug_gt0     = 69'h0;
  assign link_debug_gt1     = 69'h0;
  assign link_debug_gt2     = 69'h0;
  assign link_debug_gt3     = 69'h0;
  assign link_debug_control = 96'h0;



endmodule
