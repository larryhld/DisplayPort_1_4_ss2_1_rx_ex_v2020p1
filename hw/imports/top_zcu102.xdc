
##-----ZCU102-----##

## Refclk
set_property PACKAGE_PIN G7 [get_ports {IBUF_DS_N[0]}]
set_property PACKAGE_PIN G8 [get_ports {IBUF_DS_P[0]}]
#create_clock -period 3.703 -name IBUF_DS_P [get_ports IBUF_DS_P]

set_property PACKAGE_PIN L7 [get_ports {IBUF_DS_N1[0]}]
set_property PACKAGE_PIN L8 [get_ports {IBUF_DS_P1[0]}]
#create_clock -period 3.703 -name IBUF_DS_P1 [get_ports IBUF_DS_P1]

#AUX RX
set_property PACKAGE_PIN L12 [get_ports {rx_hpd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_hpd[0]}]
#set_property PULLDOWN true [get_ports rx_hpd]

set_property IOSTANDARD LVCMOS18 [get_ports {aux_rx_data_en_out_n_0[0]}]
set_property PACKAGE_PIN K12 [get_ports {aux_rx_data_en_out_n_0[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports aux_rx_data_out_0]
set_property PACKAGE_PIN M11 [get_ports aux_rx_data_out_0]

set_property IOSTANDARD LVCMOS18 [get_ports aux_rx_data_in_0]
set_property PACKAGE_PIN L11 [get_ports aux_rx_data_in_0]

#set_property IOSTANDARD LVDS [get_ports aux_rx_io_n]
#set_property IOSTANDARD LVDS [get_ports aux_rx_io_p]
#set_property PACKAGE_PIN AC6 [get_ports aux_rx_io_n]

#set_property PACKAGE_PIN K20 [get_ports ext_iic_scl_io]
#set_property IOSTANDARD LVCMOS18 [get_ports ext_iic_scl_io]
#set_property PACKAGE_PIN L20 [get_ports ext_iic_sda_io]
#set_property IOSTANDARD LVCMOS18 [get_ports ext_iic_sda_io]

set_min_delay -from [get_pins -filter {REF_PIN_NAME=~ C} -of_objects [get_cells -hierarchical -filter {NAME=~ */drp_control_b0gtcommon_inst/DRPADDR_reg[*]}]] -to [get_pins -filter {REF_PIN_NAME=~ DRPADDR[*]} -of_objects [get_cells -hierarchical -filter {name=~*GTHE4_COMMON_PRIM_INST}]] 0.300
set_min_delay -from [get_pins -filter {REF_PIN_NAME=~ C} -of_objects [get_cells -hierarchical -filter {NAME=~ */drp_control_b0gtcommon_inst/DRPDI_reg[*]}]] -to [get_pins -filter {REF_PIN_NAME=~ DRPDI[*]} -of_objects [get_cells -hierarchical -filter {name=~*GTHE4_COMMON_PRIM_INST}]] 0.300
set_min_delay -from [get_pins -filter {REF_PIN_NAME=~ C} -of_objects [get_cells -hierarchical -filter {NAME=~ */drp_control_b0gtcommon_inst/DRPEN_reg}]] -to [get_pins -filter {REF_PIN_NAME=~ DRPEN} -of_objects [get_cells -hierarchical -filter {name=~*GTHE4_COMMON_PRIM_INST}]] 0.300
set_min_delay -from [get_pins -filter {REF_PIN_NAME=~ C} -of_objects [get_cells -hierarchical -filter {NAME=~ */drp_control_b0gtcommon_inst/DRPWE_reg}]] -to [get_pins -filter {REF_PIN_NAME=~ DRPWE} -of_objects [get_cells -hierarchical -filter {name=~*GTHE4_COMMON_PRIM_INST}]] 0.300

# GT setting over write. This xdc file has to be read at very last.
#set_property LOC GTHE4_CHANNEL_X1Y8 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]
#set_property LOC GTHE4_CHANNEL_X1Y9 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]
#set_property LOC GTHE4_CHANNEL_X1Y10 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
#set_property LOC GTHE4_CHANNEL_X1Y11 [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]
set_property LOC "" [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
set_property LOC "" [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[1].GTHE4_CHANNEL_PRIM_INST}]
set_property LOC "" [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[2].GTHE4_CHANNEL_PRIM_INST}]
set_property LOC "" [get_cells -hierarchical -filter {NAME =~ *gen_channel_container[26].*gen_gthe4_channel_inst[3].GTHE4_CHANNEL_PRIM_INST}]


## DP RX pins
set_property PACKAGE_PIN H1 [get_ports {phy_rxn_in[0]}]
set_property PACKAGE_PIN H2 [get_ports {phy_rxp_in[0]}]
set_property PACKAGE_PIN J3 [get_ports {phy_rxn_in[1]}]
set_property PACKAGE_PIN J4 [get_ports {phy_rxp_in[1]}]
set_property PACKAGE_PIN F1 [get_ports {phy_rxn_in[2]}]
set_property PACKAGE_PIN F2 [get_ports {phy_rxp_in[2]}]
set_property PACKAGE_PIN K1 [get_ports {phy_rxn_in[3]}]
set_property PACKAGE_PIN K2 [get_ports {phy_rxp_in[3]}]

# Misc
#set_property PACKAGE_PIN M14 [get_ports {B_SOURCE_AUX_DE[0]}]
set_property PACKAGE_PIN AC1 [get_ports {B_SOURCE_AUX_DE[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {B_SOURCE_AUX_DE[0]}]

#set_property IOSTANDARD LVCMOS18 [get_ports {B_SOURCE_EN[0]}]
#set_property PACKAGE_PIN V3 [get_ports {B_SOURCE_EN[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports {B_SOURCE_RST[0]}]
#set_property PACKAGE_PIN V4 [get_ports {B_SOURCE_RST[0]}]
set_property PACKAGE_PIN U8 [get_ports {B_SOURCE_RST[0]}]

set_property PACKAGE_PIN W5 [get_ports {pwd[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {pwd[0]}]
set_property PACKAGE_PIN K20 [get_ports i2c_scl]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_scl]
set_property PACKAGE_PIN L20 [get_ports i2c_sda]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_sda]


set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
