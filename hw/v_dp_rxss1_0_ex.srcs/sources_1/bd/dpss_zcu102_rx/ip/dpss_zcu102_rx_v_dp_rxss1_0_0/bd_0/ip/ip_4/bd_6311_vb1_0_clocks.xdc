
#set_false_path -through [get_ports vid_reset] -to [get_pins -hierarchical  -filter {NAME =~*/inst/*rstblk*/*PRE}]
#set_false_path -through [get_ports vid_reset] -to [get_pins -filter {REF_PIN_NAME=~PRE*} -of_objects [get_cells -hierarchical -filter {NAME=~*rstblk*}]]
#set_false_path -from [get_cells -hierarchical  -filter {NAME =~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.wr_rst_reg_reg[*]}]
#set_false_path -from [get_cells -hierarchical  -filter {NAME =~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.rd_rst_reg_reg[*]}]
#set_false_path -from [get_cells -hierarchical  -filter {NAME =~*rstblk*/*rst_reg_reg[*]}]

set wr_clock [get_clocks -of_objects [get_ports vid_pixel_clk]]
set rd_clock [get_clocks -of_objects [get_ports m_axis_aclk]]

# Ignore paths from the write clock to the read data registers for Distributed RAM based FIFO
# Commented as converted the fifo to BRAM
#set_false_path -from [filter [all_fanout -from [get_ports vid_pixel_clk] -flat -endpoints_only] {IS_LEAF}] -to [get_cells -hierarchical -filter {name=~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm/gpr1.dout_i_reg[*]}]


# This example is using the Set Max Delay constrains for the cross clock domain pointers for AXI4-Stream FIFO

#set_max_delay -from [get_cells -hierarchical -filter {NAME =~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]}] -to [get_cells -hierarchical -filter {NAME =~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[*].wr_stg_inst/Q_reg_reg[*]}] -datapath_only [get_property -min PERIOD $rd_clock]

#set_max_delay -from [get_cells -hierarchical -filter {NAME =~*inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]}] -to [get_cells -hierarchical -filter {NAME =~*/inst/inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[*].rd_stg_inst/Q_reg_reg[*]}] -datapath_only [get_property -min PERIOD $wr_clock]


