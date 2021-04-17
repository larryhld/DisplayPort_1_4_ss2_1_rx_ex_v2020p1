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

module displayport_v8_1_2_rx_sec_pkt_fifo 
#(
  parameter C_FAMILY = "spartan6",
  parameter C_DEPTH = 256,
  parameter C_PNTR_WIDTH = 8
 )
   (
    input clk,
    input srst,
    input [64:0] din,
    input wr_en,
    input rd_en,
    output [64:0] dout,
    output full,
    output prog_full,
    output almost_full,
    output overflow,
    output underflow,
    output empty,
    output almost_empty,
    output valid
  );

// coverage off
//bd_6311_dp_0_rx_sec_pkt_fifo_inst fifo_gen_inst (
xpm_fifo_sync #(
  .FIFO_MEMORY_TYPE     ("distributed") , 
  .FIFO_WRITE_DEPTH     (C_DEPTH)       , 
  .WRITE_DATA_WIDTH     (65)            ,
  .FULL_RESET_VALUE     (0)             ,
  .FIFO_READ_LATENCY    (1)             ,
  .PROG_FULL_THRESH     (3)             , 
  .READ_DATA_WIDTH      (65)            , 
  .USE_ADV_FEATURES     ("1F1F")      
)
fifo_gen_inst (

  .sleep          (1'b0      )   ,
  .rst            (srst      )   ,
  .wr_clk         (clk       )   ,
  .wr_en          (wr_en     )   ,    
  .din            (din       )   ,
  .full           (full      )   ,
  .prog_full      (prog_full )   ,
  .wr_data_count  (          )   ,
  .overflow       (overflow  )   ,
  .wr_rst_busy    (          )   ,
  .almost_full    (almost_full)  ,
  .wr_ack         (          )   ,
  .rd_en          (rd_en     )   ,
  .dout           (dout      )   ,
  .empty          (empty     )   ,
  .prog_empty     (          )   ,
  .rd_data_count  (          )   ,
  .underflow      (underflow )   ,
  .rd_rst_busy    (          )   ,
  .almost_empty   (almost_empty) ,
  .data_valid     (valid     )   ,
  .injectsbiterr  (1'b0      )   ,
  .injectdbiterr  (1'b0      )   ,
  .sbiterr        (          )   ,
  .dbiterr        (          )       
);
// coverage on

endmodule
