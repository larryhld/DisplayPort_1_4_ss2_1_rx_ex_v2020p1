################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name s_axi_aclk -period 10 [get_ports s_axi_aclk]
create_clock -name rx_vid_clk -period 3.333 [get_ports rx_vid_clk]
create_clock -name m_axis_aclk_stream1 -period 3.333 [get_ports m_axis_aclk_stream1]
create_clock -name rx_lnk_clk -period 2.469 [get_ports rx_lnk_clk]
create_clock -name m_aud_axis_aclk -period 10 [get_ports m_aud_axis_aclk]

################################################################################