connect -url tcp:127.0.0.1:3121
source C:/Xilinx/Vitis/2020.1/scripts/vitis/util/zynqmp_utils.tcl
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-SMT2NC 210308ABAAAA" && level==0 && jtag_device_ctx=="jsn-JTAG-SMT2NC-210308ABAAAA-24738093-0"}
fpga -file C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/sw/xdprxss_dp14_rx_1/_ide/bitstream/dpss_zcu102_rx_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/sw/zcu102_rxo/export/zcu102_rxo/hw/dpss_zcu102_rx_wrapper.xsa -mem-ranges [list {0x80000000 0xbfffffff} {0x400000000 0x5ffffffff} {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
set mode [expr [mrd -value 0xFF5E0200] & 0xf]
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/sw/zcu102_rxo/export/zcu102_rxo/sw/zcu102_rxo/boot/fsbl.elf
set bp_42_58_fsbl_bp [bpadd -addr &XFsbl_Exit]
con -block -timeout 60
bpremove $bp_42_58_fsbl_bp
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/sw/xdprxss_dp14_rx_1/Debug/xdprxss_dp14_rx_1.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A53*#0"}
con
