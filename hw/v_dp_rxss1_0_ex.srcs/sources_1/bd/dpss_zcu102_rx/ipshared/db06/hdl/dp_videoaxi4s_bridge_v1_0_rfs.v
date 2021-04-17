`timescale 1ns / 1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module dp_videoaxi4s_bridge_v1_0_1
#(
    parameter   C_MAX_BPC = 8,                    // maximum bits per color supported
    parameter   C_M_AXIS_VIDEO_TDATA_WIDTH  = 96, // 4 * (3*C_MAX_BPC) and multiple of 8
    parameter   C_PPC = 4,
    parameter   C_FAMILY =  "kintex7",
    parameter   C_UG934_COMPLIANCE = 0,
    parameter   C_ENABLE_DSC = 0,
    parameter   C_ENABLE_DSC_DUMMY_BYTES_IN_RX = 0
)
(
  input  wire  [15:0]      dp_hres,
  input  wire  [2:0]       pixel_mode,
  input  wire  [2:0]       bpc,
  input  wire  [2:0]       color_format,

  // I/O declarations
  input  wire                  vid_pixel_clk,     // video pixel clock
  input  wire                  vid_reset,  
  input  wire                  vid_active_video,   // video data enable
  input  wire  [11:0]          vid_valid_per_pixel,   
  input  wire                  vid_last,   
  input  wire                  vid_vsync ,        // video vert. sync
  input  wire                  vid_hsync ,        // video horiz. sync
  input  wire  [47:0]          vid_pixel0,        // Video Data
  input  wire  [47:0]          vid_pixel1,        // Video Data 
  input  wire  [47:0]          vid_pixel2,        // Video Data
  input  wire  [47:0]          vid_pixel3,        // Video Data
  input  wire                  enable_dsc,  
  input  wire  [2:0]           num_active_lanes,

  // AXI4-streaming interface
  input  wire                                      m_axis_aclk,     // axi4_M clock
  output  wire [C_M_AXIS_VIDEO_TDATA_WIDTH-1:0]    m_axis_video_tdata , // axi-4 M data
  output  wire                                     m_axis_video_tvalid, // axi-4 M valid 
  input   wire                                     m_axis_video_tready, // axi-4 M ready 
  output  wire                                     m_axis_video_tlast , // axi-4 M end of line
  output  wire [13*C_ENABLE_DSC : 0]                m_axis_video_tuser , // axi-4 M end of line

  // Video Timing Detector interface
  output wire                    vtd_active_video, // active video (DE)
  output wire                    vtd_vsync,        // vert. sync
  output wire                    vtd_hsync,        // horiz. sync 
  // Processor Interface Flags
  output wire                   wr_error,         // FIFO write error (write when full)
  output wire                   rd_error,         // FIFO read when empty  
  output wire [15:0]            hres_cntr_out, 
  output wire [15:0]            vres_cntr_out, 
  output wire [4:0]             debug_port,
  output wire [205:0]           dsc_debug_bus_bridge
   
);

wire [13:0] m_axis_video_tuser_int;

// Bridge instantiation
generate if(C_ENABLE_DSC == 1)
begin: gen_enable_dsc_bridge_sub
  assign m_axis_video_tuser = m_axis_video_tuser_int[13:0];
  dp_videoaxi4s_bridge_v1_0_1_sub 
  #(
       .pMAX_BPC (C_MAX_BPC    ),
       .pDW      (C_M_AXIS_VIDEO_TDATA_WIDTH ),
       .pPC      (C_PPC),
       .pFAMILY  (C_FAMILY),
       .pUG934_COMPLIANCE  (C_UG934_COMPLIANCE),
       .pENABLE_DSC        (C_ENABLE_DSC),
       .pENABLE_DSC_DUMMY_BYTES_IN_RX (C_ENABLE_DSC_DUMMY_BYTES_IN_RX)
  ) dp_videoaxi4s_bridge_v1_0_1_sub_inst 
  (
       .dp_hres             (dp_hres),
       .pixel_mode          (pixel_mode),
       .bpc_in              (bpc),
       .color_format        (color_format),
       .reset_n             (~vid_reset),  
       .vid_pixel_clk       (vid_pixel_clk   ),
       .vid_hsync           (vid_hsync       ), 
       .vid_vsync           (vid_vsync       ),   
       .vid_de              (vid_active_video),   
       .vid_valid_per_pixel (vid_valid_per_pixel),   
       .vid_last            (vid_last),   
       .dp_vid_pixel0       (vid_pixel0      ),
       .dp_vid_pixel1       (vid_pixel1      ),
       .dp_vid_pixel2       (vid_pixel2      ),
       .dp_vid_pixel3       (vid_pixel3      ),
       .m_axis_aclk         (m_axis_aclk     ),
       .m_axis_tdata        (m_axis_video_tdata),
       .m_axis_tkeep        (),
       .m_axis_tlast        (m_axis_video_tlast),
       .m_axis_tready       (m_axis_video_tready),
       .m_axis_tvalid       (m_axis_video_tvalid),
       .m_axis_tuser        (m_axis_video_tuser_int),
       .wr_error            (wr_error),
       .rd_error            (rd_error),
       .hres_cntr_out       (hres_cntr_out),
       .vres_cntr_out       (vres_cntr_out),
       .enable_dsc          (enable_dsc),
       .num_active_lanes    (num_active_lanes),
       .debug_port          (debug_port),
       .dsc_debug_bus_bridge(/*dsc_debug_bus_bridge*/)
  );
   assign          dsc_debug_bus_bridge   = 0;
end
else
begin: gen_disable_dsc_bridge_sub
  assign m_axis_video_tuser = m_axis_video_tuser_int[0];
  dp_videoaxi4s_bridge_v1_0_1_sub 
  #(
       .pMAX_BPC (C_MAX_BPC    ),
       .pDW      (C_M_AXIS_VIDEO_TDATA_WIDTH ),
       .pPC      (C_PPC),
       .pFAMILY  (C_FAMILY),
       .pUG934_COMPLIANCE  (C_UG934_COMPLIANCE),
       .pENABLE_DSC        (C_ENABLE_DSC),
       .pENABLE_DSC_DUMMY_BYTES_IN_RX (C_ENABLE_DSC_DUMMY_BYTES_IN_RX)
  ) dp_videoaxi4s_bridge_v1_0_1_sub_inst 
  (
       .dp_hres             (dp_hres),
       .pixel_mode          (pixel_mode),
       .bpc_in              (bpc),
       .color_format        (color_format),
       .reset_n             (~vid_reset),  
       .vid_pixel_clk       (vid_pixel_clk   ),
       .vid_hsync           (vid_hsync       ), 
       .vid_vsync           (vid_vsync       ),   
       .vid_de              (vid_active_video),   
       .vid_valid_per_pixel (12'b111111111111),   
       .vid_last            (1'b0            ),   
       .dp_vid_pixel0       (vid_pixel0      ),
       .dp_vid_pixel1       (vid_pixel1      ),
       .dp_vid_pixel2       (vid_pixel2      ),
       .dp_vid_pixel3       (vid_pixel3      ),
       .m_axis_aclk         (m_axis_aclk     ),
       .m_axis_tdata        (m_axis_video_tdata),
       .m_axis_tkeep        (),
       .m_axis_tlast        (m_axis_video_tlast),
       .m_axis_tready       (m_axis_video_tready),
       .m_axis_tvalid       (m_axis_video_tvalid),
       .m_axis_tuser        (m_axis_video_tuser_int),
       .wr_error            (wr_error),
       .rd_error            (rd_error),
       .hres_cntr_out       (hres_cntr_out),
       .vres_cntr_out       (vres_cntr_out),
       .enable_dsc          (1'b0),
       .num_active_lanes    (num_active_lanes),
       .debug_port          (debug_port),
       .dsc_debug_bus_bridge()
  );
   assign          dsc_debug_bus_bridge   = 0;
end
endgenerate
endmodule


/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used solely      *
*     for design, simulation, implementation and creation of design files      *
*     limited to Xilinx devices or technologies. Use with non-Xilinx           *
*     devices or technologies is expressly prohibited and immediately          *
*     terminates your license.                                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY     *
*     FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY     *
*     PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE              *
*     IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS       *
*     MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY       *
*     CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY        *
*     RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY        *
*     DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE    *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A    *
*     PARTICULAR PURPOSE.                                                      *
*                                                                              *
*     Xilinx products are not intended for use in life support appliances,     *
*     devices, or systems.  Use in such applications are expressly             *
*     prohibited.                                                              *
*                                                                              *
*     (c) Copyright 1995-2018 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/

// The synthesis directives "translate_off/translate_on" specified below are
// supported by Xilinx, Mentor Graphics and Synplicity synthesis
// tools. Ensure they are correct for your synthesis tool(s).

`timescale 1ns/1ps

module dp_videoaxi4s_bridge_v1_0_1_axis
#(
 parameter FIFO_WIDTH = 128,
 parameter FAMILY = "kintex7"
)
(
  input s_aclk,
  input s_aresetn,
  input s_axis_tvalid,
  output s_axis_tready,
  input [FIFO_WIDTH-1 : 0] s_axis_tdata,
  input [13 : 0] s_axis_tuser,
  input s_axis_tlast,
  input m_aclk,
  output m_axis_tvalid,
  input m_axis_tready,
  output [FIFO_WIDTH-1 : 0] m_axis_tdata,
  output [13 : 0] m_axis_tuser,
  output m_axis_tlast,
  output [10:0] axis_data_count,
  output axis_overflow,
  output axis_underflow
);

localparam FIFO_WIDTH_AXIS = FIFO_WIDTH+1+14;

assign axis_data_count = 11'd0;
assign axis_overflow   = 1'b0;
assign axis_underflow  = 1'b0;

    xpm_fifo_axis #(
      .CLOCKING_MODE          ("independent_clock")         ,
      .FIFO_MEMORY_TYPE       ("distributed")               ,
      .FIFO_DEPTH             (1024)                        ,
      .TDATA_WIDTH            (FIFO_WIDTH)                  ,
      .TID_WIDTH              (8)                           ,
      .TUSER_WIDTH            (14)                          ,
      .USE_ADV_FEATURES       ("1F1F")      
    )
    fifo_gen_inst (
      .s_aresetn           (s_aresetn)          ,
      .s_aclk              (s_aclk)             ,
      .m_aclk              (m_aclk)             ,
      .s_axis_tvalid       (s_axis_tvalid)      ,
      .s_axis_tready       (s_axis_tready)      ,
      .s_axis_tdata        (s_axis_tdata)       ,
      .s_axis_tstrb        (16'hFFFF)           ,
      .s_axis_tkeep        (16'hFFFF)           ,
      .s_axis_tlast        (s_axis_tlast)       ,
      .s_axis_tid          (8'd0)               ,
      .s_axis_tdest        (1'b0)               ,
      .s_axis_tuser        (s_axis_tuser)       ,
      .m_axis_tvalid       (m_axis_tvalid)      ,
      .m_axis_tready       (m_axis_tready)      ,
      .m_axis_tdata        (m_axis_tdata)       ,
      .m_axis_tstrb        ()                   ,
      .m_axis_tkeep        ()                   ,
      .m_axis_tlast        (m_axis_tlast)       ,
      .m_axis_tid          ()                   ,
      .m_axis_tdest        ()                   ,
      .m_axis_tuser        (m_axis_tuser)       ,
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

  //fifo_generator_v13_2 #(
  //  .C_ADD_NGC_CONSTRAINT(0),
  //  .C_APPLICATION_TYPE_AXIS(0),
  //  .C_APPLICATION_TYPE_RACH(0),
  //  .C_APPLICATION_TYPE_RDCH(0),
  //  .C_APPLICATION_TYPE_WACH(0),
  //  .C_APPLICATION_TYPE_WDCH(0),
  //  .C_APPLICATION_TYPE_WRCH(0),
  //  .C_AXI_ADDR_WIDTH(32),
  //  .C_AXI_ARUSER_WIDTH(1),
  //  .C_AXI_AWUSER_WIDTH(1),
  //  .C_AXI_BUSER_WIDTH(1),
  //  .C_AXI_DATA_WIDTH(64),
  //  .C_AXI_ID_WIDTH(4),
  //  .C_AXI_RUSER_WIDTH(1),
  //  .C_AXI_TYPE(1),
  //  .C_AXI_WUSER_WIDTH(1),
  //  .C_AXIS_TDATA_WIDTH(FIFO_WIDTH),
  //  .C_AXIS_TDEST_WIDTH(4),
  //  .C_AXIS_TID_WIDTH(8),
  //  .C_AXIS_TKEEP_WIDTH(16),
  //  .C_AXIS_TSTRB_WIDTH(16),
  //  .C_AXIS_TUSER_WIDTH(14),
  //  .C_AXIS_TYPE(0),
  //  .C_COMMON_CLOCK(0),
  //  .C_COUNT_TYPE(0),
  //  .C_DATA_COUNT_WIDTH(10),
  //  .C_DEFAULT_VALUE("BlankString"),
  //  .C_DIN_WIDTH(18),
  //  .C_DIN_WIDTH_AXIS(FIFO_WIDTH_AXIS),
  //  .C_DIN_WIDTH_RACH(32),
  //  .C_DIN_WIDTH_RDCH(64),
  //  .C_DIN_WIDTH_WACH(32),
  //  .C_DIN_WIDTH_WDCH(64),
  //  .C_DIN_WIDTH_WRCH(2),
  //  .C_DOUT_RST_VAL("0"),
  //  .C_DOUT_WIDTH(18),
  //  .C_ENABLE_RLOCS(0),
  //  .C_ENABLE_RST_SYNC(1),
  //  .C_ERROR_INJECTION_TYPE(0),
  //  .C_ERROR_INJECTION_TYPE_AXIS(0),
  //  .C_ERROR_INJECTION_TYPE_RACH(0),
  //  .C_ERROR_INJECTION_TYPE_RDCH(0),
  //  .C_ERROR_INJECTION_TYPE_WACH(0),
  //  .C_ERROR_INJECTION_TYPE_WDCH(0),
  //  .C_ERROR_INJECTION_TYPE_WRCH(0),
  //  .C_FAMILY(FAMILY),
  //  .C_FULL_FLAGS_RST_VAL(1),
  //  .C_HAS_ALMOST_EMPTY(0),
  //  .C_HAS_ALMOST_FULL(0),
  //  .C_HAS_AXI_ARUSER(0),
  //  .C_HAS_AXI_AWUSER(0),
  //  .C_HAS_AXI_BUSER(0),
  //  .C_HAS_AXI_RD_CHANNEL(0),
  //  .C_HAS_AXI_RUSER(0),
  //  .C_HAS_AXI_WR_CHANNEL(0),
  //  .C_HAS_AXI_WUSER(0),
  //  .C_HAS_AXIS_TDATA(1),
  //  .C_HAS_AXIS_TDEST(0),
  //  .C_HAS_AXIS_TID(0),
  //  .C_HAS_AXIS_TKEEP(0),
  //  .C_HAS_AXIS_TLAST(1),
  //  .C_HAS_AXIS_TREADY(1),
  //  .C_HAS_AXIS_TSTRB(0),
  //  .C_HAS_AXIS_TUSER(1),
  //  .C_HAS_BACKUP(0),
  //  .C_HAS_DATA_COUNT(0),
  //  .C_HAS_DATA_COUNTS_AXIS(1),
  //  .C_HAS_DATA_COUNTS_RACH(0),
  //  .C_HAS_DATA_COUNTS_RDCH(0),
  //  .C_HAS_DATA_COUNTS_WACH(0),
  //  .C_HAS_DATA_COUNTS_WDCH(0),
  //  .C_HAS_DATA_COUNTS_WRCH(0),
  //  .C_HAS_INT_CLK(0),
  //  .C_HAS_MASTER_CE(0),
  //  .C_HAS_MEMINIT_FILE(0),
  //  .C_HAS_OVERFLOW(1),
  //  .C_HAS_PROG_FLAGS_AXIS(0),
  //  .C_HAS_PROG_FLAGS_RACH(0),
  //  .C_HAS_PROG_FLAGS_RDCH(0),
  //  .C_HAS_PROG_FLAGS_WACH(0),
  //  .C_HAS_PROG_FLAGS_WDCH(0),
  //  .C_HAS_PROG_FLAGS_WRCH(0),
  //  .C_HAS_RD_DATA_COUNT(0),
  //  .C_HAS_RD_RST(0),
  //  .C_HAS_RST(1),
  //  .C_HAS_SLAVE_CE(0),
  //  .C_HAS_SRST(0),
  //  .C_HAS_UNDERFLOW(1),
  //  .C_HAS_VALID(0),
  //  .C_HAS_WR_ACK(0),
  //  .C_HAS_WR_DATA_COUNT(0),
  //  .C_HAS_WR_RST(0),
  //  .C_IMPLEMENTATION_TYPE(0),
  //  .C_IMPLEMENTATION_TYPE_AXIS(11),
  //  .C_IMPLEMENTATION_TYPE_RACH(12),
  //  .C_IMPLEMENTATION_TYPE_RDCH(11),
  //  .C_IMPLEMENTATION_TYPE_WACH(12),
  //  .C_IMPLEMENTATION_TYPE_WDCH(11),
  //  .C_IMPLEMENTATION_TYPE_WRCH(12),
  //  .C_INIT_WR_PNTR_VAL(0),
  //  .C_INTERFACE_TYPE(1),
  //  .C_MEMORY_TYPE(1),
  //  .C_MIF_FILE_NAME("BlankString"),
  //  .C_MSGON_VAL(1),
  //  .C_OPTIMIZATION_MODE(0),
  //  .C_OVERFLOW_LOW(0),
  //  .C_PRELOAD_LATENCY(1),
  //  .C_PRELOAD_REGS(0),
  //  .C_PRIM_FIFO_TYPE("4kx4"),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL(2),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS(1022),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH(14),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH(1022),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH(14),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH(1022),
  //  .C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH(14),
  //  .C_PROG_EMPTY_THRESH_NEGATE_VAL(3),
  //  .C_PROG_EMPTY_TYPE(0),
  //  .C_PROG_EMPTY_TYPE_AXIS(5),
  //  .C_PROG_EMPTY_TYPE_RACH(5),
  //  .C_PROG_EMPTY_TYPE_RDCH(5),
  //  .C_PROG_EMPTY_TYPE_WACH(5),
  //  .C_PROG_EMPTY_TYPE_WDCH(5),
  //  .C_PROG_EMPTY_TYPE_WRCH(5),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL(1022),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_AXIS(1023),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_RACH(15),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_RDCH(1023),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_WACH(15),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_WDCH(1023),
  //  .C_PROG_FULL_THRESH_ASSERT_VAL_WRCH(15),
  //  .C_PROG_FULL_THRESH_NEGATE_VAL(1021),
  //  .C_PROG_FULL_TYPE(0),
  //  .C_PROG_FULL_TYPE_AXIS(5),
  //  .C_PROG_FULL_TYPE_RACH(5),
  //  .C_PROG_FULL_TYPE_RDCH(5),
  //  .C_PROG_FULL_TYPE_WACH(5),
  //  .C_PROG_FULL_TYPE_WDCH(5),
  //  .C_PROG_FULL_TYPE_WRCH(5),
  //  .C_RACH_TYPE(0),
  //  .C_RD_DATA_COUNT_WIDTH(10),
  //  .C_RD_DEPTH(1024),
  //  .C_RD_FREQ(1),
  //  .C_RD_PNTR_WIDTH(10),
  //  .C_RDCH_TYPE(0),
  //  .C_REG_SLICE_MODE_AXIS(0),
  //  .C_REG_SLICE_MODE_RACH(0),
  //  .C_REG_SLICE_MODE_RDCH(0),
  //  .C_REG_SLICE_MODE_WACH(0),
  //  .C_REG_SLICE_MODE_WDCH(0),
  //  .C_REG_SLICE_MODE_WRCH(0),
  //  .C_UNDERFLOW_LOW(0),
  //  .C_USE_COMMON_OVERFLOW(0),
  //  .C_USE_COMMON_UNDERFLOW(0),
  //  .C_USE_DEFAULT_SETTINGS(0),
  //  .C_USE_DOUT_RST(1),
  //  .C_USE_ECC(0),
  //  .C_USE_ECC_AXIS(0),
  //  .C_USE_ECC_RACH(0),
  //  .C_USE_ECC_RDCH(0),
  //  .C_USE_ECC_WACH(0),
  //  .C_USE_ECC_WDCH(0),
  //  .C_USE_ECC_WRCH(0),
  //  .C_USE_EMBEDDED_REG(0),
  //  .C_USE_FIFO16_FLAGS(0),
  //  .C_USE_FWFT_DATA_COUNT(0),
  //  .C_VALID_LOW(0),
  //  .C_WACH_TYPE(0),
  //  .C_WDCH_TYPE(0),
  //  .C_WR_ACK_LOW(0),
  //  .C_WR_DATA_COUNT_WIDTH(10),
  //  .C_WR_DEPTH(1024),
  //  .C_WR_DEPTH_AXIS(1024),
  //  .C_WR_DEPTH_RACH(16),
  //  .C_WR_DEPTH_RDCH(1024),
  //  .C_WR_DEPTH_WACH(16),
  //  .C_WR_DEPTH_WDCH(1024),
  //  .C_WR_DEPTH_WRCH(16),
  //  .C_WR_FREQ(1),
  //  .C_WR_PNTR_WIDTH(10),
  //  .C_WR_PNTR_WIDTH_AXIS(10),
  //  .C_WR_PNTR_WIDTH_RACH(4),
  //  .C_WR_PNTR_WIDTH_RDCH(10),
  //  .C_WR_PNTR_WIDTH_WACH(4),
  //  .C_WR_PNTR_WIDTH_WDCH(10),
  //  .C_WR_PNTR_WIDTH_WRCH(4),
  //  .C_WR_RESPONSE_LATENCY(1),
  //  .C_SYNCHRONIZER_STAGE(2),
  //  .C_WRCH_TYPE(0)
  //)
  //inst (
  //  .s_aclk(s_aclk),
  //  .s_aresetn(s_aresetn),
  //  .s_axis_tvalid(s_axis_tvalid),
  //  .s_axis_tready(s_axis_tready),
  //  .s_axis_tdata(s_axis_tdata),
  //  .s_axis_tlast(s_axis_tlast),
  //  .m_aclk(m_aclk),
  //  .m_axis_tvalid(m_axis_tvalid),
  //  .m_axis_tready(m_axis_tready),
  //  .m_axis_tdata(m_axis_tdata),
  //  .m_axis_tlast(m_axis_tlast),
  //  .axis_data_count(axis_data_count),
  //  .axis_overflow(axis_overflow),
  //  .axis_underflow(axis_underflow),
  //  .backup(),
  //  .backup_marker(),
  //  .clk(),
  //  .rst(),
  //  .srst(),
  //  .wr_clk(),
  //  .wr_rst(),
  //  .rd_clk(),
  //  .rd_rst(),
  //  .din(),
  //  .wr_en(),
  //  .rd_en(),
  //  .prog_empty_thresh(),
  //  .prog_empty_thresh_assert(),
  //  .prog_empty_thresh_negate(),
  //  .prog_full_thresh(),
  //  .prog_full_thresh_assert(),
  //  .prog_full_thresh_negate(),
  //  .int_clk(),
  //  .injectdbiterr(),
  //  .injectsbiterr(),
  //  .dout(),
  //  .full(),
  //  .almost_full(),
  //  .wr_ack(),
  //  .overflow(),
  //  .empty(),
  //  .almost_empty(),
  //  .valid(),
  //  .underflow(),
  //  .data_count(),
  //  .rd_data_count(),
  //  .wr_data_count(),
  //  .prog_full(),
  //  .prog_empty(),
  //  .sbiterr(),
  //  .dbiterr(),
  //  .m_aclk_en(),
  //  .s_aclk_en(),
  //  .s_axi_awid(),
  //  .s_axi_awaddr(),
  //  .s_axi_awlen(),
  //  .s_axi_awsize(),
  //  .s_axi_awburst(),
  //  .s_axi_awlock(),
  //  .s_axi_awcache(),
  //  .s_axi_awprot(),
  //  .s_axi_awqos(),
  //  .s_axi_awregion(),
  //  .s_axi_awuser(),
  //  .s_axi_awvalid(),
  //  .s_axi_awready(),
  //  .s_axi_wid(),
  //  .s_axi_wdata(),
  //  .s_axi_wstrb(),
  //  .s_axi_wlast(),
  //  .s_axi_wuser(),
  //  .s_axi_wvalid(),
  //  .s_axi_wready(),
  //  .s_axi_bid(),
  //  .s_axi_bresp(),
  //  .s_axi_buser(),
  //  .s_axi_bvalid(),
  //  .s_axi_bready(),
  //  .m_axi_awid(),
  //  .m_axi_awaddr(),
  //  .m_axi_awlen(),
  //  .m_axi_awsize(),
  //  .m_axi_awburst(),
  //  .m_axi_awlock(),
  //  .m_axi_awcache(),
  //  .m_axi_awprot(),
  //  .m_axi_awqos(),
  //  .m_axi_awregion(),
  //  .m_axi_awuser(),
  //  .m_axi_awvalid(),
  //  .m_axi_awready(),
  //  .m_axi_wid(),
  //  .m_axi_wdata(),
  //  .m_axi_wstrb(),
  //  .m_axi_wlast(),
  //  .m_axi_wuser(),
  //  .m_axi_wvalid(),
  //  .m_axi_wready(),
  //  .m_axi_bid(),
  //  .m_axi_bresp(),
  //  .m_axi_buser(),
  //  .m_axi_bvalid(),
  //  .m_axi_bready(),
  //  .s_axi_arid(),
  //  .s_axi_araddr(),
  //  .s_axi_arlen(),
  //  .s_axi_arsize(),
  //  .s_axi_arburst(),
  //  .s_axi_arlock(),
  //  .s_axi_arcache(),
  //  .s_axi_arprot(),
  //  .s_axi_arqos(),
  //  .s_axi_arregion(),
  //  .s_axi_aruser(),
  //  .s_axi_arvalid(),
  //  .s_axi_arready(),
  //  .s_axi_rid(),
  //  .s_axi_rdata(),
  //  .s_axi_rresp(),
  //  .s_axi_rlast(),
  //  .s_axi_ruser(),
  //  .s_axi_rvalid(),
  //  .s_axi_rready(),
  //  .m_axi_arid(),
  //  .m_axi_araddr(),
  //  .m_axi_arlen(),
  //  .m_axi_arsize(),
  //  .m_axi_arburst(),
  //  .m_axi_arlock(),
  //  .m_axi_arcache(),
  //  .m_axi_arprot(),
  //  .m_axi_arqos(),
  //  .m_axi_arregion(),
  //  .m_axi_aruser(),
  //  .m_axi_arvalid(),
  //  .m_axi_arready(),
  //  .m_axi_rid(),
  //  .m_axi_rdata(),
  //  .m_axi_rresp(),
  //  .m_axi_rlast(),
  //  .m_axi_ruser(),
  //  .m_axi_rvalid(),
  //  .m_axi_rready(),
  //  .s_axis_tstrb(),
  //  .s_axis_tkeep(),
  //  .s_axis_tid(),
  //  .s_axis_tdest(),
  //  .s_axis_tuser(s_axis_tuser),
  //  .m_axis_tstrb(),
  //  .m_axis_tkeep(),
  //  .m_axis_tid(),
  //  .m_axis_tdest(),
  //  .m_axis_tuser(m_axis_tuser),
  //  .axi_aw_injectsbiterr(),
  //  .axi_aw_injectdbiterr(),
  //  .axi_aw_prog_full_thresh(),
  //  .axi_aw_prog_empty_thresh(),
  //  .axi_aw_data_count(),
  //  .axi_aw_wr_data_count(),
  //  .axi_aw_rd_data_count(),
  //  .axi_aw_sbiterr(),
  //  .axi_aw_dbiterr(),
  //  .axi_aw_overflow(),
  //  .axi_aw_underflow(),
  //  .axi_w_injectsbiterr(),
  //  .axi_w_injectdbiterr(),
  //  .axi_w_prog_full_thresh(),
  //  .axi_w_prog_empty_thresh(),
  //  .axi_w_data_count(),
  //  .axi_w_wr_data_count(),
  //  .axi_w_rd_data_count(),
  //  .axi_w_sbiterr(),
  //  .axi_w_dbiterr(),
  //  .axi_w_overflow(),
  //  .axi_w_underflow(),
  //  .axi_b_injectsbiterr(),
  //  .axi_b_injectdbiterr(),
  //  .axi_b_prog_full_thresh(),
  //  .axi_b_prog_empty_thresh(),
  //  .axi_b_data_count(),
  //  .axi_b_wr_data_count(),
  //  .axi_b_rd_data_count(),
  //  .axi_b_sbiterr(),
  //  .axi_b_dbiterr(),
  //  .axi_b_overflow(),
  //  .axi_b_underflow(),
  //  .axi_ar_injectsbiterr(),
  //  .axi_ar_injectdbiterr(),
  //  .axi_ar_prog_full_thresh(),
  //  .axi_ar_prog_empty_thresh(),
  //  .axi_ar_data_count(),
  //  .axi_ar_wr_data_count(),
  //  .axi_ar_rd_data_count(),
  //  .axi_ar_sbiterr(),
  //  .axi_ar_dbiterr(),
  //  .axi_ar_overflow(),
  //  .axi_ar_underflow(),
  //  .axi_r_injectsbiterr(),
  //  .axi_r_injectdbiterr(),
  //  .axi_r_prog_full_thresh(),
  //  .axi_r_prog_empty_thresh(),
  //  .axi_r_data_count(),
  //  .axi_r_wr_data_count(),
  //  .axi_r_rd_data_count(),
  //  .axi_r_sbiterr(),
  //  .axi_r_dbiterr(),
  //  .axi_r_overflow(),
  //  .axi_r_underflow(),
  //  .axis_injectsbiterr(),
  //  .axis_injectdbiterr(),
  //  .axis_prog_full_thresh(),
  //  .axis_prog_empty_thresh(),
  //  .axis_wr_data_count(),
  //  .axis_rd_data_count(),
  //  .axis_sbiterr(),
  //  .axis_dbiterr()
  //);

endmodule


`timescale 1ns / 1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module dp_videoaxi4s_bridge_v1_0_1_sub
#(
    parameter   pMAX_BPC = 8, // maximum bits per color supported
    parameter   pDW  = 96,   // 4 * (3*pMAX_BPC) and multiple of 8
    parameter   pPC  = 4,
    parameter   pFAMILY = "kintex7",
    parameter   pUG934_COMPLIANCE = 0,
    parameter   pENABLE_DSC = 0,
    parameter   pENABLE_DSC_DUMMY_BYTES_IN_RX = 0
)
(
input  wire  [15:0]      dp_hres,
input  wire  [2:0]       pixel_mode,
input  wire  [2:0]       bpc_in,
input  wire  [2:0]       color_format,

input  wire              reset_n,  
input  wire              vid_pixel_clk,

input  wire              vid_hsync, 
input  wire              vid_vsync,   
input  wire              vid_de,   
input  wire  [11:0]      vid_valid_per_pixel,   
input  wire              vid_last,   
input  wire  [47:0]      dp_vid_pixel0,
input  wire  [47:0]      dp_vid_pixel1,
input  wire  [47:0]      dp_vid_pixel2,
input  wire  [47:0]      dp_vid_pixel3,
input  wire              enable_dsc,
input  wire  [2:0]       num_active_lanes,

input  wire              m_axis_aclk,
output wire  [pDW-1: 0]  m_axis_tdata,
output reg   [pDW/8-1:0] m_axis_tkeep,
output wire  [13:0]      m_axis_tuser,
output wire              m_axis_tlast,
input  wire              m_axis_tready,
output wire              m_axis_tvalid,

output wire              wr_error,
output wire              rd_error,
output wire  [15:0]      hres_cntr_out,
output reg   [15:0]      vres_cntr_out,
output wire  [4:0]       debug_port,
output wire  [205:0]     dsc_debug_bus_bridge
);

localparam FIFO_BUS_WIDTH = (pMAX_BPC<12)? 128 : 192;
localparam FIFO_BUS_WIDTH_RESIDUE = FIFO_BUS_WIDTH - (pDW);
localparam DSC_READ_BYTES = (pPC == 4) ? 12 : ((pPC == 2) ? 6 : 3);

//Internal Signals
wire [FIFO_BUS_WIDTH-1: 0] s_axis_tdata_fifo_in;
wire [FIFO_BUS_WIDTH-1: 0] m_axis_tdata_fifo_out;
reg [31:0] eol_eol_count;
reg [31:0] sof_sof_count;

wire [15:0]     hres = dp_hres[15:0];

reg             s_axis_tvalid_i;
wire            s_axis_tready_i;
reg  [pDW-1: 0] s_axis_tdata_i;
wire [13: 0]    s_axis_tuser_i;
wire            s_axis_tlast_i_w;
wire            s_axis_tlast_i;
reg             s_axis_tlast_i_q;
reg             s_axis_tlast_i_qq;
wire            m_axis_tvalid_i;
wire [pDW-1: 0] m_axis_tdata_i;
wire [13: 0]    m_axis_tuser_i;
wire            m_axis_tlast_i;

wire [FIFO_BUS_WIDTH_RESIDUE-1:0]     zeroes = 'h0;
wire            axis_overflow_i;
wire            axis_underflow_i;
reg  [15:0]     hres_cntr;
reg             vid_vsync_q;
reg             vid_hsync_q;
reg             vid_vsync_starts;
wire            vid_hsync_re;
wire            vid_hsync_fe;
wire            vid_vsync_re;
wire            vid_vsync_fe;
reg             vid_de_q;
reg             sof;
reg             y_only;
reg             ycrcb_422;
wire [4:0]      bpc;

reg [47:0] vid_pixel0;
reg [47:0] vid_pixel1;
reg [47:0] vid_pixel2;
reg [47:0] vid_pixel3;

reg [47:0] vid_pixel0_dsc;
reg [47:0] vid_pixel1_dsc;
reg [47:0] vid_pixel2_dsc;
reg [47:0] vid_pixel3_dsc;


reg [11:0] vid_valid_per_pixel_r;
//reg [3:0]  s_axis_tkeep_dsc_int;
wire[11:0] s_axis_tkeep_dsc;
wire dsc_last_from_fifo;
wire dsc_valid_from_fifo;
wire dsc_sof_from_fifo;
wire sof_int;
wire [11:0] dsc_tkeep_from_fifo;
wire [((DSC_READ_BYTES*8)+(DSC_READ_BYTES*2))-1:0]    dsc_data_from_fifo;
wire [23:0] vid_pixel0_dsc_fifo;
wire [23:0] vid_pixel1_dsc_fifo;
wire [23:0] vid_pixel2_dsc_fifo;
wire [23:0] vid_pixel3_dsc_fifo;
wire [5:0]  rd_wr_diff;


assign  dsc_debug_bus_bridge[191:0]    =   s_axis_tdata_fifo_in;
assign  dsc_debug_bus_bridge[205:192]  =   s_axis_tuser_i;

wire   auto_clear = reset_n;
assign s_axis_tdata_fifo_in  = {zeroes, s_axis_tdata_i};
assign m_axis_tdata_i        = m_axis_tdata_fifo_out[pDW-1:0];

// Y-only, YCBCR check
always @ ( color_format ) begin
  if(color_format == 3'b100) begin
    y_only    = 1'b1;
    ycrcb_422 = 1'b0;
  end
  else if(color_format == 3'b001) begin
    y_only    = 1'b0;
    ycrcb_422 = 1'b1;
  end
  else begin
    y_only    = 1'b0;
    ycrcb_422 = 1'b0;
  end
end //always

assign bpc = {y_only,ycrcb_422,bpc_in};

// Native video Pixel extraction - DP Output - RGB; AXI4S - RBG
// MSB alligned

generate if (pMAX_BPC == 6) begin
    always @ (y_only or ycrcb_422 or dp_vid_pixel0 or dp_vid_pixel1 or dp_vid_pixel2 or dp_vid_pixel3 ) begin
      if(ycrcb_422 == 1'b1) begin
        vid_pixel0 = {dp_vid_pixel0[47:42], dp_vid_pixel0[31:26], dp_vid_pixel0[15:10], 30'b0};
        vid_pixel1 = {dp_vid_pixel1[47:42], dp_vid_pixel1[31:26], dp_vid_pixel1[15:10], 30'b0};
        vid_pixel2 = {dp_vid_pixel2[47:42], dp_vid_pixel2[31:26], dp_vid_pixel2[15:10], 30'b0};
        vid_pixel3 = {dp_vid_pixel3[47:42], dp_vid_pixel3[31:26], dp_vid_pixel3[15:10], 30'b0};
      end else if(y_only == 1'b1) begin
        vid_pixel0 = {dp_vid_pixel0[47:42], 6'd0, 6'd0, 30'b0};
        vid_pixel1 = {dp_vid_pixel1[47:42], 6'd0, 6'd0, 30'b0};
        vid_pixel2 = {dp_vid_pixel2[47:42], 6'd0, 6'd0, 30'b0};
        vid_pixel3 = {dp_vid_pixel3[47:42], 6'd0, 6'd0, 30'b0};
      end else begin
        vid_pixel0 = {dp_vid_pixel0[47:42], dp_vid_pixel0[15:10], dp_vid_pixel0[31:26], 30'b0};
        vid_pixel1 = {dp_vid_pixel1[47:42], dp_vid_pixel1[15:10], dp_vid_pixel1[31:26], 30'b0};
        vid_pixel2 = {dp_vid_pixel2[47:42], dp_vid_pixel2[15:10], dp_vid_pixel2[31:26], 30'b0};
        vid_pixel3 = {dp_vid_pixel3[47:42], dp_vid_pixel3[15:10], dp_vid_pixel3[31:26], 30'b0};
      end
    end //always
end else if (pMAX_BPC == 8) begin
    always @ ( bpc or dp_vid_pixel0 or dp_vid_pixel1 or dp_vid_pixel2 or dp_vid_pixel3 ) begin
      case ( bpc )
        5'b 00001: vid_pixel0 = {dp_vid_pixel0[47:40], dp_vid_pixel0[15:8 ], dp_vid_pixel0[31:24], 24'b0};
        5'b 01001: vid_pixel0 = {dp_vid_pixel0[47:40], dp_vid_pixel0[31:24 ], dp_vid_pixel0[15:8], 24'b0};
        5'b 10001: vid_pixel0 = {dp_vid_pixel0[47:40], 8'd0, 8'd0, 24'b0};
        5'b 01000: vid_pixel0 = {dp_vid_pixel0[47:42],2'b0, dp_vid_pixel0[31:26], 2'b0, dp_vid_pixel0[15:10],2'b0, 24'b0};
        5'b 10000: vid_pixel0 = {dp_vid_pixel0[47:42],2'b0, 6'd0, 2'b0, 6'd0,2'b0, 24'b0};
        default: vid_pixel0 = {dp_vid_pixel0[47:42],2'b0, dp_vid_pixel0[15:10], 2'b0, dp_vid_pixel0[31:26],2'b0, 24'b0};
      endcase
      case ( bpc )
        5'b 00001: vid_pixel1 = {dp_vid_pixel1[47:40], dp_vid_pixel1[15:8 ], dp_vid_pixel1[31:24], 24'b0};
        5'b 01001: vid_pixel1 = {dp_vid_pixel1[47:40], dp_vid_pixel1[31:24 ], dp_vid_pixel1[15:8], 24'b0};
        5'b 10001: vid_pixel1 = {dp_vid_pixel1[47:40], 8'b0, 8'b0, 24'b0};
        5'b 01000: vid_pixel1 = {dp_vid_pixel1[47:42], 2'b0, dp_vid_pixel1[31:26], 2'b0, dp_vid_pixel1[15:10],2'b0, 24'b0}; 
        5'b 10000: vid_pixel1 = {dp_vid_pixel1[47:42], 2'b0, 6'd0, 2'b0, 6'd0,2'b0, 24'b0}; 
        default: vid_pixel1 = {dp_vid_pixel1[47:42], 2'b0, dp_vid_pixel1[15:10], 2'b0, dp_vid_pixel1[31:26],2'b0, 24'b0}; 
      endcase
      case ( bpc )
        5'b 00001: vid_pixel2 = {dp_vid_pixel2[47:40], dp_vid_pixel2[15:8 ], dp_vid_pixel2[31:24], 24'b0};
        5'b 01001: vid_pixel2 = {dp_vid_pixel2[47:40], dp_vid_pixel2[31:24 ], dp_vid_pixel2[15:8], 24'b0};
        5'b 10001: vid_pixel2 = {dp_vid_pixel2[47:40], 8'd0, 8'd0, 24'b0};
        5'b 01000: vid_pixel2 = {dp_vid_pixel2[47:42], 2'b0, dp_vid_pixel2[31:26], 2'b0, dp_vid_pixel2[15:10],2'b0, 24'b0}; 
        5'b 10000: vid_pixel2 = {dp_vid_pixel2[47:42], 2'b0, 6'd0, 2'b0, 6'd0,2'b0, 24'b0}; 
        default: vid_pixel2 = {dp_vid_pixel2[47:42], 2'b0, dp_vid_pixel2[15:10], 2'b0, dp_vid_pixel2[31:26],2'b0, 24'b0}; 
      endcase
      case ( bpc )
        5'b 00001: vid_pixel3 = {dp_vid_pixel3[47:40], dp_vid_pixel3[15:8 ], dp_vid_pixel3[31:24], 24'b0};
        5'b 01001: vid_pixel3 = {dp_vid_pixel3[47:40], dp_vid_pixel3[31:24 ], dp_vid_pixel3[15:8], 24'b0};
        5'b 10001: vid_pixel3 = {dp_vid_pixel3[47:40], 8'd0, 8'd0, 24'b0};
        5'b 01000: vid_pixel3 = {dp_vid_pixel3[47:42], 2'b0, dp_vid_pixel3[31:26], 2'b0, dp_vid_pixel3[15:10],2'b0, 24'b0};
        5'b 10000: vid_pixel3 = {dp_vid_pixel3[47:42], 2'b0, 6'd0, 2'b0, 6'd0,2'b0, 24'b0};
        default: vid_pixel3 = {dp_vid_pixel3[47:42], 2'b0, dp_vid_pixel3[15:10], 2'b0, dp_vid_pixel3[31:26],2'b0, 24'b0};
      endcase
    end //always
end else if (pMAX_BPC == 10) begin
    always @ ( bpc or dp_vid_pixel0 or dp_vid_pixel1 or dp_vid_pixel2 or dp_vid_pixel3 ) begin
      case ( bpc )
        5'b 00010: vid_pixel0 = {dp_vid_pixel0[47:38], dp_vid_pixel0[15:6 ], dp_vid_pixel0[31:22], 18'b0};
        5'b 01010: vid_pixel0 = {dp_vid_pixel0[47:38], dp_vid_pixel0[31:22 ], dp_vid_pixel0[15:6], 18'b0};
        5'b 10010: vid_pixel0 = {dp_vid_pixel0[47:38], 10'd0, 10'd0, 18'b0};
        5'b 00001: vid_pixel0 = {dp_vid_pixel0[47:40], 2'b0, dp_vid_pixel0[15:8 ], 2'b0, dp_vid_pixel0[31:24],2'b0, 18'b0};
        5'b 01001: vid_pixel0 = {dp_vid_pixel0[47:40], 2'b0, dp_vid_pixel0[31:24 ], 2'b0, dp_vid_pixel0[15:8],2'b0, 18'b0};
        5'b 10001: vid_pixel0 = {dp_vid_pixel0[47:40], 2'b0, 8'd0, 2'b0, 8'd0,2'b0, 18'b0};
        5'b 01000: vid_pixel0 = {dp_vid_pixel0[47:42], 4'b0, dp_vid_pixel0[31:26], 4'b0, dp_vid_pixel0[15:10],4'b0, 18'b0};
        5'b 10000: vid_pixel0 = {dp_vid_pixel0[47:42], 4'b0, 6'd0, 4'b0, 6'd0,4'b0, 18'b0};
        default: vid_pixel0 = {dp_vid_pixel0[47:42], 4'b0, dp_vid_pixel0[15:10], 4'b0, dp_vid_pixel0[31:26],4'b0, 18'b0};
      endcase
      case ( bpc )
        5'b 00010: vid_pixel1 = {dp_vid_pixel1[47:38], dp_vid_pixel1[15:6 ], dp_vid_pixel1[31:22], 18'b0};
        5'b 01010: vid_pixel1 = {dp_vid_pixel1[47:38], dp_vid_pixel1[31:22 ], dp_vid_pixel1[15:6], 18'b0};
        5'b 10010: vid_pixel1 = {dp_vid_pixel1[47:38], 10'd0, 10'd0, 18'b0};
        5'b 00001: vid_pixel1 = {dp_vid_pixel1[47:40], 2'b0, dp_vid_pixel1[15:8 ], 2'b0, dp_vid_pixel1[31:24],2'b0, 18'b0};
        5'b 01001: vid_pixel1 = {dp_vid_pixel1[47:40], 2'b0, dp_vid_pixel1[31:24 ], 2'b0, dp_vid_pixel1[15:8],2'b0, 18'b0};
        5'b 10001: vid_pixel1 = {dp_vid_pixel1[47:40], 2'b0, 8'd0, 2'b0, 8'd0,2'b0, 18'b0};
        5'b 01000: vid_pixel1 = {dp_vid_pixel1[47:42], 4'b0, dp_vid_pixel1[31:26], 4'b0, dp_vid_pixel1[15:10],4'b0, 18'b0};
        5'b 10000: vid_pixel1 = {dp_vid_pixel1[47:42], 4'b0, 6'd0, 4'b0, 6'd0,4'b0, 18'b0};
        default: vid_pixel1 = {dp_vid_pixel1[47:42], 4'b0, dp_vid_pixel1[15:10], 4'b0, dp_vid_pixel1[31:26],4'b0, 18'b0};
      endcase
      case ( bpc )
        5'b 00010: vid_pixel2 = {dp_vid_pixel2[47:38], dp_vid_pixel2[15:6 ], dp_vid_pixel2[31:22], 18'b0};
        5'b 01010: vid_pixel2 = {dp_vid_pixel2[47:38], dp_vid_pixel2[31:22 ], dp_vid_pixel2[15:6], 18'b0};
        5'b 10010: vid_pixel2 = {dp_vid_pixel2[47:38], 10'd0, 10'd0, 18'b0};
        5'b 00001: vid_pixel2 = {dp_vid_pixel2[47:40], 2'b0, dp_vid_pixel2[15:8 ], 2'b0, dp_vid_pixel2[31:24],2'b0, 18'b0};
        5'b 01001: vid_pixel2 = {dp_vid_pixel2[47:40], 2'b0, dp_vid_pixel2[31:24 ], 2'b0, dp_vid_pixel2[15:8],2'b0, 18'b0};
        5'b 10001: vid_pixel2 = {dp_vid_pixel2[47:40], 2'b0, 8'd0, 2'b0, 8'd0,2'b0, 18'b0};
        5'b 01000: vid_pixel2 = {dp_vid_pixel2[47:42], 4'b0, dp_vid_pixel2[31:26], 4'b0, dp_vid_pixel2[15:10],4'b0, 18'b0};
        5'b 10000: vid_pixel2 = {dp_vid_pixel2[47:42], 4'b0, 6'd0, 4'b0, 6'd0,4'b0, 18'b0};
        default: vid_pixel2 = {dp_vid_pixel2[47:42], 4'b0, dp_vid_pixel2[15:10], 4'b0, dp_vid_pixel2[31:26],4'b0, 18'b0};
      endcase
      case ( bpc )
        5'b 00010: vid_pixel3 = {dp_vid_pixel3[47:38], dp_vid_pixel3[15:6 ], dp_vid_pixel3[31:22], 18'b0};
        5'b 01010: vid_pixel3 = {dp_vid_pixel3[47:38], dp_vid_pixel3[31:22 ], dp_vid_pixel3[15:6], 18'b0};
        5'b 10010: vid_pixel3 = {dp_vid_pixel3[47:38], 10'd0, 10'd0, 18'b0};
        5'b 00001: vid_pixel3 = {dp_vid_pixel3[47:40], 2'b0, dp_vid_pixel3[15:8 ], 2'b0, dp_vid_pixel3[31:24], 2'b0, 18'b0};
        5'b 01001: vid_pixel3 = {dp_vid_pixel3[47:40], 2'b0, dp_vid_pixel3[31:24 ], 2'b0, dp_vid_pixel3[15:8], 2'b0, 18'b0};
        5'b 10001: vid_pixel3 = {dp_vid_pixel3[47:40], 2'b0, 8'd0, 2'b0, 8'd0, 2'b0, 18'b0};
        5'b 01000: vid_pixel3 = {dp_vid_pixel3[47:42], 4'b0, dp_vid_pixel3[31:26], 4'b0, dp_vid_pixel3[15:10], 4'b0, 18'b0};
        5'b 10000: vid_pixel3 = {dp_vid_pixel3[47:42], 4'b0, 6'd0, 4'b0, 6'd0, 4'b0, 18'b0};
        default: vid_pixel3 = {dp_vid_pixel3[47:42], 4'b0, dp_vid_pixel3[15:10], 4'b0, dp_vid_pixel3[31:26], 4'b0, 18'b0};
      endcase
    end //always
end else if (pMAX_BPC == 12) begin
    always @ ( bpc or dp_vid_pixel0 or dp_vid_pixel1 or dp_vid_pixel2 or dp_vid_pixel3 ) begin
      case ( bpc )
        5'b 00011: vid_pixel0 = {dp_vid_pixel0[47:36], dp_vid_pixel0[15:4 ], dp_vid_pixel0[31:20], 12'b0};
        5'b 01011: vid_pixel0 = {dp_vid_pixel0[47:36], dp_vid_pixel0[31:20 ], dp_vid_pixel0[15:4], 12'b0};
        5'b 10011: vid_pixel0 = {dp_vid_pixel0[47:36], 12'd0, 12'd0, 12'b0};
        5'b 00001: vid_pixel0 = {dp_vid_pixel0[47:40], 4'b0, dp_vid_pixel0[15:8 ], 4'b0, dp_vid_pixel0[31:24],4'b0, 12'b0};
        5'b 01001: vid_pixel0 = {dp_vid_pixel0[47:40], 4'b0, dp_vid_pixel0[31:24 ], 4'b0, dp_vid_pixel0[15:8],4'b0, 12'b0};
        5'b 10001: vid_pixel0 = {dp_vid_pixel0[47:40], 4'b0, 8'd0, 4'b0, 8'd0,4'b0, 12'b0};
        5'b 00010: vid_pixel0 = {dp_vid_pixel0[47:38], 2'b0, dp_vid_pixel0[15:6 ], 2'b0, dp_vid_pixel0[31:22],2'b0, 12'b0};
        5'b 01010: vid_pixel0 = {dp_vid_pixel0[47:38], 2'b0, dp_vid_pixel0[31:22 ], 2'b0, dp_vid_pixel0[15:6],2'b0, 12'b0};
        5'b 10010: vid_pixel0 = {dp_vid_pixel0[47:38], 2'b0, 10'd0, 2'b0, 10'd0,2'b0, 12'b0};
        5'b 01000: vid_pixel0 = {dp_vid_pixel0[47:42], 6'b0, dp_vid_pixel0[31:26], 6'b0, dp_vid_pixel0[15:10],6'b0, 12'b0}; 
        5'b 10000: vid_pixel0 = {dp_vid_pixel0[47:42], 6'b0, 6'd0, 6'b0, 6'd0,6'b0, 12'b0}; 
        default: vid_pixel0 = {dp_vid_pixel0[47:42], 6'b0, dp_vid_pixel0[15:10], 6'b0, dp_vid_pixel0[31:26],6'b0, 12'b0}; 
      endcase
      case ( bpc )
        5'b 00011: vid_pixel1 = {dp_vid_pixel1[47:36], dp_vid_pixel1[15:4 ], dp_vid_pixel1[31:20], 12'b0};
        5'b 01011: vid_pixel1 = {dp_vid_pixel1[47:36], dp_vid_pixel1[31:20 ], dp_vid_pixel1[15:4], 12'b0};
        5'b 10011: vid_pixel1 = {dp_vid_pixel1[47:36], 12'd0, 12'd0, 12'b0};
        5'b 00001: vid_pixel1 = {dp_vid_pixel1[47:40], 4'b0, dp_vid_pixel1[15:8 ], 4'b0, dp_vid_pixel1[31:24],4'b0, 12'b0};
        5'b 01001: vid_pixel1 = {dp_vid_pixel1[47:40], 4'b0, dp_vid_pixel1[31:24 ], 4'b0, dp_vid_pixel1[15:8],4'b0, 12'b0};
        5'b 10001: vid_pixel1 = {dp_vid_pixel1[47:40], 4'b0, 8'd0 , 4'b0, 8'd0,4'b0, 12'b0};
        5'b 00010: vid_pixel1 = {dp_vid_pixel1[47:38], 2'b0, dp_vid_pixel1[15:6 ], 2'b0, dp_vid_pixel1[31:22],2'b0, 12'b0};
        5'b 01010: vid_pixel1 = {dp_vid_pixel1[47:38], 2'b0, dp_vid_pixel1[31:22 ], 2'b0, dp_vid_pixel1[15:6],2'b0, 12'b0};
        5'b 10010: vid_pixel1 = {dp_vid_pixel1[47:38], 2'b0, 10'd0 , 2'b0, 10'd0,2'b0, 12'b0};
        5'b 01000: vid_pixel1 = {dp_vid_pixel1[47:42], 6'b0, dp_vid_pixel1[31:26], 6'b0, dp_vid_pixel1[15:10],6'b0, 12'b0};
        5'b 10000: vid_pixel1 = {dp_vid_pixel1[47:42], 6'b0, 6'd0, 6'b0, 6'd0,6'b0, 12'b0};
        default: vid_pixel1 = {dp_vid_pixel1[47:42], 6'b0, dp_vid_pixel1[15:10], 6'b0, dp_vid_pixel1[31:26],6'b0, 12'b0};
      endcase
      case ( bpc )
        5'b 00011: vid_pixel2 = {dp_vid_pixel2[47:36], dp_vid_pixel2[15:4 ], dp_vid_pixel2[31:20], 12'b0};
        5'b 01011: vid_pixel2 = {dp_vid_pixel2[47:36], dp_vid_pixel2[31:20 ], dp_vid_pixel2[15:4], 12'b0};
        5'b 10011: vid_pixel2 = {dp_vid_pixel2[47:36], 12'd0, 12'd0, 12'b0};
        5'b 00001: vid_pixel2 = {dp_vid_pixel2[47:40], 4'b0, dp_vid_pixel2[15:8 ], 4'b0, dp_vid_pixel2[31:24],4'b0, 12'b0};
        5'b 01001: vid_pixel2 = {dp_vid_pixel2[47:40], 4'b0, dp_vid_pixel2[31:24 ], 4'b0, dp_vid_pixel2[15:8],4'b0, 12'b0};
        5'b 10001: vid_pixel2 = {dp_vid_pixel2[47:40], 4'b0, 8'd0 , 4'b0, 8'd0 ,4'b0, 12'b0};
        5'b 00010: vid_pixel2 = {dp_vid_pixel2[47:38], 2'b0, dp_vid_pixel2[15:6 ], 2'b0, dp_vid_pixel2[31:22],2'b0, 12'b0};
        5'b 01010: vid_pixel2 = {dp_vid_pixel2[47:38], 2'b0, dp_vid_pixel2[31:22 ], 2'b0, dp_vid_pixel2[15:6],2'b0, 12'b0};
        5'b 10010: vid_pixel2 = {dp_vid_pixel2[47:38], 2'b0, 10'd0, 2'b0, 10'd0,2'b0, 12'b0};
        5'b 01000: vid_pixel2 = {dp_vid_pixel2[47:42], 6'b0, dp_vid_pixel2[31:26], 6'b0, dp_vid_pixel2[15:10],6'b0, 12'b0};
        5'b 10000: vid_pixel2 = {dp_vid_pixel2[47:42], 6'b0, 6'd0, 6'b0, 6'd0,6'b0, 12'b0};
        default: vid_pixel2 = {dp_vid_pixel2[47:42], 6'b0, dp_vid_pixel2[15:10], 6'b0, dp_vid_pixel2[31:26],6'b0, 12'b0};
      endcase
      case ( bpc )
        5'b 00011: vid_pixel3 = {dp_vid_pixel3[47:36], dp_vid_pixel3[15:4 ], dp_vid_pixel3[31:20], 12'b0};
        5'b 01011: vid_pixel3 = {dp_vid_pixel3[47:36], dp_vid_pixel3[31:20 ], dp_vid_pixel3[15:4], 12'b0};
        5'b 10011: vid_pixel3 = {dp_vid_pixel3[47:36], 12'd0 , 12'd0, 12'b0};
        5'b 00001: vid_pixel3 = {dp_vid_pixel3[47:40], 4'b0, dp_vid_pixel3[15:8 ], 4'b0, dp_vid_pixel3[31:24],4'b0, 12'b0};
        5'b 01001: vid_pixel3 = {dp_vid_pixel3[47:40], 4'b0, dp_vid_pixel3[31:24 ], 4'b0, dp_vid_pixel3[15:8],4'b0, 12'b0};
        5'b 10001: vid_pixel3 = {dp_vid_pixel3[47:40], 4'b0, 8'd0, 4'b0, 8'd0,4'b0, 12'b0};
        5'b 00010: vid_pixel3 = {dp_vid_pixel3[47:38], 2'b0, dp_vid_pixel3[15:6 ], 2'b0, dp_vid_pixel3[31:22],2'b0, 12'b0};
        5'b 01010: vid_pixel3 = {dp_vid_pixel3[47:38], 2'b0, dp_vid_pixel3[31:22 ], 2'b0, dp_vid_pixel3[15:6],2'b0, 12'b0};
        5'b 10010: vid_pixel3 = {dp_vid_pixel3[47:38], 2'b0, 10'd0, 2'b0, 10'd0,2'b0, 12'b0};
        5'b 01000: vid_pixel3 = {dp_vid_pixel3[47:42], 6'b0, dp_vid_pixel3[31:26], 6'b0, dp_vid_pixel3[15:10],6'b0, 12'b0};
        5'b 10000: vid_pixel3 = {dp_vid_pixel3[47:42], 6'b0, 6'd0, 6'b0, 6'd0,6'b0, 12'b0};
        default: vid_pixel3 = {dp_vid_pixel3[47:42], 6'b0, dp_vid_pixel3[15:10], 6'b0, dp_vid_pixel3[31:26],6'b0, 12'b0};
      endcase
    end //always
end else begin //16 bpc
    always @ ( bpc or dp_vid_pixel0 or dp_vid_pixel1 or dp_vid_pixel2 or dp_vid_pixel3 ) begin
      case ( bpc )
        5'b 00000: vid_pixel0 = {dp_vid_pixel0[47:42], 10'b0, dp_vid_pixel0[15:10], 10'b0, dp_vid_pixel0[31:26],10'b0};
        5'b 01000: vid_pixel0 = {dp_vid_pixel0[47:42], 10'b0, dp_vid_pixel0[31:26], 10'b0, dp_vid_pixel0[15:10],10'b0};
        5'b 10000: vid_pixel0 = {dp_vid_pixel0[47:42], 10'b0, 6'd0, 10'b0, 6'd0,10'b0};
        5'b 00001: vid_pixel0 = {dp_vid_pixel0[47:40],  8'b0, dp_vid_pixel0[15:8 ],  8'b0, dp_vid_pixel0[31:24], 8'b0};
        5'b 01001: vid_pixel0 = {dp_vid_pixel0[47:40],  8'b0, dp_vid_pixel0[31:24 ],  8'b0, dp_vid_pixel0[15:8], 8'b0};
        5'b 10001: vid_pixel0 = {dp_vid_pixel0[47:40],  8'b0, 8'd0,  8'b0, 8'd0, 8'b0};
        5'b 00010: vid_pixel0 = {dp_vid_pixel0[47:38],  6'b0, dp_vid_pixel0[15:6 ],  6'b0, dp_vid_pixel0[31:22], 6'b0};
        5'b 01010: vid_pixel0 = {dp_vid_pixel0[47:38],  6'b0, dp_vid_pixel0[31:22 ],  6'b0, dp_vid_pixel0[15:6], 6'b0};
        5'b 10010: vid_pixel0 = {dp_vid_pixel0[47:38],  6'b0, 10'd0,  6'b0, 10'd0, 6'b0};
        5'b 00011: vid_pixel0 = {dp_vid_pixel0[47:36],  4'b0, dp_vid_pixel0[15:4 ],  4'b0, dp_vid_pixel0[31:20], 4'b0};
        5'b 01011: vid_pixel0 = {dp_vid_pixel0[47:36],  4'b0, dp_vid_pixel0[31:20 ],  4'b0, dp_vid_pixel0[15:4], 4'b0};
        5'b 10011: vid_pixel0 = {dp_vid_pixel0[47:36],  4'b0, 12'd0,  4'b0, 12'd0, 4'b0};
        5'b 01100: vid_pixel0 = {dp_vid_pixel0[47:32], dp_vid_pixel0[31:16 ], dp_vid_pixel0[15:0]};
        5'b 10100: vid_pixel0 = {dp_vid_pixel0[47:32], 16'd0, 16'd0};
        default: vid_pixel0 = {dp_vid_pixel0[47:32], dp_vid_pixel0[15:0 ], dp_vid_pixel0[31:16]};
      endcase
      case ( bpc )
        5'b 00000: vid_pixel1 = {dp_vid_pixel1[47:42], 10'b0, dp_vid_pixel1[15:10], 10'b0, dp_vid_pixel1[31:26],10'b0};
        5'b 01000: vid_pixel1 = {dp_vid_pixel1[47:42], 10'b0, dp_vid_pixel1[31:26], 10'b0, dp_vid_pixel1[15:10],10'b0};
        5'b 10000: vid_pixel1 = {dp_vid_pixel1[47:42], 10'b0, 6'd0, 10'b0,6'd0,10'b0};
        5'b 00001: vid_pixel1 = {dp_vid_pixel1[47:40],  8'b0, dp_vid_pixel1[15:8 ],  8'b0, dp_vid_pixel1[31:24],8'b0};
        5'b 01001: vid_pixel1 = {dp_vid_pixel1[47:40],  8'b0, dp_vid_pixel1[31:24 ],  8'b0, dp_vid_pixel1[15:8],8'b0};
        5'b 10001: vid_pixel1 = {dp_vid_pixel1[47:40],  8'b0, 8'd0,  8'b0, 8'd0,8'b0};
        5'b 00010: vid_pixel1 = {dp_vid_pixel1[47:38],  6'b0, dp_vid_pixel1[15:6 ],  6'b0, dp_vid_pixel1[31:22],6'b0};
        5'b 01010: vid_pixel1 = {dp_vid_pixel1[47:38],  6'b0, dp_vid_pixel1[31:22 ],  6'b0, dp_vid_pixel1[15:6],6'b0};
        5'b 10010: vid_pixel1 = {dp_vid_pixel1[47:38],  6'b0, 10'd0,  6'b0, 10'd0,6'b0};
        5'b 00011: vid_pixel1 = {dp_vid_pixel1[47:36],  4'b0, dp_vid_pixel1[15:4 ],  4'b0, dp_vid_pixel1[31:20],4'b0};
        5'b 01011: vid_pixel1 = {dp_vid_pixel1[47:36],  4'b0, dp_vid_pixel1[31:20 ],  4'b0, dp_vid_pixel1[15:4],4'b0};
        5'b 10011: vid_pixel1 = {dp_vid_pixel1[47:36],  4'b0, 12'd0,  4'b0, 12'd0,4'b0};
        5'b 01100: vid_pixel1 = {dp_vid_pixel1[47:32], dp_vid_pixel1[31:16 ], dp_vid_pixel1[15:0]};
        5'b 10100: vid_pixel1 = {dp_vid_pixel1[47:32], 16'd0, 16'd0};
        default: vid_pixel1 = {dp_vid_pixel1[47:32], dp_vid_pixel1[15:0 ], dp_vid_pixel1[31:16]};
      endcase
      case ( bpc )
        5'b 00000: vid_pixel2 = {dp_vid_pixel2[47:42], 10'b0, dp_vid_pixel2[15:10], 10'b0, dp_vid_pixel2[31:26],10'b0};
        5'b 01000: vid_pixel2 = {dp_vid_pixel2[47:42], 10'b0, dp_vid_pixel2[31:26], 10'b0, dp_vid_pixel2[15:10],10'b0};
        5'b 10000: vid_pixel2 = {dp_vid_pixel2[47:42], 10'b0, 6'd0, 10'b0, 6'd0,10'b0};
        5'b 00001: vid_pixel2 = {dp_vid_pixel2[47:40],  8'b0, dp_vid_pixel2[15:8 ],  8'b0, dp_vid_pixel2[31:24],8'b0};
        5'b 01001: vid_pixel2 = {dp_vid_pixel2[47:40],  8'b0, dp_vid_pixel2[31:24 ],  8'b0, dp_vid_pixel2[15:8],8'b0};
        5'b 10001: vid_pixel2 = {dp_vid_pixel2[47:40],  8'b0, 8'd0,  8'b0, 8'd0,8'b0};
        5'b 00010: vid_pixel2 = {dp_vid_pixel2[47:38],  6'b0, dp_vid_pixel2[15:6 ],  6'b0, dp_vid_pixel2[31:22],6'b0};
        5'b 01010: vid_pixel2 = {dp_vid_pixel2[47:38],  6'b0, dp_vid_pixel2[31:22 ],  6'b0, dp_vid_pixel2[15:6],6'b0};
        5'b 10010: vid_pixel2 = {dp_vid_pixel2[47:38],  6'b0, 10'd0,  6'b0, 10'd0,6'b0};
        5'b 00011: vid_pixel2 = {dp_vid_pixel2[47:36],  4'b0, dp_vid_pixel2[15:4 ],  4'b0, dp_vid_pixel2[31:20],4'b0};
        5'b 01011: vid_pixel2 = {dp_vid_pixel2[47:36],  4'b0, dp_vid_pixel2[31:20 ],  4'b0, dp_vid_pixel2[15:4],4'b0};
        5'b 10011: vid_pixel2 = {dp_vid_pixel2[47:36],  4'b0, 12'd0,  4'b0, 12'd0,4'b0};
        5'b 01100: vid_pixel2 = {dp_vid_pixel2[47:32], dp_vid_pixel2[31:16 ], dp_vid_pixel2[15:0]};
        5'b 10100: vid_pixel2 = {dp_vid_pixel2[47:32], 16'd0, 16'd0};
        default: vid_pixel2 = {dp_vid_pixel2[47:32], dp_vid_pixel2[15:0 ], dp_vid_pixel2[31:16]};
      endcase
      case ( bpc )
        5'b 00000: vid_pixel3 = {dp_vid_pixel3[47:42], 10'b0, dp_vid_pixel3[15:10], 10'b0, dp_vid_pixel3[31:26],10'b0};
        5'b 01000: vid_pixel3 = {dp_vid_pixel3[47:42], 10'b0, dp_vid_pixel3[31:26], 10'b0, dp_vid_pixel3[15:10],10'b0};
        5'b 10000: vid_pixel3 = {dp_vid_pixel3[47:42], 10'b0, 6'd0, 10'b0, 6'd0,10'b0};
        5'b 00001: vid_pixel3 = {dp_vid_pixel3[47:40],  8'b0, dp_vid_pixel3[15:8 ],  8'b0, dp_vid_pixel3[31:24],8'b0};
        5'b 01001: vid_pixel3 = {dp_vid_pixel3[47:40],  8'b0, dp_vid_pixel3[31:24 ],  8'b0, dp_vid_pixel3[15:8],8'b0};
        5'b 10001: vid_pixel3 = {dp_vid_pixel3[47:40],  8'b0, 8'd0,  8'b0, 8'd0,8'b0};
        5'b 00010: vid_pixel3 = {dp_vid_pixel3[47:38],  6'b0, dp_vid_pixel3[15:6 ],  6'b0, dp_vid_pixel3[31:22],6'b0};
        5'b 01010: vid_pixel3 = {dp_vid_pixel3[47:38],  6'b0, dp_vid_pixel3[31:22 ],  6'b0, dp_vid_pixel3[15:6],6'b0};
        5'b 10010: vid_pixel3 = {dp_vid_pixel3[47:38],  6'b0, 10'd0,  6'b0, 10'd0,6'b0};
        5'b 00011: vid_pixel3 = {dp_vid_pixel3[47:36],  4'b0, dp_vid_pixel3[15:4 ],  4'b0, dp_vid_pixel3[31:20],4'b0};
        5'b 01011: vid_pixel3 = {dp_vid_pixel3[47:36],  4'b0, dp_vid_pixel3[31:20 ],  4'b0, dp_vid_pixel3[15:4],4'b0};
        5'b 10011: vid_pixel3 = {dp_vid_pixel3[47:36],  4'b0, 12'd0,  4'b0, 12'd0,4'b0};
        5'b 01100: vid_pixel3 = {dp_vid_pixel3[47:32], dp_vid_pixel3[31:16 ], dp_vid_pixel3[15:0]};
        5'b 10100: vid_pixel3 = {dp_vid_pixel3[47:32], 16'd0, 16'd0};
        default: vid_pixel3 = {dp_vid_pixel3[47:32], dp_vid_pixel3[15:0 ], dp_vid_pixel3[31:16]};
      endcase
    end //always
end //16 bpc
endgenerate

//Logic for remapping of pixels for DSC support - Start
generate if (pMAX_BPC == 8) begin
    always @(*)
    begin
        if(enable_dsc)
        begin
            vid_pixel0_dsc  = {vid_pixel0[47:24],24'd0};
            vid_pixel1_dsc  = {vid_pixel1[47:24],24'd0};  
            vid_pixel2_dsc  = {vid_pixel2[47:24],24'd0};  
            vid_pixel3_dsc  = {vid_pixel3[47:24],24'd0};  
        end
        else
        begin
            vid_pixel0_dsc  = vid_pixel0;
            vid_pixel1_dsc  = vid_pixel1;  
            vid_pixel2_dsc  = vid_pixel2;  
            vid_pixel3_dsc  = vid_pixel3;  
        end
    end
end else if (pMAX_BPC == 10) begin
    always @(*)
    begin
        if(enable_dsc)
        begin
            vid_pixel0_dsc  = {vid_pixel0[47:40],vid_pixel0[37:30],vid_pixel0[27:20],24'd0};
            vid_pixel1_dsc  = {vid_pixel1[47:40],vid_pixel1[37:30],vid_pixel1[27:20],24'd0};  
            vid_pixel2_dsc  = {vid_pixel2[47:40],vid_pixel2[37:30],vid_pixel2[27:20],24'd0};  
            vid_pixel3_dsc  = {vid_pixel3[47:40],vid_pixel3[37:30],vid_pixel3[27:20],24'd0};  
        end
        else
        begin
            vid_pixel0_dsc  = vid_pixel0;
            vid_pixel1_dsc  = vid_pixel1;  
            vid_pixel2_dsc  = vid_pixel2;  
            vid_pixel3_dsc  = vid_pixel3;  
        end
    end
end else if (pMAX_BPC == 12) begin
    always @(*)
    begin
        if(enable_dsc)
        begin
            vid_pixel0_dsc  = {vid_pixel0[47:40],vid_pixel0[35:28],vid_pixel0[23:16],24'd0};
            vid_pixel1_dsc  = {vid_pixel1[47:40],vid_pixel1[35:28],vid_pixel1[23:16],24'd0};  
            vid_pixel2_dsc  = {vid_pixel2[47:40],vid_pixel2[35:28],vid_pixel2[23:16],24'd0};  
            vid_pixel3_dsc  = {vid_pixel3[47:40],vid_pixel3[35:28],vid_pixel3[23:16],24'd0};  
        end
        else
        begin
            vid_pixel0_dsc  = vid_pixel0;
            vid_pixel1_dsc  = vid_pixel1;  
            vid_pixel2_dsc  = vid_pixel2;  
            vid_pixel3_dsc  = vid_pixel3;  
        end
    end
end else if (pMAX_BPC == 16) begin
    always @(*)
    begin
        if(enable_dsc)
        begin
            vid_pixel0_dsc  = {vid_pixel0[47:40],vid_pixel0[31:24],vid_pixel0[15:8],24'd0};
            vid_pixel1_dsc  = {vid_pixel1[47:40],vid_pixel1[31:24],vid_pixel1[15:8],24'd0};  
            vid_pixel2_dsc  = {vid_pixel2[47:40],vid_pixel2[31:24],vid_pixel2[15:8],24'd0};  
            vid_pixel3_dsc  = {vid_pixel3[47:40],vid_pixel3[31:24],vid_pixel3[15:8],24'd0};  
        end
        else
        begin
            vid_pixel0_dsc  = vid_pixel0;
            vid_pixel1_dsc  = vid_pixel1;  
            vid_pixel2_dsc  = vid_pixel2;  
            vid_pixel3_dsc  = vid_pixel3;  
        end
    end
end
endgenerate
//Logic for remapping of pixels for DSC support - End

//assign s_axis_tvalid_i = vid_de;
//assign s_axis_tdata_i = {8'h00,vid_pixel3,8'h00,vid_pixel2,8'h00,vid_pixel1,8'h00,vid_pixel0};

//Logic to eliminate dummy and eoc bytes from data stream   - Start
generate if ((pENABLE_DSC == 1) && (pPC == 4) && (pUG934_COMPLIANCE == 1)) begin
    dp_videoaxi4s_bridge_v1_0_1_dsc_fifo 
    #(
        .pDSC_READ_BYTES    (DSC_READ_BYTES),
        .pENABLE_DSC_DUMMY_BYTES_IN_RX (pENABLE_DSC_DUMMY_BYTES_IN_RX)
    ) dp_videoaxi4s_bridge_v1_0_1_dsc_fifo_inst
    (
        .vid_pixel_clk  (vid_pixel_clk) ,
        .enable_dsc     (enable_dsc),
        .auto_clear     (auto_clear)    ,
        .data_in        ({vid_pixel0_dsc[47:40],vid_pixel1_dsc[47:40], vid_pixel2_dsc[47:40], vid_pixel3_dsc[47:40], 
                         vid_pixel0_dsc[31:24],vid_pixel1_dsc[31:24], vid_pixel2_dsc[31:24], vid_pixel3_dsc[31:24], 
                         vid_pixel0_dsc[39:32],vid_pixel1_dsc[39:32], vid_pixel2_dsc[39:32], vid_pixel3_dsc[39:32]} 
                        ),
        .data_valid     ({vid_valid_per_pixel[11],vid_valid_per_pixel[8],vid_valid_per_pixel[5],vid_valid_per_pixel[2],
                         vid_valid_per_pixel[10],vid_valid_per_pixel[7],vid_valid_per_pixel[4],vid_valid_per_pixel[1],
                         vid_valid_per_pixel[ 9],vid_valid_per_pixel[6],vid_valid_per_pixel[3],vid_valid_per_pixel[0]}),
        .data_last      (vid_last),
        .we             (vid_de),
        .rd_wr_diff     (rd_wr_diff),
        .vid_hsync_fe   (vid_hsync_fe),
        .lanes          (num_active_lanes),
        .sof            (sof_int),
        .last_from_fifo (dsc_last_from_fifo),
        .valid_from_fifo(dsc_valid_from_fifo),
        .tkeep_from_fifo(dsc_tkeep_from_fifo),
        .data_out       (dsc_data_from_fifo)
    );

    assign vid_pixel0_dsc_fifo  =  {dsc_data_from_fifo[117:110],dsc_data_from_fifo[77:70],dsc_data_from_fifo[37:30]} ;
    assign vid_pixel1_dsc_fifo  =  {dsc_data_from_fifo[107:100],dsc_data_from_fifo[67:60],dsc_data_from_fifo[27:20]} ; 
    assign vid_pixel2_dsc_fifo  =  {dsc_data_from_fifo[97:90],dsc_data_from_fifo[57:50],dsc_data_from_fifo[17:10]} ; 
    assign vid_pixel3_dsc_fifo  =  {dsc_data_from_fifo[87:80],dsc_data_from_fifo[47:40],dsc_data_from_fifo[ 7: 0]} ;

    assign dsc_sof_from_fifo    =  dsc_data_from_fifo[119];


end else if ((pENABLE_DSC == 1) && (pPC == 2) && (pUG934_COMPLIANCE == 1)) begin
    
    dp_videoaxi4s_bridge_v1_0_1_dsc_fifo 
    #(
        .pDSC_READ_BYTES    (DSC_READ_BYTES),
        .pENABLE_DSC_DUMMY_BYTES_IN_RX (pENABLE_DSC_DUMMY_BYTES_IN_RX)
    ) dp_videoaxi4s_bridge_v1_0_1_dsc_fifo_inst
    (
        .vid_pixel_clk  (vid_pixel_clk) ,
        .enable_dsc     (enable_dsc),
        .auto_clear     (auto_clear)    ,
        .data_in        ({vid_pixel0_dsc[47:40],vid_pixel1_dsc[47:40], 
                         vid_pixel0_dsc[31:24],vid_pixel1_dsc[31:24], 
                         vid_pixel0_dsc[39:32],vid_pixel1_dsc[39:32]} 
                        ),
        .data_valid     ({6'd0, vid_valid_per_pixel[11],vid_valid_per_pixel[8],
                         vid_valid_per_pixel[10],vid_valid_per_pixel[7],
                         vid_valid_per_pixel[ 9],vid_valid_per_pixel[6]}),
        .data_last      (vid_last),
        .we             (vid_de),
        .rd_wr_diff     (rd_wr_diff),
        .vid_hsync_fe   (vid_hsync_fe),
        .lanes          (num_active_lanes),
        .sof            (sof_int),
        .last_from_fifo (dsc_last_from_fifo),
        .valid_from_fifo(dsc_valid_from_fifo),
        .tkeep_from_fifo(dsc_tkeep_from_fifo),
        .data_out       (dsc_data_from_fifo)
    );
    
    assign vid_pixel0_dsc_fifo  =  {dsc_data_from_fifo[57:50],dsc_data_from_fifo[37:30],dsc_data_from_fifo[17:10]} ;
    assign vid_pixel1_dsc_fifo  =  {dsc_data_from_fifo[47:40],dsc_data_from_fifo[27:20],dsc_data_from_fifo[ 7: 0]} ; 

    assign dsc_sof_from_fifo    =  dsc_data_from_fifo[59];


end else if ((pENABLE_DSC == 1) && (pPC == 1) && (pUG934_COMPLIANCE == 1)) begin


    dp_videoaxi4s_bridge_v1_0_1_dsc_fifo 
    #(
        .pDSC_READ_BYTES    (DSC_READ_BYTES),
        .pENABLE_DSC_DUMMY_BYTES_IN_RX (pENABLE_DSC_DUMMY_BYTES_IN_RX)
    ) dp_videoaxi4s_bridge_v1_0_1_dsc_fifo_inst
    (
        .vid_pixel_clk  (vid_pixel_clk) ,
        .enable_dsc     (enable_dsc),
        .auto_clear     (auto_clear)    ,
        .data_in        ({vid_pixel0_dsc[47:40], 
                         vid_pixel0_dsc[31:24], 
                         vid_pixel0_dsc[39:32]}
                        ),
        .data_valid     ({9'd0,vid_valid_per_pixel[11],
                         vid_valid_per_pixel[10],
                         vid_valid_per_pixel[ 9]}),
        .data_last      (vid_last),
        .we             (vid_de),
        .rd_wr_diff     (rd_wr_diff),
        .vid_hsync_fe   (vid_hsync_fe),
        .lanes          (num_active_lanes),
        .sof            (sof_int),
        .last_from_fifo (dsc_last_from_fifo),
        .valid_from_fifo(dsc_valid_from_fifo),
        .tkeep_from_fifo(dsc_tkeep_from_fifo),
        .data_out       (dsc_data_from_fifo)
    );

    assign vid_pixel0_dsc_fifo  =  {dsc_data_from_fifo[27:20],dsc_data_from_fifo[17:10],dsc_data_from_fifo[ 7: 0]} ;
    assign dsc_sof_from_fifo    =  dsc_data_from_fifo[29];


end
endgenerate
//Logic to eliminate dummy and eoc bytes from data stream   - End


generate if ( (pPC == 4) && (pUG934_COMPLIANCE == 1) ) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
    vid_valid_per_pixel_r <= 12'd0;
  end else begin
    vid_de_q <= vid_de;

    if(enable_dsc)
        s_axis_tvalid_i <= dsc_valid_from_fifo;
    else
        s_axis_tvalid_i <= vid_de;
    if(ycrcb_422)
    begin
    s_axis_tdata_i <= {vid_pixel3[47:48-2*pMAX_BPC],vid_pixel2[47:48-2*pMAX_BPC],vid_pixel1[47:48-2*pMAX_BPC],vid_pixel0[47:48-2*pMAX_BPC]};
    end
    else if (y_only)
    begin
    s_axis_tdata_i <= {vid_pixel3[47:48-pMAX_BPC],vid_pixel2[47:48-pMAX_BPC],vid_pixel1[47:48-pMAX_BPC],vid_pixel0[47:48-pMAX_BPC]};
    end
    else
    begin
        if(enable_dsc)
        begin
            s_axis_tdata_i <= {vid_pixel0_dsc_fifo[23:16],vid_pixel1_dsc_fifo[23:16],vid_pixel2_dsc_fifo[23:16],vid_pixel3_dsc_fifo[23:16],vid_pixel0_dsc_fifo[15: 8],vid_pixel1_dsc_fifo[15: 8],vid_pixel2_dsc_fifo[15: 8],vid_pixel3_dsc_fifo[15: 8],vid_pixel0_dsc_fifo[ 7: 0],vid_pixel1_dsc_fifo[ 7: 0],vid_pixel2_dsc_fifo[ 7: 0],vid_pixel3_dsc_fifo[ 7: 0]};
            //vid_valid_per_pixel_r <= {vid_valid_per_pixel[11],vid_valid_per_pixel[8],vid_valid_per_pixel[5],vid_valid_per_pixel[2],vid_valid_per_pixel[10],vid_valid_per_pixel[7],vid_valid_per_pixel[4],vid_valid_per_pixel[1],vid_valid_per_pixel[9],vid_valid_per_pixel[6],vid_valid_per_pixel[3],vid_valid_per_pixel[0]};
            vid_valid_per_pixel_r   <=  dsc_tkeep_from_fifo;
        end
        else
            s_axis_tdata_i <= {vid_pixel3[47:48-3*pMAX_BPC],vid_pixel2[47:48-3*pMAX_BPC],vid_pixel1[47:48-3*pMAX_BPC],vid_pixel0[47:48-3*pMAX_BPC]};

    end
  end
  end
end else if ( (pPC == 2) && (pUG934_COMPLIANCE == 1)) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
  end else begin
    vid_de_q <= vid_de;

    if(enable_dsc)
        s_axis_tvalid_i <= dsc_valid_from_fifo;
    else
        s_axis_tvalid_i <= vid_de;
    if(ycrcb_422)
    begin
    s_axis_tdata_i <= {vid_pixel1[47:48-2*pMAX_BPC],vid_pixel0[47:48-2*pMAX_BPC]};
    end
    else if (y_only)
    begin
    s_axis_tdata_i <= {vid_pixel1[47:48-pMAX_BPC],vid_pixel0[47:48-pMAX_BPC]};
    end
    else
    begin
        if(enable_dsc)
        begin
            s_axis_tdata_i <= {vid_pixel0_dsc_fifo[23:16],vid_pixel1_dsc_fifo[23:16],vid_pixel0_dsc_fifo[15: 8],vid_pixel1_dsc_fifo[15: 8],vid_pixel0_dsc_fifo[ 7: 0],vid_pixel1_dsc_fifo[ 7: 0]};
            //vid_valid_per_pixel_r <= {6'd0,vid_valid_per_pixel[11],vid_valid_per_pixel[8],vid_valid_per_pixel[10],vid_valid_per_pixel[7],vid_valid_per_pixel[9],vid_valid_per_pixel[6]};
            vid_valid_per_pixel_r   <=  dsc_tkeep_from_fifo;
        end
        else
            s_axis_tdata_i <= {vid_pixel1[47:48-3*pMAX_BPC],vid_pixel0[47:48-3*pMAX_BPC]};
    end
  end
  end
end else if ( (pPC == 1) && (pUG934_COMPLIANCE == 1) ) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
  end else begin
    vid_de_q <= vid_de;

    if(enable_dsc)
        s_axis_tvalid_i <= dsc_valid_from_fifo;
    else
        s_axis_tvalid_i <= vid_de;
    if(ycrcb_422)
    begin
    s_axis_tdata_i <= {vid_pixel0[47:48-2*pMAX_BPC]};
    end
    else if (y_only)
    begin
    s_axis_tdata_i <= {vid_pixel0[47:48-pMAX_BPC]};
    end
    else
    begin
        if(enable_dsc)
        begin
            s_axis_tdata_i <= {vid_pixel0_dsc_fifo[23:16],vid_pixel0_dsc_fifo[15: 8],vid_pixel0_dsc_fifo[ 7: 0]};
            //vid_valid_per_pixel_r <= {9'd0,vid_valid_per_pixel[11],vid_valid_per_pixel[10],vid_valid_per_pixel[9]};
            vid_valid_per_pixel_r   <=  dsc_tkeep_from_fifo;
        end
        else
            s_axis_tdata_i <= {vid_pixel0[47:48-3*pMAX_BPC]};
    end
  end
  end
end else if ( (pPC == 4) && (pUG934_COMPLIANCE == 0) ) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
  end else begin
    vid_de_q <= vid_de;
    s_axis_tvalid_i <= vid_de;
    s_axis_tdata_i <= {vid_pixel3[47:48-3*pMAX_BPC],vid_pixel2[47:48-3*pMAX_BPC],vid_pixel1[47:48-3*pMAX_BPC],vid_pixel0[47:48-3*pMAX_BPC]};
  end
end
end else if ( (pPC == 2) && (pUG934_COMPLIANCE == 0)) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
  end else begin
    vid_de_q <= vid_de;
    s_axis_tvalid_i <= vid_de;
    s_axis_tdata_i <= {vid_pixel1[47:48-3*pMAX_BPC],vid_pixel0[47:48-3*pMAX_BPC]};
  end
end
end else if ( (pPC == 1) && (pUG934_COMPLIANCE == 0) ) begin
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0 || vid_hsync_fe==1'b1) begin
    s_axis_tvalid_i <= 1'b0;
    s_axis_tdata_i  <= 'h0;
    vid_de_q <= 1'b0;
  end else begin
    vid_de_q <= vid_de;
    s_axis_tvalid_i <= vid_de;
    s_axis_tdata_i <= {vid_pixel0[47:48-3*pMAX_BPC]};
  end
end
end
endgenerate


//always @(*)
//begin
//    case(vid_valid_per_pixel_r)
//        12'b000000000000    :    s_axis_tkeep_dsc_int = 4'd0;
//        12'b000000000001    :    s_axis_tkeep_dsc_int = 4'd1; 
//        12'b000000000011    :    s_axis_tkeep_dsc_int = 4'd2; 
//        12'b000000000111    :    s_axis_tkeep_dsc_int = 4'd3; 
//        12'b000000001111    :    s_axis_tkeep_dsc_int = 4'd4; 
//        12'b000000011111    :    s_axis_tkeep_dsc_int = 4'd5; 
//        12'b000000111111    :    s_axis_tkeep_dsc_int = 4'd6; 
//        12'b000001111111    :    s_axis_tkeep_dsc_int = 4'd7; 
//        12'b000011111111    :    s_axis_tkeep_dsc_int = 4'd8; 
//        12'b000111111111    :    s_axis_tkeep_dsc_int = 4'd9; 
//        12'b001111111111    :    s_axis_tkeep_dsc_int = 4'd10; 
//        12'b011111111111    :    s_axis_tkeep_dsc_int = 4'd11; 
//        12'b111111111111    :    s_axis_tkeep_dsc_int = 4'd12; 
//        default             :    s_axis_tkeep_dsc_int = 4'd12;
//    endcase
//end

assign s_axis_tkeep_dsc =   vid_valid_per_pixel_r & {12{enable_dsc}};

assign m_axis_tvalid = m_axis_tvalid_i;
assign m_axis_tdata = m_axis_tdata_i;
assign m_axis_tlast = m_axis_tlast_i;
//assign m_axis_tuser = {7'b0000000,vid_vsync_fe};
assign s_axis_tuser_i = {enable_dsc,s_axis_tkeep_dsc,sof};
assign m_axis_tuser = m_axis_tuser_i;
assign wr_error = axis_overflow_i;
assign rd_error = axis_underflow_i;
//assign fsync_out = vid_vsync_fe;
assign s_axis_tlast_i_w = s_axis_tlast_i_qq;// & vid_de_q;

//always@(posedge vid_pixel_clk) begin
  assign s_axis_tlast_i = s_axis_tlast_i_w;
//end

assign hres_cntr_out = hres_cntr;

assign vid_hsync_fe = ~vid_hsync & vid_hsync_q;
assign vid_hsync_re = vid_hsync & ~vid_hsync_q;
assign vid_vsync_re = vid_vsync & ~vid_vsync_q;
assign vid_vsync_fe = ~vid_vsync & vid_vsync_q;

always@(posedge m_axis_aclk) begin
  m_axis_tkeep <= {(pDW/8){1'b1}};
end

always@(posedge vid_pixel_clk) begin
  //if(auto_clear==1'b0 || vid_vsync_re==1'b1) begin
  if(auto_clear==1'b0 || vid_vsync_fe==1'b1) begin
    vres_cntr_out <= 'h0;
  end else begin
    if(s_axis_tlast_i & s_axis_tvalid_i) begin
      vres_cntr_out <= vres_cntr_out + 1'b1;
    end
  end
end
always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0) begin
    s_axis_tlast_i_q <= 1'b0;
    s_axis_tlast_i_qq <= 1'b0;
    vid_vsync_q <= 1'b0;
    vid_hsync_q <= 1'b0;
    vid_vsync_starts <= 1'b0;
    hres_cntr <= 'h0;  
  end else begin
    vid_vsync_q <= vid_vsync;
    vid_hsync_q <= vid_hsync;
    if (vid_last && enable_dsc)
    s_axis_tlast_i_qq <= dsc_last_from_fifo;	 
    else if (enable_dsc & vid_hsync_fe)
    s_axis_tlast_i_qq <= 1'b0;	 
    else if (!enable_dsc)
    s_axis_tlast_i_qq <= s_axis_tlast_i_q;	 

    if(vid_hsync_fe==1'b1) begin
      hres_cntr <= 'h0;  
      s_axis_tlast_i_q <= 1'b0;
    end else begin
      if(vid_de) hres_cntr <= hres_cntr + pixel_mode;
      if((hres_cntr >= hres-pixel_mode-pixel_mode) && vid_de==1'b1) begin
          s_axis_tlast_i_q <= 1'b1;	 
      end else if((hres_cntr >= hres-pixel_mode) && vid_de==1'b1) begin
          s_axis_tlast_i_q <= 1'b0;	 
      end
    end


    if(vid_vsync_re) begin
      vid_vsync_starts <= 1'b1;
    end else if(vid_vsync_starts==1'b1 && vid_de==1'b1) begin
      vid_vsync_starts <= 1'b0;
    end

  end

end

always@(posedge vid_pixel_clk) begin
  if(auto_clear==1'b0) begin
    sof <= 1'b0;
  end else begin
    if(enable_dsc)
    begin
        if(sof == 1'b1) begin
          sof <= 1'b0;
        end else if(dsc_sof_from_fifo) begin
          sof <= 1'b1;
        end
    end
    else
    begin
        if(sof == 1'b1) begin
          sof <= 1'b0;
        end else if(vid_vsync_starts==1'b1 && vid_de==1'b1) begin
          sof <= 1'b1;
        end
    end
  end
end  

assign sof_int  =   (vid_vsync_starts==1'b1) & (vid_de==1'b1);

dp_videoaxi4s_bridge_v1_0_1_axis 
#(
.FIFO_WIDTH (FIFO_BUS_WIDTH ),
.FAMILY (pFAMILY)
) dp_videoaxi4s_bridge_v1_0_1_axis_inst 
(
  .s_aclk(vid_pixel_clk), // input s_aclk
  .s_aresetn(auto_clear), // input s_aresetn
  .s_axis_tvalid(s_axis_tvalid_i), // input s_axis_tvalid
  .s_axis_tready(s_axis_tready_i), // output s_axis_tready
  .s_axis_tdata(s_axis_tdata_fifo_in), // input [191 : 0] s_axis_tdata
  .s_axis_tuser(s_axis_tuser_i), // input [7 : 0] s_axis_tuser
  .s_axis_tlast(s_axis_tlast_i|s_axis_tlast_i_w), // input s_axis_tlast
  .m_aclk(m_axis_aclk), // input s_aclk
  .m_axis_tvalid(m_axis_tvalid_i), // output m_axis_tvalid
  .m_axis_tready(m_axis_tready), // input m_axis_tready
  .m_axis_tdata(m_axis_tdata_fifo_out), // output [191 : 0] m_axis_tdata
  .m_axis_tuser(m_axis_tuser_i), // output [7 : 0] m_axis_tuser
  .m_axis_tlast(m_axis_tlast_i), // output m_axis_tlast
  .axis_overflow(axis_overflow_i), // output axis_overflow
  .axis_underflow(axis_underflow_i),// output axis_underflow
  .axis_data_count()                          
);

assign debug_port = {s_axis_tlast_i_w, s_axis_tlast_i, 2'b0, s_axis_tvalid_i};

always@(posedge m_axis_aclk) begin
  if(m_axis_tuser_i[0]==1'b1 && m_axis_tvalid_i==1'b1) begin
    sof_sof_count <= 1'b0;
  end else begin
    sof_sof_count <= sof_sof_count+1'b1;
  end
end

always@(posedge m_axis_aclk) begin
  if(m_axis_tlast_i==1'b1 && m_axis_tvalid_i==1'b1) begin
    eol_eol_count <= 1'b0;
  end else begin
    eol_eol_count <= eol_eol_count+1'b1;
  end
end




endmodule


`timescale 1ns / 1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
module dp_videoaxi4s_bridge_v1_0_1_dsc_fifo
#(
    parameter   pDSC_READ_BYTES = 12,
    parameter   pENABLE_DSC_DUMMY_BYTES_IN_RX = 0
)
(
    input                               vid_pixel_clk,
    input                               enable_dsc,
    input                               auto_clear,
    input   [(pDSC_READ_BYTES*8)-1:0]   data_in,
    input   [11:0]                      data_valid,
    input                               data_last,
    input                               we,
    input                               vid_hsync_fe,
    input   [2:0]                       lanes,
    input                               sof,
    output  [5:0]                       rd_wr_diff,
    output                              last_from_fifo,
    output  reg                         valid_from_fifo,
    output  reg [11:0]                  tkeep_from_fifo,
    output  reg [((pDSC_READ_BYTES*8)+(pDSC_READ_BYTES*2))-1:0] data_out
);

wire [3:0] fifo_cnt_incr;
reg  [9:0] data_fifo    [0:127];
reg        re;
reg        data_last_level;
reg        data_last_level_q;
reg        data_last_invalid;
reg        last_re;
reg  [6:0] wr_cnt;
reg  [6:0] wr_cnt_q;
reg  [6:0] wr_cnt_latch;
reg  [6:0] rd_cnt;
reg        last_from_fifo_int;
reg        last_from_fifo_int_q;
reg  [6:0] wr_cnt_array_0  ;
reg  [6:0] wr_cnt_array_1  ;
reg  [6:0] wr_cnt_array_2  ;
reg  [6:0] wr_cnt_array_3  ;
reg  [6:0] wr_cnt_array_4  ;
reg  [6:0] wr_cnt_array_5  ;
reg  [6:0] wr_cnt_array_6  ;
reg  [6:0] wr_cnt_array_7  ;
reg  [6:0] wr_cnt_array_8  ;
reg  [6:0] wr_cnt_array_9  ;
reg  [6:0] wr_cnt_array_10 ;
reg  [6:0] wr_cnt_array_11 ;
reg  [6:0] wr_cnt_array_last_0 ;

reg  [6:0] rd_cnt_array_0  ;
reg  [6:0] rd_cnt_array_1  ;
reg  [6:0] rd_cnt_array_2  ;
reg  [6:0] rd_cnt_array_3  ;
reg  [6:0] rd_cnt_array_4  ;
reg  [6:0] rd_cnt_array_5  ;
reg  [6:0] rd_cnt_array_6  ;
reg  [6:0] rd_cnt_array_7  ;
reg  [6:0] rd_cnt_array_8  ;
reg  [6:0] rd_cnt_array_9  ;
reg  [6:0] rd_cnt_array_10 ;
reg  [6:0] rd_cnt_array_11 ;
reg  [6:0] rd_cnt_array_12 ;
reg  [6:0] rd_cnt_array_13 ;
reg  [6:0] rd_cnt_array_14 ;
reg  [6:0] rd_cnt_array_15 ;
reg  [6:0] rd_cnt_array_16 ;
reg  [6:0] rd_cnt_array_17 ;
reg  [6:0] rd_cnt_array_18 ;
reg  [6:0] rd_cnt_array_19 ;
reg  [6:0] rd_cnt_array_20 ;
reg  [6:0] rd_cnt_array_21 ;
reg  [6:0] rd_cnt_array_22 ;
reg  [6:0] rd_cnt_array_23 ;

integer k;
wire [11:0] data_valid_except_eoc;
reg  [11:0] data_valid_except_eoc_q;


//Initial registering of the inputs

reg                                enable_dsc_q          ; 
reg    [(pDSC_READ_BYTES*8)-1:0]   data_in_q             ; 
reg    [11:0]                      data_valid_q          ; 
reg                                data_last_q           ; 
reg                                we_q                  ; 
reg                                vid_hsync_fe_q        ; 
reg    [2:0]                       lanes_q               ; 
reg                                sof_q                 ;
wire                               dual_lane             ;
wire                               quad_lane             ;


generate if(pENABLE_DSC_DUMMY_BYTES_IN_RX == 0)
begin

    always @(posedge vid_pixel_clk)
    begin
        if(~auto_clear)
        begin
            enable_dsc_q       <=   1'd0                        ;     
            data_in_q          <=   {pDSC_READ_BYTES{1'b0}}     ;    
            data_valid_q       <=   12'd0                       ;
            data_last_q        <=   1'd0                        ;
            we_q               <=   1'd0                        ;    
            vid_hsync_fe_q     <=   1'd0                        ;    
            lanes_q            <=   3'd0                        ;
            sof_q              <=   1'd0                        ;
            wr_cnt_array_0     <=   7'd0                        ; 
            wr_cnt_array_1     <=   7'd0                        ;    
            wr_cnt_array_2     <=   7'd0                        ;    
            wr_cnt_array_3     <=   7'd0                        ;    
            wr_cnt_array_4     <=   7'd0                        ;    
            wr_cnt_array_5     <=   7'd0                        ;    
            wr_cnt_array_6     <=   7'd0                        ;    
            wr_cnt_array_7     <=   7'd0                        ;        
            wr_cnt_array_8     <=   7'd0                        ;    
            wr_cnt_array_9     <=   7'd0                        ;    
            wr_cnt_array_10    <=   7'd0                        ;    
            wr_cnt_array_11    <=   7'd0                        ;
        end
        else
        begin
            enable_dsc_q    <=   enable_dsc        ;     
            data_in_q       <=   data_in           ;    
            data_valid_q    <=   data_valid        ;
            data_last_q     <=   data_last         ;
            we_q            <=   we                ;    
            vid_hsync_fe_q  <=   vid_hsync_fe      ;    
            lanes_q         <=   lanes             ;
            sof_q           <=   sof               ;
            wr_cnt_q        <=   wr_cnt            ; 
            wr_cnt_array_0  <=   (wr_cnt - 7'd1) + data_valid[11]    ;
            wr_cnt_array_1  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10]   ;
            wr_cnt_array_2  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9]   ;
            wr_cnt_array_3  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8]    ;
            wr_cnt_array_4  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7]    ;
            wr_cnt_array_5  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6]   ;
            wr_cnt_array_6  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5]  ;
            wr_cnt_array_7  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5] + data_valid[4] ;
            wr_cnt_array_8  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5] + data_valid[4] + data_valid[3];
            wr_cnt_array_9  <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5] + data_valid[4] + data_valid[3] + data_valid[2];
            wr_cnt_array_10 <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5] + data_valid[4] + data_valid[3] + data_valid[2] + data_valid[1];
            wr_cnt_array_11 <=   (wr_cnt - 7'd1) + data_valid[11] + data_valid[10] + data_valid[9] + data_valid[8] + data_valid[7] + data_valid[6] + data_valid[5] + data_valid[4] + data_valid[3] + data_valid[2] + data_valid[1] + data_valid[0];
    
            wr_cnt_array_last_0 <= wr_cnt  - 7'd1         ;   
        end
    end
    
    assign fifo_cnt_incr    =   data_valid[0] + data_valid[1] + data_valid[2] + data_valid[3] +
                                data_valid[4] + data_valid[5] + data_valid[6] + data_valid[7] +
                                data_valid[8] + data_valid[9] + data_valid[10] + data_valid[11];
    
    
    
    assign last_from_fifo     =   last_from_fifo_int & ~last_from_fifo_int_q;
    //assign rd_wr_diff       =   rd_cnt[5:0] - wr_cnt[5:0];  
    assign rd_wr_diff         =   (rd_cnt - wr_cnt_latch);  
    
    
    always @(*)
    begin
        rd_cnt_array_0  =  rd_cnt[6:0]         ;
        rd_cnt_array_1  =  rd_cnt[6:0] + 7'd1  ;
        rd_cnt_array_2  =  rd_cnt[6:0] + 7'd2  ;
        rd_cnt_array_3  =  rd_cnt[6:0] + 7'd3  ;
        rd_cnt_array_4  =  rd_cnt[6:0] + 7'd4  ;
        rd_cnt_array_5  =  rd_cnt[6:0] + 7'd5  ;
        rd_cnt_array_6  =  rd_cnt[6:0] + 7'd6  ;
        rd_cnt_array_7  =  rd_cnt[6:0] + 7'd7  ;
        rd_cnt_array_8  =  rd_cnt[6:0] + 7'd8  ;
        rd_cnt_array_9  =  rd_cnt[6:0] + 7'd9  ;
        rd_cnt_array_10 =  rd_cnt[6:0] + 7'd10 ;
        rd_cnt_array_11 =  rd_cnt[6:0] + 7'd11 ;
        rd_cnt_array_12 =  rd_cnt[6:0] + 7'd12 ;
        rd_cnt_array_13 =  rd_cnt[6:0] + 7'd13 ;
        rd_cnt_array_14 =  rd_cnt[6:0] + 7'd14 ;
        rd_cnt_array_15 =  rd_cnt[6:0] + 7'd15 ;
        rd_cnt_array_16 =  rd_cnt[6:0] + 7'd16 ;
        rd_cnt_array_17 =  rd_cnt[6:0] + 7'd17 ;
        rd_cnt_array_18 =  rd_cnt[6:0] + 7'd18 ;
        rd_cnt_array_19 =  rd_cnt[6:0] + 7'd19 ;
        rd_cnt_array_20 =  rd_cnt[6:0] + 7'd20 ;
        rd_cnt_array_21 =  rd_cnt[6:0] + 7'd21 ;
        rd_cnt_array_22 =  rd_cnt[6:0] + 7'd22 ;
        rd_cnt_array_23 =  rd_cnt[6:0] + 7'd23 ;
    
    end
    
    if(pDSC_READ_BYTES == 12)
    begin
    
        always @(*)
        begin
            if(lanes_q == 3'd4)
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                                data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8] |
                                data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                                data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]               
                               ) &
                                ~(data_fifo[rd_cnt_array_12][8] | data_fifo[rd_cnt_array_13][8] | data_fifo[rd_cnt_array_14][8] |
                                data_fifo[rd_cnt_array_15][8] | data_fifo[rd_cnt_array_16][8] | data_fifo[rd_cnt_array_17][8] |
                                data_fifo[rd_cnt_array_18][8] | data_fifo[rd_cnt_array_19][8] | data_fifo[rd_cnt_array_20][8] |
                                data_fifo[rd_cnt_array_21][8] | data_fifo[rd_cnt_array_22][8] | data_fifo[rd_cnt_array_23][8]
                               );
            end
            else if (lanes_q == 3'd2)
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                                data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]) &
                                ~(data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                                data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]);
            end
            else
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                               ) &
                                ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                               );
            end
        end
        
        always @(*)
        begin
            if(last_from_fifo)
            begin
                if(lanes_q == 3'd4)
                begin
                    case(rd_wr_diff[4:0])
                       5'd0  : tkeep_from_fifo   = 12'b111111111111; 
                       5'd1  : tkeep_from_fifo   = 12'b111111111110; 
                       5'd2  : tkeep_from_fifo   = 12'b111111111100; 
                       5'd3  : tkeep_from_fifo   = 12'b111111111000; 
                       5'd4  : tkeep_from_fifo   = 12'b111111110000; 
                       5'd5  : tkeep_from_fifo   = 12'b111111100000; 
                       5'd6  : tkeep_from_fifo   = 12'b111111000000; 
                       5'd7  : tkeep_from_fifo   = 12'b111110000000; 
                       5'd8  : tkeep_from_fifo   = 12'b111100000000; 
                       5'd9  : tkeep_from_fifo   = 12'b111000000000; 
                       5'd10 : tkeep_from_fifo   = 12'b110000000000;
                       5'd11 : tkeep_from_fifo   = 12'b100000000000;
                       5'd12 : tkeep_from_fifo   = 12'b000000000000;
                       default:tkeep_from_fifo   = 12'b111111111111;
                    endcase
                end
                else if(lanes_q == 3'd2)
                begin
                    case(rd_wr_diff[4:0])
                       5'd0  : tkeep_from_fifo   = 12'b110011001100; 
                       5'd1  : tkeep_from_fifo   = 12'b110011001000; 
                       5'd2  : tkeep_from_fifo   = 12'b110011000000; 
                       5'd3  : tkeep_from_fifo   = 12'b110010000000; 
                       5'd4  : tkeep_from_fifo   = 12'b110000000000; 
                       5'd5  : tkeep_from_fifo   = 12'b100000000000; 
                       5'd6  : tkeep_from_fifo   = 12'b000000000000; 
                       default:tkeep_from_fifo   = 12'b110011001100;
                    endcase
                end
                else
                begin
                    case(rd_wr_diff[4:0])
                       5'd0  : tkeep_from_fifo   = 12'b100010001000; 
                       5'd1  : tkeep_from_fifo   = 12'b100010000000; 
                       5'd2  : tkeep_from_fifo   = 12'b100000000000; 
                       5'd3  : tkeep_from_fifo   = 12'b000000000000; 
                       default:tkeep_from_fifo   = 12'b100010001000;
                    endcase
                end
            end
            else
            begin
                if(lanes_q == 3'd4)
                   tkeep_from_fifo   = 12'b111111111111;
                else if(lanes_q == 3'd2)
                   tkeep_from_fifo   = 12'b110011001100;
                else
                   tkeep_from_fifo   = 12'b100010001000;
            end
        end
        always @(posedge vid_pixel_clk)
        begin
            if(~auto_clear)
            begin
                for(k=0; k<63; k=k+1)
                    data_fifo[k]    <=  10'd0;
                wr_cnt              <=  7'd0;
                rd_cnt              <=  7'd0;
                re                  <=  1'b0;
                data_last_level     <=  1'b0;
                data_last_level_q   <=  1'b0;
                data_out            <=   'h0;  
                wr_cnt_latch        <=   6'd0;
                last_from_fifo_int  <=   1'b0;
                last_from_fifo_int_q<=   1'b0;
                valid_from_fifo     <=  1'b0;
                //tkeep_from_fifo     <= 12'b000000000000; 
            end
            else if(enable_dsc_q) 
            begin
                last_from_fifo_int_q      <=  last_from_fifo_int;
                if(data_last && we)
                    data_last_level   <=  1'b1 ;
                else if(vid_hsync_fe)
                    data_last_level   <=  1'b0 ;
    
                if(data_last_q && we_q)
                    data_last_level_q   <=  1'b1 ;
                else if(vid_hsync_fe_q)
                    data_last_level_q   <=  1'b0 ;
    
    
                if(last_re)
                begin
                    re                  <=   1'b0;
                end
    //By checking whether we_cnt_q is >= 60, we are waiting for 72 bytes to be written in to FIFO before the first read. This will make sure that even in the worst case if we get 49 invalid data (3 dummy, 4 EOCs and 7 slice ends in the case of 8 slices, (3+4)*7), still the data that will be left in FIFO will be 72-49 = 23 which is more than 12 (bytes per clock in 4 lane mode) Similarly 30 and 15 values are fixed for other lanes.
                else if(we_q && (lanes_q == 3'd4) && (wr_cnt_q[6:0] >= 7'd60)) 
                begin
                    re  <=   1'b1;
                end
                else if(we_q && (lanes_q == 3'd2) && (wr_cnt_q[6:0] >= 7'd30))
                begin
                    re  <=   1'b1;
                end
                else if(we_q && (lanes_q == 3'd1) && (wr_cnt_q[6:0] >= 7'd15))
                begin
                    re  <=   1'b1;
                end
    
                //if(vid_hsync_fe)
                //   data_last_invalid    <=  1'b0;
                //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
                //   data_last_invalid    <=  1'b1;
    
    
       
                if(vid_hsync_fe_q || ~data_last_level_q)
                    last_from_fifo_int  <=   1'b0;
                else if(last_re)            
                    last_from_fifo_int  <=   1'b1;
        
        //Write logic
                if(we_q)
                begin
                    if(data_valid_q[11]) data_fifo[wr_cnt_array_0 ]  <=  {sof_q,data_last_q,data_in_q[95:88]}; 
                    if(data_valid_q[10]) data_fifo[wr_cnt_array_1 ]  <=  {sof_q,data_last_q,data_in_q[87:80]}; 
                    if(data_valid_q[9])  data_fifo[wr_cnt_array_2 ]  <=  {sof_q,data_last_q,data_in_q[79:72]}; 
                    if(data_valid_q[8])  data_fifo[wr_cnt_array_3 ]  <=  {sof_q,data_last_q,data_in_q[71:64]}; 
                    if(data_valid_q[7])  data_fifo[wr_cnt_array_4 ]  <=  {sof_q,data_last_q,data_in_q[63:56]}; 
                    if(data_valid_q[6])  data_fifo[wr_cnt_array_5 ]  <=  {sof_q,data_last_q,data_in_q[55:48]}; 
                    if(data_valid_q[5])  data_fifo[wr_cnt_array_6 ]  <=  {sof_q,data_last_q,data_in_q[47:40]}; 
                    if(data_valid_q[4])  data_fifo[wr_cnt_array_7 ]  <=  {sof_q,data_last_q,data_in_q[39:32]}; 
                    if(data_valid_q[3])  data_fifo[wr_cnt_array_8 ]  <=  {sof_q,data_last_q,data_in_q[31:24]}; 
                    if(data_valid_q[2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                    if(data_valid_q[1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                    if(data_valid_q[0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]}; 
    
                    if(~(|(data_valid_q)))
                    begin
                        data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                    end
                end
                if(~data_last_level && we)
                    wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
                else if (vid_hsync_fe)
                    wr_cnt  <=   7'd0;
        
                if(data_last_q && ~data_last_level_q)
                    wr_cnt_latch    <=  wr_cnt ;
                else if (vid_hsync_fe_q)
                    wr_cnt_latch    <=   7'd0;
       
        
        
        //Read logic
                if((re && we_q) || (data_last_level_q && re))
                begin
                    if(lanes_q == 3'd4)
                    begin
                        data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                        data_out[109:100] <=  data_fifo[rd_cnt_array_1 ];  
                        data_out[ 99: 90] <=  data_fifo[rd_cnt_array_2 ];  
                        data_out[ 89: 80] <=  data_fifo[rd_cnt_array_3 ];  
                        data_out[ 79: 70] <=  data_fifo[rd_cnt_array_4 ];  
                        data_out[ 69: 60] <=  data_fifo[rd_cnt_array_5 ];  
                        data_out[ 59: 50] <=  data_fifo[rd_cnt_array_6 ];  
                        data_out[ 49: 40] <=  data_fifo[rd_cnt_array_7 ];  
                        data_out[ 39: 30] <=  data_fifo[rd_cnt_array_8 ];  
                        data_out[ 29: 20] <=  data_fifo[rd_cnt_array_9 ];  
                        data_out[ 19: 10] <=  data_fifo[rd_cnt_array_10];  
                        data_out[  9:  0] <=  data_fifo[rd_cnt_array_11];
                    end
                    else if(lanes_q == 3'd2)
                    begin
                        data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                        data_out[109:100] <=  data_fifo[rd_cnt_array_1 ];  
                        data_out[ 99: 90] <=  10'd0;  
                        data_out[ 89: 80] <=  10'd0;  
                        data_out[ 79: 70] <=  data_fifo[rd_cnt_array_2 ];  
                        data_out[ 69: 60] <=  data_fifo[rd_cnt_array_3 ];  
                        data_out[ 59: 50] <=  10'd0;  
                        data_out[ 49: 40] <=  10'd0;  
                        data_out[ 39: 30] <=  data_fifo[rd_cnt_array_4 ];  
                        data_out[ 29: 20] <=  data_fifo[rd_cnt_array_5 ];  
                        data_out[ 19: 10] <=  10'd0;  
                        data_out[  9:  0] <=  10'd0;
                    end
                    else
                    begin
                        data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                        data_out[109:100] <=  10'd0;  
                        data_out[ 99: 90] <=  10'd0;  
                        data_out[ 89: 80] <=  10'd0;  
                        data_out[ 79: 70] <=  data_fifo[rd_cnt_array_1 ];  
                        data_out[ 69: 60] <=  10'd0;  
                        data_out[ 59: 50] <=  10'd0;  
                        data_out[ 49: 40] <=  10'd0;  
                        data_out[ 39: 30] <=  data_fifo[rd_cnt_array_2 ];  
                        data_out[ 29: 20] <=  10'd0;  
                        data_out[ 19: 10] <=  10'd0;  
                        data_out[  9:  0] <=  10'd0;
                    end
    
                    valid_from_fifo   <=  1'b1;
                end
                else
                begin
                    valid_from_fifo   <=  1'b0;
                end
                if((re && we_q) || (data_last_level_q && re))
                begin
                    if(lanes_q == 3'd4)
                        rd_cnt      <=      rd_cnt + 7'd12;
                    else if(lanes_q == 3'd2)
                        rd_cnt      <=      rd_cnt + 7'd6;
                    else
                        rd_cnt      <=      rd_cnt + 7'd3;
                end
                else if (vid_hsync_fe_q)
                    rd_cnt      <=      7'd0;
            end
        end
    end
    else if(pDSC_READ_BYTES == 6)
    begin
        always @(*)
        begin
            if (lanes_q == 3'd2)
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                                data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]) &
                                ~(data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                                data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]);
            end
            else
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                               ) &
                                ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                               );
            end
        end
    
        always @(*)
        begin
            if(last_from_fifo)
            begin
                if(lanes_q == 3'd2)
                begin
                    case(rd_wr_diff[4:0])
                       5'd0  : tkeep_from_fifo   = 12'b000000111111; 
                       5'd1  : tkeep_from_fifo   = 12'b000000111110; 
                       5'd2  : tkeep_from_fifo   = 12'b000000111100; 
                       5'd3  : tkeep_from_fifo   = 12'b000000111000; 
                       5'd4  : tkeep_from_fifo   = 12'b000000110000; 
                       5'd5  : tkeep_from_fifo   = 12'b000000100000; 
                       5'd6  : tkeep_from_fifo   = 12'b000000000000; 
                       default:tkeep_from_fifo   = 12'b000000111111;
                    endcase
                end
                else
                begin
                    case(rd_wr_diff[4:0])
                       5'd0  : tkeep_from_fifo   = 12'b000000101010; 
                       5'd1  : tkeep_from_fifo   = 12'b000000101000; 
                       5'd2  : tkeep_from_fifo   = 12'b000000100000; 
                       5'd3  : tkeep_from_fifo   = 12'b000000000000; 
                       default:tkeep_from_fifo   = 12'b000000101010;
                    endcase
                end
            end
            else
            begin
                if(lanes_q == 3'd2)
                   tkeep_from_fifo   = 12'b000000111111;
                else
                   tkeep_from_fifo   = 12'b000000101010;
            end
        end
        always @(posedge vid_pixel_clk)
        begin
            if(~auto_clear)
            begin
                for(k=0; k<63; k=k+1)
                    data_fifo[k]    <=  10'd0;
                wr_cnt              <=  7'd0;
                rd_cnt              <=  7'd0;
                re                  <=  1'b0;
                data_last_level     <=  1'b0;
                data_last_level_q   <=  1'b0;
                data_out            <=   'h0;  
                wr_cnt_latch        <=   6'd0;
                last_from_fifo_int  <=   1'b0;
                last_from_fifo_int_q<=   1'b0;
                valid_from_fifo     <=  1'b0;
                //data_last_invalid   <=  1'b0;
            end
            else if(enable_dsc_q) 
            begin
                last_from_fifo_int_q      <=  last_from_fifo_int;
                if(data_last && we)
                    data_last_level   <=  1'b1 ;
                else if(vid_hsync_fe)
                    data_last_level   <=  1'b0 ;
    
                if(data_last_q && we_q)
                    data_last_level_q   <=  1'b1 ;
                else if(vid_hsync_fe_q)
                    data_last_level_q   <=  1'b0 ;
        
                if(last_re)
                begin
                    re                  <=   1'b0;
                end
                else if(we_q && (lanes_q == 3'd2) && (wr_cnt_q[6:0] >= 7'd30))
                begin
                    re  <=   1'b1;
                end
                else if(we_q && (lanes_q == 3'd1) && (wr_cnt_q[6:0] >= 7'd15))
                begin
                    re  <=   1'b1;
                end
    
                //if(vid_hsync_fe)
                //   data_last_invalid    <=  1'b0;
                //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
                //   data_last_invalid    <=  1'b1;
    
    
       
                if(vid_hsync_fe_q || ~data_last_level_q)
                    last_from_fifo_int  <=   1'b0;
                else if(last_re)            
                    last_from_fifo_int  <=   1'b1;
        //Write logic
                if(we_q)
                begin
                    if(data_valid_q[ 5])  data_fifo[wr_cnt_array_6 ]  <=  {sof_q,data_last_q,data_in_q[47:40]}; 
                    if(data_valid_q[ 4])  data_fifo[wr_cnt_array_7 ]  <=  {sof_q,data_last_q,data_in_q[39:32]}; 
                    if(data_valid_q[ 3])  data_fifo[wr_cnt_array_8 ]  <=  {sof_q,data_last_q,data_in_q[31:24]}; 
                    if(data_valid_q[ 2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                    if(data_valid_q[ 1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                    if(data_valid_q[ 0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]};
    
    
                    if(~(|(data_valid_q)))
                    begin
                        data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                    end
                    
                end
                if(~data_last_level && we)
                    wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
                else if (vid_hsync_fe)
                    wr_cnt  <=   7'd0;
        
                if(data_last_q && ~data_last_level_q)
                    wr_cnt_latch    <=  wr_cnt;
                else if (vid_hsync_fe_q)
                    wr_cnt_latch    <=   7'd0;
       
        //Read logic
                if((re && we_q) || (data_last_level_q && re))
                begin
                    if(lanes_q == 3'd2)
                    begin
                        data_out[ 59: 50] <=  data_fifo[rd_cnt_array_0 ];  
                        data_out[ 49: 40] <=  data_fifo[rd_cnt_array_1 ];  
                        data_out[ 39: 30] <=  data_fifo[rd_cnt_array_2 ];  
                        data_out[ 29: 20] <=  data_fifo[rd_cnt_array_3 ];  
                        data_out[ 19: 10] <=  data_fifo[rd_cnt_array_4 ];  
                        data_out[  9:  0] <=  data_fifo[rd_cnt_array_5 ]; 
                    end
                    else
                    begin
                        data_out[ 59: 50] <=  data_fifo[rd_cnt_array_0 ];  
                        data_out[ 49: 40] <=  10'd0;  
                        data_out[ 39: 30] <=  data_fifo[rd_cnt_array_1 ];  
                        data_out[ 29: 20] <=  10'd0;  
                        data_out[ 19: 10] <=  data_fifo[rd_cnt_array_2 ];  
                        data_out[  9:  0] <=  10'd0; 
                    end
                        
                        valid_from_fifo   <=  1'b1;
                end
                else
                begin
                    valid_from_fifo   <=  1'b0;
                end
                if((re && we_q) || (data_last_level_q && re))
                    if(lanes_q == 3'd2)
                        rd_cnt      <=      rd_cnt + 7'd6;
                    else
                        rd_cnt      <=      rd_cnt + 7'd3;
                else if (vid_hsync_fe_q)
                    rd_cnt      <=      7'd0;
            end
        end
    end
    else if(pDSC_READ_BYTES == 3)
    begin
    
        always @(*)
        begin
            if(lanes_q == 3'd1)
            begin
               last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                               ) &
                                ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                               );
            end
            else
            begin
               last_re     =   1'b0;
            end
    
        end
    
        always @(*)
        begin
            if(last_from_fifo)
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b000000000111; 
                   5'd1  : tkeep_from_fifo   = 12'b000000000110; 
                   5'd2  : tkeep_from_fifo   = 12'b000000000100; 
                   5'd3  : tkeep_from_fifo   = 12'b000000000000; 
                   default:tkeep_from_fifo   = 12'b000000000111;
                endcase
            end
            else
                   tkeep_from_fifo   = 12'b000000000111;
        end
        always @(posedge vid_pixel_clk)
        begin
            if(~auto_clear)
            begin
                for(k=0; k<63; k=k+1)
                    data_fifo[k]    <=  10'd0;
                wr_cnt              <=  7'd0;
                rd_cnt              <=  7'd0;
                re                  <=  1'b0;
                data_last_level     <=  1'b0;
                data_last_level_q   <=  1'b0;
                data_out            <=   'h0;  
                wr_cnt_latch        <=   6'd0;
                last_from_fifo_int  <=   1'b0;
                last_from_fifo_int_q<=   1'b0;
                valid_from_fifo     <=  1'b0;
            end
            else if(enable_dsc_q) 
            begin
                last_from_fifo_int_q      <=  last_from_fifo_int;
                if(data_last && we)
                    data_last_level   <=  1'b1 ;
                else if(vid_hsync_fe)
                    data_last_level   <=  1'b0 ;
    
                if(data_last_q && we_q)
                    data_last_level_q   <=  1'b1 ;
                else if(vid_hsync_fe_q)
                    data_last_level_q   <=  1'b0 ;
        
                if(last_re)
                begin
                    re                  <=   1'b0;
                end
                else if(we_q && (wr_cnt_q[6:0] >= 7'd15))
                begin
                    re  <=   1'b1;
                end
    
                //if(vid_hsync_fe)
                //   data_last_invalid    <=  1'b0;
                //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
                //   data_last_invalid    <=  1'b1;
    
    
       
                if(vid_hsync_fe_q || ~data_last_level_q)
                    last_from_fifo_int  <=   1'b0;
                else if(last_re)            
                    last_from_fifo_int  <=   1'b1;
    
        //Write logic
                if(we_q)
                begin
                    if(data_valid_q[ 2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                    if(data_valid_q[ 1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                    if(data_valid_q[ 0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]};
    
    
                    if(~(|(data_valid_q)))
                    begin
                        data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                    end
                end
                if(~data_last_level && we)
                    wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
                else if (vid_hsync_fe)
                    wr_cnt  <=   7'd0;
        
                if(data_last_q && ~data_last_level_q)
                    wr_cnt_latch    <=  wr_cnt;
                else if (vid_hsync_fe_q)
                    wr_cnt_latch    <=   7'd0;
       
        
        //Read logic
                if((re && we_q) || (data_last_level_q && re))
                begin
                    data_out[ 29: 20] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[ 19: 10] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[  9:  0] <=  data_fifo[rd_cnt_array_2 ];  
                    
                    valid_from_fifo   <=  1'b1;
                end
                else
                begin
                    valid_from_fifo   <=  1'b0;
                end
                if((re && we_q) || (data_last_level_q && re))
                    rd_cnt      <=      rd_cnt + 7'd3;
                else if (vid_hsync_fe_q)
                    rd_cnt      <=      7'd0;
            end
        end
    end
    
end
else if (pENABLE_DSC_DUMMY_BYTES_IN_RX == 1)
begin
assign dual_lane    =   lanes == 3'd2;
assign quad_lane    =   lanes == 3'd4;

if(pDSC_READ_BYTES == 12)
begin
    assign  data_valid_except_eoc[11]  =   data_valid[11] | (~data_valid[11] & (data_in[95:88] != 8'hdc));
    assign  data_valid_except_eoc[10]  =   data_valid[10] | (~data_valid[10] & (data_in[87:80] != 8'hdc) & (dual_lane | quad_lane));
    assign  data_valid_except_eoc[ 9]  =   data_valid[ 9] | (~data_valid[ 9] & (data_in[79:72] != 8'hdc) & quad_lane);
    assign  data_valid_except_eoc[ 8]  =   data_valid[ 8] | (~data_valid[ 8] & (data_in[71:64] != 8'hdc) & quad_lane);
    assign  data_valid_except_eoc[ 7]  =   data_valid[ 7] | (~data_valid[ 7] & (data_in[63:56] != 8'hdc) & data_valid_except_eoc[11]); 
    assign  data_valid_except_eoc[ 6]  =   data_valid[ 6] | (~data_valid[ 6] & (data_in[55:48] != 8'hdc) & data_valid_except_eoc[11] & (dual_lane | quad_lane)); 
    assign  data_valid_except_eoc[ 5]  =   data_valid[ 5] | (~data_valid[ 5] & (data_in[47:40] != 8'hdc) & data_valid_except_eoc[11] & quad_lane); 
    assign  data_valid_except_eoc[ 4]  =   data_valid[ 4] | (~data_valid[ 4] & (data_in[39:32] != 8'hdc) & data_valid_except_eoc[11] & quad_lane); 
    assign  data_valid_except_eoc[ 3]  =   data_valid[ 3] | (~data_valid[ 3] & (data_in[31:24] != 8'hdc) & data_valid_except_eoc[11] & data_valid_except_eoc[7]);
    assign  data_valid_except_eoc[ 2]  =   data_valid[ 2] | (~data_valid[ 2] & (data_in[23:16] != 8'hdc) & data_valid_except_eoc[11] & data_valid_except_eoc[7] & (dual_lane | quad_lane));
    assign  data_valid_except_eoc[ 1]  =   data_valid[ 1] | (~data_valid[ 1] & (data_in[15: 8] != 8'hdc) & data_valid_except_eoc[11] & data_valid_except_eoc[7] & quad_lane);
    assign  data_valid_except_eoc[ 0]  =   data_valid[ 0] | (~data_valid[ 0] & (data_in[ 7: 0] != 8'hdc) & data_valid_except_eoc[11] & data_valid_except_eoc[7] & quad_lane);
end
else if (pDSC_READ_BYTES == 6)
begin
    assign  data_valid_except_eoc[11]  =   data_valid[11]; 
    assign  data_valid_except_eoc[10]  =   data_valid[10]; 
    assign  data_valid_except_eoc[ 9]  =   data_valid[ 9]; 
    assign  data_valid_except_eoc[ 8]  =   data_valid[ 8]; 
    assign  data_valid_except_eoc[ 7]  =   data_valid[ 7]; 
    assign  data_valid_except_eoc[ 6]  =   data_valid[ 6]; 
    assign  data_valid_except_eoc[ 5]  =   data_valid[ 5] | (~data_valid[ 5] & (data_in[47:40] != 8'hdc));
    assign  data_valid_except_eoc[ 4]  =   data_valid[ 4] | (~data_valid[ 4] & (data_in[39:32] != 8'hdc) & dual_lane);
    assign  data_valid_except_eoc[ 3]  =   data_valid[ 3] | (~data_valid[ 3] & (data_in[31:24] != 8'hdc) & data_valid_except_eoc[5]); 
    assign  data_valid_except_eoc[ 2]  =   data_valid[ 2] | (~data_valid[ 2] & (data_in[23:16] != 8'hdc) & data_valid_except_eoc[5] & dual_lane); 
    assign  data_valid_except_eoc[ 1]  =   data_valid[ 1] | (~data_valid[ 1] & (data_in[15: 8] != 8'hdc) & data_valid_except_eoc[5] & data_valid_except_eoc[3]); 
    assign  data_valid_except_eoc[ 0]  =   data_valid[ 0] | (~data_valid[ 0] & (data_in[ 7: 0] != 8'hdc) & data_valid_except_eoc[5] & data_valid_except_eoc[3] & dual_lane);
end
else if (pDSC_READ_BYTES == 3)
begin
    assign  data_valid_except_eoc[11]  =   data_valid[11]; 
    assign  data_valid_except_eoc[10]  =   data_valid[10]; 
    assign  data_valid_except_eoc[ 9]  =   data_valid[ 9]; 
    assign  data_valid_except_eoc[ 8]  =   data_valid[ 8]; 
    assign  data_valid_except_eoc[ 7]  =   data_valid[ 7]; 
    assign  data_valid_except_eoc[ 6]  =   data_valid[ 6]; 
    assign  data_valid_except_eoc[ 5]  =   data_valid[ 5]; 
    assign  data_valid_except_eoc[ 4]  =   data_valid[ 4]; 
    assign  data_valid_except_eoc[ 3]  =   data_valid[ 3]; 
    assign  data_valid_except_eoc[ 2]  =   data_valid[ 2];
    assign  data_valid_except_eoc[ 1]  =   data_valid[ 1];
    assign  data_valid_except_eoc[ 0]  =   data_valid[ 0];
end



always @(posedge vid_pixel_clk)
begin
    if(~auto_clear)
    begin
        enable_dsc_q       <=   1'd0                        ;     
        data_in_q          <=   {pDSC_READ_BYTES{1'b0}}     ;    
        data_valid_q       <=   12'd0                       ;
        data_last_q        <=   1'd0                        ;
        we_q               <=   1'd0                        ;    
        vid_hsync_fe_q     <=   1'd0                        ;    
        lanes_q            <=   3'd0                        ;
        sof_q              <=   1'd0                        ;
        wr_cnt_array_0     <=   7'd0                        ; 
        wr_cnt_array_1     <=   7'd0                        ;    
        wr_cnt_array_2     <=   7'd0                        ;    
        wr_cnt_array_3     <=   7'd0                        ;    
        wr_cnt_array_4     <=   7'd0                        ;    
        wr_cnt_array_5     <=   7'd0                        ;    
        wr_cnt_array_6     <=   7'd0                        ;    
        wr_cnt_array_7     <=   7'd0                        ;        
        wr_cnt_array_8     <=   7'd0                        ;    
        wr_cnt_array_9     <=   7'd0                        ;    
        wr_cnt_array_10    <=   7'd0                        ;    
        wr_cnt_array_11    <=   7'd0                        ;
    end
    else
    begin
        enable_dsc_q    <=   enable_dsc        ;     
        data_in_q       <=   data_in           ;    
        data_valid_q    <=   data_valid        ;
        data_valid_except_eoc_q    <=   data_valid_except_eoc ;
        data_last_q     <=   data_last         ;
        we_q            <=   we                ;    
        vid_hsync_fe_q  <=   vid_hsync_fe      ;    
        lanes_q         <=   lanes             ;
        sof_q           <=   sof               ;
        wr_cnt_q        <=   wr_cnt            ; 
        wr_cnt_array_0  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11]    ;
        wr_cnt_array_1  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10]   ;
        wr_cnt_array_2  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9]   ;
        wr_cnt_array_3  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8]    ;
        wr_cnt_array_4  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7]    ;
        wr_cnt_array_5  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6]   ;
        wr_cnt_array_6  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5]  ;
        wr_cnt_array_7  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5] + data_valid_except_eoc[4] ;
        wr_cnt_array_8  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5] + data_valid_except_eoc[4] + data_valid_except_eoc[3];
        wr_cnt_array_9  <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5] + data_valid_except_eoc[4] + data_valid_except_eoc[3] + data_valid_except_eoc[2];
        wr_cnt_array_10 <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5] + data_valid_except_eoc[4] + data_valid_except_eoc[3] + data_valid_except_eoc[2] + data_valid_except_eoc[1];
        wr_cnt_array_11 <=   (wr_cnt - 7'd1) + data_valid_except_eoc[11] + data_valid_except_eoc[10] + data_valid_except_eoc[9] + data_valid_except_eoc[8] + data_valid_except_eoc[7] + data_valid_except_eoc[6] + data_valid_except_eoc[5] + data_valid_except_eoc[4] + data_valid_except_eoc[3] + data_valid_except_eoc[2] + data_valid_except_eoc[1] + data_valid_except_eoc[0];

        wr_cnt_array_last_0 <= wr_cnt  - 7'd1         ;   
    end
end

assign fifo_cnt_incr    =   data_valid_except_eoc[0] + data_valid_except_eoc[1] + data_valid_except_eoc[2] + data_valid_except_eoc[3] +
                            data_valid_except_eoc[4] + data_valid_except_eoc[5] + data_valid_except_eoc[6] + data_valid_except_eoc[7] +
                            data_valid_except_eoc[8] + data_valid_except_eoc[9] + data_valid_except_eoc[10] + data_valid_except_eoc[11];



assign last_from_fifo     =   last_from_fifo_int & ~last_from_fifo_int_q;
//assign rd_wr_diff       =   rd_cnt[5:0] - wr_cnt[5:0];  
assign rd_wr_diff         =   (rd_cnt - wr_cnt_latch);  


always @(*)
begin
    rd_cnt_array_0  =  rd_cnt[6:0]         ;
    rd_cnt_array_1  =  rd_cnt[6:0] + 7'd1  ;
    rd_cnt_array_2  =  rd_cnt[6:0] + 7'd2  ;
    rd_cnt_array_3  =  rd_cnt[6:0] + 7'd3  ;
    rd_cnt_array_4  =  rd_cnt[6:0] + 7'd4  ;
    rd_cnt_array_5  =  rd_cnt[6:0] + 7'd5  ;
    rd_cnt_array_6  =  rd_cnt[6:0] + 7'd6  ;
    rd_cnt_array_7  =  rd_cnt[6:0] + 7'd7  ;
    rd_cnt_array_8  =  rd_cnt[6:0] + 7'd8  ;
    rd_cnt_array_9  =  rd_cnt[6:0] + 7'd9  ;
    rd_cnt_array_10 =  rd_cnt[6:0] + 7'd10 ;
    rd_cnt_array_11 =  rd_cnt[6:0] + 7'd11 ;
    rd_cnt_array_12 =  rd_cnt[6:0] + 7'd12 ;
    rd_cnt_array_13 =  rd_cnt[6:0] + 7'd13 ;
    rd_cnt_array_14 =  rd_cnt[6:0] + 7'd14 ;
    rd_cnt_array_15 =  rd_cnt[6:0] + 7'd15 ;
    rd_cnt_array_16 =  rd_cnt[6:0] + 7'd16 ;
    rd_cnt_array_17 =  rd_cnt[6:0] + 7'd17 ;
    rd_cnt_array_18 =  rd_cnt[6:0] + 7'd18 ;
    rd_cnt_array_19 =  rd_cnt[6:0] + 7'd19 ;
    rd_cnt_array_20 =  rd_cnt[6:0] + 7'd20 ;
    rd_cnt_array_21 =  rd_cnt[6:0] + 7'd21 ;
    rd_cnt_array_22 =  rd_cnt[6:0] + 7'd22 ;
    rd_cnt_array_23 =  rd_cnt[6:0] + 7'd23 ;

end

if(pDSC_READ_BYTES == 12)
begin

    always @(*)
    begin
        if(lanes_q == 3'd4)
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                            data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8] |
                            data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                            data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]               
                           ) &
                            ~(data_fifo[rd_cnt_array_12][8] | data_fifo[rd_cnt_array_13][8] | data_fifo[rd_cnt_array_14][8] |
                            data_fifo[rd_cnt_array_15][8] | data_fifo[rd_cnt_array_16][8] | data_fifo[rd_cnt_array_17][8] |
                            data_fifo[rd_cnt_array_18][8] | data_fifo[rd_cnt_array_19][8] | data_fifo[rd_cnt_array_20][8] |
                            data_fifo[rd_cnt_array_21][8] | data_fifo[rd_cnt_array_22][8] | data_fifo[rd_cnt_array_23][8]
                           );
        end
        else if (lanes_q == 3'd2)
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                            data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]) &
                            ~(data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                            data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]);
        end
        else
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                           ) &
                            ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                           );
        end
    end
    
    always @(*)
    begin
        if(last_from_fifo)
        begin
            if(lanes_q == 3'd4)
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b111111111111; 
                   5'd1  : tkeep_from_fifo   = 12'b111111111110; 
                   5'd2  : tkeep_from_fifo   = 12'b111111111100; 
                   5'd3  : tkeep_from_fifo   = 12'b111111111000; 
                   5'd4  : tkeep_from_fifo   = 12'b111111110000; 
                   5'd5  : tkeep_from_fifo   = 12'b111111100000; 
                   5'd6  : tkeep_from_fifo   = 12'b111111000000; 
                   5'd7  : tkeep_from_fifo   = 12'b111110000000; 
                   5'd8  : tkeep_from_fifo   = 12'b111100000000; 
                   5'd9  : tkeep_from_fifo   = 12'b111000000000; 
                   5'd10 : tkeep_from_fifo   = 12'b110000000000;
                   5'd11 : tkeep_from_fifo   = 12'b100000000000;
                   5'd12 : tkeep_from_fifo   = 12'b000000000000;
                   default:tkeep_from_fifo   = 12'b111111111111;
                endcase
            end
            else if(lanes_q == 3'd2)
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b110011001100; 
                   5'd1  : tkeep_from_fifo   = 12'b110011001000; 
                   5'd2  : tkeep_from_fifo   = 12'b110011000000; 
                   5'd3  : tkeep_from_fifo   = 12'b110010000000; 
                   5'd4  : tkeep_from_fifo   = 12'b110000000000; 
                   5'd5  : tkeep_from_fifo   = 12'b100000000000; 
                   5'd6  : tkeep_from_fifo   = 12'b000000000000; 
                   default:tkeep_from_fifo   = 12'b110011001100;
                endcase
            end
            else
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b100010001000; 
                   5'd1  : tkeep_from_fifo   = 12'b100010000000; 
                   5'd2  : tkeep_from_fifo   = 12'b100000000000; 
                   5'd3  : tkeep_from_fifo   = 12'b000000000000; 
                   default:tkeep_from_fifo   = 12'b100010001000;
                endcase
            end
        end
        else
        begin
            if(lanes_q == 3'd4)
               tkeep_from_fifo   = 12'b111111111111;
            else if(lanes_q == 3'd2)
               tkeep_from_fifo   = 12'b110011001100;
            else
               tkeep_from_fifo   = 12'b100010001000;
        end
    end
    always @(posedge vid_pixel_clk)
    begin
        if(~auto_clear)
        begin
            for(k=0; k<63; k=k+1)
                data_fifo[k]    <=  10'd0;
            wr_cnt              <=  7'd0;
            rd_cnt              <=  7'd0;
            re                  <=  1'b0;
            data_last_level     <=  1'b0;
            data_last_level_q   <=  1'b0;
            data_out            <=   'h0;  
            wr_cnt_latch        <=   6'd0;
            last_from_fifo_int  <=   1'b0;
            last_from_fifo_int_q<=   1'b0;
            valid_from_fifo     <=  1'b0;
            //tkeep_from_fifo     <= 12'b000000000000; 
        end
        else if(enable_dsc_q) 
        begin
            last_from_fifo_int_q      <=  last_from_fifo_int;
            if(data_last && we)
                data_last_level   <=  1'b1 ;
            else if(vid_hsync_fe)
                data_last_level   <=  1'b0 ;

            if(data_last_q && we_q)
                data_last_level_q   <=  1'b1 ;
            else if(vid_hsync_fe_q)
                data_last_level_q   <=  1'b0 ;


            if(last_re)
            begin
                re                  <=   1'b0;
            end
//By checking whether we_cnt_q is >= 60, we are waiting for 72 bytes to be written in to FIFO before the first read. This will make sure that even in the worst case if we get 49 invalid data (3 dummy, 4 EOCs and 7 slice ends in the case of 8 slices, (3+4)*7), still the data that will be left in FIFO will be 72-49 = 23 which is more than 12 (bytes per clock in 4 lane mode) Similarly 30 and 15 values are fixed for other lanes.
            else if(we_q && (lanes_q == 3'd4) && (wr_cnt_q[6:0] >= 7'd60)) 
            begin
                re  <=   1'b1;
            end
            else if(we_q && (lanes_q == 3'd2) && (wr_cnt_q[6:0] >= 7'd30))
            begin
                re  <=   1'b1;
            end
            else if(we_q && (lanes_q == 3'd1) && (wr_cnt_q[6:0] >= 7'd15))
            begin
                re  <=   1'b1;
            end

            //if(vid_hsync_fe)
            //   data_last_invalid    <=  1'b0;
            //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
            //   data_last_invalid    <=  1'b1;


   
            if(vid_hsync_fe_q || ~data_last_level_q)
                last_from_fifo_int  <=   1'b0;
            else if(last_re)            
                last_from_fifo_int  <=   1'b1;
    
    //Write logic
            if(we_q)
            begin
                if(data_valid_except_eoc_q[11]) data_fifo[wr_cnt_array_0 ]  <=  {sof_q,data_last_q,data_in_q[95:88]}; 
                if(data_valid_except_eoc_q[10]) data_fifo[wr_cnt_array_1 ]  <=  {sof_q,data_last_q,data_in_q[87:80]}; 
                if(data_valid_except_eoc_q[9])  data_fifo[wr_cnt_array_2 ]  <=  {sof_q,data_last_q,data_in_q[79:72]}; 
                if(data_valid_except_eoc_q[8])  data_fifo[wr_cnt_array_3 ]  <=  {sof_q,data_last_q,data_in_q[71:64]}; 
                if(data_valid_except_eoc_q[7])  data_fifo[wr_cnt_array_4 ]  <=  {sof_q,data_last_q,data_in_q[63:56]}; 
                if(data_valid_except_eoc_q[6])  data_fifo[wr_cnt_array_5 ]  <=  {sof_q,data_last_q,data_in_q[55:48]}; 
                if(data_valid_except_eoc_q[5])  data_fifo[wr_cnt_array_6 ]  <=  {sof_q,data_last_q,data_in_q[47:40]}; 
                if(data_valid_except_eoc_q[4])  data_fifo[wr_cnt_array_7 ]  <=  {sof_q,data_last_q,data_in_q[39:32]}; 
                if(data_valid_except_eoc_q[3])  data_fifo[wr_cnt_array_8 ]  <=  {sof_q,data_last_q,data_in_q[31:24]}; 
                if(data_valid_except_eoc_q[2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                if(data_valid_except_eoc_q[1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                if(data_valid_except_eoc_q[0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]}; 

                if(~(|(data_valid_q)))
                begin
                    data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                end
            end
            if(~data_last_level && we)
                wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
            else if (vid_hsync_fe)
                wr_cnt  <=   7'd0;
    
            if(data_last_q && ~data_last_level_q)
                wr_cnt_latch    <=  wr_cnt ;
            else if (vid_hsync_fe_q)
                wr_cnt_latch    <=   7'd0;
   
    
    
    //Read logic
            if((re && we_q) || (data_last_level_q && re))
            begin
                if(lanes_q == 3'd4)
                begin
                    data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[109:100] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[ 99: 90] <=  data_fifo[rd_cnt_array_2 ];  
                    data_out[ 89: 80] <=  data_fifo[rd_cnt_array_3 ];  
                    data_out[ 79: 70] <=  data_fifo[rd_cnt_array_4 ];  
                    data_out[ 69: 60] <=  data_fifo[rd_cnt_array_5 ];  
                    data_out[ 59: 50] <=  data_fifo[rd_cnt_array_6 ];  
                    data_out[ 49: 40] <=  data_fifo[rd_cnt_array_7 ];  
                    data_out[ 39: 30] <=  data_fifo[rd_cnt_array_8 ];  
                    data_out[ 29: 20] <=  data_fifo[rd_cnt_array_9 ];  
                    data_out[ 19: 10] <=  data_fifo[rd_cnt_array_10];  
                    data_out[  9:  0] <=  data_fifo[rd_cnt_array_11];
                end
                else if(lanes_q == 3'd2)
                begin
                    data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[109:100] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[ 99: 90] <=  10'd0;  
                    data_out[ 89: 80] <=  10'd0;  
                    data_out[ 79: 70] <=  data_fifo[rd_cnt_array_2 ];  
                    data_out[ 69: 60] <=  data_fifo[rd_cnt_array_3 ];  
                    data_out[ 59: 50] <=  10'd0;  
                    data_out[ 49: 40] <=  10'd0;  
                    data_out[ 39: 30] <=  data_fifo[rd_cnt_array_4 ];  
                    data_out[ 29: 20] <=  data_fifo[rd_cnt_array_5 ];  
                    data_out[ 19: 10] <=  10'd0;  
                    data_out[  9:  0] <=  10'd0;
                end
                else
                begin
                    data_out[119:110] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[109:100] <=  10'd0;  
                    data_out[ 99: 90] <=  10'd0;  
                    data_out[ 89: 80] <=  10'd0;  
                    data_out[ 79: 70] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[ 69: 60] <=  10'd0;  
                    data_out[ 59: 50] <=  10'd0;  
                    data_out[ 49: 40] <=  10'd0;  
                    data_out[ 39: 30] <=  data_fifo[rd_cnt_array_2 ];  
                    data_out[ 29: 20] <=  10'd0;  
                    data_out[ 19: 10] <=  10'd0;  
                    data_out[  9:  0] <=  10'd0;
                end

                valid_from_fifo   <=  1'b1;
            end
            else
            begin
                valid_from_fifo   <=  1'b0;
            end
            if((re && we_q) || (data_last_level_q && re))
            begin
                if(lanes_q == 3'd4)
                    rd_cnt      <=      rd_cnt + 7'd12;
                else if(lanes_q == 3'd2)
                    rd_cnt      <=      rd_cnt + 7'd6;
                else
                    rd_cnt      <=      rd_cnt + 7'd3;
            end
            else if (vid_hsync_fe_q)
                rd_cnt      <=      7'd0;
        end
    end
end
else if(pDSC_READ_BYTES == 6)
begin
    always @(*)
    begin
        if (lanes_q == 3'd2)
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] |
                            data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]) &
                            ~(data_fifo[rd_cnt_array_6][8] | data_fifo[rd_cnt_array_7][8] | data_fifo[rd_cnt_array_8][8] |
                            data_fifo[rd_cnt_array_9][8] | data_fifo[rd_cnt_array_10][8] | data_fifo[rd_cnt_array_11][8]);
        end
        else
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                           ) &
                            ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                           );
        end
    end

    always @(*)
    begin
        if(last_from_fifo)
        begin
            if(lanes_q == 3'd2)
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b000000111111; 
                   5'd1  : tkeep_from_fifo   = 12'b000000111110; 
                   5'd2  : tkeep_from_fifo   = 12'b000000111100; 
                   5'd3  : tkeep_from_fifo   = 12'b000000111000; 
                   5'd4  : tkeep_from_fifo   = 12'b000000110000; 
                   5'd5  : tkeep_from_fifo   = 12'b000000100000; 
                   5'd6  : tkeep_from_fifo   = 12'b000000000000; 
                   default:tkeep_from_fifo   = 12'b000000111111;
                endcase
            end
            else
            begin
                case(rd_wr_diff[4:0])
                   5'd0  : tkeep_from_fifo   = 12'b000000101010; 
                   5'd1  : tkeep_from_fifo   = 12'b000000101000; 
                   5'd2  : tkeep_from_fifo   = 12'b000000100000; 
                   5'd3  : tkeep_from_fifo   = 12'b000000000000; 
                   default:tkeep_from_fifo   = 12'b000000101010;
                endcase
            end
        end
        else
        begin
            if(lanes_q == 3'd2)
               tkeep_from_fifo   = 12'b000000111111;
            else
               tkeep_from_fifo   = 12'b000000101010;
        end
    end
    always @(posedge vid_pixel_clk)
    begin
        if(~auto_clear)
        begin
            for(k=0; k<63; k=k+1)
                data_fifo[k]    <=  10'd0;
            wr_cnt              <=  7'd0;
            rd_cnt              <=  7'd0;
            re                  <=  1'b0;
            data_last_level     <=  1'b0;
            data_last_level_q   <=  1'b0;
            data_out            <=   'h0;  
            wr_cnt_latch        <=   6'd0;
            last_from_fifo_int  <=   1'b0;
            last_from_fifo_int_q<=   1'b0;
            valid_from_fifo     <=  1'b0;
            //data_last_invalid   <=  1'b0;
        end
        else if(enable_dsc_q) 
        begin
            last_from_fifo_int_q      <=  last_from_fifo_int;
            if(data_last && we)
                data_last_level   <=  1'b1 ;
            else if(vid_hsync_fe)
                data_last_level   <=  1'b0 ;

            if(data_last_q && we_q)
                data_last_level_q   <=  1'b1 ;
            else if(vid_hsync_fe_q)
                data_last_level_q   <=  1'b0 ;
    
            if(last_re)
            begin
                re                  <=   1'b0;
            end
            else if(we_q && (lanes_q == 3'd2) && (wr_cnt_q[6:0] >= 7'd30))
            begin
                re  <=   1'b1;
            end
            else if(we_q && (lanes_q == 3'd1) && (wr_cnt_q[6:0] >= 7'd15))
            begin
                re  <=   1'b1;
            end

            //if(vid_hsync_fe)
            //   data_last_invalid    <=  1'b0;
            //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
            //   data_last_invalid    <=  1'b1;


   
            if(vid_hsync_fe_q || ~data_last_level_q)
                last_from_fifo_int  <=   1'b0;
            else if(last_re)            
                last_from_fifo_int  <=   1'b1;
    //Write logic
            if(we_q)
            begin
                if(data_valid_except_eoc_q[ 5])  data_fifo[wr_cnt_array_6 ]  <=  {sof_q,data_last_q,data_in_q[47:40]}; 
                if(data_valid_except_eoc_q[ 4])  data_fifo[wr_cnt_array_7 ]  <=  {sof_q,data_last_q,data_in_q[39:32]}; 
                if(data_valid_except_eoc_q[ 3])  data_fifo[wr_cnt_array_8 ]  <=  {sof_q,data_last_q,data_in_q[31:24]}; 
                if(data_valid_except_eoc_q[ 2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                if(data_valid_except_eoc_q[ 1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                if(data_valid_except_eoc_q[ 0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]};


                if(~(|(data_valid_q)))
                begin
                    data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                end
                
            end
            if(~data_last_level && we)
                wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
            else if (vid_hsync_fe)
                wr_cnt  <=   7'd0;
    
            if(data_last_q && ~data_last_level_q)
                wr_cnt_latch    <=  wr_cnt;
            else if (vid_hsync_fe_q)
                wr_cnt_latch    <=   7'd0;
   
    //Read logic
            if((re && we_q) || (data_last_level_q && re))
            begin
                if(lanes_q == 3'd2)
                begin
                    data_out[ 59: 50] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[ 49: 40] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[ 39: 30] <=  data_fifo[rd_cnt_array_2 ];  
                    data_out[ 29: 20] <=  data_fifo[rd_cnt_array_3 ];  
                    data_out[ 19: 10] <=  data_fifo[rd_cnt_array_4 ];  
                    data_out[  9:  0] <=  data_fifo[rd_cnt_array_5 ]; 
                end
                else
                begin
                    data_out[ 59: 50] <=  data_fifo[rd_cnt_array_0 ];  
                    data_out[ 49: 40] <=  10'd0;  
                    data_out[ 39: 30] <=  data_fifo[rd_cnt_array_1 ];  
                    data_out[ 29: 20] <=  10'd0;  
                    data_out[ 19: 10] <=  data_fifo[rd_cnt_array_2 ];  
                    data_out[  9:  0] <=  10'd0; 
                end
                    
                    valid_from_fifo   <=  1'b1;
            end
            else
            begin
                valid_from_fifo   <=  1'b0;
            end
            if((re && we_q) || (data_last_level_q && re))
                if(lanes_q == 3'd2)
                    rd_cnt      <=      rd_cnt + 7'd6;
                else
                    rd_cnt      <=      rd_cnt + 7'd3;
            else if (vid_hsync_fe_q)
                rd_cnt      <=      7'd0;
        end
    end
end
else if(pDSC_READ_BYTES == 3)
begin

    always @(*)
    begin
        if(lanes_q == 3'd1)
        begin
           last_re     =   (data_fifo[rd_cnt_array_0][8] | data_fifo[rd_cnt_array_1][8] | data_fifo[rd_cnt_array_2][8] 
                           ) &
                            ~(data_fifo[rd_cnt_array_3][8] | data_fifo[rd_cnt_array_4][8] | data_fifo[rd_cnt_array_5][8]
                           );
        end
        else
        begin
           last_re     =   1'b0;
        end

    end

    always @(*)
    begin
        if(last_from_fifo)
        begin
            case(rd_wr_diff[4:0])
               5'd0  : tkeep_from_fifo   = 12'b000000000111; 
               5'd1  : tkeep_from_fifo   = 12'b000000000110; 
               5'd2  : tkeep_from_fifo   = 12'b000000000100; 
               5'd3  : tkeep_from_fifo   = 12'b000000000000; 
               default:tkeep_from_fifo   = 12'b000000000111;
            endcase
        end
        else
               tkeep_from_fifo   = 12'b000000000111;
    end
    always @(posedge vid_pixel_clk)
    begin
        if(~auto_clear)
        begin
            for(k=0; k<63; k=k+1)
                data_fifo[k]    <=  10'd0;
            wr_cnt              <=  7'd0;
            rd_cnt              <=  7'd0;
            re                  <=  1'b0;
            data_last_level     <=  1'b0;
            data_last_level_q   <=  1'b0;
            data_out            <=   'h0;  
            wr_cnt_latch        <=   6'd0;
            last_from_fifo_int  <=   1'b0;
            last_from_fifo_int_q<=   1'b0;
            valid_from_fifo     <=  1'b0;
        end
        else if(enable_dsc_q) 
        begin
            last_from_fifo_int_q      <=  last_from_fifo_int;
            if(data_last && we)
                data_last_level   <=  1'b1 ;
            else if(vid_hsync_fe)
                data_last_level   <=  1'b0 ;

            if(data_last_q && we_q)
                data_last_level_q   <=  1'b1 ;
            else if(vid_hsync_fe_q)
                data_last_level_q   <=  1'b0 ;
    
            if(last_re)
            begin
                re                  <=   1'b0;
            end
            else if(we_q && (wr_cnt_q[6:0] >= 7'd15))
            begin
                re  <=   1'b1;
            end

            //if(vid_hsync_fe)
            //   data_last_invalid    <=  1'b0;
            //else if(data_last && we && data_in[47:0] == 48'hdcdc00000000)
            //   data_last_invalid    <=  1'b1;


   
            if(vid_hsync_fe_q || ~data_last_level_q)
                last_from_fifo_int  <=   1'b0;
            else if(last_re)            
                last_from_fifo_int  <=   1'b1;

    //Write logic
            if(we_q)
            begin
                if(data_valid_except_eoc_q[ 2])  data_fifo[wr_cnt_array_9 ]  <=  {sof_q,data_last_q,data_in_q[23:16]}; 
                if(data_valid_except_eoc_q[ 1])  data_fifo[wr_cnt_array_10]  <=  {sof_q,data_last_q,data_in_q[15: 8]}; 
                if(data_valid_except_eoc_q[ 0])  data_fifo[wr_cnt_array_11]  <=  {sof_q,data_last_q,data_in_q[ 7: 0]};


                if(~(|(data_valid_q)))
                begin
                    data_fifo[wr_cnt_array_last_0][8]  <= 1'b1;
                end
            end
            if(~data_last_level && we)
                wr_cnt  <=   wr_cnt + (fifo_cnt_incr);
            else if (vid_hsync_fe)
                wr_cnt  <=   7'd0;
    
            if(data_last_q && ~data_last_level_q)
                wr_cnt_latch    <=  wr_cnt;
            else if (vid_hsync_fe_q)
                wr_cnt_latch    <=   7'd0;
   
    
    //Read logic
            if((re && we_q) || (data_last_level_q && re))
            begin
                data_out[ 29: 20] <=  data_fifo[rd_cnt_array_0 ];  
                data_out[ 19: 10] <=  data_fifo[rd_cnt_array_1 ];  
                data_out[  9:  0] <=  data_fifo[rd_cnt_array_2 ];  
                
                valid_from_fifo   <=  1'b1;
            end
            else
            begin
                valid_from_fifo   <=  1'b0;
            end
            if((re && we_q) || (data_last_level_q && re))
                rd_cnt      <=      rd_cnt + 7'd3;
            else if (vid_hsync_fe_q)
                rd_cnt      <=      7'd0;
        end
    end
end
end
endgenerate
endmodule


