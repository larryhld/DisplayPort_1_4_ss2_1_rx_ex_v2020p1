
# This constraints file contains default clock frequencies to be used during out-of-context flows such as
# OOC Synthesis and Hierarchical Designs. For best results the frequencies should be modified
# to match the target frequencies. 
# This constraints file is not used in normal top-down synthesis (the default flow of Vivado)

create_clock -name pixel_clk -period 6.6 [get_ports vid_pixel_clk] 
create_clock -name axis_clk -period 5.0 [get_ports m_axis_aclk] 
