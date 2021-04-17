#------------------------------------------------------------------------------
#  (c) Copyright 2013-2018 Xilinx, Inc. All rights reserved.
#
#  This file contains confidential and proprietary information
#  of Xilinx, Inc. and is protected under U.S. and
#  international copyright and other intellectual property
#  laws.
#
#  DISCLAIMER
#  This disclaimer is not a license and does not grant any
#  rights to the materials distributed herewith. Except as
#  otherwise provided in a valid license issued to you by
#  Xilinx, and to the maximum extent permitted by applicable
#  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#  (2) Xilinx shall not be liable (whether in contract or tort,
#  including negligence, or under any other theory of
#  liability) for any loss or damage of any kind or nature
#  related to, arising under or in connection with these
#  materials, including for any direct, or any indirect,
#  special, incidental, or consequential loss or damage
#  (including loss of data, profits, goodwill, or any type of
#  loss or damage suffered as a result of any action brought
#  by a third party) even if such damage or loss was
#  reasonably foreseeable or Xilinx had been advised of the
#  possibility of the same.
#
#  CRITICAL APPLICATIONS
#  Xilinx products are not designed or intended to be fail-
#  safe, or for use in any application requiring fail-safe
#  performance, such as life-support or safety devices or
#  systems, Class III medical devices, nuclear facilities,
#  applications related to the deployment of airbags, or any
#  other applications that could lead to death, personal
#  injury, or severe property or environmental damage
#  (individually and collectively, "Critical
#  Applications"). Customer assumes the sole risk and
#  liability of any use of Xilinx products in Critical
#  Applications, subject only to applicable laws and
#  regulations governing limitations on product liability.
#
#  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#  PART OF THIS FILE AT ALL TIMES.
#------------------------------------------------------------------------------


# UltraScale FPGAs Transceivers Wizard IP core-level XDC file
# ----------------------------------------------------------------------------------------------------------------------

# Commands for enabled transceiver GTHE4_CHANNEL_X1Y8
# ----------------------------------------------------------------------------------------------------------------------

# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime TXOUTCLK source
# selection since the CPLL calibration block controls the TXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]
# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime RXOUTCLK source
# selection since the CPLL calibration block controls the RXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]]

# Channel primitive location constraint
set_property LOC GTHE4_CHANNEL_X1Y8 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]

# Channel primitive serial data pin location constraints
# (Provided as comments for your reference. The channel primitive location constraint is sufficient.)
#set_property package_pin K1 [get_ports gthrxn_in[0]]
#set_property package_pin K2 [get_ports gthrxp_in[0]]
#set_property package_pin K5 [get_ports gthtxn_out[0]]
#set_property package_pin K6 [get_ports gthtxp_out[0]]
# CPLL calibration block constraints
create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*bufg_gt_txoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_TXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*bufg_gt_rxoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[0].*U_RXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

##set_false_path -through [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[0].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet
set_case_analysis 1     [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[0].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet

# Commands for enabled transceiver GTHE4_CHANNEL_X1Y9
# ----------------------------------------------------------------------------------------------------------------------

# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime TXOUTCLK source
# selection since the CPLL calibration block controls the TXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]
# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime RXOUTCLK source
# selection since the CPLL calibration block controls the RXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]]

# Channel primitive location constraint
set_property LOC GTHE4_CHANNEL_X1Y9 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]

# Channel primitive serial data pin location constraints
# (Provided as comments for your reference. The channel primitive location constraint is sufficient.)
#set_property package_pin J3 [get_ports gthrxn_in[1]]
#set_property package_pin J4 [get_ports gthrxp_in[1]]
#set_property package_pin H5 [get_ports gthtxn_out[1]]
#set_property package_pin H6 [get_ports gthtxp_out[1]]
# CPLL calibration block constraints
create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*bufg_gt_txoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_TXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*bufg_gt_rxoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[1].*U_RXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

##set_false_path -through [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[1].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet
set_case_analysis 1     [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[1].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet

# Commands for enabled transceiver GTHE4_CHANNEL_X1Y10
# ----------------------------------------------------------------------------------------------------------------------

# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime TXOUTCLK source
# selection since the CPLL calibration block controls the TXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]
# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime RXOUTCLK source
# selection since the CPLL calibration block controls the RXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]]

# Channel primitive location constraint
set_property LOC GTHE4_CHANNEL_X1Y10 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]

# Channel primitive serial data pin location constraints
# (Provided as comments for your reference. The channel primitive location constraint is sufficient.)
#set_property package_pin H1 [get_ports gthrxn_in[2]]
#set_property package_pin H2 [get_ports gthrxp_in[2]]
#set_property package_pin G3 [get_ports gthtxn_out[2]]
#set_property package_pin G4 [get_ports gthtxp_out[2]]
# CPLL calibration block constraints
create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*bufg_gt_txoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_TXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*bufg_gt_rxoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[2].*U_RXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

##set_false_path -through [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[2].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet
set_case_analysis 1     [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[2].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet

# Commands for enabled transceiver GTHE4_CHANNEL_X1Y11
# ----------------------------------------------------------------------------------------------------------------------

# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime TXOUTCLK source
# selection since the CPLL calibration block controls the TXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*TXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]
# Set case analysis constraint, used in this configuration to limit timing analysis to the known runtime RXOUTCLK source
# selection since the CPLL calibration block controls the RXOUTCLKSEL port dynamically
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[2]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 1 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[1]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]
set_case_analysis 0 [get_pins -filter {REF_PIN_NAME=~*RXOUTCLKSEL[0]} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]]

# Channel primitive location constraint
set_property LOC GTHE4_CHANNEL_X1Y11 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]

# Channel primitive serial data pin location constraints
# (Provided as comments for your reference. The channel primitive location constraint is sufficient.)
#set_property package_pin F1 [get_ports gthrxn_in[3]]
#set_property package_pin F2 [get_ports gthrxp_in[3]]
#set_property package_pin F5 [get_ports gthtxn_out[3]]
#set_property package_pin F6 [get_ports gthtxp_out[3]]
# CPLL calibration block constraints
create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*bufg_gt_txoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_TXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

create_clock -period 6.172 [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*bufg_gt_rxoutclkmon_inst}]]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/testclk_cnt_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/freq_cnt_o_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg*}] -quiet
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/state_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[3].*U_RXOUTCLK_FREQ_COUNTER/testclk_en_dly1_reg*}] -quiet

##set_false_path -through [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[3].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet
set_case_analysis 1     [get_pins -filter {REF_PIN_NAME=~*Q} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_pwrgood_delay_inst[3].delay_powergood_inst/gen_powergood_delay.pwr_on_fsm*}]] -quiet

create_waiver -internal -quiet -user gtwizard_ultrascale -tags 1025417 -type METHODOLOGY -id TIMING-3 -description "added waiver for CPLL CAL local BUFG_GT usecase"  -scope \
  -objects [get_pins -filter {REF_PIN_NAME=~*O} -of_objects [get_cells -hierarchical -filter {NAME =~ *gen_cpll_cal_inst[*].*bufg_gt_*xoutclkmon_inst}]]

# False path constraints
# ----------------------------------------------------------------------------------------------------------------------

set_false_path -to [get_cells -hierarchical -filter {NAME =~ *bit_synchronizer*inst/i_in_meta_reg}] -quiet

##set_false_path -to [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_*_reg}] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_meta*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_meta*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync1*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync2*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync3*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_out*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_meta*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync1*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync2*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync3*}]] -quiet
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*CLR} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_out*}]] -quiet

