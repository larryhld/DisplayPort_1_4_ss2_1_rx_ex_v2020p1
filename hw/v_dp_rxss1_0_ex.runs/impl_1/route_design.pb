
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px? 
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
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common22
Nodegraph reading from file.  2default:default2
00:00:022default:default2 
00:00:00.9552default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
C
.Phase 1 Build RT Design | Checksum: 17ea3df78
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:56 ; elapsed = 00:00:47 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 2.1 Create Timer | Checksum: 188b02364
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:58 ; elapsed = 00:00:49 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 188b02364
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:58 ; elapsed = 00:00:49 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 188b02364
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:58 ; elapsed = 00:00:49 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
2.4 2default:default2,
Global Clock Net Routing2default:defaultZ18-101h px? 
N
9Phase 2.4 Global Clock Net Routing | Checksum: 186534aeb
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:56 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
p

Phase %s%s
101*constraints2
2.5 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.5 Update Timing | Checksum: 2fcbec318
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:02:00 ; elapsed = 00:01:30 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.273  | TNS=0.000  | WHS=-0.492 | THS=-67.412|
2default:defaultZ35-416h px? 
}

Phase %s%s
101*constraints2
2.6 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
2.6.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 2.6.1 Update Timing | Checksum: 2a94cf443
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:03:08 ; elapsed = 00:02:10 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.273  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
P
;Phase 2.6 Update Timing for Bus Skew | Checksum: 2da582cde
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:03:08 ; elapsed = 00:02:10 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
I
4Phase 2 Router Initialization | Checksum: 2d19f02e0
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:03:09 ; elapsed = 00:02:10 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 114c71d70
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:03:40 ; elapsed = 00:02:30 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
?CLB routing congestion detected. Several CLBs have high routing utilization, which can impact timing closure. Congested CLBs and Nets are dumped in: %s180*route23
iter_3_CongestedCLBsAndNets.txt2default:defaultZ35-443h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.090  | TNS=0.000  | WHS=-0.022 | THS=-0.139 |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 180d4dd6c
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:00 ; elapsed = 00:03:59 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.090  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.2 Global Iteration 1 | Checksum: 29989ea73
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:14 ; elapsed = 00:04:09 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 29989ea73
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:14 ; elapsed = 00:04:09 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 5.1.1 Update Timing | Checksum: 2291f5f67
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:38 ; elapsed = 00:04:23 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.090  | TNS=0.000  | WHS=0.010  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 2a40c7a14
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:38 ; elapsed = 00:04:24 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 2a40c7a14
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:39 ; elapsed = 00:04:24 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 2a40c7a14
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:39 ; elapsed = 00:04:24 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 2ba2f33e7
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:57 ; elapsed = 00:04:36 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=0.090  | TNS=0.000  | WHS=0.010  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 22c9aebc1
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:58 ; elapsed = 00:04:36 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
A
,Phase 6 Post Hold Fix | Checksum: 22c9aebc1
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:58 ; elapsed = 00:04:36 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 264bbc5a9
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:59 ; elapsed = 00:04:37 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 264bbc5a9
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:06:59 ; elapsed = 00:04:37 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
E
0Phase 9 Depositing Routes | Checksum: 264bbc5a9
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:07:07 ; elapsed = 00:04:46 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
Estimated Timing Summary %s
57*route2J
6| WNS=0.090  | TNS=0.000  | WHS=0.010  | THS=0.000  |
2default:defaultZ35-57h px? 
?
?The final timing numbers are based on the router estimated timing analysis. For a complete and accurate timing signoff, please run report_timing_summary.
127*routeZ35-327h px? 
G
2Phase 10 Post Router Timing | Checksum: 264bbc5a9
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:07:07 ; elapsed = 00:04:47 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2o
[Time (s): cpu = 00:07:07 ; elapsed = 00:04:47 . Memory (MB): peak = 5141.781 ; gain = 0.0002default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1992default:default2
1262default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:07:242default:default2
00:04:572default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
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
00:00:252default:default2
00:00:082default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_routed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:402default:default2
00:00:192default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_drc -file dpss_zcu102_rx_wrapper_drc_routed.rpt -pb dpss_zcu102_rx_wrapper_drc_routed.pb -rpx dpss_zcu102_rx_wrapper_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_drc -file dpss_zcu102_rx_wrapper_drc_routed.rpt -pb dpss_zcu102_rx_wrapper_drc_routed.pb -rpx dpss_zcu102_rx_wrapper_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_drc_routed.rpt?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:242default:default2
00:00:122default:default2
5141.7812default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file dpss_zcu102_rx_wrapper_methodology_drc_routed.rpt -pb dpss_zcu102_rx_wrapper_methodology_drc_routed.pb -rpx dpss_zcu102_rx_wrapper_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file dpss_zcu102_rx_wrapper_methodology_drc_routed.rpt -pb dpss_zcu102_rx_wrapper_methodology_drc_routed.pb -rpx dpss_zcu102_rx_wrapper_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
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
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px? 
?
2The results of Report Methodology are in file %s.
450*coretcl2?
?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_methodology_drc_routed.rpt?C:/Projects/Xilinx/DisplayPort/DisplayPort_1_4_ss2_1_rx_ex_v2020p1/hw/v_dp_rxss1_0_ex.runs/impl_1/dpss_zcu102_rx_wrapper_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:01:172default:default2
00:00:432default:default2
5420.1252default:default2
278.3442default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_power -file dpss_zcu102_rx_wrapper_power_routed.rpt -pb dpss_zcu102_rx_wrapper_power_summary_routed.pb -rpx dpss_zcu102_rx_wrapper_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_power -file dpss_zcu102_rx_wrapper_power_routed.rpt -pb dpss_zcu102_rx_wrapper_power_summary_routed.pb -rpx dpss_zcu102_rx_wrapper_power_routed.rpx2default:defaultZ4-113h px? 
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
?
?Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
2112default:default2
1312default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:01:022default:default2
00:00:372default:default2
5447.9412default:default2
27.8162default:defaultZ17-268h px? 
?
%s4*runtcl2?
yExecuting : report_route_status -file dpss_zcu102_rx_wrapper_route_status.rpt -pb dpss_zcu102_rx_wrapper_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file dpss_zcu102_rx_wrapper_timing_summary_routed.rpt -pb dpss_zcu102_rx_wrapper_timing_summary_routed.pb -rpx dpss_zcu102_rx_wrapper_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px? 
?
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -2, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
}There are set_bus_skew constraint(s) in this design. Please run report_bus_skew to ensure that bus skew requirements are met.223*timingZ38-436h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2+
report_timing_summary: 2default:default2
00:00:082default:default2
00:00:052default:default2
5447.9412default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2s
_Executing : report_incremental_reuse -file dpss_zcu102_rx_wrapper_incremental_reuse_routed.rpt
2default:defaulth px? 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px? 
?
%s4*runtcl2s
_Executing : report_clock_utilization -file dpss_zcu102_rx_wrapper_clock_utilization_routed.rpt
2default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
report_clock_utilization: 2default:default2
00:00:062default:default2
00:00:072default:default2
5447.9412default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_bus_skew -warn_on_violation -file dpss_zcu102_rx_wrapper_bus_skew_routed.rpt -pb dpss_zcu102_rx_wrapper_bus_skew_routed.pb -rpx dpss_zcu102_rx_wrapper_bus_skew_routed.rpx
2default:defaulth px? 
?
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -2, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 


End Record