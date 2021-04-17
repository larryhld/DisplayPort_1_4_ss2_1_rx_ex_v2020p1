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

module displayport_v8_1_2_rx_vid_fifo 
#(
  parameter C_DIN_WIDTH  = 48,
  parameter C_DOUT_WIDTH = 48,
  parameter C_DEPTH      = 64,
  parameter C_PTR_WIDTH  = 6,
  parameter C_FAMILY     = "spartan6"
 )
 (
    input rst,
    input wr_clk,
    input rd_clk,
    input [C_DIN_WIDTH-1:0] din,
    input wr_en,
    input rd_en,
    output [C_DOUT_WIDTH-1:0] dout,
    output full,
    output overflow,
    output empty,
    output almost_empty
  );

// coverage off
//bd_6311_dp_0_rx_vid_fifo_inst fifo_gen_inst (
xpm_fifo_async #(
  .CDC_SYNC_STAGES      (3)                ,
  .FIFO_MEMORY_TYPE     ("distributed")    ,
  .FIFO_WRITE_DEPTH     (64)               ,
  .WRITE_DATA_WIDTH     (C_DIN_WIDTH)      ,
  .FULL_RESET_VALUE     (1)                ,
  .READ_MODE            ("fwft")           ,
  .FIFO_READ_LATENCY    (0)                ,
  .READ_DATA_WIDTH      (C_DIN_WIDTH)      , 
  .USE_ADV_FEATURES     ("1F1F")      
)
fifo_gen_inst (
  .sleep            (1'b0)     ,
  .rst              (rst)      ,
  .wr_clk           (wr_clk)   ,
  .wr_en            (wr_en)    ,
  .din              (din)      ,
  .full             (full)     ,
  .prog_full        ()         ,
  .wr_data_count    ()         ,
  .overflow         (overflow) ,
  .wr_rst_busy      ()         ,
  .almost_full      ()         ,
  .wr_ack           ()         ,
  .rd_clk           (rd_clk)   ,
  .rd_en            (rd_en)    ,
  .dout             (dout)     ,
  .empty            (empty)    ,
  .prog_empty       ()         ,
  .rd_data_count    ()         ,
  .underflow        ()         ,
  .rd_rst_busy      ()         ,
  .almost_empty     (almost_empty) ,
  .data_valid       ()         ,
  .injectsbiterr    (1'b0)     ,
  .injectdbiterr    (1'b0)     ,
  .sbiterr          ()         ,
  .dbiterr          ()         
);
// coverage on

endmodule
