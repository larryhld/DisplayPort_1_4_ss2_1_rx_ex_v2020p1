// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Apr  7 18:46:31 2021
// Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_util_ds_buf_2_0/dpss_zcu102_rx_util_ds_buf_2_0_sim_netlist.v
// Design      : dpss_zcu102_rx_util_ds_buf_2_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dpss_zcu102_rx_util_ds_buf_2_0,util_ds_buf,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "util_ds_buf,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module dpss_zcu102_rx_util_ds_buf_2_0
   (IOBUF_IO_T,
    IOBUF_IO_I,
    IOBUF_IO_O,
    IOBUF_IO_IO);
  input [0:0]IOBUF_IO_T;
  input [0:0]IOBUF_IO_I;
  output [0:0]IOBUF_IO_O;
  inout [0:0]IOBUF_IO_IO;

  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire [0:0]IOBUF_IO_I;
  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire [0:0]IOBUF_IO_IO;
  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire [0:0]IOBUF_IO_O;
  (* DRIVE = "12" *) (* IBUF_LOW_PWR *) (* SLEW = "SLOW" *) wire [0:0]IOBUF_IO_T;
  wire [0:0]NLW_U0_BUFGCE_O_UNCONNECTED;
  wire [0:0]NLW_U0_BUFG_FABRIC_O_UNCONNECTED;
  wire [0:0]NLW_U0_BUFG_GT_O_UNCONNECTED;
  wire [0:0]NLW_U0_BUFG_O_UNCONNECTED;
  wire [0:0]NLW_U0_BUFHCE_O_UNCONNECTED;
  wire [0:0]NLW_U0_BUFH_O_UNCONNECTED;
  wire [0:0]NLW_U0_IBUFDS_GTME5_O_UNCONNECTED;
  wire [0:0]NLW_U0_IBUFDS_GTME5_ODIV2_UNCONNECTED;
  wire [0:0]NLW_U0_IBUFDS_GTM_O_UNCONNECTED;
  wire [0:0]NLW_U0_IBUFDS_GTM_ODIV2_UNCONNECTED;
  wire [0:0]NLW_U0_IBUF_DS_ODIV2_UNCONNECTED;
  wire [0:0]NLW_U0_IBUF_OUT_UNCONNECTED;
  wire [0:0]NLW_U0_IOBUF_DS_N_UNCONNECTED;
  wire [0:0]NLW_U0_IOBUF_DS_P_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE3_ADV_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE3_ADV_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE3_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE3_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE4_ADV_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE4_ADV_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE4_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE4_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE5_ADV_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE5_ADV_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE5_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTE5_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTME5_ADV_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTME5_ADV_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTME5_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTME5_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTM_ADV_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTM_ADV_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTM_O_UNCONNECTED;
  wire [0:0]NLW_U0_OBUFDS_GTM_OB_UNCONNECTED;
  wire [0:0]NLW_U0_OBUF_DS_N_UNCONNECTED;
  wire [0:0]NLW_U0_OBUF_DS_P_UNCONNECTED;

  (* C_BUFGCE_DIV = "1" *) 
  (* C_BUFG_GT_SYNC = "0" *) 
  (* C_BUF_TYPE = "IOBUF" *) 
  (* C_OBUFDS_GTE5_ADV = "2'b00" *) 
  (* C_REFCLK_ICNTL_TX = "5'b00000" *) 
  (* C_SIM_DEVICE = "VERSAL_AI_CORE_ES1" *) 
  (* C_SIZE = "1" *) 
  dpss_zcu102_rx_util_ds_buf_2_0_util_ds_buf U0
       (.BUFGCE_CE(1'b0),
        .BUFGCE_CLR(1'b0),
        .BUFGCE_I(1'b0),
        .BUFGCE_O(NLW_U0_BUFGCE_O_UNCONNECTED[0]),
        .BUFG_FABRIC_I(1'b0),
        .BUFG_FABRIC_O(NLW_U0_BUFG_FABRIC_O_UNCONNECTED[0]),
        .BUFG_GT_CE(1'b0),
        .BUFG_GT_CEMASK(1'b0),
        .BUFG_GT_CLR(1'b0),
        .BUFG_GT_CLRMASK(1'b0),
        .BUFG_GT_DIV({1'b0,1'b0,1'b0}),
        .BUFG_GT_I(1'b0),
        .BUFG_GT_O(NLW_U0_BUFG_GT_O_UNCONNECTED[0]),
        .BUFG_I(1'b0),
        .BUFG_O(NLW_U0_BUFG_O_UNCONNECTED[0]),
        .BUFHCE_CE(1'b0),
        .BUFHCE_I(1'b0),
        .BUFHCE_O(NLW_U0_BUFHCE_O_UNCONNECTED[0]),
        .BUFH_I(1'b0),
        .BUFH_O(NLW_U0_BUFH_O_UNCONNECTED[0]),
        .IBUFDS_GTME5_CEB(1'b0),
        .IBUFDS_GTME5_I(1'b0),
        .IBUFDS_GTME5_IB(1'b0),
        .IBUFDS_GTME5_O(NLW_U0_IBUFDS_GTME5_O_UNCONNECTED[0]),
        .IBUFDS_GTME5_ODIV2(NLW_U0_IBUFDS_GTME5_ODIV2_UNCONNECTED[0]),
        .IBUFDS_GTM_CEB(1'b0),
        .IBUFDS_GTM_I(1'b0),
        .IBUFDS_GTM_IB(1'b0),
        .IBUFDS_GTM_O(NLW_U0_IBUFDS_GTM_O_UNCONNECTED[0]),
        .IBUFDS_GTM_ODIV2(NLW_U0_IBUFDS_GTM_ODIV2_UNCONNECTED[0]),
        .IBUF_DS_CEB(1'b0),
        .IBUF_DS_N(1'b0),
        .IBUF_DS_ODIV2(NLW_U0_IBUF_DS_ODIV2_UNCONNECTED[0]),
        .IBUF_DS_P(1'b0),
        .IBUF_OUT(NLW_U0_IBUF_OUT_UNCONNECTED[0]),
        .IOBUF_DS_N(NLW_U0_IOBUF_DS_N_UNCONNECTED[0]),
        .IOBUF_DS_P(NLW_U0_IOBUF_DS_P_UNCONNECTED[0]),
        .IOBUF_IO_I(IOBUF_IO_I),
        .IOBUF_IO_IO(IOBUF_IO_IO),
        .IOBUF_IO_O(IOBUF_IO_O),
        .IOBUF_IO_T(IOBUF_IO_T),
        .OBUFDS_GTE3_ADV_CEB(1'b0),
        .OBUFDS_GTE3_ADV_I({1'b0,1'b0,1'b0,1'b0}),
        .OBUFDS_GTE3_ADV_O(NLW_U0_OBUFDS_GTE3_ADV_O_UNCONNECTED[0]),
        .OBUFDS_GTE3_ADV_OB(NLW_U0_OBUFDS_GTE3_ADV_OB_UNCONNECTED[0]),
        .OBUFDS_GTE3_CEB(1'b0),
        .OBUFDS_GTE3_I(1'b0),
        .OBUFDS_GTE3_O(NLW_U0_OBUFDS_GTE3_O_UNCONNECTED[0]),
        .OBUFDS_GTE3_OB(NLW_U0_OBUFDS_GTE3_OB_UNCONNECTED[0]),
        .OBUFDS_GTE4_ADV_CEB(1'b0),
        .OBUFDS_GTE4_ADV_I({1'b0,1'b0,1'b0,1'b0}),
        .OBUFDS_GTE4_ADV_O(NLW_U0_OBUFDS_GTE4_ADV_O_UNCONNECTED[0]),
        .OBUFDS_GTE4_ADV_OB(NLW_U0_OBUFDS_GTE4_ADV_OB_UNCONNECTED[0]),
        .OBUFDS_GTE4_CEB(1'b0),
        .OBUFDS_GTE4_I(1'b0),
        .OBUFDS_GTE4_O(NLW_U0_OBUFDS_GTE4_O_UNCONNECTED[0]),
        .OBUFDS_GTE4_OB(NLW_U0_OBUFDS_GTE4_OB_UNCONNECTED[0]),
        .OBUFDS_GTE5_ADV_CEB(1'b0),
        .OBUFDS_GTE5_ADV_I({1'b0,1'b0,1'b0,1'b0}),
        .OBUFDS_GTE5_ADV_O(NLW_U0_OBUFDS_GTE5_ADV_O_UNCONNECTED[0]),
        .OBUFDS_GTE5_ADV_OB(NLW_U0_OBUFDS_GTE5_ADV_OB_UNCONNECTED[0]),
        .OBUFDS_GTE5_CEB(1'b0),
        .OBUFDS_GTE5_I(1'b0),
        .OBUFDS_GTE5_O(NLW_U0_OBUFDS_GTE5_O_UNCONNECTED[0]),
        .OBUFDS_GTE5_OB(NLW_U0_OBUFDS_GTE5_OB_UNCONNECTED[0]),
        .OBUFDS_GTME5_ADV_CEB(1'b0),
        .OBUFDS_GTME5_ADV_I({1'b0,1'b0,1'b0,1'b0}),
        .OBUFDS_GTME5_ADV_O(NLW_U0_OBUFDS_GTME5_ADV_O_UNCONNECTED[0]),
        .OBUFDS_GTME5_ADV_OB(NLW_U0_OBUFDS_GTME5_ADV_OB_UNCONNECTED[0]),
        .OBUFDS_GTME5_CEB(1'b0),
        .OBUFDS_GTME5_I(1'b0),
        .OBUFDS_GTME5_O(NLW_U0_OBUFDS_GTME5_O_UNCONNECTED[0]),
        .OBUFDS_GTME5_OB(NLW_U0_OBUFDS_GTME5_OB_UNCONNECTED[0]),
        .OBUFDS_GTM_ADV_CEB(1'b0),
        .OBUFDS_GTM_ADV_I({1'b0,1'b0,1'b0,1'b0}),
        .OBUFDS_GTM_ADV_O(NLW_U0_OBUFDS_GTM_ADV_O_UNCONNECTED[0]),
        .OBUFDS_GTM_ADV_OB(NLW_U0_OBUFDS_GTM_ADV_OB_UNCONNECTED[0]),
        .OBUFDS_GTM_CEB(1'b0),
        .OBUFDS_GTM_I(1'b0),
        .OBUFDS_GTM_O(NLW_U0_OBUFDS_GTM_O_UNCONNECTED[0]),
        .OBUFDS_GTM_OB(NLW_U0_OBUFDS_GTM_OB_UNCONNECTED[0]),
        .OBUF_DS_N(NLW_U0_OBUF_DS_N_UNCONNECTED[0]),
        .OBUF_DS_P(NLW_U0_OBUF_DS_P_UNCONNECTED[0]),
        .OBUF_IN(1'b0),
        .RXRECCLK_SEL_GTE3_ADV({1'b0,1'b0}),
        .RXRECCLK_SEL_GTE4_ADV({1'b0,1'b0}));
endmodule

(* C_BUFGCE_DIV = "1" *) (* C_BUFG_GT_SYNC = "0" *) (* C_BUF_TYPE = "IOBUF" *) 
(* C_OBUFDS_GTE5_ADV = "2'b00" *) (* C_REFCLK_ICNTL_TX = "5'b00000" *) (* C_SIM_DEVICE = "VERSAL_AI_CORE_ES1" *) 
(* C_SIZE = "1" *) (* ORIG_REF_NAME = "util_ds_buf" *) 
module dpss_zcu102_rx_util_ds_buf_2_0_util_ds_buf
   (IBUF_DS_P,
    IBUF_DS_N,
    IBUF_OUT,
    IBUF_DS_ODIV2,
    IBUF_DS_CEB,
    OBUF_IN,
    OBUF_DS_P,
    OBUF_DS_N,
    IOBUF_DS_P,
    IOBUF_DS_N,
    IOBUF_IO_T,
    IOBUF_IO_I,
    IOBUF_IO_O,
    IOBUF_IO_IO,
    BUFG_I,
    BUFG_O,
    BUFGCE_I,
    BUFGCE_CE,
    BUFGCE_O,
    BUFGCE_CLR,
    BUFH_I,
    BUFH_O,
    BUFHCE_I,
    BUFHCE_CE,
    BUFHCE_O,
    BUFG_FABRIC_I,
    BUFG_FABRIC_O,
    OBUFDS_GTE5_CEB,
    OBUFDS_GTE5_I,
    OBUFDS_GTE5_O,
    OBUFDS_GTE5_OB,
    OBUFDS_GTE5_ADV_CEB,
    OBUFDS_GTE5_ADV_I,
    OBUFDS_GTE5_ADV_O,
    OBUFDS_GTE5_ADV_OB,
    OBUFDS_GTE3_CEB,
    OBUFDS_GTE3_I,
    OBUFDS_GTE3_O,
    OBUFDS_GTE3_OB,
    OBUFDS_GTE3_ADV_CEB,
    OBUFDS_GTE3_ADV_I,
    OBUFDS_GTE3_ADV_O,
    OBUFDS_GTE3_ADV_OB,
    RXRECCLK_SEL_GTE3_ADV,
    OBUFDS_GTE4_CEB,
    OBUFDS_GTE4_I,
    OBUFDS_GTE4_O,
    OBUFDS_GTE4_OB,
    OBUFDS_GTE4_ADV_CEB,
    OBUFDS_GTE4_ADV_I,
    OBUFDS_GTE4_ADV_O,
    OBUFDS_GTE4_ADV_OB,
    RXRECCLK_SEL_GTE4_ADV,
    IBUFDS_GTM_O,
    IBUFDS_GTM_ODIV2,
    IBUFDS_GTM_CEB,
    IBUFDS_GTM_I,
    IBUFDS_GTM_IB,
    OBUFDS_GTM_O,
    OBUFDS_GTM_OB,
    OBUFDS_GTM_CEB,
    OBUFDS_GTM_I,
    OBUFDS_GTM_ADV_CEB,
    OBUFDS_GTM_ADV_I,
    OBUFDS_GTM_ADV_O,
    OBUFDS_GTM_ADV_OB,
    IBUFDS_GTME5_O,
    IBUFDS_GTME5_ODIV2,
    IBUFDS_GTME5_CEB,
    IBUFDS_GTME5_I,
    IBUFDS_GTME5_IB,
    OBUFDS_GTME5_CEB,
    OBUFDS_GTME5_I,
    OBUFDS_GTME5_O,
    OBUFDS_GTME5_OB,
    OBUFDS_GTME5_ADV_CEB,
    OBUFDS_GTME5_ADV_I,
    OBUFDS_GTME5_ADV_O,
    OBUFDS_GTME5_ADV_OB,
    BUFG_GT_I,
    BUFG_GT_CE,
    BUFG_GT_CEMASK,
    BUFG_GT_CLR,
    BUFG_GT_CLRMASK,
    BUFG_GT_DIV,
    BUFG_GT_O);
  input [0:0]IBUF_DS_P;
  input [0:0]IBUF_DS_N;
  output [0:0]IBUF_OUT;
  output [0:0]IBUF_DS_ODIV2;
  input [0:0]IBUF_DS_CEB;
  input [0:0]OBUF_IN;
  output [0:0]OBUF_DS_P;
  output [0:0]OBUF_DS_N;
  inout [0:0]IOBUF_DS_P;
  inout [0:0]IOBUF_DS_N;
  input [0:0]IOBUF_IO_T;
  input [0:0]IOBUF_IO_I;
  output [0:0]IOBUF_IO_O;
  inout [0:0]IOBUF_IO_IO;
  input [0:0]BUFG_I;
  output [0:0]BUFG_O;
  input [0:0]BUFGCE_I;
  input [0:0]BUFGCE_CE;
  output [0:0]BUFGCE_O;
  input [0:0]BUFGCE_CLR;
  input [0:0]BUFH_I;
  output [0:0]BUFH_O;
  input [0:0]BUFHCE_I;
  input [0:0]BUFHCE_CE;
  output [0:0]BUFHCE_O;
  input [0:0]BUFG_FABRIC_I;
  output [0:0]BUFG_FABRIC_O;
  input [0:0]OBUFDS_GTE5_CEB;
  input [0:0]OBUFDS_GTE5_I;
  output [0:0]OBUFDS_GTE5_O;
  output [0:0]OBUFDS_GTE5_OB;
  input [0:0]OBUFDS_GTE5_ADV_CEB;
  input [3:0]OBUFDS_GTE5_ADV_I;
  output [0:0]OBUFDS_GTE5_ADV_O;
  output [0:0]OBUFDS_GTE5_ADV_OB;
  input [0:0]OBUFDS_GTE3_CEB;
  input [0:0]OBUFDS_GTE3_I;
  output [0:0]OBUFDS_GTE3_O;
  output [0:0]OBUFDS_GTE3_OB;
  input [0:0]OBUFDS_GTE3_ADV_CEB;
  input [3:0]OBUFDS_GTE3_ADV_I;
  output [0:0]OBUFDS_GTE3_ADV_O;
  output [0:0]OBUFDS_GTE3_ADV_OB;
  input [1:0]RXRECCLK_SEL_GTE3_ADV;
  input [0:0]OBUFDS_GTE4_CEB;
  input [0:0]OBUFDS_GTE4_I;
  output [0:0]OBUFDS_GTE4_O;
  output [0:0]OBUFDS_GTE4_OB;
  input [0:0]OBUFDS_GTE4_ADV_CEB;
  input [3:0]OBUFDS_GTE4_ADV_I;
  output [0:0]OBUFDS_GTE4_ADV_O;
  output [0:0]OBUFDS_GTE4_ADV_OB;
  input [1:0]RXRECCLK_SEL_GTE4_ADV;
  output [0:0]IBUFDS_GTM_O;
  output [0:0]IBUFDS_GTM_ODIV2;
  input [0:0]IBUFDS_GTM_CEB;
  input [0:0]IBUFDS_GTM_I;
  input [0:0]IBUFDS_GTM_IB;
  output [0:0]OBUFDS_GTM_O;
  output [0:0]OBUFDS_GTM_OB;
  input [0:0]OBUFDS_GTM_CEB;
  input [0:0]OBUFDS_GTM_I;
  input [0:0]OBUFDS_GTM_ADV_CEB;
  input [3:0]OBUFDS_GTM_ADV_I;
  output [0:0]OBUFDS_GTM_ADV_O;
  output [0:0]OBUFDS_GTM_ADV_OB;
  output [0:0]IBUFDS_GTME5_O;
  output [0:0]IBUFDS_GTME5_ODIV2;
  input [0:0]IBUFDS_GTME5_CEB;
  input [0:0]IBUFDS_GTME5_I;
  input [0:0]IBUFDS_GTME5_IB;
  input [0:0]OBUFDS_GTME5_CEB;
  input [0:0]OBUFDS_GTME5_I;
  output [0:0]OBUFDS_GTME5_O;
  output [0:0]OBUFDS_GTME5_OB;
  input [0:0]OBUFDS_GTME5_ADV_CEB;
  input [3:0]OBUFDS_GTME5_ADV_I;
  output [0:0]OBUFDS_GTME5_ADV_O;
  output [0:0]OBUFDS_GTME5_ADV_OB;
  input [0:0]BUFG_GT_I;
  input [0:0]BUFG_GT_CE;
  input [0:0]BUFG_GT_CEMASK;
  input [0:0]BUFG_GT_CLR;
  input [0:0]BUFG_GT_CLRMASK;
  input [2:0]BUFG_GT_DIV;
  output [0:0]BUFG_GT_O;

  wire \<const0> ;
  wire [0:0]IOBUF_IO_I;
  wire [0:0]IOBUF_IO_IO;
  wire [0:0]IOBUF_IO_O;
  wire [0:0]IOBUF_IO_T;

  assign BUFGCE_O[0] = \<const0> ;
  assign BUFG_FABRIC_O[0] = \<const0> ;
  assign BUFG_GT_O[0] = \<const0> ;
  assign BUFG_O[0] = \<const0> ;
  assign BUFHCE_O[0] = \<const0> ;
  assign BUFH_O[0] = \<const0> ;
  assign IBUFDS_GTME5_O[0] = \<const0> ;
  assign IBUFDS_GTME5_ODIV2[0] = \<const0> ;
  assign IBUFDS_GTM_O[0] = \<const0> ;
  assign IBUFDS_GTM_ODIV2[0] = \<const0> ;
  assign IBUF_DS_ODIV2[0] = \<const0> ;
  assign IBUF_OUT[0] = \<const0> ;
  assign OBUFDS_GTE3_ADV_O[0] = \<const0> ;
  assign OBUFDS_GTE3_ADV_OB[0] = \<const0> ;
  assign OBUFDS_GTE3_O[0] = \<const0> ;
  assign OBUFDS_GTE3_OB[0] = \<const0> ;
  assign OBUFDS_GTE4_ADV_O[0] = \<const0> ;
  assign OBUFDS_GTE4_ADV_OB[0] = \<const0> ;
  assign OBUFDS_GTE4_O[0] = \<const0> ;
  assign OBUFDS_GTE4_OB[0] = \<const0> ;
  assign OBUFDS_GTE5_ADV_O[0] = \<const0> ;
  assign OBUFDS_GTE5_ADV_OB[0] = \<const0> ;
  assign OBUFDS_GTE5_O[0] = \<const0> ;
  assign OBUFDS_GTE5_OB[0] = \<const0> ;
  assign OBUFDS_GTME5_ADV_O[0] = \<const0> ;
  assign OBUFDS_GTME5_ADV_OB[0] = \<const0> ;
  assign OBUFDS_GTME5_O[0] = \<const0> ;
  assign OBUFDS_GTME5_OB[0] = \<const0> ;
  assign OBUFDS_GTM_ADV_O[0] = \<const0> ;
  assign OBUFDS_GTM_ADV_OB[0] = \<const0> ;
  assign OBUFDS_GTM_O[0] = \<const0> ;
  assign OBUFDS_GTM_OB[0] = \<const0> ;
  assign OBUF_DS_N[0] = \<const0> ;
  assign OBUF_DS_P[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* box_type = "PRIMITIVE" *) 
  IOBUF #(
    .IOSTANDARD("DEFAULT")) 
    \USE_IOBUF.GEN_IOBUF[0].IOBUF_I 
       (.I(IOBUF_IO_I),
        .IO(IOBUF_IO_IO),
        .O(IOBUF_IO_O),
        .T(IOBUF_IO_T));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif