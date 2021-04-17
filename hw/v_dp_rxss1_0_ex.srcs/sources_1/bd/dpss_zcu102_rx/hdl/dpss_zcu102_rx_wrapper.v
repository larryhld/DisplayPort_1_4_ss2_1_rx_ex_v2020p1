//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Wed Apr  7 18:42:48 2021
//Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
//Command     : generate_target dpss_zcu102_rx_wrapper.bd
//Design      : dpss_zcu102_rx_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dpss_zcu102_rx_wrapper
   (B_SOURCE_AUX_DE,
    B_SOURCE_RST,
    IBUF_DS_N,
    IBUF_DS_N1,
    IBUF_DS_P,
    IBUF_DS_P1,
    aux_rx_data_en_out_n_0,
    aux_rx_data_in_0,
    aux_rx_data_out_0,
    i2c_scl,
    i2c_sda,
    phy_rxn_in,
    phy_rxp_in,
    pwd,
    reset,
    rx_hpd,
    user_si570_sysclk_clk_n,
    user_si570_sysclk_clk_p);
  output [0:0]B_SOURCE_AUX_DE;
  output [0:0]B_SOURCE_RST;
  input [0:0]IBUF_DS_N;
  input [0:0]IBUF_DS_N1;
  input [0:0]IBUF_DS_P;
  input [0:0]IBUF_DS_P1;
  output [0:0]aux_rx_data_en_out_n_0;
  input aux_rx_data_in_0;
  output aux_rx_data_out_0;
  inout [0:0]i2c_scl;
  inout [0:0]i2c_sda;
  input [3:0]phy_rxn_in;
  input [3:0]phy_rxp_in;
  output [0:0]pwd;
  input reset;
  output [0:0]rx_hpd;
  input user_si570_sysclk_clk_n;
  input user_si570_sysclk_clk_p;

  wire [0:0]B_SOURCE_AUX_DE;
  wire [0:0]B_SOURCE_RST;
  wire [0:0]IBUF_DS_N;
  wire [0:0]IBUF_DS_N1;
  wire [0:0]IBUF_DS_P;
  wire [0:0]IBUF_DS_P1;
  wire [0:0]aux_rx_data_en_out_n_0;
  wire aux_rx_data_in_0;
  wire aux_rx_data_out_0;
  wire [0:0]i2c_scl;
  wire [0:0]i2c_sda;
  wire [3:0]phy_rxn_in;
  wire [3:0]phy_rxp_in;
  wire [0:0]pwd;
  wire reset;
  wire [0:0]rx_hpd;
  wire user_si570_sysclk_clk_n;
  wire user_si570_sysclk_clk_p;

  dpss_zcu102_rx dpss_zcu102_rx_i
       (.B_SOURCE_AUX_DE(B_SOURCE_AUX_DE),
        .B_SOURCE_RST(B_SOURCE_RST),
        .IBUF_DS_N(IBUF_DS_N),
        .IBUF_DS_N1(IBUF_DS_N1),
        .IBUF_DS_P(IBUF_DS_P),
        .IBUF_DS_P1(IBUF_DS_P1),
        .aux_rx_data_en_out_n_0(aux_rx_data_en_out_n_0),
        .aux_rx_data_in_0(aux_rx_data_in_0),
        .aux_rx_data_out_0(aux_rx_data_out_0),
        .i2c_scl(i2c_scl),
        .i2c_sda(i2c_sda),
        .phy_rxn_in(phy_rxn_in),
        .phy_rxp_in(phy_rxp_in),
        .pwd(pwd),
        .reset(reset),
        .rx_hpd(rx_hpd),
        .user_si570_sysclk_clk_n(user_si570_sysclk_clk_n),
        .user_si570_sysclk_clk_p(user_si570_sysclk_clk_p));
endmodule
