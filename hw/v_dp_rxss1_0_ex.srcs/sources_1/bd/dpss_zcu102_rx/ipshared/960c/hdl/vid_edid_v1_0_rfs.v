`timescale 1ns / 1ps

module vid_edid_v1_0_0
(
  input  wire        s_axi_aclk,
  input  wire        s_axi_aresetn,
  input  wire [11:0] s_axi_awaddr,
  input  wire [2:0]  s_axi_awprot,
  input  wire        s_axi_awvalid,
  output wire        s_axi_awready,
  input  wire [31:0] s_axi_wdata,
  input  wire [3:0]  s_axi_wstrb,
  input  wire        s_axi_wvalid,
  output wire        s_axi_wready,
  output wire [1:0]  s_axi_bresp,
  output wire        s_axi_bvalid,
  input  wire        s_axi_bready,
  input  wire [11:0] s_axi_araddr,
  input  wire [2:0]  s_axi_arprot,
  input  wire        s_axi_arvalid,
  output wire        s_axi_arready,
  output wire [31:0] s_axi_rdata,
  output wire [1:0]  s_axi_rresp,
  output wire        s_axi_rvalid,
  input  wire        s_axi_rready,
  input  wire        ctl_clk,
  input  wire        ctl_reset,
  input  wire        iic_scl_in,
  input  wire        iic_sda_in,
  output wire        iic_sda_out
);

vid_edid_v1_0_0_edid_rom iic_edid_rom_inst
(
   .s_axi_aclk      (s_axi_aclk   ),
   .s_axi_aresetn   (s_axi_aresetn),
   .s_axi_awaddr    ({20'h00000000000000000000, s_axi_awaddr}),
   .s_axi_awprot    (s_axi_awprot ),
   .s_axi_awvalid   (s_axi_awvalid),
   .s_axi_awready   (s_axi_awready),
   .s_axi_wdata     (s_axi_wdata  ),
   .s_axi_wstrb     (s_axi_wstrb  ),
   .s_axi_wvalid    (s_axi_wvalid ),
   .s_axi_wready    (s_axi_wready ),
   .s_axi_bresp     (s_axi_bresp  ),
   .s_axi_bvalid    (s_axi_bvalid ),
   .s_axi_bready    (s_axi_bready ),
   .s_axi_araddr    ({20'h00000000000000000000, s_axi_araddr}),
   .s_axi_arprot    (s_axi_arprot ),
   .s_axi_arvalid   (s_axi_arvalid),
   .s_axi_arready   (s_axi_arready),
   .s_axi_rdata     (s_axi_rdata  ),
   .s_axi_rresp     (s_axi_rresp  ),
   .s_axi_rvalid    (s_axi_rvalid ),
   .s_axi_rready    (s_axi_rready ),
   .ctl_clk         (ctl_clk),
   .ctl_reset       (ctl_reset),
   .iic_scl_in      (iic_scl_in),
   .iic_sda_in      (iic_sda_in),
   .iic_sda_out     (iic_sda_out)
);

endmodule


