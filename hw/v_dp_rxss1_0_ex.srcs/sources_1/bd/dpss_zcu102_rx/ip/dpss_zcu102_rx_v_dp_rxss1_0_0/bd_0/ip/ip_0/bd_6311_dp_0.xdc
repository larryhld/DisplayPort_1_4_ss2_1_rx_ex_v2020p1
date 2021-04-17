# file: bd_6311_dp_0.xdc (IP Level XDC)

#-----------------------------------------------------------------
## Clock Constraints
#-----------------------------------------------------------------

#Ignoring the paths with CDC synchronizer
#set_false_path -to [get_pins -hier *sync_flop_0*/D] 
  set_false_path -to [get_cells -hierarchical  -filter {NAME =~*/i_yonly_mode_reg}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~*/ext_aud_rst_sync_reg[*]}]

set_false_path -from [get_cells -hierarchical  -filter {NAME =~*/aux_data_enable_n_reg}]


#create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-1 -description "symbol error counter used for status" \
#  -from *PIN \
#  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*CE} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_training_inst/i_symbol_error_count*}]]
#create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-1 -description "symbol error counter used for status" \
#  -from *PIN \
#  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_training_inst/i_symbol_error_count*}]]

create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-1 -description "sampling is controlled by FSM. Values will be updated per frame basis. Safe to ignore" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_user_dtg_inst/cfg_rx_vidmode_regs_reg*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*CE} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_interrupt_inst/i_mode_change_interrupt_reg*}]]
create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-1 -description "sampling is controlled by FSM. Values will be updated per frame basis. Safe to ignore" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_user_dtg_inst/cfg_rx_vidmode_regs_reg*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*CE} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_interrupt_inst/FSM_onehot_i_mode_change_interrupt_reg*}]]
create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-1 -description "sampling is controlled by FSM. Values will be updated per frame basis. Safe to ignore" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_framing*_inst/cfg_rx_vidmode_regs_reg*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_user_dtg_inst/i_*_match_event_reg*}]]
create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-4 -description "sampling is controlled by FSM. Values will be updated per frame basis. Safe to ignore" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_framing*_inst/cfg_rx_vidmode_regs_reg*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_user_dtg_inst/i_updated_timing_parameters_reg*}]]
create_waiver -scope -internal -quiet -user displayport_rx -tags 10897 -type CDC -id CDC-11 -description "i_fifo_reset CDC-11 fix" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *rx_main_inst/i_fifo_reset_reg*}]] \
  -to   *PIN  
