-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Apr  7 18:48:00 2021
-- Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_vid_phy_controller_0_0/dpss_zcu102_rx_vid_phy_controller_0_0_stub.vhdl
-- Design      : dpss_zcu102_rx_vid_phy_controller_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dpss_zcu102_rx_vid_phy_controller_0_0 is
  Port ( 
    mgtrefclk0_in : in STD_LOGIC;
    mgtrefclk1_in : in STD_LOGIC;
    gtnorthrefclk0_in : in STD_LOGIC;
    gtnorthrefclk1_in : in STD_LOGIC;
    gtsouthrefclk0_in : in STD_LOGIC;
    gtsouthrefclk1_in : in STD_LOGIC;
    gtnorthrefclk00_in : in STD_LOGIC;
    gtnorthrefclk01_in : in STD_LOGIC;
    gtnorthrefclk10_in : in STD_LOGIC;
    gtnorthrefclk11_in : in STD_LOGIC;
    gtsouthrefclk00_in : in STD_LOGIC;
    gtsouthrefclk01_in : in STD_LOGIC;
    gtsouthrefclk10_in : in STD_LOGIC;
    gtsouthrefclk11_in : in STD_LOGIC;
    phy_rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    phy_rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxoutclk : out STD_LOGIC;
    vid_phy_rx_axi4s_ch0_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_rx_axi4s_ch0_tuser : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vid_phy_rx_axi4s_ch0_tvalid : out STD_LOGIC;
    vid_phy_rx_axi4s_ch0_tready : in STD_LOGIC;
    vid_phy_rx_axi4s_aclk : in STD_LOGIC;
    vid_phy_rx_axi4s_aresetn : in STD_LOGIC;
    vid_phy_rx_axi4s_ch1_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_rx_axi4s_ch1_tuser : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vid_phy_rx_axi4s_ch1_tvalid : out STD_LOGIC;
    vid_phy_rx_axi4s_ch1_tready : in STD_LOGIC;
    vid_phy_rx_axi4s_ch2_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_rx_axi4s_ch2_tuser : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vid_phy_rx_axi4s_ch2_tvalid : out STD_LOGIC;
    vid_phy_rx_axi4s_ch2_tready : in STD_LOGIC;
    vid_phy_rx_axi4s_ch3_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_rx_axi4s_ch3_tuser : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vid_phy_rx_axi4s_ch3_tvalid : out STD_LOGIC;
    vid_phy_rx_axi4s_ch3_tready : in STD_LOGIC;
    irq : out STD_LOGIC;
    vid_phy_sb_aclk : in STD_LOGIC;
    vid_phy_sb_aresetn : in STD_LOGIC;
    vid_phy_control_sb_rx_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vid_phy_control_sb_rx_tvalid : in STD_LOGIC;
    vid_phy_control_sb_rx_tready : out STD_LOGIC;
    vid_phy_status_sb_rx_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    vid_phy_status_sb_rx_tvalid : out STD_LOGIC;
    vid_phy_status_sb_rx_tready : in STD_LOGIC;
    vid_phy_axi4lite_awaddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    vid_phy_axi4lite_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vid_phy_axi4lite_awvalid : in STD_LOGIC;
    vid_phy_axi4lite_awready : out STD_LOGIC;
    vid_phy_axi4lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_axi4lite_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    vid_phy_axi4lite_wvalid : in STD_LOGIC;
    vid_phy_axi4lite_wready : out STD_LOGIC;
    vid_phy_axi4lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vid_phy_axi4lite_bvalid : out STD_LOGIC;
    vid_phy_axi4lite_bready : in STD_LOGIC;
    vid_phy_axi4lite_araddr : in STD_LOGIC_VECTOR ( 9 downto 0 );
    vid_phy_axi4lite_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    vid_phy_axi4lite_arvalid : in STD_LOGIC;
    vid_phy_axi4lite_arready : out STD_LOGIC;
    vid_phy_axi4lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vid_phy_axi4lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    vid_phy_axi4lite_rvalid : out STD_LOGIC;
    vid_phy_axi4lite_rready : in STD_LOGIC;
    vid_phy_axi4lite_aclk : in STD_LOGIC;
    vid_phy_axi4lite_aresetn : in STD_LOGIC;
    drpclk : in STD_LOGIC
  );

end dpss_zcu102_rx_vid_phy_controller_0_0;

architecture stub of dpss_zcu102_rx_vid_phy_controller_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "mgtrefclk0_in,mgtrefclk1_in,gtnorthrefclk0_in,gtnorthrefclk1_in,gtsouthrefclk0_in,gtsouthrefclk1_in,gtnorthrefclk00_in,gtnorthrefclk01_in,gtnorthrefclk10_in,gtnorthrefclk11_in,gtsouthrefclk00_in,gtsouthrefclk01_in,gtsouthrefclk10_in,gtsouthrefclk11_in,phy_rxn_in[3:0],phy_rxp_in[3:0],rxoutclk,vid_phy_rx_axi4s_ch0_tdata[31:0],vid_phy_rx_axi4s_ch0_tuser[11:0],vid_phy_rx_axi4s_ch0_tvalid,vid_phy_rx_axi4s_ch0_tready,vid_phy_rx_axi4s_aclk,vid_phy_rx_axi4s_aresetn,vid_phy_rx_axi4s_ch1_tdata[31:0],vid_phy_rx_axi4s_ch1_tuser[11:0],vid_phy_rx_axi4s_ch1_tvalid,vid_phy_rx_axi4s_ch1_tready,vid_phy_rx_axi4s_ch2_tdata[31:0],vid_phy_rx_axi4s_ch2_tuser[11:0],vid_phy_rx_axi4s_ch2_tvalid,vid_phy_rx_axi4s_ch2_tready,vid_phy_rx_axi4s_ch3_tdata[31:0],vid_phy_rx_axi4s_ch3_tuser[11:0],vid_phy_rx_axi4s_ch3_tvalid,vid_phy_rx_axi4s_ch3_tready,irq,vid_phy_sb_aclk,vid_phy_sb_aresetn,vid_phy_control_sb_rx_tdata[7:0],vid_phy_control_sb_rx_tvalid,vid_phy_control_sb_rx_tready,vid_phy_status_sb_rx_tdata[15:0],vid_phy_status_sb_rx_tvalid,vid_phy_status_sb_rx_tready,vid_phy_axi4lite_awaddr[9:0],vid_phy_axi4lite_awprot[2:0],vid_phy_axi4lite_awvalid,vid_phy_axi4lite_awready,vid_phy_axi4lite_wdata[31:0],vid_phy_axi4lite_wstrb[3:0],vid_phy_axi4lite_wvalid,vid_phy_axi4lite_wready,vid_phy_axi4lite_bresp[1:0],vid_phy_axi4lite_bvalid,vid_phy_axi4lite_bready,vid_phy_axi4lite_araddr[9:0],vid_phy_axi4lite_arprot[2:0],vid_phy_axi4lite_arvalid,vid_phy_axi4lite_arready,vid_phy_axi4lite_rdata[31:0],vid_phy_axi4lite_rresp[1:0],vid_phy_axi4lite_rvalid,vid_phy_axi4lite_rready,vid_phy_axi4lite_aclk,vid_phy_axi4lite_aresetn,drpclk";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "dpss_zcu102_rx_vid_phy_controller_0_0_top,Vivado 2020.1";
begin
end;
