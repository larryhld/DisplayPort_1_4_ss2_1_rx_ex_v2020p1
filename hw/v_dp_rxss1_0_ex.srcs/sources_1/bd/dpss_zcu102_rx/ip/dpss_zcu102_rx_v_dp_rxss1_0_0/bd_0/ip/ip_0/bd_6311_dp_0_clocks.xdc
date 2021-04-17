# file: bd_6311_dp_0_clocks.xdc (IP Level XDC)

#-----------------------------------------------------------------
# cross clock constraints
#-----------------------------------------------------------------

set rd_vid_clock [get_clocks -of_objects [get_pins -hierarchical -filter {name=~*/rx_vid_clk*}]]

set_max_delay -datapath_only 40 -from [ get_clocks -of_objects [get_ports s_axi_aclk] ] -to  $rd_vid_clock  
set_max_delay -datapath_only 40 -from $rd_vid_clock -to  [ get_clocks -of_objects [get_ports s_axi_aclk] ] 
 
  set wr_lnk_clock [get_clocks -of_objects [get_ports rx_lnk_clk] ]
  set_max_delay -datapath_only 25 -from [ get_clocks -of_objects [get_ports s_axi_aclk] ] -to   [get_clocks -of_objects [get_ports rx_lnk_clk]  ]
  set_max_delay -datapath_only 25 -from [get_clocks -of_objects [get_ports rx_lnk_clk] ] -to [ get_clocks -of_objects [get_ports s_axi_aclk] ]    

set start_point [get_pins -of [get_cells -hierarchical -filter {NAME =~*/cfg_rx_vidmode_regs_reg*}] -filter {REF_PIN_NAME == C}]
set_max_delay -from $start_point -to [get_pins -of [get_cells -hierarchical -filter {NAME =~*/i_updated_timing_parameters_reg*}] -filter {REF_PIN_NAME == D}] -datapath_only 25
set_max_delay -from $start_point -to [get_pins -of [get_cells -hierarchical -filter {NAME =~*/i_*_match_event_reg*}] -filter {REF_PIN_NAME == D}] -datapath_only 25





