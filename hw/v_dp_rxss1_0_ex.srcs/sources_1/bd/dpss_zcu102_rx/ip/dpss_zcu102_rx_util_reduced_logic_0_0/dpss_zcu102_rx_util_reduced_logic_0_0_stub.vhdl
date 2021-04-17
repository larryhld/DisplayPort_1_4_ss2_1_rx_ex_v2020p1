-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Apr  7 18:47:28 2021
-- Host        : DESKTOP-LB2DFM9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_util_reduced_logic_0_0/dpss_zcu102_rx_util_reduced_logic_0_0_stub.vhdl
-- Design      : dpss_zcu102_rx_util_reduced_logic_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dpss_zcu102_rx_util_reduced_logic_0_0 is
  Port ( 
    Op1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Res : out STD_LOGIC
  );

end dpss_zcu102_rx_util_reduced_logic_0_0;

architecture stub of dpss_zcu102_rx_util_reduced_logic_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "Op1[1:0],Res";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2020.1";
begin
end;
