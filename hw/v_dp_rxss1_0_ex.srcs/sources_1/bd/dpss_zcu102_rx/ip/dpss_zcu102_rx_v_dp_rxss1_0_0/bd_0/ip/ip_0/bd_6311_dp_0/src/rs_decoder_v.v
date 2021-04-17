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


`timescale 1ns/1ps


module rs_decoder_v
    (
    input aclk,                         // input aclk
    input aclken,                       // input aclken
    input aresetn,                      // input aresetn
    input [7:0] s_axis_input_tdata,     // input [7 : 0] s_axis_input_tdata
    input s_axis_input_tvalid,          // input s_axis_input_tvalid
    input s_axis_input_tlast,           // input s_axis_input_tlast
    input s_axis_input_tuser,           // input s_axis_input_tuser
    output s_axis_input_tready,         // output s_axis_input_tready
    output [15:0] m_axis_output_tdata,  // output [7 : 0] m_axis_output_tdata
    output m_axis_output_tvalid,        // output m_axis_output_tvalid
    input  m_axis_output_tready,        // input m_axis_output_tready
    output m_axis_output_tuser,         // input m_axis_output_tready
    output m_axis_output_tlast,         // output m_axis_output_tlast
    output [15:0] m_axis_stat_tdata,    // output [15 : 0] m_axis_stat_tdata
    output m_axis_stat_tvalid,          // output m_axis_stat_tvalid
    output m_axis_stat_tlast,           // output m_axis_stat_tlast
    input m_axis_stat_tready,           // input m_axis_stat_tready
    output event_s_input_tlast_missing,    // output event_s_input_tlast_missing
    output event_s_input_tlast_unexpected, // output event_s_input_tlast_unexpected
    output event_s_ctrl_tdata_invalid      // output event_s_ctrl_tdata_invalid
    );



  bd_6311_dp_0_rs_decoder_v9_0_17_viv 
         rs_decoder_inst (
          .aclk(aclk),                                 // input aclk
          .aclken(aclken),                             // input aclken
	  .aresetn(aresetn),                           // input aresetn 
          .s_axis_input_tdata(s_axis_input_tdata),     // input [7 : 0] s_axis_input_tdata
          .s_axis_input_tvalid(s_axis_input_tvalid),   // input s_axis_input_tvalid
          .s_axis_input_tlast(s_axis_input_tlast),     // input s_axis_input_tlast
          .s_axis_input_tuser(s_axis_input_tuser),     // input s_axis_input_tlast
          .s_axis_input_tready(s_axis_input_tready),   // output s_axis_input_tready
          .m_axis_output_tdata(m_axis_output_tdata),   // output [15 : 0] m_axis_output_tdata
          .m_axis_output_tvalid(m_axis_output_tvalid), // output m_axis_output_tvalid
          .m_axis_output_tready(m_axis_output_tready), // input m_axis_output_tready
          .m_axis_output_tuser(m_axis_output_tuser),   // output m_axis_output_tuser
          .m_axis_output_tlast(m_axis_output_tlast),   // output m_axis_output_tlast
          .m_axis_stat_tdata(m_axis_stat_tdata),       // output [15 : 0] m_axis_stat_tdata
          .m_axis_stat_tvalid(m_axis_stat_tvalid),     // output m_axis_stat_tvalid
          .m_axis_stat_tlast(m_axis_stat_tlast),       // output m_axis_stat_tlast
          .m_axis_stat_tready(m_axis_stat_tready),     // input m_axis_stat_tready
          .event_s_input_tlast_missing(event_s_input_tlast_missing),       // output event_s_input_tlast_missing
          .event_s_input_tlast_unexpected(event_s_input_tlast_unexpected), // output event_s_input_tlast_unexpected
          .event_s_ctrl_tdata_invalid(event_s_ctrl_tdata_invalid)          // output event_s_ctrl_tdata_invalid
        );


endmodule
