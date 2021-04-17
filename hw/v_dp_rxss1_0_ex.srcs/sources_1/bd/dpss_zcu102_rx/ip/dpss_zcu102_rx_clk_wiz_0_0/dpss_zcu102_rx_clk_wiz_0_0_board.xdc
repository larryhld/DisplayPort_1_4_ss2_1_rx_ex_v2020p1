#--------------------Physical Constraints-----------------

set_property BOARD_PIN {user_si570_sysclk_p} [get_ports clk_in1_p]
set_property BOARD_PIN {user_si570_sysclk_n} [get_ports clk_in1_n]
set_property BOARD_PIN {CPU_RESET} [get_ports reset]
