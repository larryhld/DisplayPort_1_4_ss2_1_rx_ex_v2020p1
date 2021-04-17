------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- vid_edid_v1_0_0_family_support.vhd - package
------------------------------------------------------------------------
-- Filename:   vid_edid_v1_0_0_family_support.vhd
--
-- Description: 
--
--      FAMILIES, PRIMITIVES and PRIMITIVE AVAILABILITY GUARDS
--
--              This package allows to determine whether a given primitive
--              or set of primitives is available in an FPGA family of interest.
--
--              The key element is the function, 'supported', which is
--              available in four variants (overloads). Here are examples
--              of each:
--
--                supported(virtex2, u_RAMB16_S2)
--    
--                supported("Virtex2", u_RAMB16_S2)
--    
--                supported(spartan3, (u_MUXCY, u_XORCY, u_FD))
--
--                supported("spartan3", (u_MUXCY, u_XORCY, u_FD))
--
--              The 'supported' function returns true if and only
--              if all of the primitives being tested, as given in the
--              second argument, are available in the FPGA family that
--              is given in the first argument.
--
--              The first argument can be either one of the FPGA family
--              names from the enumeration type, 'families_type', or a
--              (case insensitive) string giving the same information.
--              The family name 'nofamily' is special and supports
--              none of the primitives.
--
--              The second argument is either a primitive or a list of
--              primitives. The set of primitive names that can be
--              tested is defined by the declaration of the
--              enumeration type, 'primitives_type'. The names are
--              the UNISIM-library names for the primitives, prefixed
--              by "u_". (The prefix avoids introducing a name that
--              conflicts with the component declaration for the primitive.)
--               
--              The array type, 'primitive_array_type' is the basis for
--              forming lists of primitives. Typically, a fixed list
--              of primitves is expressed as a VHDL aggregate, a
--              comma separated list of primitives enclosed in
--              parentheses. (See the last two examples, above.)
--
--              The 'supported' function can be used as a guard
--              condition for a piece of code that depends on primitives
--              (primitive availability guard). Here is an example:
--
--
--                  GEN : if supported(C_FAMILY, (u_MUXCY, u_XORCY)) generate
--                  begin
--                        ... Here, an implementation that depends on
--                        ... MUXCY and XORCY.
--                  end generate;
--
--
--              It can also be used in an assertion statement
--              to give warnings about problems that can arise from
--              attempting to implement into a family that does not
--              support all of the required primitives:
--
--
--                  assert supported(C_FAMILY, <primtive list>)
--                    report "This module cannot be implemnted " &
--                           "into family, " & C_FAMILY &
--                           ", because one or more of the primitives, " &
--                           "<primitive_list>" & ", is not supported."
--                    severity error;
--
--
--      A NOTE ON USAGE
--
--              It is probably best to take an exception to the coding
--              guidelines and make the names that are needed
--              from this package visible to a VHDL compilation unit by
--
--                  library <libname>;
--                  use     <libname>.vid_edid_v1_0_0_family_support.all;
--
--              rather than by calling out individual names in use clauses.
--              (VHDL tools do not have a common interpretation at present
--              on whether
--
--                  use <libname>.vid_edid_v1_0_0_family_support.primitives_type"
--
--              makes the enumeration literals visible.)

--
--      ADDITIONAL FEATURES
--
--            - A function, native_lut_size, is available to allow
--              the caller to query the largest sized LUT available in a given
--              FPGA family.
--
--            - A function, equalIgnoringCase, is available to compare strings
--              with case insensitivity. While this can be used to establish
--              whether the target family is some particular family, such
--              usage is discouraged and should be limited to legacy
--              situations or the rare situations where primitive
--              availability guards will not suffice.
--
--------------------------------------------------------------------------------
-- Author:     FLO
-- History:
-- FLO         2005Mar24         - First Version
--
-- FLO         11/30/05
-- ^^^^^^   
-- Virtex5 added.
-- ~~~~~~
-- TK          03/17/06          Corrected a Spartan3e issue in myimage
-- ~~~~~~
-- FLO         04/26/06
-- ^^^^^^   
--   Added the native_lut_size function.
-- ~~~~~~
-- FLO         08/10/06
-- ^^^^^^
--   Added support for families virtex, spartan2 and spartan2e.
-- ~~~~~~
-- FLO         08/25/06
-- ^^^^^^
--   Enhanced the warning in function str2fam. Now when a string that is
--   passed in the call as a parameter does not correspond to a supported fpga
--   family, the string value of the passed string is mentioned in the warning
--   and it is explicitly stated that the returned value is 'nofamily'.
-- ~~~~~~
-- FLO         08/26/06
-- ^^^^^^
--   - Updated the virtex5 primitive set to a more recent list and
--     removed primitives (TEMAC, PCIE, etc.) that are not present
--     in all virtex5 family members.
--   - Added function equalIgnoringCase and an admonition to use it
--     as little as possible.
--   - Made some improvements to descriptions inside comments.
-- ~~~~~~
-- FLO         08/28/06
-- ^^^^^^
--   Added support for families spartan3a and spartan3an. These are initially
--   taken to have the same primitives as spartan3e.
-- ~~~~~~
-- FLO         10/28/06
-- ^^^^^^
--   Changed function str2fam so that it no longer depends on the VHDL
--   attribute, 'VAL. This is an XST workaround.
-- ~~~~~~
-- FLO         03/08/07
-- ^^^^^^
--   Updated spartan3a and sparan3an.
--   Added spartan3adsp.
-- ~~~~~~
-- FLO         08/31/07
-- ^^^^^^
--   A performance XST workaround was implemented to address slowness
--   associated with primitive availability guards. The workaround changes
--   the way that the fam_has_prim constant is initialized (aggregate
--   rather than a system of function and procedure calls).
-- ~~~~~~
-- FLO         04/11/08
-- ^^^^^^
--   Added these families: aspartan3e, aspartan3a, aspartan3an, aspartan3adsp
-- ~~~~~~
-- FLO         04/14/08
-- ^^^^^^
--   Removed family: aspartan3an
-- ~~~~~~
-- FLO         06/25/08
-- ^^^^^^
--   Added these families: qvirtex4, qrvirtex4
-- ~~~~~~
-- FLO         07/26/08
-- ^^^^^^
--   The BSCAN primitive for spartan3e is now BSCAN_SPARTAN3 instead
--   of BSCAN_SPARTAN3E.
-- ~~~~~~
-- FLO         09/02/06
-- ^^^^^^
--   Added an initial approximation of primitives for spartan6 and virtex6.
-- ~~~~~~
-- FLO         09/04/28
-- ^^^^^^
--  -Removed primitive u_BSCAN_SPARTAN3A from spartan6.
--  -Added the 5 and 6 LUTs to spartan6.
-- ~~~~~~
-- FLO         02/09/10  (back to MM/DD/YY)
-- ^^^^^^
--  -Removed primitive u_BSCAN_VIRTEX5 from virtex6.
--  -Added families spartan6l, qspartan6, aspartan6 and virtex6l.
-- ~~~~~~
-- FLO         04/26/10  (MM/DD/YY)
-- ^^^^^^
--  -Added families qspartan6l, qvirtex5 and qvirtex6.
-- ~~~~~~
-- FLO         06/21/10  (MM/DD/YY)
-- ^^^^^^
--  -Added family qrvirtex5.
-- ~~~~~~
--
--     DET     9/7/2010     For 12.4
-- ~~~~~~
--    -- Per CR573867
--     - Added the function get_root_family() as part of the derivative part
--       support improvements.
--     - Added the Virtex7 and Kintex7 device families
-- ^^^^^^
-- ~~~~~~
-- FLO         10/28/10  (MM/DD/YY)
-- ^^^^^^
--  -Added u_SRLC32E as supported for spartan6 (and its derivatives).  (CR 575828)
-- ~~~~~~
-- FLO         12/15/10  (MM/DD/YY)
-- ^^^^^^
--  -Changed virtex6cx to be equal to virtex6 (instead of virtex5)
--  -Move kintex7 and virtex7 to the primitives in the Rodin unisim.btl file
--  -Added artix7 from the primitives in the Rodin unisim.btl file
-- ~~~~~~
-- FLO         01/05/10  (MM/DD/YY)
-- ^^^^^^
--  -Added RAMB16_4_36 for kintex7, virtex7, artix7 to grandfather axi_ethernetlite_v1_00_a.
-- ~~~~~~
--
--------------------------------------------------------------------------------
-- Naming Conventions:
--    active low signals: "*_n"
--    clock signals: "clk", "clk_div#", "clk_#x"
--    reset signals: "rst", "rst_n"
--    generics: "C_*"
--    user defined types: "*_TYPE"
--    state machine next state: "*_ns"
--    state machine current state: "*_cs"
--    combinational signals: "*_cmb"
--    pipelined or register delay signals: "*_d#"
--    counter signals: "*cnt*"
--    clock enable signals: "*_ce"
--    internal version of output port: "*_i"
--    device pins: "*_pin"
--    ports:- Names begin with Uppercase
--    processes: "*_PROCESS"
--    component instantiations: "<ENTITY_>I_<#|FUNC>
--------------------------------------------------------------------------------

package vid_edid_v1_0_0_family_support is

    type families_type is
    (
       nofamily
     , virtex
     , spartan2
     , spartan2e
     , virtexe
     , virtex2
     , qvirtex2    -- Taken to be identical to the virtex2 primitive set.
     , qrvirtex2   -- Taken to be identical to the virtex2 primitive set.
     , virtex2p
     , spartan3
     , aspartan3
     , virtex4
     , virtex4lx
     , virtex4fx
     , virtex4sx
     , spartan3e
     , virtex5
     , spartan3a
     , spartan3an
     , spartan3adsp
     , aspartan3e
     , aspartan3a
     , aspartan3adsp
     , qvirtex4
     , qrvirtex4
     , spartan6
     , virtex6
     , spartan6l
     , qspartan6
     , aspartan6
     , virtex6l
     , qspartan6l
     , qvirtex5
     , qvirtex6
     , qrvirtex5
     , virtex5tx
     , virtex5fx
     , virtex6cx
     , kintex7
     , virtex7
     , artix7
    );


    type primitives_type is
    (
       u_AND2
     , u_AND2B1L
     , u_AND3
     , u_AND4
     , u_AUTOBUF
     , u_BSCAN_SPARTAN2
     , u_BSCAN_SPARTAN3
     , u_BSCAN_SPARTAN3A
     , u_BSCAN_SPARTAN3E
     , u_BSCAN_SPARTAN6
     , u_BSCAN_VIRTEX
     , u_BSCAN_VIRTEX2
     , u_BSCAN_VIRTEX4
     , u_BSCAN_VIRTEX5
     , u_BSCAN_VIRTEX6
     , u_BUF
     , u_BUFCF
     , u_BUFE
     , u_BUFG
     , u_BUFGCE
     , u_BUFGCE_1
     , u_BUFGCTRL
     , u_BUFGDLL
     , u_BUFGMUX
     , u_BUFGMUX_1
     , u_BUFGMUX_CTRL
     , u_BUFGMUX_VIRTEX4
     , u_BUFGP
     , u_BUFH
     , u_BUFHCE
     , u_BUFIO
     , u_BUFIO2
     , u_BUFIO2_2CLK
     , u_BUFIO2FB
     , u_BUFIO2FB_2CLK
     , u_BUFIODQS
     , u_BUFPLL
     , u_BUFPLL_MCB
     , u_BUFR
     , u_BUFT
     , u_CAPTURE_SPARTAN2
     , u_CAPTURE_SPARTAN3
     , u_CAPTURE_SPARTAN3A
     , u_CAPTURE_SPARTAN3E
     , u_CAPTURE_VIRTEX
     , u_CAPTURE_VIRTEX2
     , u_CAPTURE_VIRTEX4
     , u_CAPTURE_VIRTEX5
     , u_CAPTURE_VIRTEX6
     , u_CARRY4
     , u_CFGLUT5
     , u_CLKDLL
     , u_CLKDLLE
     , u_CLKDLLHF
     , u_CRC32
     , u_CRC64
     , u_DCIRESET
     , u_DCM
     , u_DCM_ADV
     , u_DCM_BASE
     , u_DCM_CLKGEN
     , u_DCM_PS
     , u_DNA_PORT
     , u_DSP48
     , u_DSP48A
     , u_DSP48A1
     , u_DSP48E
     , u_DSP48E1
     , u_DUMMY_INV
     , u_DUMMY_NOR2
     , u_EFUSE_USR
     , u_EMAC
     , u_FD
     , u_FD_1
     , u_FDC
     , u_FDC_1
     , u_FDCE
     , u_FDCE_1
     , u_FDCP
     , u_FDCP_1
     , u_FDCPE
     , u_FDCPE_1
     , u_FDDRCPE
     , u_FDDRRSE
     , u_FDE
     , u_FDE_1
     , u_FDP
     , u_FDP_1
     , u_FDPE
     , u_FDPE_1
     , u_FDR
     , u_FDR_1
     , u_FDRE
     , u_FDRE_1
     , u_FDRS
     , u_FDRS_1
     , u_FDRSE
     , u_FDRSE_1
     , u_FDS
     , u_FDS_1
     , u_FDSE
     , u_FDSE_1
     , u_FIFO16
     , u_FIFO18
     , u_FIFO18_36
     , u_FIFO18E1
     , u_FIFO36
     , u_FIFO36_72
     , u_FIFO36E1
     , u_FMAP
     , u_FRAME_ECC_VIRTEX4
     , u_FRAME_ECC_VIRTEX5
     , u_FRAME_ECC_VIRTEX6
     , u_GND
     , u_GT10_10GE_4
     , u_GT10_10GE_8
     , u_GT10_10GFC_4
     , u_GT10_10GFC_8
     , u_GT10_AURORA_1
     , u_GT10_AURORA_2
     , u_GT10_AURORA_4
     , u_GT10_AURORAX_4
     , u_GT10_AURORAX_8
     , u_GT10_CUSTOM
     , u_GT10_INFINIBAND_1
     , u_GT10_INFINIBAND_2
     , u_GT10_INFINIBAND_4
     , u_GT10_OC192_4
     , u_GT10_OC192_8
     , u_GT10_OC48_1
     , u_GT10_OC48_2
     , u_GT10_OC48_4
     , u_GT10_PCI_EXPRESS_1
     , u_GT10_PCI_EXPRESS_2
     , u_GT10_PCI_EXPRESS_4
     , u_GT10_XAUI_1
     , u_GT10_XAUI_2
     , u_GT10_XAUI_4
     , u_GT11CLK
     , u_GT11CLK_MGT
     , u_GT11_CUSTOM
     , u_GT_AURORA_1
     , u_GT_AURORA_2
     , u_GT_AURORA_4
     , u_GT_CUSTOM
     , u_GT_ETHERNET_1
     , u_GT_ETHERNET_2
     , u_GT_ETHERNET_4
     , u_GT_FIBRE_CHAN_1
     , u_GT_FIBRE_CHAN_2
     , u_GT_FIBRE_CHAN_4
     , u_GT_INFINIBAND_1
     , u_GT_INFINIBAND_2
     , u_GT_INFINIBAND_4
     , u_GTPA1_DUAL
     , u_GT_XAUI_1
     , u_GT_XAUI_2
     , u_GT_XAUI_4
     , u_GTXE1
     , u_IBUF
     , u_IBUF_AGP
     , u_IBUF_CTT
     , u_IBUF_DLY_ADJ
     , u_IBUFDS
     , u_IBUFDS_DIFF_OUT
     , u_IBUFDS_DLY_ADJ
     , u_IBUFDS_GTXE1
     , u_IBUFG
     , u_IBUFG_AGP
     , u_IBUFG_CTT
     , u_IBUFGDS
     , u_IBUFGDS_DIFF_OUT
     , u_IBUFG_GTL
     , u_IBUFG_GTLP
     , u_IBUFG_HSTL_I
     , u_IBUFG_HSTL_III
     , u_IBUFG_HSTL_IV
     , u_IBUFG_LVCMOS18
     , u_IBUFG_LVCMOS2
     , u_IBUFG_LVDS
     , u_IBUFG_LVPECL
     , u_IBUFG_PCI33_3
     , u_IBUFG_PCI33_5
     , u_IBUFG_PCI66_3
     , u_IBUFG_PCIX66_3
     , u_IBUFG_SSTL2_I
     , u_IBUFG_SSTL2_II
     , u_IBUFG_SSTL3_I
     , u_IBUFG_SSTL3_II
     , u_IBUF_GTL
     , u_IBUF_GTLP
     , u_IBUF_HSTL_I
     , u_IBUF_HSTL_III
     , u_IBUF_HSTL_IV
     , u_IBUF_LVCMOS18
     , u_IBUF_LVCMOS2
     , u_IBUF_LVDS
     , u_IBUF_LVPECL
     , u_IBUF_PCI33_3
     , u_IBUF_PCI33_5
     , u_IBUF_PCI66_3
     , u_IBUF_PCIX66_3
     , u_IBUF_SSTL2_I
     , u_IBUF_SSTL2_II
     , u_IBUF_SSTL3_I
     , u_IBUF_SSTL3_II
     , u_ICAP_SPARTAN3A
     , u_ICAP_SPARTAN6
     , u_ICAP_VIRTEX2
     , u_ICAP_VIRTEX4
     , u_ICAP_VIRTEX5
     , u_ICAP_VIRTEX6
     , u_IDDR
     , u_IDDR2
     , u_IDDR_2CLK
     , u_IDELAY
     , u_IDELAYCTRL
     , u_IFDDRCPE
     , u_IFDDRRSE
     , u_INV
     , u_IOBUF
     , u_IOBUF_AGP
     , u_IOBUF_CTT
     , u_IOBUFDS
     , u_IOBUFDS_DIFF_OUT
     , u_IOBUF_F_12
     , u_IOBUF_F_16
     , u_IOBUF_F_2
     , u_IOBUF_F_24
     , u_IOBUF_F_4
     , u_IOBUF_F_6
     , u_IOBUF_F_8
     , u_IOBUF_GTL
     , u_IOBUF_GTLP
     , u_IOBUF_HSTL_I
     , u_IOBUF_HSTL_III
     , u_IOBUF_HSTL_IV
     , u_IOBUF_LVCMOS18
     , u_IOBUF_LVCMOS2
     , u_IOBUF_LVDS
     , u_IOBUF_LVPECL
     , u_IOBUF_PCI33_3
     , u_IOBUF_PCI33_5
     , u_IOBUF_PCI66_3
     , u_IOBUF_PCIX66_3
     , u_IOBUF_S_12
     , u_IOBUF_S_16
     , u_IOBUF_S_2
     , u_IOBUF_S_24
     , u_IOBUF_S_4
     , u_IOBUF_S_6
     , u_IOBUF_S_8
     , u_IOBUF_SSTL2_I
     , u_IOBUF_SSTL2_II
     , u_IOBUF_SSTL3_I
     , u_IOBUF_SSTL3_II
     , u_IODELAY
     , u_IODELAY2
     , u_IODELAYE1
     , u_IODRP2
     , u_IODRP2_MCB
     , u_ISERDES
     , u_ISERDES2
     , u_ISERDESE1
     , u_ISERDES_NODELAY
     , u_JTAGPPC
     , u_JTAG_SIM_SPARTAN6
     , u_JTAG_SIM_VIRTEX6
     , u_KEEPER
     , u_KEY_CLEAR
     , u_LD
     , u_LD_1
     , u_LDC
     , u_LDC_1
     , u_LDCE
     , u_LDCE_1
     , u_LDCP
     , u_LDCP_1
     , u_LDCPE
     , u_LDCPE_1
     , u_LDE
     , u_LDE_1
     , u_LDP
     , u_LDP_1
     , u_LDPE
     , u_LDPE_1
     , u_LUT1
     , u_LUT1_D
     , u_LUT1_L
     , u_LUT2
     , u_LUT2_D
     , u_LUT2_L
     , u_LUT3
     , u_LUT3_D
     , u_LUT3_L
     , u_LUT4
     , u_LUT4_D
     , u_LUT4_L
     , u_LUT5
     , u_LUT5_D
     , u_LUT5_L
     , u_LUT6
     , u_LUT6_D
     , u_LUT6_L
     , u_MCB
     , u_MMCM_ADV
     , u_MMCM_BASE
     , u_MULT18X18
     , u_MULT18X18S
     , u_MULT18X18SIO
     , u_MULT_AND
     , u_MUXCY
     , u_MUXCY_D
     , u_MUXCY_L
     , u_MUXF5
     , u_MUXF5_D
     , u_MUXF5_L
     , u_MUXF6
     , u_MUXF6_D
     , u_MUXF6_L
     , u_MUXF7
     , u_MUXF7_D
     , u_MUXF7_L
     , u_MUXF8
     , u_MUXF8_D
     , u_MUXF8_L
     , u_NAND2
     , u_NAND3
     , u_NAND4
     , u_NOR2
     , u_NOR3
     , u_NOR4
     , u_OBUF
     , u_OBUF_AGP
     , u_OBUF_CTT
     , u_OBUFDS
     , u_OBUF_F_12
     , u_OBUF_F_16
     , u_OBUF_F_2
     , u_OBUF_F_24
     , u_OBUF_F_4
     , u_OBUF_F_6
     , u_OBUF_F_8
     , u_OBUF_GTL
     , u_OBUF_GTLP
     , u_OBUF_HSTL_I
     , u_OBUF_HSTL_III
     , u_OBUF_HSTL_IV
     , u_OBUF_LVCMOS18
     , u_OBUF_LVCMOS2
     , u_OBUF_LVDS
     , u_OBUF_LVPECL
     , u_OBUF_PCI33_3
     , u_OBUF_PCI33_5
     , u_OBUF_PCI66_3
     , u_OBUF_PCIX66_3
     , u_OBUF_S_12
     , u_OBUF_S_16
     , u_OBUF_S_2
     , u_OBUF_S_24
     , u_OBUF_S_4
     , u_OBUF_S_6
     , u_OBUF_S_8
     , u_OBUF_SSTL2_I
     , u_OBUF_SSTL2_II
     , u_OBUF_SSTL3_I
     , u_OBUF_SSTL3_II
     , u_OBUFT
     , u_OBUFT_AGP
     , u_OBUFT_CTT
     , u_OBUFTDS
     , u_OBUFT_F_12
     , u_OBUFT_F_16
     , u_OBUFT_F_2
     , u_OBUFT_F_24
     , u_OBUFT_F_4
     , u_OBUFT_F_6
     , u_OBUFT_F_8
     , u_OBUFT_GTL
     , u_OBUFT_GTLP
     , u_OBUFT_HSTL_I
     , u_OBUFT_HSTL_III
     , u_OBUFT_HSTL_IV
     , u_OBUFT_LVCMOS18
     , u_OBUFT_LVCMOS2
     , u_OBUFT_LVDS
     , u_OBUFT_LVPECL
     , u_OBUFT_PCI33_3
     , u_OBUFT_PCI33_5
     , u_OBUFT_PCI66_3
     , u_OBUFT_PCIX66_3
     , u_OBUFT_S_12
     , u_OBUFT_S_16
     , u_OBUFT_S_2
     , u_OBUFT_S_24
     , u_OBUFT_S_4
     , u_OBUFT_S_6
     , u_OBUFT_S_8
     , u_OBUFT_SSTL2_I
     , u_OBUFT_SSTL2_II
     , u_OBUFT_SSTL3_I
     , u_OBUFT_SSTL3_II
     , u_OCT_CALIBRATE
     , u_ODDR
     , u_ODDR2
     , u_OFDDRCPE
     , u_OFDDRRSE
     , u_OFDDRTCPE
     , u_OFDDRTRSE
     , u_OR2
     , u_OR2L
     , u_OR3
     , u_OR4
     , u_ORCY
     , u_OSERDES
     , u_OSERDES2
     , u_OSERDESE1
     , u_PCIE_2_0
     , u_PCIE_A1
     , u_PLL_ADV
     , u_PLL_BASE
     , u_PMCD
     , u_POST_CRC_INTERNAL
     , u_PPC405
     , u_PPC405_ADV
     , u_PPR_FRAME
     , u_PULLDOWN
     , u_PULLUP
     , u_RAM128X1D
     , u_RAM128X1S
     , u_RAM128X1S_1
     , u_RAM16X1D
     , u_RAM16X1D_1
     , u_RAM16X1S
     , u_RAM16X1S_1
     , u_RAM16X2S
     , u_RAM16X4S
     , u_RAM16X8S
     , u_RAM256X1S
     , u_RAM32M
     , u_RAM32X1D
     , u_RAM32X1D_1
     , u_RAM32X1S
     , u_RAM32X1S_1
     , u_RAM32X2S
     , u_RAM32X4S
     , u_RAM32X8S
     , u_RAM64M
     , u_RAM64X1D
     , u_RAM64X1D_1
     , u_RAM64X1S
     , u_RAM64X1S_1
     , u_RAM64X2S
     , u_RAMB16
     , u_RAMB16BWE
     , u_RAMB16BWER
     , u_RAMB16BWE_S18
     , u_RAMB16BWE_S18_S18
     , u_RAMB16BWE_S18_S9
     , u_RAMB16BWE_S36
     , u_RAMB16BWE_S36_S18
     , u_RAMB16BWE_S36_S36
     , u_RAMB16BWE_S36_S9
     , u_RAMB16_S1
     , u_RAMB16_S18
     , u_RAMB16_S18_S18
     , u_RAMB16_S18_S36
     , u_RAMB16_S1_S1
     , u_RAMB16_S1_S18
     , u_RAMB16_S1_S2
     , u_RAMB16_S1_S36
     , u_RAMB16_S1_S4
     , u_RAMB16_S1_S9
     , u_RAMB16_S2
     , u_RAMB16_S2_S18
     , u_RAMB16_S2_S2
     , u_RAMB16_S2_S36
     , u_RAMB16_S2_S4
     , u_RAMB16_S2_S9
     , u_RAMB16_S36
     , u_RAMB16_S36_S36
     , u_RAMB16_S4
     , u_RAMB16_S4_S18
     , u_RAMB16_S4_S36
     , u_RAMB16_S4_S4
     , u_RAMB16_S4_S9
     , u_RAMB16_S9
     , u_RAMB16_S9_S18
     , u_RAMB16_S9_S36
     , u_RAMB16_S9_S9
     , u_RAMB18
     , u_RAMB18E1
     , u_RAMB18SDP
     , u_RAMB32_S64_ECC
     , u_RAMB36
     , u_RAMB36E1
     , u_RAMB36_EXP
     , u_RAMB36SDP
     , u_RAMB36SDP_EXP
     , u_RAMB4_S1
     , u_RAMB4_S16
     , u_RAMB4_S16_S16
     , u_RAMB4_S1_S1
     , u_RAMB4_S1_S16
     , u_RAMB4_S1_S2
     , u_RAMB4_S1_S4
     , u_RAMB4_S1_S8
     , u_RAMB4_S2
     , u_RAMB4_S2_S16
     , u_RAMB4_S2_S2
     , u_RAMB4_S2_S4
     , u_RAMB4_S2_S8
     , u_RAMB4_S4
     , u_RAMB4_S4_S16
     , u_RAMB4_S4_S4
     , u_RAMB4_S4_S8
     , u_RAMB4_S8
     , u_RAMB4_S8_S16
     , u_RAMB4_S8_S8
     , u_RAMB8BWER
     , u_ROM128X1
     , u_ROM16X1
     , u_ROM256X1
     , u_ROM32X1
     , u_ROM64X1
     , u_SLAVE_SPI
     , u_SPI_ACCESS
     , u_SRL16
     , u_SRL16_1
     , u_SRL16E
     , u_SRL16E_1
     , u_SRLC16
     , u_SRLC16_1
     , u_SRLC16E
     , u_SRLC16E_1
     , u_SRLC32E
     , u_STARTBUF_SPARTAN2
     , u_STARTBUF_SPARTAN3
     , u_STARTBUF_SPARTAN3E
     , u_STARTBUF_VIRTEX
     , u_STARTBUF_VIRTEX2
     , u_STARTBUF_VIRTEX4
     , u_STARTUP_SPARTAN2
     , u_STARTUP_SPARTAN3
     , u_STARTUP_SPARTAN3A
     , u_STARTUP_SPARTAN3E
     , u_STARTUP_SPARTAN6
     , u_STARTUP_VIRTEX
     , u_STARTUP_VIRTEX2
     , u_STARTUP_VIRTEX4
     , u_STARTUP_VIRTEX5
     , u_STARTUP_VIRTEX6
     , u_SUSPEND_SYNC
     , u_SYSMON
     , u_TEMAC_SINGLE
     , u_TOC
     , u_TOCBUF
     , u_USR_ACCESS_VIRTEX4
     , u_USR_ACCESS_VIRTEX5
     , u_USR_ACCESS_VIRTEX6
     , u_VCC
     , u_XNOR2
     , u_XNOR3
     , u_XNOR4
     , u_XOR2
     , u_XOR3
     , u_XOR4
     , u_XORCY
     , u_XORCY_D
     , u_XORCY_L
    -- Primitives added for artix7, kintex6, virtex7 below
     , u_AND2B1
     , u_AND2B2
     , u_AND3B1
     , u_AND3B2
     , u_AND3B3
     , u_AND4B1
     , u_AND4B2
     , u_AND4B3
     , u_AND4B4
     , u_AND5
     , u_AND5B1
     , u_AND5B2
     , u_AND5B3
     , u_AND5B4
     , u_AND5B5
     , u_BSCANE2
     , u_BUFMR
     , u_BUFMRCE
     , u_CAPTUREE2
     , u_CFG_IO_ACCESS
     , u_FRAME_ECCE2
     , u_GTXE2_CHANNEL
     , u_GTXE2_COMMON
     , u_IBUF_DCIEN
     , u_IBUFDS_BLVDS_25
     , u_IBUFDS_DCIEN
     , u_IBUFDS_DIFF_OUT_DCIEN
     , u_IBUFDS_GTE2
     , u_IBUFDS_LVDS_25
     , u_IBUFGDS_BLVDS_25
     , u_IBUFGDS_LVDS_25
     , u_IBUFG_HSTL_I_18
     , u_IBUFG_HSTL_I_DCI
     , u_IBUFG_HSTL_I_DCI_18
     , u_IBUFG_HSTL_II
     , u_IBUFG_HSTL_II_18
     , u_IBUFG_HSTL_II_DCI
     , u_IBUFG_HSTL_II_DCI_18
     , u_IBUFG_HSTL_III_18
     , u_IBUFG_HSTL_III_DCI
     , u_IBUFG_HSTL_III_DCI_18
     , u_IBUFG_LVCMOS12
     , u_IBUFG_LVCMOS15
     , u_IBUFG_LVCMOS25
     , u_IBUFG_LVCMOS33
     , u_IBUFG_LVDCI_15
     , u_IBUFG_LVDCI_18
     , u_IBUFG_LVDCI_DV2_15
     , u_IBUFG_LVDCI_DV2_18
     , u_IBUFG_LVTTL
     , u_IBUFG_SSTL18_I
     , u_IBUFG_SSTL18_I_DCI
     , u_IBUFG_SSTL18_II
     , u_IBUFG_SSTL18_II_DCI
     , u_IBUF_HSTL_I_18
     , u_IBUF_HSTL_I_DCI
     , u_IBUF_HSTL_I_DCI_18
     , u_IBUF_HSTL_II
     , u_IBUF_HSTL_II_18
     , u_IBUF_HSTL_II_DCI
     , u_IBUF_HSTL_II_DCI_18
     , u_IBUF_HSTL_III_18
     , u_IBUF_HSTL_III_DCI
     , u_IBUF_HSTL_III_DCI_18
     , u_IBUF_LVCMOS12
     , u_IBUF_LVCMOS15
     , u_IBUF_LVCMOS25
     , u_IBUF_LVCMOS33
     , u_IBUF_LVDCI_15
     , u_IBUF_LVDCI_18
     , u_IBUF_LVDCI_DV2_15
     , u_IBUF_LVDCI_DV2_18
     , u_IBUF_LVTTL
     , u_IBUF_SSTL18_I
     , u_IBUF_SSTL18_I_DCI
     , u_IBUF_SSTL18_II
     , u_IBUF_SSTL18_II_DCI
     , u_ICAPE2
     , u_IDELAYE2
     , u_IN_FIFO
     , u_IOBUFDS_BLVDS_25
     , u_IOBUFDS_DIFF_OUT_DCIEN
     , u_IOBUF_HSTL_I_18
     , u_IOBUF_HSTL_II
     , u_IOBUF_HSTL_II_18
     , u_IOBUF_HSTL_II_DCI
     , u_IOBUF_HSTL_II_DCI_18
     , u_IOBUF_HSTL_III_18
     , u_IOBUF_LVCMOS12
     , u_IOBUF_LVCMOS15
     , u_IOBUF_LVCMOS25
     , u_IOBUF_LVCMOS33
     , u_IOBUF_LVDCI_15
     , u_IOBUF_LVDCI_18
     , u_IOBUF_LVDCI_DV2_15
     , u_IOBUF_LVDCI_DV2_18
     , u_IOBUF_LVTTL
     , u_IOBUF_SSTL18_I
     , u_IOBUF_SSTL18_II
     , u_IOBUF_SSTL18_II_DCI
     , u_ISERDESE2
     , u_JTAG_SIME2
     , u_LUT6_2
     , u_MMCME2_ADV
     , u_MMCME2_BASE
     , u_NAND2B1
     , u_NAND2B2
     , u_NAND3B1
     , u_NAND3B2
     , u_NAND3B3
     , u_NAND4B1
     , u_NAND4B2
     , u_NAND4B3
     , u_NAND4B4
     , u_NAND5
     , u_NAND5B1
     , u_NAND5B2
     , u_NAND5B3
     , u_NAND5B4
     , u_NAND5B5
     , u_NOR2B1
     , u_NOR2B2
     , u_NOR3B1
     , u_NOR3B2
     , u_NOR3B3
     , u_NOR4B1
     , u_NOR4B2
     , u_NOR4B3
     , u_NOR4B4
     , u_NOR5
     , u_NOR5B1
     , u_NOR5B2
     , u_NOR5B3
     , u_NOR5B4
     , u_NOR5B5
     , u_OBUFDS_BLVDS_25
     , u_OBUFDS_DUAL_BUF
     , u_OBUFDS_LVDS_25
     , u_OBUF_HSTL_I_18
     , u_OBUF_HSTL_I_DCI
     , u_OBUF_HSTL_I_DCI_18
     , u_OBUF_HSTL_II
     , u_OBUF_HSTL_II_18
     , u_OBUF_HSTL_II_DCI
     , u_OBUF_HSTL_II_DCI_18
     , u_OBUF_HSTL_III_18
     , u_OBUF_HSTL_III_DCI
     , u_OBUF_HSTL_III_DCI_18
     , u_OBUF_LVCMOS12
     , u_OBUF_LVCMOS15
     , u_OBUF_LVCMOS25
     , u_OBUF_LVCMOS33
     , u_OBUF_LVDCI_15
     , u_OBUF_LVDCI_18
     , u_OBUF_LVDCI_DV2_15
     , u_OBUF_LVDCI_DV2_18
     , u_OBUF_LVTTL
     , u_OBUF_SSTL18_I
     , u_OBUF_SSTL18_I_DCI
     , u_OBUF_SSTL18_II
     , u_OBUF_SSTL18_II_DCI
     , u_OBUFT_DCIEN
     , u_OBUFTDS_BLVDS_25
     , u_OBUFTDS_DCIEN
     , u_OBUFTDS_DCIEN_DUAL_BUF
     , u_OBUFTDS_DUAL_BUF
     , u_OBUFTDS_LVDS_25
     , u_OBUFT_HSTL_I_18
     , u_OBUFT_HSTL_I_DCI
     , u_OBUFT_HSTL_I_DCI_18
     , u_OBUFT_HSTL_II
     , u_OBUFT_HSTL_II_18
     , u_OBUFT_HSTL_II_DCI
     , u_OBUFT_HSTL_II_DCI_18
     , u_OBUFT_HSTL_III_18
     , u_OBUFT_HSTL_III_DCI
     , u_OBUFT_HSTL_III_DCI_18
     , u_OBUFT_LVCMOS12
     , u_OBUFT_LVCMOS15
     , u_OBUFT_LVCMOS25
     , u_OBUFT_LVCMOS33
     , u_OBUFT_LVDCI_15
     , u_OBUFT_LVDCI_18
     , u_OBUFT_LVDCI_DV2_15
     , u_OBUFT_LVDCI_DV2_18
     , u_OBUFT_LVTTL
     , u_OBUFT_SSTL18_I
     , u_OBUFT_SSTL18_I_DCI
     , u_OBUFT_SSTL18_II
     , u_OBUFT_SSTL18_II_DCI
     , u_ODELAYE2
     , u_OR2B1
     , u_OR2B2
     , u_OR3B1
     , u_OR3B2
     , u_OR3B3
     , u_OR4B1
     , u_OR4B2
     , u_OR4B3
     , u_OR4B4
     , u_OR5
     , u_OR5B1
     , u_OR5B2
     , u_OR5B3
     , u_OR5B4
     , u_OR5B5
     , u_OSERDESE2
     , u_OUT_FIFO
     , u_PCIE_2_1
     , u_PHASER_IN
     , u_PHASER_IN_PHY
     , u_PHASER_OUT
     , u_PHASER_OUT_PHY
     , u_PHASER_REF
     , u_PHY_CONTROL
     , u_PLLE2_ADV
     , u_PLLE2_BASE
     , u_PSS
     , u_RAMD32
     , u_RAMD64E
     , u_RAMS32
     , u_RAMS64E
     , u_SIM_CONFIGE2
     , u_STARTUPE2
     , u_USR_ACCESSE2
     , u_XADC
     , u_XNOR5
     , u_XOR5
     , u_ZHOLD_DELAY
    );

    type primitive_array_type is array (natural range <>) of primitives_type;


    ---------------------------------------------------------------------------- 
    -- Returns true if primitive is available in family.
    --
    -- Examples:
    --
    --     supported(virtex2, u_RAMB16_S2) returns true because the RAMB16_S2
    --                                     primitive is available in the
    --                                     virtex2 family.
    --
    --     supported(spartan3, u_RAM4B_S4) returns false because the RAMB4_S4
    --                                     primitive is not available in the
    --                                     spartan3 family.
    ---------------------------------------------------------------------------- 
    function supported( family         : families_type;
                        primitive      : primitives_type
                      ) return boolean;


    ---------------------------------------------------------------------------- 
    -- This is an overload of function 'supported' (see above). It allows a list
    -- of primitives to be tested.
    --
    -- Returns true if all of primitives in the list are available in family.
    --
    -- Example:        supported(spartan3, (u_MUXCY, u_XORCY, u_FD))
    -- is
    -- equivalent to:  supported(spartan3, u_MUXCY) and
    --                 supported(spartan3, u_XORCY) and
    --                 supported(spartan3, u_FD);
    ---------------------------------------------------------------------------- 
    function supported( family         : families_type;
                        primitives     : primitive_array_type
                      ) return boolean;


    ---------------------------------------------------------------------------- 
    -- Below, are overloads of function 'supported' that allow the family
    -- parameter to be passed as a string. These correspond to the above two
    -- functions otherwise.
    ---------------------------------------------------------------------------- 
    function supported( fam_as_str     : string;
                        primitive      : primitives_type
                      ) return boolean;


    function supported( fam_as_str     : string;
                        primitives     : primitive_array_type
                      ) return boolean;



    ---------------------------------------------------------------------------- 
    -- Conversions from/to STRING to/from families_type.
    -- These are convenience functions that are not normally needed when
    -- using the 'supported' functions.
    ---------------------------------------------------------------------------- 
    function str2fam( fam_as_string  : string ) return families_type;


    function fam2str( fam :  families_type ) return string;

    ---------------------------------------------------------------------------- 
    -- Function: native_lut_size
    --
    -- Returns the largest LUT size available in FPGA family, fam.
    -- If no LUT is available in fam, then returns zero by default, unless
    -- the call specifies a no_lut_return_val, in which case this value
    -- is returned.
    --
    -- The function is available in two overload versions, one for each
    -- way of passing the fam argument.
    ---------------------------------------------------------------------------- 
    function native_lut_size( fam : families_type;
                              no_lut_return_val : natural := 0
                            ) return natural;

    function native_lut_size( fam_as_string : string;
                              no_lut_return_val : natural := 0
                            ) return natural;
                      

    ---------------------------------------------------------------------------- 
    -- Function: equalIgnoringCase
    --
    -- Compare one string against another for equality with case insensitivity.
    -- Can be used to test see if a family, C_FAMILY, is equal to some
    -- family. However such usage is discouraged. Use instead availability
    -- primitive guards based on the function, 'supported', wherever possible.
    ---------------------------------------------------------------------------- 
    function equalIgnoringCase( str1, str2 : string ) return boolean;
    
    
    
    ---------------------------------------------------------------------------- 
    -- Function: get_root_family
    --
    -- This function takes in the string for the desired FPGA family type and
    -- returns the root FPGA family type. This is used for derivative part 
    -- aliasing to the root family.
    ---------------------------------------------------------------------------- 
    function get_root_family( family_in : string ) return string;
    
    
    
    

end package vid_edid_v1_0_0_family_support;



package body vid_edid_v1_0_0_family_support is

    type     prim_status_type is (
                                    n  -- no
                                  , y  -- yes
                                  , u  -- unknown, not used. However, we use
                                       -- an enumeration to allow for
                                       -- possible future enhancement.
                                 );

    type     fam_prim_status is array (primitives_type) of prim_status_type;

    type     fam_has_prim_type is array (families_type) of fam_prim_status;

-- Performance workaround (XST procedure and function handling).
-- The fam_has_prim constant is initialized by an aggregate rather than by the
-- following function. A version of this file with this function not
-- commented was employed in building the aggregate. So, what is below still
-- defines the family-primitive matirix.
--#   ---------------------------------------------------------------------------- 
--#   --  This function is used to populate the matrix of family/primitive values. 
--#   ---------------------------------------------------------------------------- 
--#   ---( 
--#   function prim_population return fam_has_prim_type is 
--#       variable pp : fam_has_prim_type := (others => (others => n)); 
--#
--#       procedure set_to(  stat      : prim_status_type 
--#                        ; fam       : families_type 
--#                        ; prim_list : primitive_array_type 
--#                       ) is 
--#       begin 
--#           for i in prim_list'range loop 
--#               pp(fam)(prim_list(i)) := stat; 
--#           end loop; 
--#       end set_to; 
--#
--#   begin 
--#       set_to(y, virtex, ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGDLL 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_VIRTEX 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLHF 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFG 
--#                           , u_IBUFG_AGP 
--#                           , u_IBUFG_CTT 
--#                           , u_IBUFG_GTL 
--#                           , u_IBUFG_GTLP 
--#                           , u_IBUFG_HSTL_I 
--#                           , u_IBUFG_HSTL_III 
--#                           , u_IBUFG_HSTL_IV 
--#                           , u_IBUFG_LVCMOS2 
--#                           , u_IBUFG_PCI33_3 
--#                           , u_IBUFG_PCI33_5 
--#                           , u_IBUFG_PCI66_3 
--#                           , u_IBUFG_SSTL2_I 
--#                           , u_IBUFG_SSTL2_II 
--#                           , u_IBUFG_SSTL3_I 
--#                           , u_IBUFG_SSTL3_II 
--#                           , u_IBUF_AGP 
--#                           , u_IBUF_CTT 
--#                           , u_IBUF_GTL 
--#                           , u_IBUF_GTLP 
--#                           , u_IBUF_HSTL_I 
--#                           , u_IBUF_HSTL_III 
--#                           , u_IBUF_HSTL_IV 
--#                           , u_IBUF_LVCMOS2 
--#                           , u_IBUF_PCI33_3 
--#                           , u_IBUF_PCI33_5 
--#                           , u_IBUF_PCI66_3 
--#                           , u_IBUF_SSTL2_I 
--#                           , u_IBUF_SSTL2_II 
--#                           , u_IBUF_SSTL3_I 
--#                           , u_IBUF_SSTL3_II 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUF_AGP 
--#                           , u_IOBUF_CTT 
--#                           , u_IOBUF_F_12 
--#                           , u_IOBUF_F_16 
--#                           , u_IOBUF_F_2 
--#                           , u_IOBUF_F_24 
--#                           , u_IOBUF_F_4 
--#                           , u_IOBUF_F_6 
--#                           , u_IOBUF_F_8 
--#                           , u_IOBUF_GTL 
--#                           , u_IOBUF_GTLP 
--#                           , u_IOBUF_HSTL_I 
--#                           , u_IOBUF_HSTL_III 
--#                           , u_IOBUF_HSTL_IV 
--#                           , u_IOBUF_LVCMOS2 
--#                           , u_IOBUF_PCI33_3 
--#                           , u_IOBUF_PCI33_5 
--#                           , u_IOBUF_PCI66_3 
--#                           , u_IOBUF_SSTL2_I 
--#                           , u_IOBUF_SSTL2_II 
--#                           , u_IOBUF_SSTL3_I 
--#                           , u_IOBUF_SSTL3_II 
--#                           , u_IOBUF_S_12 
--#                           , u_IOBUF_S_16 
--#                           , u_IOBUF_S_2 
--#                           , u_IOBUF_S_24 
--#                           , u_IOBUF_S_4 
--#                           , u_IOBUF_S_6 
--#                           , u_IOBUF_S_8 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFT 
--#                           , u_OBUFT_AGP 
--#                           , u_OBUFT_CTT 
--#                           , u_OBUFT_F_12 
--#                           , u_OBUFT_F_16 
--#                           , u_OBUFT_F_2 
--#                           , u_OBUFT_F_24 
--#                           , u_OBUFT_F_4 
--#                           , u_OBUFT_F_6 
--#                           , u_OBUFT_F_8 
--#                           , u_OBUFT_GTL 
--#                           , u_OBUFT_GTLP 
--#                           , u_OBUFT_HSTL_I 
--#                           , u_OBUFT_HSTL_III 
--#                           , u_OBUFT_HSTL_IV 
--#                           , u_OBUFT_LVCMOS2 
--#                           , u_OBUFT_PCI33_3 
--#                           , u_OBUFT_PCI33_5 
--#                           , u_OBUFT_PCI66_3 
--#                           , u_OBUFT_SSTL2_I 
--#                           , u_OBUFT_SSTL2_II 
--#                           , u_OBUFT_SSTL3_I 
--#                           , u_OBUFT_SSTL3_II 
--#                           , u_OBUFT_S_12 
--#                           , u_OBUFT_S_16 
--#                           , u_OBUFT_S_2 
--#                           , u_OBUFT_S_24 
--#                           , u_OBUFT_S_4 
--#                           , u_OBUFT_S_6 
--#                           , u_OBUFT_S_8 
--#                           , u_OBUF_AGP 
--#                           , u_OBUF_CTT 
--#                           , u_OBUF_F_12 
--#                           , u_OBUF_F_16 
--#                           , u_OBUF_F_2 
--#                           , u_OBUF_F_24 
--#                           , u_OBUF_F_4 
--#                           , u_OBUF_F_6 
--#                           , u_OBUF_F_8 
--#                           , u_OBUF_GTL 
--#                           , u_OBUF_GTLP 
--#                           , u_OBUF_HSTL_I 
--#                           , u_OBUF_HSTL_III 
--#                           , u_OBUF_HSTL_IV 
--#                           , u_OBUF_LVCMOS2 
--#                           , u_OBUF_PCI33_3 
--#                           , u_OBUF_PCI33_5 
--#                           , u_OBUF_PCI66_3 
--#                           , u_OBUF_SSTL2_I 
--#                           , u_OBUF_SSTL2_II 
--#                           , u_OBUF_SSTL3_I 
--#                           , u_OBUF_SSTL3_II 
--#                           , u_OBUF_S_12 
--#                           , u_OBUF_S_16 
--#                           , u_OBUF_S_2 
--#                           , u_OBUF_S_24 
--#                           , u_OBUF_S_4 
--#                           , u_OBUF_S_6 
--#                           , u_OBUF_S_8 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAMB4_S1 
--#                           , u_RAMB4_S16 
--#                           , u_RAMB4_S16_S16 
--#                           , u_RAMB4_S1_S1 
--#                           , u_RAMB4_S1_S16 
--#                           , u_RAMB4_S1_S2 
--#                           , u_RAMB4_S1_S4 
--#                           , u_RAMB4_S1_S8 
--#                           , u_RAMB4_S2 
--#                           , u_RAMB4_S2_S16 
--#                           , u_RAMB4_S2_S2 
--#                           , u_RAMB4_S2_S4 
--#                           , u_RAMB4_S2_S8 
--#                           , u_RAMB4_S4 
--#                           , u_RAMB4_S4_S16 
--#                           , u_RAMB4_S4_S4 
--#                           , u_RAMB4_S4_S8 
--#                           , u_RAMB4_S8 
--#                           , u_RAMB4_S8_S16 
--#                           , u_RAMB4_S8_S8 
--#                           , u_ROM16X1 
--#                           , u_ROM32X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_STARTBUF_VIRTEX 
--#                           , u_STARTUP_VIRTEX 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       set_to(y, spartan2, ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_SPARTAN2 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGDLL 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_SPARTAN2 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLHF 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFG 
--#                           , u_IBUFG_AGP 
--#                           , u_IBUFG_CTT 
--#                           , u_IBUFG_GTL 
--#                           , u_IBUFG_GTLP 
--#                           , u_IBUFG_HSTL_I 
--#                           , u_IBUFG_HSTL_III 
--#                           , u_IBUFG_HSTL_IV 
--#                           , u_IBUFG_LVCMOS2 
--#                           , u_IBUFG_PCI33_3 
--#                           , u_IBUFG_PCI33_5 
--#                           , u_IBUFG_PCI66_3 
--#                           , u_IBUFG_SSTL2_I 
--#                           , u_IBUFG_SSTL2_II 
--#                           , u_IBUFG_SSTL3_I 
--#                           , u_IBUFG_SSTL3_II 
--#                           , u_IBUF_AGP 
--#                           , u_IBUF_CTT 
--#                           , u_IBUF_GTL 
--#                           , u_IBUF_GTLP 
--#                           , u_IBUF_HSTL_I 
--#                           , u_IBUF_HSTL_III 
--#                           , u_IBUF_HSTL_IV 
--#                           , u_IBUF_LVCMOS2 
--#                           , u_IBUF_PCI33_3 
--#                           , u_IBUF_PCI33_5 
--#                           , u_IBUF_PCI66_3 
--#                           , u_IBUF_SSTL2_I 
--#                           , u_IBUF_SSTL2_II 
--#                           , u_IBUF_SSTL3_I 
--#                           , u_IBUF_SSTL3_II 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUF_AGP 
--#                           , u_IOBUF_CTT 
--#                           , u_IOBUF_F_12 
--#                           , u_IOBUF_F_16 
--#                           , u_IOBUF_F_2 
--#                           , u_IOBUF_F_24 
--#                           , u_IOBUF_F_4 
--#                           , u_IOBUF_F_6 
--#                           , u_IOBUF_F_8 
--#                           , u_IOBUF_GTL 
--#                           , u_IOBUF_GTLP 
--#                           , u_IOBUF_HSTL_I 
--#                           , u_IOBUF_HSTL_III 
--#                           , u_IOBUF_HSTL_IV 
--#                           , u_IOBUF_LVCMOS2 
--#                           , u_IOBUF_PCI33_3 
--#                           , u_IOBUF_PCI33_5 
--#                           , u_IOBUF_PCI66_3 
--#                           , u_IOBUF_SSTL2_I 
--#                           , u_IOBUF_SSTL2_II 
--#                           , u_IOBUF_SSTL3_I 
--#                           , u_IOBUF_SSTL3_II 
--#                           , u_IOBUF_S_12 
--#                           , u_IOBUF_S_16 
--#                           , u_IOBUF_S_2 
--#                           , u_IOBUF_S_24 
--#                           , u_IOBUF_S_4 
--#                           , u_IOBUF_S_6 
--#                           , u_IOBUF_S_8 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFT 
--#                           , u_OBUFT_AGP 
--#                           , u_OBUFT_CTT 
--#                           , u_OBUFT_F_12 
--#                           , u_OBUFT_F_16 
--#                           , u_OBUFT_F_2 
--#                           , u_OBUFT_F_24 
--#                           , u_OBUFT_F_4 
--#                           , u_OBUFT_F_6 
--#                           , u_OBUFT_F_8 
--#                           , u_OBUFT_GTL 
--#                           , u_OBUFT_GTLP 
--#                           , u_OBUFT_HSTL_I 
--#                           , u_OBUFT_HSTL_III 
--#                           , u_OBUFT_HSTL_IV 
--#                           , u_OBUFT_LVCMOS2 
--#                           , u_OBUFT_PCI33_3 
--#                           , u_OBUFT_PCI33_5 
--#                           , u_OBUFT_PCI66_3 
--#                           , u_OBUFT_SSTL2_I 
--#                           , u_OBUFT_SSTL2_II 
--#                           , u_OBUFT_SSTL3_I 
--#                           , u_OBUFT_SSTL3_II 
--#                           , u_OBUFT_S_12 
--#                           , u_OBUFT_S_16 
--#                           , u_OBUFT_S_2 
--#                           , u_OBUFT_S_24 
--#                           , u_OBUFT_S_4 
--#                           , u_OBUFT_S_6 
--#                           , u_OBUFT_S_8 
--#                           , u_OBUF_AGP 
--#                           , u_OBUF_CTT 
--#                           , u_OBUF_F_12 
--#                           , u_OBUF_F_16 
--#                           , u_OBUF_F_2 
--#                           , u_OBUF_F_24 
--#                           , u_OBUF_F_4 
--#                           , u_OBUF_F_6 
--#                           , u_OBUF_F_8 
--#                           , u_OBUF_GTL 
--#                           , u_OBUF_GTLP 
--#                           , u_OBUF_HSTL_I 
--#                           , u_OBUF_HSTL_III 
--#                           , u_OBUF_HSTL_IV 
--#                           , u_OBUF_LVCMOS2 
--#                           , u_OBUF_PCI33_3 
--#                           , u_OBUF_PCI33_5 
--#                           , u_OBUF_PCI66_3 
--#                           , u_OBUF_SSTL2_I 
--#                           , u_OBUF_SSTL2_II 
--#                           , u_OBUF_SSTL3_I 
--#                           , u_OBUF_SSTL3_II 
--#                           , u_OBUF_S_12 
--#                           , u_OBUF_S_16 
--#                           , u_OBUF_S_2 
--#                           , u_OBUF_S_24 
--#                           , u_OBUF_S_4 
--#                           , u_OBUF_S_6 
--#                           , u_OBUF_S_8 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAMB4_S1 
--#                           , u_RAMB4_S16 
--#                           , u_RAMB4_S16_S16 
--#                           , u_RAMB4_S1_S1 
--#                           , u_RAMB4_S1_S16 
--#                           , u_RAMB4_S1_S2 
--#                           , u_RAMB4_S1_S4 
--#                           , u_RAMB4_S1_S8 
--#                           , u_RAMB4_S2 
--#                           , u_RAMB4_S2_S16 
--#                           , u_RAMB4_S2_S2 
--#                           , u_RAMB4_S2_S4 
--#                           , u_RAMB4_S2_S8 
--#                           , u_RAMB4_S4 
--#                           , u_RAMB4_S4_S16 
--#                           , u_RAMB4_S4_S4 
--#                           , u_RAMB4_S4_S8 
--#                           , u_RAMB4_S8 
--#                           , u_RAMB4_S8_S16 
--#                           , u_RAMB4_S8_S8 
--#                           , u_ROM16X1 
--#                           , u_ROM32X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_STARTBUF_SPARTAN2 
--#                           , u_STARTUP_SPARTAN2 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       set_to(y, spartan2e, ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_SPARTAN2 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGDLL 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_SPARTAN2 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLE 
--#                           , u_CLKDLLHF 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFG 
--#                           , u_IBUFG_AGP 
--#                           , u_IBUFG_CTT 
--#                           , u_IBUFG_GTL 
--#                           , u_IBUFG_GTLP 
--#                           , u_IBUFG_HSTL_I 
--#                           , u_IBUFG_HSTL_III 
--#                           , u_IBUFG_HSTL_IV 
--#                           , u_IBUFG_LVCMOS18 
--#                           , u_IBUFG_LVCMOS2 
--#                           , u_IBUFG_LVDS 
--#                           , u_IBUFG_LVPECL 
--#                           , u_IBUFG_PCI33_3 
--#                           , u_IBUFG_PCI66_3 
--#                           , u_IBUFG_PCIX66_3 
--#                           , u_IBUFG_SSTL2_I 
--#                           , u_IBUFG_SSTL2_II 
--#                           , u_IBUFG_SSTL3_I 
--#                           , u_IBUFG_SSTL3_II 
--#                           , u_IBUF_AGP 
--#                           , u_IBUF_CTT 
--#                           , u_IBUF_GTL 
--#                           , u_IBUF_GTLP 
--#                           , u_IBUF_HSTL_I 
--#                           , u_IBUF_HSTL_III 
--#                           , u_IBUF_HSTL_IV 
--#                           , u_IBUF_LVCMOS18 
--#                           , u_IBUF_LVCMOS2 
--#                           , u_IBUF_LVDS 
--#                           , u_IBUF_LVPECL 
--#                           , u_IBUF_PCI33_3 
--#                           , u_IBUF_PCI66_3 
--#                           , u_IBUF_PCIX66_3 
--#                           , u_IBUF_SSTL2_I 
--#                           , u_IBUF_SSTL2_II 
--#                           , u_IBUF_SSTL3_I 
--#                           , u_IBUF_SSTL3_II 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUF_AGP 
--#                           , u_IOBUF_CTT 
--#                           , u_IOBUF_F_12 
--#                           , u_IOBUF_F_16 
--#                           , u_IOBUF_F_2 
--#                           , u_IOBUF_F_24 
--#                           , u_IOBUF_F_4 
--#                           , u_IOBUF_F_6 
--#                           , u_IOBUF_F_8 
--#                           , u_IOBUF_GTL 
--#                           , u_IOBUF_GTLP 
--#                           , u_IOBUF_HSTL_I 
--#                           , u_IOBUF_HSTL_III 
--#                           , u_IOBUF_HSTL_IV 
--#                           , u_IOBUF_LVCMOS18 
--#                           , u_IOBUF_LVCMOS2 
--#                           , u_IOBUF_LVDS 
--#                           , u_IOBUF_LVPECL 
--#                           , u_IOBUF_PCI33_3 
--#                           , u_IOBUF_PCI66_3 
--#                           , u_IOBUF_PCIX66_3 
--#                           , u_IOBUF_SSTL2_I 
--#                           , u_IOBUF_SSTL2_II 
--#                           , u_IOBUF_SSTL3_I 
--#                           , u_IOBUF_SSTL3_II 
--#                           , u_IOBUF_S_12 
--#                           , u_IOBUF_S_16 
--#                           , u_IOBUF_S_2 
--#                           , u_IOBUF_S_24 
--#                           , u_IOBUF_S_4 
--#                           , u_IOBUF_S_6 
--#                           , u_IOBUF_S_8 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFT 
--#                           , u_OBUFT_AGP 
--#                           , u_OBUFT_CTT 
--#                           , u_OBUFT_F_12 
--#                           , u_OBUFT_F_16 
--#                           , u_OBUFT_F_2 
--#                           , u_OBUFT_F_24 
--#                           , u_OBUFT_F_4 
--#                           , u_OBUFT_F_6 
--#                           , u_OBUFT_F_8 
--#                           , u_OBUFT_GTL 
--#                           , u_OBUFT_GTLP 
--#                           , u_OBUFT_HSTL_I 
--#                           , u_OBUFT_HSTL_III 
--#                           , u_OBUFT_HSTL_IV 
--#                           , u_OBUFT_LVCMOS18 
--#                           , u_OBUFT_LVCMOS2 
--#                           , u_OBUFT_LVDS 
--#                           , u_OBUFT_LVPECL 
--#                           , u_OBUFT_PCI33_3 
--#                           , u_OBUFT_PCI66_3 
--#                           , u_OBUFT_PCIX66_3 
--#                           , u_OBUFT_SSTL2_I 
--#                           , u_OBUFT_SSTL2_II 
--#                           , u_OBUFT_SSTL3_I 
--#                           , u_OBUFT_SSTL3_II 
--#                           , u_OBUFT_S_12 
--#                           , u_OBUFT_S_16 
--#                           , u_OBUFT_S_2 
--#                           , u_OBUFT_S_24 
--#                           , u_OBUFT_S_4 
--#                           , u_OBUFT_S_6 
--#                           , u_OBUFT_S_8 
--#                           , u_OBUF_AGP 
--#                           , u_OBUF_CTT 
--#                           , u_OBUF_F_12 
--#                           , u_OBUF_F_16 
--#                           , u_OBUF_F_2 
--#                           , u_OBUF_F_24 
--#                           , u_OBUF_F_4 
--#                           , u_OBUF_F_6 
--#                           , u_OBUF_F_8 
--#                           , u_OBUF_GTL 
--#                           , u_OBUF_GTLP 
--#                           , u_OBUF_HSTL_I 
--#                           , u_OBUF_HSTL_III 
--#                           , u_OBUF_HSTL_IV 
--#                           , u_OBUF_LVCMOS18 
--#                           , u_OBUF_LVCMOS2 
--#                           , u_OBUF_LVDS 
--#                           , u_OBUF_LVPECL 
--#                           , u_OBUF_PCI33_3 
--#                           , u_OBUF_PCI66_3 
--#                           , u_OBUF_PCIX66_3 
--#                           , u_OBUF_SSTL2_I 
--#                           , u_OBUF_SSTL2_II 
--#                           , u_OBUF_SSTL3_I 
--#                           , u_OBUF_SSTL3_II 
--#                           , u_OBUF_S_12 
--#                           , u_OBUF_S_16 
--#                           , u_OBUF_S_2 
--#                           , u_OBUF_S_24 
--#                           , u_OBUF_S_4 
--#                           , u_OBUF_S_6 
--#                           , u_OBUF_S_8 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAMB4_S1 
--#                           , u_RAMB4_S16 
--#                           , u_RAMB4_S16_S16 
--#                           , u_RAMB4_S1_S1 
--#                           , u_RAMB4_S1_S16 
--#                           , u_RAMB4_S1_S2 
--#                           , u_RAMB4_S1_S4 
--#                           , u_RAMB4_S1_S8 
--#                           , u_RAMB4_S2 
--#                           , u_RAMB4_S2_S16 
--#                           , u_RAMB4_S2_S2 
--#                           , u_RAMB4_S2_S4 
--#                           , u_RAMB4_S2_S8 
--#                           , u_RAMB4_S4 
--#                           , u_RAMB4_S4_S16 
--#                           , u_RAMB4_S4_S4 
--#                           , u_RAMB4_S4_S8 
--#                           , u_RAMB4_S8 
--#                           , u_RAMB4_S8_S16 
--#                           , u_RAMB4_S8_S8 
--#                           , u_ROM16X1 
--#                           , u_ROM32X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_STARTBUF_SPARTAN2 
--#                           , u_STARTUP_SPARTAN2 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       set_to(y, virtexe, ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGDLL 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_VIRTEX 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLE 
--#                           , u_CLKDLLHF 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFG 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFT 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAMB4_S1 
--#                           , u_RAMB4_S16 
--#                           , u_RAMB4_S16_S16 
--#                           , u_RAMB4_S1_S1 
--#                           , u_RAMB4_S1_S16 
--#                           , u_RAMB4_S1_S2 
--#                           , u_RAMB4_S1_S4 
--#                           , u_RAMB4_S1_S8 
--#                           , u_RAMB4_S2 
--#                           , u_RAMB4_S2_S16 
--#                           , u_RAMB4_S2_S2 
--#                           , u_RAMB4_S2_S4 
--#                           , u_RAMB4_S2_S8 
--#                           , u_RAMB4_S4 
--#                           , u_RAMB4_S4_S16 
--#                           , u_RAMB4_S4_S4 
--#                           , u_RAMB4_S4_S8 
--#                           , u_RAMB4_S8 
--#                           , u_RAMB4_S8_S16 
--#                           , u_RAMB4_S8_S8 
--#                           , u_ROM16X1 
--#                           , u_ROM32X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_STARTBUF_VIRTEX 
--#                           , u_STARTUP_VIRTEX 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#               ); 
--#       -- 
--#       set_to(y, virtex2, ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX2 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGDLL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_VIRTEX2 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLE 
--#                           , u_CLKDLLHF 
--#                           , u_DCM 
--#                           , u_DUMMY_INV 
--#                           , u_DUMMY_NOR2 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDDRCPE 
--#                           , u_FDDRRSE 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_ICAP_VIRTEX2 
--#                           , u_IFDDRCPE 
--#                           , u_IFDDRRSE 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_OFDDRCPE 
--#                           , u_OFDDRRSE 
--#                           , u_OFDDRTCPE 
--#                           , u_OFDDRTRSE 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_ORCY 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM128X1S 
--#                           , u_RAM128X1S_1 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM16X8S 
--#                           , u_RAM32X1D 
--#                           , u_RAM32X1D_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM32X4S 
--#                           , u_RAM32X8S 
--#                           , u_RAM64X1D 
--#                           , u_RAM64X1D_1 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAM64X2S 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_STARTBUF_VIRTEX2 
--#                           , u_STARTUP_VIRTEX2 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       pp(qvirtex2)   := pp(virtex2); 
--#       -- 
--#       pp(qrvirtex2)  := pp(virtex2); 
--#       -- 
--#       set_to(y, virtex2p, 
--#                          ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX2 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFE 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGDLL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGP 
--#                           , u_BUFT 
--#                           , u_CAPTURE_VIRTEX2 
--#                           , u_CLKDLL 
--#                           , u_CLKDLLE 
--#                           , u_CLKDLLHF 
--#                           , u_DCM 
--#                           , u_DUMMY_INV 
--#                           , u_DUMMY_NOR2 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDDRCPE 
--#                           , u_FDDRRSE 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_GT10_10GE_4 
--#                           , u_GT10_10GE_8 
--#                           , u_GT10_10GFC_4 
--#                           , u_GT10_10GFC_8 
--#                           , u_GT10_AURORAX_4 
--#                           , u_GT10_AURORAX_8 
--#                           , u_GT10_AURORA_1 
--#                           , u_GT10_AURORA_2 
--#                           , u_GT10_AURORA_4 
--#                           , u_GT10_CUSTOM 
--#                           , u_GT10_INFINIBAND_1 
--#                           , u_GT10_INFINIBAND_2 
--#                           , u_GT10_INFINIBAND_4 
--#                           , u_GT10_OC192_4 
--#                           , u_GT10_OC192_8 
--#                           , u_GT10_OC48_1 
--#                           , u_GT10_OC48_2 
--#                           , u_GT10_OC48_4 
--#                           , u_GT10_PCI_EXPRESS_1 
--#                           , u_GT10_PCI_EXPRESS_2 
--#                           , u_GT10_PCI_EXPRESS_4 
--#                           , u_GT10_XAUI_1 
--#                           , u_GT10_XAUI_2 
--#                           , u_GT10_XAUI_4 
--#                           , u_GT_AURORA_1 
--#                           , u_GT_AURORA_2 
--#                           , u_GT_AURORA_4 
--#                           , u_GT_CUSTOM 
--#                           , u_GT_ETHERNET_1 
--#                           , u_GT_ETHERNET_2 
--#                           , u_GT_ETHERNET_4 
--#                           , u_GT_FIBRE_CHAN_1 
--#                           , u_GT_FIBRE_CHAN_2 
--#                           , u_GT_FIBRE_CHAN_4 
--#                           , u_GT_INFINIBAND_1 
--#                           , u_GT_INFINIBAND_2 
--#                           , u_GT_INFINIBAND_4 
--#                           , u_GT_XAUI_1 
--#                           , u_GT_XAUI_2 
--#                           , u_GT_XAUI_4 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_ICAP_VIRTEX2 
--#                           , u_IFDDRCPE 
--#                           , u_IFDDRRSE 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_JTAGPPC 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_OFDDRCPE 
--#                           , u_OFDDRRSE 
--#                           , u_OFDDRTCPE 
--#                           , u_OFDDRTRSE 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_ORCY 
--#                           , u_PPC405 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM128X1S 
--#                           , u_RAM128X1S_1 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM16X8S 
--#                           , u_RAM32X1D 
--#                           , u_RAM32X1D_1 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM32X4S 
--#                           , u_RAM32X8S 
--#                           , u_RAM64X1D 
--#                           , u_RAM64X1D_1 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAM64X2S 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_STARTBUF_VIRTEX2 
--#                           , u_STARTUP_VIRTEX2 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       set_to(y, spartan3, 
--#                          ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_SPARTAN3 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGDLL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGP 
--#                           , u_CAPTURE_SPARTAN3 
--#                           , u_DCM 
--#                           , u_DUMMY_INV 
--#                           , u_DUMMY_NOR2 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDDRCPE 
--#                           , u_FDDRRSE 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_IFDDRCPE 
--#                           , u_IFDDRRSE 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_OFDDRCPE 
--#                           , u_OFDDRRSE 
--#                           , u_OFDDRTCPE 
--#                           , u_OFDDRTRSE 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_ORCY 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_STARTBUF_SPARTAN3 
--#                           , u_STARTUP_SPARTAN3 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       pp(aspartan3)   := pp(spartan3); 
--#       -- 
--#       set_to(y, spartan3e, 
--#                          ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_SPARTAN3 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGDLL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGP 
--#                           , u_CAPTURE_SPARTAN3E 
--#                           , u_DCM 
--#                           , u_DUMMY_INV 
--#                           , u_DUMMY_NOR2 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDDRCPE 
--#                           , u_FDDRRSE 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FMAP 
--#                           , u_GND 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_IDDR2 
--#                           , u_IFDDRCPE 
--#                           , u_IFDDRRSE 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT18X18SIO 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_ODDR2 
--#                           , u_OFDDRCPE 
--#                           , u_OFDDRRSE 
--#                           , u_OFDDRTCPE 
--#                           , u_OFDDRTRSE 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_ORCY 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_STARTBUF_SPARTAN3E 
--#                           , u_STARTUP_SPARTAN3E 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       pp(aspartan3e)   := pp(spartan3e); 
--#       -- 
--#       set_to(y, virtex4fx, 
--#                          ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX4 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGCTRL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGMUX_VIRTEX4 
--#                           , u_BUFGP 
--#                           , u_BUFGP 
--#                           , u_BUFIO 
--#                           , u_BUFR 
--#                           , u_CAPTURE_VIRTEX4 
--#                           , u_DCIRESET 
--#                           , u_DCM 
--#                           , u_DCM_ADV 
--#                           , u_DCM_BASE 
--#                           , u_DCM_PS 
--#                           , u_DSP48 
--#                           , u_EMAC 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FIFO16 
--#                           , u_FMAP 
--#                           , u_FRAME_ECC_VIRTEX4 
--#                           , u_GND 
--#                           , u_GT11CLK 
--#                           , u_GT11CLK_MGT 
--#                           , u_GT11_CUSTOM 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_ICAP_VIRTEX4 
--#                           , u_IDDR 
--#                           , u_IDELAY 
--#                           , u_IDELAYCTRL 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_ISERDES 
--#                           , u_JTAGPPC 
--#                           , u_KEEPER 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_ODDR 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_OSERDES 
--#                           , u_PMCD 
--#                           , u_PPC405 
--#                           , u_PPC405_ADV 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM16X8S 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM32X4S 
--#                           , u_RAM32X8S 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAM64X2S 
--#                           , u_RAMB16 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_RAMB32_S64_ECC 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_STARTBUF_VIRTEX4 
--#                           , u_STARTUP_VIRTEX4 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_USR_ACCESS_VIRTEX4 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       pp(virtex4sx) := pp(virtex4fx); 
--#       -- 
--#       pp(virtex4lx) := pp(virtex4fx); 
--#       set_to(n, virtex4lx, (u_EMAC, 
--#                              u_GT11CLK, u_GT11CLK_MGT, u_GT11_CUSTOM, 
--#                              u_JTAGPPC, u_PPC405, u_PPC405_ADV 
--#             )               ); 
--#       -- 
--#       pp(virtex4) := pp(virtex4lx); -- virtex4 is defined as the largest set 
--#                                      -- of primitives that EVERY virtex4 
--#                                      -- device supports, i.e.. a design that uses 
--#                                      -- the virtex4 subset of primitives 
--#                                      -- is compatible with any variant of 
--#                                      -- the virtex4 family. 
--#       -- 
--#       pp(qvirtex4) := pp(virtex4); 
--#       -- 
--#       pp(qrvirtex4) := pp(virtex4); 
--#       -- 
--#       set_to(y, virtex5, 
--#                          ( 
--#                             u_AND2 
--#                           , u_AND3 
--#                           , u_AND4 
--#                           , u_BSCAN_VIRTEX5 
--#                           , u_BUF 
--#                           , u_BUFCF 
--#                           , u_BUFG 
--#                           , u_BUFGCE 
--#                           , u_BUFGCE_1 
--#                           , u_BUFGCTRL 
--#                           , u_BUFGMUX 
--#                           , u_BUFGMUX_1 
--#                           , u_BUFGMUX_CTRL 
--#                           , u_BUFGP 
--#                           , u_BUFIO 
--#                           , u_BUFR 
--#                           , u_CAPTURE_VIRTEX5 
--#                           , u_CARRY4 
--#                           , u_CFGLUT5 
--#                           , u_CRC32 
--#                           , u_CRC64 
--#                           , u_DCIRESET 
--#                           , u_DCM 
--#                           , u_DCM_ADV 
--#                           , u_DCM_BASE 
--#                           , u_DCM_PS 
--#                           , u_DSP48 
--#                           , u_DSP48E 
--#                           , u_EMAC 
--#                           , u_FD 
--#                           , u_FDC 
--#                           , u_FDCE 
--#                           , u_FDCE_1 
--#                           , u_FDCP 
--#                           , u_FDCPE 
--#                           , u_FDCPE_1 
--#                           , u_FDCP_1 
--#                           , u_FDC_1 
--#                           , u_FDDRCPE 
--#                           , u_FDDRRSE 
--#                           , u_FDE 
--#                           , u_FDE_1 
--#                           , u_FDP 
--#                           , u_FDPE 
--#                           , u_FDPE_1 
--#                           , u_FDP_1 
--#                           , u_FDR 
--#                           , u_FDRE 
--#                           , u_FDRE_1 
--#                           , u_FDRS 
--#                           , u_FDRSE 
--#                           , u_FDRSE_1 
--#                           , u_FDRS_1 
--#                           , u_FDR_1 
--#                           , u_FDS 
--#                           , u_FDSE 
--#                           , u_FDSE_1 
--#                           , u_FDS_1 
--#                           , u_FD_1 
--#                           , u_FIFO16 
--#                           , u_FIFO18 
--#                           , u_FIFO18_36 
--#                           , u_FIFO36 
--#                           , u_FIFO36_72 
--#                           , u_FMAP 
--#                           , u_FRAME_ECC_VIRTEX5 
--#                           , u_GND 
--#                           , u_GT11CLK 
--#                           , u_GT11CLK_MGT 
--#                           , u_GT11_CUSTOM 
--#                           , u_IBUF 
--#                           , u_IBUFDS 
--#                           , u_IBUFDS_DIFF_OUT 
--#                           , u_IBUFG 
--#                           , u_IBUFGDS 
--#                           , u_IBUFGDS_DIFF_OUT 
--#                           , u_ICAP_VIRTEX5 
--#                           , u_IDDR 
--#                           , u_IDDR_2CLK 
--#                           , u_IDELAY 
--#                           , u_IDELAYCTRL 
--#                           , u_IFDDRCPE 
--#                           , u_IFDDRRSE 
--#                           , u_INV 
--#                           , u_IOBUF 
--#                           , u_IOBUFDS 
--#                           , u_IODELAY 
--#                           , u_ISERDES 
--#                           , u_ISERDES_NODELAY 
--#                           , u_KEEPER 
--#                           , u_KEY_CLEAR 
--#                           , u_LD 
--#                           , u_LDC 
--#                           , u_LDCE 
--#                           , u_LDCE_1 
--#                           , u_LDCP 
--#                           , u_LDCPE 
--#                           , u_LDCPE_1 
--#                           , u_LDCP_1 
--#                           , u_LDC_1 
--#                           , u_LDE 
--#                           , u_LDE_1 
--#                           , u_LDP 
--#                           , u_LDPE 
--#                           , u_LDPE_1 
--#                           , u_LDP_1 
--#                           , u_LD_1 
--#                           , u_LUT1 
--#                           , u_LUT1_D 
--#                           , u_LUT1_L 
--#                           , u_LUT2 
--#                           , u_LUT2_D 
--#                           , u_LUT2_L 
--#                           , u_LUT3 
--#                           , u_LUT3_D 
--#                           , u_LUT3_L 
--#                           , u_LUT4 
--#                           , u_LUT4_D 
--#                           , u_LUT4_L 
--#                           , u_LUT5 
--#                           , u_LUT5_D 
--#                           , u_LUT5_L 
--#                           , u_LUT6 
--#                           , u_LUT6_D 
--#                           , u_LUT6_L 
--#                           , u_MULT18X18 
--#                           , u_MULT18X18S 
--#                           , u_MULT_AND 
--#                           , u_MUXCY 
--#                           , u_MUXCY_D 
--#                           , u_MUXCY_L 
--#                           , u_MUXF5 
--#                           , u_MUXF5_D 
--#                           , u_MUXF5_L 
--#                           , u_MUXF6 
--#                           , u_MUXF6_D 
--#                           , u_MUXF6_L 
--#                           , u_MUXF7 
--#                           , u_MUXF7_D 
--#                           , u_MUXF7_L 
--#                           , u_MUXF8 
--#                           , u_MUXF8_D 
--#                           , u_MUXF8_L 
--#                           , u_NAND2 
--#                           , u_NAND3 
--#                           , u_NAND4 
--#                           , u_NOR2 
--#                           , u_NOR3 
--#                           , u_NOR4 
--#                           , u_OBUF 
--#                           , u_OBUFDS 
--#                           , u_OBUFT 
--#                           , u_OBUFTDS 
--#                           , u_ODDR 
--#                           , u_OFDDRCPE 
--#                           , u_OFDDRRSE 
--#                           , u_OFDDRTCPE 
--#                           , u_OFDDRTRSE 
--#                           , u_OR2 
--#                           , u_OR3 
--#                           , u_OR4 
--#                           , u_OSERDES 
--#                           , u_PLL_ADV 
--#                           , u_PLL_BASE 
--#                           , u_PMCD 
--#                           , u_PULLDOWN 
--#                           , u_PULLUP 
--#                           , u_RAM128X1D 
--#                           , u_RAM128X1S 
--#                           , u_RAM16X1D 
--#                           , u_RAM16X1D_1 
--#                           , u_RAM16X1S 
--#                           , u_RAM16X1S_1 
--#                           , u_RAM16X2S 
--#                           , u_RAM16X4S 
--#                           , u_RAM16X8S 
--#                           , u_RAM256X1S 
--#                           , u_RAM32M 
--#                           , u_RAM32X1S 
--#                           , u_RAM32X1S_1 
--#                           , u_RAM32X2S 
--#                           , u_RAM32X4S 
--#                           , u_RAM32X8S 
--#                           , u_RAM64M 
--#                           , u_RAM64X1D 
--#                           , u_RAM64X1S 
--#                           , u_RAM64X1S_1 
--#                           , u_RAM64X2S 
--#                           , u_RAMB16 
--#                           , u_RAMB16_S1 
--#                           , u_RAMB16_S18 
--#                           , u_RAMB16_S18_S18 
--#                           , u_RAMB16_S18_S36 
--#                           , u_RAMB16_S1_S1 
--#                           , u_RAMB16_S1_S18 
--#                           , u_RAMB16_S1_S2 
--#                           , u_RAMB16_S1_S36 
--#                           , u_RAMB16_S1_S4 
--#                           , u_RAMB16_S1_S9 
--#                           , u_RAMB16_S2 
--#                           , u_RAMB16_S2_S18 
--#                           , u_RAMB16_S2_S2 
--#                           , u_RAMB16_S2_S36 
--#                           , u_RAMB16_S2_S4 
--#                           , u_RAMB16_S2_S9 
--#                           , u_RAMB16_S36 
--#                           , u_RAMB16_S36_S36 
--#                           , u_RAMB16_S4 
--#                           , u_RAMB16_S4_S18 
--#                           , u_RAMB16_S4_S36 
--#                           , u_RAMB16_S4_S4 
--#                           , u_RAMB16_S4_S9 
--#                           , u_RAMB16_S9 
--#                           , u_RAMB16_S9_S18 
--#                           , u_RAMB16_S9_S36 
--#                           , u_RAMB16_S9_S9 
--#                           , u_RAMB18 
--#                           , u_RAMB18SDP 
--#                           , u_RAMB32_S64_ECC 
--#                           , u_RAMB36 
--#                           , u_RAMB36SDP 
--#                           , u_RAMB36SDP_EXP 
--#                           , u_RAMB36_EXP 
--#                           , u_ROM128X1 
--#                           , u_ROM16X1 
--#                           , u_ROM256X1 
--#                           , u_ROM32X1 
--#                           , u_ROM64X1 
--#                           , u_SRL16 
--#                           , u_SRL16E 
--#                           , u_SRL16E_1 
--#                           , u_SRL16_1 
--#                           , u_SRLC16 
--#                           , u_SRLC16E 
--#                           , u_SRLC16E_1 
--#                           , u_SRLC16_1 
--#                           , u_SRLC32E 
--#                           , u_STARTUP_VIRTEX5 
--#                           , u_SYSMON 
--#                           , u_TOC 
--#                           , u_TOCBUF 
--#                           , u_USR_ACCESS_VIRTEX5 
--#                           , u_VCC 
--#                           , u_XNOR2 
--#                           , u_XNOR3 
--#                           , u_XNOR4 
--#                           , u_XOR2 
--#                           , u_XOR3 
--#                           , u_XOR4 
--#                           , u_XORCY 
--#                           , u_XORCY_D 
--#                           , u_XORCY_L 
--#                          ) 
--#             ); 
--#       -- 
--#       pp(spartan3a)  := pp(spartan3e); -- Populate spartan3a by taking 
--#                                        -- differences from spartan3e. 
--#       set_to(n, spartan3a, ( 
--#                              u_BSCAN_SPARTAN3 
--#                            , u_CAPTURE_SPARTAN3E 
--#                            , u_DUMMY_INV 
--#                            , u_DUMMY_NOR2 
--#                            , u_STARTBUF_SPARTAN3E 
--#                            , u_STARTUP_SPARTAN3E 
--#             )              ); 
--#       set_to(y, spartan3a, ( 
--#                              u_BSCAN_SPARTAN3A 
--#                            , u_CAPTURE_SPARTAN3A 
--#                            , u_DCM_PS 
--#                            , u_DNA_PORT 
--#                            , u_IBUF_DLY_ADJ 
--#                            , u_IBUFDS_DLY_ADJ 
--#                            , u_ICAP_SPARTAN3A 
--#                            , u_RAMB16BWE 
--#                            , u_RAMB16BWE_S18 
--#                            , u_RAMB16BWE_S18_S18 
--#                            , u_RAMB16BWE_S18_S9 
--#                            , u_RAMB16BWE_S36 
--#                            , u_RAMB16BWE_S36_S18 
--#                            , u_RAMB16BWE_S36_S36 
--#                            , u_RAMB16BWE_S36_S9 
--#                            , u_SPI_ACCESS 
--#                            , u_STARTUP_SPARTAN3A 
--#             )              ); 
--#
--#       -- 
--#       pp(aspartan3a)   := pp(spartan3a); 
--#       -- 
--#       pp(spartan3an) := pp(spartan3a); 
--#       -- 
--#       pp(spartan3adsp) := pp(spartan3a); 
--#       set_to(y, spartan3adsp, ( 
--#                                 u_DSP48A 
--#                               , u_RAMB16BWER 
--#             )                 ); 
--#       -- 
--#       pp(aspartan3adsp) := pp(spartan3adsp); 
--#       -- 
--#       set_to(y, spartan6,  ( 
--#                              u_AND2 
--#                            , u_AND2B1L 
--#                            , u_AND3 
--#                            , u_AND4 
--#                            , u_AUTOBUF 
--#                            , u_BSCAN_SPARTAN6 
--#                            , u_BUF 
--#                            , u_BUFCF 
--#                            , u_BUFG 
--#                            , u_BUFGCE 
--#                            , u_BUFGCE_1 
--#                            , u_BUFGDLL 
--#                            , u_BUFGMUX 
--#                            , u_BUFGMUX 
--#                            , u_BUFGMUX_1 
--#                            , u_BUFGMUX_1 
--#                            , u_BUFGP 
--#                            , u_BUFH 
--#                            , u_BUFIO2 
--#                            , u_BUFIO2_2CLK 
--#                            , u_BUFIO2FB 
--#                            , u_BUFIO2FB_2CLK 
--#                            , u_BUFPLL 
--#                            , u_BUFPLL_MCB 
--#                            , u_CAPTURE_SPARTAN3A 
--#                            , u_DCM 
--#                            , u_DCM_CLKGEN 
--#                            , u_DCM_PS 
--#                            , u_DNA_PORT 
--#                            , u_DSP48A1 
--#                            , u_FD 
--#                            , u_FD_1 
--#                            , u_FDC 
--#                            , u_FDC_1 
--#                            , u_FDCE 
--#                            , u_FDCE_1 
--#                            , u_FDCP 
--#                            , u_FDCP_1 
--#                            , u_FDCPE 
--#                            , u_FDCPE_1 
--#                            , u_FDDRCPE 
--#                            , u_FDDRRSE 
--#                            , u_FDE 
--#                            , u_FDE_1 
--#                            , u_FDP 
--#                            , u_FDP_1 
--#                            , u_FDPE 
--#                            , u_FDPE_1 
--#                            , u_FDR 
--#                            , u_FDR_1 
--#                            , u_FDRE 
--#                            , u_FDRE_1 
--#                            , u_FDRS 
--#                            , u_FDRS_1 
--#                            , u_FDRSE 
--#                            , u_FDRSE_1 
--#                            , u_FDS 
--#                            , u_FDS_1 
--#                            , u_FDSE 
--#                            , u_FDSE_1 
--#                            , u_FMAP 
--#                            , u_GND 
--#                            , u_GTPA1_DUAL 
--#                            , u_IBUF 
--#                            , u_IBUF_DLY_ADJ 
--#                            , u_IBUFDS 
--#                            , u_IBUFDS_DIFF_OUT 
--#                            , u_IBUFDS_DLY_ADJ 
--#                            , u_IBUFG 
--#                            , u_IBUFGDS 
--#                            , u_IBUFGDS_DIFF_OUT 
--#                            , u_ICAP_SPARTAN3A 
--#                            , u_ICAP_SPARTAN6 
--#                            , u_IDDR2 
--#                            , u_IFDDRCPE 
--#                            , u_IFDDRRSE 
--#                            , u_INV 
--#                            , u_IOBUF 
--#                            , u_IOBUFDS 
--#                            , u_IODELAY2 
--#                            , u_IODRP2 
--#                            , u_IODRP2_MCB 
--#                            , u_ISERDES2 
--#                            , u_JTAG_SIM_SPARTAN6 
--#                            , u_KEEPER 
--#                            , u_LD 
--#                            , u_LD_1 
--#                            , u_LDC 
--#                            , u_LDC_1 
--#                            , u_LDCE 
--#                            , u_LDCE_1 
--#                            , u_LDCP 
--#                            , u_LDCP_1 
--#                            , u_LDCPE 
--#                            , u_LDCPE_1 
--#                            , u_LDE 
--#                            , u_LDE_1 
--#                            , u_LDP 
--#                            , u_LDP_1 
--#                            , u_LDPE 
--#                            , u_LDPE_1 
--#                            , u_LUT1 
--#                            , u_LUT1_D 
--#                            , u_LUT1_L 
--#                            , u_LUT2 
--#                            , u_LUT2_D 
--#                            , u_LUT2_L 
--#                            , u_LUT3 
--#                            , u_LUT3_D 
--#                            , u_LUT3_L 
--#                            , u_LUT4 
--#                            , u_LUT4_D 
--#                            , u_LUT4_L 
--#                            , u_LUT5 
--#                            , u_LUT5_D 
--#                            , u_LUT5_L 
--#                            , u_LUT6 
--#                            , u_LUT6_D 
--#                            , u_LUT6_L 
--#                            , u_MCB 
--#                            , u_MULT18X18 
--#                            , u_MULT18X18S 
--#                            , u_MULT18X18SIO 
--#                            , u_MULT_AND 
--#                            , u_MUXCY 
--#                            , u_MUXCY_D 
--#                            , u_MUXCY_L 
--#                            , u_MUXF5 
--#                            , u_MUXF5_D 
--#                            , u_MUXF5_L 
--#                            , u_MUXF6 
--#                            , u_MUXF6_D 
--#                            , u_MUXF6_L 
--#                            , u_MUXF7 
--#                            , u_MUXF7_D 
--#                            , u_MUXF7_L 
--#                            , u_MUXF8 
--#                            , u_MUXF8_D 
--#                            , u_MUXF8_L 
--#                            , u_NAND2 
--#                            , u_NAND3 
--#                            , u_NAND4 
--#                            , u_NOR2 
--#                            , u_NOR3 
--#                            , u_NOR4 
--#                            , u_OBUF 
--#                            , u_OBUFDS 
--#                            , u_OBUFT 
--#                            , u_OBUFTDS 
--#                            , u_OCT_CALIBRATE 
--#                            , u_ODDR2 
--#                            , u_OFDDRCPE 
--#                            , u_OFDDRRSE 
--#                            , u_OFDDRTCPE 
--#                            , u_OFDDRTRSE 
--#                            , u_OR2 
--#                            , u_OR2L 
--#                            , u_OR3 
--#                            , u_OR4 
--#                            , u_ORCY 
--#                            , u_OSERDES2 
--#                            , u_PCIE_A1 
--#                            , u_PLL_ADV 
--#                            , u_POST_CRC_INTERNAL 
--#                            , u_PULLDOWN 
--#                            , u_PULLUP 
--#                            , u_RAM16X1D 
--#                            , u_RAM16X1D_1 
--#                            , u_RAM16X1S 
--#                            , u_RAM16X1S_1 
--#                            , u_RAM16X2S 
--#                            , u_RAM16X4S 
--#                            , u_RAM32X1S 
--#                            , u_RAM32X1S_1 
--#                            , u_RAM32X2S 
--#                            , u_RAM64X1S 
--#                            , u_RAM64X1S_1 
--#                            , u_RAMB16BWE 
--#                            , u_RAMB16BWE_S18 
--#                            , u_RAMB16BWE_S18_S18 
--#                            , u_RAMB16BWE_S18_S9 
--#                            , u_RAMB16BWE_S36 
--#                            , u_RAMB16BWE_S36_S18 
--#                            , u_RAMB16BWE_S36_S36 
--#                            , u_RAMB16BWE_S36_S9 
--#                            , u_RAMB16_S1 
--#                            , u_RAMB16_S18 
--#                            , u_RAMB16_S18_S18 
--#                            , u_RAMB16_S18_S36 
--#                            , u_RAMB16_S1_S1 
--#                            , u_RAMB16_S1_S18 
--#                            , u_RAMB16_S1_S2 
--#                            , u_RAMB16_S1_S36 
--#                            , u_RAMB16_S1_S4 
--#                            , u_RAMB16_S1_S9 
--#                            , u_RAMB16_S2 
--#                            , u_RAMB16_S2_S18 
--#                            , u_RAMB16_S2_S2 
--#                            , u_RAMB16_S2_S36 
--#                            , u_RAMB16_S2_S4 
--#                            , u_RAMB16_S2_S9 
--#                            , u_RAMB16_S36 
--#                            , u_RAMB16_S36_S36 
--#                            , u_RAMB16_S4 
--#                            , u_RAMB16_S4_S18 
--#                            , u_RAMB16_S4_S36 
--#                            , u_RAMB16_S4_S4 
--#                            , u_RAMB16_S4_S9 
--#                            , u_RAMB16_S9 
--#                            , u_RAMB16_S9_S18 
--#                            , u_RAMB16_S9_S36 
--#                            , u_RAMB16_S9_S9 
--#                            , u_RAMB8BWER 
--#                            , u_ROM128X1 
--#                            , u_ROM16X1 
--#                            , u_ROM256X1 
--#                            , u_ROM32X1 
--#                            , u_ROM64X1 
--#                            , u_SLAVE_SPI 
--#                            , u_SPI_ACCESS 
--#                            , u_SRL16 
--#                            , u_SRL16_1 
--#                            , u_SRL16E 
--#                            , u_SRL16E_1 
--#                            , u_SRLC16 
--#                            , u_SRLC16_1 
--#                            , u_SRLC16E 
--#                            , u_SRLC16E_1 
--#                            , u_SRLC32E 
--#                            , u_STARTUP_SPARTAN3A 
--#                            , u_STARTUP_SPARTAN6 
--#                            , u_SUSPEND_SYNC 
--#                            , u_TOC 
--#                            , u_TOCBUF 
--#                            , u_VCC 
--#                            , u_XNOR2 
--#                            , u_XNOR3 
--#                            , u_XNOR4 
--#                            , u_XOR2 
--#                            , u_XOR3 
--#                            , u_XOR4 
--#                            , u_XORCY 
--#                            , u_XORCY_D 
--#                            , u_XORCY_L 
--#             )              ); 
--#       -- 
--#       -- 
--#       set_to(y, virtex6,   ( 
--#                              u_AND2 
--#                            , u_AND2B1L 
--#                            , u_AND3 
--#                            , u_AND4 
--#                            , u_AUTOBUF 
--#                            , u_BSCAN_VIRTEX6 
--#                            , u_BUF 
--#                            , u_BUFCF 
--#                            , u_BUFG 
--#                            , u_BUFGCE 
--#                            , u_BUFGCE_1 
--#                            , u_BUFGCTRL 
--#                            , u_BUFGMUX 
--#                            , u_BUFGMUX_1 
--#                            , u_BUFGMUX_CTRL 
--#                            , u_BUFGP 
--#                            , u_BUFH 
--#                            , u_BUFHCE 
--#                            , u_BUFIO 
--#                            , u_BUFIODQS 
--#                            , u_BUFR 
--#                            , u_CAPTURE_VIRTEX5 
--#                            , u_CAPTURE_VIRTEX6 
--#                            , u_CARRY4 
--#                            , u_CFGLUT5 
--#                            , u_CRC32 
--#                            , u_CRC64 
--#                            , u_DCIRESET 
--#                            , u_DCIRESET 
--#                            , u_DCM 
--#                            , u_DCM_ADV 
--#                            , u_DCM_BASE 
--#                            , u_DCM_PS 
--#                            , u_DSP48 
--#                            , u_DSP48E 
--#                            , u_DSP48E1 
--#                            , u_EFUSE_USR 
--#                            , u_EMAC 
--#                            , u_FD 
--#                            , u_FD_1 
--#                            , u_FDC 
--#                            , u_FDC_1 
--#                            , u_FDCE 
--#                            , u_FDCE_1 
--#                            , u_FDCP 
--#                            , u_FDCP_1 
--#                            , u_FDCPE 
--#                            , u_FDCPE_1 
--#                            , u_FDDRCPE 
--#                            , u_FDDRRSE 
--#                            , u_FDE 
--#                            , u_FDE_1 
--#                            , u_FDP 
--#                            , u_FDP_1 
--#                            , u_FDPE 
--#                            , u_FDPE_1 
--#                            , u_FDR 
--#                            , u_FDR_1 
--#                            , u_FDRE 
--#                            , u_FDRE_1 
--#                            , u_FDRS 
--#                            , u_FDRS_1 
--#                            , u_FDRSE 
--#                            , u_FDRSE_1 
--#                            , u_FDS 
--#                            , u_FDS_1 
--#                            , u_FDSE 
--#                            , u_FDSE_1 
--#                            , u_FIFO16 
--#                            , u_FIFO18 
--#                            , u_FIFO18_36 
--#                            , u_FIFO18E1 
--#                            , u_FIFO36 
--#                            , u_FIFO36_72 
--#                            , u_FIFO36E1 
--#                            , u_FMAP 
--#                            , u_FRAME_ECC_VIRTEX5 
--#                            , u_FRAME_ECC_VIRTEX6 
--#                            , u_GND 
--#                            , u_GT11CLK 
--#                            , u_GT11CLK_MGT 
--#                            , u_GT11_CUSTOM 
--#                            , u_GTXE1 
--#                            , u_IBUF 
--#                            , u_IBUF 
--#                            , u_IBUFDS 
--#                            , u_IBUFDS 
--#                            , u_IBUFDS_DIFF_OUT 
--#                            , u_IBUFDS_GTXE1 
--#                            , u_IBUFG 
--#                            , u_IBUFG 
--#                            , u_IBUFGDS 
--#                            , u_IBUFGDS 
--#                            , u_IBUFGDS_DIFF_OUT 
--#                            , u_ICAP_VIRTEX5 
--#                            , u_ICAP_VIRTEX6 
--#                            , u_IDDR 
--#                            , u_IDDR_2CLK 
--#                            , u_IDELAY 
--#                            , u_IDELAYCTRL 
--#                            , u_IFDDRCPE 
--#                            , u_IFDDRRSE 
--#                            , u_INV 
--#                            , u_IOBUF 
--#                            , u_IOBUF 
--#                            , u_IOBUFDS 
--#                            , u_IOBUFDS 
--#                            , u_IOBUFDS_DIFF_OUT 
--#                            , u_IODELAY 
--#                            , u_IODELAYE1 
--#                            , u_ISERDES 
--#                            , u_ISERDESE1 
--#                            , u_ISERDES_NODELAY 
--#                            , u_JTAG_SIM_VIRTEX6 
--#                            , u_KEEPER 
--#                            , u_KEY_CLEAR 
--#                            , u_LD 
--#                            , u_LD_1 
--#                            , u_LDC 
--#                            , u_LDC_1 
--#                            , u_LDCE 
--#                            , u_LDCE_1 
--#                            , u_LDCP 
--#                            , u_LDCP_1 
--#                            , u_LDCPE 
--#                            , u_LDCPE_1 
--#                            , u_LDE 
--#                            , u_LDE_1 
--#                            , u_LDP 
--#                            , u_LDP_1 
--#                            , u_LDPE 
--#                            , u_LDPE_1 
--#                            , u_LUT1 
--#                            , u_LUT1_D 
--#                            , u_LUT1_L 
--#                            , u_LUT2 
--#                            , u_LUT2_D 
--#                            , u_LUT2_L 
--#                            , u_LUT3 
--#                            , u_LUT3_D 
--#                            , u_LUT3_L 
--#                            , u_LUT4 
--#                            , u_LUT4_D 
--#                            , u_LUT4_L 
--#                            , u_LUT5 
--#                            , u_LUT5_D 
--#                            , u_LUT5_L 
--#                            , u_LUT6 
--#                            , u_LUT6_D 
--#                            , u_LUT6_L 
--#                            , u_MMCM_ADV 
--#                            , u_MMCM_BASE 
--#                            , u_MULT18X18 
--#                            , u_MULT18X18S 
--#                            , u_MULT_AND 
--#                            , u_MUXCY 
--#                            , u_MUXCY_D 
--#                            , u_MUXCY_L 
--#                            , u_MUXF5 
--#                            , u_MUXF5_D 
--#                            , u_MUXF5_L 
--#                            , u_MUXF6 
--#                            , u_MUXF6_D 
--#                            , u_MUXF6_L 
--#                            , u_MUXF7 
--#                            , u_MUXF7_D 
--#                            , u_MUXF7_L 
--#                            , u_MUXF8 
--#                            , u_MUXF8_D 
--#                            , u_MUXF8_L 
--#                            , u_NAND2 
--#                            , u_NAND3 
--#                            , u_NAND4 
--#                            , u_NOR2 
--#                            , u_NOR3 
--#                            , u_NOR4 
--#                            , u_OBUF 
--#                            , u_OBUFDS 
--#                            , u_OBUFT 
--#                            , u_OBUFTDS 
--#                            , u_ODDR 
--#                            , u_OFDDRCPE 
--#                            , u_OFDDRRSE 
--#                            , u_OFDDRTCPE 
--#                            , u_OFDDRTRSE 
--#                            , u_OR2 
--#                            , u_OR2L 
--#                            , u_OR3 
--#                            , u_OR4 
--#                            , u_OSERDES 
--#                            , u_OSERDESE1 
--#                            , u_PCIE_2_0 
--#                            , u_PLL_ADV 
--#                            , u_PLL_BASE 
--#                            , u_PMCD 
--#                            , u_PPR_FRAME 
--#                            , u_PULLDOWN 
--#                            , u_PULLUP 
--#                            , u_RAM128X1D 
--#                            , u_RAM128X1S 
--#                            , u_RAM16X1D 
--#                            , u_RAM16X1D_1 
--#                            , u_RAM16X1S 
--#                            , u_RAM16X1S_1 
--#                            , u_RAM16X2S 
--#                            , u_RAM16X4S 
--#                            , u_RAM16X8S 
--#                            , u_RAM256X1S 
--#                            , u_RAM32M 
--#                            , u_RAM32X1S 
--#                            , u_RAM32X1S_1 
--#                            , u_RAM32X2S 
--#                            , u_RAM32X4S 
--#                            , u_RAM32X8S 
--#                            , u_RAM64M 
--#                            , u_RAM64X1D 
--#                            , u_RAM64X1S 
--#                            , u_RAM64X1S_1 
--#                            , u_RAM64X2S 
--#                            , u_RAMB16 
--#                            , u_RAMB16_S1 
--#                            , u_RAMB16_S18 
--#                            , u_RAMB16_S18_S18 
--#                            , u_RAMB16_S18_S36 
--#                            , u_RAMB16_S1_S1 
--#                            , u_RAMB16_S1_S18 
--#                            , u_RAMB16_S1_S2 
--#                            , u_RAMB16_S1_S36 
--#                            , u_RAMB16_S1_S4 
--#                            , u_RAMB16_S1_S9 
--#                            , u_RAMB16_S2 
--#                            , u_RAMB16_S2_S18 
--#                            , u_RAMB16_S2_S2 
--#                            , u_RAMB16_S2_S36 
--#                            , u_RAMB16_S2_S4 
--#                            , u_RAMB16_S2_S9 
--#                            , u_RAMB16_S36 
--#                            , u_RAMB16_S36_S36 
--#                            , u_RAMB16_S4 
--#                            , u_RAMB16_S4_S18 
--#                            , u_RAMB16_S4_S36 
--#                            , u_RAMB16_S4_S4 
--#                            , u_RAMB16_S4_S9 
--#                            , u_RAMB16_S9 
--#                            , u_RAMB16_S9_S18 
--#                            , u_RAMB16_S9_S36 
--#                            , u_RAMB16_S9_S9 
--#                            , u_RAMB18 
--#                            , u_RAMB18E1 
--#                            , u_RAMB18SDP 
--#                            , u_RAMB32_S64_ECC 
--#                            , u_RAMB36 
--#                            , u_RAMB36E1 
--#                            , u_RAMB36_EXP 
--#                            , u_RAMB36SDP 
--#                            , u_RAMB36SDP_EXP 
--#                            , u_ROM128X1 
--#                            , u_ROM16X1 
--#                            , u_ROM256X1 
--#                            , u_ROM32X1 
--#                            , u_ROM64X1 
--#                            , u_SRL16 
--#                            , u_SRL16_1 
--#                            , u_SRL16E 
--#                            , u_SRL16E_1 
--#                            , u_SRLC16 
--#                            , u_SRLC16_1 
--#                            , u_SRLC16E 
--#                            , u_SRLC16E_1 
--#                            , u_SRLC32E 
--#                            , u_STARTUP_VIRTEX5 
--#                            , u_STARTUP_VIRTEX6 
--#                            , u_SYSMON 
--#                            , u_SYSMON 
--#                            , u_TEMAC_SINGLE 
--#                            , u_TOC 
--#                            , u_TOCBUF 
--#                            , u_USR_ACCESS_VIRTEX5 
--#                            , u_USR_ACCESS_VIRTEX6 
--#                            , u_VCC 
--#                            , u_XNOR2 
--#                            , u_XNOR3 
--#                            , u_XNOR4 
--#                            , u_XOR2 
--#                            , u_XOR3 
--#                            , u_XOR4 
--#                            , u_XORCY 
--#                            , u_XORCY_D 
--#                            , u_XORCY_L 
--#             )              ); 
--#       -- 
--#       pp(spartan6l) := pp(spartan6); 
--#       -- 
--#       pp(qspartan6) := pp(spartan6); 
--#       -- 
--#       pp(aspartan6) := pp(spartan6); 
--#       -- 
--#       pp(virtex6l) := pp(virtex6); 
--#       -- 
--#       pp(qspartan6l) := pp(spartan6); 
--#       -- 
--#       pp(qvirtex5) := pp(virtex5); 
--#       -- 
--#       pp(qvirtex6) := pp(virtex6); 
--#       -- 
--#       pp(qrvirtex5) := pp(virtex5); 
--#       -- 
--#       pp(virtex5tx) := pp(virtex5); 
--#       -- 
--#       pp(virtex5fx) := pp(virtex5); 
--#       -- 
--#       pp(virtex6cx) := pp(virtex6); 
--#       -- 
--#       set_to(y, kintex7,   ( 
--#                              u_AND2
--#                            , u_AND2B1
--#                            , u_AND2B1L
--#                            , u_AND2B2
--#                            , u_AND3
--#                            , u_AND3B1
--#                            , u_AND3B2
--#                            , u_AND3B3
--#                            , u_AND4
--#                            , u_AND4B1
--#                            , u_AND4B2
--#                            , u_AND4B3
--#                            , u_AND4B4
--#                            , u_AND5
--#                            , u_AND5B1
--#                            , u_AND5B2
--#                            , u_AND5B3
--#                            , u_AND5B4
--#                            , u_AND5B5
--#                            , u_AUTOBUF
--#                            , u_BSCANE2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGCTRL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_BUFH
--#                            , u_BUFHCE
--#                            , u_BUFIO
--#                            , u_BUFMR
--#                            , u_BUFMRCE
--#                            , u_BUFR
--#                            , u_BUFT
--#                            , u_CAPTUREE2
--#                            , u_CARRY4
--#                            , u_CFGLUT5
--#                            , u_DCIRESET
--#                            , u_DNA_PORT
--#                            , u_DSP48E1
--#                            , u_EFUSE_USR
--#                            , u_FD
--#                            , u_FD_1
--#                            , u_FDC
--#                            , u_FDC_1
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCP_1
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDP_1
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDR
--#                            , u_FDR_1
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRS_1
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDS
--#                            , u_FDS_1
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FIFO18E1
--#                            , u_FIFO36E1
--#                            , u_FMAP
--#                            , u_FRAME_ECCE2
--#                            , u_GND
--#                            , u_GTXE2_CHANNEL
--#                            , u_GTXE2_COMMON
--#                            , u_IBUF
--#                            , u_IBUF_DCIEN
--#                            , u_IBUFDS
--#                            , u_IBUFDS_BLVDS_25
--#                            , u_IBUFDS_DCIEN
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFDS_DIFF_OUT_DCIEN
--#                            , u_IBUFDS_GTE2
--#                            , u_IBUFDS_LVDS_25
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_BLVDS_25
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_IBUFGDS_LVDS_25
--#                            , u_IBUFG_HSTL_I
--#                            , u_IBUFG_HSTL_I_18
--#                            , u_IBUFG_HSTL_I_DCI
--#                            , u_IBUFG_HSTL_I_DCI_18
--#                            , u_IBUFG_HSTL_II
--#                            , u_IBUFG_HSTL_II_18
--#                            , u_IBUFG_HSTL_II_DCI
--#                            , u_IBUFG_HSTL_II_DCI_18
--#                            , u_IBUFG_HSTL_III
--#                            , u_IBUFG_HSTL_III_18
--#                            , u_IBUFG_HSTL_III_DCI
--#                            , u_IBUFG_HSTL_III_DCI_18
--#                            , u_IBUFG_LVCMOS12
--#                            , u_IBUFG_LVCMOS15
--#                            , u_IBUFG_LVCMOS18
--#                            , u_IBUFG_LVCMOS25
--#                            , u_IBUFG_LVCMOS33
--#                            , u_IBUFG_LVDCI_15
--#                            , u_IBUFG_LVDCI_18
--#                            , u_IBUFG_LVDCI_DV2_15
--#                            , u_IBUFG_LVDCI_DV2_18
--#                            , u_IBUFG_LVDS
--#                            , u_IBUFG_LVPECL
--#                            , u_IBUFG_LVTTL
--#                            , u_IBUFG_PCI33_3
--#                            , u_IBUFG_PCI66_3
--#                            , u_IBUFG_PCIX66_3
--#                            , u_IBUFG_SSTL18_I
--#                            , u_IBUFG_SSTL18_I_DCI
--#                            , u_IBUFG_SSTL18_II
--#                            , u_IBUFG_SSTL18_II_DCI
--#                            , u_IBUF_HSTL_I
--#                            , u_IBUF_HSTL_I_18
--#                            , u_IBUF_HSTL_I_DCI
--#                            , u_IBUF_HSTL_I_DCI_18
--#                            , u_IBUF_HSTL_II
--#                            , u_IBUF_HSTL_II_18
--#                            , u_IBUF_HSTL_II_DCI
--#                            , u_IBUF_HSTL_II_DCI_18
--#                            , u_IBUF_HSTL_III
--#                            , u_IBUF_HSTL_III_18
--#                            , u_IBUF_HSTL_III_DCI
--#                            , u_IBUF_HSTL_III_DCI_18
--#                            , u_IBUF_LVCMOS12
--#                            , u_IBUF_LVCMOS15
--#                            , u_IBUF_LVCMOS18
--#                            , u_IBUF_LVCMOS25
--#                            , u_IBUF_LVCMOS33
--#                            , u_IBUF_LVDCI_15
--#                            , u_IBUF_LVDCI_18
--#                            , u_IBUF_LVDCI_DV2_15
--#                            , u_IBUF_LVDCI_DV2_18
--#                            , u_IBUF_LVDS
--#                            , u_IBUF_LVPECL
--#                            , u_IBUF_LVTTL
--#                            , u_IBUF_PCI33_3
--#                            , u_IBUF_PCI66_3
--#                            , u_IBUF_PCIX66_3
--#                            , u_IBUF_SSTL18_I
--#                            , u_IBUF_SSTL18_I_DCI
--#                            , u_IBUF_SSTL18_II
--#                            , u_IBUF_SSTL18_II_DCI
--#                            , u_ICAPE2
--#                            , u_IDDR
--#                            , u_IDDR_2CLK
--#                            , u_IDELAY
--#                            , u_IDELAYCTRL
--#                            , u_IDELAYE2
--#                            , u_IN_FIFO
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_IOBUFDS_BLVDS_25
--#                            , u_IOBUFDS_DIFF_OUT
--#                            , u_IOBUFDS_DIFF_OUT_DCIEN
--#                            , u_IOBUF_F_12
--#                            , u_IOBUF_F_16
--#                            , u_IOBUF_F_2
--#                            , u_IOBUF_F_24
--#                            , u_IOBUF_F_4
--#                            , u_IOBUF_F_6
--#                            , u_IOBUF_F_8
--#                            , u_IOBUF_HSTL_I
--#                            , u_IOBUF_HSTL_I_18
--#                            , u_IOBUF_HSTL_II
--#                            , u_IOBUF_HSTL_II_18
--#                            , u_IOBUF_HSTL_II_DCI
--#                            , u_IOBUF_HSTL_II_DCI_18
--#                            , u_IOBUF_HSTL_III
--#                            , u_IOBUF_HSTL_III_18
--#                            , u_IOBUF_LVCMOS12
--#                            , u_IOBUF_LVCMOS15
--#                            , u_IOBUF_LVCMOS18
--#                            , u_IOBUF_LVCMOS25
--#                            , u_IOBUF_LVCMOS33
--#                            , u_IOBUF_LVDCI_15
--#                            , u_IOBUF_LVDCI_18
--#                            , u_IOBUF_LVDCI_DV2_15
--#                            , u_IOBUF_LVDCI_DV2_18
--#                            , u_IOBUF_LVDS
--#                            , u_IOBUF_LVPECL
--#                            , u_IOBUF_LVTTL
--#                            , u_IOBUF_PCI33_3
--#                            , u_IOBUF_PCI66_3
--#                            , u_IOBUF_PCIX66_3
--#                            , u_IOBUF_S_12
--#                            , u_IOBUF_S_16
--#                            , u_IOBUF_S_2
--#                            , u_IOBUF_S_24
--#                            , u_IOBUF_S_4
--#                            , u_IOBUF_S_6
--#                            , u_IOBUF_S_8
--#                            , u_IOBUF_SSTL18_I
--#                            , u_IOBUF_SSTL18_II
--#                            , u_IOBUF_SSTL18_II_DCI
--#                            , u_IODELAY
--#                            , u_IODELAYE1
--#                            , u_ISERDESE2
--#                            , u_JTAG_SIME2
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LD_1
--#                            , u_LDC
--#                            , u_LDC_1
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCP_1
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDP_1
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_LUT5
--#                            , u_LUT5_D
--#                            , u_LUT5_L
--#                            , u_LUT6
--#                            , u_LUT6_2
--#                            , u_LUT6_D
--#                            , u_LUT6_L
--#                            , u_MMCME2_ADV
--#                            , u_MMCME2_BASE
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND2B1
--#                            , u_NAND2B2
--#                            , u_NAND3
--#                            , u_NAND3B1
--#                            , u_NAND3B2
--#                            , u_NAND3B3
--#                            , u_NAND4
--#                            , u_NAND4B1
--#                            , u_NAND4B2
--#                            , u_NAND4B3
--#                            , u_NAND4B4
--#                            , u_NAND5
--#                            , u_NAND5B1
--#                            , u_NAND5B2
--#                            , u_NAND5B3
--#                            , u_NAND5B4
--#                            , u_NAND5B5
--#                            , u_NOR2
--#                            , u_NOR2B1
--#                            , u_NOR2B2
--#                            , u_NOR3
--#                            , u_NOR3B1
--#                            , u_NOR3B2
--#                            , u_NOR3B3
--#                            , u_NOR4
--#                            , u_NOR4B1
--#                            , u_NOR4B2
--#                            , u_NOR4B3
--#                            , u_NOR4B4
--#                            , u_NOR5
--#                            , u_NOR5B1
--#                            , u_NOR5B2
--#                            , u_NOR5B3
--#                            , u_NOR5B4
--#                            , u_NOR5B5
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFDS_BLVDS_25
--#                            , u_OBUFDS_DUAL_BUF
--#                            , u_OBUFDS_LVDS_25
--#                            , u_OBUF_F_12
--#                            , u_OBUF_F_16
--#                            , u_OBUF_F_2
--#                            , u_OBUF_F_24
--#                            , u_OBUF_F_4
--#                            , u_OBUF_F_6
--#                            , u_OBUF_F_8
--#                            , u_OBUF_HSTL_I
--#                            , u_OBUF_HSTL_I_18
--#                            , u_OBUF_HSTL_I_DCI
--#                            , u_OBUF_HSTL_I_DCI_18
--#                            , u_OBUF_HSTL_II
--#                            , u_OBUF_HSTL_II_18
--#                            , u_OBUF_HSTL_II_DCI
--#                            , u_OBUF_HSTL_II_DCI_18
--#                            , u_OBUF_HSTL_III
--#                            , u_OBUF_HSTL_III_18
--#                            , u_OBUF_HSTL_III_DCI
--#                            , u_OBUF_HSTL_III_DCI_18
--#                            , u_OBUF_LVCMOS12
--#                            , u_OBUF_LVCMOS15
--#                            , u_OBUF_LVCMOS18
--#                            , u_OBUF_LVCMOS25
--#                            , u_OBUF_LVCMOS33
--#                            , u_OBUF_LVDCI_15
--#                            , u_OBUF_LVDCI_18
--#                            , u_OBUF_LVDCI_DV2_15
--#                            , u_OBUF_LVDCI_DV2_18
--#                            , u_OBUF_LVDS
--#                            , u_OBUF_LVPECL
--#                            , u_OBUF_LVTTL
--#                            , u_OBUF_PCI33_3
--#                            , u_OBUF_PCI66_3
--#                            , u_OBUF_PCIX66_3
--#                            , u_OBUF_S_12
--#                            , u_OBUF_S_16
--#                            , u_OBUF_S_2
--#                            , u_OBUF_S_24
--#                            , u_OBUF_S_4
--#                            , u_OBUF_S_6
--#                            , u_OBUF_S_8
--#                            , u_OBUF_SSTL18_I
--#                            , u_OBUF_SSTL18_I_DCI
--#                            , u_OBUF_SSTL18_II
--#                            , u_OBUF_SSTL18_II_DCI
--#                            , u_OBUFT
--#                            , u_OBUFT_DCIEN
--#                            , u_OBUFTDS
--#                            , u_OBUFTDS_BLVDS_25
--#                            , u_OBUFTDS_DCIEN
--#                            , u_OBUFTDS_DCIEN_DUAL_BUF
--#                            , u_OBUFTDS_DUAL_BUF
--#                            , u_OBUFTDS_LVDS_25
--#                            , u_OBUFT_F_12
--#                            , u_OBUFT_F_16
--#                            , u_OBUFT_F_2
--#                            , u_OBUFT_F_24
--#                            , u_OBUFT_F_4
--#                            , u_OBUFT_F_6
--#                            , u_OBUFT_F_8
--#                            , u_OBUFT_HSTL_I
--#                            , u_OBUFT_HSTL_I_18
--#                            , u_OBUFT_HSTL_I_DCI
--#                            , u_OBUFT_HSTL_I_DCI_18
--#                            , u_OBUFT_HSTL_II
--#                            , u_OBUFT_HSTL_II_18
--#                            , u_OBUFT_HSTL_II_DCI
--#                            , u_OBUFT_HSTL_II_DCI_18
--#                            , u_OBUFT_HSTL_III
--#                            , u_OBUFT_HSTL_III_18
--#                            , u_OBUFT_HSTL_III_DCI
--#                            , u_OBUFT_HSTL_III_DCI_18
--#                            , u_OBUFT_LVCMOS12
--#                            , u_OBUFT_LVCMOS15
--#                            , u_OBUFT_LVCMOS18
--#                            , u_OBUFT_LVCMOS25
--#                            , u_OBUFT_LVCMOS33
--#                            , u_OBUFT_LVDCI_15
--#                            , u_OBUFT_LVDCI_18
--#                            , u_OBUFT_LVDCI_DV2_15
--#                            , u_OBUFT_LVDCI_DV2_18
--#                            , u_OBUFT_LVDS
--#                            , u_OBUFT_LVPECL
--#                            , u_OBUFT_LVTTL
--#                            , u_OBUFT_PCI33_3
--#                            , u_OBUFT_PCI66_3
--#                            , u_OBUFT_PCIX66_3
--#                            , u_OBUFT_S_12
--#                            , u_OBUFT_S_16
--#                            , u_OBUFT_S_2
--#                            , u_OBUFT_S_24
--#                            , u_OBUFT_S_4
--#                            , u_OBUFT_S_6
--#                            , u_OBUFT_S_8
--#                            , u_OBUFT_SSTL18_I
--#                            , u_OBUFT_SSTL18_I_DCI
--#                            , u_OBUFT_SSTL18_II
--#                            , u_OBUFT_SSTL18_II_DCI
--#                            , u_ODDR
--#                            , u_ODELAYE2
--#                            , u_OR2
--#                            , u_OR2B1
--#                            , u_OR2B2
--#                            , u_OR2L
--#                            , u_OR3
--#                            , u_OR3B1
--#                            , u_OR3B2
--#                            , u_OR3B3
--#                            , u_OR4
--#                            , u_OR4B1
--#                            , u_OR4B2
--#                            , u_OR4B3
--#                            , u_OR4B4
--#                            , u_OR5
--#                            , u_OR5B1
--#                            , u_OR5B2
--#                            , u_OR5B3
--#                            , u_OR5B4
--#                            , u_OR5B5
--#                            , u_OSERDESE2
--#                            , u_OUT_FIFO
--#                            , u_PCIE_2_1
--#                            , u_PHASER_IN
--#                            , u_PHASER_IN_PHY
--#                            , u_PHASER_OUT
--#                            , u_PHASER_OUT_PHY
--#                            , u_PHASER_REF
--#                            , u_PHY_CONTROL
--#                            , u_PLLE2_ADV
--#                            , u_PLLE2_BASE
--#                            , u_PSS
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM128X1D
--#                            , u_RAM128X1S
--#                            , u_RAM128X1S_1
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM256X1S
--#                            , u_RAM32M
--#                            , u_RAM32X1D
--#                            , u_RAM32X1D_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64M
--#                            , u_RAM64X1D
--#                            , u_RAM64X1D_1
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB18E1
--#                            , u_RAMB36E1
--#                            , u_RAMD32
--#                            , u_RAMD64E
--#                            , u_RAMS32
--#                            , u_RAMS64E
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SIM_CONFIGE2
--#                            , u_SRL16
--#                            , u_SRL16_1
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRLC16
--#                            , u_SRLC16_1
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC32E
--#                            , u_STARTUPE2
--#                            , u_USR_ACCESSE2
--#                            , u_VCC
--#                            , u_XADC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XNOR5
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XOR5
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                            , u_ZHOLD_DELAY
--#             )              ); 
--#       -- 
--#       set_to(y, virtex7,   ( 
--#                              u_AND2
--#                            , u_AND2B1
--#                            , u_AND2B1L
--#                            , u_AND2B2
--#                            , u_AND3
--#                            , u_AND3B1
--#                            , u_AND3B2
--#                            , u_AND3B3
--#                            , u_AND4
--#                            , u_AND4B1
--#                            , u_AND4B2
--#                            , u_AND4B3
--#                            , u_AND4B4
--#                            , u_AND5
--#                            , u_AND5B1
--#                            , u_AND5B2
--#                            , u_AND5B3
--#                            , u_AND5B4
--#                            , u_AND5B5
--#                            , u_AUTOBUF
--#                            , u_BSCANE2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGCTRL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_BUFH
--#                            , u_BUFHCE
--#                            , u_BUFIO
--#                            , u_BUFMR
--#                            , u_BUFMRCE
--#                            , u_BUFR
--#                            , u_BUFT
--#                            , u_CAPTUREE2
--#                            , u_CARRY4
--#                            , u_CFG_IO_ACCESS
--#                            , u_CFGLUT5
--#                            , u_DCIRESET
--#                            , u_DNA_PORT
--#                            , u_DSP48E1
--#                            , u_EFUSE_USR
--#                            , u_FD
--#                            , u_FD_1
--#                            , u_FDC
--#                            , u_FDC_1
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCP_1
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDP_1
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDR
--#                            , u_FDR_1
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRS_1
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDS
--#                            , u_FDS_1
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FIFO18E1
--#                            , u_FIFO36E1
--#                            , u_FMAP
--#                            , u_FRAME_ECCE2
--#                            , u_GND
--#                            , u_GTXE2_CHANNEL
--#                            , u_GTXE2_COMMON
--#                            , u_IBUF
--#                            , u_IBUF_DCIEN
--#                            , u_IBUFDS
--#                            , u_IBUFDS_BLVDS_25
--#                            , u_IBUFDS_DCIEN
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFDS_DIFF_OUT_DCIEN
--#                            , u_IBUFDS_GTE2
--#                            , u_IBUFDS_LVDS_25
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_BLVDS_25
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_IBUFGDS_LVDS_25
--#                            , u_IBUFG_HSTL_I
--#                            , u_IBUFG_HSTL_I_18
--#                            , u_IBUFG_HSTL_I_DCI
--#                            , u_IBUFG_HSTL_I_DCI_18
--#                            , u_IBUFG_HSTL_II
--#                            , u_IBUFG_HSTL_II_18
--#                            , u_IBUFG_HSTL_II_DCI
--#                            , u_IBUFG_HSTL_II_DCI_18
--#                            , u_IBUFG_HSTL_III
--#                            , u_IBUFG_HSTL_III_18
--#                            , u_IBUFG_HSTL_III_DCI
--#                            , u_IBUFG_HSTL_III_DCI_18
--#                            , u_IBUFG_LVCMOS12
--#                            , u_IBUFG_LVCMOS15
--#                            , u_IBUFG_LVCMOS18
--#                            , u_IBUFG_LVCMOS25
--#                            , u_IBUFG_LVCMOS33
--#                            , u_IBUFG_LVDCI_15
--#                            , u_IBUFG_LVDCI_18
--#                            , u_IBUFG_LVDCI_DV2_15
--#                            , u_IBUFG_LVDCI_DV2_18
--#                            , u_IBUFG_LVDS
--#                            , u_IBUFG_LVPECL
--#                            , u_IBUFG_LVTTL
--#                            , u_IBUFG_PCI33_3
--#                            , u_IBUFG_PCI66_3
--#                            , u_IBUFG_PCIX66_3
--#                            , u_IBUFG_SSTL18_I
--#                            , u_IBUFG_SSTL18_I_DCI
--#                            , u_IBUFG_SSTL18_II
--#                            , u_IBUFG_SSTL18_II_DCI
--#                            , u_IBUF_HSTL_I
--#                            , u_IBUF_HSTL_I_18
--#                            , u_IBUF_HSTL_I_DCI
--#                            , u_IBUF_HSTL_I_DCI_18
--#                            , u_IBUF_HSTL_II
--#                            , u_IBUF_HSTL_II_18
--#                            , u_IBUF_HSTL_II_DCI
--#                            , u_IBUF_HSTL_II_DCI_18
--#                            , u_IBUF_HSTL_III
--#                            , u_IBUF_HSTL_III_18
--#                            , u_IBUF_HSTL_III_DCI
--#                            , u_IBUF_HSTL_III_DCI_18
--#                            , u_IBUF_LVCMOS12
--#                            , u_IBUF_LVCMOS15
--#                            , u_IBUF_LVCMOS18
--#                            , u_IBUF_LVCMOS25
--#                            , u_IBUF_LVCMOS33
--#                            , u_IBUF_LVDCI_15
--#                            , u_IBUF_LVDCI_18
--#                            , u_IBUF_LVDCI_DV2_15
--#                            , u_IBUF_LVDCI_DV2_18
--#                            , u_IBUF_LVDS
--#                            , u_IBUF_LVPECL
--#                            , u_IBUF_LVTTL
--#                            , u_IBUF_PCI33_3
--#                            , u_IBUF_PCI66_3
--#                            , u_IBUF_PCIX66_3
--#                            , u_IBUF_SSTL18_I
--#                            , u_IBUF_SSTL18_I_DCI
--#                            , u_IBUF_SSTL18_II
--#                            , u_IBUF_SSTL18_II_DCI
--#                            , u_ICAPE2
--#                            , u_IDDR
--#                            , u_IDDR_2CLK
--#                            , u_IDELAY
--#                            , u_IDELAYCTRL
--#                            , u_IDELAYE2
--#                            , u_IN_FIFO
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_IOBUFDS_BLVDS_25
--#                            , u_IOBUFDS_DIFF_OUT
--#                            , u_IOBUFDS_DIFF_OUT_DCIEN
--#                            , u_IOBUF_F_12
--#                            , u_IOBUF_F_16
--#                            , u_IOBUF_F_2
--#                            , u_IOBUF_F_24
--#                            , u_IOBUF_F_4
--#                            , u_IOBUF_F_6
--#                            , u_IOBUF_F_8
--#                            , u_IOBUF_HSTL_I
--#                            , u_IOBUF_HSTL_I_18
--#                            , u_IOBUF_HSTL_II
--#                            , u_IOBUF_HSTL_II_18
--#                            , u_IOBUF_HSTL_II_DCI
--#                            , u_IOBUF_HSTL_II_DCI_18
--#                            , u_IOBUF_HSTL_III
--#                            , u_IOBUF_HSTL_III_18
--#                            , u_IOBUF_LVCMOS12
--#                            , u_IOBUF_LVCMOS15
--#                            , u_IOBUF_LVCMOS18
--#                            , u_IOBUF_LVCMOS25
--#                            , u_IOBUF_LVCMOS33
--#                            , u_IOBUF_LVDCI_15
--#                            , u_IOBUF_LVDCI_18
--#                            , u_IOBUF_LVDCI_DV2_15
--#                            , u_IOBUF_LVDCI_DV2_18
--#                            , u_IOBUF_LVDS
--#                            , u_IOBUF_LVPECL
--#                            , u_IOBUF_LVTTL
--#                            , u_IOBUF_PCI33_3
--#                            , u_IOBUF_PCI66_3
--#                            , u_IOBUF_PCIX66_3
--#                            , u_IOBUF_S_12
--#                            , u_IOBUF_S_16
--#                            , u_IOBUF_S_2
--#                            , u_IOBUF_S_24
--#                            , u_IOBUF_S_4
--#                            , u_IOBUF_S_6
--#                            , u_IOBUF_S_8
--#                            , u_IOBUF_SSTL18_I
--#                            , u_IOBUF_SSTL18_II
--#                            , u_IOBUF_SSTL18_II_DCI
--#                            , u_IODELAY
--#                            , u_IODELAYE1
--#                            , u_ISERDESE2
--#                            , u_JTAG_SIME2
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LD_1
--#                            , u_LDC
--#                            , u_LDC_1
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCP_1
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDP_1
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_LUT5
--#                            , u_LUT5_D
--#                            , u_LUT5_L
--#                            , u_LUT6
--#                            , u_LUT6_2
--#                            , u_LUT6_D
--#                            , u_LUT6_L
--#                            , u_MMCME2_ADV
--#                            , u_MMCME2_BASE
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND2B1
--#                            , u_NAND2B2
--#                            , u_NAND3
--#                            , u_NAND3B1
--#                            , u_NAND3B2
--#                            , u_NAND3B3
--#                            , u_NAND4
--#                            , u_NAND4B1
--#                            , u_NAND4B2
--#                            , u_NAND4B3
--#                            , u_NAND4B4
--#                            , u_NAND5
--#                            , u_NAND5B1
--#                            , u_NAND5B2
--#                            , u_NAND5B3
--#                            , u_NAND5B4
--#                            , u_NAND5B5
--#                            , u_NOR2
--#                            , u_NOR2B1
--#                            , u_NOR2B2
--#                            , u_NOR3
--#                            , u_NOR3B1
--#                            , u_NOR3B2
--#                            , u_NOR3B3
--#                            , u_NOR4
--#                            , u_NOR4B1
--#                            , u_NOR4B2
--#                            , u_NOR4B3
--#                            , u_NOR4B4
--#                            , u_NOR5
--#                            , u_NOR5B1
--#                            , u_NOR5B2
--#                            , u_NOR5B3
--#                            , u_NOR5B4
--#                            , u_NOR5B5
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFDS_BLVDS_25
--#                            , u_OBUFDS_DUAL_BUF
--#                            , u_OBUFDS_LVDS_25
--#                            , u_OBUF_F_12
--#                            , u_OBUF_F_16
--#                            , u_OBUF_F_2
--#                            , u_OBUF_F_24
--#                            , u_OBUF_F_4
--#                            , u_OBUF_F_6
--#                            , u_OBUF_F_8
--#                            , u_OBUF_HSTL_I
--#                            , u_OBUF_HSTL_I_18
--#                            , u_OBUF_HSTL_I_DCI
--#                            , u_OBUF_HSTL_I_DCI_18
--#                            , u_OBUF_HSTL_II
--#                            , u_OBUF_HSTL_II_18
--#                            , u_OBUF_HSTL_II_DCI
--#                            , u_OBUF_HSTL_II_DCI_18
--#                            , u_OBUF_HSTL_III
--#                            , u_OBUF_HSTL_III_18
--#                            , u_OBUF_HSTL_III_DCI
--#                            , u_OBUF_HSTL_III_DCI_18
--#                            , u_OBUF_LVCMOS12
--#                            , u_OBUF_LVCMOS15
--#                            , u_OBUF_LVCMOS18
--#                            , u_OBUF_LVCMOS25
--#                            , u_OBUF_LVCMOS33
--#                            , u_OBUF_LVDCI_15
--#                            , u_OBUF_LVDCI_18
--#                            , u_OBUF_LVDCI_DV2_15
--#                            , u_OBUF_LVDCI_DV2_18
--#                            , u_OBUF_LVDS
--#                            , u_OBUF_LVPECL
--#                            , u_OBUF_LVTTL
--#                            , u_OBUF_PCI33_3
--#                            , u_OBUF_PCI66_3
--#                            , u_OBUF_PCIX66_3
--#                            , u_OBUF_S_12
--#                            , u_OBUF_S_16
--#                            , u_OBUF_S_2
--#                            , u_OBUF_S_24
--#                            , u_OBUF_S_4
--#                            , u_OBUF_S_6
--#                            , u_OBUF_S_8
--#                            , u_OBUF_SSTL18_I
--#                            , u_OBUF_SSTL18_I_DCI
--#                            , u_OBUF_SSTL18_II
--#                            , u_OBUF_SSTL18_II_DCI
--#                            , u_OBUFT
--#                            , u_OBUFT_DCIEN
--#                            , u_OBUFTDS
--#                            , u_OBUFTDS_BLVDS_25
--#                            , u_OBUFTDS_DCIEN
--#                            , u_OBUFTDS_DCIEN_DUAL_BUF
--#                            , u_OBUFTDS_DUAL_BUF
--#                            , u_OBUFTDS_LVDS_25
--#                            , u_OBUFT_F_12
--#                            , u_OBUFT_F_16
--#                            , u_OBUFT_F_2
--#                            , u_OBUFT_F_24
--#                            , u_OBUFT_F_4
--#                            , u_OBUFT_F_6
--#                            , u_OBUFT_F_8
--#                            , u_OBUFT_HSTL_I
--#                            , u_OBUFT_HSTL_I_18
--#                            , u_OBUFT_HSTL_I_DCI
--#                            , u_OBUFT_HSTL_I_DCI_18
--#                            , u_OBUFT_HSTL_II
--#                            , u_OBUFT_HSTL_II_18
--#                            , u_OBUFT_HSTL_II_DCI
--#                            , u_OBUFT_HSTL_II_DCI_18
--#                            , u_OBUFT_HSTL_III
--#                            , u_OBUFT_HSTL_III_18
--#                            , u_OBUFT_HSTL_III_DCI
--#                            , u_OBUFT_HSTL_III_DCI_18
--#                            , u_OBUFT_LVCMOS12
--#                            , u_OBUFT_LVCMOS15
--#                            , u_OBUFT_LVCMOS18
--#                            , u_OBUFT_LVCMOS25
--#                            , u_OBUFT_LVCMOS33
--#                            , u_OBUFT_LVDCI_15
--#                            , u_OBUFT_LVDCI_18
--#                            , u_OBUFT_LVDCI_DV2_15
--#                            , u_OBUFT_LVDCI_DV2_18
--#                            , u_OBUFT_LVDS
--#                            , u_OBUFT_LVPECL
--#                            , u_OBUFT_LVTTL
--#                            , u_OBUFT_PCI33_3
--#                            , u_OBUFT_PCI66_3
--#                            , u_OBUFT_PCIX66_3
--#                            , u_OBUFT_S_12
--#                            , u_OBUFT_S_16
--#                            , u_OBUFT_S_2
--#                            , u_OBUFT_S_24
--#                            , u_OBUFT_S_4
--#                            , u_OBUFT_S_6
--#                            , u_OBUFT_S_8
--#                            , u_OBUFT_SSTL18_I
--#                            , u_OBUFT_SSTL18_I_DCI
--#                            , u_OBUFT_SSTL18_II
--#                            , u_OBUFT_SSTL18_II_DCI
--#                            , u_ODDR
--#                            , u_ODELAYE2
--#                            , u_OR2
--#                            , u_OR2B1
--#                            , u_OR2B2
--#                            , u_OR2L
--#                            , u_OR3
--#                            , u_OR3B1
--#                            , u_OR3B2
--#                            , u_OR3B3
--#                            , u_OR4
--#                            , u_OR4B1
--#                            , u_OR4B2
--#                            , u_OR4B3
--#                            , u_OR4B4
--#                            , u_OR5
--#                            , u_OR5B1
--#                            , u_OR5B2
--#                            , u_OR5B3
--#                            , u_OR5B4
--#                            , u_OR5B5
--#                            , u_OSERDESE2
--#                            , u_OUT_FIFO
--#                            , u_PCIE_2_1
--#                            , u_PHASER_IN
--#                            , u_PHASER_IN_PHY
--#                            , u_PHASER_OUT
--#                            , u_PHASER_OUT_PHY
--#                            , u_PHASER_REF
--#                            , u_PHY_CONTROL
--#                            , u_PLLE2_ADV
--#                            , u_PLLE2_BASE
--#                            , u_PSS
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM128X1D
--#                            , u_RAM128X1S
--#                            , u_RAM128X1S_1
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM256X1S
--#                            , u_RAM32M
--#                            , u_RAM32X1D
--#                            , u_RAM32X1D_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64M
--#                            , u_RAM64X1D
--#                            , u_RAM64X1D_1
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB36E1
--#                            , u_RAMB36E1
--#                            , u_RAMD32
--#                            , u_RAMD64E
--#                            , u_RAMS32
--#                            , u_RAMS64E
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SIM_CONFIGE2
--#                            , u_SRL16
--#                            , u_SRL16_1
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRLC16
--#                            , u_SRLC16_1
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC32E
--#                            , u_STARTUPE2
--#                            , u_USR_ACCESSE2
--#                            , u_VCC
--#                            , u_XADC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XNOR5
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XOR5
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                            , u_ZHOLD_DELAY
--#             )              ); 
--#       -- 
--#       set_to(y, artix7,   ( 
--#                             u_AND2
--#                           , u_AND2B1
--#                           , u_AND2B1L
--#                           , u_AND2B2
--#                           , u_AND3
--#                           , u_AND3B1
--#                           , u_AND3B2
--#                           , u_AND3B3
--#                           , u_AND4
--#                           , u_AND4B1
--#                           , u_AND4B2
--#                           , u_AND4B3
--#                           , u_AND4B4
--#                           , u_AND5
--#                           , u_AND5B1
--#                           , u_AND5B2
--#                           , u_AND5B3
--#                           , u_AND5B4
--#                           , u_AND5B5
--#                           , u_AUTOBUF
--#                           , u_BSCANE2
--#                           , u_BUF
--#                           , u_BUFCF
--#                           , u_BUFG
--#                           , u_BUFGCE
--#                           , u_BUFGCE_1
--#                           , u_BUFGCTRL
--#                           , u_BUFGMUX
--#                           , u_BUFGMUX_1
--#                           , u_BUFGP
--#                           , u_BUFH
--#                           , u_BUFHCE
--#                           , u_BUFIO
--#                           , u_BUFMR
--#                           , u_BUFMRCE
--#                           , u_BUFR
--#                           , u_BUFT
--#                           , u_CAPTUREE2
--#                           , u_CARRY4
--#                           , u_CFGLUT5
--#                           , u_DCIRESET
--#                           , u_DNA_PORT
--#                           , u_DSP48E1
--#                           , u_EFUSE_USR
--#                           , u_FD
--#                           , u_FD_1
--#                           , u_FDC
--#                           , u_FDC_1
--#                           , u_FDCE
--#                           , u_FDCE_1
--#                           , u_FDCP
--#                           , u_FDCP_1
--#                           , u_FDCPE
--#                           , u_FDCPE_1
--#                           , u_FDE
--#                           , u_FDE_1
--#                           , u_FDP
--#                           , u_FDP_1
--#                           , u_FDPE
--#                           , u_FDPE_1
--#                           , u_FDR
--#                           , u_FDR_1
--#                           , u_FDRE
--#                           , u_FDRE_1
--#                           , u_FDRS
--#                           , u_FDRS_1
--#                           , u_FDRSE
--#                           , u_FDRSE_1
--#                           , u_FDS
--#                           , u_FDS_1
--#                           , u_FDSE
--#                           , u_FDSE_1
--#                           , u_FIFO18E1
--#                           , u_FIFO36E1
--#                           , u_FMAP
--#                           , u_FRAME_ECCE2
--#                           , u_GND
--#                           , u_IBUF
--#                           , u_IBUF_DCIEN
--#                           , u_IBUFDS
--#                           , u_IBUFDS_DCIEN
--#                           , u_IBUFDS_DIFF_OUT
--#                           , u_IBUFDS_DIFF_OUT_DCIEN
--#                           , u_IBUFDS_GTE2
--#                           , u_IBUFG
--#                           , u_IBUFGDS
--#                           , u_IBUFGDS_DIFF_OUT
--#                           , u_IBUFG_LVDS
--#                           , u_IBUFG_LVPECL
--#                           , u_IBUFG_PCIX66_3
--#                           , u_IBUF_LVDS
--#                           , u_IBUF_LVPECL
--#                           , u_IBUF_PCIX66_3
--#                           , u_ICAPE2
--#                           , u_IDDR
--#                           , u_IDDR_2CLK
--#                           , u_IDELAY
--#                           , u_IDELAYCTRL
--#                           , u_IDELAYE2
--#                           , u_IN_FIFO
--#                           , u_INV
--#                           , u_IOBUF
--#                           , u_IOBUFDS
--#                           , u_IOBUFDS_DIFF_OUT
--#                           , u_IOBUFDS_DIFF_OUT_DCIEN
--#                           , u_IOBUF_F_12
--#                           , u_IOBUF_F_16
--#                           , u_IOBUF_F_2
--#                           , u_IOBUF_F_24
--#                           , u_IOBUF_F_4
--#                           , u_IOBUF_F_6
--#                           , u_IOBUF_F_8
--#                           , u_IOBUF_LVDS
--#                           , u_IOBUF_LVPECL
--#                           , u_IOBUF_PCIX66_3
--#                           , u_IOBUF_S_12
--#                           , u_IOBUF_S_16
--#                           , u_IOBUF_S_2
--#                           , u_IOBUF_S_24
--#                           , u_IOBUF_S_4
--#                           , u_IOBUF_S_6
--#                           , u_IOBUF_S_8
--#                           , u_IODELAY
--#                           , u_IODELAYE1
--#                           , u_ISERDESE2
--#                           , u_JTAG_SIME2
--#                           , u_KEEPER
--#                           , u_LD
--#                           , u_LD_1
--#                           , u_LDC
--#                           , u_LDC_1
--#                           , u_LDCE
--#                           , u_LDCE_1
--#                           , u_LDCP
--#                           , u_LDCP_1
--#                           , u_LDCPE
--#                           , u_LDCPE_1
--#                           , u_LDE
--#                           , u_LDE_1
--#                           , u_LDP
--#                           , u_LDP_1
--#                           , u_LDPE
--#                           , u_LDPE_1
--#                           , u_LUT1
--#                           , u_LUT1_D
--#                           , u_LUT1_L
--#                           , u_LUT2
--#                           , u_LUT2_D
--#                           , u_LUT2_L
--#                           , u_LUT3
--#                           , u_LUT3_D
--#                           , u_LUT3_L
--#                           , u_LUT4
--#                           , u_LUT4_D
--#                           , u_LUT4_L
--#                           , u_LUT5
--#                           , u_LUT5_D
--#                           , u_LUT5_L
--#                           , u_LUT6
--#                           , u_LUT6_2
--#                           , u_LUT6_D
--#                           , u_LUT6_L
--#                           , u_MMCME2_ADV
--#                           , u_MMCME2_BASE
--#                           , u_MULT_AND
--#                           , u_MUXCY
--#                           , u_MUXCY_D
--#                           , u_MUXCY_L
--#                           , u_MUXF5
--#                           , u_MUXF5_D
--#                           , u_MUXF5_L
--#                           , u_MUXF6
--#                           , u_MUXF6_D
--#                           , u_MUXF6_L
--#                           , u_MUXF7
--#                           , u_MUXF7_D
--#                           , u_MUXF7_L
--#                           , u_MUXF8
--#                           , u_MUXF8_D
--#                           , u_MUXF8_L
--#                           , u_NAND2
--#                           , u_NAND2B1
--#                           , u_NAND2B2
--#                           , u_NAND3
--#                           , u_NAND3B1
--#                           , u_NAND3B2
--#                           , u_NAND3B3
--#                           , u_NAND4
--#                           , u_NAND4B1
--#                           , u_NAND4B2
--#                           , u_NAND4B3
--#                           , u_NAND4B4
--#                           , u_NAND5
--#                           , u_NAND5B1
--#                           , u_NAND5B2
--#                           , u_NAND5B3
--#                           , u_NAND5B4
--#                           , u_NAND5B5
--#                           , u_NOR2
--#                           , u_NOR2B1
--#                           , u_NOR2B2
--#                           , u_NOR3
--#                           , u_NOR3B1
--#                           , u_NOR3B2
--#                           , u_NOR3B3
--#                           , u_NOR4
--#                           , u_NOR4B1
--#                           , u_NOR4B2
--#                           , u_NOR4B3
--#                           , u_NOR4B4
--#                           , u_NOR5
--#                           , u_NOR5B1
--#                           , u_NOR5B2
--#                           , u_NOR5B3
--#                           , u_NOR5B4
--#                           , u_NOR5B5
--#                           , u_OBUF
--#                           , u_OBUFDS
--#                           , u_OBUFDS_DUAL_BUF
--#                           , u_OBUF_F_12
--#                           , u_OBUF_F_16
--#                           , u_OBUF_F_2
--#                           , u_OBUF_F_24
--#                           , u_OBUF_F_4
--#                           , u_OBUF_F_6
--#                           , u_OBUF_F_8
--#                           , u_OBUF_LVDS
--#                           , u_OBUF_LVPECL
--#                           , u_OBUF_PCIX66_3
--#                           , u_OBUF_S_12
--#                           , u_OBUF_S_16
--#                           , u_OBUF_S_2
--#                           , u_OBUF_S_24
--#                           , u_OBUF_S_4
--#                           , u_OBUF_S_6
--#                           , u_OBUF_S_8
--#                           , u_OBUFT
--#                           , u_OBUFT_DCIEN
--#                           , u_OBUFTDS
--#                           , u_OBUFTDS_DCIEN
--#                           , u_OBUFTDS_DCIEN_DUAL_BUF
--#                           , u_OBUFTDS_DUAL_BUF
--#                           , u_OBUFT_F_12
--#                           , u_OBUFT_F_16
--#                           , u_OBUFT_F_2
--#                           , u_OBUFT_F_24
--#                           , u_OBUFT_F_4
--#                           , u_OBUFT_F_6
--#                           , u_OBUFT_F_8
--#                           , u_OBUFT_LVDS
--#                           , u_OBUFT_LVPECL
--#                           , u_OBUFT_PCIX66_3
--#                           , u_OBUFT_S_12
--#                           , u_OBUFT_S_16
--#                           , u_OBUFT_S_2
--#                           , u_OBUFT_S_24
--#                           , u_OBUFT_S_4
--#                           , u_OBUFT_S_6
--#                           , u_OBUFT_S_8
--#                           , u_ODDR
--#                           , u_ODELAYE2
--#                           , u_OR2
--#                           , u_OR2B1
--#                           , u_OR2B2
--#                           , u_OR2L
--#                           , u_OR3
--#                           , u_OR3B1
--#                           , u_OR3B2
--#                           , u_OR3B3
--#                           , u_OR4
--#                           , u_OR4B1
--#                           , u_OR4B2
--#                           , u_OR4B3
--#                           , u_OR4B4
--#                           , u_OR5
--#                           , u_OR5B1
--#                           , u_OR5B2
--#                           , u_OR5B3
--#                           , u_OR5B4
--#                           , u_OR5B5
--#                           , u_OSERDESE2
--#                           , u_OUT_FIFO
--#                           , u_PCIE_2_1
--#                           , u_PHASER_IN
--#                           , u_PHASER_IN_PHY
--#                           , u_PHASER_OUT
--#                           , u_PHASER_OUT_PHY
--#                           , u_PHASER_REF
--#                           , u_PHY_CONTROL
--#                           , u_PLLE2_ADV
--#                           , u_PLLE2_BASE
--#                           , u_PSS
--#                           , u_PULLDOWN
--#                           , u_PULLUP
--#                           , u_RAM128X1D
--#                           , u_RAM128X1S
--#                           , u_RAM128X1S_1
--#                           , u_RAM16X1D
--#                           , u_RAM16X1D_1
--#                           , u_RAM16X1S
--#                           , u_RAM16X1S_1
--#                           , u_RAM16X2S
--#                           , u_RAM16X4S
--#                           , u_RAM16X8S
--#                           , u_RAM256X1S
--#                           , u_RAM32M
--#                           , u_RAM32X1D
--#                           , u_RAM32X1D_1
--#                           , u_RAM32X1S
--#                           , u_RAM32X1S_1
--#                           , u_RAM32X2S
--#                           , u_RAM32X4S
--#                           , u_RAM32X8S
--#                           , u_RAM64M
--#                           , u_RAM64X1D
--#                           , u_RAM64X1D_1
--#                           , u_RAM64X1S
--#                           , u_RAM64X1S_1
--#                           , u_RAM64X2S
--#                            , u_RAMB16_S4_S36
--#                           , u_RAMB18E1
--#                           , u_RAMB36E1
--#                           , u_RAMD32
--#                           , u_RAMD64E
--#                           , u_RAMS32
--#                           , u_RAMS64E
--#                           , u_ROM128X1
--#                           , u_ROM16X1
--#                           , u_ROM256X1
--#                           , u_ROM32X1
--#                           , u_ROM64X1
--#                           , u_SIM_CONFIGE2
--#                           , u_SRL16
--#                           , u_SRL16_1
--#                           , u_SRL16E
--#                           , u_SRL16E_1
--#                           , u_SRLC16
--#                           , u_SRLC16_1
--#                           , u_SRLC16E
--#                           , u_SRLC16E_1
--#                           , u_SRLC32E
--#                           , u_STARTUPE2
--#                           , u_USR_ACCESSE2
--#                           , u_VCC
--#                           , u_XADC
--#                           , u_XNOR2
--#                           , u_XNOR3
--#                           , u_XNOR4
--#                           , u_XNOR5
--#                           , u_XOR2
--#                           , u_XOR3
--#                           , u_XOR4
--#                           , u_XOR5
--#                           , u_XORCY
--#                           , u_XORCY_D
--#                           , u_XORCY_L
--#                           , u_ZHOLD_DELAY
--#             )              ); 
--#       -- 
--#       return pp; 
--#   end prim_population; 
--#   ---) 
--#
--#constant fam_has_prim :  fam_has_prim_type := prim_population; 
constant fam_has_prim :  fam_has_prim_type := 
(
     nofamily => (
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex => (
y, n, y, y, n, n, n, n, n, n, y, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan2 => (
y, n, y, y, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan2e => (
y, n, y, y, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtexe => (
y, n, y, y, n, n, n, n, n, n, y, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex2 => (
y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qvirtex2 => (
y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qrvirtex2 => (
y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex2p => (
y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan3 => (
y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     aspartan3 => (
y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex4 => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex4lx => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex4fx => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, y, y, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex4sx => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, y, y, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan3e => (
y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex5 => (
y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan3a => (
y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan3an => (
y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan3adsp => (
y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     aspartan3e => (
y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     aspartan3a => (
y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     aspartan3adsp => (
y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qvirtex4 => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qrvirtex4 => (
y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan6 => (
y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex6 => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, n, y, y, y, n, y, y, y, y, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, n, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, y, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, y, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, n, y, n, y, y, n, y, y, y, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     spartan6l => (
y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qspartan6 => (
y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     aspartan6 => (
y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex6l => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, n, y, y, y, n, y, y, y, y, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, n, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, y, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, y, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, n, y, n, y, y, n, y, y, y, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qspartan6l => (
y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qvirtex5 => (
y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qvirtex6 => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, n, y, y, y, n, y, y, y, y, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, n, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, y, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, y, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, n, y, n, y, y, n, y, y, y, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     qrvirtex5 => (
y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex5tx => (
y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex5fx => (
y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex6cx => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, n, y, y, y, n, y, y, y, y, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, n, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, y, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, y, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, n, y, n, y, y, n, y, y, y, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     kintex7 => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, n, n, n, n, n, n, y, y, n, y, n, y, y, y, n, y, y, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, y, n, n, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, 
y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y), 
     virtex7 => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, n, n, n, n, n, n, y, y, n, y, n, y, y, y, n, y, y, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, y, n, n, y, y, y, y, y, y, y, y, n, n, y, y, n, y, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, 
y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y), 
     artix7 => (
y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, n, n, n, n, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, 
n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y) 
);

    function supported( family         : families_type;
                        primitive      : primitives_type
                      ) return boolean is
    begin
        return  fam_has_prim(family)(primitive) = y;
    end supported;


    function supported( family         : families_type;
                        primitives     : primitive_array_type
                      ) return boolean is
    begin
        for i in primitives'range loop
            if fam_has_prim(family)(primitives(i)) /= y then
                return false;
            end if;
        end loop;
        return true;
    end supported;

    ----------------------------------------------------------------------------
    -- This function is used as alternative to the 'IMAGE attribute, which
    -- is not correctly interpretted by some vhdl tools.
    ----------------------------------------------------------------------------
    function myimage (fam_type :  families_type) return string is 
      variable temp : families_type :=fam_type;
    begin 
    case temp is 
      when nofamily      => return "nofamily";
      when virtex        => return "virtex";
      when spartan2      => return "spartan2";
      when spartan2e     => return "spartan2e";
      when virtexe       => return "virtexe";
      when virtex2       => return "virtex2";
      when qvirtex2      => return "qvirtex2";
      when qrvirtex2     => return "qrvirtex2";
      when virtex2p      => return "virtex2p";
      when spartan3      => return "spartan3";
      when aspartan3     => return "aspartan3";
      when spartan3e     => return "spartan3e";
      when virtex4       => return "virtex4";
      when virtex4lx     => return "virtex4lx";
      when virtex4fx     => return "virtex4fx";
      when virtex4sx     => return "virtex4sx";
      when virtex5       => return "virtex5";
      when spartan3a     => return "spartan3a";
      when spartan3an    => return "spartan3an";
      when spartan3adsp  => return "spartan3adsp";
      when aspartan3e    => return "aspartan3e";
      when aspartan3a    => return "aspartan3a";
      when aspartan3adsp => return "aspartan3adsp";
      when qvirtex4      => return "qvirtex4";
      when qrvirtex4     => return "qrvirtex4";
      when spartan6      => return "spartan6";
      when virtex6       => return "virtex6";
      when spartan6l     => return "spartan6l";
      when qspartan6     => return "qspartan6";
      when aspartan6     => return "aspartan6";
      when virtex6l      => return "virtex6l" ;
      when qspartan6l    => return "qspartan6l";
      when qvirtex5      => return "qvirtex5" ;
      when qvirtex6      => return "qvirtex6" ;
      when qrvirtex5     => return "qrvirtex5";
      when virtex5tx     => return "virtex5tx";
      when virtex5fx     => return "virtex5fx";
      when virtex6cx     => return "virtex6cx";
      when virtex7       => return "virtex7"  ;
      when kintex7       => return "kintex7"  ;
      when artix7        => return "artix7"   ;
    end case;
    end myimage;


    
    ---------------------------------------------------------------------------- 
    -- Function: get_root_family
    --
    -- This function takes in the string for the desired FPGA family type and
    -- returns the root FPGA family type string. This is used for derivative part 
    -- aliasing to the root family. This is primarily for fifo_generator and 
    -- blk_mem_gen calls that need the root family passed to the call.
    ---------------------------------------------------------------------------- 
    function get_root_family(family_in : string) return string is
    
    begin 
      
      -- spartan3 Root family
      if    (equalIgnoringCase(family_in, "spartan3"      )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "spartan3a"     )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "spartan3an"    )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "spartan3adsp"  )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "aspartan3"     )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "aspartan3a"    )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "aspartan3adsp" )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "spartan3e"     )) Then return "spartan3" ;
      Elsif (equalIgnoringCase(family_in, "aspartan3e"    )) Then return "spartan3" ;
                                                           
      -- virtex4 Root family                               
      Elsif (equalIgnoringCase(family_in, "virtex4"       )) Then return "virtex4"  ;
      Elsif (equalIgnoringCase(family_in, "virtex4lx"     )) Then return "virtex4"  ;
      Elsif (equalIgnoringCase(family_in, "virtex4fx"     )) Then return "virtex4"  ;
      Elsif (equalIgnoringCase(family_in, "virtex4sx"     )) Then return "virtex4"  ;
      Elsif (equalIgnoringCase(family_in, "qvirtex4"      )) Then return "virtex4"  ;
      Elsif (equalIgnoringCase(family_in, "qrvirtex4"     )) Then return "virtex4"  ;
                                                           
      -- virtex5 Root family                               
      Elsif (equalIgnoringCase(family_in, "virtex5"       )) Then return "virtex5"  ;
      Elsif (equalIgnoringCase(family_in, "qvirtex5"      )) Then return "virtex5"  ;
      Elsif (equalIgnoringCase(family_in, "qrvirtex5"     )) Then return "virtex5"  ;
      Elsif (equalIgnoringCase(family_in, "virtex5tx"     )) Then return "virtex5"  ;
      Elsif (equalIgnoringCase(family_in, "virtex5fx"     )) Then return "virtex5"  ;
                                                           
      -- virtex6 Root family                               
      Elsif (equalIgnoringCase(family_in, "virtex6"       )) Then return "virtex6"  ;
      Elsif (equalIgnoringCase(family_in, "virtex6l"      )) Then return "virtex6"  ;
      Elsif (equalIgnoringCase(family_in, "qvirtex6"      )) Then return "virtex6"  ;
      Elsif (equalIgnoringCase(family_in, "virtex6cx"     )) Then return "virtex6"  ;
                                                           
      -- spartan6 Root family                              
      Elsif (equalIgnoringCase(family_in, "spartan6"      )) Then return "spartan6" ;
      Elsif (equalIgnoringCase(family_in, "spartan6l"     )) Then return "spartan6" ;
      Elsif (equalIgnoringCase(family_in, "qspartan6"     )) Then return "spartan6" ;
      Elsif (equalIgnoringCase(family_in, "aspartan6"     )) Then return "spartan6" ;
      Elsif (equalIgnoringCase(family_in, "qspartan6l"    )) Then return "spartan6" ;
      
      -- Virtex7 Root family                              
      Elsif (equalIgnoringCase(family_in, "virtex7"      )) Then return "virtex7" ;
      
      -- Kintex7 Root family                              
      Elsif (equalIgnoringCase(family_in, "kintex7"     )) Then return "kintex7" ;
      
      -- artix7 Root family                              
      Elsif (equalIgnoringCase(family_in, "artix7"     )) Then return "artix7" ;
      
      -- No Match to supported families and derivatives
      Else  return "nofamily";
      
      End if;
    
    end get_root_family;


    
    
    function toLowerCaseChar( char : character ) return character is
    begin
       -- If char is not an upper case letter then return char
       if char < 'A' OR char > 'Z' then
         return char;
       end if;
       -- Otherwise map char to its corresponding lower case character and
       -- return that
       case char is
         when 'A' => return 'a';
         when 'B' => return 'b';
         when 'C' => return 'c';
         when 'D' => return 'd';
         when 'E' => return 'e';
         when 'F' => return 'f';
         when 'G' => return 'g';
         when 'H' => return 'h';
         when 'I' => return 'i';
         when 'J' => return 'j';
         when 'K' => return 'k';
         when 'L' => return 'l';
         when 'M' => return 'm';
         when 'N' => return 'n';
         when 'O' => return 'o';
         when 'P' => return 'p';
         when 'Q' => return 'q';
         when 'R' => return 'r';
         when 'S' => return 's';
         when 'T' => return 't';
         when 'U' => return 'u';
         when 'V' => return 'v';
         when 'W' => return 'w';
         when 'X' => return 'x';
         when 'Y' => return 'y';
         when 'Z' => return 'z';
         when others => return char;
       end case;
    end toLowerCaseChar;


    ---------------------------------------------------------------------------- 
    -- Function: equalIgnoringCase
    --
    -- Compare one string against another for equality with case insensitivity.
    -- Can be used to test see if a family, C_FAMILY, is equal to some
    -- family. However such usage is discouraged. Use instead availability
    -- primitive guards based on the function, 'supported', wherever possible.
    ---------------------------------------------------------------------------- 
    function equalIgnoringCase( str1, str2 : string ) return boolean is
      constant LEN1 : integer := str1'length;
      constant LEN2 : integer := str2'length;
      variable equal : boolean := TRUE;
    begin
       if not (LEN1 = LEN2) then
         equal := FALSE;
       else
         for i in str1'range loop
           if not (toLowerCaseChar(str1(i)) = toLowerCaseChar(str2(i))) then
             equal := FALSE;
           end if;
         end loop;
       end if;
       return equal;
    end equalIgnoringCase;


    ---------------------------------------------------------------------------- 
    -- Conversions from/to STRING to/from families_type.
    -- These are convenience functions that are not normally needed when
    -- using the 'supported' functions.
    ---------------------------------------------------------------------------- 
    function str2fam( fam_as_string  : string ) return families_type is
        --
        variable fas : string(1 to fam_as_string'length) := fam_as_string;
        variable fam  : families_type;
        --
    begin
        -- Search for and return the corresponding family.
        for fam in families_type'low to families_type'high loop
            if equalIgnoringCase(fas, myimage(fam)) then return fam; end if;
        end loop;
        -- If there is no matching family, report a warning and return nofamily.
        assert false
          report "Package vid_edid_v1_0_0_family_support: Function str2fam called" &
                 " with string parameter, " & fam_as_string &
                 ", that does not correspond" &
                 " to a supported family. Returning nofamily."
          severity warning;
        return nofamily;
    end str2fam;


    function fam2str( fam :  families_type) return string is
    begin
      --return families_type'IMAGE(fam);
        return myimage(fam);
    end fam2str;

    function supported( fam_as_str     : string;
                        primitive      : primitives_type
                      ) return boolean is
    begin
        return supported(str2fam(fam_as_str), primitive);
    end supported;


    function supported( fam_as_str     : string;
                        primitives     : primitive_array_type
                      ) return boolean is
    begin
        return supported(str2fam(fam_as_str), primitives);
    end supported;


    ---------------------------------------------------------------------------- 
    -- Function: native_lut_size, two overloads.
    ---------------------------------------------------------------------------- 
    function native_lut_size( fam : families_type;
                              no_lut_return_val : natural := 0
                            ) return natural is
    begin
        if    supported(fam, u_LUT6) then return  6;
        elsif supported(fam, u_LUT5) then return  5;
        elsif supported(fam, u_LUT4) then return  4;
        elsif supported(fam, u_LUT3) then return  3;
        elsif supported(fam, u_LUT2) then return  2;
        elsif supported(fam, u_LUT1) then return  1;
        else                              return no_lut_return_val;
        end if;
    end;


    function native_lut_size( fam_as_string : string;
                              no_lut_return_val : natural := 0
                            ) return natural is
    begin
        return native_lut_size( fam => str2fam(fam_as_string),
                                no_lut_return_val => no_lut_return_val
                              );
    end;


end package body vid_edid_v1_0_0_family_support;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- pselect_f.vhd - entity/architecture pair
------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_pselect_f.vhd
--
-- Description:
--                  (Note: At least as early as I.31, XST implements a carry-
--                   chain structure for most decoders when these are coded in
--                   inferrable VHLD. An example of such code can be seen
--                   below in the "INFERRED_GEN" Generate Statement.
--
--                   ->  New code should not need to instantiate pselect-type
--                       components.
--
--                   ->  Existing code can be ported to Virtex5 and later by
--                       replacing pselect instances by vid_edid_v1_0_0_pselect_f instances.
--                       As long as the C_FAMILY parameter is not included
--                       in the Generic Map, an inferred implementation
--                       will result.
--
--                   ->  If the designer wishes to force an explicit carry-
--                       chain implementation, vid_edid_v1_0_0_pselect_f can be used with
--                       the C_FAMILY parameter set to the target
--                       Xilinx FPGA family.
--                  )
--
--                  Parameterizeable peripheral select (address decode).
--                  AValid qualifier comes in on Carry In at bottom
--                  of carry chain.
--
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:       vid_edid_v1_0_0_pselect_f.vhd
--                    vid_edid_v1_0_0_family_support.vhd
--
-------------------------------------------------------------------------------
-- History:
-- Vaibhav & FLO   05/26/06    First Version
--
--     DET     1/17/2008     v3_00_a
-- ~~~~~~
--     - Changed proc_common library version to v3_00_a
--     - Incorporated new disclaimer header
-- ^^^^^^
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library unisim;
use unisim.all;

--library proc_common_v3_00_a;
--use proc_common_v3_00_a.vid_edid_v1_0_0_family_support.all;
use work.vid_edid_v1_0_0_family_support.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_AB            -- number of address bits to decode
--          C_AW            -- width of address bus
--          C_BAR           -- base address of peripheral (peripheral select
--                             is asserted when the C_AB most significant
--                             address bits match the C_AB most significant
--                             C_BAR bits
-- Definition of Ports:
--          A               -- address input
--          AValid          -- address qualifier
--          CS              -- peripheral select
-------------------------------------------------------------------------------

entity vid_edid_v1_0_0_pselect_f is

  generic (
    C_AB     : integer := 9;
    C_AW     : integer := 32;
    C_BAR    : std_logic_vector;
    C_FAMILY : string := "nofamily"
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    CS       : out  std_logic
    );

end entity vid_edid_v1_0_0_pselect_f;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of vid_edid_v1_0_0_pselect_f is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

  component MUXCY is
    port (
      O  : out std_logic;
      CI : in  std_logic;
      DI : in  std_logic;
      S  : in  std_logic
    );
  end component MUXCY;

  constant NLS            : natural := native_lut_size(C_FAMILY);
  constant USE_INFERRED   : boolean :=  not supported(C_FAMILY, u_MUXCY)
                                        or NLS=0         -- LUT not supported.
                                        or C_AB <= NLS;  -- Just one LUT
                                                         -- needed.

  -----------------------------------------------------------------------------
  -- C_BAR may not be indexed from 0 and may not be ascending;
  -- BAR recasts C_BAR to have these properties.
  -----------------------------------------------------------------------------
  constant BAR          : std_logic_vector(0 to C_BAR'length-1) := C_BAR;

  type bo2sl_type is array (boolean) of std_logic;
  constant bo2sl  : bo2sl_type := (false => '0', true => '1');
 
  function min(i, j: integer) return integer is
  begin
      if i<j then return i; else return j; end if;
  end;

begin

  ------------------------------------------------------------------------------
  -- Check that the generics are valid.
  ------------------------------------------------------------------------------
  -- synthesis translate_off
     assert (C_AB <= C_BAR'length) and (C_AB <= C_AW)
     report "vid_edid_v1_0_0_pselect_f generic error: " &
            "(C_AB <= C_BAR'length) and (C_AB <= C_AW)" &
            " does not hold."
     severity failure;
  -- synthesis translate_on


  ------------------------------------------------------------------------------
  -- Build a behavioral decoder
  ------------------------------------------------------------------------------
  INFERRED_GEN : if (USE_INFERRED = TRUE ) generate
  begin
  
    XST_WA:if C_AB > 0 generate
      CS  <= AValid when A(0 to C_AB-1) = BAR (0 to C_AB-1) else
             '0' ;
    end generate XST_WA;
    
    PASS_ON_GEN:if C_AB = 0 generate
      CS  <= AValid ;
    end generate PASS_ON_GEN;
    
  end generate INFERRED_GEN;


  ------------------------------------------------------------------------------
  -- Build a structural decoder using the fast carry chain
  ------------------------------------------------------------------------------
  GEN_STRUCTURAL_A : if (USE_INFERRED = FALSE ) generate

      constant  NUM_LUTS    : integer := (C_AB+(NLS-1))/NLS;

      signal    lut_out     : std_logic_vector(0 to NUM_LUTS); -- XST workaround
      signal    carry_chain : std_logic_vector(0 to NUM_LUTS);

  begin

      carry_chain(NUM_LUTS) <= AValid;         -- Initialize start of carry chain.
      CS                    <= carry_chain(0); -- Assign end of carry chain to output.

      XST_WA: if NUM_LUTS > 0 generate         -- workaround for XST
      begin
          GEN_DECODE: for i in 0 to NUM_LUTS-1 generate

            constant NI  : natural  := i;
            constant BTL : positive := min(NLS, C_AB-NI*NLS);-- num Bits This LUT

          begin

                           
              lut_out(i) <= bo2sl(A(NI*NLS to NI*NLS+BTL-1) =     -- LUT
                                  BAR(NI*NLS to NI*NLS+BTL-1));

              MUXCY_I: component MUXCY                            -- MUXCY
                port map (
                  O  => carry_chain(i),
                  CI => carry_chain(i+1),
                  DI => '0',
                  S  => lut_out(i)
                );

          end generate GEN_DECODE;
      end generate XST_WA;

  end generate GEN_STRUCTURAL_A;

end imp;



------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- Processor Common Library Package
------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_proc_common_pkg.vhd
-- Version:         v1.21b
-- Description:     This file contains the constants and functions used in the 
--                  processor common library components.
--
-------------------------------------------------------------------------------
-- Structure:       
--
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--  ALS         09/12/01      -- Created from opb_arb_pkg.vhd
--
--  ALS         09/21/01        
-- ^^^^^^
--  Added pwr function. Replaced log2 function with one that works for XST.
-- ~~~~~~
--
--  ALS         12/07/01
-- ^^^^^^
--  Added Addr_bits function.
-- ~~~~~~
--  ALS         01/31/02
-- ^^^^^^
--  Added max2 function.
-- ~~~~~~
--  FLO         02/22/02
-- ^^^^^^
--  Extended input argument range of log2 function to 2^30. Also, added
--  a check that the argument does not exceed this value; a failure
--  assertion violation is generated if it does not.
-- ~~~~~~
--  FLO         08/31/06
-- ^^^^^^
--  Removed type TARGET_FAMILY_TYPE and functions Get_Reg_File_Area and
--  Get_RLOC_Name. These objects are not used. Further, the functions
--  produced misleading warnings (CR419886, CR419898).
-- ~~~~~~
--  FLO         05/25/07
-- ^^^^^^
--  -Reimplemented function pad_power2 to correct error when the input
--  argument is 1. (fixes CR 303469)
--  -Added function clog2(x), which returns the integer ceiling of the
--  base 2 logarithm of x. This function can be used in place of log2
--  when wishing to avoid the XST warning, "VHDL Assertion Statement
--  with non constant condition is ignored".
-- ~~~~~~
--
--     DET     1/17/2008     v3_00_a
-- ~~~~~~
--     - Incorporated new disclaimer header
-- ^^^^^^
--
--     DET     5/8/2009     v3_00_a for EDK L.SP2
-- ~~~~~~
--   - Per CR520627
--     - Added synthesis translate_off/on constructs to the log2 function
--       around the assertion statement. This removes a repetative XST Warning
--       in SRP files about a non-constant assertion check.
-- ^^^^^^
--  FL0         20/27/2010
-- ^^^^^^
--  Removed 42 TBD comment, again. (CR 568493)
-- ~~~~~~
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-- need conversion function to convert reals/integers to std logic vectors
use ieee.std_logic_arith.conv_std_logic_vector;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


package vid_edid_v1_0_0_proc_common_pkg is

-------------------------------------------------------------------------------
-- Type Declarations
-------------------------------------------------------------------------------
type CHAR_TO_INT_TYPE is array (character) of integer;
-- type INTEGER_ARRAY_TYPE is array (natural range <>) of integer;
-- Type SLV64_ARRAY_TYPE is array (natural range <>) of std_logic_vector(0 to 63);

-------------------------------------------------------------------------------
-- Function and Procedure Declarations
-------------------------------------------------------------------------------
function max2 (num1, num2 : integer) return integer;
function min2 (num1, num2 : integer) return integer;
function Addr_Bits(x,y : std_logic_vector) return integer;
function clog2(x : positive) return natural;
function pad_power2 ( in_num : integer )  return integer;
function pad_4 ( in_num : integer )  return integer;
function log2(x : natural) return integer;
function pwr(x: integer; y: integer) return integer;
function String_To_Int(S : string) return integer;
function itoa (int : integer) return string;
-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
-- the RESET_ACTIVE constant should denote the logic level of an active reset
constant RESET_ACTIVE       : std_logic         := '1'; 

-- table containing strings representing hex characters for conversion to
-- integers
constant STRHEX_TO_INT_TABLE : CHAR_TO_INT_TYPE :=
    ('0'     => 0,
     '1'     => 1,
     '2'     => 2,
     '3'     => 3,
     '4'     => 4,
     '5'     => 5,
     '6'     => 6,
     '7'     => 7,
     '8'     => 8,
     '9'     => 9,
     'A'|'a' => 10,
     'B'|'b' => 11,
     'C'|'c' => 12,
     'D'|'d' => 13,
     'E'|'e' => 14,
     'F'|'f' => 15,
     others  => -1);

 
end vid_edid_v1_0_0_proc_common_pkg;

package body vid_edid_v1_0_0_proc_common_pkg is
-------------------------------------------------------------------------------
-- Function Definitions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Function max2
--
-- This function returns the greater of two numbers.
-------------------------------------------------------------------------------
function max2 (num1, num2 : integer) return integer is
begin
    if num1 >= num2 then
        return num1;
    else
        return num2;
    end if;
end function max2;


-------------------------------------------------------------------------------
-- Function min2
--
-- This function returns the lesser of two numbers.
-------------------------------------------------------------------------------
function min2 (num1, num2 : integer) return integer is
begin
    if num1 <= num2 then
        return num1;
    else
        return num2;
    end if;
end function min2;


-------------------------------------------------------------------------------
-- Function Addr_bits
--
-- function to convert an address range (base address and an upper address)
-- into the number of upper address bits needed for decoding a device
-- select signal.  will handle slices and big or little endian
-------------------------------------------------------------------------------
function Addr_Bits(x,y : std_logic_vector) return integer is
  variable addr_xor : std_logic_vector(x'range);
  variable count    : integer := 0;
begin
  assert x'length = y'length and (x'ascending xnor y'ascending)
    report "Addr_Bits: arguments are not the same type"
    severity ERROR;
  addr_xor := x xor y;
  for i in x'range
  loop
    if addr_xor(i) = '1' then return count;
    end if;
    count := count + 1;
  end loop;
  return x'length;
end Addr_Bits;


--------------------------------------------------------------------------------
-- Function clog2 - returns the integer ceiling of the base 2 logarithm of x,
--                  i.e., the least integer greater than or equal to log2(x).
--------------------------------------------------------------------------------
function clog2(x : positive) return natural is
  variable r  : natural := 0;
  variable rp : natural := 1; -- rp tracks the value 2**r
begin 
  while rp < x loop -- Termination condition T: x <= 2**r
    -- Loop invariant L: 2**(r-1) < x
    r := r + 1;
    if rp > integer'high - rp then exit; end if;  -- If doubling rp overflows
      -- the integer range, the doubled value would exceed x, so safe to exit.
    rp := rp + rp;
  end loop;
  -- L and T  <->  2**(r-1) < x <= 2**r  <->  (r-1) < log2(x) <= r
  return r; --
end clog2;

-------------------------------------------------------------------------------
-- Function pad_power2
--
-- This function returns the next power of 2 from the input number. If the 
-- input number is a power of 2, this function returns the input number.
--
-- This function is used to round up the number of masters to the next power
-- of 2 if the number of masters is not already a power of 2.
--
-- Input argument 0, which is not a power of two, is accepted and returns 0.
-- Input arguments less than 0 are not allowed.
-------------------------------------------------------------------------------
-- 
function pad_power2 (in_num : integer  ) return integer is
begin         
    if in_num = 0 then
        return 0;
    else
        return 2**(clog2(in_num));
    end if;
end pad_power2;




-------------------------------------------------------------------------------
-- Function pad_4
--
-- This function returns the next multiple of 4 from the input number. If the 
-- input number is a multiple of 4, this function returns the input number.
--
-------------------------------------------------------------------------------
-- 
function pad_4 (in_num : integer  ) return integer is

variable out_num     : integer;

begin
    out_num := (((in_num-1)/4) + 1)*4;
    return out_num;
    
end pad_4;

-------------------------------------------------------------------------------
-- Function log2 -- returns number of bits needed to encode x choices
--   x = 0  returns 0
--   x = 1  returns 0
--   x = 2  returns 1
--   x = 4  returns 2, etc.
-------------------------------------------------------------------------------
--
function log2(x : natural) return integer is
  variable i  : integer := 0; 
  variable val: integer := 1;
begin 
  if x = 0 then return 0;
  else
    for j in 0 to 29 loop -- for loop for XST 
      if val >= x then null; 
      else
        i := i+1;
        val := val*2;
      end if;
    end loop;
  -- Fix per CR520627  XST was ignoring this anyway and printing a  
  -- Warning in SRP file. This will get rid of the warning and not
  -- impact simulation.  
  -- synthesis translate_off
    assert val >= x
      report "Function log2 received argument larger" &
             " than its capability of 2^30. "
      severity failure;
  -- synthesis translate_on
    return i;
  end if;  
end function log2; 


-------------------------------------------------------------------------------
-- Function pwr -- x**y
-- negative numbers not allowed for y
-------------------------------------------------------------------------------

function pwr(x: integer; y: integer) return integer is
  variable z : integer := 1;
begin
  if y = 0 then return 1; 
  else
    for i in 1 to y loop
      z := z * x;
    end loop;
    return z;
  end if;
end function pwr;

-------------------------------------------------------------------------------
-- Function itoa
-- 
-- The itoa function converts an integer to a text string.
-- This function is required since `image doesn't work in Synplicity
-- Valid input range is -9999 to 9999
-------------------------------------------------------------------------------
--  
  function itoa (int : integer) return string is
    type table is array (0 to 9) of string (1 to 1);
    constant LUT     : table :=
      ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    variable str1            : string(1 to 1);
    variable str2            : string(1 to 2);
    variable str3            : string(1 to 3);
    variable str4            : string(1 to 4);
    variable str5            : string(1 to 5);
    variable abs_int         : natural;
    
    variable thousands_place : natural;
    variable hundreds_place  : natural;
    variable tens_place      : natural;
    variable ones_place      : natural;
    variable sign            : integer;
    
  begin
    abs_int := abs(int);
    if abs_int > int then sign := -1;
    else sign := 1;
    end if;
    thousands_place :=  abs_int/1000;
    hundreds_place :=  (abs_int-thousands_place*1000)/100;
    tens_place :=      (abs_int-thousands_place*1000-hundreds_place*100)/10;
    ones_place :=      
      (abs_int-thousands_place*1000-hundreds_place*100-tens_place*10);
    
    if sign>0 then
      if thousands_place>0 then
        str4 := LUT(thousands_place) & LUT(hundreds_place) & LUT(tens_place) &
                LUT(ones_place);
        return str4;
      elsif hundreds_place>0 then 
        str3 := LUT(hundreds_place) & LUT(tens_place) & LUT(ones_place);
        return str3;
      elsif tens_place>0 then
        str2 := LUT(tens_place) & LUT(ones_place);
        return str2;
      else
        str1 := LUT(ones_place);
        return str1;
      end if;
    else
      if thousands_place>0 then
        str5 := "-" & LUT(thousands_place) & LUT(hundreds_place) & 
          LUT(tens_place) & LUT(ones_place);
        return str5;
      elsif hundreds_place>0 then 
        str4 := "-" & LUT(hundreds_place) & LUT(tens_place) & LUT(ones_place);
        return str4;
      elsif tens_place>0 then
        str3 := "-" & LUT(tens_place) & LUT(ones_place);
        return str3;
      else
        str2 := "-" & LUT(ones_place);
        return str2;
      end if;
    end if;  
  end itoa; 
  
  

-----------------------------------------------------------------------------
-- Function String_To_Int
--
-- Converts a string of hex character to an integer
-- accept negative numbers
-----------------------------------------------------------------------------
  function String_To_Int(S : String) return Integer is
    variable Result : integer := 0;
    variable Temp   : integer := S'Left;
    variable Negative : integer := 1;
  begin
    for I in S'Left to S'Right loop
      if (S(I) = '-') then
        Temp     := 0;
        Negative := -1;
      else
        Temp := STRHEX_TO_INT_TABLE(S(I));
        if (Temp = -1) then
          assert false
            report "Wrong value in String_To_Int conversion " & S(I)
            severity error;
        end if;
      end if;
      Result := Result * 16 + Temp;
    end loop;
    return (Negative * Result);
  end String_To_Int;

end package body vid_edid_v1_0_0_proc_common_pkg;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- vid_edid_v1_0_0_counter_f - entity/architecture pair
-------------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_counter_f.vhd
--
-- Description:     Implements a parameterizable N-bit vid_edid_v1_0_0_counter_f
--                      Up/Down Counter
--                      Count Enable
--                      Parallel Load
--                      Synchronous Reset
--                      The structural implementation has incremental cost
--                      of one LUT per bit.
--                      Precedence of operations when simultaneous:
--                        reset, load, count
--
--                  A default inferred-RTL implementation is provided and
--                  is used if the user explicitly specifies C_FAMILY=nofamily
--                  or ommits C_FAMILY (allowing it to default to nofamily).
--                  The default implementation is also used
--                  if needed primitives are not available in FPGAs of the
--                  type given by C_FAMILY.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--                  vid_edid_v1_0_0_counter_f.vhd
--                      vid_edid_v1_0_0_family_support.vhd
--
-------------------------------------------------------------------------------
-- Author: FLO & Nitin   06/06/2006   First Version, functional equivalent
--                                    of counter.vhd.
-- History:
--     DET     1/17/2008     v3_00_a
-- ~~~~~~
--     - Changed proc_common library version to v3_00_a
--     - Incorporated new disclaimer header
-- ^^^^^^
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.unsigned;
use IEEE.numeric_std."+";
use IEEE.numeric_std."-";

library unisim;
use unisim.all;

--library proc_common_v3_00_a;
--use proc_common_v3_00_a.vid_edid_v1_0_0_family_support.all;
use work.vid_edid_v1_0_0_family_support.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------

entity vid_edid_v1_0_0_counter_f is
    generic(
            C_NUM_BITS : integer := 9;
            C_FAMILY   : string := "nofamily"
           );

    port(
         Clk           : in  std_logic;
         Rst           : in  std_logic;
         Load_In       : in  std_logic_vector(C_NUM_BITS - 1 downto 0);
         Count_Enable  : in  std_logic;
         Count_Load    : in  std_logic;
         Count_Down    : in  std_logic;
         Count_Out     : out std_logic_vector(C_NUM_BITS - 1 downto 0);
         Carry_Out     : out std_logic
        );
end entity vid_edid_v1_0_0_counter_f;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture imp of vid_edid_v1_0_0_counter_f is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

    ---------------------------------------------------------------------
    -- Component declarations
    ---------------------------------------------------------------------  
    component MUXCY_L is
      port (
        DI : in  std_logic;
        CI : in  std_logic;
        S  : in  std_logic;
        LO : out std_logic);
    end component MUXCY_L;

    component XORCY is
      port (
        LI : in  std_logic;
        CI : in  std_logic;
        O  : out std_logic);
    end component XORCY;

    component FDRE is
      port (
        Q  : out std_logic;
        C  : in  std_logic;
        CE : in  std_logic;
        D  : in  std_logic;
        R  : in  std_logic
      );
    end component FDRE;

    ---------------------------------------------------------------------
    -- Constant declarations
    ---------------------------------------------------------------------
    constant USE_STRUCTURAL_A : boolean :=
             supported(C_FAMILY, (u_MUXCY_L, u_XORCY, u_FDRE));
  
    constant USE_INFERRED : boolean := not USE_STRUCTURAL_A;

---------------------------------------------------------------------
-- Begin architecture
---------------------------------------------------------------------
begin

    ---------------------------------------------------------------------
    -- Generate structural code
    ---------------------------------------------------------------------
    STRUCTURAL_A_GEN : if USE_STRUCTURAL_A generate

        signal alu_cy         : std_logic_vector(C_NUM_BITS+1 downto 0);
        signal alu_cy_init    : std_logic;
        signal icount_out     : std_logic_vector(C_NUM_BITS downto 0);
        signal icount_out_x   : std_logic_vector(C_NUM_BITS downto 0);
        signal load_in_x      : std_logic_vector(C_NUM_BITS downto 0);
        signal count_AddSub   : std_logic_vector(C_NUM_BITS downto 0);
        signal count_Result   : std_logic_vector(C_NUM_BITS downto 0);
        signal count_clock_en : std_logic;

    begin

        alu_cy_init <= (Count_Down and Count_Load) or
                       (not Count_Down and not Count_load);

        I_MUXCY_I : component MUXCY_L
          port map (
            DI => '0',
            CI => '1',
            S  => alu_cy_init,
            LO => alu_cy(0));

        count_clock_en <= Count_Enable or Count_Load;

        load_in_x    <= ('0' & Load_In);

        -- Mask out carry position to retain legacy self-clear on next enable.
        icount_out_x <= ('0' & icount_out(C_NUM_BITS-1 downto 0));

        -----------------------------------------------------------------
        -- Generate counter using MUXCY_L, XORCY and FDRE
        -----------------------------------------------------------------
        I_ADDSUB_GEN : for i in 0 to C_NUM_BITS generate

            count_AddSub(i) <= load_in_x(i) xor Count_Down
                                            when Count_Load ='1' else
                               icount_out_x(i) xor Count_Down ; -- LUT

            MUXCY_I : component MUXCY_L
              port map (
                DI => Count_Down,
                CI => alu_cy(i),
                S  => count_AddSub(i),
                LO => alu_cy(i+1));

            XOR_I : component XORCY
              port map (
                LI => count_AddSub(i),
                CI => alu_cy(i),
                O  => count_Result(i));

            FDRE_I: component FDRE
              port map (
                Q  => iCount_Out(i),
                C  => Clk,
                CE => count_clock_en,
                D  => count_Result(i),
                R  => Rst);      

        end generate I_ADDSUB_GEN;


        Carry_Out <= icount_out(C_NUM_BITS);
        Count_Out <= icount_out(C_NUM_BITS-1 downto 0);

    end generate STRUCTURAL_A_GEN;


    ---------------------------------------------------------------------
    -- Generate Inferred code
    ---------------------------------------------------------------------
    --INFERRED_GEN : if USE_INFERRED generate
    INFERRED_GEN : if (not USE_STRUCTURAL_A) generate

        signal icount_out    : unsigned(C_NUM_BITS downto 0);
        signal icount_out_x  : unsigned(C_NUM_BITS downto 0);
        signal load_in_x     : unsigned(C_NUM_BITS downto 0);

    begin

        load_in_x    <= unsigned('0' & Load_In);

        -- Mask out carry position to retain legacy self-clear on next enable.
 --        icount_out_x <= ('0' & icount_out(C_NUM_BITS-1 downto 0)); -- Echeck WA
         icount_out_x <= unsigned('0' & std_logic_vector(icount_out(C_NUM_BITS-1 downto 0)));

        -----------------------------------------------------------------
        -- Process to generate counter with - synchronous reset, load,
        -- counter enable, count down / up features.
        -----------------------------------------------------------------
        CNTR_PROC : process(Clk)
        begin
            if Clk'event and Clk = '1' then
                if Rst = '1' then
                    icount_out <= (others => '0');
                elsif Count_Load = '1' then
                    icount_out <= load_in_x;
                elsif Count_Down = '1'  and Count_Enable = '1' then
                    icount_out <= icount_out_x - 1;
                elsif Count_Enable = '1' then
                    icount_out <= icount_out_x + 1;
                end if;
            end if;
        end process CNTR_PROC;

        Carry_Out <= icount_out(C_NUM_BITS);
        Count_Out <= std_logic_vector(icount_out(C_NUM_BITS-1 downto 0));

    end generate INFERRED_GEN;


end architecture imp;
---------------------------------------------------------------
-- End of file vid_edid_v1_0_0_counter_f.vhd
---------------------------------------------------------------


-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved. 
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.



-- ----------------------------------------------
-- Libraries
-- ----------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

-- ----------------------------------------------
-- Package definition
-- ----------------------------------------------
package vid_edid_v1_0_0_common_pkg is 
    -- ----------------------------------------------
    -- extend vector capability to other types
    -- ----------------------------------------------
	type integer_vector is array (natural range <>) of integer; 
	type real_vector is array (natural range <>) of real; 
	type time_vector is array (natural range <>) of time; 
    type boolean_vector is array (natural range <>) of boolean;

    -- ----------------------------------------------
    -- Common data types
    -- ----------------------------------------------
    type tUNSIGNED8_ARRAY is array (natural range <>) of unsigned (7 downto 0);
    type tUNSIGNED16_ARRAY is array (natural range <>) of unsigned (15 downto 0);
    type tUNSIGNED32_ARRAY is array (natural range <>) of unsigned (31 downto 0);

    -- ----------------------------------------------
    -- String and character data types
    -- ----------------------------------------------
    subtype tFILENAME is string(1 to 128);

    -- ----------------------------------------------
    -- Integer data types
    -- ----------------------------------------------
    subtype tUINT8 is integer range 0 to (2**8 - 1);
    type tUINT8_ARRAY is array(NATURAL RANGE <>, NATURAL RANGE <>) of tUINT8;

    subtype tUINT16 is integer range 0 to (2**16 - 1);

    subtype tSINT32 is integer;
    type tSINT32_ARRAY is array(NATURAL RANGE <>) of tSINT32;

    type tINTEGER_VECTOR_PTR is access integer_vector;

    type tINTEGER_ARRAY_2D is array (natural range <>, natural range <>) of integer;
    type tINTEGER_ARRAY_2D_PTR is access tINTEGER_ARRAY_2D;

    -- ----------------------------------------------
    -- Useful constants
    -- ----------------------------------------------
    constant kZERO  : unsigned (63 downto 0) := (others => '0');
    constant kONE   : unsigned (63 downto 0) := (others => '1');

    -- ----------------------------------------------
    -- Useful functions
    -- ----------------------------------------------
    function log2(a : integer) return integer;
    function max(a : integer; b : integer) return integer;
    function twos_comp(a : signed) return signed;
    function twos_comp(a : unsigned) return unsigned;
    function to_slv(a : integer; s : integer) return std_logic_vector;
    function is_odd(a : integer) return boolean;
    function random(seed : unsigned) return unsigned;
    function random(seed : integer) return integer;
    function reorder32(data_in : unsigned (31 downto 0)) return unsigned;
    function reorder16(data_in : unsigned (15 downto 0)) return unsigned;
    function reorder32pixel(data_in : unsigned (31 downto 0)) return unsigned;
	function hi_word(data_in : unsigned (31 downto 0)) return unsigned;
    function hi_word(data_in : integer) return integer;
	function lo_word(data_in : unsigned (31 downto 0)) return unsigned;
    function lo_word(data_in : integer) return integer;
	function hi_byte(data_in : unsigned (15 downto 0)) return unsigned;
	function lo_byte(data_in : unsigned (15 downto 0)) return unsigned;
	function hi_byte(data_in : integer) return integer;
	function lo_byte(data_in : integer) return integer;
    function get_range_int(data_in : integer; high_bit : integer; low_bit : integer) return integer;
    function cat_unsigned( x : in unsigned; x_hi : in natural; x_lo : in natural; y : in unsigned ; y_hi : in natural ; y_lo : in natural) return unsigned;
    function cat_signed(  x : in signed; x_hi : in natural; x_lo : in natural; y : in signed ; y_hi : in natural ; y_lo : in natural) return signed ;
    function to_integer( x : std_logic ) return integer;

    -- ----------------------------------------------
    -- Logical functions
    -- ----------------------------------------------
    function reduction_or  ( x : in unsigned ) return std_logic;
    function reduction_and ( x : in unsigned ) return std_logic;

    -- ----------------------------------------------
    -- Arithmetic functions
    -- ----------------------------------------------
    function signed_add(op_a : signed; op_b : signed) return signed;
    function signed_mult(op_a : signed; op_b : signed) return signed;
end package vid_edid_v1_0_0_common_pkg;

-- ----------------------------------------------
-- package body
-- ----------------------------------------------
package body vid_edid_v1_0_0_common_pkg is

-- ----------------------------------------------
-- log2 function
-- ----------------------------------------------
function log2(a : integer) return integer is
    variable rval : integer;
begin
    rval := 30;
    for x in 1 to 30 loop               -- Works for up to 32 bit integers
        if(2**x >= a) then 
            rval := x;
            exit;
        end if;
    end loop;

    return(rval);
end function log2;

-- ----------------------------------------------
-- twos_comp, signed and unsigned
-- ----------------------------------------------
function twos_comp(a : signed) return signed is
    variable result : signed(a'HIGH downto a'LOW);
begin
    result := (not a) + 1;
    return result;
end function;

-- same function, different data type
function twos_comp(a : unsigned) return unsigned is
    variable result : unsigned(a'HIGH downto a'LOW);
begin
    result := (not a) + 1;
    return result;
end function;

-- ----------------------------------------------
-- return true if integer is odd
-- ----------------------------------------------
function is_odd(a : integer) return boolean is
    variable tf_value : boolean := false;
begin
    tf_value := true;
    if (a mod 2) = a then
        tf_value := false;
    end if;
    return tf_value;
end function is_odd;

function is_even(a : integer) return boolean is
begin
    return not is_odd(a);
end function is_even;

-- ----------------------------------------------
-- convert integer to std_logic_vector
-- ----------------------------------------------
function to_slv(a : integer; s : integer) return std_logic_vector is
begin
    return std_logic_vector(to_unsigned(a, s));
end function;

-- ----------------------------------------------
-- convert a single bit to an integer
-- ----------------------------------------------
function to_integer( x : std_logic ) return integer is
    variable result : integer;
begin
    if x = '1' then
        result := 1;
    else
        result := 0;
    end if;
    return result;
end function to_integer;

-- ----------------------------------------------
-- random value unsigned
-- ----------------------------------------------
function random(seed : unsigned) return unsigned is
    constant base   : unsigned (31 downto 0) := to_unsigned (1093347, 32);
    constant const  : unsigned (31 downto 0) := to_unsigned (384572349, 32);
    variable result : unsigned (63 downto 0);
begin
    result := base * seed + const;
    return result(seed'high downto seed'low);
end function;

-- ----------------------------------------------
-- random value integer
-- ----------------------------------------------
function random(seed : integer) return integer is
begin
    return(to_integer(signed(random(unsigned(to_signed(seed, 32))))));
end function;

-- ----------------------------------------------
-- reorder a 32 bit unsigned for endian issues
-- ----------------------------------------------
function reorder32 (data_in : unsigned (31 downto 0)) return unsigned is
	variable data_out : unsigned (31 downto 0);
begin
	data_out(31 downto 24) := data_in(7 downto 0);
	data_out(23 downto 16) := data_in(15 downto 8);
	data_out(15 downto 8)  := data_in(23 downto 16);
	data_out(7 downto 0)   := data_in(31 downto 24);

    return data_out;
end function reorder32;

-- ----------------------------------------------
-- reorder a 16 bit unsigned for endian issues
-- ----------------------------------------------
function reorder16 (data_in : unsigned (15 downto 0)) return unsigned is
	variable data_out : unsigned (15 downto 0);
begin
	data_out(15 downto 8) := data_in(7 downto 0);
	data_out(7 downto 0)  := data_in(15 downto 8);

    return data_out;
end function reorder16;

-- --------------------------------------------------
-- reorder a 32 bit unsigned pixel for endian issues
-- --------------------------------------------------
function reorder32pixel (data_in : unsigned (31 downto 0)) return unsigned is
	variable data_out : unsigned (31 downto 0);
begin
    return (data_in(31 downto 24) & data_in(7 downto 0) & data_in(15 downto 8) & data_in(23 downto 16));
end function reorder32pixel;

-- ----------------------------------------------
-- collection of basic extraction functions
-- ----------------------------------------------
-- high 16 bits from 32 bits unsigned
function hi_word (data_in : unsigned(31 downto 0)) return unsigned is
begin
	return data_in (31 downto 16);
end function hi_word;

-- high 16 bits from integer
function hi_word (data_in : integer) return integer is
    variable data_out : signed (31 downto 0) := to_signed(data_in, 32);
begin
     return to_integer(data_out(31 downto 16));
end function hi_word;

-- low 16 bits from 32 bits unsigned
function lo_word (data_in : unsigned (31 downto 0)) return unsigned is
begin
	return data_in(15 downto 0);
end function lo_word;

-- low 16 bits from integer
function lo_word (data_in : integer) return integer is
    variable data_out : signed (31 downto 0) := to_signed(data_in, 32);
begin
	return to_integer(data_out(15 downto 0));
end function lo_word;

-- high 8 bits from 16 bits unsigned
function hi_byte (data_in : unsigned (15 downto 0)) return unsigned is
begin
	return (data_in(15 downto 8));
end function hi_byte;

-- low 8 bits from 16 bits unsigned
function lo_byte (data_in : unsigned (15 downto 0)) return unsigned is
begin
	return (data_in(7 downto 0));
end function lo_byte;

-- low 8 bits from 16 bit integer
function hi_byte (data_in : integer) return integer is
    variable data_out : signed (31 downto 0) := to_signed(data_in, 32);
begin
	return (to_integer(data_out(15 downto 8)));
end function hi_byte;

-- low 8 bits from 16 bit integer
function lo_byte (data_in : integer) return integer is
    variable data_out : signed (31 downto 0) := to_signed(data_in, 32);
begin
	return (to_integer(data_out(7 downto 0)));
end function lo_byte;

-- --------------------------------------------------------------------------------------------------
-- Arithmetic funcitons
--   the larger operand must be the first in the call
-- --------------------------------------------------------------------------------------------------
function signed_add(op_a : signed; op_b : signed) return signed is
    variable i_result : signed(op_a'HIGH+1 downto op_a'LOW);
    variable int_op_a : signed(op_a'HIGH downto op_a'LOW) := op_a;
    variable int_op_b : signed(op_b'HIGH downto op_b'LOW) := op_b;
begin
    -- warn about operands not being the same width
    if op_a'LENGTH /= op_b'length then
        report "WARNING - operands are not the same width (op_a = " & integer'IMAGE(op_a'LENGTH) &
               " op_b = " & integer'IMAGE(op_b'LENGTH) &")" severity warning;
    end if;

    -- make the inbound operands one bit larger to handle overflow and add
    i_result := (int_op_a(int_op_a'HIGH) & int_op_a(int_op_a'HIGH downto int_op_a'LOW)) +
                (int_op_b(int_op_b'HIGH) & int_op_b(int_op_b'HIGH downto int_op_b'LOW));

    return i_result;
end function signed_add;

function signed_mult(op_a : signed; op_b : signed) return signed is
    variable i_result : signed(op_a'HIGH-op_a'LOW+1+op_b'HIGH-op_b'LOW downto 0);
begin
    -- perform the full multiplication
    i_result := op_a * op_b;

    -- remove the extra bit incorrectly generated by the signed math
    return (i_result(i_result'HIGH) & i_result(i_result'HIGH-2 downto 0));
end function signed_mult;

function get_range_int(data_in : integer; high_bit : integer; low_bit : integer) return integer is
    variable unsigned_value : unsigned (31 downto 0) := unsigned(to_signed(data_in, 32));
begin
    return(to_integer(unsigned_value(high_bit downto low_bit)));
end function get_range_int;



function cat_unsigned( x : in unsigned; x_hi : in natural; x_lo : in natural; y : in unsigned ; y_hi : in natural ; y_lo : in natural) return unsigned is
    variable result : unsigned( (x_hi-x_lo) + (y_hi-y_lo) + 1 downto 0);
    variable k      : natural;
begin
    assert( (x_hi >= x_lo) and (y_hi >= y_lo) );

    k:=0;
    for j in x_hi to x_lo loop
        if x(j)='1' then
            result(result'HIGH - k) := '1';
        else 
            result(result'HIGH - k) := '0';
        end if;
        k:=k+1;
    end loop;

   
    for j in y_hi to y_lo  loop
        if y(j)='1' then
            result(result'HIGH-k):='1';
        else
            result(result'HIGH-k):='0';
        end if;
        k:=k+1;
    end loop;

    return result;
end function;


function cat_signed(  x : in signed; x_hi : in natural; x_lo : in natural; y : in signed ; y_hi : in natural ; y_lo : in natural) return signed is
    variable result : signed((x_hi-x_lo) + (y_hi-y_lo) + 1 downto 0);
    variable k      : natural;
begin
    assert( (x_hi >= x_lo) and (y_hi >= y_lo) );

    k:=0;
    for j in x_hi to x_lo loop
        if x(j)='1' then
            result(result'HIGH - k) := '1';
        else 
            result(result'HIGH - k) := '0';
        end if;
        k:=k+1;
    end loop;

   
    for j in y_hi to y_lo  loop
        if y(j)='1' then
            result(result'HIGH-k):='1';
        else
            result(result'HIGH-k):='0';
        end if;
        k:=k+1;
    end loop;

    return result;

end function ;


function reduction_or ( x : in unsigned ) return std_logic is
    variable return_sl : std_logic;
begin
    if x /= 0 then
        return_sl := '1';
    else
        return_sl := '0';
    end if;
    return return_sl;
end function reduction_or;

function reduction_and ( x : in unsigned ) return std_logic is
    variable return_sl : std_logic;
    constant kCOMPARE_VALUE : unsigned(x'range) := (others => '1');
begin
    if x = kCOMPARE_VALUE then
        return_sl := '1';
    else
        return_sl := '0';
    end if;
    return return_sl;
end function reduction_and;

function max(a : integer; b : integer) return integer is
    variable return_int : integer;
begin
    if a < b then
        return_int := b;
    else
        return_int := a;
    end if;

    return return_int;
end function max;

end package body vid_edid_v1_0_0_common_pkg;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- vid_edid_v1_0_0_multiplexor.vhd - entity/architecture pair
------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_multiplexor.vhd
-- Version:         v1.00a
-- Description:     The vid_edid_v1_0_0_multiplexor module multiplexes APB signals from
--                  different APB slaves depending on the selected APB slave.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- vid_edid_v1_0_0_axi_apb_bridge.vhd
--              -- vid_edid_v1_0_0_psel_decoder.vhd
--              -- vid_edid_v1_0_0_multiplexor.vhd
--              -- vid_edid_v1_0_0_axilite_sif.vhd
--              -- vid_edid_v1_0_0_apb_mif.vhd
--
-------------------------------------------------------------------------------
-- Author:      USM
-- History:
--   USM      07/30/2010
-- ^^^^^^^
-- ~~~~~~~
-------------------------------------------------------------------------------
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.std_logic_unsigned.all;
use     IEEE.numeric_std.all;

entity vid_edid_v1_0_0_multiplexor is
  generic (

    C_M_APB_DATA_WIDTH  : integer range 32 to 32   := 32;
    C_APB_NUM_SLAVES    : integer range 1 to 16    := 4
        );

  port (
    M_APB_PCLK          : in std_logic;
    M_APB_PRESETN       : in std_logic;
    M_APB_PREADY        : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PRDATA1       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA2       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA3       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA4       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA5       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA6       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA7       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA8       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA9       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA10      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA11      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA12      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA13      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA14      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA15      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA16      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PSLVERR       : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PSEL          : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    PSEL_i              : in  std_logic;
    apb_pslverr         : out std_logic;
    apb_pready          : out std_logic;
    apb_prdata          : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    sl_pselect          : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0)
    );

end entity vid_edid_v1_0_0_multiplexor;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture RTL of vid_edid_v1_0_0_multiplexor is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

-------------------------------------------------------------------------------
 -- Signal declarations
-------------------------------------------------------------------------------

     signal M_APB_PSEL_i : std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);

begin

     M_APB_PSEL <= M_APB_PSEL_i;

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 1
-- ****************************************************************************

    GEN_1_SELECT_SLAVE : if C_APB_NUM_SLAVES = 1 generate
    begin

-------------------------------------------------------------------------------
 -- PSLVERR, PREADY, PRDATA are directly assigned as only one slave is on APB
-------------------------------------------------------------------------------

         apb_pslverr <= M_APB_PSLVERR(0);
         apb_pready <= M_APB_PREADY(0);
         apb_prdata <= M_APB_PRDATA1;

-------------------------------------------------------------------------------
 -- Slave select signal is assigned after decoding the address
-------------------------------------------------------------------------------

        PSEL_1_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i(0) <= PSEL_i;
                end if;
            end if;
        end process PSEL_1_PROCESS;

    end generate GEN_1_SELECT_SLAVE;

-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 2
-- ****************************************************************************

    GEN_2_SELECT_SLAVE : if C_APB_NUM_SLAVES = 2 generate

        signal pselect_i     : std_logic_vector(1 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_2_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is                        
                        when "10" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "01" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_2_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_2_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "10" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "01" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_2_SL_SIGNALS;

    end generate GEN_2_SELECT_SLAVE;

-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 3
-- ****************************************************************************

    GEN_3_SELECT_SLAVE : if C_APB_NUM_SLAVES = 3 generate

        signal pselect_i     : std_logic_vector(2 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_3_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_3_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_3_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_3_SL_SIGNALS;

    end generate GEN_3_SELECT_SLAVE;

-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 4
-- ****************************************************************************

    GEN_4_SELECT_SLAVE : if C_APB_NUM_SLAVES = 4 generate

        signal pselect_i     : std_logic_vector(3 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_4_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "1000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "0100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "0010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "0001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_4_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_4_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "1000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "0100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "0010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "0001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_4_SL_SIGNALS;

    end generate GEN_4_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 5
-- ****************************************************************************

    GEN_5_SELECT_SLAVE : if C_APB_NUM_SLAVES = 5 generate

        signal pselect_i     : std_logic_vector(4 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_5_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "10000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "01000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "00100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "00010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "00001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_5_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_5_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "10000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "01000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "00100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "00010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "00001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_5_SL_SIGNALS;

    end generate GEN_5_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 6
-- ****************************************************************************

    GEN_6_SELECT_SLAVE : if C_APB_NUM_SLAVES = 6 generate

        signal pselect_i     : std_logic_vector(5 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_6_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                   M_APB_PSEL_i <= (others => '0');
                   case pselect_i is
                        when "100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_6_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_6_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_6_SL_SIGNALS;

    end generate GEN_6_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 7
-- ****************************************************************************

    GEN_7_SELECT_SLAVE : if C_APB_NUM_SLAVES = 7 generate

        signal pselect_i     : std_logic_vector(6 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_7_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "1000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "0100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "0010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "0001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "0000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "0000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "0000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_7_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_7_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "1000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "0100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "0010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "0001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "0000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "0000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "0000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_7_SL_SIGNALS;

    end generate GEN_7_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 8
-- ****************************************************************************

    GEN_8_SELECT_SLAVE : if C_APB_NUM_SLAVES = 8 generate

        signal pselect_i     : std_logic_vector(7 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_8_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "10000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "01000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "00100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "00010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "00001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "00000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "00000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "00000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_8_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_8_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "10000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "01000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "00100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "00010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "00001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "00000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "00000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "00000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_8_SL_SIGNALS;

    end generate GEN_8_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 9
-- ****************************************************************************

    GEN_9_SELECT_SLAVE : if C_APB_NUM_SLAVES = 9 generate

        signal pselect_i     : std_logic_vector(8 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_9_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_9_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_9_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_9_SL_SIGNALS;

    end generate GEN_9_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 10
-- ****************************************************************************

    GEN_10_SELECT_SLAVE : if C_APB_NUM_SLAVES = 10 generate

        signal pselect_i     : std_logic_vector(9 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_10_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                   M_APB_PSEL_i <= (others => '0');
                   case pselect_i is
                        when "1000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "0100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "0010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "0001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "0000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "0000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "0000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "0000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "0000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "0000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_10_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_10_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "1000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "0100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "0010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "0001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "0000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "0000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "0000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "0000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "0000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "0000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_10_SL_SIGNALS;

    end generate GEN_10_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 11
-- ****************************************************************************

    GEN_11_SELECT_SLAVE : if C_APB_NUM_SLAVES = 11 generate

        signal pselect_i     : std_logic_vector(10 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_11_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                   M_APB_PSEL_i <= (others => '0');
                   case pselect_i is
                        when "10000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "01000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "00100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "00010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "00001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "00000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "00000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "00000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "00000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "00000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "00000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_11_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_11_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "10000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "01000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "00100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "00010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "00001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "00000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "00000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "00000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "00000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "00000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "00000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_11_SL_SIGNALS;

    end generate GEN_11_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 12
-- ****************************************************************************

    GEN_12_SELECT_SLAVE : if C_APB_NUM_SLAVES = 12 generate

        signal pselect_i     : std_logic_vector(11 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_12_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "100000000000" =>
                            M_APB_PSEL_i(11) <= PSEL_i;
                        when "010000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "001000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "000100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "000010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "000001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "000000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "000000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "000000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "000000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "000000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "000000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_12_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_12_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA12,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "100000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(11);
                    apb_pready <= M_APB_PREADY(11);
                    apb_prdata <= M_APB_PRDATA12;
                when "010000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "001000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "000100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "000010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "000001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "000000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "000000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "000000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "000000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "000000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "000000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_12_SL_SIGNALS;

    end generate GEN_12_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 13
-- ****************************************************************************

    GEN_13_SELECT_SLAVE : if C_APB_NUM_SLAVES = 13 generate

        signal pselect_i     : std_logic_vector(12 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_13_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                   M_APB_PSEL_i <= (others => '0');
                   case pselect_i is
                        when "1000000000000" =>
                            M_APB_PSEL_i(12) <= PSEL_i;
                        when "0100000000000" =>
                            M_APB_PSEL_i(11) <= PSEL_i;
                        when "0010000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "0001000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "0000100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "0000010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "0000001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "0000000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "0000000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "0000000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "0000000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "0000000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "0000000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_13_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_13_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA13,
                                    M_APB_PRDATA12,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "1000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(12);
                    apb_pready <= M_APB_PREADY(12);
                    apb_prdata <= M_APB_PRDATA13;
                when "0100000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(11);
                    apb_pready <= M_APB_PREADY(11);
                    apb_prdata <= M_APB_PRDATA12;
                when "0010000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "0001000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "0000100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "0000010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "0000001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "0000000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "0000000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "0000000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "0000000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "0000000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "0000000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_13_SL_SIGNALS;

    end generate GEN_13_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 14
-- ****************************************************************************

    GEN_14_SELECT_SLAVE : if C_APB_NUM_SLAVES = 14 generate

        signal pselect_i     : std_logic_vector(13 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_14_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "10000000000000" =>
                            M_APB_PSEL_i(13) <= PSEL_i;
                        when "01000000000000" =>
                            M_APB_PSEL_i(12) <= PSEL_i;
                        when "00100000000000" =>
                            M_APB_PSEL_i(11) <= PSEL_i;
                        when "00010000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "00001000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "00000100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "00000010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "00000001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "00000000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "00000000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "00000000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "00000000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "00000000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "00000000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_14_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_14_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA14,
                                    M_APB_PRDATA13,
                                    M_APB_PRDATA12,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "10000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(13);
                    apb_pready <= M_APB_PREADY(13);
                    apb_prdata <= M_APB_PRDATA14;
                when "01000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(12);
                    apb_pready <= M_APB_PREADY(12);
                    apb_prdata <= M_APB_PRDATA13;
                when "00100000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(11);
                    apb_pready <= M_APB_PREADY(11);
                    apb_prdata <= M_APB_PRDATA12;
                when "00010000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "00001000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "00000100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "00000010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "00000001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "00000000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "00000000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "00000000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "00000000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "00000000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "00000000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_14_SL_SIGNALS;

    end generate GEN_14_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 15
-- ****************************************************************************

    GEN_15_SELECT_SLAVE : if C_APB_NUM_SLAVES = 15 generate

        signal pselect_i     : std_logic_vector(14 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_15_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others => '0');
                    case pselect_i is
                        when "100000000000000" =>
                            M_APB_PSEL_i(14) <= PSEL_i;
                        when "010000000000000" =>
                            M_APB_PSEL_i(13) <= PSEL_i;
                        when "001000000000000" =>
                            M_APB_PSEL_i(12) <= PSEL_i;
                        when "000100000000000" =>
                            M_APB_PSEL_i(11) <= PSEL_i;
                        when "000010000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "000001000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "000000100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "000000010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "000000001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "000000000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "000000000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "000000000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "000000000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "000000000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "000000000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others => '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_15_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_15_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA15,
                                    M_APB_PRDATA14,
                                    M_APB_PRDATA13,
                                    M_APB_PRDATA12,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "100000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(14);
                    apb_pready <= M_APB_PREADY(14);
                    apb_prdata <= M_APB_PRDATA15;
                when "010000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(13);
                    apb_pready <= M_APB_PREADY(13);
                    apb_prdata <= M_APB_PRDATA14;
                when "001000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(12);
                    apb_pready <= M_APB_PREADY(12);
                    apb_prdata <= M_APB_PRDATA13;
                when "000100000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(11);
                    apb_pready <= M_APB_PREADY(11);
                    apb_prdata <= M_APB_PRDATA12;
                when "000010000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "000001000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "000000100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "000000010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "000000001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "000000000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "000000000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "000000000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "000000000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "000000000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "000000000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_15_SL_SIGNALS;

    end generate GEN_15_SELECT_SLAVE;
-- ****************************************************************************
-- Multiplexing logic when C_APB_NUM_SLAVES = 16
-- ****************************************************************************

    GEN_16_SELECT_SLAVE : if C_APB_NUM_SLAVES = 16 generate

        signal pselect_i     : std_logic_vector(15 downto 0);

    begin

-------------------------------------------------------------------------------
 -- pselect_i assignment.
-------------------------------------------------------------------------------
      
        pselect_i <= sl_pselect;

-------------------------------------------------------------------------------
 -- Process for the generation of PSEL depending on the selected slave.
-------------------------------------------------------------------------------
        PSEL_16_PROCESS : process (M_APB_PCLK ) is
        begin
            if (M_APB_PCLK'event and M_APB_PCLK = '1') then
                if (M_APB_PRESETN = '0') then
                    M_APB_PSEL_i <= (others => '0');
                else
                    M_APB_PSEL_i <= (others=> '0');
                    case pselect_i is
                        when "1000000000000000" =>
                            M_APB_PSEL_i(15) <= PSEL_i;
                        when "0100000000000000" =>
                            M_APB_PSEL_i(14) <= PSEL_i;
                        when "0010000000000000" =>
                            M_APB_PSEL_i(13) <= PSEL_i;
                        when "0001000000000000" =>
                            M_APB_PSEL_i(12) <= PSEL_i;
                        when "0000100000000000" =>
                            M_APB_PSEL_i(11) <= PSEL_i;
                        when "0000010000000000" =>
                            M_APB_PSEL_i(10) <= PSEL_i;
                        when "0000001000000000" =>
                            M_APB_PSEL_i(9) <= PSEL_i;
                        when "0000000100000000" =>
                            M_APB_PSEL_i(8) <= PSEL_i;
                        when "0000000010000000" =>
                            M_APB_PSEL_i(7) <= PSEL_i;
                        when "0000000001000000" =>
                            M_APB_PSEL_i(6) <= PSEL_i;
                        when "0000000000100000" =>
                            M_APB_PSEL_i(5) <= PSEL_i;
                        when "0000000000010000" =>
                            M_APB_PSEL_i(4) <= PSEL_i;
                        when "0000000000001000" =>
                            M_APB_PSEL_i(3) <= PSEL_i;
                        when "0000000000000100" =>
                            M_APB_PSEL_i(2) <= PSEL_i;
                        when "0000000000000010" =>
                            M_APB_PSEL_i(1) <= PSEL_i;
                        when "0000000000000001" =>
                            M_APB_PSEL_i(0) <= PSEL_i;
                    -- coverage off
                       when others =>
                            M_APB_PSEL_i <= (others=> '0');
                    -- coverage on
                    end case;
                end if;
            end if;
        end process PSEL_16_PROCESS;

-------------------------------------------------------------------------------
 -- Combo for the generation of PSLVERR, PREADY, PRDATA depending on the
 -- selected slave.
-------------------------------------------------------------------------------
        MUX_16_SL_SIGNALS : process (pselect_i,
                                    M_APB_PSLVERR,
                                    M_APB_PREADY,
                                    M_APB_PRDATA16,
                                    M_APB_PRDATA15,
                                    M_APB_PRDATA14,
                                    M_APB_PRDATA13,
                                    M_APB_PRDATA12,
                                    M_APB_PRDATA11,
                                    M_APB_PRDATA10,
                                    M_APB_PRDATA9,
                                    M_APB_PRDATA8,
                                    M_APB_PRDATA7,
                                    M_APB_PRDATA6,
                                    M_APB_PRDATA5,
                                    M_APB_PRDATA4,
                                    M_APB_PRDATA3,
                                    M_APB_PRDATA2,
                                    M_APB_PRDATA1) is
        begin
            case pselect_i is
                when "1000000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(15);
                    apb_pready <= M_APB_PREADY(15);
                    apb_prdata <= M_APB_PRDATA16;
                when "0100000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(14);
                    apb_pready <= M_APB_PREADY(14);
                    apb_prdata <= M_APB_PRDATA15;
                when "0010000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(13);
                    apb_pready <= M_APB_PREADY(13);
                    apb_prdata <= M_APB_PRDATA14;
                when "0001000000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(12);
                    apb_pready <= M_APB_PREADY(12);
                    apb_prdata <= M_APB_PRDATA13;
                when "0000100000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(11);
                    apb_pready <= M_APB_PREADY(11);
                    apb_prdata <= M_APB_PRDATA12;
                when "0000010000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(10);
                    apb_pready <= M_APB_PREADY(10);
                    apb_prdata <= M_APB_PRDATA11;
                when "0000001000000000" =>
                    apb_pslverr <= M_APB_PSLVERR(9);
                    apb_pready <= M_APB_PREADY(9);
                    apb_prdata <= M_APB_PRDATA10;
                when "0000000100000000" =>
                    apb_pslverr <= M_APB_PSLVERR(8);
                    apb_pready <= M_APB_PREADY(8);
                    apb_prdata <= M_APB_PRDATA9;
                when "0000000010000000" =>
                    apb_pslverr <= M_APB_PSLVERR(7);
                    apb_pready <= M_APB_PREADY(7);
                    apb_prdata <= M_APB_PRDATA8;
                when "0000000001000000" =>
                    apb_pslverr <= M_APB_PSLVERR(6);
                    apb_pready <= M_APB_PREADY(6);
                    apb_prdata <= M_APB_PRDATA7;
                when "0000000000100000" =>
                    apb_pslverr <= M_APB_PSLVERR(5);
                    apb_pready <= M_APB_PREADY(5);
                    apb_prdata <= M_APB_PRDATA6;
                when "0000000000010000" =>
                    apb_pslverr <= M_APB_PSLVERR(4);
                    apb_pready <= M_APB_PREADY(4);
                    apb_prdata <= M_APB_PRDATA5;
                when "0000000000001000" =>
                    apb_pslverr <= M_APB_PSLVERR(3);
                    apb_pready <= M_APB_PREADY(3);
                    apb_prdata <= M_APB_PRDATA4;
                when "0000000000000100" =>
                    apb_pslverr <= M_APB_PSLVERR(2);
                    apb_pready <= M_APB_PREADY(2);
                    apb_prdata <= M_APB_PRDATA3;
                when "0000000000000010" =>
                    apb_pslverr <= M_APB_PSLVERR(1);
                    apb_pready <= M_APB_PREADY(1);
                    apb_prdata <= M_APB_PRDATA2;
                when "0000000000000001" =>
                    apb_pslverr <= M_APB_PSLVERR(0);
                    apb_pready <= M_APB_PREADY(0);
                    apb_prdata <= M_APB_PRDATA1;
            -- coverage off
               when others =>
                    apb_pslverr <= '0';
                    apb_pready <= '0';
                    apb_prdata <= (others => '0');
            -- coverage on
            end case;
        end process MUX_16_SL_SIGNALS;

    end generate GEN_16_SELECT_SLAVE;
end architecture RTL;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- axilite_slif.vhd - entity/architecture pair
-------------------------------------------------------------------------------
-- Filename:        axilite_slif.vhd
-- Version:         v1.00a
-- Description:     The AXI4-Lite Slave Interface module provides a
--                  bi-directional slave interface to the AXI. The AXI data
--                  bus width is always fixed to 32-bits. When both write and
--                  read transfers are simultaneously requested on AXI4-Lite,
--                  read requestis given more priority than write request.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- vid_edid_v1_0_0_axi_apb_bridge.vhd
--              -- vid_edid_v1_0_0_psel_decoder.vhd
--              -- vid_edid_v1_0_0_multiplexor.vhd
--              -- vid_edid_v1_0_0_axilite_sif.vhd
--              -- vid_edid_v1_0_0_apb_mif.vhd
--
-------------------------------------------------------------------------------
-- Author:      USM
-- History:
--   USM      07/30/2010   Initial version
-- ^^^^^^^
-- ~~~~~~~
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--library proc_common_v3_00_a;
--use proc_common_v3_00_a.vid_edid_v1_0_0_proc_common_pkg.clog2;
--use proc_common_v3_00_a.vid_edid_v1_0_0_counter_f;
use work.vid_edid_v1_0_0_proc_common_pkg.clog2;

entity vid_edid_v1_0_0_axilite_sif is
  generic (
    C_FAMILY              : string                   := "virtex6";
    C_S_AXI_ADDR_WIDTH    : integer range 32 to 32   := 32;
    C_S_AXI_DATA_WIDTH    : integer range 32 to 32   := 32;
    C_DPHASE_TIMEOUT      : integer range 0 to 256   := 0;
    C_M_APB_PROTOCOL      : string                   := "apb3"
    );
  port (
  -- AXI Signals
    S_AXI_ACLK       : in  std_logic;
    S_AXI_ARESETN    : in  std_logic;

    S_AXI_AWADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWPROT     : in  std_logic_vector(2 downto 0);
    S_AXI_AWVALID    : in  std_logic;
    S_AXI_AWREADY    : out std_logic;
    S_AXI_WVALID     : in  std_logic;
    S_AXI_WREADY     : out std_logic;
    S_AXI_BRESP      : out std_logic_vector(1 downto 0);
    S_AXI_BVALID     : out std_logic;
    S_AXI_BREADY     : in  std_logic;

    S_AXI_ARADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID    : in  std_logic;
    S_AXI_ARREADY    : out std_logic;
    S_AXI_RDATA      : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP      : out std_logic_vector(1 downto 0);
    S_AXI_RVALID     : out std_logic;
    S_AXI_RREADY     : in  std_logic;

  -- Signals from other modules
    axi_awprot       : out  std_logic_vector(2 downto 0);
    address          : out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    apb_rd_request   : out std_logic;
    apb_wr_request   : out std_logic;
    dphase_timeout   : out std_logic;
    apb_pready       : in  std_logic;
    slv_err_resp     : in  std_logic;
    rd_data          : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
    );

end entity vid_edid_v1_0_0_axilite_sif;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture RTL of vid_edid_v1_0_0_axilite_sif is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

-------------------------------------------------------------------------------
-- This function generates the number of address bits to be compared depending
-- upon the selected base and high addresses.
-------------------------------------------------------------------------------

    type  AXI_SM_TYPE is (AXI_IDLE,
                          WRITE,
                          WRITE_W_WAIT,
                          WRITE_WAIT,
                          WR_RESP,
                          READ,
                          READ_WAIT,
                          RD_RESP);

-------------------------------------------------------------------------------
 -- Signal declarations
-------------------------------------------------------------------------------

    signal axi_wr_rd_ns   : AXI_SM_TYPE;
    signal axi_wr_rd_cs   : AXI_SM_TYPE;

    signal ARREADY_i      : std_logic;
    signal WREADY_i       : std_logic;
    signal AWREADY_i      : std_logic;
    signal BVALID_i       : std_logic;
    signal BRESP_1_i      : std_logic;
    signal RVALID_i       : std_logic;
    signal RRESP_1_i      : std_logic;

    signal write_ready_sm : std_logic;
    signal waddr_ready_sm : std_logic;
    signal arready_sm     : std_logic;
    signal BVALID_sm      : std_logic;
    signal RVALID_sm      : std_logic;

    signal load_cntr      : std_logic;
    signal data_timeout   : std_logic;
    signal both_valids    : std_logic;
    signal address_i      : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal send_rd        : std_logic;
    signal send_wr_resp   : std_logic;
    signal cntr_enable    : std_logic;
    signal wr_request     : std_logic;
    signal rd_request     : std_logic;
    signal awprot : std_logic_vector(2 downto 0);
    
-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
component vid_edid_v1_0_0_counter_f is
    generic(
            C_NUM_BITS : integer := 9;
            C_FAMILY   : string := "nofamily"
           );

    port(
         Clk           : in  std_logic;
         Rst           : in  std_logic;
         Load_In       : in  std_logic_vector(C_NUM_BITS - 1 downto 0);
         Count_Enable  : in  std_logic;
         Count_Load    : in  std_logic;
         Count_Down    : in  std_logic;
         Count_Out     : out std_logic_vector(C_NUM_BITS - 1 downto 0);
         Carry_Out     : out std_logic
        );
end component;

begin

-------------------------------------------------------------------------------
-- I/O signal assignments
-------------------------------------------------------------------------------

    S_AXI_AWREADY         <= AWREADY_i;

    S_AXI_WREADY          <= WREADY_i;

    S_AXI_BRESP(0)        <= '0';
    S_AXI_BRESP(1)        <= BRESP_1_i;
    S_AXI_BVALID          <= BVALID_i;

    S_AXI_ARREADY         <= ARREADY_i;

    S_AXI_RRESP(0)        <= '0';
    S_AXI_RRESP(1)        <= RRESP_1_i;
    S_AXI_RVALID          <= RVALID_i;

-------------------------------------------------------------------------------
-- Data phase timeout to APB, read and write request assignments
-------------------------------------------------------------------------------

    dphase_timeout <= data_timeout;
    apb_rd_request <= rd_request;
    apb_wr_request <= wr_request;

-------------------------------------------------------------------------------
-- Address generation for generating slave select
-------------------------------------------------------------------------------

   ADDR_REG : process(S_AXI_ACLK) is
   begin
      if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
          if (S_AXI_ARESETN = '0') then
             address_i <= (others => '0');
          else
             if (waddr_ready_sm = '1') then
                   address_i <= S_AXI_AWADDR;
             elsif (rd_request = '1') then
                   address_i <= S_AXI_ARADDR;
             end if;
          end if;
      end if;
   end process ADDR_REG;

-------------------------------------------------------------------------------
-- Address assignment for saving one cycle
-------------------------------------------------------------------------------

    address <= S_AXI_ARADDR when rd_request = '1' else
               S_AXI_AWADDR when waddr_ready_sm = '1' else
               address_i;

-- ****************************************************************************
-- This generate is used when APB4 is selected
-- ****************************************************************************
    GEN_APB4_WRITE_PROT_INVALID : if (C_M_APB_PROTOCOL /= "apb4") generate
        axi_awprot <= (others=>'0'); 
    end generate GEN_APB4_WRITE_PROT_INVALID;

    GEN_APB4_WRITE_PROT : if C_M_APB_PROTOCOL = "apb4" generate

          signal awprot : std_logic_vector(2 downto 0);
    begin
  
-------------------------------------------------------------------------------
-- Write PROT generation for APB
-------------------------------------------------------------------------------

        axi_awprot <= S_AXI_AWPROT when both_valids = '1' else awprot; 
    
-- ****************************************************************************
-- This process is used for registering the AXI protection when a write 
-- is requested. 
-- ****************************************************************************

       AXI_WRITE_PROT_REG : process(S_AXI_ACLK) is
       begin
          if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
              if (S_AXI_ARESETN = '0') then
                 awprot <= (others => '0');
              else
                 if (waddr_ready_sm = '1') then
                       awprot <= S_AXI_AWPROT;
                 end if;
              end if;
          end if;
       end process AXI_WRITE_PROT_REG;
   
   end generate GEN_APB4_WRITE_PROT;

-- ****************************************************************************
-- This process is used for registering the APB read data that needs to be
-- sent on AXI
-- ****************************************************************************

    RD_RESP_REG : process(S_AXI_ACLK) is
    begin
       if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
          if (S_AXI_ARESETN = '0') then
             RRESP_1_i <= '0';
          else
             if (send_rd = '1') then
                 RRESP_1_i <= slv_err_resp;
             elsif (S_AXI_RREADY = '1') then
                 RRESP_1_i <= '0';
             end if;
          end if;
      end if;
   end process RD_RESP_REG;

-- ****************************************************************************
-- This process is used for registering Read response
-- ****************************************************************************

    RD_DATA_REG : process(S_AXI_ACLK) is
    begin
       if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
          if (S_AXI_ARESETN = '0') then
             S_AXI_RDATA <= (others => '0');
          else
             if (send_rd = '1') then
                 S_AXI_RDATA <= rd_data;
             elsif (S_AXI_RREADY = '1') then
                 S_AXI_RDATA <= (others => '0');
             end if;
          end if;
      end if;
   end process RD_DATA_REG;

-- ****************************************************************************
-- This process is used for registering Write response
-- ****************************************************************************

   WR_RESP_REG : process(S_AXI_ACLK) is
   begin
       if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
          if (S_AXI_ARESETN = '0') then
             BRESP_1_i <= '0';
          else
             if (send_wr_resp = '1') then
                 BRESP_1_i <= slv_err_resp;
             elsif (S_AXI_BREADY = '1') then
                 BRESP_1_i <= '0';
             end if;
          end if;
      end if;
   end process WR_RESP_REG;

-------------------------------------------------------------------------------
-- FSM
-------------------------------------------------------------------------------
-- ****************************************************************************
-- AXI Write Read State Machine -- START
-- ****************************************************************************

   AXI_WR_RD_SM   : process (axi_wr_rd_cs,
                             S_AXI_AWVALID,
                             S_AXI_WVALID,
                             S_AXI_BREADY,
                             S_AXI_ARVALID,
                             S_AXI_RREADY,
                             apb_pready,
                             data_timeout
                             ) is
   begin

      axi_wr_rd_ns <= axi_wr_rd_cs;
      write_ready_sm <= '0';
      waddr_ready_sm <= '0';
      wr_request <= '0';
      rd_request <= '0';
      BVALID_sm <= '0';
      RVALID_sm <= '0';
      arready_sm <= '0';
      load_cntr <= '0';
      both_valids <= '0';
      send_rd <= '0';
      send_wr_resp <= '0';
      cntr_enable <= '0';

      case axi_wr_rd_cs is

           when AXI_IDLE =>
                if (S_AXI_ARVALID = '1') then
                     rd_request <= '1';
                     load_cntr <= '1';
                     arready_sm <= '1';
                     axi_wr_rd_ns <= READ_WAIT;
                elsif(S_AXI_AWVALID = '1' and
                      S_AXI_WVALID = '1') then
                     write_ready_sm <= '1';
                     waddr_ready_sm <= '1';
                     wr_request <= '1';
                     both_valids <= '1';
                     load_cntr <= '1';
                     axi_wr_rd_ns <= WRITE_WAIT;
                elsif(S_AXI_AWVALID = '1') then
                     waddr_ready_sm <= '1';
                     axi_wr_rd_ns <= WRITE_W_WAIT;
                end if;

           when WRITE_WAIT =>
                cntr_enable <= '1';
                axi_wr_rd_ns <= WRITE;

           when WRITE_W_WAIT =>
                if(S_AXI_WVALID = '1') then
                     write_ready_sm <= '1';
                     wr_request <= '1';
                     load_cntr <= '1';
                     axi_wr_rd_ns <= WRITE;
                end if;

           when WRITE =>
                cntr_enable <= '1';
                if(apb_pready = '1' or data_timeout = '1') then
                     cntr_enable <= '0';
                     send_wr_resp <= '1';
                     BVALID_sm <= '1';
                     axi_wr_rd_ns <= WR_RESP;
                end if;

           when WR_RESP =>
                if (S_AXI_BREADY = '1') then
                    axi_wr_rd_ns <= AXI_IDLE;
                else
                    BVALID_sm <= '1';
                end if;

           when READ_WAIT =>
                cntr_enable <= '1';
                axi_wr_rd_ns <= READ;

           when READ =>
                cntr_enable <= '1';
                if(apb_pready = '1' or data_timeout = '1') then
                     cntr_enable <= '0';
                     RVALID_sm <= '1';
                     send_rd <= '1';
                     axi_wr_rd_ns <= RD_RESP;
                end if;

           when RD_RESP =>                
                if(S_AXI_RREADY = '1') then
                     if(S_AXI_AWVALID = '1' and
                        S_AXI_WVALID = '1') then
                          write_ready_sm <= '1';
                          waddr_ready_sm <= '1';
                          wr_request <= '1';
                          load_cntr <= '1';
                          both_valids <= '1';
                          axi_wr_rd_ns <= WRITE_WAIT;
                     elsif(S_AXI_AWVALID = '1') then
                          waddr_ready_sm <= '1';
                          axi_wr_rd_ns <= WRITE_W_WAIT;
                     else
                          axi_wr_rd_ns <= AXI_IDLE;
                     end if;
                else
                     RVALID_sm <= '1';
                end if;

          -- coverage off
           when others =>
                axi_wr_rd_ns <= AXI_IDLE;
          -- coverage on

       end case;

   end process AXI_WR_RD_SM;

-------------------------------------------------------------------------------
-- Registering the signals generated from the AXI_WR_RD_SM state machine
-------------------------------------------------------------------------------

   AXI_WR_DATA_SM_REG : process(S_AXI_ACLK) is
   begin
      if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
         if (S_AXI_ARESETN = '0') then
             axi_wr_rd_cs <= AXI_IDLE;
             ARREADY_i <= '0';
             WREADY_i <= '0';
             AWREADY_i <= '0';
             BVALID_i <= '0';
             RVALID_i <= '0';
         else
             axi_wr_rd_cs <= axi_wr_rd_ns;
             WREADY_i <= write_ready_sm;
             AWREADY_i <= waddr_ready_sm;
             ARREADY_i <= arready_sm;
             BVALID_i <= BVALID_sm;
             RVALID_i <= RVALID_sm;
         end if;
      end if;
   end process AXI_WR_DATA_SM_REG;
   
   -------------------------------------------------------------------------------
   -- This implements the dataphase watchdog timeout function. The counter is
   -- allowed to count down when an active APB operation is ongoing. A data 
   -- acknowledge from the target address space forces the counter to reload.
   -- When the APB is not responding and not generating apb_ready within the
   -- number of clock cycles mentioned in C_DPHASE_TIMEOUT, AXI generates
   -- ready so that AXI is not hung.
   ------------------------------------------------------------------------------- 
    
   DATA_PHASE_WDT : if (C_DPHASE_TIMEOUT /= 0) generate
    
    
       constant TIMEOUT_VALUE_TO_USE : integer := C_DPHASE_TIMEOUT;
       constant COUNTER_WIDTH        : Integer := clog2(TIMEOUT_VALUE_TO_USE);
       constant DPTO_LD_VALUE        : std_logic_vector(COUNTER_WIDTH-1 downto 0)
                                     := std_logic_vector(to_unsigned
                                        (TIMEOUT_VALUE_TO_USE-1,COUNTER_WIDTH));
       signal timeout_i              : std_logic;
       signal cntr_start             : std_logic;
       signal cntr_rst               : std_logic;
    
   begin
          
   
-- ****************************************************************************
-- This process is used for generating the counter enable
-- ****************************************************************************

   WR_RESP_REG : process(S_AXI_ACLK) is
   begin
       if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
          if (S_AXI_ARESETN = '0') then
             cntr_start <= '0';
          else
             if (load_cntr = '1') then
                 cntr_start <= '1';
             elsif (timeout_i = '1') then
                 cntr_start <= '0';
             end if;
          end if;
      end if;
   end process WR_RESP_REG;
   
   cntr_rst <= not S_AXI_ARESETN or timeout_i;
   
-- ****************************************************************************
-- Instantiation of counter from proc_common
-- ****************************************************************************

      --I_DPTO_COUNTER : entity proc_common_v3_00_a.vid_edid_v1_0_0_counter_f
      I_DPTO_COUNTER : vid_edid_v1_0_0_counter_f
         generic map(
           C_NUM_BITS    =>  COUNTER_WIDTH,
           C_FAMILY      =>  C_FAMILY
             )
         port map(
           Clk           =>  S_AXI_ACLK,
           Rst           =>  cntr_rst,
           Load_In       =>  DPTO_LD_VALUE,
           Count_Enable  =>  cntr_enable,
           Count_Load    =>  load_cntr,
           Count_Down    =>  '1',
           Count_Out     =>  open,
           Carry_Out     =>  timeout_i
           );
       
-- ****************************************************************************
-- This process is used for registering data_timeout
-- ****************************************************************************

       REG_TIMEOUT : process(S_AXI_ACLK)
       begin
           if(S_AXI_ACLK'EVENT and S_AXI_ACLK='1')then
               if(S_AXI_ARESETN='0')then
                   data_timeout <= '0';
               else
                   if (data_timeout = '1') then
                       data_timeout <= '0';
                   elsif (timeout_i = '1' and apb_pready = '0') then
                       data_timeout <= '1';
                   end if;
               end if;
           end if;
       end process REG_TIMEOUT;
       
   end generate DATA_PHASE_WDT;
   
-- ****************************************************************************
-- No logic when C_DPHASE_TIMEOUT = 0
-- ****************************************************************************

   NO_DATA_PHASE_WDT : if (C_DPHASE_TIMEOUT = 0) generate
   begin
        data_timeout <= '0';
   end generate NO_DATA_PHASE_WDT;

end architecture RTL;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-------------------------------------------------------------------------------
-- vid_edid_v1_0_0_apb_mif.vhd - entity/architecture pair
-------------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_apb_mif.vhd
-- Version:         v1.00a
-- Description:     The APB Master Interface module provides a bi-directional
--                  APB master interface on the APB. This interface can be APB3
--                  or APB4 that supports M_APB_PSTRB and M_APB_PPROT signals.
--                  The APB data bus width is always fixed to 32-bits.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- vid_edid_v1_0_0_axi_apb_bridge.vhd
--              -- vid_edid_v1_0_0_psel_decoder.vhd
--              -- vid_edid_v1_0_0_multiplexor.vhd
--              -- vid_edid_v1_0_0_axilite_sif.vhd
--              -- vid_edid_v1_0_0_apb_mif.vhd
--
-------------------------------------------------------------------------------
-- Author:      USM
-- History:
--   USM      07/30/2010   Initial version
-- ^^^^^^^
-- ~~~~~~~
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vid_edid_v1_0_0_apb_mif is
  generic (
    C_M_APB_ADDR_WIDTH   : integer range 32 to 32   := 32;
    C_M_APB_DATA_WIDTH   : integer range 32 to 32   := 32;
    C_S_AXI_DATA_WIDTH   : integer range 32 to 32   := 32;
    C_APB_NUM_SLAVES     : integer range 1 to 16    := 4;
    C_M_APB_PROTOCOL     : string                   := "apb3"

    );
  port (

  -- APB Signals
    M_APB_PCLK       : in std_logic;
    M_APB_PRESETN    : in std_logic;

    M_APB_PADDR      : out std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    M_APB_PENABLE    : out std_logic;
    M_APB_PWRITE     : out std_logic;
    M_APB_PWDATA     : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PSTRB      : out std_logic_vector
                           ((C_M_APB_DATA_WIDTH/8)-1 downto 0);
    M_APB_PPROT      : out std_logic_vector(2 downto 0);

  -- Signals from other modules
    apb_pslverr      : in  std_logic;
    apb_pready       : in  std_logic;
    apb_rd_request   : in  std_logic;
    apb_wr_request   : in  std_logic;
    dphase_timeout   : in  std_logic;
    apb_prdata       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    rd_data          : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    slv_err_resp     : out std_logic;
    PSEL_i           : out std_logic;
    address          : in  std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    axi_awprot       : in  std_logic_vector(2 downto 0);

  -- AXI Signals
    S_AXI_WDATA      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB      : in  std_logic_vector
                           ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_ARADDR     : in  std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    S_AXI_ARPROT     : in  std_logic_vector(2 downto 0)
    );

end entity vid_edid_v1_0_0_apb_mif;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture RTL of vid_edid_v1_0_0_apb_mif is

    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

    type  APB_SM_TYPE is (APB_IDLE,
                          APB_SETUP,
                          APB_ACCESS
                         );

-------------------------------------------------------------------------------
-- Signal declarations
-------------------------------------------------------------------------------

    signal apb_wr_rd_ns   : APB_SM_TYPE;
    signal apb_wr_rd_cs   : APB_SM_TYPE;

    signal PENABLE_i      : std_logic;
    signal PWRITE_i       : std_logic;
    signal PWDATA_i       : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    signal PADDR_i        : std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);

    signal apb_penable_sm : std_logic;
    signal drive_wr_0s    : std_logic;
    signal apb_psel_sm    : std_logic;

begin

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- APB I/O signal assignments
-------------------------------------------------------------------------------

    M_APB_PADDR           <= PADDR_i;
    M_APB_PENABLE         <= PENABLE_i;
    M_APB_PWRITE          <= PWRITE_i;
    M_APB_PWDATA          <= PWDATA_i;

-------------------------------------------------------------------------------
-- Internal signal assignments
-------------------------------------------------------------------------------

    PSEL_i <= apb_psel_sm;

-- ****************************************************************************
-- This process is used for registering the APB address when a write or a read
-- is requested. To reduce the power consumption the APB_PADDR signal is not
-- changed until a read is requested.
-- ****************************************************************************

   APB_ADDR_REG : process(M_APB_PCLK) is
   begin
      if (M_APB_PCLK'event and M_APB_PCLK = '1') then
          if (M_APB_PRESETN = '0') then
             PADDR_i <= (others => '0');
          else
             if (apb_wr_request = '1') then
                   PADDR_i <= address;
             elsif (apb_rd_request = '1') then
                   PADDR_i <= S_AXI_ARADDR;
             end if;
          end if;
      end if;
   end process APB_ADDR_REG;

-- ****************************************************************************
-- This process is used for registering the APB write signal when a write is
-- requested. To reduce the power consumption the APB_PWRITE signal is not
-- changed until a read is requested.
-- ****************************************************************************

   APB_WRITE_REG : process(M_APB_PCLK) is
   begin
      if (M_APB_PCLK'event and M_APB_PCLK = '1') then
          if (M_APB_PRESETN = '0') then
             PWRITE_i <= '0';
          else
             if (apb_wr_request = '1') then
                   PWRITE_i <= '1';
             elsif (apb_rd_request = '1') then
                   PWRITE_i <= '0';
             end if;
          end if;
      end if;
   end process APB_WRITE_REG;

-- ****************************************************************************
-- This process is used for registering the APB write data when a write is
-- requested.
-- ****************************************************************************

   APB_WR_DATA_REG : process(M_APB_PCLK) is
   begin
      if (M_APB_PCLK'event and M_APB_PCLK = '1') then
          if (M_APB_PRESETN = '0') then
             PWDATA_i <= (others => '0');
          else
             if (apb_wr_request = '1') then
                   PWDATA_i <= S_AXI_WDATA;
             elsif (drive_wr_0s = '1') then
                   PWDATA_i <= (others => '0');
             end if;
          end if;
      end if;
   end process APB_WR_DATA_REG;

-- ****************************************************************************
-- This generate is used when APB4 is selected
-- ****************************************************************************
    GEN_APB4_STRBS_PROT_INVALID : if (C_M_APB_PROTOCOL /= "apb4") generate
        M_APB_PSTRB          <= (others=>'0');
        M_APB_PPROT          <= (others=>'0');
    end generate GEN_APB4_STRBS_PROT_INVALID;

    GEN_APB4_STRBS_PROT : if C_M_APB_PROTOCOL = "apb4" generate

            signal PSTRB_i        : std_logic_vector
                                    ((C_M_APB_DATA_WIDTH/8)-1 downto 0);
            signal PPROT_i         : std_logic_vector(2 downto 0);
    begin

-------------------------------------------------------------------------------
-- APB STRB/PROT signal assignments
-------------------------------------------------------------------------------

        M_APB_PSTRB          <= PSTRB_i;
        M_APB_PPROT          <= PPROT_i;

-- ****************************************************************************
-- This process is used for registering the APB write strobes when a write is
-- requested.
-- ****************************************************************************

       APB_WR_STRB_REG : process(M_APB_PCLK) is
       begin
          if (M_APB_PCLK'event and M_APB_PCLK = '1') then
              if (M_APB_PRESETN = '0') then
                 PSTRB_i <= (others => '0');
              else
                 if (apb_wr_request = '1') then
                       PSTRB_i <= S_AXI_WSTRB;
                 elsif (drive_wr_0s = '1') then
                       PSTRB_i <= (others => '0');
                 end if;
              end if;
          end if;
       end process APB_WR_STRB_REG;

-- ****************************************************************************
-- This process is used for driving the APB PROT when a write or a read
-- is requested. To reduce the power consumption the APB_PPROT signal is not
-- changed until a read is requested.
-- ****************************************************************************

       APB_PROT_REG : process(M_APB_PCLK) is
       begin
          if (M_APB_PCLK'event and M_APB_PCLK = '1') then
              if (M_APB_PRESETN = '0') then
                 PPROT_i <= (others => '0');
              else
                 if (apb_wr_request = '1') then
                       PPROT_i <= axi_awprot;
                 elsif (apb_rd_request = '1') then
                       PPROT_i <= S_AXI_ARPROT;
                 end if;
              end if;
          end if;
       end process APB_PROT_REG;

   end generate GEN_APB4_STRBS_PROT;

-- ****************************************************************************
-- APB State Machine -- START
-- ****************************************************************************

   APB_WR_RD_SM   : process (apb_wr_rd_cs,
                             apb_wr_request,
                             apb_rd_request,
                             apb_pslverr,
                             apb_pready,
                             apb_prdata,
                             dphase_timeout
                            ) is
   begin

     apb_wr_rd_ns <= apb_wr_rd_cs;
     apb_penable_sm <= '0';
     rd_data <= (others => '0');
     slv_err_resp <= '0';
     drive_wr_0s <= '0';
     apb_psel_sm <= '0';

      case apb_wr_rd_cs is

           when APB_IDLE =>
                if(apb_wr_request = '1' or
                   apb_rd_request = '1') then
                     apb_psel_sm <= '1';
                     apb_wr_rd_ns <= APB_SETUP;
                end if;

           when APB_SETUP =>
                     apb_psel_sm <= '1';
                     apb_penable_sm <= '1';
                     apb_wr_rd_ns <= APB_ACCESS;

           when APB_ACCESS =>
                if(apb_pready = '1') then
                     drive_wr_0s <= '1';
                     slv_err_resp <= apb_pslverr;
                     rd_data <= apb_prdata;
                     apb_wr_rd_ns <= APB_IDLE;
                elsif (dphase_timeout = '1') then
                     drive_wr_0s <= '1';
                     apb_wr_rd_ns <= APB_IDLE;
                else
                     apb_psel_sm <= '1';
                     apb_penable_sm <= '1';
                end if;
                
          -- coverage off
            when others =>
                apb_wr_rd_ns <= APB_IDLE;
          -- coverage on

       end case;

   end process APB_WR_RD_SM;

-------------------------------------------------------------------------------
-- Registering the signals generated from the APB state machine
-------------------------------------------------------------------------------

   APB_WR_RD_SM_REG : process(M_APB_PCLK) is
   begin
      if (M_APB_PCLK'event and M_APB_PCLK = '1') then
         if (M_APB_PRESETN = '0') then
           apb_wr_rd_cs <= APB_IDLE;
           PENABLE_i <= '0';
         else
           apb_wr_rd_cs <= apb_wr_rd_ns;
           PENABLE_i <= apb_penable_sm;
         end if;
      end if;
   end process APB_WR_RD_SM_REG;

end architecture RTL;


------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- vid_edid_v1_0_0_psel_decoder.vhd - entity/architecture pair
------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_psel_decoder.vhd
-- Version:         v1.00a
-- Description:     This module generates the PSEL signal for selecting
--                  different slaves.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- vid_edid_v1_0_0_axi_apb_bridge.vhd
--              -- vid_edid_v1_0_0_psel_decoder.vhd
--              -- vid_edid_v1_0_0_multiplexor.vhd
--              -- vid_edid_v1_0_0_axilite_sif.vhd
--              -- vid_edid_v1_0_0_apb_mif.vhd
--
-------------------------------------------------------------------------------
-- Author:      USM
-- History:
--   USM      07/30/2010
-- ^^^^^^^
-- ~~~~~~~
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.CONV_INTEGER;

--library proc_common_v3_00_a;
--use proc_common_v3_00_a.vid_edid_v1_0_0_pselect_f;

entity vid_edid_v1_0_0_psel_decoder is
  generic (
    C_FAMILY               : string                    := "virtex6";

    C_S_AXI_ADDR_WIDTH     : integer range 32 to 32    := 32;
    C_APB_NUM_SLAVES       : integer range 1 to 16     := 4;

    C_S_AXI_RNG1_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG1_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG2_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG2_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG3_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG3_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG4_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG4_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG5_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG5_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG6_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG6_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG7_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG7_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG8_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG8_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG9_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG9_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG10_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG10_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG11_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG11_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG12_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG12_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG13_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG13_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG14_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG14_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG15_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG15_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG16_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG16_HIGHADDR : std_logic_vector(0 to 31) := X"00000000"

    );
  port (
    Address           : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    addr_is_valid     : in std_logic;
    sl_pselect        : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0)
    );

end entity vid_edid_v1_0_0_psel_decoder;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture RTL of vid_edid_v1_0_0_psel_decoder is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

-------------------------------------------------------------------------------
-- Function declaration
-- This function generates the number of address bits to be compared depending
-- upon the selected base and high addresses.
-------------------------------------------------------------------------------

    function Get_Addr_Bits (x : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH-1);
                            y : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH-1)
                           )
             return integer is
        variable addr_nor : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH-1);
        begin
            addr_nor := x xor y;
            for i in 0 to C_S_AXI_ADDR_WIDTH-1 loop
                if addr_nor(i)='1' then
                    return i;
                end if;
            end loop;
    -- coverage off
            return(C_S_AXI_ADDR_WIDTH);
    -- coverage on
    end function Get_Addr_Bits;
-------------------------------------------------------------------------------
 -- Signal declarations
-------------------------------------------------------------------------------
component vid_edid_v1_0_0_pselect_f is

  generic (
    C_AB     : integer := 9;
    C_AW     : integer := 32;
    C_BAR    : std_logic_vector;
    C_FAMILY : string := "nofamily"
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    CS       : out  std_logic
    );

end component;
begin

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 1
-- ****************************************************************************

    GEN_1_ADDR_RANGES : if C_APB_NUM_SLAVES = 1 generate

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals - As one slave is used select is always
 -- high
-------------------------------------------------------------------------------

        sl_pselect(0)  <= addr_is_valid;

    end generate GEN_1_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 2
-- ****************************************************************************

    GEN_2_ADDR_RANGES : if C_APB_NUM_SLAVES = 2 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          --RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          --RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

    end generate GEN_2_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 3
-- ****************************************************************************

    GEN_3_ADDR_RANGES : if C_APB_NUM_SLAVES = 3 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range3 & addr_hit_range2 & addr_hit_range1 ;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          --RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          --RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          --RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

    end generate GEN_3_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 4
-- ****************************************************************************

    GEN_4_ADDR_RANGES : if C_APB_NUM_SLAVES = 4 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range4 & addr_hit_range3 &
                        addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          --RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          --RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          --RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          --RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

    end generate GEN_4_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 5
-- ****************************************************************************

    GEN_5_ADDR_RANGES : if C_APB_NUM_SLAVES = 5 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          --RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

    end generate GEN_5_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 6
-- ****************************************************************************

    GEN_6_ADDR_RANGES : if C_APB_NUM_SLAVES = 6 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );
    end generate GEN_6_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 7
-- ****************************************************************************

    GEN_7_ADDR_RANGES : if C_APB_NUM_SLAVES = 7 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range7 & addr_hit_range6 &
                    addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

    end generate GEN_7_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 8
-- ****************************************************************************

    GEN_8_ADDR_RANGES : if C_APB_NUM_SLAVES = 8 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range8 & addr_hit_range7 &
                    addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );

    end generate GEN_8_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 9
-- ****************************************************************************

    GEN_9_ADDR_RANGES : if C_APB_NUM_SLAVES = 9 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range9 & addr_hit_range8 &
                    addr_hit_range7 & addr_hit_range6 &
                    addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

    end generate GEN_9_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 10
-- ****************************************************************************

    GEN_10_ADDR_RANGES : if C_APB_NUM_SLAVES = 10 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range10 & addr_hit_range9 &
                    addr_hit_range8 & addr_hit_range7 &
                    addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

    end generate GEN_10_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 11
-- ****************************************************************************

    GEN_11_ADDR_RANGES : if C_APB_NUM_SLAVES = 11 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range11 & addr_hit_range10 &
                    addr_hit_range9 & addr_hit_range8 &
                    addr_hit_range7 & addr_hit_range6 &
                    addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );

    end generate GEN_11_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 12
-- ****************************************************************************

    GEN_12_ADDR_RANGES : if C_APB_NUM_SLAVES = 12 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        constant DECODE_BITS_RNG12      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG12_BASEADDR, C_S_AXI_RNG12_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;
        signal addr_hit_range12 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range12 & addr_hit_range11 &
                    addr_hit_range10 & addr_hit_range9 &
                    addr_hit_range8 & addr_hit_range7 &
                    addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2& addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 12
-------------------------------------------------------------------------------

          RANGE12_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG12,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG12_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range12    -- [out]
              );


    end generate GEN_12_ADDR_RANGES;
-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 13
-- ****************************************************************************

    GEN_13_ADDR_RANGES : if C_APB_NUM_SLAVES = 13 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        constant DECODE_BITS_RNG12      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG12_BASEADDR, C_S_AXI_RNG12_HIGHADDR);
        constant DECODE_BITS_RNG13      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG13_BASEADDR, C_S_AXI_RNG13_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;
        signal addr_hit_range12 : std_logic;
        signal addr_hit_range13 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range13 & addr_hit_range12 &
                    addr_hit_range11 & addr_hit_range10 &
                    addr_hit_range9 & addr_hit_range8 &
                    addr_hit_range7 & addr_hit_range6 &
                    addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 12
-------------------------------------------------------------------------------

          RANGE12_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG12,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG12_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range12    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 13
-------------------------------------------------------------------------------

          RANGE13_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG13,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG13_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range13    -- [out]
              );

    end generate GEN_13_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 14
-- ****************************************************************************

    GEN_14_ADDR_RANGES : if C_APB_NUM_SLAVES = 14 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        constant DECODE_BITS_RNG12      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG12_BASEADDR, C_S_AXI_RNG12_HIGHADDR);
        constant DECODE_BITS_RNG13      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG13_BASEADDR, C_S_AXI_RNG13_HIGHADDR);
        constant DECODE_BITS_RNG14      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG14_BASEADDR, C_S_AXI_RNG14_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;
        signal addr_hit_range12 : std_logic;
        signal addr_hit_range13 : std_logic;
        signal addr_hit_range14 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range14 & addr_hit_range13 &
                    addr_hit_range12 & addr_hit_range11 &
                    addr_hit_range10 & addr_hit_range9 &
                    addr_hit_range8 & addr_hit_range7 &
                    addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 12
-------------------------------------------------------------------------------

          RANGE12_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG12,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG12_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range12    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 13
-------------------------------------------------------------------------------

          RANGE13_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG13,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG13_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range13    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 14
-------------------------------------------------------------------------------

          RANGE14_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG14,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG14_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range14    -- [out]
              );

    end generate GEN_14_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 15
-- ****************************************************************************

    GEN_15_ADDR_RANGES : if C_APB_NUM_SLAVES = 15 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        constant DECODE_BITS_RNG12      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG12_BASEADDR, C_S_AXI_RNG12_HIGHADDR);
        constant DECODE_BITS_RNG13      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG13_BASEADDR, C_S_AXI_RNG13_HIGHADDR);
        constant DECODE_BITS_RNG14      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG14_BASEADDR, C_S_AXI_RNG14_HIGHADDR);
        constant DECODE_BITS_RNG15      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG15_BASEADDR, C_S_AXI_RNG15_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;
        signal addr_hit_range12 : std_logic;
        signal addr_hit_range13 : std_logic;
        signal addr_hit_range14 : std_logic;
        signal addr_hit_range15 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range15 & addr_hit_range14 &
                    addr_hit_range13 & addr_hit_range12 &
                    addr_hit_range11 & addr_hit_range10 &
                    addr_hit_range9 & addr_hit_range8 &
                    addr_hit_range7 & addr_hit_range6 &
                    addr_hit_range5 & addr_hit_range4 &
                    addr_hit_range3 & addr_hit_range2 &
                    addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 12
-------------------------------------------------------------------------------

          RANGE12_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG12,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG12_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range12    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 13
-------------------------------------------------------------------------------

          RANGE13_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG13,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG13_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range13    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 14
-------------------------------------------------------------------------------

          RANGE14_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG14,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG14_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range14    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 15
-------------------------------------------------------------------------------

          RANGE15_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG15,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG15_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range15    -- [out]
              );


    end generate GEN_15_ADDR_RANGES;

-- ****************************************************************************
-- Address decoding logic when C_APB_NUM_SLAVES = 16
-- ****************************************************************************

    GEN_16_ADDR_RANGES : if C_APB_NUM_SLAVES = 16 generate

        constant DECODE_BITS_RNG1      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG1_BASEADDR, C_S_AXI_RNG1_HIGHADDR);
        constant DECODE_BITS_RNG2      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG2_BASEADDR, C_S_AXI_RNG2_HIGHADDR);
        constant DECODE_BITS_RNG3      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG3_BASEADDR, C_S_AXI_RNG3_HIGHADDR);
        constant DECODE_BITS_RNG4      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG4_BASEADDR, C_S_AXI_RNG4_HIGHADDR);
        constant DECODE_BITS_RNG5      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG5_BASEADDR, C_S_AXI_RNG5_HIGHADDR);
        constant DECODE_BITS_RNG6      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG6_BASEADDR, C_S_AXI_RNG6_HIGHADDR);
        constant DECODE_BITS_RNG7      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG7_BASEADDR, C_S_AXI_RNG7_HIGHADDR);
        constant DECODE_BITS_RNG8      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG8_BASEADDR, C_S_AXI_RNG8_HIGHADDR);
        constant DECODE_BITS_RNG9      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG9_BASEADDR, C_S_AXI_RNG9_HIGHADDR);
        constant DECODE_BITS_RNG10      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG10_BASEADDR, C_S_AXI_RNG10_HIGHADDR);
        constant DECODE_BITS_RNG11      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG11_BASEADDR, C_S_AXI_RNG11_HIGHADDR);
        constant DECODE_BITS_RNG12      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG12_BASEADDR, C_S_AXI_RNG12_HIGHADDR);
        constant DECODE_BITS_RNG13      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG13_BASEADDR, C_S_AXI_RNG13_HIGHADDR);
        constant DECODE_BITS_RNG14      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG14_BASEADDR, C_S_AXI_RNG14_HIGHADDR);
        constant DECODE_BITS_RNG15      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG15_BASEADDR, C_S_AXI_RNG15_HIGHADDR);
        constant DECODE_BITS_RNG16      : integer :=
                 Get_Addr_Bits(C_S_AXI_RNG16_BASEADDR, C_S_AXI_RNG16_HIGHADDR);
        signal addr_hit_range1 : std_logic;
        signal addr_hit_range2 : std_logic;
        signal addr_hit_range3 : std_logic;
        signal addr_hit_range4 : std_logic;
        signal addr_hit_range5 : std_logic;
        signal addr_hit_range6 : std_logic;
        signal addr_hit_range7 : std_logic;
        signal addr_hit_range8 : std_logic;
        signal addr_hit_range9 : std_logic;
        signal addr_hit_range10 : std_logic;
        signal addr_hit_range11 : std_logic;
        signal addr_hit_range12 : std_logic;
        signal addr_hit_range13 : std_logic;
        signal addr_hit_range14 : std_logic;
        signal addr_hit_range15 : std_logic;
        signal addr_hit_range16 : std_logic;

    begin

-------------------------------------------------------------------------------
 -- Generation of slave select signal that is used for  assigning the
 -- PREADY, PSLVERR & PRDATA signals
-------------------------------------------------------------------------------

        sl_pselect  <= addr_hit_range16 & addr_hit_range15 &
                    addr_hit_range14 & addr_hit_range13 &
                    addr_hit_range12 & addr_hit_range11 &
                    addr_hit_range10 & addr_hit_range9 &
                    addr_hit_range8 & addr_hit_range7 &
                    addr_hit_range6 & addr_hit_range5 &
                    addr_hit_range4 & addr_hit_range3 &
                    addr_hit_range2 & addr_hit_range1;

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 1
-------------------------------------------------------------------------------

          RANGE1_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG1,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG1_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range1    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 2
-------------------------------------------------------------------------------

          RANGE2_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG2,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG2_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range2    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 3
-------------------------------------------------------------------------------

          RANGE3_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG3,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG3_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range3    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 4
-------------------------------------------------------------------------------

          RANGE4_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG4,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG4_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range4    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 5
-------------------------------------------------------------------------------

          RANGE5_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG5,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG5_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range5    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 6
-------------------------------------------------------------------------------

          RANGE6_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG6,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG6_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range6    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 7
-------------------------------------------------------------------------------

          RANGE7_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG7,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG7_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range7    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 8
-------------------------------------------------------------------------------

          RANGE8_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG8,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG8_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range8    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 9
-------------------------------------------------------------------------------

          RANGE9_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG9,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG9_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range9    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 10
-------------------------------------------------------------------------------

          RANGE10_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG10,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG10_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range10    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 11
-------------------------------------------------------------------------------

          RANGE11_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG11,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG11_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range11    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 12
-------------------------------------------------------------------------------

          RANGE12_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG12,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG12_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range12    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 13
-------------------------------------------------------------------------------

          RANGE13_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG13,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG13_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range13    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 14
-------------------------------------------------------------------------------

          RANGE14_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG14,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG14_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range14    -- [out]
              );
-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 15
-------------------------------------------------------------------------------

          RANGE15_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG15,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG15_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range15    -- [out]
              );

-------------------------------------------------------------------------------
 -- Instantiate the basic address decoder vid_edid_v1_0_0_pselect_f from proc_common
 -- library v3_00_a for Range 16
-------------------------------------------------------------------------------

          RANGE16_SELECT: vid_edid_v1_0_0_pselect_f
              generic map
              (
                  C_AB     => DECODE_BITS_RNG16,
                  C_AW     => 32,
                  C_BAR    => C_S_AXI_RNG16_BASEADDR,
                  C_FAMILY => C_FAMILY
              )
              port map
              (
                  A        => Address,           -- [in]
                  AValid   => addr_is_valid,     -- [in]
                  CS       => addr_hit_range16    -- [out]
              );

    end generate GEN_16_ADDR_RANGES;

end architecture RTL;


-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.



-- ----------------------------------------------
-- Libraries
-- ----------------------------------------------
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library work;
    use work.vid_edid_v1_0_0_common_pkg.all;

-- ----------------------------------------------
-- entity declaration
-- ----------------------------------------------
entity vid_edid_v1_0_0_rom is
generic (
    gIIC_DEVICE_ADDRESS     : unsigned (7 downto 1) := "1011100";           -- 0xb8,0xb9 by default
    gIIC_DEVICE_PAGE_ADDRESS     : unsigned (7 downto 1) := "1011100";           -- 0xb8,0xb9 by default
    gROM_SIZE               : integer := 128                                -- size of the ROM in bytes
);
port (
    -- control clock and reset
    ctl_clk                 : in  std_ulogic;                               -- clock to run internal logic
    ctl_reset               : in  std_ulogic;                               -- ctl_clk synchronous reset, active low

    -- rom array interface
    kROM_BYTE_ARRAY         : in  tUNSIGNED8_ARRAY(0 to gROM_SIZE-1);      -- ROM byte array

    -- iic interface
    iic_scl_in              : in  std_ulogic;                               -- serial clock input
    iic_sda_in              : in  std_ulogic;                               -- serial data input
    iic_sda_out             : out std_ulogic                                -- data output
);
end entity vid_edid_v1_0_0_rom;


-- ----------------------------------------------
-- architecture definition
-- ----------------------------------------------
architecture rtl of vid_edid_v1_0_0_rom is
    -- sychronization stage and detection

    attribute MARK_DEBUG : string;

    signal i_sync_scl               : unsigned (2 downto 0);
    signal i_sync_sda               : unsigned (2 downto 0);
    signal i_start_detected         : std_ulogic;
    signal i_stop_detected          : std_ulogic;
    signal i_scl_rising_edge        : std_ulogic;
    signal i_scl_falling_edge       : std_ulogic;
    signal i_iic_data               : unsigned (7 downto 0);

    -- iic management signals
    type tSERIAL_STATE is (kSS_IDLE, kSS_WAIT_CLOCK_FALLING, kSS_DEVICE_ADDRESS, kSS_DEVICE_ADDRESS_ACK, kSS_WRITE_ADDRESS, kSS_WRITE_ADDRESS_ACK,
                           kSS_READ_DATA, kSS_READ_DATA_ACK, kSS_WRITE_DATA, kSS_WRITE_DATA_ACK);

    signal i_serial_state           : tSERIAL_STATE;
    signal i_serial_count           : unsigned (2 downto 0);
    signal i_serial_read            : std_ulogic;
    signal i_sda_out                : std_ulogic;

    -- iic data management
    signal i_serial_address         : unsigned (8 downto 0);
    signal i_serial_data            : unsigned (7 downto 0);
    signal i_segment_addr           : unsigned (7 downto 0);
    signal i_set_serial_address     : std_ulogic;
    signal i_write_data             : std_ulogic;
    signal i_load_read_data         : std_ulogic;
    signal i_set_segment_pointer    : std_ulogic;
    signal i_read_segment_pointer    : std_ulogic;
    signal i_clear_segment_pointer  : std_ulogic;


begin

-- ----------------------------------------------
-- Signal mapping
-- ----------------------------------------------
SigMap: block
begin
    -- map internal signals to ports
    iic_sda_out <= i_sda_out;

    -- create some detection signals for reference
    i_start_detected   <= '1' when i_sync_sda(2 downto 1) = "10" and i_sync_scl(2 downto 1) = "11" else '0';
    i_stop_detected    <= '1' when i_sync_sda(2 downto 1) = "01" and i_sync_scl(2 downto 1) = "11" else '0';
    i_scl_rising_edge  <= '1' when i_sync_scl(2 downto 1) = "01" else '0';
    i_scl_falling_edge <= '1' when i_sync_scl(2 downto 1) = "10" else '0';
end block SigMap;


-- ----------------------------------------------
-- I2C Interface
-- ----------------------------------------------
IICInterface: process (ctl_clk)
begin
    if rising_edge(ctl_clk) then
        if ctl_reset = '1' then
            i_sync_scl <= "000";
            i_sync_sda <= "000";
            i_serial_state <= kSS_IDLE;
            i_serial_count <= "000";
            i_serial_read <= '0';
            i_sda_out <= '1';
            i_load_read_data <= '0';
            i_set_serial_address <= '0';
            i_write_data <= '0';
            i_set_segment_pointer <= '0';
            i_read_segment_pointer <= '0';
            i_clear_segment_pointer <= '0';

        else

            -- ---------------------------------------
            -- sample registers
            -- ---------------------------------------
            i_sync_scl <= i_sync_scl(1 downto 0) & iic_scl_in;
            i_sync_sda <= i_sync_sda(1 downto 0) & iic_sda_in;

            -- ---------------------------------------
            -- iic data capture shift register
            -- ---------------------------------------
            if i_scl_rising_edge = '1' then
                i_iic_data <= i_iic_data(6 downto 0) & i_sync_sda(2);
            end if;

            -- ---------------------------------------
            -- iic manager state machine
            -- ---------------------------------------
            i_set_serial_address <= '0';
            i_write_data <= '0';
            i_load_read_data <= '0';
            i_sda_out <= '1';
            i_clear_segment_pointer <= '0';


            case i_serial_state is
                when kSS_IDLE =>
                    -- look for the start condition
                    if i_start_detected = '1' then
                        i_serial_state <= kSS_WAIT_CLOCK_FALLING;
                    end if;

                    -- set the counter
                    i_serial_count <= "111";

                when kSS_WAIT_CLOCK_FALLING =>
                    if i_scl_falling_edge = '1' then
                        i_serial_state <= kSS_DEVICE_ADDRESS;
                    end if;

                when kSS_DEVICE_ADDRESS =>
                    -- wait for the address and read/write to be entered
                    if i_scl_falling_edge = '1' then
                        i_serial_count <= i_serial_count - 1;

                        -- at the end of the count, verify the address, 7 bits
                        if i_serial_count = 0 then
                            if i_iic_data(7 downto 1) = gIIC_DEVICE_ADDRESS then
                                i_serial_read <= i_iic_data(0);
                                i_set_segment_pointer <= '0';
                                i_serial_state <= kSS_DEVICE_ADDRESS_ACK;
                            elsif i_iic_data(7 downto 1) = gIIC_DEVICE_PAGE_ADDRESS then
                                --i_serial_address(8) <= '1'; -- set the extention
                                --i_serial_read <= '0';
                                i_serial_read <= i_iic_data(0);
                                i_set_segment_pointer <= not i_iic_data(0);
                                i_read_segment_pointer <= i_iic_data(0);
                                i_serial_state <= kSS_DEVICE_ADDRESS_ACK;
                            else
                                i_serial_state <= kSS_IDLE;
                            end if;
                        end if;
                    end if;

                when kSS_DEVICE_ADDRESS_ACK =>
                    i_sda_out <= '0';

                    -- assert ack at the falling edge
                    if i_scl_falling_edge = '1' then
                        i_sda_out <= '1';

                        -- for a read, go to the read data state
                        if i_serial_read = '1' then
                            i_serial_state <= kSS_READ_DATA;
                            i_load_read_data <= '1';
                        else
                            -- for a write, assume the write address first
                            i_serial_state <= kSS_WRITE_ADDRESS;
                        end if;
                    end if;

                    -- reset the serial counter in this state
                    i_serial_count <= "111";

                when kSS_WRITE_ADDRESS =>
                    -- wait for the address byte
                    -- no need to look for stop since only one byte is accepted
                    if i_scl_rising_edge = '1' then
                        i_serial_count <= i_serial_count - 1;

                        -- end of byte
                        if i_serial_count = 0 then
                            i_set_serial_address <= '1';
                            i_serial_state <= kSS_WRITE_ADDRESS_ACK;
                        end if;
                    end if;

                when kSS_WRITE_ADDRESS_ACK =>
                    -- assert ack at the falling edge
                    if i_scl_falling_edge = '1' then
                        if i_sda_out = '1' then
                            i_sda_out <= '0';
                        else
                            -- if the ack is already asserted, this is the second phase of the cycle, advance to the write data state
                            i_sda_out <= '1';
                            i_serial_state <= kSS_WRITE_DATA;
                            i_set_segment_pointer <= '0';
                        end if;
                    else
                        i_sda_out <= i_sda_out;
                    end if;

                    -- reset the serial counter in this state
                    i_serial_count <= "111";

                when kSS_READ_DATA =>
                    -- set the serial data out
                    if i_read_segment_pointer = '1' then
                      i_sda_out <= i_segment_addr(7);
                    else
                      i_sda_out <= i_serial_data(7);
                    end if;

                    -- check for a stop condition
                    if i_start_detected = '1' then
                        i_serial_state <= kSS_WAIT_CLOCK_FALLING;
                        i_sda_out <= '1';
                        i_serial_count <= "111";

                    elsif i_stop_detected = '1' then
                        i_sda_out <= '1';
                        i_serial_state <= kSS_IDLE;

                    elsif i_scl_falling_edge = '1' then
                        i_serial_count <= i_serial_count - 1;

                        -- check for all data sent
                        if i_serial_count = 0 then
                            -- release sda
                            i_sda_out <= '1';

                            -- look for ack from the master
                            i_serial_state <= kSS_READ_DATA_ACK;
                        end if;
                    end if;

                when kSS_READ_DATA_ACK =>
                    -- wait for the falling
                    if i_stop_detected = '1' then
                      i_sda_out <= '1';
                      i_serial_state <= kSS_IDLE;
                    elsif i_scl_falling_edge = '1' then
                        -- look for state of the ack
                        if i_sync_sda(2) = '1' then
                            -- assume the last data has been read
                            i_serial_state <= kSS_IDLE;
                            i_set_segment_pointer <= '0';
                            i_read_segment_pointer <= '0';
                            i_clear_segment_pointer <= '1';
                        else
                            -- another byte will be read
                            i_load_read_data <= '1';
                            i_serial_state <= kSS_READ_DATA;
                            i_set_segment_pointer <= '0';
                            i_read_segment_pointer <= '0';
                        end if;
                    end if;

                    -- reset the serial counter in this state
                    i_serial_count <= "111";

                when kSS_WRITE_DATA =>
                    -- need to look for stop
                    if i_stop_detected = '1' then
                        i_serial_state <= kSS_IDLE;

                    elsif i_start_detected = '1' then
                        i_serial_state <= kSS_WAIT_CLOCK_FALLING;
                        i_serial_count <= "111";

                    -- wait for the data byte
                    elsif i_scl_rising_edge = '1' then
                        i_serial_count <= i_serial_count - 1;

                        -- end of byte
                        if i_serial_count = 0 then
                            i_write_data <= '1';
                            i_serial_state <= kSS_WRITE_DATA_ACK;
                        end if;
                    end if;

                when kSS_WRITE_DATA_ACK =>
                    -- assert ack at the falling edge
                    if i_scl_falling_edge = '1' then
                        if i_sda_out = '1' then
                            i_sda_out <= '0';
                        else
                            -- if the ack is already asserted, this is the second phase of the cycle, advance to the write data state
                            i_sda_out <= '1';
                            i_serial_state <= kSS_WRITE_DATA;
                        end if;
                    else
                        i_sda_out <= i_sda_out;
                    end if;

                    -- reset the serial counter in this state
                    i_serial_count <= "111";

                when others =>
                    i_serial_state <= kSS_IDLE;
                    i_serial_count <= "111";
                    i_sda_out <= '1';
                    i_write_data <= '0';
                    i_set_serial_address <= '0';
                    i_load_read_data <= '0';
--                    i_set_segment_pointer <= '0';
            end case;
        end if;
    end if;
end process IICInterface;

-- ----------------------------------------------
-- ROM data management
-- ----------------------------------------------
ROMData: process (ctl_clk)
begin
    if rising_edge(ctl_clk) then
        if ctl_reset = '1' then
            i_serial_address(8) <= '0';
            i_segment_addr <= "00000000";
        else
	    --segment address is managed in logic below. 
	    --This variable is only used to return to Source when reading segment address. Tied to 0 and user can implement as needed.
            i_segment_addr <= "00000000";
            -- ------------------------------------------
            -- load the serial data when requested
            -- ------------------------------------------
            if (i_stop_detected = '1') or (i_clear_segment_pointer = '1') then
                -- segment pointer register (address bits 8 and above) needs to be reset at STOP oder NO ACK (VESA EDDC v1.2 chapter 9.1.1)
                i_serial_address(8) <= '0';
            elsif ((i_set_segment_pointer = '1') and (i_set_serial_address = '1')) then
                -- load serial address bits 8 and above
                i_serial_address(8) <= i_iic_data(0);
            elsif i_set_serial_address = '1' then
                --i_serial_address <= to_integer(i_iic_data(6 downto 0));
                i_serial_address(7 downto 0) <= i_iic_data(7 downto 0);

            elsif i_load_read_data = '1' then
                -- synthesis translate_off
                report "I2C Data Read from Address " & integer'IMAGE(to_integer(i_serial_address));
                -- synthesis translate_on
                i_serial_data <= kROM_BYTE_ARRAY(to_integer(i_serial_address));
                --i_serial_address <= (i_serial_address + 1) mod gROM_SIZE;
                i_serial_address(7 downto 0) <= (i_serial_address(7 downto 0) + 1);
            elsif i_scl_falling_edge = '1' then
                i_serial_data <= i_serial_data(6 downto 0) & '1';

            ---- segment pointer register (address bits 8 and above) needs to be reset at STOP oder NO ACK (VESA EDDC v1.2 chapter 9.1.1)
            --elsif (i_stop_detected = '1') or (i_clear_segment_pointer = '1') then
            --    i_serial_address(8) <= '0';
            end if;
        end if;
    end if;
end process ROMData;


end architecture rtl;





------------------------------------------------------------------------
-- File name   : 
-- Rev         : 
-- Description : 
--
-- (c) Copyright 2001-2008 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------
-- vid_edid_v1_0_0_axi_apb_bridge.vhd - entity/architecture pair
------------------------------------------------------------------------
-- Filename:        vid_edid_v1_0_0_axi_apb_bridge.vhd
-- Version:         v1.00a
-- Description:     The AXI to APB Bridge module translates AXI
--                  transactions into APB transactions. It functions as a
--                  AXI slave on the AXI port and an APB master on
--                  the APB interface.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- vid_edid_v1_0_0_axi_apb_bridge.vhd
--              -- vid_edid_v1_0_0_psel_decoder.vhd
--              -- vid_edid_v1_0_0_multiplexor.vhd
--              -- vid_edid_v1_0_0_axilite_sif.vhd
--              -- vid_edid_v1_0_0_apb_mif.vhd
--
-------------------------------------------------------------------------------
-- Author:      USM
-- History:
--   USM      07/30/2010   Initial version
-- ^^^^^^^
-- ~~~~~~~
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--library axi_apb_bridge_v1_00_a;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
--
-- Definition of Generics
--
-- System Parameters
--
--  C_FAMILY                 -- FPGA Family for which the vid_edid_v1_0_0_axi_apb_bridge is
--                           -- targeted
-- AXI Parameters
--
--  C_S_AXI_ADDR_WIDTH       -- Width of the AXI address bus (in bits)
--                              fixed to 32
--  C_S_AXI_DATA_WIDTH       -- Width of the AXI data bus (in bits)
--                              fixed to 32
--  C_BASEADDR               -- AXI base address for address range 1
--  C_HIGHADDR               -- AXI high address for address range 1
--
-- APB Parameters
--
--  C_M_APB_ADDR_WIDTH       -- Width of the APB address bus (in bits)
--                              fixed to 32
--  C_M_APB_DATA_WIDTH       -- Width of the APB data bus (in bits)
--                              fixed to 32
--  C_APB_NUM_SLAVES         -- The number of APB slaves
--  C_M_APB_PROTOCOL         -- The type of APB interface APB3/APB4
--
-- Core Parameters
--
--  C_DPHASE_TIMEOUT         -- Data phase time out value
--
-- Definition of Ports
--
-- System signals
--
--  S_AXI_ACLK               -- AXI Clock
--  S_AXI_ARESETN            -- AXI Reset Signal - active low
--
-- AXI Write address channel signals
--  S_AXI_AWADDR             -- Write address bus - The write address bus gives
--                              the address of the first transfer in a write
--                              burst transaction - fixed to 32
--  S_AXI_AWPROT             -- Protection type - This signal indicates the
--                              normal, privileged, or secure protection level
--                              of the transaction and whether the transaction
--                              is a data access or an instruction access
--  S_AXI_AWVALID            -- Write address valid - This signal indicates
--                              that valid write address & control information
--                              are available
--  S_AXI_AWREADY            -- Write address ready - This signal indicates
--                              that the slave is ready to accept an address
--                              and associated control signals
--
-- AXI Write data channel signals
--
--  S_AXI_WDATA              -- Write data bus - fixed to 32
--  S_AXI_WSTRB              -- Write strobes - These signals indicates which
--                              byte lanes to update in memory
--  S_AXI_WVALID             -- Write valid - This signal indicates that valid
--                              write data and strobes are available
--  S_AXI_WREADY             -- Write ready - This signal indicates that the
--                              slave can accept the write data
-- AXI Write response channel signals
--
--  S_AXI_BRESP              -- Write response - This signal indicates the
--                              status of the write transaction
--  S_AXI_BVALID             -- Write response valid - This signal indicates
--                              that a valid write response is available
--  S_AXI_BREADY             -- Response ready - This signal indicates that
--                              the master can accept the response information
--
-- AXI Read address channel signals
--
--  S_AXI_ARADDR             -- Read address - The read address bus gives the
--                              initial address of a read burst transaction
--  S_AXI_ARPROT             -- Protection type - This signal provides
--                              protection unit information for the transaction
--  S_AXI_ARVALID            -- Read address valid - This signal indicates,
--                              when HIGH, that the read address and control
--                              information is valid and will remain stable
--                              until the address acknowledge signal,ARREADY,
--                              is high.
--  S_AXI_ARREADY            -- Read address ready - This signal indicates
--                              that the slave is ready to accept an address
--                              and associated control signals:
--
-- AXI Read data channel signals
--
--  S_AXI_RDATA              -- Read data bus - fixed to 32
--  S_AXI_RRESP              -- Read response - This signal indicates the
--                              status of the read transfer
--  S_AXI_RVALID             -- Read valid - This signal indicates that the
--                              required read data is available and the read
--                              transfer can complete
--  S_AXI_RREADY             -- Read ready - This signal indicates that the
--                              master can accept the read data and response
--                              information
-- APB signals
--  M_APB_PCLK               -- APB Clock
--  M_APB_PRESETN            -- APB Reset Signal - active low
--  M_APB_PADDR              -- APB address bus
--  M_APB_PSEL               -- Slave select signal
--  M_APB_PENABLE            -- Enable signal indicates that the second and
--                              sub-sequent cycles of an APB transfer
--  M_APB_PWRITE             -- Direction indicates an APB write access when
--                              high and an APB read access when low
--  M_APB_PWDATA             -- APB write data
--  M_APB_PREADY             -- Ready, the APB slave uses this signal to
--                              extend an APB transfer
--  M_APB_PRDATA1            -- APB read data driven by slave 1
--  M_APB_PRDATA2            -- APB read data driven by slave 2
--  M_APB_PRDATA3            -- APB read data driven by slave 3
--  M_APB_PRDATA4            -- APB read data driven by slave 4
--  M_APB_PRDATA5            -- APB read data driven by slave 5
--  M_APB_PRDATA6            -- APB read data driven by slave 6
--  M_APB_PRDATA7            -- APB read data driven by slave 7
--  M_APB_PRDATA8            -- APB read data driven by slave 8
--  M_APB_PRDATA9            -- APB read data driven by slave 9
--  M_APB_PRDATA10           -- APB read data driven by slave 10
--  M_APB_PRDATA11           -- APB read data driven by slave 11
--  M_APB_PRDATA12           -- APB read data driven by slave 12
--  M_APB_PRDATA13           -- APB read data driven by slave 13
--  M_APB_PRDATA14           -- APB read data driven by slave 14
--  M_APB_PRDATA15           -- APB read data driven by slave 15
--  M_APB_PRDATA16           -- APB read data driven by slave 16
--  M_APB_PSLVERR            -- This signal indicates transfer failure
--  M_APB_PPROT              -- This signal indicates the normal,
--                              privileged, or secure protection level of the
--                              transaction and whether the transaction is a
--                              data access or an instruction access. Driven
--                              when APB4 is selected.
--  M_APB_PSTRB              -- Write strobes. This signal indicates which
--                              byte lanes to update during a write transfer.
--                              Write strobes must not be active during a
--                              read transfer.Driven when APB4 is selected.
-------------------------------------------------------------------------------
-- Generics & Signals Description
-------------------------------------------------------------------------------

entity vid_edid_v1_0_0_axi_apb_bridge is
  generic (
    C_FAMILY              : string                    := "virtex6";

    C_S_AXI_ADDR_WIDTH    : integer range 32 to 32    := 32;
    C_S_AXI_DATA_WIDTH    : integer range 32 to 32    := 32;

    C_M_APB_ADDR_WIDTH    : integer range 32 to 32    := 32;
    C_M_APB_DATA_WIDTH    : integer range 32 to 32    := 32;
    C_APB_NUM_SLAVES      : integer range 1 to 16     := 4;
    C_M_APB_PROTOCOL      : string                    := "apb3";

    C_BASEADDR            : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_HIGHADDR            : std_logic_vector(0 to 31) := X"00000000";
    C_DPHASE_TIMEOUT       : integer range 0 to 256    := 0
    );
  port (
  -- AXI signals
    S_AXI_ACLK         : in  std_logic;
    S_AXI_ARESETN      : in  std_logic;

    S_AXI_AWADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWPROT       : in  std_logic_vector(2 downto 0);
    S_AXI_AWVALID      : in  std_logic;
    S_AXI_AWREADY      : out std_logic;
    S_AXI_WDATA        : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB        : in  std_logic_vector
                             ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID       : in  std_logic;
    S_AXI_WREADY       : out std_logic;
    S_AXI_BRESP        : out std_logic_vector(1 downto 0);
    S_AXI_BVALID       : out std_logic;
    S_AXI_BREADY       : in  std_logic;

    S_AXI_ARADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARPROT       : in  std_logic_vector(2 downto 0);
    S_AXI_ARVALID      : in  std_logic;
    S_AXI_ARREADY      : out std_logic;
    S_AXI_RDATA        : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP        : out std_logic_vector(1 downto 0);
    S_AXI_RVALID       : out std_logic;
    S_AXI_RREADY       : in  std_logic;

-- APB signals
    M_APB_PCLK         : out  std_logic;
    M_APB_PRESETN      : out  std_logic;
    M_APB_PADDR        : out std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    M_APB_PSEL         : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PENABLE      : out std_logic;
    M_APB_PWRITE       : out std_logic;
    M_APB_PWDATA       : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PREADY       : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PRDATA       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PSLVERR      : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PPROT        : out std_logic_vector(2 downto 0);
    M_APB_PSTRB        : out std_logic_vector
                             ((C_M_APB_DATA_WIDTH/8)-1 downto 0)
    );

end entity vid_edid_v1_0_0_axi_apb_bridge;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture RTL of vid_edid_v1_0_0_axi_apb_bridge is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

-------------------------------------------------------------------------------
 -- Constant declarations
-------------------------------------------------------------------------------
    
    CONSTANT C_S_AXI_RNG2_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG2_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG3_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG3_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG4_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG4_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG5_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG5_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG6_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG6_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG7_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG7_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG8_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG8_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG9_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG9_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG10_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG10_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG11_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG11_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG12_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG12_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG13_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG13_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG14_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG14_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG15_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG15_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    CONSTANT C_S_AXI_RNG16_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    CONSTANT C_S_AXI_RNG16_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

-------------------------------------------------------------------------------
 -- Signal declarations
-------------------------------------------------------------------------------

    signal Address        : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal sl_pselect     : std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    signal apb_pslverr    : std_logic;
    signal apb_pready     : std_logic;
    signal apb_prdata     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    signal apb_rd_request : std_logic;
    signal apb_wr_request : std_logic;
    signal rd_data        : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    signal slv_err_resp   : std_logic;
    signal PSEL_i         : std_logic;
    signal axi_awprot     : std_logic_vector(2 downto 0);
    signal dphase_timeout : std_logic;    
    
    signal M_APB_PRDATA2      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA3      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA4      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA5      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA6      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA7      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA8      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA9      : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA10     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA11     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA12     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA13     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA14     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA15     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');
    signal M_APB_PRDATA16     : std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0) := (OTHERS=>'0');

component vid_edid_v1_0_0_psel_decoder is
  generic (
    C_FAMILY               : string                    := "virtex6";

    C_S_AXI_ADDR_WIDTH     : integer range 32 to 32    := 32;
    C_APB_NUM_SLAVES       : integer range 1 to 16     := 4;

    C_S_AXI_RNG1_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG1_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG2_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG2_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG3_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG3_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG4_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG4_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG5_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG5_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG6_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG6_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG7_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG7_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG8_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG8_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG9_BASEADDR  : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG9_HIGHADDR  : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG10_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG10_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG11_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG11_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG12_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG12_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG13_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG13_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG14_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG14_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG15_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG15_HIGHADDR : std_logic_vector(0 to 31) := X"00000000";

    C_S_AXI_RNG16_BASEADDR : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_S_AXI_RNG16_HIGHADDR : std_logic_vector(0 to 31) := X"00000000"

    );
  port (
    Address           : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    addr_is_valid     : in std_logic;
    sl_pselect        : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0)
    );

end component;

component vid_edid_v1_0_0_multiplexor is
  generic (

    C_M_APB_DATA_WIDTH  : integer range 32 to 32   := 32;
    C_APB_NUM_SLAVES    : integer range 1 to 16    := 4
        );

  port (
    M_APB_PCLK          : in std_logic;
    M_APB_PRESETN       : in std_logic;
    M_APB_PREADY        : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PRDATA1       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA2       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA3       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA4       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA5       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA6       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA7       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA8       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA9       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA10      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA11      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA12      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA13      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA14      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA15      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PRDATA16      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PSLVERR       : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    M_APB_PSEL          : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
    PSEL_i              : in  std_logic;
    apb_pslverr         : out std_logic;
    apb_pready          : out std_logic;
    apb_prdata          : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    sl_pselect          : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0)
    );

end component;

component vid_edid_v1_0_0_axilite_sif is
  generic (
    C_FAMILY              : string                   := "virtex6";
    C_S_AXI_ADDR_WIDTH    : integer range 32 to 32   := 32;
    C_S_AXI_DATA_WIDTH    : integer range 32 to 32   := 32;
    C_DPHASE_TIMEOUT      : integer range 0 to 256   := 0;
    C_M_APB_PROTOCOL      : string                   := "apb3"
    );
  port (
  -- AXI Signals
    S_AXI_ACLK       : in  std_logic;
    S_AXI_ARESETN    : in  std_logic;

    S_AXI_AWADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWPROT     : in  std_logic_vector(2 downto 0);
    S_AXI_AWVALID    : in  std_logic;
    S_AXI_AWREADY    : out std_logic;
    S_AXI_WVALID     : in  std_logic;
    S_AXI_WREADY     : out std_logic;
    S_AXI_BRESP      : out std_logic_vector(1 downto 0);
    S_AXI_BVALID     : out std_logic;
    S_AXI_BREADY     : in  std_logic;

    S_AXI_ARADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID    : in  std_logic;
    S_AXI_ARREADY    : out std_logic;
    S_AXI_RDATA      : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP      : out std_logic_vector(1 downto 0);
    S_AXI_RVALID     : out std_logic;
    S_AXI_RREADY     : in  std_logic;

  -- Signals from other modules
    axi_awprot       : out  std_logic_vector(2 downto 0);
    address          : out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    apb_rd_request   : out std_logic;
    apb_wr_request   : out std_logic;
    dphase_timeout   : out std_logic;
    apb_pready       : in  std_logic;
    slv_err_resp     : in  std_logic;
    rd_data          : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
    );

end component;

component vid_edid_v1_0_0_apb_mif is
  generic (
    C_M_APB_ADDR_WIDTH   : integer range 32 to 32   := 32;
    C_M_APB_DATA_WIDTH   : integer range 32 to 32   := 32;
    C_S_AXI_DATA_WIDTH   : integer range 32 to 32   := 32;
    C_APB_NUM_SLAVES     : integer range 1 to 16    := 4;
    C_M_APB_PROTOCOL     : string                   := "apb3"

    );
  port (

  -- APB Signals
    M_APB_PCLK       : in std_logic;
    M_APB_PRESETN    : in std_logic;

    M_APB_PADDR      : out std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    M_APB_PENABLE    : out std_logic;
    M_APB_PWRITE     : out std_logic;
    M_APB_PWDATA     : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    M_APB_PSTRB      : out std_logic_vector
                           ((C_M_APB_DATA_WIDTH/8)-1 downto 0);
    M_APB_PPROT      : out std_logic_vector(2 downto 0);

  -- Signals from other modules
    apb_pslverr      : in  std_logic;
    apb_pready       : in  std_logic;
    apb_rd_request   : in  std_logic;
    apb_wr_request   : in  std_logic;
    dphase_timeout   : in  std_logic;
    apb_prdata       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    rd_data          : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    slv_err_resp     : out std_logic;
    PSEL_i           : out std_logic;
    address          : in  std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    axi_awprot       : in  std_logic_vector(2 downto 0);

  -- AXI Signals
    S_AXI_WDATA      : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB      : in  std_logic_vector
                           ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_ARADDR     : in  std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
    S_AXI_ARPROT     : in  std_logic_vector(2 downto 0)
    );

end component;


begin

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
    
-------------------------------------------------------------------------------
-- APB clock and reset assignments
-------------------------------------------------------------------------------

    M_APB_PCLK <= S_AXI_ACLK;
    
    M_APB_PRESETN <= S_AXI_ARESETN;

-------------------------------------------------------------------------------
 -- Instantiate the address decoder as APB is shared
-------------------------------------------------------------------------------

        --PSEL_DECODER_MODULE : entity axi_apb_bridge_v1_00_a.vid_edid_v1_0_0_psel_decoder
        PSEL_DECODER_MODULE :  vid_edid_v1_0_0_psel_decoder
        generic map
        (
         C_FAMILY                         => C_FAMILY,
         C_S_AXI_ADDR_WIDTH               => C_S_AXI_ADDR_WIDTH,
         C_APB_NUM_SLAVES                 => C_APB_NUM_SLAVES,
         C_S_AXI_RNG1_BASEADDR            => C_BASEADDR,
         C_S_AXI_RNG1_HIGHADDR            => C_HIGHADDR,
         C_S_AXI_RNG2_BASEADDR            => C_S_AXI_RNG2_BASEADDR,
         C_S_AXI_RNG2_HIGHADDR            => C_S_AXI_RNG2_HIGHADDR,
         C_S_AXI_RNG3_BASEADDR            => C_S_AXI_RNG3_BASEADDR,
         C_S_AXI_RNG3_HIGHADDR            => C_S_AXI_RNG3_HIGHADDR,
         C_S_AXI_RNG4_BASEADDR            => C_S_AXI_RNG4_BASEADDR,
         C_S_AXI_RNG4_HIGHADDR            => C_S_AXI_RNG4_HIGHADDR,
         C_S_AXI_RNG5_BASEADDR            => C_S_AXI_RNG5_BASEADDR,
         C_S_AXI_RNG5_HIGHADDR            => C_S_AXI_RNG5_HIGHADDR,
         C_S_AXI_RNG6_BASEADDR            => C_S_AXI_RNG6_BASEADDR,
         C_S_AXI_RNG6_HIGHADDR            => C_S_AXI_RNG6_HIGHADDR,
         C_S_AXI_RNG7_BASEADDR            => C_S_AXI_RNG7_BASEADDR,
         C_S_AXI_RNG7_HIGHADDR            => C_S_AXI_RNG7_HIGHADDR,
         C_S_AXI_RNG8_BASEADDR            => C_S_AXI_RNG8_BASEADDR,
         C_S_AXI_RNG8_HIGHADDR            => C_S_AXI_RNG8_HIGHADDR,
         C_S_AXI_RNG9_BASEADDR            => C_S_AXI_RNG9_BASEADDR,
         C_S_AXI_RNG9_HIGHADDR            => C_S_AXI_RNG9_HIGHADDR,
         C_S_AXI_RNG10_BASEADDR           => C_S_AXI_RNG10_BASEADDR,
         C_S_AXI_RNG10_HIGHADDR           => C_S_AXI_RNG10_HIGHADDR,
         C_S_AXI_RNG11_BASEADDR           => C_S_AXI_RNG11_BASEADDR,
         C_S_AXI_RNG11_HIGHADDR           => C_S_AXI_RNG11_HIGHADDR,
         C_S_AXI_RNG12_BASEADDR           => C_S_AXI_RNG12_BASEADDR,
         C_S_AXI_RNG12_HIGHADDR           => C_S_AXI_RNG12_HIGHADDR,
         C_S_AXI_RNG13_BASEADDR           => C_S_AXI_RNG13_BASEADDR,
         C_S_AXI_RNG13_HIGHADDR           => C_S_AXI_RNG13_HIGHADDR,
         C_S_AXI_RNG14_BASEADDR           => C_S_AXI_RNG14_BASEADDR,
         C_S_AXI_RNG14_HIGHADDR           => C_S_AXI_RNG14_HIGHADDR,
         C_S_AXI_RNG15_BASEADDR           => C_S_AXI_RNG15_BASEADDR,
         C_S_AXI_RNG15_HIGHADDR           => C_S_AXI_RNG15_HIGHADDR,
         C_S_AXI_RNG16_BASEADDR           => C_S_AXI_RNG16_BASEADDR,
         C_S_AXI_RNG16_HIGHADDR           => C_S_AXI_RNG16_HIGHADDR
        )
        port map
        (
         Address                          => address,
         addr_is_valid                    => '1',
         sl_pselect                       => sl_pselect
        );
-------------------------------------------------------------------------------
 -- Instantiate the Multiplexor as APB is shared
-------------------------------------------------------------------------------

        --MULTIPLEXOR_MODULE : entity axi_apb_bridge_v1_00_a.vid_edid_v1_0_0_multiplexor
        MULTIPLEXOR_MODULE :  vid_edid_v1_0_0_multiplexor
        generic map
        (
         C_M_APB_DATA_WIDTH               => C_M_APB_DATA_WIDTH,
         C_APB_NUM_SLAVES                 => C_APB_NUM_SLAVES
        )
        port map
        (
         M_APB_PCLK                       => S_AXI_ACLK,
         M_APB_PRESETN                    => S_AXI_ARESETN,
         M_APB_PREADY                     => M_APB_PREADY,
         M_APB_PRDATA1                    => M_APB_PRDATA,
         M_APB_PRDATA2                    => M_APB_PRDATA2,
         M_APB_PRDATA3                    => M_APB_PRDATA3,
         M_APB_PRDATA4                    => M_APB_PRDATA4,
         M_APB_PRDATA5                    => M_APB_PRDATA5,
         M_APB_PRDATA6                    => M_APB_PRDATA6,
         M_APB_PRDATA7                    => M_APB_PRDATA7,
         M_APB_PRDATA8                    => M_APB_PRDATA8,
         M_APB_PRDATA9                    => M_APB_PRDATA9,
         M_APB_PRDATA10                   => M_APB_PRDATA10,
         M_APB_PRDATA11                   => M_APB_PRDATA11,
         M_APB_PRDATA12                   => M_APB_PRDATA12,
         M_APB_PRDATA13                   => M_APB_PRDATA13,
         M_APB_PRDATA14                   => M_APB_PRDATA14,
         M_APB_PRDATA15                   => M_APB_PRDATA15,
         M_APB_PRDATA16                   => M_APB_PRDATA16,
         M_APB_PSLVERR                    => M_APB_PSLVERR,
         M_APB_PSEL                       => M_APB_PSEL,
         PSEL_i                           => PSEL_i,
         apb_pslverr                      => apb_pslverr,
         apb_pready                       => apb_pready,
         apb_prdata                       => apb_prdata,
         sl_pselect                       => sl_pselect
        );

-------------------------------------------------------------------------------
 -- Instantiate the AXI Lite Slave Interface module
-------------------------------------------------------------------------------

        --AXILITE_SLAVE_IF_MODULE : entity axi_apb_bridge_v1_00_a.vid_edid_v1_0_0_axilite_sif
        AXILITE_SLAVE_IF_MODULE : vid_edid_v1_0_0_axilite_sif
        generic map
        (
         C_FAMILY                         => C_FAMILY,
         C_S_AXI_ADDR_WIDTH               => C_S_AXI_ADDR_WIDTH,
         C_S_AXI_DATA_WIDTH               => C_S_AXI_DATA_WIDTH,
         C_DPHASE_TIMEOUT                 => C_DPHASE_TIMEOUT,
         C_M_APB_PROTOCOL                 => C_M_APB_PROTOCOL
        )
        port map
        (
         S_AXI_ACLK                       => S_AXI_ACLK,
         S_AXI_ARESETN                    => S_AXI_ARESETN,

         S_AXI_AWADDR                     => S_AXI_AWADDR,
         S_AXI_AWPROT                      => S_AXI_AWPROT,
         S_AXI_AWVALID                    => S_AXI_AWVALID,
         S_AXI_AWREADY                    => S_AXI_AWREADY,
         S_AXI_WVALID                     => S_AXI_WVALID,
         S_AXI_WREADY                     => S_AXI_WREADY,
         S_AXI_BRESP                      => S_AXI_BRESP,
         S_AXI_BVALID                     => S_AXI_BVALID,
         S_AXI_BREADY                     => S_AXI_BREADY,

         S_AXI_ARADDR                     => S_AXI_ARADDR,
         S_AXI_ARVALID                    => S_AXI_ARVALID,
         S_AXI_ARREADY                    => S_AXI_ARREADY,
         S_AXI_RDATA                      => S_AXI_RDATA,
         S_AXI_RRESP                      => S_AXI_RRESP,
         S_AXI_RVALID                     => S_AXI_RVALID,
         S_AXI_RREADY                     => S_AXI_RREADY,
         axi_awprot                       => axi_awprot,
         address                          => address,
         apb_rd_request                   => apb_rd_request,
         apb_wr_request                   => apb_wr_request,
         dphase_timeout                   => dphase_timeout,
         apb_pready                       => apb_pready,
         slv_err_resp                     => slv_err_resp,
         rd_data                          => rd_data
        );

-------------------------------------------------------------------------------
 -- Instantiate the APB Master Interface module
-------------------------------------------------------------------------------

        --APB_MASTER_IF_MODULE : entity axi_apb_bridge_v1_00_a.vid_edid_v1_0_0_apb_mif
        APB_MASTER_IF_MODULE :  vid_edid_v1_0_0_apb_mif
        generic map
        (
         C_M_APB_ADDR_WIDTH               => C_M_APB_ADDR_WIDTH,
         C_M_APB_DATA_WIDTH               => C_M_APB_DATA_WIDTH,
         C_S_AXI_DATA_WIDTH               => C_S_AXI_DATA_WIDTH,
         C_APB_NUM_SLAVES                 => C_APB_NUM_SLAVES,
         C_M_APB_PROTOCOL                 => C_M_APB_PROTOCOL
        )
        port map
        (
         M_APB_PCLK                       => S_AXI_ACLK,
         M_APB_PRESETN                    => S_AXI_ARESETN,

         M_APB_PADDR                      => M_APB_PADDR,
         M_APB_PENABLE                    => M_APB_PENABLE,
         M_APB_PWRITE                     => M_APB_PWRITE,
         M_APB_PWDATA                     => M_APB_PWDATA,
         M_APB_PSTRB                      => M_APB_PSTRB,
         M_APB_PPROT                      => M_APB_PPROT,
         apb_pslverr                      => apb_pslverr,
         apb_pready                       => apb_pready,
         apb_rd_request                   => apb_rd_request,
         apb_wr_request                   => apb_wr_request,
         dphase_timeout                   => dphase_timeout,
         apb_prdata                       => apb_prdata,
         rd_data                          => rd_data,
         slv_err_resp                     => slv_err_resp,
         PSEL_i                           => PSEL_i,
         address                          => address,
         axi_awprot                       => axi_awprot,
         S_AXI_WDATA                      => S_AXI_WDATA,
         S_AXI_WSTRB                      => S_AXI_WSTRB,
         S_AXI_ARADDR                     => S_AXI_ARADDR,
         S_AXI_ARPROT                     => S_AXI_ARPROT
        );

end architecture RTL;


-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved. 
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.


-- ----------------------------------------------
-- Libraries
-- ----------------------------------------------
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library work;
    use work.vid_edid_v1_0_0_common_pkg.all;

-- ----------------------------------------------
-- entity declaration
-- ----------------------------------------------
entity vid_edid_v1_0_0_edid_rom is
  generic (
     C_FAMILY               : string  := "spartan6";
     C_COMPONENT_NAME       : string  := "displayport_v4";
     -- AXI 
     C_S_BASEADDR           : string := X"CA400000";
     C_S_HIGHADDR           : string := X"CA40FFFF"
  );
port (
    -- AXI Interface is valid only for Spartan6/Virtex6
    s_axi_aclk              : in    std_logic; 
    s_axi_aresetn           : in    std_logic; 
    s_axi_awaddr            : in    std_logic_vector(31 downto 0); 
    s_axi_awprot            : in    std_logic_vector(2 downto 0); 
    s_axi_awvalid           : in    std_logic; 
    s_axi_awready           : out   std_logic; 
    s_axi_wdata             : in    std_logic_vector(31 downto 0); 
    s_axi_wstrb             : in    std_logic_vector(3 downto 0); 
    s_axi_wvalid            : in    std_logic;
    s_axi_wready            : out   std_logic;
    s_axi_bresp             : out   std_logic_vector(1 downto 0);
    s_axi_bvalid            : out   std_logic;
    s_axi_bready            : in    std_logic;
    s_axi_araddr            : in    std_logic_vector(31 downto 0);
    s_axi_arprot            : in    std_logic_vector(2 downto 0);
    s_axi_arvalid           : in    std_logic;
    s_axi_arready           : out   std_logic;
    s_axi_rdata             : out   std_logic_vector(31 downto 0);
    s_axi_rresp             : out   std_logic_vector(1 downto 0);
    s_axi_rvalid            : out   std_logic;
    s_axi_rready            : in    std_logic;

    -- control clock and reset
    ctl_reset               : in  std_ulogic;                           -- ctl_clk synchronous reset, active low

    -- iic interface
    iic_scl_in              : in  std_ulogic;                           -- serial clock input
    iic_sda_in              : in  std_ulogic;                           -- serial data input
    iic_sda_out             : out std_ulogic;                           -- data output 

    -- EDID programmable interface
    ctl_clk                 : in  std_ulogic                           -- clock to run internal logic
);
end entity vid_edid_v1_0_0_edid_rom;


-- ----------------------------------------------
-- architecture definition
-- ----------------------------------------------
architecture rtl of vid_edid_v1_0_0_edid_rom is

-------------------------------------------------------------------------------
-- hexstr_to_std_logic_vec
--  This function converts a hex string to a std_logic_vector
-------------------------------------------------------------------------------
  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer ) RETURN std_logic_vector IS
    VARIABLE RESULT                      : std_logic_vector(size-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE BIN                         : std_logic_vector(3 DOWNTO 0);
    VARIABLE INDEX                       : integer                           := 0;
  BEGIN
    FOR i IN arg1'reverse_range LOOP
      CASE arg1(i) IS
        WHEN '0'  => BIN := (OTHERS => '0');
        WHEN '1'  => BIN := (0 => '1', OTHERS => '0');
        WHEN '2'  => BIN := (1 => '1', OTHERS => '0');
        WHEN '3'  => BIN := (0 => '1', 1 => '1', OTHERS => '0');
        WHEN '4'  => BIN := (2 => '1', OTHERS => '0');
        WHEN '5'  => BIN := (0 => '1', 2 => '1', OTHERS => '0');
        WHEN '6'  => BIN := (1 => '1', 2 => '1', OTHERS => '0');
        WHEN '7'  => BIN := (3 => '0', OTHERS => '1');
        WHEN '8'  => BIN := (3 => '1', OTHERS => '0');
        WHEN '9'  => BIN := (0 => '1', 3 => '1', OTHERS => '0');
        WHEN 'A'  => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'a'  => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'B'  => BIN := (2 => '0', OTHERS => '1');
        WHEN 'b'  => BIN := (2 => '0', OTHERS => '1');
        WHEN 'C'  => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'c'  => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'D'  => BIN := (1 => '0', OTHERS => '1');
        WHEN 'd'  => BIN := (1 => '0', OTHERS => '1');
        WHEN 'E'  => BIN := (0 => '0', OTHERS => '1');
        WHEN 'e'  => BIN := (0 => '0', OTHERS => '1');
        WHEN 'F'  => BIN := (OTHERS => '1');
        WHEN 'f'  => BIN := (OTHERS => '1');
        WHEN OTHERS         =>
          --ASSERT false
          --  REPORT "NOT A HEX CHARACTER" SEVERITY error;
          FOR j IN 0 TO 3 LOOP
            BIN(j)      := 'X';
          END LOOP;
      END CASE;
      FOR j IN 0 TO 3 LOOP
        IF (INDEX*4)+j < size THEN
          RESULT((INDEX*4)+j)  := BIN(j);
        END IF;
      END LOOP;
      INDEX := INDEX + 1;
    END LOOP;
    RETURN RESULT;
  END hexstr_to_std_logic_vec;
    -- array definition
    signal i_edid_array      : tUNSIGNED8_ARRAY(0 to 383);
    signal i_edid_prog_array : tUNSIGNED8_ARRAY(0 to 383);

    signal apb_addr     : std_logic_vector(31 downto 0);
    signal apb_select   : std_logic_vector(0 downto 0);
    signal apb_enable   : std_logic;
    signal apb_write    : std_logic;
    signal edid_apb_write : std_logic;
    signal edid_apb_read  : std_logic;
    signal apb_wdata    : std_logic_vector(31 downto 0);
    signal apb_pready   : std_logic_vector(0 downto 0);
    signal apb_rdata    : std_logic_vector(31 downto 0);

    constant S_BASEADDR        : std_logic_vector(31 downto 0) := hexstr_to_std_logic_vec(C_S_BASEADDR, 32);
    constant S_HIGHADDR        : std_logic_vector(31 downto 0) := hexstr_to_std_logic_vec(C_S_HIGHADDR, 32);

    component vid_edid_v1_0_0_axi_apb_bridge is
      generic (
        C_FAMILY              : string                    := "spartan6";
    
        C_S_AXI_ADDR_WIDTH    : integer range 32 to 32    := 32;
        C_S_AXI_DATA_WIDTH    : integer range 32 to 32    := 32;
    						      
        C_M_APB_ADDR_WIDTH    : integer range 32 to 32    := 32;
        C_M_APB_DATA_WIDTH    : integer range 32 to 32    := 32;
        C_APB_NUM_SLAVES      : integer range 1 to 16     := 1;
        C_M_APB_PROTOCOL      : string                    := "APB3";
        C_BASEADDR            : std_logic_vector(0 to 31) := X"FFFFFFFF";
        C_HIGHADDR            : std_logic_vector(0 to 31) := X"00000000";
        C_DPHASE_TIMEOUT      : integer range 0 to 256    := 0
        );
      port (
      -- AXI Signals
        S_AXI_ACLK         : in  std_logic;
        S_AXI_ARESETN      : in  std_logic;
        
        S_AXI_AWADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWPROT       : in  std_logic_vector(2 downto 0);
        S_AXI_AWVALID      : in  std_logic;
        S_AXI_AWREADY      : out std_logic;
        S_AXI_WDATA        : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB        : in  std_logic_vector
                                 ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        S_AXI_WVALID       : in  std_logic;
        S_AXI_WREADY       : out std_logic;
        S_AXI_BRESP        : out std_logic_vector(1 downto 0);
        S_AXI_BVALID       : out std_logic;
        S_AXI_BREADY       : in  std_logic;
        
        S_AXI_ARADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARPROT       : in  std_logic_vector(2 downto 0);
        S_AXI_ARVALID      : in  std_logic;
        S_AXI_ARREADY      : out std_logic;
        S_AXI_RDATA        : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP        : out std_logic_vector(1 downto 0);
        S_AXI_RVALID       : out std_logic;
        S_AXI_RREADY       : in  std_logic;
        
    -- APB signals    
        M_APB_PADDR        : out std_logic_vector(C_M_APB_ADDR_WIDTH-1 downto 0);
        M_APB_PSEL         : out std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
        M_APB_PENABLE      : out std_logic;
        M_APB_PWRITE       : out std_logic;
        M_APB_PWDATA       : out std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
        M_APB_PREADY       : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
        M_APB_PRDATA       : in  std_logic_vector(C_M_APB_DATA_WIDTH-1 downto 0);
        M_APB_PSLVERR      : in  std_logic_vector(C_APB_NUM_SLAVES-1 downto 0);
        M_APB_PPROT        : out std_logic_vector(2 downto 0);
        M_APB_PSTRB        : out std_logic_vector
                                 ((C_M_APB_DATA_WIDTH/8)-1 downto 0)
        );

    end component;
    -- compute checksum function
    function compute_checksum (uint8_array : tUNSIGNED8_ARRAY) return unsigned is
        variable i_checksum : unsigned (7 downto 0) := x"00";
    begin
        -- compute sum
        for x in uint8_array'range loop
            i_checksum := i_checksum + uint8_array(x);
        end loop;
        -- 2's comp - logical not + 1
        i_checksum := (not i_checksum) + 1;
        -- return 2's comp
        return (i_checksum);
    end function compute_checksum;

constant kEDID_ARRAY_XIL : tUNSIGNED8_ARRAY(0 to 383) := (
x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"61", x"2C", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"17", x"01", x"04", x"A5", x"40", x"28", x"78", x"02", x"8D", x"85", x"AD", x"4F", x"35", x"B1", x"25",
x"0E", x"50", x"54", x"21", x"08", x"00", x"61", x"40", x"81", x"80", x"A9", x"00", x"D1", x"00", x"D1", x"40",
x"01", x"01", x"01", x"01", x"01", x"01", x"10", x"9A", x"00", x"A0", x"A0", x"A0", x"0A", x"50", x"30", x"20",
x"35", x"00", x"56", x"50", x"21", x"00", x"00", x"1E", x"00", x"00", x"00", x"FF", x"00", x"58", x"49", x"4C",
x"5F", x"44", x"50", x"5F", x"76", x"34", x"5F", x"78", x"0A", x"20", x"00", x"00", x"00", x"FC", x"00", x"58",
x"49", x"4C", x"49", x"4E", x"58", x"20", x"44", x"50", x"0A", x"20", x"20", x"20", x"00", x"00", x"00", x"FD",
x"00", x"31", x"56", x"1D", x"71", x"1C", x"00", x"0A", x"20", x"20", x"20", x"20", x"20", x"20", x"01", x"89",
x"02", x"03", x"1D", x"C5", x"83", x"0F", x"00", x"00", x"23", x"0D", x"7F", x"07", x"50", x"90", x"05", x"04",
x"03", x"02", x"07", x"16", x"01", x"06", x"11", x"12", x"15", x"13", x"14", x"1F", x"20", x"02", x"3A", x"80",
x"18", x"71", x"38", x"2D", x"40", x"58", x"2C", x"45", x"00", x"81", x"91", x"21", x"00", x"00", x"1E", x"01",
x"1D", x"80", x"18", x"71", x"1C", x"16", x"20", x"58", x"2C", x"25", x"00", x"81", x"91", x"21", x"00", x"00",
x"9E", x"01", x"1D", x"00", x"72", x"51", x"D0", x"1E", x"20", x"6E", x"28", x"55", x"00", x"81", x"91", x"21",
x"00", x"00", x"1E", x"8C", x"0A", x"D0", x"8A", x"20", x"E0", x"2D", x"10", x"10", x"3E", x"96", x"00", x"81",
x"91", x"21", x"00", x"00", x"18", x"56", x"AA", x"00", x"18", x"F1", x"70", x"2D", x"80", x"58", x"2C", x"45",
x"00", x"81", x"91", x"21", x"00", x"00", x"3E", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"43",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00"
);

begin

--i_edid_array(0 to 255) <= kEDID_ARRAY_XIL;              --kEDID_ARRAY;
--i_edid_array(127) <= compute_checksum(kEDID_ARRAY_XIL); -- (kEDID_ARRAY);

  apb_pready <=  (others=>'1');

  edid_apb_write <= apb_write and apb_enable and apb_select(0); 

  REG_WR_UPDATE: process(ctl_clk) is
  begin
    if (ctl_clk'event and ctl_clk = '1') then
      if (ctl_reset = '1') then
	i_edid_array(0 to 383) <= kEDID_ARRAY_XIL;
      else
	case edid_apb_write is
	  when '1' => i_edid_array(to_integer( unsigned (apb_addr(10 downto 2)))) <= unsigned (apb_wdata(7 downto 0));
	  when others => null;
	end case;
      end if;
    end if;
  end process REG_WR_UPDATE;
  
  edid_apb_read <= not(apb_write) and apb_select(0);

  REG_RD_UPDATE: process(ctl_clk) is
  begin
    if (ctl_clk'event and ctl_clk = '1') then
      if (ctl_reset = '1') then
	apb_rdata <= (others => '0');
      else
	case edid_apb_read is
	  when '1' => apb_rdata(7 downto 0) <= std_logic_vector(i_edid_array(to_integer(unsigned (apb_addr(10 downto 2)))));
	  when others => null;
	end case;
      end if;
    end if;
  end process REG_RD_UPDATE;

    vid_edid_v1_0_0_axi2apb_inst :  vid_edid_v1_0_0_axi_apb_bridge 
     generic map(
       C_FAMILY              => C_FAMILY,
       C_S_AXI_ADDR_WIDTH    =>  32,
       C_S_AXI_DATA_WIDTH    =>  32,
       C_M_APB_ADDR_WIDTH    =>  32,
       C_M_APB_DATA_WIDTH    =>  32,
       C_APB_NUM_SLAVES      =>  1,
       C_M_APB_PROTOCOL      => "APB3",
       C_BASEADDR            => S_BASEADDR,
       C_HIGHADDR            => S_HIGHADDR,
       C_DPHASE_TIMEOUT      => 0
      ) 
    port map(
    -- AXI Signals
      S_AXI_ACLK        =>  s_axi_aclk, 
      S_AXI_ARESETN     =>  s_axi_aresetn, 
      
      S_AXI_AWADDR      =>  s_axi_awaddr, 
      S_AXI_AWPROT      =>  s_axi_awprot, 
      S_AXI_AWVALID     =>  s_axi_awvalid, 
      S_AXI_AWREADY     =>  s_axi_awready, 
      S_AXI_WDATA       =>  s_axi_wdata, 
      S_AXI_WSTRB       =>  s_axi_wstrb, 
                        
      S_AXI_WVALID      =>  s_axi_wvalid, 
      S_AXI_WREADY      =>  s_axi_wready, 
      S_AXI_BRESP       =>  s_axi_bresp, 
      S_AXI_BVALID      =>  s_axi_bvalid, 
      S_AXI_BREADY      =>  s_axi_bready, 
      
      S_AXI_ARADDR      =>  s_axi_araddr, 
      S_AXI_ARPROT      =>  s_axi_arprot, 
      S_AXI_ARVALID     =>  s_axi_arvalid, 
      S_AXI_ARREADY     =>  s_axi_arready,  
      S_AXI_RDATA       =>  s_axi_rdata, 
      S_AXI_RRESP       =>  s_axi_rresp, 
      S_AXI_RVALID      =>  s_axi_rvalid, 
      S_AXI_RREADY      =>  s_axi_rready, 
      
---- APB signals    
      M_APB_PADDR       =>  apb_addr, 
      M_APB_PSEL        =>  apb_select, 
      M_APB_PENABLE     =>  apb_enable, 
      M_APB_PWRITE      =>  apb_write, 
      M_APB_PWDATA      =>  apb_wdata, 
      M_APB_PREADY      =>  apb_pready, 
      M_APB_PRDATA      =>  apb_rdata, 
      M_APB_PSLVERR     =>  "0", 
      M_APB_PPROT       =>  open, 
      M_APB_PSTRB       =>  open 
    );

-- -----------------------------------------
-- iic rom component
-- -----------------------------------------
iic_rom_inst: entity work.vid_edid_v1_0_0_rom 
generic map (
    gIIC_DEVICE_ADDRESS     => "1010000",       -- 0x50
	gIIC_DEVICE_PAGE_ADDRESS	=> "0110000",		-- 0x30
    gROM_SIZE               => 384              -- EDID 1.4 size
)
port map (
    ctl_clk                 => ctl_clk,
    ctl_reset               => ctl_reset,
    kROM_BYTE_ARRAY         => i_edid_array,
    iic_scl_in              => iic_scl_in,
    iic_sda_in              => iic_sda_in,
    iic_sda_out             => iic_sda_out
);


end architecture rtl;


