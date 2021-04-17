-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Apr  7 18:54:48 2021
-- Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dpss_zcu102_rx_v_dp_rxss1_0_0_sim_netlist.vhdl
-- Design      : dpss_zcu102_rx_v_dp_rxss1_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0 : entity is "bd_6311_xlconstant_0_0,xlconstant_v1_1_7_xlconstant,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0 : entity is "xlconstant_v1_1_7_xlconstant,Vivado 2020.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xlconstant_0_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  dout(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311 is
  port (
    acr_m_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_n_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_valid : out STD_LOGIC;
    aud_axi_egress_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aud_axi_egress_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    aud_axi_egress_tready : in STD_LOGIC;
    aud_axi_egress_tvalid : out STD_LOGIC;
    aux_rx_data_en_out_n : out STD_LOGIC;
    aux_rx_data_in : in STD_LOGIC;
    aux_rx_data_out : out STD_LOGIC;
    dprxss_dp_irq : out STD_LOGIC;
    dprxss_iic_irq : out STD_LOGIC;
    edid_iic_scl_i : in STD_LOGIC;
    edid_iic_scl_o : out STD_LOGIC;
    edid_iic_scl_t : out STD_LOGIC;
    edid_iic_sda_i : in STD_LOGIC;
    edid_iic_sda_o : out STD_LOGIC;
    edid_iic_sda_t : out STD_LOGIC;
    ext_iic_scl_i : in STD_LOGIC;
    ext_iic_scl_o : out STD_LOGIC;
    ext_iic_scl_t : out STD_LOGIC;
    ext_iic_sda_i : in STD_LOGIC;
    ext_iic_sda_o : out STD_LOGIC;
    ext_iic_sda_t : out STD_LOGIC;
    ext_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_aud_axis_aclk : in STD_LOGIC;
    m_aud_axis_aresetn : in STD_LOGIC;
    m_axis_aclk_stream1 : in STD_LOGIC;
    m_axis_phy_rx_sb_control_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_phy_rx_sb_control_tready : in STD_LOGIC;
    m_axis_phy_rx_sb_control_tvalid : out STD_LOGIC;
    m_axis_video_stream1_tdata : out STD_LOGIC_VECTOR ( 119 downto 0 );
    m_axis_video_stream1_tlast : out STD_LOGIC;
    m_axis_video_stream1_tready : in STD_LOGIC;
    m_axis_video_stream1_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_video_stream1_tvalid : out STD_LOGIC;
    rx_hpd : out STD_LOGIC;
    rx_lnk_clk : in STD_LOGIC;
    rx_vid_clk : in STD_LOGIC;
    rx_vid_rst : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_lnk_rx_lane0_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane0_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane0_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane0_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane1_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane1_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane1_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane1_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane2_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane2_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane2_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane2_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane3_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane3_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane3_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane3_tvalid : in STD_LOGIC;
    s_axis_phy_rx_sb_status_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_phy_rx_sb_status_tready : out STD_LOGIC;
    s_axis_phy_rx_sb_status_tvalid : in STD_LOGIC
  );
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311 : entity is "dpss_zcu102_rx_v_dp_rxss1_0_0.hwdef";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311 is
  component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_dp_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    axi_int : out STD_LOGIC;
    rx_vid_clk : in STD_LOGIC;
    rx_vid_rst : in STD_LOGIC;
    rx_vid_vsync : out STD_LOGIC;
    rx_vid_hsync : out STD_LOGIC;
    rx_vid_oddeven : out STD_LOGIC;
    rx_vid_enable : out STD_LOGIC;
    rx_vid_pixel0 : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rx_vid_pixel1 : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rx_vid_pixel2 : out STD_LOGIC_VECTOR ( 47 downto 0 );
    rx_vid_pixel3 : out STD_LOGIC_VECTOR ( 47 downto 0 );
    lnk_m_vid : out STD_LOGIC_VECTOR ( 23 downto 0 );
    lnk_n_vid : out STD_LOGIC_VECTOR ( 23 downto 0 );
    aux_rx_data_in : in STD_LOGIC;
    aux_rx_data_out : out STD_LOGIC;
    aux_rx_data_en_out_n : out STD_LOGIC;
    rx_hpd : out STD_LOGIC;
    i2c_sda_in : in STD_LOGIC;
    i2c_sda_enable_n : out STD_LOGIC;
    i2c_sda_o : out STD_LOGIC;
    i2c_scl_in : in STD_LOGIC;
    i2c_scl_enable_n : out STD_LOGIC;
    i2c_scl_o : out STD_LOGIC;
    aud_rst : in STD_LOGIC;
    rx_lnk_clk : in STD_LOGIC;
    lnk_rx_axi4s_lane0_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    lnk_rx_axi4s_lane0_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    lnk_rx_axi4s_lane0_tvalid : in STD_LOGIC;
    lnk_rx_axi4s_lane0_tready : out STD_LOGIC;
    lnk_rx_axi4s_lane1_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    lnk_rx_axi4s_lane1_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    lnk_rx_axi4s_lane1_tvalid : in STD_LOGIC;
    lnk_rx_axi4s_lane1_tready : out STD_LOGIC;
    lnk_rx_axi4s_lane2_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    lnk_rx_axi4s_lane2_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    lnk_rx_axi4s_lane2_tvalid : in STD_LOGIC;
    lnk_rx_axi4s_lane2_tready : out STD_LOGIC;
    lnk_rx_axi4s_lane3_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    lnk_rx_axi4s_lane3_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    lnk_rx_axi4s_lane3_tvalid : in STD_LOGIC;
    lnk_rx_axi4s_lane3_tready : out STD_LOGIC;
    lnk_rx_sb_status_axi4s_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    lnk_rx_sb_status_axi4s_tvalid : in STD_LOGIC;
    lnk_rx_sb_status_axi4s_tready : out STD_LOGIC;
    lnk_rx_sb_control_axi4s_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    lnk_rx_sb_control_axi4s_tvalid : out STD_LOGIC;
    lnk_rx_sb_control_axi4s_tready : in STD_LOGIC;
    lnk_m_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    lnk_n_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    m_aud_axis_aclk : in STD_LOGIC;
    m_aud_axis_aresetn : in STD_LOGIC;
    m_axis_audio_egress_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_audio_egress_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_audio_egress_tvalid : out STD_LOGIC;
    m_axis_audio_egress_tready : in STD_LOGIC;
    link_bw_high_out : out STD_LOGIC;
    link_bw_hbr2_out : out STD_LOGIC;
    bw_changed_out : out STD_LOGIC;
    rx_vid_pixel_mode : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rx_vid_msa_hres : out STD_LOGIC_VECTOR ( 15 downto 0 );
    rx_vid_msa_vres : out STD_LOGIC_VECTOR ( 15 downto 0 );
    rx_bpc : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rx_cformat : out STD_LOGIC_VECTOR ( 2 downto 0 );
    acr_m_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_n_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_valid : out STD_LOGIC
  );
  end component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_dp_0;
  component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_iic_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    iic2intc_irpt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    sda_i : in STD_LOGIC;
    sda_o : out STD_LOGIC;
    sda_t : out STD_LOGIC;
    scl_i : in STD_LOGIC;
    scl_o : out STD_LOGIC;
    scl_t : out STD_LOGIC;
    gpo : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_iic_0;
  component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_notof_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_notof_0_0;
  component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_vb1_0 is
  port (
    vid_pixel_clk : in STD_LOGIC;
    vid_reset : in STD_LOGIC;
    vid_active_video : in STD_LOGIC;
    vid_vsync : in STD_LOGIC;
    vid_hsync : in STD_LOGIC;
    vid_pixel0 : in STD_LOGIC_VECTOR ( 47 downto 0 );
    vid_pixel1 : in STD_LOGIC_VECTOR ( 47 downto 0 );
    vid_pixel2 : in STD_LOGIC_VECTOR ( 47 downto 0 );
    vid_pixel3 : in STD_LOGIC_VECTOR ( 47 downto 0 );
    dp_hres : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pixel_mode : in STD_LOGIC_VECTOR ( 2 downto 0 );
    bpc : in STD_LOGIC_VECTOR ( 2 downto 0 );
    color_format : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    m_axis_video_tdata : out STD_LOGIC_VECTOR ( 119 downto 0 );
    m_axis_video_tlast : out STD_LOGIC;
    m_axis_video_tvalid : out STD_LOGIC;
    m_axis_video_tready : in STD_LOGIC;
    wr_error : out STD_LOGIC;
    rd_error : out STD_LOGIC;
    m_axis_video_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    hres_cntr_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    vres_cntr_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    debug_port : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_vb1_0;
  component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xbar_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M01_AXI_wvalid : out STD_LOGIC;
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_rready : out STD_LOGIC
  );
  end component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xbar_0;
  signal dp_dp_rx_vid_intf_str0_TX_VID_ENABLE : STD_LOGIC;
  signal dp_dp_rx_vid_intf_str0_TX_VID_HSYNC : STD_LOGIC;
  signal dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0 : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1 : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2 : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3 : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal dp_dp_rx_vid_intf_str0_TX_VID_VSYNC : STD_LOGIC;
  signal dp_rx_bpc : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal dp_rx_cformat : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal dp_rx_vid_msa_hres : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal dp_rx_vid_pixel_mode : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal notof_0_Res : STD_LOGIC;
  signal xbar_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal xbar_M00_AXI_ARREADY : STD_LOGIC;
  signal xbar_M00_AXI_ARVALID : STD_LOGIC;
  signal xbar_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal xbar_M00_AXI_AWREADY : STD_LOGIC;
  signal xbar_M00_AXI_AWVALID : STD_LOGIC;
  signal xbar_M00_AXI_BREADY : STD_LOGIC;
  signal xbar_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_M00_AXI_BVALID : STD_LOGIC;
  signal xbar_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M00_AXI_RREADY : STD_LOGIC;
  signal xbar_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_M00_AXI_RVALID : STD_LOGIC;
  signal xbar_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M00_AXI_WREADY : STD_LOGIC;
  signal xbar_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_M00_AXI_WVALID : STD_LOGIC;
  signal xbar_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M01_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_M01_AXI_ARREADY : STD_LOGIC;
  signal xbar_M01_AXI_ARVALID : STD_LOGIC;
  signal xbar_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M01_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_M01_AXI_AWREADY : STD_LOGIC;
  signal xbar_M01_AXI_AWVALID : STD_LOGIC;
  signal xbar_M01_AXI_BREADY : STD_LOGIC;
  signal xbar_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_M01_AXI_BVALID : STD_LOGIC;
  signal xbar_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M01_AXI_RREADY : STD_LOGIC;
  signal xbar_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_M01_AXI_RVALID : STD_LOGIC;
  signal xbar_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_M01_AXI_WREADY : STD_LOGIC;
  signal xbar_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_M01_AXI_WVALID : STD_LOGIC;
  signal NLW_dp_bw_changed_out_UNCONNECTED : STD_LOGIC;
  signal NLW_dp_link_bw_hbr2_out_UNCONNECTED : STD_LOGIC;
  signal NLW_dp_link_bw_high_out_UNCONNECTED : STD_LOGIC;
  signal NLW_dp_rx_vid_oddeven_UNCONNECTED : STD_LOGIC;
  signal NLW_dp_lnk_m_aud_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_dp_lnk_m_vid_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_dp_lnk_n_aud_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_dp_lnk_n_vid_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_dp_rx_vid_msa_vres_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_vb1_rd_error_UNCONNECTED : STD_LOGIC;
  signal NLW_vb1_wr_error_UNCONNECTED : STD_LOGIC;
  signal NLW_vb1_debug_port_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_vb1_hres_cntr_out_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_vb1_vres_cntr_out_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_xbar_M00_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_xbar_M00_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of dp : label is "bd_6311_dp_0_dport_wrapper,Vivado 2020.1";
  attribute X_CORE_INFO of iic : label is "axi_iic,Vivado 2020.1";
  attribute X_CORE_INFO of notof_0 : label is "util_vector_logic_v2_0_1_util_vector_logic,Vivado 2020.1";
  attribute X_CORE_INFO of vb1 : label is "dp_videoaxi4s_bridge_v1_0_1,Vivado 2020.1";
  attribute X_CORE_INFO of xbar : label is "bd_6050,Vivado 2020.1";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of acr_valid : signal is "xilinx.com:signal:data:1.0 DATA.ACR_VALID DATA";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of acr_valid : signal is "XIL_INTERFACENAME DATA.ACR_VALID, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of aud_axi_egress_tready : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TREADY";
  attribute X_INTERFACE_INFO of aud_axi_egress_tvalid : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TVALID";
  attribute X_INTERFACE_INFO of dprxss_dp_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.DPRXSS_DP_IRQ INTERRUPT";
  attribute X_INTERFACE_PARAMETER of dprxss_dp_irq : signal is "XIL_INTERFACENAME INTR.DPRXSS_DP_IRQ, PortWidth 1, SENSITIVITY LEVEL_HIGH";
  attribute X_INTERFACE_INFO of dprxss_iic_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.DPRXSS_IIC_IRQ INTERRUPT";
  attribute X_INTERFACE_PARAMETER of dprxss_iic_irq : signal is "XIL_INTERFACENAME INTR.DPRXSS_IIC_IRQ, PortWidth 1, SENSITIVITY LEVEL_HIGH";
  attribute X_INTERFACE_INFO of edid_iic_scl_i : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_I";
  attribute X_INTERFACE_INFO of edid_iic_scl_o : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_O";
  attribute X_INTERFACE_INFO of edid_iic_scl_t : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_T";
  attribute X_INTERFACE_INFO of edid_iic_sda_i : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_I";
  attribute X_INTERFACE_INFO of edid_iic_sda_o : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_O";
  attribute X_INTERFACE_INFO of edid_iic_sda_t : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_T";
  attribute X_INTERFACE_INFO of ext_iic_scl_i : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_I";
  attribute X_INTERFACE_INFO of ext_iic_scl_o : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_O";
  attribute X_INTERFACE_INFO of ext_iic_scl_t : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_T";
  attribute X_INTERFACE_INFO of ext_iic_sda_i : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_I";
  attribute X_INTERFACE_INFO of ext_iic_sda_o : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_O";
  attribute X_INTERFACE_INFO of ext_iic_sda_t : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_T";
  attribute X_INTERFACE_INFO of m_aud_axis_aclk : signal is "xilinx.com:signal:clock:1.0 CLK.M_AUD_AXIS_ACLK CLK";
  attribute X_INTERFACE_PARAMETER of m_aud_axis_aclk : signal is "XIL_INTERFACENAME CLK.M_AUD_AXIS_ACLK, ASSOCIATED_BUSIF aud_axi_egress, ASSOCIATED_RESET m_aud_axis_aresetn, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of m_aud_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 RST.M_AUD_AXIS_ARESETN RST";
  attribute X_INTERFACE_PARAMETER of m_aud_axis_aresetn : signal is "XIL_INTERFACENAME RST.M_AUD_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of m_axis_aclk_stream1 : signal is "xilinx.com:signal:clock:1.0 CLK.M_AXIS_ACLK_STREAM1 CLK";
  attribute X_INTERFACE_PARAMETER of m_axis_aclk_stream1 : signal is "XIL_INTERFACENAME CLK.M_AXIS_ACLK_STREAM1, ASSOCIATED_BUSIF m_axis_video_stream1, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TREADY";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TVALID";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TLAST";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TREADY";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TVALID";
  attribute X_INTERFACE_INFO of rx_hpd : signal is "xilinx.com:signal:data:1.0 DATA.RX_HPD DATA";
  attribute X_INTERFACE_PARAMETER of rx_hpd : signal is "XIL_INTERFACENAME DATA.RX_HPD, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of rx_lnk_clk : signal is "xilinx.com:signal:clock:1.0 CLK.RX_LNK_CLK CLK";
  attribute X_INTERFACE_PARAMETER of rx_lnk_clk : signal is "XIL_INTERFACENAME CLK.RX_LNK_CLK, ASSOCIATED_BUSIF s_axis_lnk_rx_lane0:s_axis_lnk_rx_lane1:s_axis_lnk_rx_lane2:s_axis_lnk_rx_lane3, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of rx_vid_clk : signal is "xilinx.com:signal:clock:1.0 CLK.RX_VID_CLK CLK";
  attribute X_INTERFACE_PARAMETER of rx_vid_clk : signal is "XIL_INTERFACENAME CLK.RX_VID_CLK, ASSOCIATED_RESET rx_vid_rst, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of rx_vid_rst : signal is "xilinx.com:signal:reset:1.0 RST.RX_VID_RST RST";
  attribute X_INTERFACE_PARAMETER of rx_vid_rst : signal is "XIL_INTERFACENAME RST.RX_VID_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH";
  attribute X_INTERFACE_INFO of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 CLK.S_AXI_ACLK CLK";
  attribute X_INTERFACE_PARAMETER of s_axi_aclk : signal is "XIL_INTERFACENAME CLK.S_AXI_ACLK, ASSOCIATED_BUSIF m_axis_phy_rx_sb_control:s_axi:s_axis_phy_rx_sb_status, ASSOCIATED_CLKEN s_sc_aclken, ASSOCIATED_RESET s_axi_aresetn, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 RST.S_AXI_ARESETN RST";
  attribute X_INTERFACE_PARAMETER of s_axi_aresetn : signal is "XIL_INTERFACENAME RST.S_AXI_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TVALID";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TVALID";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TVALID";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TVALID";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TREADY";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TVALID";
  attribute X_INTERFACE_INFO of aud_axi_egress_tdata : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TDATA";
  attribute X_INTERFACE_PARAMETER of aud_axi_egress_tdata : signal is "XIL_INTERFACENAME aud_axi_egress, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of aud_axi_egress_tid : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TID";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TDATA";
  attribute X_INTERFACE_PARAMETER of m_axis_phy_rx_sb_control_tdata : signal is "XIL_INTERFACENAME m_axis_phy_rx_sb_control, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TDATA";
  attribute X_INTERFACE_PARAMETER of m_axis_video_stream1_tdata : signal is "XIL_INTERFACENAME m_axis_video_stream1, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, FREQ_HZ 300000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 15, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tuser : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TUSER";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_PARAMETER of s_axi_araddr : signal is "XIL_INTERFACENAME s_axi, ADDR_WIDTH 13, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, DATA_WIDTH 32, FREQ_HZ 99999001, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 8, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 8, NUM_WRITE_THREADS 1, PHASE 0.000, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of s_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 s_axi ARPROT";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_INFO of s_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 s_axi AWPROT";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane0_tdata : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane0, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane1_tdata : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane1, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane2_tdata : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane2, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane3_tdata : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane3, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, FREQ_HZ 405000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TUSER";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_phy_rx_sb_status_tdata : signal is "XIL_INTERFACENAME s_axis_phy_rx_sb_status, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, FREQ_HZ 99999001, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
begin
dp: component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_dp_0
     port map (
      acr_m_aud(23 downto 0) => acr_m_aud(23 downto 0),
      acr_n_aud(23 downto 0) => acr_n_aud(23 downto 0),
      acr_valid => acr_valid,
      aud_rst => notof_0_Res,
      aux_rx_data_en_out_n => aux_rx_data_en_out_n,
      aux_rx_data_in => aux_rx_data_in,
      aux_rx_data_out => aux_rx_data_out,
      axi_int => dprxss_dp_irq,
      bw_changed_out => NLW_dp_bw_changed_out_UNCONNECTED,
      i2c_scl_enable_n => edid_iic_scl_t,
      i2c_scl_in => edid_iic_scl_i,
      i2c_scl_o => edid_iic_scl_o,
      i2c_sda_enable_n => edid_iic_sda_t,
      i2c_sda_in => edid_iic_sda_i,
      i2c_sda_o => edid_iic_sda_o,
      link_bw_hbr2_out => NLW_dp_link_bw_hbr2_out_UNCONNECTED,
      link_bw_high_out => NLW_dp_link_bw_high_out_UNCONNECTED,
      lnk_m_aud(23 downto 0) => NLW_dp_lnk_m_aud_UNCONNECTED(23 downto 0),
      lnk_m_vid(23 downto 0) => NLW_dp_lnk_m_vid_UNCONNECTED(23 downto 0),
      lnk_n_aud(23 downto 0) => NLW_dp_lnk_n_aud_UNCONNECTED(23 downto 0),
      lnk_n_vid(23 downto 0) => NLW_dp_lnk_n_vid_UNCONNECTED(23 downto 0),
      lnk_rx_axi4s_lane0_tdata(31 downto 0) => s_axis_lnk_rx_lane0_tdata(31 downto 0),
      lnk_rx_axi4s_lane0_tready => s_axis_lnk_rx_lane0_tready,
      lnk_rx_axi4s_lane0_tuser(11 downto 0) => s_axis_lnk_rx_lane0_tuser(11 downto 0),
      lnk_rx_axi4s_lane0_tvalid => s_axis_lnk_rx_lane0_tvalid,
      lnk_rx_axi4s_lane1_tdata(31 downto 0) => s_axis_lnk_rx_lane1_tdata(31 downto 0),
      lnk_rx_axi4s_lane1_tready => s_axis_lnk_rx_lane1_tready,
      lnk_rx_axi4s_lane1_tuser(11 downto 0) => s_axis_lnk_rx_lane1_tuser(11 downto 0),
      lnk_rx_axi4s_lane1_tvalid => s_axis_lnk_rx_lane1_tvalid,
      lnk_rx_axi4s_lane2_tdata(31 downto 0) => s_axis_lnk_rx_lane2_tdata(31 downto 0),
      lnk_rx_axi4s_lane2_tready => s_axis_lnk_rx_lane2_tready,
      lnk_rx_axi4s_lane2_tuser(11 downto 0) => s_axis_lnk_rx_lane2_tuser(11 downto 0),
      lnk_rx_axi4s_lane2_tvalid => s_axis_lnk_rx_lane2_tvalid,
      lnk_rx_axi4s_lane3_tdata(31 downto 0) => s_axis_lnk_rx_lane3_tdata(31 downto 0),
      lnk_rx_axi4s_lane3_tready => s_axis_lnk_rx_lane3_tready,
      lnk_rx_axi4s_lane3_tuser(11 downto 0) => s_axis_lnk_rx_lane3_tuser(11 downto 0),
      lnk_rx_axi4s_lane3_tvalid => s_axis_lnk_rx_lane3_tvalid,
      lnk_rx_sb_control_axi4s_tdata(7 downto 0) => m_axis_phy_rx_sb_control_tdata(7 downto 0),
      lnk_rx_sb_control_axi4s_tready => m_axis_phy_rx_sb_control_tready,
      lnk_rx_sb_control_axi4s_tvalid => m_axis_phy_rx_sb_control_tvalid,
      lnk_rx_sb_status_axi4s_tdata(31 downto 0) => s_axis_phy_rx_sb_status_tdata(31 downto 0),
      lnk_rx_sb_status_axi4s_tready => s_axis_phy_rx_sb_status_tready,
      lnk_rx_sb_status_axi4s_tvalid => s_axis_phy_rx_sb_status_tvalid,
      m_aud_axis_aclk => m_aud_axis_aclk,
      m_aud_axis_aresetn => m_aud_axis_aresetn,
      m_axis_audio_egress_tdata(31 downto 0) => aud_axi_egress_tdata(31 downto 0),
      m_axis_audio_egress_tid(7 downto 0) => aud_axi_egress_tid(7 downto 0),
      m_axis_audio_egress_tready => aud_axi_egress_tready,
      m_axis_audio_egress_tvalid => aud_axi_egress_tvalid,
      rx_bpc(2 downto 0) => dp_rx_bpc(2 downto 0),
      rx_cformat(2 downto 0) => dp_rx_cformat(2 downto 0),
      rx_hpd => rx_hpd,
      rx_lnk_clk => rx_lnk_clk,
      rx_vid_clk => rx_vid_clk,
      rx_vid_enable => dp_dp_rx_vid_intf_str0_TX_VID_ENABLE,
      rx_vid_hsync => dp_dp_rx_vid_intf_str0_TX_VID_HSYNC,
      rx_vid_msa_hres(15 downto 0) => dp_rx_vid_msa_hres(15 downto 0),
      rx_vid_msa_vres(15 downto 0) => NLW_dp_rx_vid_msa_vres_UNCONNECTED(15 downto 0),
      rx_vid_oddeven => NLW_dp_rx_vid_oddeven_UNCONNECTED,
      rx_vid_pixel0(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0(47 downto 0),
      rx_vid_pixel1(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1(47 downto 0),
      rx_vid_pixel2(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2(47 downto 0),
      rx_vid_pixel3(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3(47 downto 0),
      rx_vid_pixel_mode(2 downto 0) => dp_rx_vid_pixel_mode(2 downto 0),
      rx_vid_rst => rx_vid_rst,
      rx_vid_vsync => dp_dp_rx_vid_intf_str0_TX_VID_VSYNC,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(31 downto 0) => xbar_M01_AXI_ARADDR(31 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arprot(2 downto 0) => xbar_M01_AXI_ARPROT(2 downto 0),
      s_axi_arready => xbar_M01_AXI_ARREADY,
      s_axi_arvalid => xbar_M01_AXI_ARVALID,
      s_axi_awaddr(31 downto 0) => xbar_M01_AXI_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => xbar_M01_AXI_AWPROT(2 downto 0),
      s_axi_awready => xbar_M01_AXI_AWREADY,
      s_axi_awvalid => xbar_M01_AXI_AWVALID,
      s_axi_bready => xbar_M01_AXI_BREADY,
      s_axi_bresp(1 downto 0) => xbar_M01_AXI_BRESP(1 downto 0),
      s_axi_bvalid => xbar_M01_AXI_BVALID,
      s_axi_rdata(31 downto 0) => xbar_M01_AXI_RDATA(31 downto 0),
      s_axi_rready => xbar_M01_AXI_RREADY,
      s_axi_rresp(1 downto 0) => xbar_M01_AXI_RRESP(1 downto 0),
      s_axi_rvalid => xbar_M01_AXI_RVALID,
      s_axi_wdata(31 downto 0) => xbar_M01_AXI_WDATA(31 downto 0),
      s_axi_wready => xbar_M01_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => xbar_M01_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => xbar_M01_AXI_WVALID
    );
iic: component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_iic_0
     port map (
      gpo(0) => ext_rst(0),
      iic2intc_irpt => dprxss_iic_irq,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(8 downto 0) => xbar_M00_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => xbar_M00_AXI_ARREADY,
      s_axi_arvalid => xbar_M00_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => xbar_M00_AXI_AWADDR(8 downto 0),
      s_axi_awready => xbar_M00_AXI_AWREADY,
      s_axi_awvalid => xbar_M00_AXI_AWVALID,
      s_axi_bready => xbar_M00_AXI_BREADY,
      s_axi_bresp(1 downto 0) => xbar_M00_AXI_BRESP(1 downto 0),
      s_axi_bvalid => xbar_M00_AXI_BVALID,
      s_axi_rdata(31 downto 0) => xbar_M00_AXI_RDATA(31 downto 0),
      s_axi_rready => xbar_M00_AXI_RREADY,
      s_axi_rresp(1 downto 0) => xbar_M00_AXI_RRESP(1 downto 0),
      s_axi_rvalid => xbar_M00_AXI_RVALID,
      s_axi_wdata(31 downto 0) => xbar_M00_AXI_WDATA(31 downto 0),
      s_axi_wready => xbar_M00_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => xbar_M00_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => xbar_M00_AXI_WVALID,
      scl_i => ext_iic_scl_i,
      scl_o => ext_iic_scl_o,
      scl_t => ext_iic_scl_t,
      sda_i => ext_iic_sda_i,
      sda_o => ext_iic_sda_o,
      sda_t => ext_iic_sda_t
    );
notof_0: component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_notof_0_0
     port map (
      Op1(0) => m_aud_axis_aresetn,
      Res(0) => notof_0_Res
    );
vb1: component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_vb1_0
     port map (
      bpc(2 downto 0) => dp_rx_bpc(2 downto 0),
      color_format(2 downto 0) => dp_rx_cformat(2 downto 0),
      debug_port(4 downto 0) => NLW_vb1_debug_port_UNCONNECTED(4 downto 0),
      dp_hres(15 downto 0) => dp_rx_vid_msa_hres(15 downto 0),
      hres_cntr_out(15 downto 0) => NLW_vb1_hres_cntr_out_UNCONNECTED(15 downto 0),
      m_axis_aclk => m_axis_aclk_stream1,
      m_axis_video_tdata(119 downto 0) => m_axis_video_stream1_tdata(119 downto 0),
      m_axis_video_tlast => m_axis_video_stream1_tlast,
      m_axis_video_tready => m_axis_video_stream1_tready,
      m_axis_video_tuser(0) => m_axis_video_stream1_tuser(0),
      m_axis_video_tvalid => m_axis_video_stream1_tvalid,
      pixel_mode(2 downto 0) => dp_rx_vid_pixel_mode(2 downto 0),
      rd_error => NLW_vb1_rd_error_UNCONNECTED,
      vid_active_video => dp_dp_rx_vid_intf_str0_TX_VID_ENABLE,
      vid_hsync => dp_dp_rx_vid_intf_str0_TX_VID_HSYNC,
      vid_pixel0(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL0(47 downto 0),
      vid_pixel1(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL1(47 downto 0),
      vid_pixel2(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL2(47 downto 0),
      vid_pixel3(47 downto 0) => dp_dp_rx_vid_intf_str0_TX_VID_PIXEL3(47 downto 0),
      vid_pixel_clk => rx_vid_clk,
      vid_reset => rx_vid_rst,
      vid_vsync => dp_dp_rx_vid_intf_str0_TX_VID_VSYNC,
      vres_cntr_out(15 downto 0) => NLW_vb1_vres_cntr_out_UNCONNECTED(15 downto 0),
      wr_error => NLW_vb1_wr_error_UNCONNECTED
    );
xbar: component decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311_xbar_0
     port map (
      M00_AXI_araddr(8 downto 0) => xbar_M00_AXI_ARADDR(8 downto 0),
      M00_AXI_arprot(2 downto 0) => NLW_xbar_M00_AXI_arprot_UNCONNECTED(2 downto 0),
      M00_AXI_arready => xbar_M00_AXI_ARREADY,
      M00_AXI_arvalid => xbar_M00_AXI_ARVALID,
      M00_AXI_awaddr(8 downto 0) => xbar_M00_AXI_AWADDR(8 downto 0),
      M00_AXI_awprot(2 downto 0) => NLW_xbar_M00_AXI_awprot_UNCONNECTED(2 downto 0),
      M00_AXI_awready => xbar_M00_AXI_AWREADY,
      M00_AXI_awvalid => xbar_M00_AXI_AWVALID,
      M00_AXI_bready => xbar_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => xbar_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => xbar_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => xbar_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rready => xbar_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => xbar_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => xbar_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => xbar_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wready => xbar_M00_AXI_WREADY,
      M00_AXI_wstrb(3 downto 0) => xbar_M00_AXI_WSTRB(3 downto 0),
      M00_AXI_wvalid => xbar_M00_AXI_WVALID,
      M01_AXI_araddr(31 downto 0) => xbar_M01_AXI_ARADDR(31 downto 0),
      M01_AXI_arprot(2 downto 0) => xbar_M01_AXI_ARPROT(2 downto 0),
      M01_AXI_arready => xbar_M01_AXI_ARREADY,
      M01_AXI_arvalid => xbar_M01_AXI_ARVALID,
      M01_AXI_awaddr(31 downto 0) => xbar_M01_AXI_AWADDR(31 downto 0),
      M01_AXI_awprot(2 downto 0) => xbar_M01_AXI_AWPROT(2 downto 0),
      M01_AXI_awready => xbar_M01_AXI_AWREADY,
      M01_AXI_awvalid => xbar_M01_AXI_AWVALID,
      M01_AXI_bready => xbar_M01_AXI_BREADY,
      M01_AXI_bresp(1 downto 0) => xbar_M01_AXI_BRESP(1 downto 0),
      M01_AXI_bvalid => xbar_M01_AXI_BVALID,
      M01_AXI_rdata(31 downto 0) => xbar_M01_AXI_RDATA(31 downto 0),
      M01_AXI_rready => xbar_M01_AXI_RREADY,
      M01_AXI_rresp(1 downto 0) => xbar_M01_AXI_RRESP(1 downto 0),
      M01_AXI_rvalid => xbar_M01_AXI_RVALID,
      M01_AXI_wdata(31 downto 0) => xbar_M01_AXI_WDATA(31 downto 0),
      M01_AXI_wready => xbar_M01_AXI_WREADY,
      M01_AXI_wstrb(3 downto 0) => xbar_M01_AXI_WSTRB(3 downto 0),
      M01_AXI_wvalid => xbar_M01_AXI_WVALID,
      S00_AXI_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      S00_AXI_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      S00_AXI_arready => s_axi_arready(0),
      S00_AXI_arvalid => s_axi_arvalid(0),
      S00_AXI_awaddr(12 downto 0) => s_axi_awaddr(12 downto 0),
      S00_AXI_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      S00_AXI_awready => s_axi_awready(0),
      S00_AXI_awvalid => s_axi_awvalid(0),
      S00_AXI_bready => s_axi_bready(0),
      S00_AXI_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      S00_AXI_bvalid => s_axi_bvalid(0),
      S00_AXI_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      S00_AXI_rready => s_axi_rready(0),
      S00_AXI_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      S00_AXI_rvalid => s_axi_rvalid(0),
      S00_AXI_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      S00_AXI_wready => s_axi_wready(0),
      S00_AXI_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      S00_AXI_wvalid => s_axi_wvalid(0),
      aclk => s_axi_aclk,
      aresetn => s_axi_aresetn
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    rx_vid_clk : in STD_LOGIC;
    rx_vid_rst : in STD_LOGIC;
    m_axis_aclk_stream1 : in STD_LOGIC;
    aux_rx_data_in : in STD_LOGIC;
    aux_rx_data_out : out STD_LOGIC;
    aux_rx_data_en_out_n : out STD_LOGIC;
    rx_lnk_clk : in STD_LOGIC;
    rx_hpd : out STD_LOGIC;
    dprxss_dp_irq : out STD_LOGIC;
    m_aud_axis_aclk : in STD_LOGIC;
    m_aud_axis_aresetn : in STD_LOGIC;
    acr_m_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_n_aud : out STD_LOGIC_VECTOR ( 23 downto 0 );
    acr_valid : out STD_LOGIC;
    ext_rst : out STD_LOGIC_VECTOR ( 0 to 0 );
    dprxss_iic_irq : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_video_stream1_tdata : out STD_LOGIC_VECTOR ( 119 downto 0 );
    m_axis_video_stream1_tlast : out STD_LOGIC;
    m_axis_video_stream1_tready : in STD_LOGIC;
    m_axis_video_stream1_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_video_stream1_tvalid : out STD_LOGIC;
    s_axis_lnk_rx_lane0_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane0_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane0_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane0_tvalid : in STD_LOGIC;
    m_axis_phy_rx_sb_control_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_phy_rx_sb_control_tready : in STD_LOGIC;
    m_axis_phy_rx_sb_control_tvalid : out STD_LOGIC;
    s_axis_phy_rx_sb_status_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_phy_rx_sb_status_tready : out STD_LOGIC;
    s_axis_phy_rx_sb_status_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane3_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane3_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane3_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane3_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane2_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane2_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane2_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane2_tvalid : in STD_LOGIC;
    s_axis_lnk_rx_lane1_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_lnk_rx_lane1_tready : out STD_LOGIC;
    s_axis_lnk_rx_lane1_tuser : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axis_lnk_rx_lane1_tvalid : in STD_LOGIC;
    edid_iic_scl_i : in STD_LOGIC;
    edid_iic_scl_o : out STD_LOGIC;
    edid_iic_scl_t : out STD_LOGIC;
    edid_iic_sda_i : in STD_LOGIC;
    edid_iic_sda_o : out STD_LOGIC;
    edid_iic_sda_t : out STD_LOGIC;
    ext_iic_scl_i : in STD_LOGIC;
    ext_iic_scl_o : out STD_LOGIC;
    ext_iic_scl_t : out STD_LOGIC;
    ext_iic_sda_i : in STD_LOGIC;
    ext_iic_sda_o : out STD_LOGIC;
    ext_iic_sda_t : out STD_LOGIC;
    aud_axi_egress_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aud_axi_egress_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    aud_axi_egress_tready : in STD_LOGIC;
    aud_axi_egress_tvalid : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "dpss_zcu102_rx_v_dp_rxss1_0_0,bd_6311,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "bd_6311,Vivado 2020.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of inst : label is "dpss_zcu102_rx_v_dp_rxss1_0_0.hwdef";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of acr_valid : signal is "xilinx.com:signal:data:1.0 DATA.acr_valid DATA";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of acr_valid : signal is "XIL_INTERFACENAME DATA.acr_valid, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of aud_axi_egress_tready : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TREADY";
  attribute X_INTERFACE_INFO of aud_axi_egress_tvalid : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TVALID";
  attribute X_INTERFACE_PARAMETER of aud_axi_egress_tvalid : signal is "XIL_INTERFACENAME aud_axi_egress, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 8, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of dprxss_dp_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.dprxss_dp_irq INTERRUPT";
  attribute X_INTERFACE_PARAMETER of dprxss_dp_irq : signal is "XIL_INTERFACENAME INTR.dprxss_dp_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of dprxss_iic_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.dprxss_iic_irq INTERRUPT";
  attribute X_INTERFACE_PARAMETER of dprxss_iic_irq : signal is "XIL_INTERFACENAME INTR.dprxss_iic_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of edid_iic_scl_i : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_I";
  attribute X_INTERFACE_INFO of edid_iic_scl_o : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_O";
  attribute X_INTERFACE_INFO of edid_iic_scl_t : signal is "xilinx.com:interface:iic:1.0 edid_iic SCL_T";
  attribute X_INTERFACE_INFO of edid_iic_sda_i : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_I";
  attribute X_INTERFACE_INFO of edid_iic_sda_o : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_O";
  attribute X_INTERFACE_INFO of edid_iic_sda_t : signal is "xilinx.com:interface:iic:1.0 edid_iic SDA_T";
  attribute X_INTERFACE_INFO of ext_iic_scl_i : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_I";
  attribute X_INTERFACE_INFO of ext_iic_scl_o : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_O";
  attribute X_INTERFACE_INFO of ext_iic_scl_t : signal is "xilinx.com:interface:iic:1.0 ext_iic SCL_T";
  attribute X_INTERFACE_INFO of ext_iic_sda_i : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_I";
  attribute X_INTERFACE_INFO of ext_iic_sda_o : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_O";
  attribute X_INTERFACE_INFO of ext_iic_sda_t : signal is "xilinx.com:interface:iic:1.0 ext_iic SDA_T";
  attribute X_INTERFACE_INFO of m_aud_axis_aclk : signal is "xilinx.com:signal:clock:1.0 CLK.m_aud_axis_aclk CLK";
  attribute X_INTERFACE_PARAMETER of m_aud_axis_aclk : signal is "XIL_INTERFACENAME CLK.m_aud_axis_aclk, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, ASSOCIATED_BUSIF aud_axi_egress, ASSOCIATED_RESET m_aud_axis_aresetn, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_aud_axis_aresetn : signal is "xilinx.com:signal:reset:1.0 RST.m_aud_axis_aresetn RST";
  attribute X_INTERFACE_PARAMETER of m_aud_axis_aresetn : signal is "XIL_INTERFACENAME RST.m_aud_axis_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_aclk_stream1 : signal is "xilinx.com:signal:clock:1.0 CLK.m_axis_aclk_stream1 CLK";
  attribute X_INTERFACE_PARAMETER of m_axis_aclk_stream1 : signal is "XIL_INTERFACENAME CLK.m_axis_aclk_stream1, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, ASSOCIATED_BUSIF m_axis_video_stream1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TREADY";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TVALID";
  attribute X_INTERFACE_PARAMETER of m_axis_phy_rx_sb_control_tvalid : signal is "XIL_INTERFACENAME m_axis_phy_rx_sb_control, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TLAST";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TREADY";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TVALID";
  attribute X_INTERFACE_PARAMETER of m_axis_video_stream1_tvalid : signal is "XIL_INTERFACENAME m_axis_video_stream1, TDATA_NUM_BYTES 15, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 300000000, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rx_hpd : signal is "xilinx.com:signal:data:1.0 DATA.rx_hpd DATA";
  attribute X_INTERFACE_PARAMETER of rx_hpd : signal is "XIL_INTERFACENAME DATA.rx_hpd, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of rx_lnk_clk : signal is "xilinx.com:signal:clock:1.0 CLK.rx_lnk_clk CLK";
  attribute X_INTERFACE_PARAMETER of rx_lnk_clk : signal is "XIL_INTERFACENAME CLK.rx_lnk_clk, FREQ_HZ 405000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, ASSOCIATED_BUSIF s_axis_lnk_rx_lane0:s_axis_lnk_rx_lane1:s_axis_lnk_rx_lane2:s_axis_lnk_rx_lane3, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rx_vid_clk : signal is "xilinx.com:signal:clock:1.0 CLK.rx_vid_clk CLK";
  attribute X_INTERFACE_PARAMETER of rx_vid_clk : signal is "XIL_INTERFACENAME CLK.rx_vid_clk, FREQ_HZ 300000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN dpss_zcu102_rx_clk_wiz_0_0_clk_out1, ASSOCIATED_RESET rx_vid_rst, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rx_vid_rst : signal is "xilinx.com:signal:reset:1.0 RST.rx_vid_rst RST";
  attribute X_INTERFACE_PARAMETER of rx_vid_rst : signal is "XIL_INTERFACENAME RST.rx_vid_rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 CLK.s_axi_aclk CLK";
  attribute X_INTERFACE_PARAMETER of s_axi_aclk : signal is "XIL_INTERFACENAME CLK.s_axi_aclk, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, ASSOCIATED_BUSIF m_axis_phy_rx_sb_control:s_axi:s_axis_phy_rx_sb_status, ASSOCIATED_RESET s_axi_aresetn, INSERT_VIP 0, ASSOCIATED_CLKEN s_sc_aclken";
  attribute X_INTERFACE_INFO of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 RST.s_axi_aresetn RST";
  attribute X_INTERFACE_PARAMETER of s_axi_aresetn : signal is "XIL_INTERFACENAME RST.s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TVALID";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane0_tvalid : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TVALID";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane1_tvalid : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane1, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TVALID";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane2_tvalid : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane2, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TREADY";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TVALID";
  attribute X_INTERFACE_PARAMETER of s_axis_lnk_rx_lane3_tvalid : signal is "XIL_INTERFACENAME s_axis_lnk_rx_lane3, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 12, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 405000000, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_vid_phy_controller_0_0_rxoutclk, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TREADY";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TVALID";
  attribute X_INTERFACE_PARAMETER of s_axis_phy_rx_sb_status_tvalid : signal is "XIL_INTERFACENAME s_axis_phy_rx_sb_status, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 99999001, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aud_axi_egress_tdata : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TDATA";
  attribute X_INTERFACE_INFO of aud_axi_egress_tid : signal is "xilinx.com:interface:axis:1.0 aud_axi_egress TID";
  attribute X_INTERFACE_INFO of m_axis_phy_rx_sb_control_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_phy_rx_sb_control TDATA";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TDATA";
  attribute X_INTERFACE_INFO of m_axis_video_stream1_tuser : signal is "xilinx.com:interface:axis:1.0 m_axis_video_stream1 TUSER";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 s_axi ARPROT";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_INFO of s_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 s_axi AWPROT";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_rready : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 13, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN dpss_zcu102_rx_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TDATA";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane0_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane0 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TDATA";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane1_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane1 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TDATA";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane2_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane2 TUSER";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TDATA";
  attribute X_INTERFACE_INFO of s_axis_lnk_rx_lane3_tuser : signal is "xilinx.com:interface:axis:1.0 s_axis_lnk_rx_lane3 TUSER";
  attribute X_INTERFACE_INFO of s_axis_phy_rx_sb_status_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_phy_rx_sb_status TDATA";
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bd_6311
     port map (
      acr_m_aud(23 downto 0) => acr_m_aud(23 downto 0),
      acr_n_aud(23 downto 0) => acr_n_aud(23 downto 0),
      acr_valid => acr_valid,
      aud_axi_egress_tdata(31 downto 0) => aud_axi_egress_tdata(31 downto 0),
      aud_axi_egress_tid(7 downto 0) => aud_axi_egress_tid(7 downto 0),
      aud_axi_egress_tready => aud_axi_egress_tready,
      aud_axi_egress_tvalid => aud_axi_egress_tvalid,
      aux_rx_data_en_out_n => aux_rx_data_en_out_n,
      aux_rx_data_in => aux_rx_data_in,
      aux_rx_data_out => aux_rx_data_out,
      dprxss_dp_irq => dprxss_dp_irq,
      dprxss_iic_irq => dprxss_iic_irq,
      edid_iic_scl_i => edid_iic_scl_i,
      edid_iic_scl_o => edid_iic_scl_o,
      edid_iic_scl_t => edid_iic_scl_t,
      edid_iic_sda_i => edid_iic_sda_i,
      edid_iic_sda_o => edid_iic_sda_o,
      edid_iic_sda_t => edid_iic_sda_t,
      ext_iic_scl_i => ext_iic_scl_i,
      ext_iic_scl_o => ext_iic_scl_o,
      ext_iic_scl_t => ext_iic_scl_t,
      ext_iic_sda_i => ext_iic_sda_i,
      ext_iic_sda_o => ext_iic_sda_o,
      ext_iic_sda_t => ext_iic_sda_t,
      ext_rst(0) => ext_rst(0),
      m_aud_axis_aclk => m_aud_axis_aclk,
      m_aud_axis_aresetn => m_aud_axis_aresetn,
      m_axis_aclk_stream1 => m_axis_aclk_stream1,
      m_axis_phy_rx_sb_control_tdata(7 downto 0) => m_axis_phy_rx_sb_control_tdata(7 downto 0),
      m_axis_phy_rx_sb_control_tready => m_axis_phy_rx_sb_control_tready,
      m_axis_phy_rx_sb_control_tvalid => m_axis_phy_rx_sb_control_tvalid,
      m_axis_video_stream1_tdata(119 downto 0) => m_axis_video_stream1_tdata(119 downto 0),
      m_axis_video_stream1_tlast => m_axis_video_stream1_tlast,
      m_axis_video_stream1_tready => m_axis_video_stream1_tready,
      m_axis_video_stream1_tuser(0) => m_axis_video_stream1_tuser(0),
      m_axis_video_stream1_tvalid => m_axis_video_stream1_tvalid,
      rx_hpd => rx_hpd,
      rx_lnk_clk => rx_lnk_clk,
      rx_vid_clk => rx_vid_clk,
      rx_vid_rst => rx_vid_rst,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(12 downto 0) => s_axi_araddr(12 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready(0) => s_axi_arready(0),
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(12 downto 0) => s_axi_awaddr(12 downto 0),
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready(0) => s_axi_awready(0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid(0) => s_axi_wvalid(0),
      s_axis_lnk_rx_lane0_tdata(31 downto 0) => s_axis_lnk_rx_lane0_tdata(31 downto 0),
      s_axis_lnk_rx_lane0_tready => s_axis_lnk_rx_lane0_tready,
      s_axis_lnk_rx_lane0_tuser(11 downto 0) => s_axis_lnk_rx_lane0_tuser(11 downto 0),
      s_axis_lnk_rx_lane0_tvalid => s_axis_lnk_rx_lane0_tvalid,
      s_axis_lnk_rx_lane1_tdata(31 downto 0) => s_axis_lnk_rx_lane1_tdata(31 downto 0),
      s_axis_lnk_rx_lane1_tready => s_axis_lnk_rx_lane1_tready,
      s_axis_lnk_rx_lane1_tuser(11 downto 0) => s_axis_lnk_rx_lane1_tuser(11 downto 0),
      s_axis_lnk_rx_lane1_tvalid => s_axis_lnk_rx_lane1_tvalid,
      s_axis_lnk_rx_lane2_tdata(31 downto 0) => s_axis_lnk_rx_lane2_tdata(31 downto 0),
      s_axis_lnk_rx_lane2_tready => s_axis_lnk_rx_lane2_tready,
      s_axis_lnk_rx_lane2_tuser(11 downto 0) => s_axis_lnk_rx_lane2_tuser(11 downto 0),
      s_axis_lnk_rx_lane2_tvalid => s_axis_lnk_rx_lane2_tvalid,
      s_axis_lnk_rx_lane3_tdata(31 downto 0) => s_axis_lnk_rx_lane3_tdata(31 downto 0),
      s_axis_lnk_rx_lane3_tready => s_axis_lnk_rx_lane3_tready,
      s_axis_lnk_rx_lane3_tuser(11 downto 0) => s_axis_lnk_rx_lane3_tuser(11 downto 0),
      s_axis_lnk_rx_lane3_tvalid => s_axis_lnk_rx_lane3_tvalid,
      s_axis_phy_rx_sb_status_tdata(31 downto 0) => s_axis_phy_rx_sb_status_tdata(31 downto 0),
      s_axis_phy_rx_sb_status_tready => s_axis_phy_rx_sb_status_tready,
      s_axis_phy_rx_sb_status_tvalid => s_axis_phy_rx_sb_status_tvalid
    );
end STRUCTURE;
