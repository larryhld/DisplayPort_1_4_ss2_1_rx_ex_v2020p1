
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xczu9eg2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xczu9eg2default:defaultZ17-349h px? 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px? 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px? 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:04 ; elapsed = 00:00:02 . Memory (MB): peak = 3141.523 ; gain = 0.0002default:defaulth px? 
g

Starting %s Task
103*constraints2,
Cache Timing Information2default:defaultZ18-103h px? 
?
"Creating clock %s with %s sources.582*constraints2?
?dpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_wrapper_inst/inst/gen_gtwizard_gthe4_top.dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[26].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST/RXOUTCLK2default:default2
42default:default2?
?c:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_vid_phy_controller_0_0/vid_phy_controller_xdc.xdc2default:default2
492default:default8@Z18-633h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?
?The BUFG_GT instance '%s' has DIV pins that are not tied constant, so the automatically derived generated clock will use a worst case divide of 1.177*timing2?
ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst	ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst2default:default8Z38-252h px? 
P
;Ending Cache Timing Information Task | Checksum: 204fc4653
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:13 ; elapsed = 00:00:09 . Memory (MB): peak = 3141.523 ; gain = 0.0002default:defaulth px? 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px? 
?

Phase %s%s
101*constraints2
1 2default:default25
!Generate And Synthesize MIG Cores2default:defaultZ18-101h px? 
?
<Added synthesis output to IP cache for IP %s, cache-ID = %s
2511*coregen2/
dpss_zcu102_rx_ddr4_0_0_phy2default:default2$
e529b490a7d889292default:defaultZ19-5647h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:132default:default2
00:00:082default:default2
3366.2462default:default2
0.0002default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2

read_xdc: 2default:default2
00:00:202default:default2
00:00:152default:default2
3435.9142default:default2
69.6682default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0622default:default2
3435.9142default:default2
0.0002default:defaultZ17-268h px? 
U
@Phase 1 Generate And Synthesize MIG Cores | Checksum: 21e63eebd
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:40 ; elapsed = 00:01:34 . Memory (MB): peak = 3435.914 ; gain = 119.0592default:defaulth px? 
?

Phase %s%s
101*constraints2
2 2default:default27
#Generate And Synthesize Debug Cores2default:defaultZ18-101h px? 
k
)Generating Script for core instance : %s 214*	chipscope2
dbg_hub2default:defaultZ16-329h px? 
?
Generating IP %s for %s.
1712*coregen2+
xilinx.com:ip:xsdbm:3.02default:default2

dbg_hub_CV2default:defaultZ19-3806h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:122default:default2
00:00:072default:default2
3453.8672default:default2
0.0002default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.1432default:default2
3453.8672default:default2
0.0002default:defaultZ17-268h px? 
W
BPhase 2 Generate And Synthesize Debug Cores | Checksum: 2104a5bbf
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:54 ; elapsed = 00:03:04 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
i

Phase %s%s
101*constraints2
3 2default:default2
Retarget2default:defaultZ18-101h px? 
y
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
772default:default2
62642default:defaultZ31-138h px? 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px? 
<
'Phase 3 Retarget | Checksum: 19d7b4e88
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:05 ; elapsed = 00:03:13 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
4732default:default2
10162default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Retarget2default:default2
3442default:defaultZ31-1021h px? 
u

Phase %s%s
101*constraints2
4 2default:default2(
Constant propagation2default:defaultZ18-101h px? 
v
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
52default:default2
162default:defaultZ31-138h px? 
H
3Phase 4 Constant propagation | Checksum: 176cada09
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:08 ; elapsed = 00:03:15 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
11122default:default2
35632default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2(
Constant propagation2default:default2
3292default:defaultZ31-1021h px? 
f

Phase %s%s
101*constraints2
5 2default:default2
Sweep2default:defaultZ18-101h px? 
?
?Instance %s has been optimized to an empty box cell during %s but it has constraints that prevent its removal. Empty box cells do not impact the implementation flow but they have no functional relevance.92*opt2?
?dpss_zcu102_rx_i/dp_rx_hier_0/v_dp_rxss1_0/inst/dp/inst/core_top_inst/dport_link_inst/displayport_v8_1_2_rx_link_inst/displayport_v8_1_2_rx_main_inst/sync_cell_fifo_rst_inst (bd_6311_dp_0_xpm_cdc_array_single__parameterized1__79)	?dpss_zcu102_rx_i/dp_rx_hier_0/v_dp_rxss1_0/inst/dp/inst/core_top_inst/dport_link_inst/displayport_v8_1_2_rx_link_inst/displayport_v8_1_2_rx_main_inst/sync_cell_fifo_rst_inst2default:default2
sweep2default:default8Z31-120h px? 
9
$Phase 5 Sweep | Checksum: 14c1c87a8
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:21 ; elapsed = 00:03:28 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
02default:default2
101052default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Sweep2default:default2
39952default:defaultZ31-1021h px? 
r

Phase %s%s
101*constraints2
6 2default:default2%
BUFG optimization2default:defaultZ18-101h px? 
?
PPhase BUFG optimization inserted %s global clock buffer(s) for CLOCK_LOW_FANOUT.553*opt2
02default:defaultZ31-1077h px? 
E
0Phase 6 BUFG optimization | Checksum: 14c1c87a8
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:24 ; elapsed = 00:03:31 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
EPhase %s created %s cells of which %s are BUFGs and removed %s cells.395*opt2%
BUFG optimization2default:default2
02default:default2
02default:default2
02default:defaultZ31-662h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2%
BUFG optimization2default:default2
12default:defaultZ31-1021h px? 
|

Phase %s%s
101*constraints2
7 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px? 
?
dSRL Remap converted %s SRLs to %s registers and converted %s registers of register chains to %s SRLs546*opt2
02default:default2
02default:default2
02default:default2
02default:defaultZ31-1064h px? 
O
:Phase 7 Shift Register Optimization | Checksum: 14c1c87a8
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:25 ; elapsed = 00:03:33 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px? 
x

Phase %s%s
101*constraints2
8 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px? 
K
6Phase 8 Post Processing Netlist | Checksum: 18646133d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:26 ; elapsed = 00:03:34 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
12default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2+
Post Processing Netlist2default:default2
5042default:defaultZ31-1021h px? 
/
Opt_design Change Summary
*commonh px? 
/
=========================
*commonh px? 


*commonh px? 


*commonh px? 
?
z-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Phase                        |  #Cells created  |  #Cells Removed  |  #Constrained objects preventing optimizations  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Retarget                     |             473  |            1016  |                                            344  |
|  Constant propagation         |            1112  |            3563  |                                            329  |
|  Sweep                        |               0  |           10105  |                                           3995  |
|  BUFG optimization            |               0  |               0  |                                              1  |
|  Shift Register Optimization  |               0  |               0  |                                              0  |
|  Post Processing Netlist      |               0  |               1  |                                            504  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.272 . Memory (MB): peak = 3453.867 ; gain = 0.0002default:defaulth px? 
J
5Ending Logic Optimization Task | Checksum: 25ee4e98f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:30 ; elapsed = 00:03:37 . Memory (MB): peak = 3453.867 ; gain = 137.0122default:defaulth px? 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px? 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px? 
?
$Power model is not available for %s
23*power2?
xiphy_riu_or	?dpss_zcu102_rx_i/ddr4_0/inst/u_ddr4_mem_intfc/u_mig_ddr4_phy/inst/generate_block1.u_ddr_xiphy/byte_num[0].xiphy_byte_wrapper.u_xiphy_byte_wrapper/u_xiphy_riuor/xiphy_riu_or2default:default8Z33-23h px? 
?
$Power model is not available for %s
23*power2?
genVref.u_hpio_vref	ydpss_zcu102_rx_i/ddr4_0/inst/u_ddr4_mem_intfc/u_mig_ddr4_phy/inst/u_ddr_iob/genByte[2].u_ddr_iob_byte/genVref.u_hpio_vref2default:default8Z33-23h px? 
=
Applying IDT optimizations ...
9*pwroptZ34-9h px? 
?
Applying ODC optimizations ...
10*pwroptZ34-10h px? 
?
"Creating clock %s with %s sources.582*constraints2?
?dpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_wrapper_inst/inst/gen_gtwizard_gthe4_top.dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[26].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST/RXOUTCLK2default:default2
42default:default2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_vid_phy_controller_0_0/vid_phy_controller_xdc.xdc2default:default2
492default:default8@Z18-633h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?
?The BUFG_GT instance '%s' has DIV pins that are not tied constant, so the automatically derived generated clock will use a worst case divide of 1.177*timing2?
ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst	ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst2default:default8Z38-252h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 


*pwropth px? 
e

Starting %s Task
103*constraints2*
PowerOpt Patch Enables2default:defaultZ18-103h px? 
?
?WRITE_MODE attribute of %s BRAM(s) out of a total of %s has been updated to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
62default:default2
332default:defaultZ34-162h px? 
d
+Structural ODC has moved %s WE to EN ports
155*pwropt2
12default:defaultZ34-201h px? 
?
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
62default:default2
12default:default2
662default:defaultZ34-65h px? 
N
9Ending PowerOpt Patch Enables Task | Checksum: 268640600
*commonh px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.614 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
J
5Ending Power Optimization Task | Checksum: 268640600
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:01:19 ; elapsed = 00:00:53 . Memory (MB): peak = 5141.781 ; gain = 1687.9142default:defaulth px? 
\

Starting %s Task
103*constraints2!
Final Cleanup2default:defaultZ18-103h px? 
E
0Ending Final Cleanup Task | Checksum: 268640600
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
b

Starting %s Task
103*constraints2'
Netlist Obfuscation2default:defaultZ18-103h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.1032default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
K
6Ending Netlist Obfuscation Task | Checksum: 1cd3a3eab
*commonh px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.686 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1082default:default2
1222default:default2
02default:default2
02default:defaultZ4-41h px? 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
opt_design: 2default:default2
00:03:092default:default2
00:04:452default:default2
5141.7812default:default2
2000.2582default:defaultZ17-268h px? 
?
"Creating clock %s with %s sources.582*constraints2?
?dpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_wrapper_inst/inst/gen_gtwizard_gthe4_top.dpss_zcu102_rx_vid_phy_controller_0_0_gtwrapper_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[26].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST/RXOUTCLK2default:default2
42default:default2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.srcs/sources_1/bd/dpss_zcu102_rx/ip/dpss_zcu102_rx_vid_phy_controller_0_0/vid_phy_controller_xdc.xdc2default:default2
492default:default8@Z18-633h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?
?The BUFG_GT instance '%s' has DIV pins that are not tied constant, so the automatically derived generated clock will use a worst case divide of 1.177*timing2?
ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst	ddpss_zcu102_rx_i/dp_rx_hier_0/vid_phy_controller_0/inst/gt_usrclk_source_inst/bufg_gt_rx_usrclk_inst2default:default8Z38-252h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2 
00:00:00.1502default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_opt.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:422default:default2
00:00:262default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_drc -file dpss_zcu102_rx_wrapper_drc_opted.rpt -pb dpss_zcu102_rx_wrapper_drc_opted.pb -rpx dpss_zcu102_rx_wrapper_drc_opted.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_drc -file dpss_zcu102_rx_wrapper_drc_opted.rpt -pb dpss_zcu102_rx_wrapper_drc_opted.pb -rpx dpss_zcu102_rx_wrapper_drc_opted.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_drc_opted.rpt?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_drc_opted.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:112default:default2
00:00:062default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 


End Record