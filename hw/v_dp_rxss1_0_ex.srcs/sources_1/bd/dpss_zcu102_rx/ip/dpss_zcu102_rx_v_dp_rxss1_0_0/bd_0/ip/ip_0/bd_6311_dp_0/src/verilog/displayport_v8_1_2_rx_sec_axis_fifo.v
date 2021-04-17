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

module displayport_v8_1_2_rx_sec_axis_fifo 
#(
   parameter C_FAMILY = "spartan6"
 )
    (
   input m_aclk, 
   input s_aclk, 
   input s_aresetn,
   input s_axis_tvalid,
   output s_axis_tready,
   input [31:0] s_axis_tdata,
   input [7:0] s_axis_tid,
   output m_axis_tvalid,
   input m_axis_tready,
   output [31:0] m_axis_tdata,
   output [7:0] m_axis_tid,
   output axis_overflow,
   output axis_underflow
	);

// coverage off
//bd_6311_dp_0_sec_axis_fifo_inst fifo_gen_inst (
xpm_fifo_axis #(
  .CLOCKING_MODE          ("independent_clock")         ,
  .FIFO_MEMORY_TYPE       ("distributed")               ,
  .FIFO_DEPTH             (32)                          ,
  .TDATA_WIDTH            (32)                          ,
  .TID_WIDTH              (8)                           ,
  .TUSER_WIDTH            (1)                           , 
  .USE_ADV_FEATURES       ("1F1F")      
)
fifo_gen_inst (
  .s_aresetn           (s_aresetn)          ,
  .s_aclk              (s_aclk)             ,
  .m_aclk              (m_aclk)             ,
  .s_axis_tvalid       (s_axis_tvalid)      ,
  .s_axis_tready       (s_axis_tready)      ,
  .s_axis_tdata        (s_axis_tdata)       ,
  .s_axis_tstrb        (4'hF)               ,
  .s_axis_tkeep        (4'hF)               ,
  .s_axis_tlast        (1'b0)               ,
  .s_axis_tid          (s_axis_tid)         ,
  .s_axis_tdest        (1'b0)               ,
  .s_axis_tuser        (1'b0)               ,
  .m_axis_tvalid       (m_axis_tvalid)      ,
  .m_axis_tready       (m_axis_tready)      ,
  .m_axis_tdata        (m_axis_tdata)       ,
  .m_axis_tstrb        ()                   ,
  .m_axis_tkeep        ()                   ,
  .m_axis_tlast        ()                   ,
  .m_axis_tid          (m_axis_tid)         ,
  .m_axis_tdest        ()    ,
  .m_axis_tuser        ()    ,
  .prog_full_axis      ()    ,
  .wr_data_count_axis  ()    ,
  .almost_full_axis    ()    ,
  .prog_empty_axis     ()    ,
  .rd_data_count_axis  ()    ,
  .almost_empty_axis   ()    ,
  .injectsbiterr_axis  (1'b0)               ,
  .injectdbiterr_axis  (1'b0)               ,
  .sbiterr_axis        ()                   ,
  .dbiterr_axis        ()     
);

// coverage on
endmodule

