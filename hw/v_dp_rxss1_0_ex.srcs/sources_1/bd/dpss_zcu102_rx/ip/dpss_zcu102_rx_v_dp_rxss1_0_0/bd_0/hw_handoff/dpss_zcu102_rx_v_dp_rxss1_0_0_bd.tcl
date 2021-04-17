
################################################################
# This is a generated script based on design: bd_6311
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source bd_6311_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.3 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name bd_6311

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design -bdsource SBD $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set aud_axi_egress [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 aud_axi_egress ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   ] $aud_axi_egress

  set edid_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 edid_iic ]

  set ext_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ext_iic ]

  set m_axis_phy_rx_sb_control [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_phy_rx_sb_control ]

  set m_axis_video_stream1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_video_stream1 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {0} \
   ] $m_axis_video_stream1

  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {13} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.NUM_READ_OUTSTANDING {8} \
   CONFIG.NUM_WRITE_OUTSTANDING {8} \
   CONFIG.PROTOCOL {AXI4LITE} \
   ] $s_axi

  set s_axis_lnk_rx_lane0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_lnk_rx_lane0 ]

  set s_axis_lnk_rx_lane1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_lnk_rx_lane1 ]

  set s_axis_lnk_rx_lane2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_lnk_rx_lane2 ]

  set s_axis_lnk_rx_lane3 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_lnk_rx_lane3 ]

  set s_axis_phy_rx_sb_status [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_phy_rx_sb_status ]


  # Create ports
  set acr_m_aud [ create_bd_port -dir O -from 23 -to 0 acr_m_aud ]
  set acr_n_aud [ create_bd_port -dir O -from 23 -to 0 acr_n_aud ]
  set acr_valid [ create_bd_port -dir O -type data acr_valid ]
  set aux_rx_data_en_out_n [ create_bd_port -dir O aux_rx_data_en_out_n ]
  set aux_rx_data_in [ create_bd_port -dir I aux_rx_data_in ]
  set aux_rx_data_out [ create_bd_port -dir O aux_rx_data_out ]
  set dprxss_dp_irq [ create_bd_port -dir O -type intr dprxss_dp_irq ]
  set dprxss_iic_irq [ create_bd_port -dir O -type intr dprxss_iic_irq ]
  set ext_rst [ create_bd_port -dir O -from 0 -to 0 ext_rst ]
  set m_aud_axis_aclk [ create_bd_port -dir I -type clk m_aud_axis_aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {aud_axi_egress} \
   CONFIG.ASSOCIATED_RESET {m_aud_axis_aresetn} \
 ] $m_aud_axis_aclk
  set m_aud_axis_aresetn [ create_bd_port -dir I -type rst m_aud_axis_aresetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $m_aud_axis_aresetn
  set m_axis_aclk_stream1 [ create_bd_port -dir I -type clk m_axis_aclk_stream1 ]
  set rx_hpd [ create_bd_port -dir O -type data rx_hpd ]
  set rx_lnk_clk [ create_bd_port -dir I -type clk rx_lnk_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {s_axis_lnk_rx_lane0:s_axis_lnk_rx_lane1:s_axis_lnk_rx_lane2:s_axis_lnk_rx_lane3} \
 ] $rx_lnk_clk
  set rx_vid_clk [ create_bd_port -dir I -type clk rx_vid_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {rx_vid_rst} \
 ] $rx_vid_clk
  set rx_vid_rst [ create_bd_port -dir I -type rst rx_vid_rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $rx_vid_rst
  set s_axi_aclk [ create_bd_port -dir I -type clk s_axi_aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {m_axis_phy_rx_sb_control:s_axi:s_axis_phy_rx_sb_status} \
   CONFIG.ASSOCIATED_RESET {s_axi_aresetn} \
 ] $s_axi_aclk
  set s_axi_aresetn [ create_bd_port -dir I -type rst s_axi_aresetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $s_axi_aresetn

  # Create instance: dp, and set properties
  set dp [ create_bd_cell -type ip -vlnv xilinx.com:ip:displayport:8.1 dp ]
  set_property -dict [ list \
   CONFIG.C_VERSAL {false} \
   CONFIG.Data_flow_direction {Receive_Sink_Core} \
   CONFIG.Dual_Pixel_Enable {false} \
   CONFIG.Enable_HDCP22_Encryption_Hooks {false} \
   CONFIG.Enable_HDCP_Encryption_Hooks {false} \
   CONFIG.Enable_of_Audio_Channels {true} \
   CONFIG.GT_Data_Width {2} \
   CONFIG.Link_Rate {8.1} \
   CONFIG.MST_Enable {false} \
   CONFIG.Max_Bits_Per_Color {10} \
   CONFIG.Number_of_Audio_Channels {2} \
   CONFIG.Number_of_Lanes {4} \
   CONFIG.PHY_type_External {External_phy} \
   CONFIG.Protocol_Selection {DP_1_3} \
   CONFIG.Quad_Pixel_Enable {true} \
   CONFIG.SIM_Mode {false} \
   CONFIG.SS_Mode {true} \
   CONFIG.SupportLevel {0} \
   CONFIG.YCRCB_Enable {true} \
   CONFIG.YOnly_Enable {true} \
   CONFIG.aux_io_loc {1} \
   CONFIG.aux_io_type {0} \
   CONFIG.eDP_Enable {false} \
 ] $dp

  # Create instance: iic, and set properties
  set iic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 iic ]
  set_property -dict [ list \
   CONFIG.IIC_FREQ_KHZ {400} \
 ] $iic

  # Create instance: notof_0, and set properties
  set notof_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 notof_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $notof_0

  # Create instance: vb1, and set properties
  set vb1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dp_videoaxi4s_bridge:1.0 vb1 ]
  set_property -dict [ list \
   CONFIG.C_MAX_BPC {10} \
   CONFIG.C_M_AXIS_VIDEO_TDATA_WIDTH {120} \
   CONFIG.C_PPC {4} \
   CONFIG.C_UG934_COMPLIANCE {true} \
 ] $vb1

  # Create instance: xbar, and set properties
  set xbar [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 xbar ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $xbar

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net dp_aud_axi_egress [get_bd_intf_ports aud_axi_egress] [get_bd_intf_pins dp/aud_axi_egress]
  connect_bd_intf_net -intf_net dp_dp_rx_vid_intf_str0 [get_bd_intf_pins dp/dp_rx_vid_intf_str0] [get_bd_intf_pins vb1/dp_vid]
  connect_bd_intf_net -intf_net dp_i2c_edid [get_bd_intf_ports edid_iic] [get_bd_intf_pins dp/i2c_edid]
  connect_bd_intf_net -intf_net dp_lnk_rx_sb_control_axi4s [get_bd_intf_ports m_axis_phy_rx_sb_control] [get_bd_intf_pins dp/lnk_rx_sb_control_axi4s]
  connect_bd_intf_net -intf_net iic_IIC [get_bd_intf_ports ext_iic] [get_bd_intf_pins iic/IIC]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_ports s_axi] [get_bd_intf_pins xbar/S00_AXI]
  connect_bd_intf_net -intf_net s_axis_lnk_rx_lane0_1 [get_bd_intf_ports s_axis_lnk_rx_lane0] [get_bd_intf_pins dp/lnk_rx_axi4s]
  connect_bd_intf_net -intf_net s_axis_lnk_rx_lane1_1 [get_bd_intf_ports s_axis_lnk_rx_lane1] [get_bd_intf_pins dp/lnk_rx_axi4s_lane1]
  connect_bd_intf_net -intf_net s_axis_lnk_rx_lane2_1 [get_bd_intf_ports s_axis_lnk_rx_lane2] [get_bd_intf_pins dp/lnk_rx_axi4s_lane2]
  connect_bd_intf_net -intf_net s_axis_lnk_rx_lane3_1 [get_bd_intf_ports s_axis_lnk_rx_lane3] [get_bd_intf_pins dp/lnk_rx_axi4s_lane3]
  connect_bd_intf_net -intf_net s_axis_phy_rx_sb_status_1 [get_bd_intf_ports s_axis_phy_rx_sb_status] [get_bd_intf_pins dp/lnk_rx_sb_status_axi4s]
  connect_bd_intf_net -intf_net vb1_m_axis_video [get_bd_intf_ports m_axis_video_stream1] [get_bd_intf_pins vb1/m_axis_video]
  connect_bd_intf_net -intf_net xbar_M00_AXI [get_bd_intf_pins iic/S_AXI] [get_bd_intf_pins xbar/M00_AXI]
  connect_bd_intf_net -intf_net xbar_M01_AXI [get_bd_intf_pins dp/dp_s_axilite] [get_bd_intf_pins xbar/M01_AXI]

  # Create port connections
  connect_bd_net -net aux_rx_data_in_1 [get_bd_ports aux_rx_data_in] [get_bd_pins dp/aux_rx_data_in]
  connect_bd_net -net dp_acr_m_aud [get_bd_ports acr_m_aud] [get_bd_pins dp/acr_m_aud]
  connect_bd_net -net dp_acr_n_aud [get_bd_ports acr_n_aud] [get_bd_pins dp/acr_n_aud]
  connect_bd_net -net dp_acr_valid [get_bd_ports acr_valid] [get_bd_pins dp/acr_valid]
  connect_bd_net -net dp_aux_rx_data_en_out_n [get_bd_ports aux_rx_data_en_out_n] [get_bd_pins dp/aux_rx_data_en_out_n]
  connect_bd_net -net dp_aux_rx_data_out [get_bd_ports aux_rx_data_out] [get_bd_pins dp/aux_rx_data_out]
  connect_bd_net -net dp_axi_int [get_bd_ports dprxss_dp_irq] [get_bd_pins dp/axi_int]
  connect_bd_net -net dp_rx_bpc [get_bd_pins dp/rx_bpc] [get_bd_pins vb1/bpc]
  connect_bd_net -net dp_rx_cformat [get_bd_pins dp/rx_cformat] [get_bd_pins vb1/color_format]
  connect_bd_net -net dp_rx_hpd [get_bd_ports rx_hpd] [get_bd_pins dp/rx_hpd]
  connect_bd_net -net dp_rx_vid_msa_hres [get_bd_pins dp/rx_vid_msa_hres] [get_bd_pins vb1/dp_hres]
  connect_bd_net -net dp_rx_vid_pixel_mode [get_bd_pins dp/rx_vid_pixel_mode] [get_bd_pins vb1/pixel_mode]
  connect_bd_net -net iic_gpo [get_bd_ports ext_rst] [get_bd_pins iic/gpo]
  connect_bd_net -net iic_iic2intc_irpt [get_bd_ports dprxss_iic_irq] [get_bd_pins iic/iic2intc_irpt]
  connect_bd_net -net m_aud_axis_aclk_1 [get_bd_ports m_aud_axis_aclk] [get_bd_pins dp/m_aud_axis_aclk]
  connect_bd_net -net m_aud_axis_aresetn_1 [get_bd_ports m_aud_axis_aresetn] [get_bd_pins dp/m_aud_axis_aresetn] [get_bd_pins notof_0/Op1]
  connect_bd_net -net m_axis_aclk_stream1_1 [get_bd_ports m_axis_aclk_stream1] [get_bd_pins vb1/m_axis_aclk]
  connect_bd_net -net notof_0_Res [get_bd_pins dp/aud_rst] [get_bd_pins notof_0/Res]
  connect_bd_net -net rx_lnk_clk_1 [get_bd_ports rx_lnk_clk] [get_bd_pins dp/rx_lnk_clk]
  connect_bd_net -net rx_vid_clk_1 [get_bd_ports rx_vid_clk] [get_bd_pins dp/rx_vid_clk] [get_bd_pins vb1/vid_pixel_clk]
  connect_bd_net -net rx_vid_rst_1 [get_bd_ports rx_vid_rst] [get_bd_pins dp/rx_vid_rst] [get_bd_pins vb1/vid_reset]
  connect_bd_net -net s_axi_aclk_1 [get_bd_ports s_axi_aclk] [get_bd_pins dp/s_axi_aclk] [get_bd_pins iic/s_axi_aclk] [get_bd_pins xbar/aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_ports s_axi_aresetn] [get_bd_pins dp/s_axi_aresetn] [get_bd_pins iic/s_axi_aresetn] [get_bd_pins xbar/aresetn]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs dp/dp_s_axilite/Reg] -force
  assign_bd_address -offset 0x00001000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs iic/S_AXI/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


