-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Apr  7 18:47:28 2021
-- Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_util_reduced_logic_0_0/dpss_zcu102_rx_util_reduced_logic_0_0_sim_netlist.vhdl
-- Design      : dpss_zcu102_rx_util_reduced_logic_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dpss_zcu102_rx_util_reduced_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Res : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of dpss_zcu102_rx_util_reduced_logic_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of dpss_zcu102_rx_util_reduced_logic_0_0 : entity is "dpss_zcu102_rx_util_reduced_logic_0_0,util_reduced_logic_v2_0_4_util_reduced_logic,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of dpss_zcu102_rx_util_reduced_logic_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of dpss_zcu102_rx_util_reduced_logic_0_0 : entity is "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2020.1";
end dpss_zcu102_rx_util_reduced_logic_0_0;

architecture STRUCTURE of dpss_zcu102_rx_util_reduced_logic_0_0 is
begin
Res_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Op1(0),
      I1 => Op1(1),
      O => Res
    );
end STRUCTURE;
