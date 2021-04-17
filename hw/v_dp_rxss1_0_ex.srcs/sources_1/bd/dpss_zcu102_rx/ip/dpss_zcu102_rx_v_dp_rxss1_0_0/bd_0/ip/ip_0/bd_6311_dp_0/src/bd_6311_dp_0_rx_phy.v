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
// includes
//----------------------------------------------
`include "displayport_v8_1_2_rx_defs.v"
`include "displayport_v8_1_2_rx_dpcd_defs.v"

//----------------------------------------------
// module declaration
//----------------------------------------------
module bd_6311_dp_0_rx_phy
#(
    parameter   pDEVICE_FAMILY  = "zynquplus",     // select the device family support
    parameter   pLANE_COUNT     = 4,     // number of lanes implemented
    parameter   pTCQ            = 100,                   // delay for all register assignments
    parameter   pAC_CAP_DISABLE = "TRUE",                // disable the internal AC capacitor
    parameter   pDATA_WIDTH     = 2
)
(
    // main link transceiver interface
    input  wire         lnk_clk_ibufds,                 // clock input from Input Buffer
    input  wire         lnk_fwdclk_ibufds,                 // clock input from Input Buffer
    output wire         lnk_clk,                        // link clock for the FPGA fabric

    output reg  [3:0]   lnk_rx_lane0_kchar,             // receive data is a kchar
    output reg  [31:0]  lnk_rx_lane0_data,              // receiver data, lane 0, 16-bits
    output reg  [3:0]   lnk_rx_lane0_symbol_error,      // symbol error detected
    output reg  [3:0]   lnk_rx_lane0_disparity_error,   // symbol disparity error

    output reg  [3:0]   lnk_rx_lane1_kchar,             // receive data is a kchar
    output reg  [31:0]  lnk_rx_lane1_data,              // receiver data, lane 1, 16-bits
    output reg  [3:0]   lnk_rx_lane1_symbol_error,      // symbol error detected
    output reg  [3:0]   lnk_rx_lane1_disparity_error,   // symbol disparity error

    output reg  [3:0]   lnk_rx_lane2_kchar,             // receive data is a kchar
    output reg  [31:0]  lnk_rx_lane2_data,              // receiver data, lane 2, 16-bits
    output reg  [3:0]   lnk_rx_lane2_symbol_error,      // symbol error detected
    output reg  [3:0]   lnk_rx_lane2_disparity_error,   // symbol disparity error

    output reg  [3:0]   lnk_rx_lane3_kchar,             // receive data is a kchar
    output reg  [31:0]  lnk_rx_lane3_data,              // receiver data, lane 3, 16-bits
    output reg  [3:0]   lnk_rx_lane3_symbol_error,      // symbol error detected
    output reg  [3:0]   lnk_rx_lane3_disparity_error,   // symbol disparity error

    input  wire         lnk_rx_gt_buf_rst,              // rxx elastic buffer reset

    input  wire [pLANE_COUNT-1:0]   lnk_rx_lane_p,      // lane serial data, p
    input  wire [pLANE_COUNT-1:0]   lnk_rx_lane_n,      // lane serial data, n

    // configuration and status
    input  wire `tDPORT_RX_DPCD_REGS  cfg_rx_dpcd_regs, // PHY configuration registers from the DPCD
    input  wire `tDPORT_RX_PHY_CONFIG cfg_rx_phy_config,// PHY configuration from the host
    output wire `tDPORT_RX_PHY_STATUS cfg_rx_phy_status,// PHY status registers

    // host clock for the DRP control
    input  wire         apb_clk,                        // apb host clock
    input  wire         apb_reset,                      // apb host reset

    // AUX channel interface
    input  wire        aux_data_out,                    // manchester encoded serial data out, positive polarity only
    output wire        aux_data_in,                     // manchester encoded serial data in, positive polarity only
    input  wire        aux_data_enable_n,               // data enable of aux serial data

    // bi-directional LVDS - DP IO standard


    // HPD interface
    output wire         hpd,                            // hot plug detect signal
    input  wire         hot_plug_detect,                // HPD signal to link controller
    input wire          access_link_bw_set,
    input wire          access_train_lane_set,

    output wire         link_bw_high_out,
    output wire         link_bw_hbr2_out,
    output wire         bw_changed_out,
    output wire         phy_pll_reset_out,


   // GT Common Ports (QPLL)
    input               gt0_qpllclk_in,
    input               gt0_qpllclk_lock,
    input               gt0_qpllrefclk_in
);

 wire [4:0]   i_lnk_rx_lane_p_w;
 wire [4:0]   i_lnk_rx_lane_n_w;
 //---------------------------------------------
 // internal config signal
 //---------------------------------------------
 wire            en_bwch_reset;
 wire            en_itr_reset;
 wire            en_tp1_reset;
 wire            i_rx_phy_reset;
 wire            i_rx_phy_reset_2;                       // secondary reset (CDR, buffer)
 wire            i_rx_phy_reset_3;                       // ored reset for elastic buffer
 wire            i_rx_phy_reset_auto;                    // automatic reset after link rate change
 reg             i_rx_phy_pcs_reset;                     // automatic pcs reset
 reg  [1:0]      i_training_pattern_q;                   // registered value of the training pattern
 wire            i_training_pattern_1_set;               // check if tp1 is set
 wire            i_phy_reset;                            // combined phy reset
 wire            i_buf_reset;                
 wire            i_pma_reset;                
 wire            i_pcs_reset;                
 wire            i_cdr_hold;                
 wire            i_rxlpmlfhold;             
 wire            i_rxlpmhfhold;             
 wire            i_rxlpmhfoverden;             
 wire            i_prbscntreset;             
 wire            i_eyescanreset;             
 wire            i_eyescantrigger;           
 wire [2:0]      i_loopback;                 
 wire            i_rxpolarity_lane0;               
 wire            i_rxpolarity_lane1;               
 wire            i_rxpolarity_lane2;               
 wire            i_rxpolarity_lane3;               
 wire            i_rxdfelpmreset;   
                           
 wire [3:0]      i_eyescandataerror_out;           
 wire [3:0]      i_comma_det_out;                  
 wire [16:0]     i_dmonitor_out_0;           
 wire [16:0]     i_dmonitor_out_1;           
 wire [16:0]     i_dmonitor_out_2;           
 wire [16:0]     i_dmonitor_out_3;           

 wire [3:0]      i_rx_power_down;                        // power down the PHY
 wire [1:0]      i_elec_idle_reset_tile_0;
 wire [1:0]      i_elec_idle_reset_tile_1;
 reg             i_elec_idle_reset;
 //----------------------------------------------
 // phy status wiring
 //----------------------------------------------
 wire            i_pll_lock_detect_tile_0;
 wire            i_pll_lock_detect_tile_1;
 wire            i_pll_lock_detect_tile_00;
 wire            i_pll_lock_detect_tile_01;
 wire            i_pll_lock_detect_tile_10;
 wire            i_pll_lock_detect_tile_11;
 wire [3:0]      i_rx_pma_reset_done_out;
 wire [1:0]      i_reset_done_tile_0;
 wire [1:0]      i_reset_done_tile_1;
 wire            i_rec_clk_dcm_locked;
 wire            i_prbs_enable_set;
 wire [2:0]      i_prbs_test_enable;
 //----------------------------------------------
 // link testing and status
 //----------------------------------------------
 reg             i_prbs_error_lane0;
 reg             i_prbs_error_lane1;
 reg             i_prbs_error_lane2;
 reg             i_prbs_error_lane3;
 reg             i_rx_low_voltage_lane0;
 reg             i_rx_low_voltage_lane1;
 reg             i_rx_low_voltage_lane2;
 reg             i_rx_low_voltage_lane3;
 reg  [1:0]      i_loss_of_sync_lane0;
 reg  [1:0]      i_loss_of_sync_lane1;
 reg  [1:0]      i_loss_of_sync_lane2;
 reg  [1:0]      i_loss_of_sync_lane3;
 reg             i_lane0_aligned;
 reg             i_lane1_aligned;
 reg             i_lane2_aligned;
 reg             i_lane3_aligned;
 reg             i_lane0_symbol_locked;
 reg             i_lane1_symbol_locked;
 reg             i_lane2_symbol_locked;
 reg             i_lane3_symbol_locked;
 reg  [2:0]      i_rx_buffer_status_lane_0;
 reg  [2:0]      i_rx_buffer_status_lane_1;
 reg  [2:0]      i_rx_buffer_status_lane_2;
 reg  [2:0]      i_rx_buffer_status_lane_3;
 reg is_dfe_lpm_reset_condition;
 //----------------------------------------------
 // clocking switching wires - s6 specific
 //----------------------------------------------
 wire            i_clkout0;
 wire            i_clkout0_buf;
 wire            i_clkout2_buf;
 //----------------------------------------------
 // comma align enables
 //----------------------------------------------
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0]       i_sync_training_pattern_1;
 reg             i_comma_align_enable;
 wire vio_comma_enable_always;
 assign vio_comma_enable_always = 1'b1;
 reg             i_comma_align_enable0;
 reg             i_comma_align_enable1;
 reg             i_comma_align_enable2;
 reg             i_comma_align_enable3;
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0]       i_sync_training_pattern_2;              // registered value of the training pattern
 wire            i_training_pattern_2_set;               // check if tp2 is set
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0]       i_sync_training_pattern_3;              // registered value of the training pattern
 wire            i_training_pattern_3_set;               // check if tp2 is set
 //----------------------------------------------
 // drp state machine registers
 //----------------------------------------------
  wire [15:0]  gt_pcsrsvdin_in;

 reg [23:0] drp_7series_cmd;
 reg [3:0]  drp_7series_cmd_id;
 reg [23:0] drp_usseries_cmd;
 reg [3:0]  drp_usseries_cmd_id;
 reg [6:0]      i_drp_state;
 reg  [7:0]      i_detect_rx_clock_update;
 reg             i_detect_lpm_dfe_update;
 reg             i_drp_enable=1'b0;
 reg             i_drp_write=1'b0;
 reg             i_drp_locked=1'b0;
 wire            i_drp_busy;
 wire [15:0]     i_drp_read_data;
 reg  [15:0]     i_drp_write_data;
 reg  [7:0]      i_drp_addr;
 wire [1:0]      i_drp_ready;
 wire            i_drp_ready00, i_drp_ready01;
 wire            i_drp_ready10, i_drp_ready11;
 reg  [7:0]      i_auto_reset;
 reg  [7:0]      i_auto_reset_gtrxreset;
 reg  [7:0]      i_auto_reset_lpm_dfe_update;
 wire            bw_changed;
 reg             bw_changed_latch;
 wire            lpm_dfe_mode_changed;
 wire            link_bw_high;
 wire            link_bw_rbr;
 wire   link_bw_hbr2; 
 wire [3:0] lane_count;
 wire lpm_dfe_hbr2_update;
 wire [1:0] i_tx_sys_clk_sel_in;
 wire [1:0] i_rx_sys_clk_sel_in;
 wire cpll_locked = i_pll_lock_detect_tile_00 & i_pll_lock_detect_tile_01 &
                                              i_pll_lock_detect_tile_10 & i_pll_lock_detect_tile_11;
 
 //----------------------------------------------
 // v6 gtx test registers
 //----------------------------------------------
 //----------------------------------------------
 // wiring from GT to follower flops
 //----------------------------------------------

 wire  [3:0]   i_lnk_rx_lane0_kchar_d;
 wire  [31:0]  i_lnk_rx_lane0_data_d;
 wire  [3:0]   i_lnk_rx_lane0_symbol_error_d;
 wire  [3:0]   i_lnk_rx_lane0_disparity_error_d;
 wire  [3:0]   i_lnk_rx_lane1_kchar_d;
 wire  [31:0]  i_lnk_rx_lane1_data_d;
 wire  [3:0]   i_lnk_rx_lane1_symbol_error_d;
 wire  [3:0]   i_lnk_rx_lane1_disparity_error_d;
 wire  [3:0]   i_lnk_rx_lane2_kchar_d;
 wire  [31:0]  i_lnk_rx_lane2_data_d;
 wire  [3:0]   i_lnk_rx_lane2_symbol_error_d;
 wire  [3:0]   i_lnk_rx_lane2_disparity_error_d;
 wire  [3:0]   i_lnk_rx_lane3_kchar_d;
 wire  [31:0]  i_lnk_rx_lane3_data_d;
 wire  [3:0]   i_lnk_rx_lane3_symbol_error_d;
 wire  [3:0]   i_lnk_rx_lane3_disparity_error_d;


 wire          i_rx_low_voltage_lane0_d;
 wire          i_rx_low_voltage_lane1_d;
 wire          i_rx_low_voltage_lane2_d;
 wire          i_rx_low_voltage_lane3_d;
 wire [1:0]    i_loss_of_sync_lane0_d;
 wire [1:0]    i_loss_of_sync_lane1_d;
 wire [1:0]    i_loss_of_sync_lane2_d;
 wire [1:0]    i_loss_of_sync_lane3_d;
 wire          i_lane0_aligned_d;
 wire          i_lane1_aligned_d;
 wire          i_lane2_aligned_d;
 wire          i_lane3_aligned_d;
 wire          i_lane0_symbol_locked_d;
 wire          i_lane1_symbol_locked_d;
 wire          i_lane2_symbol_locked_d;
 wire          i_lane3_symbol_locked_d;
 wire [2:0]    i_rx_buffer_status_lane_0_d;
 wire [2:0]    i_rx_buffer_status_lane_1_d;
 wire [2:0]    i_rx_buffer_status_lane_2_d;
 wire [2:0]    i_rx_buffer_status_lane_3_d;
 wire          i_prbs_error_lane0_d;
 wire          i_prbs_error_lane1_d;
 wire          i_prbs_error_lane2_d;
 wire          i_prbs_error_lane3_d;
 wire          i_rx_user_ready;
 wire          locked_o;
 //--------------------------------------------------------------------------------
 // LPM enable signals to be high when link rate is 5.4.
 //--------------------------------------------------------------------------------

 wire GT0_RXLPMEN_IN;
 wire GT1_RXLPMEN_IN;
 wire GT2_RXLPMEN_IN;
 wire GT3_RXLPMEN_IN;

 reg GT0_RXLPMEN_IN_reg;
 reg GT1_RXLPMEN_IN_reg;
 reg GT2_RXLPMEN_IN_reg;
 reg GT3_RXLPMEN_IN_reg;

 //----------------------------------------------
 // DRP state machine state parameters
 //----------------------------------------------
 localparam      pDS_IDLE            = 7'h 01;
 localparam      pDS_WAIT_READ       = 7'h 02;
 localparam      pDS_WAIT_WRITE      = 7'h 04;
 localparam      pDS_DELAY_STATE_1Q  = 7'h 08;
 localparam      pDS_DELAY_STATE_2Q  = 7'h 10;
 localparam      pDS_HOST_ACCESS     = 7'h 20;
 localparam      pDS_HOST_ACCESS_WAIT= 7'h 40;
 //----------------------------------------------------------
 // handle verilog parameterized lane count by using internal
 // wire which is 5 bits wide i.e. to avoid 0 concat.
 //----------------------------------------------------------
 localparam LANE_COUNT_DIFF = 5 - pLANE_COUNT;

 assign  i_lnk_rx_lane_p_w[4:0] = { { LANE_COUNT_DIFF { 1'b 0 } }, lnk_rx_lane_p[pLANE_COUNT-1:0] }; 
 assign  i_lnk_rx_lane_n_w[4:0] = { { LANE_COUNT_DIFF { 1'b 0 } }, lnk_rx_lane_n[pLANE_COUNT-1:0] }; 

 //----------------------------------------------------------
 //  VIO control
 //----------------------------------------------------------
// wire [15:0] probe_in0;
// wire [71:0] probe_out0;
// wire [71:0] probe_out1;
// wire [71:0] probe_out2;
// wire [15:0] probe_out3;
//
// vio_0 dp_phy_vio_inst (
//  .clk(apb_clk),          
//  .probe_in0(probe_in0),  
//  .probe_out0(probe_out0),
//  .probe_out1(probe_out1),
//  .probe_out2(probe_out2),
//  .probe_out3(probe_out3) 
// );

wire train_lane_set_accessed = access_train_lane_set;
wire reset_on_train_lane_set = ( en_itr_reset == 1'b1 ) ? train_lane_set_accessed : 1'b0;

 //----------------------------------------------------------
 // Syncronizer for training pattern1 from DPCD to lnk domain
 //----------------------------------------------------------
 always @ (posedge lnk_clk)
 begin
    i_sync_training_pattern_1    <= #pTCQ { i_sync_training_pattern_1[0], i_training_pattern_1_set };
    i_sync_training_pattern_2    <= #pTCQ { i_sync_training_pattern_2[0], i_training_pattern_2_set };
    i_sync_training_pattern_3    <= #pTCQ { i_sync_training_pattern_3[0], i_training_pattern_3_set };

 end

 //----------------------------------------------
 // Register the RX lane data from the PHY for timing
 //----------------------------------------------
wire i_reset_done_lane0_active = i_reset_done_tile_0[0];
wire i_reset_done_lane1_active = (lane_count>'h1)?(i_reset_done_tile_0[1]):1'b1;
wire i_reset_done_lane2_active = (lane_count=='h4)?(i_reset_done_tile_1[0]):1'b1;
wire i_reset_done_lane3_active = (lane_count=='h4)?(i_reset_done_tile_1[1]):1'b1;
wire i_reset_done_inactive = ~(i_reset_done_lane0_active&i_reset_done_lane1_active&i_reset_done_lane2_active&i_reset_done_lane3_active);

wire i_rx_buffer_status_lane_0_active = (i_rx_buffer_status_lane_0[2] && (~i_reset_done_inactive));
wire i_rx_buffer_status_lane_1_active = (i_rx_buffer_status_lane_1[2] && lane_count>'h1) && (~i_reset_done_inactive);
wire i_rx_buffer_status_lane_2_active = (i_rx_buffer_status_lane_2[2] && lane_count=='h4) && (~i_reset_done_inactive);
wire i_rx_buffer_status_lane_3_active = (i_rx_buffer_status_lane_3[2] && lane_count=='h4) && (~i_reset_done_inactive);
reg [17:0] init_wait_rx_bufstatus;
wire       init_wait_done;
reg [1:0]  i_sync_init_wait_done;

wire [17:0] init_wait_clk_cycles = 18'h1;

always@(posedge apb_clk) begin
    if(i_phy_reset | i_reset_done_inactive) begin
      init_wait_rx_bufstatus <= 10'b0;
    end else begin
      if (init_wait_rx_bufstatus != init_wait_clk_cycles) 
         init_wait_rx_bufstatus <= init_wait_rx_bufstatus + 1'b1;
    end
end

assign init_wait_done = (init_wait_rx_bufstatus == init_wait_clk_cycles) ? 1'b1 : 1'b0;

always @ (posedge lnk_clk)
   i_sync_init_wait_done     <= #pTCQ { i_sync_init_wait_done[0], init_wait_done };

reg lane_buffers_in_error_state_toggle = 1'b0;
(* async_reg = "true" *) reg [3:0] lane_buffers_in_error_state_toggle_q;
wire gen_rst_due_to_buffer_error = (lane_buffers_in_error_state_toggle_q[3] != lane_buffers_in_error_state_toggle_q[2]);

  // Auto reset generated when Buffer is having overflows/underflows
  always@(posedge apb_clk) begin
    if(i_phy_reset | i_reset_done_inactive) begin
      lane_buffers_in_error_state_toggle_q <= 4'b0000;
    end else begin
      lane_buffers_in_error_state_toggle_q <= {lane_buffers_in_error_state_toggle_q[2:0], lane_buffers_in_error_state_toggle};
    end
  end

 always @ (posedge lnk_clk)
 begin
   if(i_sync_init_wait_done[1]!=1'b1) begin
     lane_buffers_in_error_state_toggle <= #pTCQ 1'b0;
   end else if((i_rx_buffer_status_lane_0_active | i_rx_buffer_status_lane_1_active | i_rx_buffer_status_lane_2_active | i_rx_buffer_status_lane_3_active)) begin
     lane_buffers_in_error_state_toggle <= #pTCQ 1'b1;
   end
 end

 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] i_rx_low_voltage_lane0_d_sync;
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] i_rx_low_voltage_lane1_d_sync;
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] i_rx_low_voltage_lane2_d_sync;
 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] i_rx_low_voltage_lane3_d_sync;
 always @ (posedge apb_clk)
 begin
    i_rx_low_voltage_lane0_d_sync <= #pTCQ {i_rx_low_voltage_lane0_d_sync[0], i_rx_low_voltage_lane0_d};
    i_rx_low_voltage_lane1_d_sync <= #pTCQ {i_rx_low_voltage_lane1_d_sync[0], i_rx_low_voltage_lane1_d};
    i_rx_low_voltage_lane2_d_sync <= #pTCQ {i_rx_low_voltage_lane2_d_sync[0], i_rx_low_voltage_lane2_d};
    i_rx_low_voltage_lane3_d_sync <= #pTCQ {i_rx_low_voltage_lane3_d_sync[0], i_rx_low_voltage_lane3_d};

    i_rx_low_voltage_lane0        <= #pTCQ  i_rx_low_voltage_lane0_d_sync[1];
    i_rx_low_voltage_lane1        <= #pTCQ  i_rx_low_voltage_lane1_d_sync[1];
    i_rx_low_voltage_lane2        <= #pTCQ  i_rx_low_voltage_lane2_d_sync[1];
    i_rx_low_voltage_lane3        <= #pTCQ  i_rx_low_voltage_lane3_d_sync[1];
 end

 always @ (posedge lnk_clk)
 begin
    // main link output flops

    lnk_rx_lane0_kchar            <= #pTCQ  i_lnk_rx_lane0_kchar_d;
    lnk_rx_lane0_data             <= #pTCQ  i_lnk_rx_lane0_data_d;
    lnk_rx_lane0_symbol_error     <= #pTCQ  i_lnk_rx_lane0_symbol_error_d;
    lnk_rx_lane0_disparity_error  <= #pTCQ  i_lnk_rx_lane0_disparity_error_d;
    lnk_rx_lane1_kchar            <= #pTCQ  i_lnk_rx_lane1_kchar_d;
    lnk_rx_lane1_data             <= #pTCQ  i_lnk_rx_lane1_data_d;
    lnk_rx_lane1_symbol_error     <= #pTCQ  i_lnk_rx_lane1_symbol_error_d;
    lnk_rx_lane1_disparity_error  <= #pTCQ  i_lnk_rx_lane1_disparity_error_d;
    lnk_rx_lane2_kchar            <= #pTCQ  i_lnk_rx_lane2_kchar_d;
    lnk_rx_lane2_data             <= #pTCQ  i_lnk_rx_lane2_data_d;
    lnk_rx_lane2_symbol_error     <= #pTCQ  i_lnk_rx_lane2_symbol_error_d;
    lnk_rx_lane2_disparity_error  <= #pTCQ  i_lnk_rx_lane2_disparity_error_d;
    lnk_rx_lane3_kchar            <= #pTCQ  i_lnk_rx_lane3_kchar_d;
    lnk_rx_lane3_data             <= #pTCQ  i_lnk_rx_lane3_data_d;
    lnk_rx_lane3_symbol_error     <= #pTCQ  i_lnk_rx_lane3_symbol_error_d;
    lnk_rx_lane3_disparity_error  <= #pTCQ  i_lnk_rx_lane3_disparity_error_d;

    // status follower flops
    i_loss_of_sync_lane0          <= #pTCQ  i_loss_of_sync_lane0_d;
    i_loss_of_sync_lane1          <= #pTCQ  i_loss_of_sync_lane1_d;
    i_loss_of_sync_lane2          <= #pTCQ  i_loss_of_sync_lane2_d;
    i_loss_of_sync_lane3          <= #pTCQ  i_loss_of_sync_lane3_d;
    i_lane0_aligned               <= #pTCQ  i_lane0_aligned_d;
    i_lane1_aligned               <= #pTCQ  i_lane1_aligned_d;
    i_lane2_aligned               <= #pTCQ  i_lane2_aligned_d;
    i_lane3_aligned               <= #pTCQ  i_lane3_aligned_d;
    i_lane0_symbol_locked         <= #pTCQ  i_lane0_symbol_locked_d;
    i_lane1_symbol_locked         <= #pTCQ  i_lane1_symbol_locked_d;
    i_lane2_symbol_locked         <= #pTCQ  i_lane2_symbol_locked_d;
    i_lane3_symbol_locked         <= #pTCQ  i_lane3_symbol_locked_d;
    i_rx_buffer_status_lane_0     <= #pTCQ  i_rx_buffer_status_lane_0_d;
    i_rx_buffer_status_lane_1     <= #pTCQ  i_rx_buffer_status_lane_1_d;
    i_rx_buffer_status_lane_2     <= #pTCQ  i_rx_buffer_status_lane_2_d;
    i_rx_buffer_status_lane_3     <= #pTCQ  i_rx_buffer_status_lane_3_d;
    i_prbs_error_lane0            <= #pTCQ  i_prbs_error_lane0_d;
    i_prbs_error_lane1            <= #pTCQ  i_prbs_error_lane1_d;
    i_prbs_error_lane2            <= #pTCQ  i_prbs_error_lane2_d;
    i_prbs_error_lane3            <= #pTCQ  i_prbs_error_lane3_d;
    // enable comma align when training pattern 1 is not enabled
    i_comma_align_enable          <= #pTCQ ~i_sync_training_pattern_1[1];
       // enable comma align when training pattern 1 is not enabled
       // tp1 does not have valid commma - hence disabled
       i_comma_align_enable0 <= #pTCQ (vio_comma_enable_always)?i_comma_align_enable:(~i_sync_training_pattern_1[1] && (~i_lane0_symbol_locked || i_sync_training_pattern_2[1] || i_sync_training_pattern_3[1]));
       i_comma_align_enable1 <= #pTCQ (vio_comma_enable_always)?i_comma_align_enable:(~i_sync_training_pattern_1[1] && (~i_lane1_symbol_locked || i_sync_training_pattern_2[1] || i_sync_training_pattern_3[1]));
       i_comma_align_enable2 <= #pTCQ (vio_comma_enable_always)?i_comma_align_enable:(~i_sync_training_pattern_1[1] && (~i_lane2_symbol_locked || i_sync_training_pattern_2[1] || i_sync_training_pattern_3[1]));
       i_comma_align_enable3 <= #pTCQ (vio_comma_enable_always)?i_comma_align_enable:(~i_sync_training_pattern_1[1] && (~i_lane3_symbol_locked || i_sync_training_pattern_2[1] || i_sync_training_pattern_3[1]));
 end
 //----------------------------------------------
 // determine the PHY reset
 //----------------------------------------------
 assign  i_rx_phy_reset                = cfg_rx_phy_config[`kCFG_RX_PHY_RESET];
 assign  i_rx_phy_reset_auto           = i_auto_reset[7];
 assign  i_rx_power_down               = cfg_rx_phy_config[`kCFG_RX_PHY_POWER_DOWN];
 assign  i_phy_reset                   = i_rx_phy_reset | i_rx_phy_reset_auto ;

 assign  i_buf_reset                   = cfg_rx_phy_config[`kCFG_RX_PHY_BUF_RST] | i_rx_phy_reset_3;
 assign  i_pcs_reset                   = cfg_rx_phy_config[`kCFG_RX_PHY_PCS_RST];
 assign  i_pma_reset                   = cfg_rx_phy_config[`kCFG_RX_PHY_PMA_RST];
 assign  i_cdr_hold                    = cfg_rx_phy_config[`kCFG_RX_PHY_CDRHOLD];
 assign  i_rxlpmlfhold                 = cfg_rx_phy_config[`kCFG_RX_PHY_RXLPMLFHOLD];
 assign  i_rxlpmhfhold                 = cfg_rx_phy_config[`kCFG_RX_PHY_RXLPMHFHOLD];
 assign  i_rxlpmhfoverden              = cfg_rx_phy_config[`kCFG_RX_PHY_RXLPMHFOVERDEN];
 assign  i_prbscntreset                = cfg_rx_phy_config[`kCFG_RX_PHY_PRBSCNTRESET];
 assign  i_eyescanreset                = cfg_rx_phy_config[`kCFG_RX_PHY_EYESCANRESET];
 assign  i_eyescantrigger              = cfg_rx_phy_config[`kCFG_RX_PHY_EYESCANTRIGGER];
 assign  i_loopback                    = cfg_rx_phy_config[`kCFG_RX_PHY_LOOPBACK];
 assign  i_rxpolarity_lane0        = (cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE_CTRL] == 1'b1)?cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE0]:cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY];
 assign  i_rxpolarity_lane1        = (cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE_CTRL] == 1'b1)?cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE1]:cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY]; 
 assign  i_rxpolarity_lane2        = (cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE_CTRL] == 1'b1)?cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE2]:cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY]; 
 assign  i_rxpolarity_lane3        = (cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE_CTRL] == 1'b1)?cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY_LANE3]:cfg_rx_phy_config[`kCFG_RX_PHY_RXPOLARITY]; 

 assign  i_rxdfelpmreset               = cfg_rx_phy_config[`kCFG_RX_PHY_DFE_LPM_RST];
 assign  en_bwch_reset                 = cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_BWCH_RESET];
 assign  en_itr_reset                  = cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_ITR_RESET];
 assign  en_tp1_reset                  = cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_TP1_RESET]; 

 assign gt_pcsrsvdin_in  =  cfg_rx_phy_config[`kCFG_RX_PHY_PCSRSVDIN]; 
 // GTX 010
 // GTH 100 On board NORTHREFCLKS are connected to FPGA  
 // US-GTH SW 010 for 2.7/5.4 and 001 for 1.62
 //wire [2:0] gt_refclk_sel =  cfg_rx_phy_config[`kCFG_RX_PHY_REFCLKSEL]; // 010 for refclk1 on reset

 (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] i_eyescantrigger_sync;
  always@(posedge lnk_clk) begin
      i_eyescantrigger_sync <= #pTCQ {i_eyescantrigger_sync[0], i_eyescantrigger};
  end

// assign i_rx_sys_clk_sel_in = (link_bw_hbr2==1)?2'b01:2'b00;
// assign i_tx_sys_clk_sel_in = (link_bw_hbr2==1)?2'b01:2'b00;
 assign i_rx_sys_clk_sel_in = 2'b00;
 assign i_tx_sys_clk_sel_in = 2'b00;
 //----------------------------------------------
 // electrically idle reset
 //----------------------------------------------
 assign  i_elec_idle_reset_tile_0[0]   = ( cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_ELEC_IDLE] & i_rx_low_voltage_lane0_d );
 assign  i_elec_idle_reset_tile_0[1]   = ( cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_ELEC_IDLE] & i_rx_low_voltage_lane1_d );
 assign  i_elec_idle_reset_tile_1[0]   = ( cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_ELEC_IDLE] & i_rx_low_voltage_lane2_d );
 assign  i_elec_idle_reset_tile_1[1]   = ( cfg_rx_phy_config[`kCFG_RX_PHY_ENABLE_ELEC_IDLE] & i_rx_low_voltage_lane3_d );
 //----------------------------------------------
 // use lane0 electrial idle - master lane
 // if required, create independent bits per lane
 // register the reset signal in apb_clk as apb_clk
 // will always be running and clean reset timing
 //----------------------------------------------
 always @ (posedge apb_clk)
 begin
    if (apb_reset == 1'b1)
    begin
       i_elec_idle_reset   <= 1'b 1;
    end
    else
    begin
       i_elec_idle_reset   <= ( i_phy_reset | i_elec_idle_reset_tile_0[0] );
    end
 end
 //----------------------------------------------
 // prbs test enables
 //----------------------------------------------
 assign  i_prbs_enable_set             = ( cfg_rx_dpcd_regs[`kDPCD_LINK_QUAL_PATTERN_SET] == 2'b11 ) ||
                                         ( cfg_rx_dpcd_regs[`kDPCD_LINK_QUAL_LANE0_SET] == 3'b011);
 assign  i_prbs_test_enable            = { 2'b 00, i_prbs_enable_set };
 assign  i_training_pattern_1_set      = ( cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET]  == 2'b01 );
 assign  i_training_pattern_2_set = ( cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET] == 2'b10 );
 assign  i_training_pattern_3_set = ( cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET] == 2'b11 );

 reg [2:0] i_tp1_start_detect_sync;
 reg [2:0] i_tp2_start_detect_sync;
 reg [2:0] i_tp3_start_detect_sync;
 wire i_tp1_started;
 wire i_tp2_started;
 wire i_tp3_started;
 wire i_tp2_ended;
 wire i_tp3_ended;

 always@(posedge apb_clk) begin
   if(apb_reset) begin
     i_tp1_start_detect_sync <= 'h0;
     i_tp2_start_detect_sync <= 'h0;
     i_tp3_start_detect_sync <= 'h0;
   end else begin
     i_tp1_start_detect_sync <={i_tp1_start_detect_sync[1:0], i_training_pattern_1_set};
     i_tp2_start_detect_sync <={i_tp2_start_detect_sync[1:0], i_training_pattern_2_set};
     i_tp3_start_detect_sync <={i_tp3_start_detect_sync[1:0], i_training_pattern_3_set};
   end
 end

 assign i_tp1_started = (i_tp1_start_detect_sync[2]==1'b0 && i_tp1_start_detect_sync[1]==1'b1);
 assign i_tp2_started = (i_tp2_start_detect_sync[2]==1'b0 && i_tp2_start_detect_sync[1]==1'b1);
 assign i_tp3_started = (i_tp3_start_detect_sync[2]==1'b0 && i_tp3_start_detect_sync[1]==1'b1);


 assign i_tp2_ended   = (i_tp2_start_detect_sync[2]==1'b1 && i_tp2_start_detect_sync[1]==1'b0);
 assign i_tp3_ended   = (i_tp3_start_detect_sync[2]==1'b1 && i_tp3_start_detect_sync[1]==1'b0);

  wire i_tp2_or_tp3_fe;

  assign i_tp2_or_tp3_fe = 1'b0; //Not needed for asserting DFE HOLD as per GT recommendation

 //----------------------------------------------
 // PHY status output register
 //----------------------------------------------
 assign  cfg_rx_phy_status[1:0]                              = i_reset_done_tile_0;
 assign  cfg_rx_phy_status[3:2]                              = i_reset_done_tile_1;
 assign  cfg_rx_phy_status[4]                                = i_pll_lock_detect_tile_0;
 assign  cfg_rx_phy_status[5]                                = i_pll_lock_detect_tile_1;
 assign  cfg_rx_phy_status[6]                                = 1'b1;
 assign  cfg_rx_phy_status[7]                                = i_rec_clk_dcm_locked;
 assign  cfg_rx_phy_status[8]                                = i_prbs_error_lane0;
 assign  cfg_rx_phy_status[9]                                = i_prbs_error_lane1;
 assign  cfg_rx_phy_status[10]                               = i_prbs_error_lane2;
 assign  cfg_rx_phy_status[11]                               = i_prbs_error_lane3;
 assign  cfg_rx_phy_status[12]                               = i_rx_low_voltage_lane0;
 assign  cfg_rx_phy_status[13]                               = i_rx_low_voltage_lane1;
 assign  cfg_rx_phy_status[14]                               = i_rx_low_voltage_lane2;
 assign  cfg_rx_phy_status[15]                               = i_rx_low_voltage_lane3;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE0_ALIGNED]       = i_lane0_aligned;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE1_ALIGNED]       = i_lane1_aligned;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE2_ALIGNED]       = i_lane2_aligned;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE3_ALIGNED]       = i_lane3_aligned;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE0_SYMBOL_LOCKED] = i_lane0_symbol_locked;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE1_SYMBOL_LOCKED] = i_lane1_symbol_locked;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE2_SYMBOL_LOCKED] = i_lane2_symbol_locked;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_LANE3_SYMBOL_LOCKED] = i_lane3_symbol_locked;
 assign  cfg_rx_phy_status[25:24]                            = i_rx_buffer_status_lane_0[2:1];
 assign  cfg_rx_phy_status[27:26]                            = i_rx_buffer_status_lane_1[2:1];
 assign  cfg_rx_phy_status[29:28]                            = i_rx_buffer_status_lane_2[2:1];
 assign  cfg_rx_phy_status[31:30]                            = i_rx_buffer_status_lane_3[2:1];
 assign  cfg_rx_phy_status[39:32]                            = 8'b 0;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_STATUS_DRP_LOCKED]   = i_drp_locked;
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_STATUS_DRP_READY]    = (i_drp_ready==2'b11);
 assign  cfg_rx_phy_status[`kCFG_RX_PHY_STATUS_DRP_RDATA]    = i_drp_read_data;
 //----------------------------------------------
 // DRP machine assigns
 //----------------------------------------------
 assign  bw_changed   = ( en_bwch_reset == 1'b1 ) ? access_link_bw_set : ( i_detect_rx_clock_update != cfg_rx_dpcd_regs[`kDPCD_LINK_BW_SET] );
 assign  lpm_dfe_mode_changed = 1'b0;
 assign  link_bw_high = ( cfg_rx_dpcd_regs[`kDPCD_LINK_BW_SET] == 8'h a );
 assign  link_bw_rbr  = ( cfg_rx_dpcd_regs[`kDPCD_LINK_BW_SET] == 8'h 6 );
 assign   link_bw_hbr2             = ( cfg_rx_dpcd_regs[`kDPCD_LINK_BW_SET] == 8'd 20 );
 assign   lane_count               = cfg_rx_dpcd_regs[`kDPCD_LANE_COUNT_SET];


 assign bw_changed_out    = bw_changed;
 assign link_bw_hbr2_out  = link_bw_hbr2;
 assign link_bw_high_out  = link_bw_high;
 assign phy_pll_reset_out = i_phy_reset;

   wire [2:0] gt_refclk_sel =  cfg_rx_phy_config[`kCFG_RX_PHY_REFCLKSEL]; // 010 for refclk1 on reset

 //----------------------------------------------
 // pcs reset generation logic, based on tp1
 //----------------------------------------------
 always @ (posedge apb_clk)
 begin
    if (apb_reset == 1'b1)
    begin
       i_detect_rx_clock_update <= #pTCQ 8'b 0;
       i_detect_lpm_dfe_update  <= #pTCQ 1'b 0; 
       i_training_pattern_q     <= #pTCQ 2'b 0;
       i_rx_phy_pcs_reset       <= #pTCQ 1'b 0;
    end
    else
    begin
       // store the value of the previous select to detect a change
       i_detect_rx_clock_update <= #pTCQ cfg_rx_dpcd_regs[`kDPCD_LINK_BW_SET];

       // store the value of the previous LPM/DFE mode to detect change
       i_detect_lpm_dfe_update  <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE];

       // store the value of the previous tp to detect a change
       i_training_pattern_q     <= #pTCQ cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET];

       // pcs reset on detection of training pattern 1 in case of RBR or HBR or HBR2 in LPM mode
       if (i_training_pattern_q != 2'b01 && cfg_rx_dpcd_regs[`kDPCD_TRAINING_PATTERN_SET] == 2'b01 && (en_tp1_reset == 1'b1)) //(link_bw_hbr2 == 1'b0) &&
       begin
           i_rx_phy_pcs_reset <= #pTCQ 1'b1;
       end
       else
       begin
           i_rx_phy_pcs_reset <= #pTCQ 1'b0;
       end
    end
 end


 //------------------------------------------------------------------------------------------------------------
 //                               7-Series  PHY components
 //------------------------------------------------------------------------------------------------------------
 generate if ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" ) | 
               ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" ))
 begin //{


    //assign i_pll_lock_detect_tile_0 = (link_bw_hbr2==1 )?common_qpll_lock:i_pll_lock_detect_tile_00 & i_pll_lock_detect_tile_01;
    //assign i_pll_lock_detect_tile_1 = (link_bw_hbr2==1 )?1'b1:i_pll_lock_detect_tile_10 & i_pll_lock_detect_tile_11;
    assign i_pll_lock_detect_tile_0 = i_pll_lock_detect_tile_00 & i_pll_lock_detect_tile_01;
    assign i_pll_lock_detect_tile_1 = i_pll_lock_detect_tile_10 & i_pll_lock_detect_tile_11;
    assign i_drp_ready[0]           = i_drp_ready00 & i_drp_ready01;
    assign i_drp_ready[1]           = i_drp_ready10 & i_drp_ready11;
    assign lnk_clk                  = i_clkout0_buf;
   
    assign  i_rx_phy_reset_2              = cfg_rx_phy_config[`kCFG_RX_PHY_RESET_2] | i_auto_reset_gtrxreset[7] | reset_on_train_lane_set | i_rx_phy_pcs_reset;
    assign  i_rx_phy_reset_3              = i_rx_phy_reset_2; //gen_rst_due_to_buffer_error; //removed reset on buf status error

    assign GT0_RXLPMEN_IN = ((link_bw_hbr2==0) || (link_bw_hbr2==1 && i_tp1_start_detect_sync[1]==1) || cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE]==0) ;
    assign GT1_RXLPMEN_IN = ((link_bw_hbr2==0) || (link_bw_hbr2==1 && i_tp1_start_detect_sync[1]==1) || cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE]==0) ;
    assign GT2_RXLPMEN_IN = ((link_bw_hbr2==0) || (link_bw_hbr2==1 && i_tp1_start_detect_sync[1]==1) || cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE]==0) ;
    assign GT3_RXLPMEN_IN = ((link_bw_hbr2==0) || (link_bw_hbr2==1 && i_tp1_start_detect_sync[1]==1) || cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE]==0) ;

     wire [15:0] us_drp_data_a5 = {i_drp_read_data[15:14], 14'h0};

    //----------------------------------------------
    // Ultrascale DRP registers
    // Reference clock for 2.7Gbps and 5.4Gbps is 135Mhz
    // Reference clock for 1.62Gbps is 270Mhz
    //----------------------------------------------
    //028
    //7     R/W CPLL_FBDIV_45  (N1) 5->1; 4->0
    //15:8  R/W CPLL_FBDIV     (N2) 5->3, 3->1
    //----------------------------------------------
    //02A
    //15:11  R/W CPLL_REFCLK_DIV  1->'h16  0-> 2
    //------------------------------------------------------------
    //07C 
    //10:8 R/W TXOUT_DIV (D)  1->0 ,2->1 ,4->2 ,8->3 ,16->4
    //------------------------------------------------------------
    //063 -> (Atrribute->DRP Encoding)
    //2:0 R/W RXOUT_DIV (D)   1->0 ,2->1 ,4->2 ,8->3 ,16->4
    //------------------------------------------------------------
    // GT0 - DRP Read considered as master and used for all lanes.
    // Ultrascale default reference clock is 270Mhz for 1.62Gbps 
    // Added the M, N1, N2 and D as per the DP159 FW clock for HBR2, high
    // RBR uses 270Mhz reference clock
    // HBR and HBR2 uses DP159 FWD clock which is 135Mhz for HBR and 270Mhz for HBR2

    wire [15:0] us_drp_data_28 = ( link_bw_high | link_bw_hbr2 ) ? { 8'h3, 1'h0, i_drp_read_data[6:0] } :
                                                                   { 8'h1, 1'h0, i_drp_read_data[6:0] } ;
    wire [15:0] us_drp_data_2A = ( link_bw_high | link_bw_hbr2 ) ? { 5'h 10, i_drp_read_data[10:0] } :
                                                                   { 5'h 10, i_drp_read_data[10:0] } ;
    //wire [15:0] us_drp_data_63_fwd = ( link_bw_hbr2 | link_bw_high ) ? { i_drp_read_data[15:3], 3'h 1 } :
    //                                                                   { i_drp_read_data[15:3], 3'h 2 } ;
    // Below update is required to work 2.7Gbps with external clock of 270Mhz
    //wire [15:0] us_drp_data_63_ext = ( link_bw_hbr2 ) ? { i_drp_read_data[15:3], 3'h 1 } :
    //                                                    { i_drp_read_data[15:3], 3'h 2 } ;
    wire [15:0] us_drp_data_63 = (link_bw_hbr2 || (link_bw_high && gt_refclk_sel==3'b010 ))?{ i_drp_read_data[15:3], 3'h 1 } :
                                                                                            { i_drp_read_data[15:3], 3'h 2 } ;



     //GTH CDR Values
     // Need to test for Ultrascale GTH
     // RBR CDR values are same for FWD clock and for external reference clock 
     wire [71:0] us_rxcdr_cfg_rbr  = 72'h00_0000_0721_0000_0000;  //72'h00_0000_0721_0000_0000; 
     wire [71:0] us_rxcdr_cfg_hbr  = 72'h00_0000_0756_0000_0000;  //72'h00_0000_0721_0000_0000; 
     wire [71:0] us_rxcdr_cfg_hbr2 = 72'h00_0000_0766_0000_0000;  //72'h00_0000_0742_0000_0000;

     reg [15:0] us_drp_data_0E;// = 16'h0020; 
     reg [15:0] us_drp_data_0F;// = (link_bw_rbr | link_bw_high)? 16'h4010 : 16'h1020; 
     reg [15:0] us_drp_data_10;// = 16'h23FF; 
     reg [15:0] us_drp_data_11;// = 16'h8000; 
     reg [15:0] us_drp_data_12;// = {i_drp_read_data[15:8], 8'h03}; 

   always @ (posedge apb_clk) begin
     case({link_bw_hbr2, link_bw_high, link_bw_rbr})
       3'b001: begin
         us_drp_data_0E = us_rxcdr_cfg_rbr[15:0];
         us_drp_data_0F = us_rxcdr_cfg_rbr[31:16];
         us_drp_data_10 = us_rxcdr_cfg_rbr[47:32];
         us_drp_data_11 = us_rxcdr_cfg_rbr[63:48];
         us_drp_data_12 = {i_drp_read_data[15:8], us_rxcdr_cfg_rbr[71:64]};
       end
       3'b010: begin
         us_drp_data_0E = us_rxcdr_cfg_hbr[15:0];
         us_drp_data_0F = us_rxcdr_cfg_hbr[31:16];
         us_drp_data_10 = us_rxcdr_cfg_hbr[47:32];
         us_drp_data_11 = us_rxcdr_cfg_hbr[63:48];
         us_drp_data_12 = {i_drp_read_data[15:8], us_rxcdr_cfg_hbr[71:64]};
       end
       3'b100: begin
         us_drp_data_0E = us_rxcdr_cfg_hbr2[15:0];
         us_drp_data_0F = us_rxcdr_cfg_hbr2[31:16];
         us_drp_data_10 = us_rxcdr_cfg_hbr2[47:32];
         us_drp_data_11 = us_rxcdr_cfg_hbr2[63:48];
         us_drp_data_12 = {i_drp_read_data[15:8], us_rxcdr_cfg_hbr2[71:64]};
       end
       default: begin
       end
     endcase
   end
     
    localparam NO_OF_DRP_INS = 8; 
    localparam NO_OF_DRP_INS_PLUS1 = NO_OF_DRP_INS + 1; 
     // Addr[7:0] + Data[15:0]
     // All commands by default read and write.
     reg [23:0] drp_usseries_cmd_mem [0:NO_OF_DRP_INS];
    
     always @ (posedge apb_clk)
     begin
       drp_usseries_cmd_mem[0] <= {8'h28, us_drp_data_28};   // 7- CPLL_FBDIV_45, 15:8 - CPLL_FBDIV
       drp_usseries_cmd_mem[1] <= {8'h2A, us_drp_data_2A};   // [15-11] - CPLL_REFCK_DIV
       drp_usseries_cmd_mem[2] <= {8'h63, us_drp_data_63};   // [2:0] - RXOUT_DIV
       drp_usseries_cmd_mem[3] <= {8'h0E, us_drp_data_0E};   // CDR Config
       drp_usseries_cmd_mem[4] <= {8'h0F, us_drp_data_0F};
       drp_usseries_cmd_mem[5] <= {8'h10, us_drp_data_10};
       drp_usseries_cmd_mem[6] <= {8'h11, us_drp_data_11};
       drp_usseries_cmd_mem[7] <= {8'h12, us_drp_data_12};
       drp_usseries_cmd_mem[8] <= 24'h0;                  
     end

    assign lpm_dfe_hbr2_update = 0;//(link_bw_hbr2==1 && (i_tp1_started==1 || i_tp2_started==1 || i_tp3_started==1) && cfg_rx_phy_config[`kCFG_RX_PHY_USE_DFE]==1 );

       //----------------------------------------------
    //  DRP state machine
    //----------------------------------------------

     always @ (posedge apb_clk)
    begin
       if (apb_reset == 1'b1 )
       begin
          i_drp_state      <= #pTCQ pDS_IDLE;
          i_drp_enable     <= #pTCQ 1'b0;
          i_drp_write      <= #pTCQ 1'b0;
          i_drp_write_data <= #pTCQ 16'h0000;
          i_drp_addr       <= #pTCQ 8'h00;
          drp_usseries_cmd_id <= #pTCQ 4'b0001;
          i_drp_locked     <= #pTCQ 1'b0;
       end
       else 
       begin
          i_drp_enable     <= #pTCQ 1'b 0;
          i_drp_write      <= #pTCQ 1'b 0;
          case ( i_drp_state )
             pDS_IDLE:
             begin
                i_drp_locked     <= #pTCQ 1'b0;
                if ( bw_changed | lpm_dfe_mode_changed | lpm_dfe_hbr2_update | cfg_rx_phy_config[`kCFG_RX_PHY_DRP_ACCESS])
                begin
                   i_drp_state      <= #pTCQ (cfg_rx_phy_config[`kCFG_RX_PHY_DRP_ACCESS])?pDS_HOST_ACCESS:pDS_DELAY_STATE_1Q;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_IDLE;
                   drp_usseries_cmd_id <= #pTCQ 4'b0001;
                end
             end

             pDS_HOST_ACCESS:
             begin
                   i_drp_locked     <= #pTCQ 1'b0;
                   i_drp_enable     <= #pTCQ 1'b1;
                   i_drp_addr       <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_DRP_ADDR];
                   i_drp_write_data <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_DRP_WDATA];
                   i_drp_write      <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_DRP_WRITE];
                   if ( i_drp_ready == 2'b11 )
                     i_drp_state      <= #pTCQ pDS_IDLE;
                   else
                     i_drp_state      <= #pTCQ pDS_HOST_ACCESS_WAIT;
             end
             pDS_HOST_ACCESS_WAIT:
             begin
                   i_drp_locked     <= #pTCQ 1'b0;
                   i_drp_enable     <= #pTCQ 1'b0;
                   i_drp_addr       <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_DRP_ADDR];
                   i_drp_write_data <= #pTCQ cfg_rx_phy_config[`kCFG_RX_PHY_DRP_WDATA];
                   i_drp_write      <= #pTCQ 1'b0;
                   if ( i_drp_ready == 2'b11 )
                     i_drp_state      <= #pTCQ pDS_IDLE;
                   else
                     i_drp_state      <= #pTCQ pDS_HOST_ACCESS_WAIT;
             end

             pDS_DELAY_STATE_1Q:
             begin
                   i_drp_locked     <= #pTCQ 1'b1;
                   i_drp_state      <= #pTCQ pDS_DELAY_STATE_2Q;
                   drp_usseries_cmd  <= #pTCQ drp_usseries_cmd_mem[0];
                   drp_usseries_cmd_id <= #pTCQ 4'b0001;
                end

             pDS_DELAY_STATE_2Q:
             begin
                   drp_usseries_cmd  <= #pTCQ drp_usseries_cmd_mem[0];
                   i_drp_enable     <= #pTCQ 1'b 1;
                   i_drp_addr       <= #pTCQ drp_usseries_cmd[23:16];
                   i_drp_state      <= #pTCQ pDS_WAIT_READ;
             end
             pDS_WAIT_READ:
             begin
                if ( i_drp_ready == 2'b11 )
                begin
                   i_drp_addr       <= #pTCQ drp_usseries_cmd[23:16];
                   i_drp_write_data <= #pTCQ drp_usseries_cmd[15:0];
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE;
                   i_drp_enable     <= #pTCQ 1'b 1;
                   i_drp_write      <= #pTCQ 1'b 1;
                end
                else
                begin
                   drp_usseries_cmd  <= #pTCQ drp_usseries_cmd_mem[drp_usseries_cmd_id-1];
                   i_drp_state      <= #pTCQ pDS_WAIT_READ;
                end
             end
             pDS_WAIT_WRITE:
             begin
                if ( i_drp_ready == 2'b11 )
                begin
                   if(drp_usseries_cmd_id==NO_OF_DRP_INS) begin
                     i_drp_state      <= #pTCQ pDS_IDLE;
                   end else begin
                     i_drp_state      <= #pTCQ pDS_WAIT_READ;
                     i_drp_addr       <= #pTCQ drp_usseries_cmd[23:16];
                     i_drp_enable     <= #pTCQ 1'b 1;
                   end
                   drp_usseries_cmd_id <= #pTCQ drp_usseries_cmd_id + 4'b0001;
                end
                else
                begin
                   drp_usseries_cmd  <= #pTCQ drp_usseries_cmd_mem[drp_usseries_cmd_id];
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE;
                end
             end
          endcase
       end
    end

    //----------------------------------------------
    //  Automatic reset after a link rate change
    //----------------------------------------------
    always @ (posedge apb_clk)
    begin
       if (apb_reset == 1'b1)
       begin
          i_auto_reset <= 8'h00;
          i_auto_reset_gtrxreset <= 8'h00;
          is_dfe_lpm_reset_condition <= 1'b0;
       end
       else
       begin

          if(i_drp_state == pDS_IDLE && lpm_dfe_hbr2_update==1'b1) begin
            is_dfe_lpm_reset_condition <= 1'b1;
          end else if (i_drp_state == pDS_IDLE && drp_usseries_cmd_id==NO_OF_DRP_INS_PLUS1 && is_dfe_lpm_reset_condition==1'b1) begin
            is_dfe_lpm_reset_condition <= 1'b0;
          end

          // At the end of a link change reset
          if (i_drp_state == pDS_IDLE && drp_usseries_cmd_id==NO_OF_DRP_INS_PLUS1 && is_dfe_lpm_reset_condition==1'b0) //drp_usseries_cmd_id will change to 0x01 in next cycle
          begin
             i_auto_reset <= #pTCQ 8'hff;
          end
          else
          begin
             i_auto_reset <= #pTCQ {i_auto_reset[6:0], 1'b0};
          end

          if (i_drp_state == pDS_IDLE && drp_usseries_cmd_id==NO_OF_DRP_INS_PLUS1) //drp_usseries_cmd_id will change to 0x01 in next cycle
          begin
             i_auto_reset_gtrxreset <= #pTCQ 8'hff;
          end
          else if(cpll_locked)
          begin
             i_auto_reset_gtrxreset <= #pTCQ {i_auto_reset_gtrxreset[6:0], 1'b0};
          end

       end
    end



    //----------------------------------------------
    // User ready signaling for 7 series (async reset)
    //----------------------------------------------
    // GTX Transceiver PLL /Lock Time Adaptation
    // LPM Worst Case = 2.3 x 10^6 x UI
    // DFE Worst Case = 3.7 x 10^6 x UI
    // ------------------------------------------------------------------------------------------
    //   Line Rate      DFE/LPM          tDLOCK (ms)           cpll_timer_max_value (ms)
    //                                                 APB Clk = 50 MHz      APB Clk = 100 MHz
    // ------------------------------------------------------------------------------------------
    //      1.62G        LPM                ~1.41          ~2.6                   ~1.3
    //      2.7G         LPM                ~0.85          ~2.6                   ~1.3  
    //      5.4G         DFE                ~0.69          ~2.6                   ~1.3
    // ------------------------------------------------------------------------------------------
    reg [19:0] cpll_timer;
    reg cdr_lock_time_wait;
    reg valid_rx_user_ready_window;
    reg i_rx_user_ready_apb;

    (* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg [1:0] cpll_locked_apb_sync;
    always@(posedge apb_clk) begin  
      cpll_locked_apb_sync <= #pTCQ {cpll_locked_apb_sync[0], cpll_locked};
    end

    reg i_tp1_start_detect_latch;

    //Async reset for userready is not needed since apb_clk is stable and i_phy_reset is generated in APB domain
    always @ ( posedge apb_clk )
    begin
      if (( i_phy_reset==1'b1) || (cpll_locked_apb_sync[1]==1'b0 ) || i_rx_phy_reset_2) 
      begin
        i_tp1_start_detect_latch <= #pTCQ 1'b0;
      end else if(i_training_pattern_1_set) begin //to ensure symbols are in main link
        i_tp1_start_detect_latch <= #pTCQ 1'b1;
      end
    end

// rx_user_rdy assertion after the PLL is locked to the ref clk (after tdlock wait period) - according to Table56 in ds182
// GPU will come out of power state before it writes to LINK_BW_SET register. So it is known that the GT is not in ELECTRICAL IDLE

    always @ ( posedge apb_clk )
    begin
       if (( i_phy_reset==1'b1) || (cpll_locked_apb_sync[1]==1'b0 )) // || (i_rx_phy_reset_2)) 
       begin
          i_rx_user_ready_apb        <= #pTCQ 1'b 0;
          cpll_timer                 <= #pTCQ 0;
          cdr_lock_time_wait         <= #pTCQ 1'b0;
          valid_rx_user_ready_window <= #pTCQ 1'b1;
       end
       else
       begin
          i_rx_user_ready_apb <= #pTCQ cdr_lock_time_wait;
          //if(cpll_locked_apb_sync[1] & valid_rx_user_ready_window & i_tp1_start_detect_latch) //To be reviewed if needed to wait till TP1
          if(cpll_locked_apb_sync[1] & valid_rx_user_ready_window) 
              cpll_timer <= #pTCQ cpll_timer + 1;
              if(cpll_timer == cfg_rx_phy_config[`kCFG_RX_PHY_TDLOCK_VALUE]) 
              begin 
                   cdr_lock_time_wait         <= #pTCQ 1'b1;
                   valid_rx_user_ready_window <= #pTCQ 1'b0;
              end
       end
    end

    assign i_rx_user_ready = i_rx_user_ready_apb;

    always @ ( posedge lnk_clk or posedge i_phy_reset ) 
    begin
       if ( i_phy_reset==1'b1)
       begin
           GT0_RXLPMEN_IN_reg <= #pTCQ 1'b1;
           GT1_RXLPMEN_IN_reg <= #pTCQ 1'b1;
           GT2_RXLPMEN_IN_reg <= #pTCQ 1'b1;
           GT3_RXLPMEN_IN_reg <= #pTCQ 1'b1;
       end
       else
       begin
           GT0_RXLPMEN_IN_reg <= #pTCQ GT0_RXLPMEN_IN;
           GT1_RXLPMEN_IN_reg <= #pTCQ GT1_RXLPMEN_IN;
           GT2_RXLPMEN_IN_reg <= #pTCQ GT2_RXLPMEN_IN;
           GT3_RXLPMEN_IN_reg <= #pTCQ GT3_RXLPMEN_IN;
       end
    end

    //----------------------------------------------
    // receive clock regeneration
    //----------------------------------------------
         BUFG_GT bufg_gt_mmcm_in_clk_inst (
          .CE       (1'b1),
          .CEMASK   (1'b0),
          .CLR      (1'b0),
          .CLRMASK  (1'b0),
          .DIV      (3'b000),
          .I        (i_clkout0),
          .O        (i_clkout0_buf)
        ); 

    assign i_rec_clk_dcm_locked = 1'b 1;
    assign i_clkout2_buf        = i_clkout0_buf;
    //----------------------------------------------
    // Hot Plug Detect
    //----------------------------------------------
    OBUF hot_plug_detect_inst (
        .O (hpd),
        .I (hot_plug_detect)
    );

    //----------------------------------------------
    // AUX Channel
    //----------------------------------------------


 end //}
 endgenerate


 //----------------------------------------------
 // 7-Series GTX2
 //----------------------------------------------
 generate if ( ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" )  
                | ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 1 ) )
 begin //{
    assign i_lane0_aligned_d        = 1'b 0;
     bd_6311_dp_0_gth_us_wrapper_1
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gth_us_wrapper_inst
    (
        .GT0_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[0]),
        .GT0_TXPMARESETDONE_OUT         (),
        .GT0_DMONITOROUT_OUT            (i_dmonitor_out_0[15:0]),
 


        //Following signals are applied to all lanes
        .GT0_TX8B10BEN_IN               (1'b1),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT0_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT0_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT0_RXLPMHFHOLD_IN             (i_rxlpmhfhold), 
        .GT0_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT0_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (i_rxpolarity_lane0),
        .GT0_TXPOLARITY_IN              (1'b0),
  
        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN_reg),   
        .GT0_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT0_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT0_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (i_eyescanreset),
        .GT0_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT0_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[0]),
        .GT0_RXPD_IN                    ({i_rx_power_down[0], i_rx_power_down[0]}),
        .GT0_TXPD_IN                    (2'b 0),
        .GT0_RXUSERRDY_IN               (i_rx_user_ready),
        .GT0_RXCHARISK_OUT              (i_lnk_rx_lane0_kchar_d),
        .GT0_RXDISPERR_OUT              (i_lnk_rx_lane0_disparity_error_d),
        .GT0_RXNOTINTABLE_OUT           (i_lnk_rx_lane0_symbol_error_d),
        .GT0_RXBYTEISALIGNED_OUT        (i_lane0_symbol_locked_d),
        .GT0_RXCOMMADET_OUT             (i_comma_det_out[0]),
        .GT0_RXMCOMMAALIGNEN_IN         (i_comma_align_enable),
        .GT0_RXPCOMMAALIGNEN_IN         (i_comma_align_enable),
        .GT0_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT0_RXPRBSERR_OUT              (i_prbs_error_lane0_d),
        .GT0_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT0_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT0_RXDATA_OUT                 (i_lnk_rx_lane0_data_d),
        .GT0_RXOUTCLK_OUT               (i_clkout0),
        .GT0_RXPCSRESET_IN              (i_pcs_reset), 
        .GT0_RXPMARESET_IN              (i_pma_reset), 
        .GT0_RXUSRCLK_IN                (i_clkout0_buf),
        .GT0_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT0_PCSRSVDIN_IN               (gt_pcsrsvdin_in),
	
        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT0_RXELECIDLE_OUT             (i_rx_low_voltage_lane0_d),
        .GT0_RXBUFRESET_IN              (i_buf_reset),
        .GT0_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_0_d),
        .GT0_RXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_GTHTXN_OUT                 (),
        .GT0_GTHTXP_OUT                 (),
        .GT0_GTHRXN_IN                  (i_lnk_rx_lane_n_w[0]),
        .GT0_GTHRXP_IN                  (i_lnk_rx_lane_p_w[0]),
 

        .GT0_TXPOSTCURSOR_IN            (5'b 0),
        .GT0_TXPRECURSOR_IN             (5'b 0),
        .GT0_TXUSERRDY_IN               (1'b 0),
        .GT0_TXCHARISK_IN               (2'b 0),
        .GT0_TXCHARDISPVAL_IN           (2'b 0),
        .GT0_TXCHARDISPMODE_IN          (2'b 0),
        .GT0_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT0_TXDATA_IN                  (16'b 0),
        .GT0_TXOUTCLK_OUT               (),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (1'b 0), 
        .GT0_TXPMARESET_IN              (1'b 0), 
        .GT0_TXUSRCLK_IN                (1'b0),
        .GT0_TXUSRCLK2_IN               (1'b0),
        .GT0_TXDIFFCTRL_IN              (5'b 0),
        .GT0_TXINHIBIT_IN               (1'b 0),
        .GT0_TXBUFSTATUS_OUT            (),
        .GT0_TXRESETDONE_OUT            (),
        .GT0_TXPRBSFORCEERR_IN          (1'b 0),
        .GT0_TXPRBSSEL_IN               (3'b 0),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 else if ( ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) |  ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" )
             | ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 2 ) )
 begin //{
    assign i_lane0_aligned_d        = 1'b 0;
    assign i_lane1_aligned_d        = 1'b 0;
 
     bd_6311_dp_0_gth_us_wrapper_2
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gth_us_wrapper_inst
    (
        .GT0_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[0]),
        .GT0_TXPMARESETDONE_OUT         (),
        .GT1_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[1]),
        .GT1_TXPMARESETDONE_OUT         (),
        .GT0_DMONITOROUT_OUT            (i_dmonitor_out_0[15:0]),
        .GT1_DMONITOROUT_OUT            (i_dmonitor_out_1[15:0]),
 

        //Following signals are applied to all lanes

        .GT0_TX8B10BEN_IN               (1'b1),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT1_TX8B10BEN_IN               (1'b1),
        .GT1_RX8B10BEN_IN               (1'b1),
        .GT0_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT0_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT0_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT0_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT0_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (i_rxpolarity_lane0),
        .GT0_TXPOLARITY_IN              (1'b0),

        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN_reg), 
        .GT0_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT0_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT0_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (i_eyescanreset),
        .GT0_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT0_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[0]),
        .GT0_RXPD_IN                    ({i_rx_power_down[0], i_rx_power_down[0]}),
        .GT0_TXPD_IN                    (2'b 0),
        .GT0_RXUSERRDY_IN               (i_rx_user_ready),
        .GT0_RXCHARISK_OUT              (i_lnk_rx_lane0_kchar_d),
        .GT0_RXDISPERR_OUT              (i_lnk_rx_lane0_disparity_error_d),
        .GT0_RXNOTINTABLE_OUT           (i_lnk_rx_lane0_symbol_error_d),
        .GT0_RXBYTEISALIGNED_OUT        (i_lane0_symbol_locked_d),
        .GT0_RXCOMMADET_OUT             (i_comma_det_out[0]),
        .GT0_RXMCOMMAALIGNEN_IN         (i_comma_align_enable),
        .GT0_RXPCOMMAALIGNEN_IN         (i_comma_align_enable),
        .GT0_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT0_RXPRBSERR_OUT              (i_prbs_error_lane0_d),
        .GT0_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT0_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT0_RXDATA_OUT                 (i_lnk_rx_lane0_data_d),
        .GT0_RXOUTCLK_OUT               (i_clkout0),
        .GT0_RXPCSRESET_IN              (i_pcs_reset), 
        .GT0_RXPMARESET_IN              (i_pma_reset), 
        .GT0_RXUSRCLK_IN                (i_clkout0_buf),
        .GT0_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT0_RXELECIDLE_OUT             (i_rx_low_voltage_lane0_d),
        .GT0_RXBUFRESET_IN              (i_buf_reset),
        .GT0_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_0_d),
        .GT0_RXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_GTHTXN_OUT                 (),
        .GT0_GTHTXP_OUT                 (),
        .GT0_GTHRXN_IN                  (i_lnk_rx_lane_n_w[0]),
        .GT0_GTHRXP_IN                  (i_lnk_rx_lane_p_w[0]),
 

        .GT0_TXPOSTCURSOR_IN            (5'b 0),
        .GT0_TXPRECURSOR_IN             (5'b 0),
        .GT0_TXUSERRDY_IN               (1'b 0),
        .GT0_TXCHARISK_IN               (2'b 0),
        .GT0_TXCHARDISPVAL_IN           (2'b 0),
        .GT0_TXCHARDISPMODE_IN          (2'b 0),
        .GT0_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT0_TXDATA_IN                  (16'b 0),
        .GT0_TXOUTCLK_OUT               (),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (1'b 0), 
        .GT0_TXPMARESET_IN              (1'b 0), 
        .GT0_TXUSRCLK_IN                (1'b0),
        .GT0_TXUSRCLK2_IN               (1'b0),
        .GT0_TXDIFFCTRL_IN              (5'b 0),
        .GT0_TXINHIBIT_IN               (1'b 0),
        .GT0_TXBUFSTATUS_OUT            (),
        .GT0_TXRESETDONE_OUT            (),
        .GT0_TXPRBSFORCEERR_IN          (1'b 0),
        .GT0_TXPRBSSEL_IN               (3'b 0),
        .GT0_PCSRSVDIN_IN               (gt_pcsrsvdin_in),
        .GT1_PCSRSVDIN_IN               (gt_pcsrsvdin_in),
        .GT1_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT1_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT1_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT1_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT1_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT1_LOOPBACK_IN                (i_loopback), 
        .GT1_RXPOLARITY_IN              (i_rxpolarity_lane1),
        .GT1_TXPOLARITY_IN              (1'b0),

        .GT1_RXLPMEN_IN                 (GT1_RXLPMEN_IN_reg), 
        .GT1_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT1_DRPCLK_IN                  (apb_clk),
        .GT1_DRPDI_IN                   (i_drp_write_data),
        .GT1_DRPDO_OUT                  (),
        .GT1_DRPEN_IN                   (i_drp_enable),
        .GT1_DRPRDY_OUT                 (i_drp_ready01),
        .GT1_DRPWE_IN                   (i_drp_write),
        .GT1_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT1_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT1_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT1_CPLLFBCLKLOST_OUT          (),
        .GT1_CPLLLOCK_OUT               (i_pll_lock_detect_tile_01),
        .GT1_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT1_CPLLREFCLKLOST_OUT         (),
        .GT1_CPLLRESET_IN               (i_phy_reset),
        .GT1_EYESCANRESET_IN            (i_eyescanreset),
        .GT1_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT1_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[1]),
        .GT1_RXPD_IN                    ({i_rx_power_down[1], i_rx_power_down[1]}),
        .GT1_TXPD_IN                    (2'b 0),
        .GT1_RXUSERRDY_IN               (i_rx_user_ready),
        .GT1_RXCHARISK_OUT              (i_lnk_rx_lane1_kchar_d),
        .GT1_RXDISPERR_OUT              (i_lnk_rx_lane1_disparity_error_d),
        .GT1_RXNOTINTABLE_OUT           (i_lnk_rx_lane1_symbol_error_d),
        .GT1_RXBYTEISALIGNED_OUT        (i_lane1_symbol_locked_d),
        .GT1_RXCOMMADET_OUT             (i_comma_det_out[1]),
        .GT1_RXMCOMMAALIGNEN_IN         (i_comma_align_enable1),
        .GT1_RXPCOMMAALIGNEN_IN         (i_comma_align_enable1),
        .GT1_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT1_RXPRBSERR_OUT              (i_prbs_error_lane1_d),
        .GT1_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT1_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT1_RXDATA_OUT                 (i_lnk_rx_lane1_data_d),
        .GT1_RXOUTCLK_OUT               (),
        .GT1_RXPCSRESET_IN              (i_pcs_reset),
        .GT1_RXPMARESET_IN              (i_pma_reset),
        .GT1_RXUSRCLK_IN                (i_clkout0_buf),
        .GT1_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT1_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT1_RXELECIDLE_OUT             (i_rx_low_voltage_lane1_d),
        .GT1_RXBUFRESET_IN              (i_buf_reset),
        .GT1_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_1_d),
        .GT1_RXRESETDONE_OUT            (i_reset_done_tile_0[1]),
        .GT1_GTHTXN_OUT                 (),
        .GT1_GTHTXP_OUT                 (),
        .GT1_GTHRXN_IN                  (i_lnk_rx_lane_n_w[1]),
        .GT1_GTHRXP_IN                  (i_lnk_rx_lane_p_w[1]),
 

        .GT1_TXPOSTCURSOR_IN            (5'b 0),
        .GT1_TXPRECURSOR_IN             (5'b 0),
        .GT1_TXUSERRDY_IN               (1'b 0),
        .GT1_TXCHARISK_IN               (2'b 0),
        .GT1_TXCHARDISPVAL_IN           (2'b 0),
        .GT1_TXCHARDISPMODE_IN          (2'b 0),
        .GT1_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT1_TXDATA_IN                  (16'b 0),
        .GT1_TXOUTCLK_OUT               (),
        .GT1_TXOUTCLKFABRIC_OUT         (),
        .GT1_TXOUTCLKPCS_OUT            (),
        .GT1_TXPCSRESET_IN              (1'b 0),
        .GT1_TXPMARESET_IN              (1'b 0),
        .GT1_TXUSRCLK_IN                (1'b0),
        .GT1_TXUSRCLK2_IN               (1'b0),
        .GT1_TXDIFFCTRL_IN              (5'b 0),
        .GT1_TXINHIBIT_IN               (1'b 0),
        .GT1_TXBUFSTATUS_OUT            (),
        .GT1_TXRESETDONE_OUT            (),
        .GT1_TXPRBSFORCEERR_IN          (1'b 0),
        .GT1_TXPRBSSEL_IN               (3'b 0),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 else if ( ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" )
             | ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 4 ) )
 begin //{
    assign i_lane0_aligned_d        = 1'b 0;
    assign i_lane1_aligned_d        = 1'b 0;
    assign i_lane2_aligned_d        = 1'b 0;
    assign i_lane3_aligned_d        = 1'b 0;
     bd_6311_dp_0_gth_us_wrapper_4
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gth_us_wrapper_inst
    (
        .GT0_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[0]),
        .GT0_TXPMARESETDONE_OUT         (),
        .GT1_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[1]),
        .GT1_TXPMARESETDONE_OUT         (),
        .GT2_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[2]),
        .GT2_TXPMARESETDONE_OUT         (),
        .GT3_RXPMARESETDONE_OUT         (i_rx_pma_reset_done_out[3]),
        .GT3_TXPMARESETDONE_OUT         (),
        .GT0_DMONITOROUT_OUT            (i_dmonitor_out_0[15:0]),
        .GT1_DMONITOROUT_OUT            (i_dmonitor_out_1[15:0]),
        .GT2_DMONITOROUT_OUT            (i_dmonitor_out_2[15:0]),
        .GT3_DMONITOROUT_OUT            (i_dmonitor_out_3[15:0]),
 

        //Following signals are applied to all lanes

        .GT0_TX8B10BEN_IN               (1'b1),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT1_TX8B10BEN_IN               (1'b1),
        .GT1_RX8B10BEN_IN               (1'b1),
        .GT2_TX8B10BEN_IN               (1'b1),
        .GT2_RX8B10BEN_IN               (1'b1),
        .GT3_TX8B10BEN_IN               (1'b1),
        .GT3_RX8B10BEN_IN               (1'b1),
        .GT0_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT0_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT0_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT0_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT0_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (i_rxpolarity_lane0),
        .GT0_TXPOLARITY_IN              (1'b0),

        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN_reg),  
        .GT0_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT0_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT0_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (i_eyescanreset),
        .GT0_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT0_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[0]),
        .GT0_RXPD_IN                    ({i_rx_power_down[0], i_rx_power_down[0]}),
        .GT0_TXPD_IN                    (2'b 0),
        .GT0_RXUSERRDY_IN               (i_rx_user_ready),
        .GT0_RXCHARISK_OUT              (i_lnk_rx_lane0_kchar_d),
        .GT0_RXDISPERR_OUT              (i_lnk_rx_lane0_disparity_error_d),
        .GT0_RXNOTINTABLE_OUT           (i_lnk_rx_lane0_symbol_error_d),
        .GT0_RXBYTEISALIGNED_OUT        (i_lane0_symbol_locked_d),
        .GT0_RXCOMMADET_OUT             (i_comma_det_out[0]),
        .GT0_RXMCOMMAALIGNEN_IN         (i_comma_align_enable0),
        .GT0_RXPCOMMAALIGNEN_IN         (i_comma_align_enable0),
        .GT0_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT0_RXPRBSERR_OUT              (i_prbs_error_lane0_d),
        .GT0_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT0_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT0_RXDATA_OUT                 (i_lnk_rx_lane0_data_d),
        .GT0_RXOUTCLK_OUT               (i_clkout0),
        .GT0_RXPCSRESET_IN              (i_pcs_reset),
        .GT0_RXPMARESET_IN              (i_pma_reset),
        .GT0_RXUSRCLK_IN                (i_clkout0_buf),
        .GT0_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT0_RXELECIDLE_OUT             (i_rx_low_voltage_lane0_d),
        .GT0_RXBUFRESET_IN              (i_buf_reset), 
        .GT0_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_0_d),
        .GT0_RXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_GTHTXN_OUT                 (),
        .GT0_GTHTXP_OUT                 (),
        .GT0_GTHRXN_IN                  (i_lnk_rx_lane_n_w[0]),
        .GT0_GTHRXP_IN                  (i_lnk_rx_lane_p_w[0]),
 

        .GT0_TXPOSTCURSOR_IN            (5'b 0),
        .GT0_TXPRECURSOR_IN             (5'b 0),
        .GT0_TXUSERRDY_IN               (1'b 0),
        .GT0_TXCHARISK_IN               (2'b 0),
        .GT0_TXCHARDISPVAL_IN           (2'b 0),
        .GT0_TXCHARDISPMODE_IN          (2'b 0),
        .GT0_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT0_TXDATA_IN                  (16'b 0),
        .GT0_TXOUTCLK_OUT               (),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (1'b 0), 
        .GT0_TXPMARESET_IN              (1'b 0), 
        .GT0_TXUSRCLK_IN                (1'b0),
        .GT0_TXUSRCLK2_IN               (1'b0),
        .GT0_TXDIFFCTRL_IN              (5'b 0),
        .GT0_TXINHIBIT_IN               (1'b 0),
        .GT0_TXBUFSTATUS_OUT            (),
        .GT0_TXRESETDONE_OUT            (),
        .GT0_TXPRBSFORCEERR_IN          (1'b 0),
        .GT0_TXPRBSSEL_IN               (3'b 0),
        .GT0_PCSRSVDIN_IN              (gt_pcsrsvdin_in),
        .GT1_PCSRSVDIN_IN              (gt_pcsrsvdin_in),
        .GT2_PCSRSVDIN_IN              (gt_pcsrsvdin_in),
        .GT3_PCSRSVDIN_IN              (gt_pcsrsvdin_in),
        .GT1_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT1_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT1_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT1_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT1_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT1_LOOPBACK_IN                (i_loopback), 
        .GT1_RXPOLARITY_IN              (i_rxpolarity_lane1),
        .GT1_TXPOLARITY_IN              (1'b0),

        .GT1_RXLPMEN_IN                 (GT1_RXLPMEN_IN_reg), 
        .GT1_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT1_DRPCLK_IN                  (apb_clk),
        .GT1_DRPDI_IN                   (i_drp_write_data),
        .GT1_DRPDO_OUT                  (),
        .GT1_DRPEN_IN                   (i_drp_enable),
        .GT1_DRPRDY_OUT                 (i_drp_ready01),
        .GT1_DRPWE_IN                   (i_drp_write),
        .GT1_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT1_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT1_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT1_CPLLFBCLKLOST_OUT          (),
        .GT1_CPLLLOCK_OUT               (i_pll_lock_detect_tile_01),
        .GT1_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT1_CPLLREFCLKLOST_OUT         (),
        .GT1_CPLLRESET_IN               (i_phy_reset),
        .GT1_EYESCANRESET_IN            (i_eyescanreset),
        .GT1_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT1_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[1]),
        .GT1_RXPD_IN                    ({i_rx_power_down[1], i_rx_power_down[1]}),
        .GT1_TXPD_IN                    (2'b 0),
        .GT1_RXUSERRDY_IN               (i_rx_user_ready),
        .GT1_RXCHARISK_OUT              (i_lnk_rx_lane1_kchar_d),
        .GT1_RXDISPERR_OUT              (i_lnk_rx_lane1_disparity_error_d),
        .GT1_RXNOTINTABLE_OUT           (i_lnk_rx_lane1_symbol_error_d),
        .GT1_RXBYTEISALIGNED_OUT        (i_lane1_symbol_locked_d),
        .GT1_RXCOMMADET_OUT             (i_comma_det_out[1]),
        .GT1_RXMCOMMAALIGNEN_IN         (i_comma_align_enable1),
        .GT1_RXPCOMMAALIGNEN_IN         (i_comma_align_enable1),
        .GT1_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT1_RXPRBSERR_OUT              (i_prbs_error_lane1_d),
        .GT1_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT1_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT1_RXDATA_OUT                 (i_lnk_rx_lane1_data_d),
        .GT1_RXOUTCLK_OUT               (),
        .GT1_RXPCSRESET_IN              (i_pcs_reset),
        .GT1_RXPMARESET_IN              (i_pma_reset),
        .GT1_RXUSRCLK_IN                (i_clkout0_buf),
        .GT1_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT1_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT1_RXELECIDLE_OUT             (i_rx_low_voltage_lane1_d),
        .GT1_RXBUFRESET_IN              (i_buf_reset),
        .GT1_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_1_d),
        .GT1_RXRESETDONE_OUT            (i_reset_done_tile_0[1]),
        .GT1_GTHTXN_OUT                 (),
        .GT1_GTHTXP_OUT                 (),
        .GT1_GTHRXN_IN                  (i_lnk_rx_lane_n_w[1]),
        .GT1_GTHRXP_IN                  (i_lnk_rx_lane_p_w[1]),
 

        .GT1_TXPOSTCURSOR_IN            (5'b 0),
        .GT1_TXPRECURSOR_IN             (5'b 0),
        .GT1_TXUSERRDY_IN               (1'b 0),
        .GT1_TXCHARISK_IN               (2'b 0),
        .GT1_TXCHARDISPVAL_IN           (2'b 0),
        .GT1_TXCHARDISPMODE_IN          (2'b 0),
        .GT1_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT1_TXDATA_IN                  (16'b 0),
        .GT1_TXOUTCLK_OUT               (),
        .GT1_TXOUTCLKFABRIC_OUT         (),
        .GT1_TXOUTCLKPCS_OUT            (),
        .GT1_TXPCSRESET_IN              (1'b 0),
        .GT1_TXPMARESET_IN              (1'b 0),
        .GT1_TXUSRCLK_IN                (1'b0),
        .GT1_TXUSRCLK2_IN               (1'b0),
        .GT1_TXDIFFCTRL_IN              (5'b 0),
        .GT1_TXINHIBIT_IN               (1'b 0),
        .GT1_TXBUFSTATUS_OUT            (),
        .GT1_TXRESETDONE_OUT            (),
        .GT1_TXPRBSFORCEERR_IN          (1'b 0),
        .GT1_TXPRBSSEL_IN               (3'b 0),


        .GT2_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT2_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT2_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT2_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT2_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT2_LOOPBACK_IN                (i_loopback), 
        .GT2_RXPOLARITY_IN              (i_rxpolarity_lane2),
        .GT2_TXPOLARITY_IN              (1'b0),

        .GT2_RXLPMEN_IN                 (GT2_RXLPMEN_IN_reg),   
        .GT2_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT2_DRPCLK_IN                  (apb_clk),
        .GT2_DRPDI_IN                   (i_drp_write_data),
        .GT2_DRPDO_OUT                  (),
        .GT2_DRPEN_IN                   (i_drp_enable),
        .GT2_DRPRDY_OUT                 (i_drp_ready10),
        .GT2_DRPWE_IN                   (i_drp_write),
        .GT2_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT2_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT2_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT2_CPLLFBCLKLOST_OUT          (),
        .GT2_CPLLLOCK_OUT               (i_pll_lock_detect_tile_10),
        .GT2_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT2_CPLLREFCLKLOST_OUT         (),
        .GT2_CPLLRESET_IN               (i_phy_reset),
        .GT2_EYESCANRESET_IN            (i_eyescanreset),
        .GT2_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT2_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[2]),
        .GT2_RXPD_IN                    ({i_rx_power_down[2], i_rx_power_down[2]}),
        .GT2_TXPD_IN                    (2'b 0),
        .GT2_RXUSERRDY_IN               (i_rx_user_ready),
        .GT2_RXCHARISK_OUT              (i_lnk_rx_lane2_kchar_d),
        .GT2_RXDISPERR_OUT              (i_lnk_rx_lane2_disparity_error_d),
        .GT2_RXNOTINTABLE_OUT           (i_lnk_rx_lane2_symbol_error_d),
        .GT2_RXBYTEISALIGNED_OUT        (i_lane2_symbol_locked_d),
        .GT2_RXCOMMADET_OUT             (i_comma_det_out[2]),
        .GT2_RXMCOMMAALIGNEN_IN         (i_comma_align_enable2),
        .GT2_RXPCOMMAALIGNEN_IN         (i_comma_align_enable2),
        .GT2_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT2_RXPRBSERR_OUT              (i_prbs_error_lane2_d),
        .GT2_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT2_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT2_RXDATA_OUT                 (i_lnk_rx_lane2_data_d),
        .GT2_RXOUTCLK_OUT               (),
        .GT2_RXPCSRESET_IN              (i_pcs_reset),
        .GT2_RXPMARESET_IN              (i_pma_reset),
        .GT2_RXUSRCLK_IN                (i_clkout0_buf),
        .GT2_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT2_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT2_RXELECIDLE_OUT             (i_rx_low_voltage_lane2_d),
        .GT2_RXBUFRESET_IN              (i_buf_reset), 
        .GT2_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_2_d),
        .GT2_RXRESETDONE_OUT            (i_reset_done_tile_1[0]),
        .GT2_GTHTXN_OUT                 (),
        .GT2_GTHTXP_OUT                 (),
        .GT2_GTHRXN_IN                  (i_lnk_rx_lane_n_w[2]),
        .GT2_GTHRXP_IN                  (i_lnk_rx_lane_p_w[2]),
 

        .GT2_TXPOSTCURSOR_IN            (5'b 0),
        .GT2_TXPRECURSOR_IN             (5'b 0),
        .GT2_TXUSERRDY_IN               (1'b 0),
        .GT2_TXCHARISK_IN               (2'b 0),
        .GT2_TXCHARDISPVAL_IN           (2'b 0),
        .GT2_TXCHARDISPMODE_IN          (2'b 0),
        .GT2_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT2_TXDATA_IN                  (16'b 0),
        .GT2_TXOUTCLK_OUT               (),
        .GT2_TXOUTCLKFABRIC_OUT         (),
        .GT2_TXOUTCLKPCS_OUT            (),
        .GT2_TXPCSRESET_IN              (1'b 0),
        .GT2_TXPMARESET_IN              (1'b 0),
        .GT2_TXUSRCLK_IN                (1'b0),
        .GT2_TXUSRCLK2_IN               (1'b0),
        .GT2_TXDIFFCTRL_IN              (5'b 0),
        .GT2_TXINHIBIT_IN               (1'b 0),
        .GT2_TXBUFSTATUS_OUT            (),
        .GT2_TXRESETDONE_OUT            (),
        .GT2_TXPRBSFORCEERR_IN          (1'b 0),
        .GT2_TXPRBSSEL_IN               (3'b 0),

        .GT3_RXLPMLFHOLD_IN             (i_rxlpmlfhold),   
        .GT3_RXLPMHFHOLD_IN             (i_rxlpmhfhold),   
        .GT3_RXDFELPMRESET_IN           (i_rxdfelpmreset), 
        .GT3_RXLPMHFOVRDEN_IN           (i_rxlpmhfoverden), 
        .GT3_RXCDRHOLD_IN               (i_cdr_hold), 
        .GT3_LOOPBACK_IN                (i_loopback), 
        .GT3_RXPOLARITY_IN              (i_rxpolarity_lane3),
        .GT3_TXPOLARITY_IN              (1'b0),

        .GT3_RXLPMEN_IN                 (GT3_RXLPMEN_IN_reg), 
        .GT3_DRPADDR_IN                 ({ 2'b 00, i_drp_addr }),
	
        .GT3_DRPCLK_IN                  (apb_clk),
        .GT3_DRPDI_IN                   (i_drp_write_data),
        .GT3_DRPDO_OUT                  (),
        .GT3_DRPEN_IN                   (i_drp_enable),
        .GT3_DRPRDY_OUT                 (i_drp_ready11),
        .GT3_DRPWE_IN                   (i_drp_write),
        .GT3_GTREFCLK0_IN               (lnk_clk_ibufds),
        .GT3_GTREFCLK1_IN               (lnk_fwdclk_ibufds),
	
        .GT3_GTREFCLKSEL_IN             (gt_refclk_sel),
        .GT3_CPLLFBCLKLOST_OUT          (),
        .GT3_CPLLLOCK_OUT               (i_pll_lock_detect_tile_11),
        .GT3_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT3_CPLLREFCLKLOST_OUT         (),
        .GT3_CPLLRESET_IN               (i_phy_reset),
        .GT3_EYESCANRESET_IN            (i_eyescanreset),
        .GT3_EYESCANTRIGGER_IN          (i_eyescantrigger_sync[1]),
        .GT3_EYESCANDATAERROR_OUT       (i_eyescandataerror_out[3]),
        .GT3_RXPD_IN                    ({i_rx_power_down[3], i_rx_power_down[3]}),
        .GT3_TXPD_IN                    (2'b 0),
        .GT3_RXUSERRDY_IN               (i_rx_user_ready),
        .GT3_RXCHARISK_OUT              (i_lnk_rx_lane3_kchar_d),
        .GT3_RXDISPERR_OUT              (i_lnk_rx_lane3_disparity_error_d),
        .GT3_RXNOTINTABLE_OUT           (i_lnk_rx_lane3_symbol_error_d),
        .GT3_RXBYTEISALIGNED_OUT        (i_lane3_symbol_locked_d),
        .GT3_RXCOMMADET_OUT             (i_comma_det_out[3]),
        .GT3_RXMCOMMAALIGNEN_IN         (i_comma_align_enable3),
        .GT3_RXPCOMMAALIGNEN_IN         (i_comma_align_enable3),
        .GT3_RXPRBSCNTRESET_IN          (i_prbscntreset),
        .GT3_RXPRBSERR_OUT              (i_prbs_error_lane3_d),
        .GT3_RXPRBSSEL_IN               (i_prbs_test_enable),
        .GT3_GTRXRESET_IN               (i_rx_phy_reset_2),
        .GT3_RXDATA_OUT                 (i_lnk_rx_lane3_data_d),
        .GT3_RXOUTCLK_OUT               (),
        .GT3_RXPCSRESET_IN              (i_pcs_reset),
        .GT3_RXPMARESET_IN              (i_pma_reset),
        .GT3_RXUSRCLK_IN                (i_clkout0_buf),
        .GT3_RXUSRCLK2_IN               (i_clkout2_buf),
        .GT3_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT3_RXELECIDLE_OUT             (i_rx_low_voltage_lane3_d),
        .GT3_RXBUFRESET_IN              (i_buf_reset), //(i_rx_phy_reset_3),
        .GT3_RXBUFSTATUS_OUT            (i_rx_buffer_status_lane_3_d),
        .GT3_RXRESETDONE_OUT            (i_reset_done_tile_1[1]),
        .GT3_GTHTXN_OUT                 (),
        .GT3_GTHTXP_OUT                 (),
        .GT3_GTHRXN_IN                  (i_lnk_rx_lane_n_w[3]),
        .GT3_GTHRXP_IN                  (i_lnk_rx_lane_p_w[3]),
 

        .GT3_TXPOSTCURSOR_IN            (5'b 0),
        .GT3_TXPRECURSOR_IN             (5'b 0),
        .GT3_TXUSERRDY_IN               (1'b 0),
        .GT3_TXCHARISK_IN               (2'b 0),
        .GT3_TXCHARDISPVAL_IN           (2'b 0),
        .GT3_TXCHARDISPMODE_IN          (2'b 0),
        .GT3_GTTXRESET_IN               (i_rx_phy_reset_2),
        .GT3_TXDATA_IN                  (16'b 0),
        .GT3_TXOUTCLK_OUT               (),
        .GT3_TXOUTCLKFABRIC_OUT         (),
        .GT3_TXOUTCLKPCS_OUT            (),
        .GT3_TXPCSRESET_IN              (1'b 0),
        .GT3_TXPMARESET_IN              (1'b 0),
        .GT3_TXUSRCLK_IN                (1'b0),
        .GT3_TXUSRCLK2_IN               (1'b0),
        .GT3_TXDIFFCTRL_IN              (5'b 0),
        .GT3_TXINHIBIT_IN               (1'b 0),
        .GT3_TXBUFSTATUS_OUT            (),
        .GT3_TXRESETDONE_OUT            (),
        .GT3_TXPRBSFORCEERR_IN          (1'b 0),
        .GT3_TXPRBSSEL_IN               (3'b 0),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 endgenerate


 //--------------------------------------------------------------------
 // one or two lane case
 //--------------------------------------------------------------------
 generate if ( pLANE_COUNT != 4 )
 begin
    assign i_lnk_rx_lane2_data_d            = 32'b 0;
    assign i_lnk_rx_lane2_kchar_d           = 4'b 0;
    assign i_lnk_rx_lane2_disparity_error_d = 4'b 0;
    assign i_pll_lock_detect_tile_10        = 1'b 1;
    assign i_reset_done_tile_1[0]           = 1'b 1;
    assign i_drp_ready10                    = 1'b 1;
    assign i_lnk_rx_lane2_symbol_error_d    = 4'b 0;
    assign i_lane2_symbol_locked_d          = 1'b 0;
    assign i_prbs_error_lane2_d             = 1'b 0;
    assign i_loss_of_sync_lane2_d           = 2'b 0;
    assign i_rx_low_voltage_lane2_d         = 1'b 0;
    assign i_rx_buffer_status_lane_2_d      = 3'b 0;
    assign i_lane2_aligned_d                = 1'b 0;

    assign i_pll_lock_detect_tile_11        = 1'b 1;
    assign i_reset_done_tile_1[1]           = 1'b 1;
    assign i_drp_ready11                    = 1'b 1;
    assign i_lnk_rx_lane3_data_d            = 32'b 0;
    assign i_lnk_rx_lane3_kchar_d           = 4'b 0;
    assign i_lnk_rx_lane3_disparity_error_d = 4'b 0;
    assign i_lnk_rx_lane3_symbol_error_d    = 4'b 0;
    assign i_lane3_symbol_locked_d          = 1'b 0;
    assign i_prbs_error_lane3_d             = 1'b 0;
    assign i_loss_of_sync_lane3_d           = 2'b 0;
    assign i_rx_low_voltage_lane3_d         = 1'b 0;
    assign i_rx_buffer_status_lane_3_d      = 3'b 0;
    assign i_lane3_aligned_d                = 1'b 0;
 end
 endgenerate

 //--------------------------------------------------------------------
 // tie off unused GT instance signals
 //--------------------------------------------------------------------
 //--------------------------------------------------------------------
 generate if ( ( (pDEVICE_FAMILY == "virtex7") | (pDEVICE_FAMILY == "zynq") |
                 (pDEVICE_FAMILY == "virtexu") | (pDEVICE_FAMILY == "kintexu") | 
                 (pDEVICE_FAMILY == "kintex7") | (pDEVICE_FAMILY == "artix7" ) | 
		 ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & (pLANE_COUNT == 1) )
 begin
    assign i_lnk_rx_lane1_data_d            = 32'b 0;
    assign i_lnk_rx_lane1_kchar_d           = 4'b 0;
    assign i_lnk_rx_lane1_disparity_error_d = 4'b 0;
    assign i_pll_lock_detect_tile_01        = 1'b 1;
    assign i_reset_done_tile_0[1]           = 1'b 1;
    assign i_drp_ready01                    = 1'b 1;
    assign i_lnk_rx_lane1_symbol_error_d    = 4'b 0;
    assign i_lane1_symbol_locked_d          = 1'b 0;
    assign i_prbs_error_lane1_d             = 1'b 0;
    assign i_loss_of_sync_lane1_d           = 2'b 0;
    assign i_rx_low_voltage_lane1_d         = 1'b 0;
    assign i_rx_buffer_status_lane_1_d      = 3'b 0;
    assign i_lane1_aligned_d                = 1'b 0;
 end
 endgenerate


endmodule  // displayport_v8_1_2_rx_phy
