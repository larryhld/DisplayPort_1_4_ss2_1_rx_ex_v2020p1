-- (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:rs_decoder:9.0
-- IP Revision: 17

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY rs_decoder_v9_0_17;
USE rs_decoder_v9_0_17.rs_decoder_v9_0_17;

ENTITY bd_6311_dp_0_rs_decoder_v9_0_17_viv IS
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_input_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_input_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_input_tvalid : IN STD_LOGIC;
    s_axis_input_tlast : IN STD_LOGIC;
    s_axis_input_tready : OUT STD_LOGIC;
    m_axis_output_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_output_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_output_tvalid : OUT STD_LOGIC;
    m_axis_output_tready : IN STD_LOGIC;
    m_axis_output_tlast : OUT STD_LOGIC;
    m_axis_stat_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_stat_tvalid : OUT STD_LOGIC;
    m_axis_stat_tlast : OUT STD_LOGIC;
    m_axis_stat_tready : IN STD_LOGIC;
    event_s_input_tlast_missing : OUT STD_LOGIC;
    event_s_input_tlast_unexpected : OUT STD_LOGIC;
    event_s_ctrl_tdata_invalid : OUT STD_LOGIC
  );
END bd_6311_dp_0_rs_decoder_v9_0_17_viv;

ARCHITECTURE bd_6311_dp_0_rs_decoder_v9_0_17_viv_arch OF bd_6311_dp_0_rs_decoder_v9_0_17_viv IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF bd_6311_dp_0_rs_decoder_v9_0_17_viv_arch: ARCHITECTURE IS "yes";
  COMPONENT rs_decoder_v9_0_17 IS
    GENERIC (
      C_HAS_ACLKEN : INTEGER;
      C_HAS_ARESETN : INTEGER;
      C_HAS_S_AXIS_CTRL : INTEGER;
      C_HAS_S_AXIS_INPUT_TUSER : INTEGER;
      C_HAS_M_AXIS_OUTPUT_TUSER : INTEGER;
      C_S_AXIS_INPUT_TDATA_WIDTH : INTEGER;
      C_S_AXIS_INPUT_TUSER_WIDTH : INTEGER;
      C_S_AXIS_CTRL_TDATA_WIDTH : INTEGER;
      C_M_AXIS_OUTPUT_TDATA_WIDTH : INTEGER;
      C_M_AXIS_OUTPUT_TUSER_WIDTH : INTEGER;
      C_M_AXIS_STAT_TDATA_WIDTH : INTEGER;
      C_HAS_DATA_DEL : INTEGER;
      C_HAS_ERASE : INTEGER;
      C_HAS_ERR_STATS : INTEGER;
      C_HAS_INFO : INTEGER;
      C_HAS_N_IN : INTEGER;
      C_HAS_R_IN : INTEGER;
      C_GEN_START : INTEGER;
      C_H : INTEGER;
      C_K : INTEGER;
      C_N : INTEGER;
      C_POLYNOMIAL : INTEGER;
      C_SPEC : INTEGER;
      C_SYMBOL_WIDTH : INTEGER;
      C_IGNORE_ILLEGAL_N_R : INTEGER;
      C_DEFINE_LEGAL_R_VALS : INTEGER;
      C_NUM_LEGAL_R_VALUES : INTEGER;
      C_LEGAL_R_VECTOR_FILE : STRING;
      C_NUM_CHANNELS : INTEGER;
      C_NUM_PUNC_PATTERNS : INTEGER;
      C_PUNCTURE_SELECT_FILE : STRING;
      C_PUNCTURE_VECTOR_FILE : STRING;
      C_MEMSTYLE : INTEGER;
      C_OUTPUT_CHECK_SYMBOLS : INTEGER;
      C_OPTIMISATION : INTEGER;
      C_SELF_RECOVERING : INTEGER;
      C_MEM_INIT_PREFIX : STRING;
      C_ELABORATION_DIR : STRING;
      C_XDEVICEFAMILY : STRING;
      C_FAMILY : STRING
    );
    PORT (
      aclk : IN STD_LOGIC;
      aclken : IN STD_LOGIC;
      aresetn : IN STD_LOGIC;
      s_axis_input_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s_axis_input_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      s_axis_input_tvalid : IN STD_LOGIC;
      s_axis_input_tlast : IN STD_LOGIC;
      s_axis_input_tready : OUT STD_LOGIC;
      s_axis_ctrl_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s_axis_ctrl_tvalid : IN STD_LOGIC;
      s_axis_ctrl_tready : OUT STD_LOGIC;
      m_axis_output_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m_axis_output_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      m_axis_output_tvalid : OUT STD_LOGIC;
      m_axis_output_tready : IN STD_LOGIC;
      m_axis_output_tlast : OUT STD_LOGIC;
      m_axis_stat_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m_axis_stat_tvalid : OUT STD_LOGIC;
      m_axis_stat_tlast : OUT STD_LOGIC;
      m_axis_stat_tready : IN STD_LOGIC;
      event_s_input_tlast_missing : OUT STD_LOGIC;
      event_s_input_tlast_unexpected : OUT STD_LOGIC;
      event_s_ctrl_tdata_invalid : OUT STD_LOGIC
    );
  END COMPONENT rs_decoder_v9_0_17;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF event_s_ctrl_tdata_invalid: SIGNAL IS "XIL_INTERFACENAME event_s_ctrl_tdata_invalid_intf, SENSITIVITY EDGE_RISING, PortWidth 1";
  ATTRIBUTE X_INTERFACE_INFO OF event_s_ctrl_tdata_invalid: SIGNAL IS "xilinx.com:signal:interrupt:1.0 event_s_ctrl_tdata_invalid_intf INTERRUPT";
  ATTRIBUTE X_INTERFACE_PARAMETER OF event_s_input_tlast_unexpected: SIGNAL IS "XIL_INTERFACENAME event_s_input_tlast_unexpected_intf, SENSITIVITY EDGE_RISING, PortWidth 1";
  ATTRIBUTE X_INTERFACE_INFO OF event_s_input_tlast_unexpected: SIGNAL IS "xilinx.com:signal:interrupt:1.0 event_s_input_tlast_unexpected_intf INTERRUPT";
  ATTRIBUTE X_INTERFACE_PARAMETER OF event_s_input_tlast_missing: SIGNAL IS "XIL_INTERFACENAME event_s_input_tlast_missing_intf, SENSITIVITY EDGE_RISING, PortWidth 1";
  ATTRIBUTE X_INTERFACE_INFO OF event_s_input_tlast_missing: SIGNAL IS "xilinx.com:signal:interrupt:1.0 event_s_input_tlast_missing_intf INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_stat_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_STAT TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_stat_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_STAT TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_stat_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_STAT TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_axis_stat_tdata: SIGNAL IS "XIL_INTERFACENAME M_AXIS_STAT, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_stat_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_STAT TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_output_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_OUTPUT TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_output_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_OUTPUT TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_output_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_OUTPUT TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_output_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_OUTPUT TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_axis_output_tdata: SIGNAL IS "XIL_INTERFACENAME M_AXIS_OUTPUT, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_output_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 M_AXIS_OUTPUT TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_input_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 S_AXIS_INPUT TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_input_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 S_AXIS_INPUT TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_input_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 S_AXIS_INPUT TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_input_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 S_AXIS_INPUT TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axis_input_tdata: SIGNAL IS "XIL_INTERFACENAME S_AXIS_INPUT, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_input_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 S_AXIS_INPUT TDATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF aresetn: SIGNAL IS "XIL_INTERFACENAME aresetn_intf, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 aresetn_intf RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF aclken: SIGNAL IS "XIL_INTERFACENAME aclken_intf, POLARITY ACTIVE_HIGH";
  ATTRIBUTE X_INTERFACE_INFO OF aclken: SIGNAL IS "xilinx.com:signal:clockenable:1.0 aclken_intf CE";
  ATTRIBUTE X_INTERFACE_PARAMETER OF aclk: SIGNAL IS "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_STAT:M_AXIS_OUTPUT:S_AXIS_CTRL:S_AXIS_INPUT, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 aclk_intf CLK";
BEGIN
  U0 : rs_decoder_v9_0_17
    GENERIC MAP (
      C_HAS_ACLKEN => 1,
      C_HAS_ARESETN => 1,
      C_HAS_S_AXIS_CTRL => 0,
      C_HAS_S_AXIS_INPUT_TUSER => 1,
      C_HAS_M_AXIS_OUTPUT_TUSER => 1,
      C_S_AXIS_INPUT_TDATA_WIDTH => 8,
      C_S_AXIS_INPUT_TUSER_WIDTH => 1,
      C_S_AXIS_CTRL_TDATA_WIDTH => 8,
      C_M_AXIS_OUTPUT_TDATA_WIDTH => 16,
      C_M_AXIS_OUTPUT_TUSER_WIDTH => 1,
      C_M_AXIS_STAT_TDATA_WIDTH => 16,
      C_HAS_DATA_DEL => 1,
      C_HAS_ERASE => 0,
      C_HAS_ERR_STATS => 1,
      C_HAS_INFO => 0,
      C_HAS_N_IN => 0,
      C_HAS_R_IN => 0,
      C_GEN_START => 0,
      C_H => 1,
      C_K => 13,
      C_N => 15,
      C_POLYNOMIAL => 19,
      C_SPEC => 0,
      C_SYMBOL_WIDTH => 4,
      C_IGNORE_ILLEGAL_N_R => 1,
      C_DEFINE_LEGAL_R_VALS => 0,
      C_NUM_LEGAL_R_VALUES => 2,
      C_LEGAL_R_VECTOR_FILE => "no_coe_file_loaded",
      C_NUM_CHANNELS => 4,
      C_NUM_PUNC_PATTERNS => 0,
      C_PUNCTURE_SELECT_FILE => "no_coe_file_loaded",
      C_PUNCTURE_VECTOR_FILE => "no_coe_file_loaded",
      C_MEMSTYLE => 2,
      C_OUTPUT_CHECK_SYMBOLS => 1,
      C_OPTIMISATION => 1,
      C_SELF_RECOVERING => 0,
      C_MEM_INIT_PREFIX => "bd_6311_dp_0_rs_decoder_v9_0_17_viv",
      C_ELABORATION_DIR => "./",
      C_XDEVICEFAMILY => "zynquplus",
      C_FAMILY => "zynquplus"
    )
    PORT MAP (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      s_axis_input_tdata => s_axis_input_tdata,
      s_axis_input_tuser => s_axis_input_tuser,
      s_axis_input_tvalid => s_axis_input_tvalid,
      s_axis_input_tlast => s_axis_input_tlast,
      s_axis_input_tready => s_axis_input_tready,
      s_axis_ctrl_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(1, 8)),
      s_axis_ctrl_tvalid => '0',
      m_axis_output_tdata => m_axis_output_tdata,
      m_axis_output_tuser => m_axis_output_tuser,
      m_axis_output_tvalid => m_axis_output_tvalid,
      m_axis_output_tready => m_axis_output_tready,
      m_axis_output_tlast => m_axis_output_tlast,
      m_axis_stat_tdata => m_axis_stat_tdata,
      m_axis_stat_tvalid => m_axis_stat_tvalid,
      m_axis_stat_tlast => m_axis_stat_tlast,
      m_axis_stat_tready => m_axis_stat_tready,
      event_s_input_tlast_missing => event_s_input_tlast_missing,
      event_s_input_tlast_unexpected => event_s_input_tlast_unexpected,
      event_s_ctrl_tdata_invalid => event_s_ctrl_tdata_invalid
    );
END bd_6311_dp_0_rs_decoder_v9_0_17_viv_arch;
