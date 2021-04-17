

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
`timescale 1ns / 1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
//module displayport 
module bd_6311_dp_0_dport_wrapper
#(
  parameter  C_FAMILY                 = "virtex7",
  parameter  C_DEVICE                 = "xc7vx690",
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
  parameter  C_GT_DATAWIDTH           = 2,
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
   output wire [4-1:0] lnk_tx_lane_p        ,
   output wire [4-1:0] lnk_tx_lane_n        ,
   input  wire                    lnk_clk_p            ,
   input  wire                    lnk_clk_n            ,
   input  wire                    lnk_fwdclk_p         ,
   input  wire                    lnk_fwdclk_n         ,
   output wire                    phy_pll_reset_out    ,
   output wire                    lnk_clk              ,

   output wire                    lnk_clk_ibufds_out     ,
   input  wire                    lnk_fwdclk_ibufds    ,
   output wire                    common_qpll_clk_out    ,
   output wire                    common_qpll_ref_clk_out,
   output wire                    common_qpll_lock_out   , 
   output wire                    pll0_lock_out,
   output wire                    pll1_lock_out,
   output wire                    pll0_clk_out,
   output wire                    pll0_ref_clk_out,
   output wire                    pll1_clk_out,
   output wire                    pll1_ref_clk_out,
   input  wire                    lnk_clk_ibufds       ,

   output wire [68:0]             link_debug_gt0       ,
   output wire [68:0]             link_debug_gt1       ,
   output wire [68:0]             link_debug_gt2       ,
   output wire [68:0]             link_debug_gt3       ,
   output wire [95:0]             link_debug_control   ,
   output wire [3:0]              aux_debug_bus        ,


   // GT Common Ports (QPLL) - For GTX/GTH
   input  wire                    common_qpll_clk      ,
   input  wire                    common_qpll_lock     ,
   input  wire                    common_qpll_ref_clk  ,
   // GT Common Ports (PLL) - For GTP
   input  wire                    pll0_lock            ,
   input  wire                    pll1_lock            ,
   input  wire                    pll0_clk             ,
   input  wire                    pll0_ref_clk         ,
   input  wire                    pll1_clk             ,
   input  wire                    pll1_ref_clk         ,

   input  wire                    tx_lnk_clk                      ,
   output wire [31:0]             lnk_tx_axi4s_lane0_tdata        , // 4 byte interface
   output wire [11:0]             lnk_tx_axi4s_lane0_tuser        , // DISPMODE,DISPVAL,CHARISK - each per byte
   output wire                    lnk_tx_axi4s_lane0_tvalid       , 
   input  wire                    lnk_tx_axi4s_lane0_tready       , 
   //input  wire [8 -1:0]  lnk_tx_sb_status_axi4s_tdata,
   input  wire [31:0]             lnk_tx_sb_status_axi4s_tdata,
   input  wire                         lnk_tx_sb_status_axi4s_tvalid,
   output wire                         lnk_tx_sb_status_axi4s_tready,

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
   inout  wire                    aux_tx_io_p          , // group AUXIO
   inout  wire                    aux_tx_io_n          , // group AUXIO
   output wire                    aux_tx_channel_out_p , // group AUXIO
   output wire                    aux_tx_channel_out_n , // group AUXIO
   input  wire                    aux_tx_channel_in_p  , // group AUXIO
   input  wire                    aux_tx_channel_in_n  , // group AUXIO
   input  wire                    aux_tx_data_in          , // group AUXIO
   output wire                    aux_tx_data_out         , // group AUXIO
   output wire                    aux_tx_data_en_out_n    , // group AUXIO
   input  wire                    tx_hpd               ,

   // new outputs for Tx Subsystem

   output wire [31:0]  tx_gt_ctrl_out,
   output wire [2:0]   tx_bpc,
   output wire [1:0]   tx_video_format,
   output wire [2:0]   tx_ppc,
   input  wire [31:0]             txss_axi_status,
   output wire [31:0]             txss_axi_control,
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

   output wire    [23:0]          lnk_m_vid            ,
   output wire    [23:0]          lnk_n_vid            ,
   input  wire [4-1:0] lnk_rx_lane_p        ,
   input  wire [4-1:0] lnk_rx_lane_n        ,
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


   inout  wire                    aux_rx_io_p          , // group AUXIO
   inout  wire                    aux_rx_io_n          , // group AUXIO
   output wire                    aux_rx_channel_out_p,           // group AUXIO
   output wire                    aux_rx_channel_out_n,           // group AUXIO
   input  wire                    aux_rx_channel_in_p,            // group AUXIO
   input  wire                    aux_rx_channel_in_n,            // group AUXIO
   input  wire                    aux_rx_data_in          , // group AUXIO
   output wire                    aux_rx_data_out         , // group AUXIO
   output wire                    aux_rx_data_en_out_n    , // group AUXIO
   output wire                    rx_hpd               ,
   input  wire                    i2c_sda_in           ,
   output wire                    i2c_sda_enable_n     ,
   output wire                    i2c_sda_o            ,
   input  wire                    i2c_scl_in           ,
   output wire                    i2c_scl_enable_n     ,
   output wire                    i2c_scl_o            ,

   input  wire                    aud_clk              ,
   input  wire                    aud_rst              ,
   input  wire                    s_aud_axis_aclk        ,
   input  wire                    s_aud_axis_aresetn     ,
   input wire [31:0]              s_axis_audio_ingress_tdata,
   input wire [7:0]               s_axis_audio_ingress_tid,
   input wire                     s_axis_audio_ingress_tvalid,
   output wire                    s_axis_audio_ingress_tready,
   input  wire                    m_aud_axis_aclk        ,
   input  wire                    m_aud_axis_aresetn     ,
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
   output wire                    hdcp_egress_clk     ,
   input  wire                    hdcp_ingress_clk    ,
   input  wire                    hdcp_ext_clk        ,
   input  wire                    hdcp_ingress_clken  ,
   output wire                    hdcp_egress_clken   ,
   output wire                    hdcp_rst            ,
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

   output wire [31:0]             rx_gt_ctrl_out       ,
   output wire [2:0]              rx_bpc               ,
   output wire [2:0]              rx_bpc_stream2       ,
   output wire [2:0]              rx_bpc_stream3       ,
   output wire [2:0]              rx_bpc_stream4       ,
   output wire [2:0]              rx_cformat           ,
   output wire [2:0]              rx_cformat_stream2   ,
   output wire [2:0]              rx_cformat_stream3   ,
   output wire [2:0]              rx_cformat_stream4   ,

   // ACR (Audio Clock Regeneration) Interface
   output wire [23:0]             acr_m_aud, 
   output wire [23:0]             acr_n_aud, 
   output wire                    acr_valid

);

  bd_6311_dp_0_core_top #(
     .C_FAMILY                 (  C_FAMILY                ),
     .C_COMPONENT_NAME         (  C_COMPONENT_NAME        ),
     .C_LANE_COUNT             (  C_LANE_COUNT            ),
     .C_FLOW_DIRECTION         (  C_FLOW_DIRECTION        ),
     .C_PHY_TYPE_EXTERNAL      (  C_PHY_TYPE_EXTERNAL     ),
     .C_INCLUDE_HDCP           (  C_INCLUDE_HDCP          ),
     .C_INCLUDE_HDCP22         (  C_INCLUDE_HDCP22        ),
     .C_SECONDARY_SUPPORT      (  C_SECONDARY_SUPPORT     ),
     .C_IEEE_OUI               (  C_IEEE_OUI              ),
     .C_AUDIO_CHANNELS         (  C_AUDIO_CHANNELS        ),
     .C_S_BASEADDR             (  C_S_BASEADDR            ),
     .C_S_HIGHADDR             (  C_S_HIGHADDR            ),
     .C_PROTOCOL_SELECTION     (  C_PROTOCOL_SELECTION    ),
     .C_LINK_RATE              (  C_LINK_RATE             ),
     .C_MST_ENABLE             (  C_MST_ENABLE            ),
     .C_NUMBER_OF_MST_STREAMS  (  C_NUMBER_OF_MST_STREAMS ),
     .C_MAX_BITS_PER_COLOR     (  C_MAX_BITS_PER_COLOR    ),
     .C_QUAD_PIXEL_ENABLE      (  C_QUAD_PIXEL_ENABLE     ),
     .C_DUAL_PIXEL_ENABLE      (  C_DUAL_PIXEL_ENABLE     ),
     .C_YCRCB_ENABLE           (  C_YCRCB_ENABLE          ),
     .C_YONLY_ENABLE           (  C_YONLY_ENABLE          ),
     .C_VENDOR_SPECIFIC        (  C_VENDOR_SPECIFIC       ),
     .C_DATA_WIDTH             (  C_GT_DATAWIDTH          ),
     .C_BUF_BYPASS             (  C_BUF_BYPASS            ),
     .C_EDP_EN                 (  C_EDP_EN                ),
     .C_IS_VERSAL              (  C_IS_VERSAL             ), 
     .C_SIM_MODE               (  C_SIM_MODE              )
  ) core_top_inst
  (
     .s_axi_aclk         ( s_axi_aclk      )   , // group DP_S_AXILITE
     .s_axi_aresetn      ( s_axi_aresetn   )   , // group DP_S_AXILITE
     .s_axi_awaddr       ( s_axi_awaddr    )   , // group DP_S_AXILITE
     .s_axi_awprot       ( s_axi_awprot    )   , // group DP_S_AXILITE
     .s_axi_awvalid      ( s_axi_awvalid   )   , // group DP_S_AXILITE
     .s_axi_awready      ( s_axi_awready   )   , // group DP_S_AXILITE
     .s_axi_wdata        ( s_axi_wdata     )   , // group DP_S_AXILITE
     .s_axi_wstrb        ( s_axi_wstrb     )   , // group DP_S_AXILITE
     .s_axi_wvalid       ( s_axi_wvalid    )   , // group DP_S_AXILITE
     .s_axi_wready       ( s_axi_wready    )   , // group DP_S_AXILITE
     .s_axi_bresp        ( s_axi_bresp     )   , // group DP_S_AXILITE
     .s_axi_bvalid       ( s_axi_bvalid    )   , // group DP_S_AXILITE
     .s_axi_bready       ( s_axi_bready    )   , // group DP_S_AXILITE
     .s_axi_araddr       ( s_axi_araddr    )   , // group DP_S_AXILITE
     .s_axi_arprot       ( s_axi_arprot    )   , // group DP_S_AXILITE
     .s_axi_arvalid      ( s_axi_arvalid   )   , // group DP_S_AXILITE
     .s_axi_arready      ( s_axi_arready   )   , // group DP_S_AXILITE
     .s_axi_rdata        ( s_axi_rdata     )   , // group DP_S_AXILITE
     .s_axi_rresp        ( s_axi_rresp     )   , // group DP_S_AXILITE
     .s_axi_rvalid       ( s_axi_rvalid    )   , // group DP_S_AXILITE
     .s_axi_rready       ( s_axi_rready    )   , // group DP_S_AXILITE
     .axi_int            ( axi_int         )   , // group DP_S_AXILITE
     .tx_vid_clk         ( tx_vid_clk      )   , // group VIDEO_IF
     .tx_vid_rst         ( tx_vid_rst      )   , // group VIDEO_IF
     .tx_vid_vsync       ( tx_vid_vsync    )   , // group VIDEO_IF
     .tx_vid_hsync       ( tx_vid_hsync    )   , // group VIDEO_IF
     .tx_vid_oddeven     ( tx_vid_oddeven  )   , // group VIDEO_IF
     .tx_vid_enable      ( tx_vid_enable   )   , // group VIDEO_IF
     .tx_vid_pixel0      ( tx_vid_pixel0   )   , // group VIDEO_IF
     .tx_vid_pixel1      ( tx_vid_pixel1   )   , // group VIDEO_IF
     .tx_vid_pixel2      ( tx_vid_pixel2   )   , // group VIDEO_IF
     .tx_vid_pixel3      ( tx_vid_pixel3   )   , // group VIDEO_IF
     .tx_vid_clk_stream2        ( tx_vid_clk_stream2       )  , // group VIDEO_IF
     .tx_vid_rst_stream2        ( tx_vid_rst_stream2       )  , // group VIDEO_IF
     .tx_vid_vsync_stream2      ( tx_vid_vsync_stream2     )  , // group VIDEO_IF
     .tx_vid_hsync_stream2      ( tx_vid_hsync_stream2     )  , // group VIDEO_IF
     .tx_vid_oddeven_stream2    ( tx_vid_oddeven_stream2   )  , // group VIDEO_IF
     .tx_vid_enable_stream2     ( tx_vid_enable_stream2    )  , // group VIDEO_IF
     .tx_vid_pixel0_stream2     ( tx_vid_pixel0_stream2    )  , // group VIDEO_IF
     .tx_vid_pixel1_stream2     ( tx_vid_pixel1_stream2    )  , // group VIDEO_IF
     .tx_vid_pixel2_stream2     ( tx_vid_pixel2_stream2    )  , // group VIDEO_IF
     .tx_vid_pixel3_stream2     ( tx_vid_pixel3_stream2    )  , // group VIDEO_IF
     .tx_vid_clk_stream3        ( tx_vid_clk_stream3       )  , // group VIDEO_IF
     .tx_vid_rst_stream3        ( tx_vid_rst_stream3       )  , // group VIDEO_IF
     .tx_vid_vsync_stream3      ( tx_vid_vsync_stream3     )  , // group VIDEO_IF
     .tx_vid_hsync_stream3      ( tx_vid_hsync_stream3     )  , // group VIDEO_IF
     .tx_vid_oddeven_stream3    ( tx_vid_oddeven_stream3   )  , // group VIDEO_IF
     .tx_vid_enable_stream3     ( tx_vid_enable_stream3    )  , // group VIDEO_IF
     .tx_vid_pixel0_stream3     ( tx_vid_pixel0_stream3    )  , // group VIDEO_IF
     .tx_vid_pixel1_stream3     ( tx_vid_pixel1_stream3    )  , // group VIDEO_IF
     .tx_vid_pixel2_stream3     ( tx_vid_pixel2_stream3    )  , // group VIDEO_IF
     .tx_vid_pixel3_stream3     ( tx_vid_pixel3_stream3    )  , // group VIDEO_IF
     .tx_vid_clk_stream4        ( tx_vid_clk_stream4       )  , // group VIDEO_IF
     .tx_vid_rst_stream4        ( tx_vid_rst_stream4       )  , // group VIDEO_IF
     .tx_vid_vsync_stream4      ( tx_vid_vsync_stream4     )  , // group VIDEO_IF
     .tx_vid_hsync_stream4      ( tx_vid_hsync_stream4     )  , // group VIDEO_IF
     .tx_vid_oddeven_stream4    ( tx_vid_oddeven_stream4   )  , // group VIDEO_IF
     .tx_vid_enable_stream4     ( tx_vid_enable_stream4    )  , // group VIDEO_IF
     .tx_vid_pixel0_stream4     ( tx_vid_pixel0_stream4    )  , // group VIDEO_IF
     .tx_vid_pixel1_stream4     ( tx_vid_pixel1_stream4    )  , // group VIDEO_IF
     .tx_vid_pixel2_stream4     ( tx_vid_pixel2_stream4    )  , // group VIDEO_IF
     .tx_vid_pixel3_stream4     ( tx_vid_pixel3_stream4    )  , // group VIDEO_IF
     .tx_lnk_clk               (tx_lnk_clk),              
     .lnk_tx_axi4s_lane0_tdata (lnk_tx_axi4s_lane0_tdata),              
     .lnk_tx_axi4s_lane0_tuser (lnk_tx_axi4s_lane0_tuser),
     .lnk_tx_axi4s_lane0_tvalid(lnk_tx_axi4s_lane0_tvalid),
     .lnk_tx_axi4s_lane0_tready(lnk_tx_axi4s_lane0_tready),
     .lnk_tx_sb_status_axi4s_tdata (lnk_tx_sb_status_axi4s_tdata),              
     .lnk_tx_sb_status_axi4s_tvalid(lnk_tx_sb_status_axi4s_tvalid),              
     .lnk_tx_sb_status_axi4s_tready(lnk_tx_sb_status_axi4s_tready),              
     .lnk_tx_axi4s_lane1_tdata (lnk_tx_axi4s_lane1_tdata),              
     .lnk_tx_axi4s_lane1_tuser (lnk_tx_axi4s_lane1_tuser),
     .lnk_tx_axi4s_lane1_tvalid(lnk_tx_axi4s_lane1_tvalid),
     .lnk_tx_axi4s_lane1_tready(lnk_tx_axi4s_lane1_tready),
     .lnk_tx_axi4s_lane2_tdata (lnk_tx_axi4s_lane2_tdata),              
     .lnk_tx_axi4s_lane2_tuser (lnk_tx_axi4s_lane2_tuser),
     .lnk_tx_axi4s_lane2_tvalid(lnk_tx_axi4s_lane2_tvalid),
     .lnk_tx_axi4s_lane2_tready(lnk_tx_axi4s_lane2_tready),

     .lnk_tx_axi4s_lane3_tdata (lnk_tx_axi4s_lane3_tdata),              
     .lnk_tx_axi4s_lane3_tuser (lnk_tx_axi4s_lane3_tuser),
     .lnk_tx_axi4s_lane3_tvalid(lnk_tx_axi4s_lane3_tvalid),
     .lnk_tx_axi4s_lane3_tready(lnk_tx_axi4s_lane3_tready),
     .aux_tx_data_in            (aux_tx_data_in           ), 
     .aux_tx_data_out           (aux_tx_data_out          ),         
     .aux_tx_data_en_out_n      (aux_tx_data_en_out_n     ),
     .tx_hpd                    ( tx_hpd             ) ,
     .tx_gt_ctrl_out                        (tx_gt_ctrl_out),
     .tx_bpc                    (tx_bpc),
     .tx_video_format           (tx_video_format),
     .tx_ppc                    (tx_ppc),
     .txss_axi_control   (txss_axi_control  ),
     .txss_axi_status    (txss_axi_status   ),
     .tx_video_format_stream2   (tx_video_format_stream2),
     .tx_ppc_stream2            (tx_ppc_stream2),
     .tx_video_format_stream3   (tx_video_format_stream3),
     .tx_ppc_stream3            (tx_ppc_stream3),
     .tx_video_format_stream4   (tx_video_format_stream4),
     .tx_ppc_stream4            (tx_ppc_stream4),
     .rx_vid_clk                ( rx_vid_clk         ) , // group VIDEO_IF
     .rx_vid_rst                ( rx_vid_rst         ) , // group VIDEO_IF
     .rx_vid_pixel_mode         ( rx_vid_pixel_mode  ) ,                   
     .rx_vid_vsync              ( rx_vid_vsync       ) , // group VIDEO_IF
     .rx_vid_hsync              ( rx_vid_hsync       ) , // group VIDEO_IF
     .rx_vid_oddeven            ( rx_vid_oddeven     ) , // group VIDEO_IF
     .rx_vid_enable             ( rx_vid_enable      ) , // group VIDEO_IF
     .rx_vid_pixel0             ( rx_vid_pixel0      ) , // group VIDEO_IF
     .rx_vid_pixel1             ( rx_vid_pixel1      ) , // group VIDEO_IF
     .rx_vid_pixel2             ( rx_vid_pixel2      ) , // group VIDEO_IF
     .rx_vid_pixel3             ( rx_vid_pixel3      ) , // group VIDEO_IF
     .rx_vid_clk_stream2        ( rx_vid_clk_stream2      )  , // group VIDEO_IF
     .rx_vid_rst_stream2        ( rx_vid_rst_stream2      )  , // group VIDEO_IF
     .rx_vid_vsync_stream2      ( rx_vid_vsync_stream2    )  , // group VIDEO_IF
     .rx_vid_hsync_stream2      ( rx_vid_hsync_stream2    )  , // group VIDEO_IF
     .rx_vid_oddeven_stream2    ( rx_vid_oddeven_stream2  )  , // group VIDEO_IF
     .rx_vid_enable_stream2     ( rx_vid_enable_stream2   )  , // group VIDEO_IF
     .rx_vid_pixel0_stream2     ( rx_vid_pixel0_stream2   )  , // group VIDEO_IF
     .rx_vid_pixel1_stream2     ( rx_vid_pixel1_stream2   )  , // group VIDEO_IF
     .rx_vid_pixel2_stream2     ( rx_vid_pixel2_stream2   )  , // group VIDEO_IF
     .rx_vid_pixel3_stream2     ( rx_vid_pixel3_stream2   )  , // group VIDEO_IF
     .rx_vid_clk_stream3        ( rx_vid_clk_stream3      )  , // group VIDEO_IF
     .rx_vid_rst_stream3        ( rx_vid_rst_stream3      )  , // group VIDEO_IF
     .rx_vid_vsync_stream3      ( rx_vid_vsync_stream3    )  , // group VIDEO_IF
     .rx_vid_hsync_stream3      ( rx_vid_hsync_stream3    )  , // group VIDEO_IF
     .rx_vid_oddeven_stream3    ( rx_vid_oddeven_stream3  )  , // group VIDEO_IF
     .rx_vid_enable_stream3     ( rx_vid_enable_stream3   )  , // group VIDEO_IF
     .rx_vid_pixel0_stream3     ( rx_vid_pixel0_stream3   )  , // group VIDEO_IF
     .rx_vid_pixel1_stream3     ( rx_vid_pixel1_stream3   )  , // group VIDEO_IF
     .rx_vid_pixel2_stream3     ( rx_vid_pixel2_stream3   )  , // group VIDEO_IF
     .rx_vid_pixel3_stream3     ( rx_vid_pixel3_stream3   )  , // group VIDEO_IF
     .rx_vid_clk_stream4        ( rx_vid_clk_stream4      )  , // group VIDEO_IF
     .rx_vid_rst_stream4        ( rx_vid_rst_stream4      )  , // group VIDEO_IF
     .rx_vid_vsync_stream4      ( rx_vid_vsync_stream4    )  , // group VIDEO_IF
     .rx_vid_hsync_stream4      ( rx_vid_hsync_stream4    )  , // group VIDEO_IF
     .rx_vid_oddeven_stream4    ( rx_vid_oddeven_stream4  )  , // group VIDEO_IF
     .rx_vid_enable_stream4     ( rx_vid_enable_stream4   )  , // group VIDEO_IF
     .rx_vid_pixel0_stream4     ( rx_vid_pixel0_stream4   )  , // group VIDEO_IF
     .rx_vid_pixel1_stream4     ( rx_vid_pixel1_stream4   )  , // group VIDEO_IF
     .rx_vid_pixel2_stream4     ( rx_vid_pixel2_stream4   )  , // group VIDEO_IF
     .rx_vid_pixel3_stream4     ( rx_vid_pixel3_stream4   )  , // group VIDEO_IF
     .rx_vid_msa_hres           ( rx_vid_msa_hres         ) ,
     .rx_vid_msa_vres           ( rx_vid_msa_vres         ) ,
     .rx_vid_msa_hres_stream2   ( rx_vid_msa_hres_stream2 ) ,
     .rx_vid_msa_vres_stream2   ( rx_vid_msa_vres_stream2 ) ,
     .rx_vid_msa_hres_stream3   ( rx_vid_msa_hres_stream3 ) ,
     .rx_vid_msa_vres_stream3   ( rx_vid_msa_vres_stream3 ) ,
     .rx_vid_msa_hres_stream4   ( rx_vid_msa_hres_stream4 ) ,
     .rx_vid_msa_vres_stream4   ( rx_vid_msa_vres_stream4 ) ,
     .lnk_m_vid                 ( lnk_m_vid               ) ,
     .lnk_n_vid                 ( lnk_n_vid               ) ,
     .aux_rx_data_in            (aux_rx_data_in           ), 
     .aux_rx_data_out           (aux_rx_data_out          ),         
     .aux_rx_data_en_out_n      (aux_rx_data_en_out_n     ),

     .rx_lnk_clk                      (rx_lnk_clk),
     .lnk_rx_axi4s_lane0_tdata        (lnk_rx_axi4s_lane0_tdata), // 4 byte interface
     .lnk_rx_axi4s_lane0_tuser        (lnk_rx_axi4s_lane0_tuser), // SYMBERR,DISPERR,CHARISK - each per byte
     .lnk_rx_axi4s_lane0_tvalid       (lnk_rx_axi4s_lane0_tvalid), 
     .lnk_rx_axi4s_lane0_tready       (lnk_rx_axi4s_lane0_tready),  

     .lnk_rx_sb_control_axi4s_tdata   (lnk_rx_sb_control_axi4s_tdata),
     .lnk_rx_sb_control_axi4s_tvalid  (lnk_rx_sb_control_axi4s_tvalid),
     .lnk_rx_sb_control_axi4s_tready  (lnk_rx_sb_control_axi4s_tready),

     .lnk_rx_sb_status_axi4s_tdata    (lnk_rx_sb_status_axi4s_tdata),
     .lnk_rx_sb_status_axi4s_tvalid   (lnk_rx_sb_status_axi4s_tvalid),
     .lnk_rx_sb_status_axi4s_tready   (lnk_rx_sb_status_axi4s_tready),
     .lnk_rx_axi4s_lane1_tdata        (lnk_rx_axi4s_lane1_tdata),
     .lnk_rx_axi4s_lane1_tuser        (lnk_rx_axi4s_lane1_tuser),
     .lnk_rx_axi4s_lane1_tvalid       (lnk_rx_axi4s_lane1_tvalid), 
     .lnk_rx_axi4s_lane1_tready       (lnk_rx_axi4s_lane1_tready), 
     .lnk_rx_axi4s_lane2_tdata        (lnk_rx_axi4s_lane2_tdata),
     .lnk_rx_axi4s_lane2_tuser        (lnk_rx_axi4s_lane2_tuser),
     .lnk_rx_axi4s_lane2_tvalid       (lnk_rx_axi4s_lane2_tvalid), 
     .lnk_rx_axi4s_lane2_tready       (lnk_rx_axi4s_lane2_tready), 
  
     .lnk_rx_axi4s_lane3_tdata        (lnk_rx_axi4s_lane3_tdata),
     .lnk_rx_axi4s_lane3_tuser        (lnk_rx_axi4s_lane3_tuser),
     .lnk_rx_axi4s_lane3_tvalid       (lnk_rx_axi4s_lane3_tvalid), 
     .lnk_rx_axi4s_lane3_tready       (lnk_rx_axi4s_lane3_tready), 

     .rx_hpd                    ( rx_hpd                  ) ,
     .i2c_sda_in                ( i2c_sda_in              ) ,
     .i2c_sda_enable_n          ( i2c_sda_enable_n        ) ,
     .i2c_scl_in                ( i2c_scl_in              ) ,
     .i2c_scl_enable_n          ( i2c_scl_enable_n        ) ,
     .aud_clk                   ( aud_clk                 ) ,
     .aud_rst                   ( aud_rst                 ) ,
     .aud_axis_aclk               ( m_aud_axis_aclk     ),
     .aud_axis_aresetn            ( m_aud_axis_aresetn  ),
     .s_axis_audio_ingress_tdata  (s_axis_audio_ingress_tdata   ),
     .s_axis_audio_ingress_tid    (s_axis_audio_ingress_tid     ),
     .s_axis_audio_ingress_tvalid (s_axis_audio_ingress_tvalid  ),
     .s_axis_audio_ingress_tready (s_axis_audio_ingress_tready  ),
     .m_axis_audio_egress_tid     (m_axis_audio_egress_tid      ),
     .m_axis_audio_egress_tdata   (m_axis_audio_egress_tdata    ),
     .m_axis_audio_egress_tready  (m_axis_audio_egress_tready   ),
     .m_axis_audio_egress_tvalid  (m_axis_audio_egress_tvalid   ),
     .lnk_m_aud                 ( lnk_m_aud               ) ,
     .lnk_n_aud                 ( lnk_n_aud               ) ,
     .link_bw_high_out          ( link_bw_high_out        ) ,
     .link_bw_hbr2_out          ( link_bw_hbr2_out        ) ,
     .bw_changed_out            ( bw_changed_out          ) ,
     .hdcp_ext_clk              ( hdcp_ext_clk            ),
     .hdcp_ingress_clk          ( hdcp_ingress_clk        ),
     .hdcp_egress_clk           ( hdcp_egress_clk         ),
     .hdcp_ingress_clken        ( hdcp_ingress_clken      ),
     .hdcp_egress_clken         ( hdcp_egress_clken       ),
     .hdcp_rst                  ( hdcp_rst                ),
     .hdcp13_soft_rst           ( hdcp13_soft_rst         ),
     .hdcp22_soft_rst           ( hdcp22_soft_rst         ),
     .hdcp_status               ( hdcp_status             ),
     .hdcp_egress_data          ( hdcp_egress_data        ),
     .hdcp_egress_tuser         ( hdcp_egress_tuser       ),
     .hdcp_egress_tready        ( hdcp_egress_tready      ),
     .hdcp_egress_tvalid        ( hdcp_egress_tvalid      ),
     .hdcp_ingress_data         ( hdcp_ingress_data       ),
     .hdcp_ingress_tuser        ( hdcp_ingress_tuser      ),
     .hdcp_ingress_tready       ( hdcp_ingress_tready     ),
     .hdcp_ingress_tvalid       ( hdcp_ingress_tvalid     ),
     .hdcp_egress_fifo_afull    ( hdcp_egress_fifo_afull  ),
     .rx_gt_ctrl_out            (rx_gt_ctrl_out           ),
     .rx_bpc                    ( rx_bpc                  ),
     .rx_bpc_stream2            ( rx_bpc_stream2          ),
     .rx_bpc_stream3            ( rx_bpc_stream3          ),
     .rx_bpc_stream4            ( rx_bpc_stream4          ),
     .rx_cformat                ( rx_cformat              ),
     .rx_cformat_stream2        ( rx_cformat_stream2      ),
     .rx_cformat_stream3        ( rx_cformat_stream3      ),
     .rx_cformat_stream4        ( rx_cformat_stream4      ),
     .acr_m_aud                 ( acr_m_aud               ),
     .acr_n_aud                 ( acr_n_aud               ),
     .acr_valid                 ( acr_valid               )  

  );

     assign common_qpll_clk_out      = 1'b 0;
     assign common_qpll_ref_clk_out= 1'b 0;
     assign common_qpll_lock_out   = 1'b 0;
     assign pll0_lock_out    = 1'b 0;
     assign pll1_lock_out    = 1'b 0;
     assign pll0_clk_out     = 1'b 0;
     assign pll0_ref_clk_out = 1'b 0;
     assign pll1_clk_out     = 1'b 0;
     assign pll1_ref_clk_out = 1'b 0;
     assign lnk_clk_ibufds_out = 1'b 0;


  assign i2c_scl_o = 1'b0;
  assign i2c_sda_o = 1'b0;


endmodule
