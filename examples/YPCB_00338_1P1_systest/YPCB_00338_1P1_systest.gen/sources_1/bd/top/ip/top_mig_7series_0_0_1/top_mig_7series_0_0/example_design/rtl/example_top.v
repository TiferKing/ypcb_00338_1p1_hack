//*****************************************************************************
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 4.2
//  \   \         Application        : MIG
//  /   /         Filename           : example_top.v
// /___/   /\     Date Last Modified : $Date: 2011/06/02 08:35:03 $
// \   \  /  \    Date Created       : Tue Sept 21 2010
//  \___\/\___\
//
// Device           : 7 Series
// Design Name      : DDR3 SDRAM
// Purpose          :
//   Top-level  module. This module serves as an example,
//   and allows the user to synthesize a self-contained design,
//   which they can be used to test their hardware.
//   In addition to the memory controller, the module instantiates:
//     1. Synthesizable testbench - used to model user's backend logic
//        and generate different traffic patterns
// Reference        :
// Revision History :
//*****************************************************************************

//`define SKIP_CALIB
`timescale 1ps/1ps

module example_top #
  (

   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter C0_BEGIN_ADDRESS         = 32'h00000000,
   parameter C0_END_ADDRESS           = 32'h00ffffff,
   parameter C0_PRBS_EADDR_MASK_POS   = 32'hff000000,
   parameter C0_ENFORCE_RD_WR         = 0,
   parameter C0_ENFORCE_RD_WR_CMD     = 8'h11,
   parameter C0_ENFORCE_RD_WR_PATTERN = 3'b000,
   parameter C0_C_EN_WRAP_TRANS       = 0,
   parameter C0_C_AXI_NBURST_TEST     = 0,

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter C0_CK_WIDTH              = 1,
                                     // # of CK/CK# outputs to memory.
   parameter C0_nCS_PER_RANK          = 1,
                                     // # of unique CS outputs per rank for phy
   parameter C0_CKE_WIDTH             = 1,
                                     // # of CKE outputs to memory.
   parameter C0_ODT_WIDTH             = 1,
                                     // # of ODT outputs to memory.
   parameter C0_BANK_WIDTH            = 3,
                                     // # of memory Bank Address bits.
   parameter C0_COL_WIDTH             = 10,
                                     // # of memory Column Address bits.
   parameter C0_CS_WIDTH              = 1,
                                     // # of unique CS outputs to memory.
   parameter C0_DQ_WIDTH              = 72,
                                     // # of DQ (data)
   parameter C0_DQS_WIDTH             = 9,
   parameter C0_DQS_CNT_WIDTH         = 4,
                                     // = ceil(log2(DQS_WIDTH))
   parameter C0_DRAM_WIDTH            = 8,
                                     // # of DQ per DQS
   parameter C0_ECC                   = "ON",
   parameter C0_ECC_TEST              = "OFF",
   //parameter C0_nBANK_MACHS           = 4,
   parameter C0_nBANK_MACHS           = 4,
   parameter C0_RANKS                 = 1,
                                     // # of Ranks.
   parameter C0_ROW_WIDTH             = 15,
                                     // # of memory Row Address bits.
   parameter C0_ADDR_WIDTH            = 29,
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices

   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter C0_BURST_MODE            = "8",
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".

   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter C0_CLKIN_PERIOD          = 5000,
                                     // Input Clock Period
   parameter C0_CLKFBOUT_MULT         = 16,
                                     // write PLL VCO multiplier
   parameter C0_DIVCLK_DIVIDE         = 3,
                                     // write PLL VCO divisor
   parameter C0_CLKOUT0_PHASE         = 337.5,
                                     // Phase for PLL output clock (CLKOUT0)
   parameter C0_CLKOUT0_DIVIDE        = 2,
                                     // VCO output divisor for PLL output clock (CLKOUT0)
   parameter C0_CLKOUT1_DIVIDE        = 2,
                                     // VCO output divisor for PLL output clock (CLKOUT1)
   parameter C0_CLKOUT2_DIVIDE        = 32,
                                     // VCO output divisor for PLL output clock (CLKOUT2)
   parameter C0_CLKOUT3_DIVIDE        = 8,
                                     // VCO output divisor for PLL output clock (CLKOUT3)
   parameter C0_MMCM_VCO              = 1066,
                                     // Max Freq (MHz) of MMCM VCO
   parameter C0_MMCM_MULT_F           = 8,
                                     // write MMCM VCO multiplier
   parameter C0_MMCM_DIVCLK_DIVIDE    = 1,
                                     // write MMCM VCO divisor

   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter C0_SIMULATION            = "FALSE",
                                     // Should be TRUE during design simulations and
                                     // FALSE during implementations

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter C0_TCQ                   = 100,
   
   parameter DRAM_TYPE             = "DDR3",

   
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter C0_nCK_PER_CLK           = 4,
                                     // # of memory CKs per fabric CLK

   
   //***************************************************************************
   // AXI4 Shim parameters
   //***************************************************************************
   parameter C0_C_S_AXI_ID_WIDTH              = 4,
                                             // Width of all master and slave ID signals.
                                             // # = >= 1.
   parameter C0_C_S_AXI_ADDR_WIDTH            = 31,
                                             // Width of S_AXI_AWADDR, S_AXI_ARADDR, M_AXI_AWADDR and
                                             // M_AXI_ARADDR for all SI/MI slots.
                                             // # = 32.
   parameter C0_C_S_AXI_DATA_WIDTH            = 512,
                                             // Width of WDATA and RDATA on SI slot.
                                             // Must be <= APP_DATA_WIDTH.
                                             // # = 32, 64, 128, 256.
   parameter C0_C_S_AXI_SUPPORTS_NARROW_BURST = 0,
                                             // Indicates whether to instatiate upsizer
                                             // Range: 0, 1
      

   //***************************************************************************
   // Debug parameters
   //***************************************************************************
   parameter C0_DEBUG_PORT            = "OFF",
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
      
   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter C1_BEGIN_ADDRESS         = 32'h00000000,
   parameter C1_END_ADDRESS           = 32'h00ffffff,
   parameter C1_PRBS_EADDR_MASK_POS   = 32'hff000000,
   parameter C1_ENFORCE_RD_WR         = 0,
   parameter C1_ENFORCE_RD_WR_CMD     = 8'h11,
   parameter C1_ENFORCE_RD_WR_PATTERN = 3'b000,
   parameter C1_C_EN_WRAP_TRANS       = 0,
   parameter C1_C_AXI_NBURST_TEST     = 0,

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter C1_CK_WIDTH              = 1,
                                     // # of CK/CK# outputs to memory.
   parameter C1_nCS_PER_RANK          = 1,
                                     // # of unique CS outputs per rank for phy
   parameter C1_CKE_WIDTH             = 1,
                                     // # of CKE outputs to memory.
   parameter C1_ODT_WIDTH             = 1,
                                     // # of ODT outputs to memory.
   parameter C1_BANK_WIDTH            = 3,
                                     // # of memory Bank Address bits.
   parameter C1_COL_WIDTH             = 10,
                                     // # of memory Column Address bits.
   parameter C1_CS_WIDTH              = 1,
                                     // # of unique CS outputs to memory.
   parameter C1_DQ_WIDTH              = 72,
                                     // # of DQ (data)
   parameter C1_DQS_WIDTH             = 9,
   parameter C1_DQS_CNT_WIDTH         = 4,
                                     // = ceil(log2(DQS_WIDTH))
   parameter C1_DRAM_WIDTH            = 8,
                                     // # of DQ per DQS
   parameter C1_ECC                   = "ON",
   parameter C1_ECC_TEST              = "OFF",
   //parameter C1_nBANK_MACHS           = 4,
   parameter C1_nBANK_MACHS           = 4,
   parameter C1_RANKS                 = 1,
                                     // # of Ranks.
   parameter C1_ROW_WIDTH             = 15,
                                     // # of memory Row Address bits.
   parameter C1_ADDR_WIDTH            = 29,
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices

   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter C1_BURST_MODE            = "8",
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".

   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter C1_CLKIN_PERIOD          = 5000,
                                     // Input Clock Period
   parameter C1_CLKFBOUT_MULT         = 16,
                                     // write PLL VCO multiplier
   parameter C1_DIVCLK_DIVIDE         = 3,
                                     // write PLL VCO divisor
   parameter C1_CLKOUT0_PHASE         = 337.5,
                                     // Phase for PLL output clock (CLKOUT0)
   parameter C1_CLKOUT0_DIVIDE        = 2,
                                     // VCO output divisor for PLL output clock (CLKOUT0)
   parameter C1_CLKOUT1_DIVIDE        = 2,
                                     // VCO output divisor for PLL output clock (CLKOUT1)
   parameter C1_CLKOUT2_DIVIDE        = 32,
                                     // VCO output divisor for PLL output clock (CLKOUT2)
   parameter C1_CLKOUT3_DIVIDE        = 8,
                                     // VCO output divisor for PLL output clock (CLKOUT3)
   parameter C1_MMCM_VCO              = 1066,
                                     // Max Freq (MHz) of MMCM VCO
   parameter C1_MMCM_MULT_F           = 8,
                                     // write MMCM VCO multiplier
   parameter C1_MMCM_DIVCLK_DIVIDE    = 1,
                                     // write MMCM VCO divisor

   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter C1_SIMULATION            = "FALSE",
                                     // Should be TRUE during design simulations and
                                     // FALSE during implementations

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter C1_TCQ                   = 100,
   

   
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter C1_nCK_PER_CLK           = 4,
                                     // # of memory CKs per fabric CLK

   
   //***************************************************************************
   // AXI4 Shim parameters
   //***************************************************************************
   parameter C1_C_S_AXI_ID_WIDTH              = 4,
                                             // Width of all master and slave ID signals.
                                             // # = >= 1.
   parameter C1_C_S_AXI_ADDR_WIDTH            = 31,
                                             // Width of S_AXI_AWADDR, S_AXI_ARADDR, M_AXI_AWADDR and
                                             // M_AXI_ARADDR for all SI/MI slots.
                                             // # = 32.
   parameter C1_C_S_AXI_DATA_WIDTH            = 512,
                                             // Width of WDATA and RDATA on SI slot.
                                             // Must be <= APP_DATA_WIDTH.
                                             // # = 32, 64, 128, 256.
   parameter C1_C_S_AXI_SUPPORTS_NARROW_BURST = 0,
                                             // Indicates whether to instatiate upsizer
                                             // Range: 0, 1
      

   //***************************************************************************
   // Debug parameters
   //***************************************************************************
   parameter C1_DEBUG_PORT            = "OFF",
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
      
   parameter RST_ACT_LOW           = 1
                                     // =1 for active low reset,
                                     // =0 for active high.
   )
  (

   // Inouts
   inout [71:0]                         c0_ddr3_dq,
   inout [8:0]                        c0_ddr3_dqs_n,
   inout [8:0]                        c0_ddr3_dqs_p,

   // Outputs
   output [14:0]                       c0_ddr3_addr,
   output [2:0]                      c0_ddr3_ba,
   output                                       c0_ddr3_ras_n,
   output                                       c0_ddr3_cas_n,
   output                                       c0_ddr3_we_n,
   output                                       c0_ddr3_reset_n,
   output [0:0]                        c0_ddr3_ck_p,
   output [0:0]                        c0_ddr3_ck_n,
   output [0:0]                       c0_ddr3_cke,
   
   output [0:0]           c0_ddr3_cs_n,
   
   
   output [0:0]                       c0_ddr3_odt,
   

   // Inputs
   
   // Differential system clocks
   input                                        c0_sys_clk_p,
   input                                        c0_sys_clk_n,
   

   output                                       tg_compare_error,
   output                                       init_calib_complete,
   
      
   // Inouts
   inout [71:0]                         c1_ddr3_dq,
   inout [8:0]                        c1_ddr3_dqs_n,
   inout [8:0]                        c1_ddr3_dqs_p,

   // Outputs
   output [14:0]                       c1_ddr3_addr,
   output [2:0]                      c1_ddr3_ba,
   output                                       c1_ddr3_ras_n,
   output                                       c1_ddr3_cas_n,
   output                                       c1_ddr3_we_n,
   output                                       c1_ddr3_reset_n,
   output [0:0]                        c1_ddr3_ck_p,
   output [0:0]                        c1_ddr3_ck_n,
   output [0:0]                       c1_ddr3_cke,
   
   output [0:0]           c1_ddr3_cs_n,
   
   
   output [0:0]                       c1_ddr3_odt,
   

   // Inputs
   
   // Differential system clocks
   input                                        c1_sys_clk_p,
   input                                        c1_sys_clk_n,
   

   
   
   
      

   // System reset - Default polarity of sys_rst pin is Active Low.
   // System reset polarity will change based on the option 
   // selected in GUI.
   input                                        sys_rst
   );

function integer clogb2 (input integer size);
    begin
      size = size - 1;
      for (clogb2=1; size>1; clogb2=clogb2+1)
        size = size >> 1;
    end
  endfunction // clogb2

  function integer STR_TO_INT;
    input [7:0] in;
    begin
      if(in == "8")
        STR_TO_INT = 8;
      else if(in == "4")
        STR_TO_INT = 4;
      else
        STR_TO_INT = 0;
    end
  endfunction


  localparam C0_DATA_WIDTH            = 64;
  localparam C0_RANK_WIDTH = clogb2(C0_RANKS);
  localparam C0_PAYLOAD_WIDTH         = (C0_ECC_TEST == "OFF") ? C0_DATA_WIDTH : C0_DQ_WIDTH;
  localparam C0_BURST_LENGTH          = STR_TO_INT(C0_BURST_MODE);
  localparam C0_APP_DATA_WIDTH        = 2 * C0_nCK_PER_CLK * C0_PAYLOAD_WIDTH;
  localparam C0_APP_MASK_WIDTH        = C0_APP_DATA_WIDTH / 8;

  //***************************************************************************
  // Traffic Gen related parameters (derived)
  //***************************************************************************
  localparam  C0_TG_ADDR_WIDTH = ((C0_CS_WIDTH == 1) ? 0 : C0_RANK_WIDTH)
                                 + C0_BANK_WIDTH + C0_ROW_WIDTH + C0_COL_WIDTH;
  localparam C0_MASK_SIZE             = C0_DATA_WIDTH/8;
  localparam C0_DBG_WR_STS_WIDTH      = 40;
  localparam C0_DBG_RD_STS_WIDTH      = 40;
      
  localparam C1_DATA_WIDTH            = 64;
  localparam C1_RANK_WIDTH = clogb2(C1_RANKS);
  localparam C1_PAYLOAD_WIDTH         = (C1_ECC_TEST == "OFF") ? C1_DATA_WIDTH : C1_DQ_WIDTH;
  localparam C1_BURST_LENGTH          = STR_TO_INT(C1_BURST_MODE);
  localparam C1_APP_DATA_WIDTH        = 2 * C1_nCK_PER_CLK * C1_PAYLOAD_WIDTH;
  localparam C1_APP_MASK_WIDTH        = C1_APP_DATA_WIDTH / 8;

  //***************************************************************************
  // Traffic Gen related parameters (derived)
  //***************************************************************************
  localparam  C1_TG_ADDR_WIDTH = ((C1_CS_WIDTH == 1) ? 0 : C1_RANK_WIDTH)
                                 + C1_BANK_WIDTH + C1_ROW_WIDTH + C1_COL_WIDTH;
  localparam C1_MASK_SIZE             = C1_DATA_WIDTH/8;
  localparam C1_DBG_WR_STS_WIDTH      = 40;
  localparam C1_DBG_RD_STS_WIDTH      = 40;
      

  // Wire declarations
      
  wire                              c0_clk;
  wire                              c0_rst;
  wire                              c0_mmcm_locked;
  reg                               c0_aresetn;
  wire                              c0_app_sr_active;
  wire                              c0_app_ref_ack;
  wire                              c0_app_zq_ack;
  wire [(2*C0_nCK_PER_CLK)-1:0]          c0_app_ecc_multiple_err;
  wire [(2*C0_nCK_PER_CLK)-1:0]          c0_app_ecc_single_err;
  wire                              c0_app_rd_data_valid;
  wire [C0_APP_DATA_WIDTH-1:0]         c0_app_rd_data;

  wire                              c0_mem_pattern_init_done;

  wire                              c0_cmd_err;
  wire                              c0_data_msmatch_err;
  wire                              c0_write_err;
  wire                              c0_read_err;
  wire                              c0_test_cmptd;
  wire                              c0_write_cmptd;
  wire                              c0_read_cmptd;
  wire                              c0_cmptd_one_wr_rd;

  // Slave Interface Write Address Ports
  wire [C0_C_S_AXI_ID_WIDTH-1:0]       c0_s_axi_awid;
  wire [C0_C_S_AXI_ADDR_WIDTH-1:0]     c0_s_axi_awaddr;
  wire [7:0]                        c0_s_axi_awlen;
  wire [2:0]                        c0_s_axi_awsize;
  wire [1:0]                        c0_s_axi_awburst;
  wire [0:0]                        c0_s_axi_awlock;
  wire [3:0]                        c0_s_axi_awcache;
  wire [2:0]                        c0_s_axi_awprot;
  wire                              c0_s_axi_awvalid;
  wire                              c0_s_axi_awready;
   // Slave Interface Write Data Ports
  wire [C0_C_S_AXI_DATA_WIDTH-1:0]     c0_s_axi_wdata;
  wire [(C0_C_S_AXI_DATA_WIDTH/8)-1:0]   c0_s_axi_wstrb;
  wire                              c0_s_axi_wlast;
  wire                              c0_s_axi_wvalid;
  wire                              c0_s_axi_wready;
   // Slave Interface Write Response Ports
  wire                              c0_s_axi_bready;
  wire [C0_C_S_AXI_ID_WIDTH-1:0]       c0_s_axi_bid;
  wire [1:0]                        c0_s_axi_bresp;
  wire                              c0_s_axi_bvalid;
   // Slave Interface Read Address Ports
  wire [C0_C_S_AXI_ID_WIDTH-1:0]       c0_s_axi_arid;
  wire [C0_C_S_AXI_ADDR_WIDTH-1:0]     c0_s_axi_araddr;
  wire [7:0]                        c0_s_axi_arlen;
  wire [2:0]                        c0_s_axi_arsize;
  wire [1:0]                        c0_s_axi_arburst;
  wire [0:0]                        c0_s_axi_arlock;
  wire [3:0]                        c0_s_axi_arcache;
  wire [2:0]                        c0_s_axi_arprot;
  wire                              c0_s_axi_arvalid;
  wire                              c0_s_axi_arready;
   // Slave Interface Read Data Ports
  wire                              c0_s_axi_rready;
  wire [C0_C_S_AXI_ID_WIDTH-1:0]       c0_s_axi_rid;
  wire [C0_C_S_AXI_DATA_WIDTH-1:0]     c0_s_axi_rdata;
  wire [1:0]                        c0_s_axi_rresp;
  wire                              c0_s_axi_rlast;
  wire                              c0_s_axi_rvalid;

  wire                              c0_cmp_data_valid;
  wire [C0_C_S_AXI_DATA_WIDTH-1:0]      c0_cmp_data;     // Compare data
  wire [C0_C_S_AXI_DATA_WIDTH-1:0]      c0_rdata_cmp;      // Read data

  wire                              c0_dbg_wr_sts_vld;
  wire [C0_DBG_WR_STS_WIDTH-1:0]       c0_dbg_wr_sts;
  wire                              c0_dbg_rd_sts_vld;
  wire [C0_DBG_RD_STS_WIDTH-1:0]       c0_dbg_rd_sts;
  wire [11:0]                           c0_device_temp;
  
`ifdef SKIP_CALIB
  // skip calibration wires
  wire                          c0_calib_tap_req;
  reg                           c0_calib_tap_load;
  reg [6:0]                     c0_calib_tap_addr;
  reg [7:0]                     c0_calib_tap_val;
  reg                           c0_calib_tap_load_done;
`endif
      
    // Wire declarations
      
  wire                              c1_clk;
  wire                              c1_rst;
  wire                              c1_mmcm_locked;
  reg                               c1_aresetn;
  wire                              c1_app_sr_active;
  wire                              c1_app_ref_ack;
  wire                              c1_app_zq_ack;
  wire [(2*C1_nCK_PER_CLK)-1:0]          c1_app_ecc_multiple_err;
  wire [(2*C1_nCK_PER_CLK)-1:0]          c1_app_ecc_single_err;
  wire                              c1_app_rd_data_valid;
  wire [C1_APP_DATA_WIDTH-1:0]         c1_app_rd_data;

  wire                              c1_mem_pattern_init_done;

  wire                              c1_cmd_err;
  wire                              c1_data_msmatch_err;
  wire                              c1_write_err;
  wire                              c1_read_err;
  wire                              c1_test_cmptd;
  wire                              c1_write_cmptd;
  wire                              c1_read_cmptd;
  wire                              c1_cmptd_one_wr_rd;

  // Slave Interface Write Address Ports
  wire [C1_C_S_AXI_ID_WIDTH-1:0]       c1_s_axi_awid;
  wire [C1_C_S_AXI_ADDR_WIDTH-1:0]     c1_s_axi_awaddr;
  wire [7:0]                        c1_s_axi_awlen;
  wire [2:0]                        c1_s_axi_awsize;
  wire [1:0]                        c1_s_axi_awburst;
  wire [0:0]                        c1_s_axi_awlock;
  wire [3:0]                        c1_s_axi_awcache;
  wire [2:0]                        c1_s_axi_awprot;
  wire                              c1_s_axi_awvalid;
  wire                              c1_s_axi_awready;
   // Slave Interface Write Data Ports
  wire [C1_C_S_AXI_DATA_WIDTH-1:0]     c1_s_axi_wdata;
  wire [(C1_C_S_AXI_DATA_WIDTH/8)-1:0]   c1_s_axi_wstrb;
  wire                              c1_s_axi_wlast;
  wire                              c1_s_axi_wvalid;
  wire                              c1_s_axi_wready;
   // Slave Interface Write Response Ports
  wire                              c1_s_axi_bready;
  wire [C1_C_S_AXI_ID_WIDTH-1:0]       c1_s_axi_bid;
  wire [1:0]                        c1_s_axi_bresp;
  wire                              c1_s_axi_bvalid;
   // Slave Interface Read Address Ports
  wire [C1_C_S_AXI_ID_WIDTH-1:0]       c1_s_axi_arid;
  wire [C1_C_S_AXI_ADDR_WIDTH-1:0]     c1_s_axi_araddr;
  wire [7:0]                        c1_s_axi_arlen;
  wire [2:0]                        c1_s_axi_arsize;
  wire [1:0]                        c1_s_axi_arburst;
  wire [0:0]                        c1_s_axi_arlock;
  wire [3:0]                        c1_s_axi_arcache;
  wire [2:0]                        c1_s_axi_arprot;
  wire                              c1_s_axi_arvalid;
  wire                              c1_s_axi_arready;
   // Slave Interface Read Data Ports
  wire                              c1_s_axi_rready;
  wire [C1_C_S_AXI_ID_WIDTH-1:0]       c1_s_axi_rid;
  wire [C1_C_S_AXI_DATA_WIDTH-1:0]     c1_s_axi_rdata;
  wire [1:0]                        c1_s_axi_rresp;
  wire                              c1_s_axi_rlast;
  wire                              c1_s_axi_rvalid;

  wire                              c1_cmp_data_valid;
  wire [C1_C_S_AXI_DATA_WIDTH-1:0]      c1_cmp_data;     // Compare data
  wire [C1_C_S_AXI_DATA_WIDTH-1:0]      c1_rdata_cmp;      // Read data

  wire                              c1_dbg_wr_sts_vld;
  wire [C1_DBG_WR_STS_WIDTH-1:0]       c1_dbg_wr_sts;
  wire                              c1_dbg_rd_sts_vld;
  wire [C1_DBG_RD_STS_WIDTH-1:0]       c1_dbg_rd_sts;
  wire [11:0]                           c1_device_temp;
  
`ifdef SKIP_CALIB
  // skip calibration wires
  wire                          c1_calib_tap_req;
  reg                           c1_calib_tap_load;
  reg [6:0]                     c1_calib_tap_addr;
  reg [7:0]                     c1_calib_tap_val;
  reg                           c1_calib_tap_load_done;
`endif
      
  

//***************************************************************************
	wire                            c0_init_calib_complete;
	wire                            c0_tg_compare_error;
	wire                            c1_init_calib_complete;
	wire                            c1_tg_compare_error;

  assign init_calib_complete = c0_init_calib_complete & c1_init_calib_complete;
  assign tg_compare_error = c0_tg_compare_error | c1_tg_compare_error;
  assign c0_tg_compare_error = c0_cmd_err | c0_data_msmatch_err | c0_write_err | c0_read_err | (|c0_app_ecc_multiple_err) | (|c0_app_ecc_single_err);
      
        assign c1_tg_compare_error = c1_cmd_err | c1_data_msmatch_err | c1_write_err | c1_read_err | (|c1_app_ecc_multiple_err) | (|c1_app_ecc_single_err);
      
      


      
      
// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

  top_mig_7series_0_0 u_top_mig_7series_0_0
      (
       
       
// Memory interface ports
       .c0_ddr3_addr                      (c0_ddr3_addr),
       .c0_ddr3_ba                        (c0_ddr3_ba),
       .c0_ddr3_cas_n                     (c0_ddr3_cas_n),
       .c0_ddr3_ck_n                      (c0_ddr3_ck_n),
       .c0_ddr3_ck_p                      (c0_ddr3_ck_p),
       .c0_ddr3_cke                       (c0_ddr3_cke),
       .c0_ddr3_ras_n                     (c0_ddr3_ras_n),
       .c0_ddr3_we_n                      (c0_ddr3_we_n),
       .c0_ddr3_dq                        (c0_ddr3_dq),
       .c0_ddr3_dqs_n                     (c0_ddr3_dqs_n),
       .c0_ddr3_dqs_p                     (c0_ddr3_dqs_p),
       .c0_ddr3_reset_n                   (c0_ddr3_reset_n),
       .c0_init_calib_complete            (c0_init_calib_complete),
      
       .c0_ddr3_cs_n                      (c0_ddr3_cs_n),
       .c0_ddr3_odt                       (c0_ddr3_odt),
// Application interface ports
       .c0_ui_clk                         (c0_clk),
       .c0_ui_clk_sync_rst                (c0_rst),

       .c0_mmcm_locked                    (c0_mmcm_locked),
       .c0_aresetn                        (c0_aresetn),
       .c0_app_sr_active                  (c0_app_sr_active),
       .c0_app_ref_ack                    (c0_app_ref_ack),
       .c0_app_zq_ack                     (c0_app_zq_ack),

// Slave Interface Write Address Ports
       .c0_s_axi_awid                     (c0_s_axi_awid),
       .c0_s_axi_awaddr                   (c0_s_axi_awaddr),
       .c0_s_axi_awlen                    (c0_s_axi_awlen),
       .c0_s_axi_awsize                   (c0_s_axi_awsize),
       .c0_s_axi_awburst                  (c0_s_axi_awburst),
       .c0_s_axi_awlock                   (c0_s_axi_awlock),
       .c0_s_axi_awcache                  (c0_s_axi_awcache),
       .c0_s_axi_awprot                   (c0_s_axi_awprot),
       .c0_s_axi_awqos                    (4'h0),
       .c0_s_axi_awvalid                  (c0_s_axi_awvalid),
       .c0_s_axi_awready                  (c0_s_axi_awready),
// Slave Interface Write Data Ports
       .c0_s_axi_wdata                    (c0_s_axi_wdata),
       .c0_s_axi_wstrb                    (c0_s_axi_wstrb),
       .c0_s_axi_wlast                    (c0_s_axi_wlast),
       .c0_s_axi_wvalid                   (c0_s_axi_wvalid),
       .c0_s_axi_wready                   (c0_s_axi_wready),
// Slave Interface Write Response Ports
       .c0_s_axi_bid                      (c0_s_axi_bid),
       .c0_s_axi_bresp                    (c0_s_axi_bresp),
       .c0_s_axi_bvalid                   (c0_s_axi_bvalid),
       .c0_s_axi_bready                   (c0_s_axi_bready),
// Slave Interface Read Address Ports
       .c0_s_axi_arid                     (c0_s_axi_arid),
       .c0_s_axi_araddr                   (c0_s_axi_araddr),
       .c0_s_axi_arlen                    (c0_s_axi_arlen),
       .c0_s_axi_arsize                   (c0_s_axi_arsize),
       .c0_s_axi_arburst                  (c0_s_axi_arburst),
       .c0_s_axi_arlock                   (c0_s_axi_arlock),
       .c0_s_axi_arcache                  (c0_s_axi_arcache),
       .c0_s_axi_arprot                   (c0_s_axi_arprot),
       .c0_s_axi_arqos                    (4'h0),
       .c0_s_axi_arvalid                  (c0_s_axi_arvalid),
       .c0_s_axi_arready                  (c0_s_axi_arready),
// Slave Interface Read Data Ports
       .c0_s_axi_rid                      (c0_s_axi_rid),
       .c0_s_axi_rdata                    (c0_s_axi_rdata),
       .c0_s_axi_rresp                    (c0_s_axi_rresp),
       .c0_s_axi_rlast                    (c0_s_axi_rlast),
       .c0_s_axi_rvalid                   (c0_s_axi_rvalid),
       .c0_s_axi_rready                   (c0_s_axi_rready),
// AXI CTRL port
       .c0_s_axi_ctrl_awvalid             (1'b0),
       .c0_s_axi_ctrl_awready             (),
       .c0_s_axi_ctrl_awaddr              ('b0),
// Slave Interface Write Data Ports
       .c0_s_axi_ctrl_wvalid              (1'b0),
       .c0_s_axi_ctrl_wready              (),
       .c0_s_axi_ctrl_wdata               ('b0),
// Slave Interface Write Response Ports
       .c0_s_axi_ctrl_bvalid              (),
       .c0_s_axi_ctrl_bready              (1'b1),
       .c0_s_axi_ctrl_bresp               (),
// Slave Interface Read Address Ports
       .c0_s_axi_ctrl_arvalid             (1'b0),
       .c0_s_axi_ctrl_arready             (),
       .c0_s_axi_ctrl_araddr              ('b0),
// Slave Interface Read Data Ports
       .c0_s_axi_ctrl_rvalid              (),
       .c0_s_axi_ctrl_rready              (1'b1),
       .c0_s_axi_ctrl_rdata               (),
       .c0_s_axi_ctrl_rresp               (),
// Interrupt output
       .c0_interrupt                      (),
      .c0_app_ecc_multiple_err           (c0_app_ecc_multiple_err),
       .c0_app_ecc_single_err             (c0_app_ecc_single_err),
       
// System Clock Ports
       .c0_sys_clk_p                       (c0_sys_clk_p),
       .c0_sys_clk_n                       (c0_sys_clk_n),
       .c0_device_temp            (c0_device_temp),
       `ifdef SKIP_CALIB
       .c0_calib_tap_req                    (c0_calib_tap_req),
       .c0_calib_tap_load                   (c0_calib_tap_load),
       .c0_calib_tap_addr                   (c0_calib_tap_addr),
       .c0_calib_tap_val                    (c0_calib_tap_val),
       .c0_calib_tap_load_done              (c0_calib_tap_load_done),
       `endif
      
       
// Memory interface ports
       .c1_ddr3_addr                      (c1_ddr3_addr),
       .c1_ddr3_ba                        (c1_ddr3_ba),
       .c1_ddr3_cas_n                     (c1_ddr3_cas_n),
       .c1_ddr3_ck_n                      (c1_ddr3_ck_n),
       .c1_ddr3_ck_p                      (c1_ddr3_ck_p),
       .c1_ddr3_cke                       (c1_ddr3_cke),
       .c1_ddr3_ras_n                     (c1_ddr3_ras_n),
       .c1_ddr3_we_n                      (c1_ddr3_we_n),
       .c1_ddr3_dq                        (c1_ddr3_dq),
       .c1_ddr3_dqs_n                     (c1_ddr3_dqs_n),
       .c1_ddr3_dqs_p                     (c1_ddr3_dqs_p),
       .c1_ddr3_reset_n                   (c1_ddr3_reset_n),
       .c1_init_calib_complete            (c1_init_calib_complete),
      
       .c1_ddr3_cs_n                      (c1_ddr3_cs_n),
       .c1_ddr3_odt                       (c1_ddr3_odt),
// Application interface ports
       .c1_ui_clk                         (c1_clk),
       .c1_ui_clk_sync_rst                (c1_rst),

       .c1_mmcm_locked                    (c1_mmcm_locked),
       .c1_aresetn                        (c1_aresetn),
       .c1_app_sr_active                  (c1_app_sr_active),
       .c1_app_ref_ack                    (c1_app_ref_ack),
       .c1_app_zq_ack                     (c1_app_zq_ack),

// Slave Interface Write Address Ports
       .c1_s_axi_awid                     (c1_s_axi_awid),
       .c1_s_axi_awaddr                   (c1_s_axi_awaddr),
       .c1_s_axi_awlen                    (c1_s_axi_awlen),
       .c1_s_axi_awsize                   (c1_s_axi_awsize),
       .c1_s_axi_awburst                  (c1_s_axi_awburst),
       .c1_s_axi_awlock                   (c1_s_axi_awlock),
       .c1_s_axi_awcache                  (c1_s_axi_awcache),
       .c1_s_axi_awprot                   (c1_s_axi_awprot),
       .c1_s_axi_awqos                    (4'h0),
       .c1_s_axi_awvalid                  (c1_s_axi_awvalid),
       .c1_s_axi_awready                  (c1_s_axi_awready),
// Slave Interface Write Data Ports
       .c1_s_axi_wdata                    (c1_s_axi_wdata),
       .c1_s_axi_wstrb                    (c1_s_axi_wstrb),
       .c1_s_axi_wlast                    (c1_s_axi_wlast),
       .c1_s_axi_wvalid                   (c1_s_axi_wvalid),
       .c1_s_axi_wready                   (c1_s_axi_wready),
// Slave Interface Write Response Ports
       .c1_s_axi_bid                      (c1_s_axi_bid),
       .c1_s_axi_bresp                    (c1_s_axi_bresp),
       .c1_s_axi_bvalid                   (c1_s_axi_bvalid),
       .c1_s_axi_bready                   (c1_s_axi_bready),
// Slave Interface Read Address Ports
       .c1_s_axi_arid                     (c1_s_axi_arid),
       .c1_s_axi_araddr                   (c1_s_axi_araddr),
       .c1_s_axi_arlen                    (c1_s_axi_arlen),
       .c1_s_axi_arsize                   (c1_s_axi_arsize),
       .c1_s_axi_arburst                  (c1_s_axi_arburst),
       .c1_s_axi_arlock                   (c1_s_axi_arlock),
       .c1_s_axi_arcache                  (c1_s_axi_arcache),
       .c1_s_axi_arprot                   (c1_s_axi_arprot),
       .c1_s_axi_arqos                    (4'h0),
       .c1_s_axi_arvalid                  (c1_s_axi_arvalid),
       .c1_s_axi_arready                  (c1_s_axi_arready),
// Slave Interface Read Data Ports
       .c1_s_axi_rid                      (c1_s_axi_rid),
       .c1_s_axi_rdata                    (c1_s_axi_rdata),
       .c1_s_axi_rresp                    (c1_s_axi_rresp),
       .c1_s_axi_rlast                    (c1_s_axi_rlast),
       .c1_s_axi_rvalid                   (c1_s_axi_rvalid),
       .c1_s_axi_rready                   (c1_s_axi_rready),
// AXI CTRL port
       .c1_s_axi_ctrl_awvalid             (1'b0),
       .c1_s_axi_ctrl_awready             (),
       .c1_s_axi_ctrl_awaddr              ('b0),
// Slave Interface Write Data Ports
       .c1_s_axi_ctrl_wvalid              (1'b0),
       .c1_s_axi_ctrl_wready              (),
       .c1_s_axi_ctrl_wdata               ('b0),
// Slave Interface Write Response Ports
       .c1_s_axi_ctrl_bvalid              (),
       .c1_s_axi_ctrl_bready              (1'b1),
       .c1_s_axi_ctrl_bresp               (),
// Slave Interface Read Address Ports
       .c1_s_axi_ctrl_arvalid             (1'b0),
       .c1_s_axi_ctrl_arready             (),
       .c1_s_axi_ctrl_araddr              ('b0),
// Slave Interface Read Data Ports
       .c1_s_axi_ctrl_rvalid              (),
       .c1_s_axi_ctrl_rready              (1'b1),
       .c1_s_axi_ctrl_rdata               (),
       .c1_s_axi_ctrl_rresp               (),
// Interrupt output
       .c1_interrupt                      (),
      .c1_app_ecc_multiple_err           (c1_app_ecc_multiple_err),
       .c1_app_ecc_single_err             (c1_app_ecc_single_err),
       
// System Clock Ports
       .c1_sys_clk_p                       (c1_sys_clk_p),
       .c1_sys_clk_n                       (c1_sys_clk_n),
       .c1_device_temp            (c1_device_temp),
       `ifdef SKIP_CALIB
       .c1_calib_tap_req                    (c1_calib_tap_req),
       .c1_calib_tap_load                   (c1_calib_tap_load),
       .c1_calib_tap_addr                   (c1_calib_tap_addr),
       .c1_calib_tap_val                    (c1_calib_tap_val),
       .c1_calib_tap_load_done              (c1_calib_tap_load_done),
       `endif
      
       .sys_rst                        (sys_rst)
       );
// End of User Design top instance


//***************************************************************************
// The traffic generation module instantiated below drives traffic (patterns)
// on the application interface of the memory controller
//***************************************************************************

   always @(posedge c0_clk) begin
     c0_aresetn <= ~c0_rst;
   end

   mig_7series_v4_2_axi4_tg #(

     .C_AXI_ID_WIDTH                   (C0_C_S_AXI_ID_WIDTH),
     .C_AXI_ADDR_WIDTH                 (C0_C_S_AXI_ADDR_WIDTH),
     .C_AXI_DATA_WIDTH                 (C0_C_S_AXI_DATA_WIDTH),
     .C_AXI_NBURST_SUPPORT             (C0_C_AXI_NBURST_TEST),
     .C_EN_WRAP_TRANS                  (C0_C_EN_WRAP_TRANS),
     .C_BEGIN_ADDRESS                  (C0_BEGIN_ADDRESS),
     .C_END_ADDRESS                    (C0_END_ADDRESS),
     .PRBS_EADDR_MASK_POS              (C0_PRBS_EADDR_MASK_POS),
     .DBG_WR_STS_WIDTH                 (C0_DBG_WR_STS_WIDTH),
     .DBG_RD_STS_WIDTH                 (C0_DBG_RD_STS_WIDTH),
     .ENFORCE_RD_WR                    (C0_ENFORCE_RD_WR),
     .ENFORCE_RD_WR_CMD                (C0_ENFORCE_RD_WR_CMD),
     .EN_UPSIZER                       (C0_C_S_AXI_SUPPORTS_NARROW_BURST),
     .ENFORCE_RD_WR_PATTERN            (C0_ENFORCE_RD_WR_PATTERN)

   ) c0_u_axi4_tg_inst
   (
     .aclk                             (c0_clk),
     .aresetn                          (c0_aresetn),

// Input control signals
     .init_cmptd                       (c0_init_calib_complete),
     .init_test                        (1'b0),
     .wdog_mask                        (~c0_init_calib_complete),
     .wrap_en                          (1'b0),

// AXI write address channel signals
     .axi_wready                       (c0_s_axi_awready),
     .axi_wid                          (c0_s_axi_awid),
     .axi_waddr                        (c0_s_axi_awaddr),
     .axi_wlen                         (c0_s_axi_awlen),
     .axi_wsize                        (c0_s_axi_awsize),
     .axi_wburst                       (c0_s_axi_awburst),
     .axi_wlock                        (c0_s_axi_awlock),
     .axi_wcache                       (c0_s_axi_awcache),
     .axi_wprot                        (c0_s_axi_awprot),
     .axi_wvalid                       (c0_s_axi_awvalid),

// AXI write data channel signals
     .axi_wd_wready                    (c0_s_axi_wready),
     .axi_wd_wid                       (c0_s_axi_wid),
     .axi_wd_data                      (c0_s_axi_wdata),
     .axi_wd_strb                      (c0_s_axi_wstrb),
     .axi_wd_last                      (c0_s_axi_wlast),
     .axi_wd_valid                     (c0_s_axi_wvalid),

// AXI write response channel signals
     .axi_wd_bid                       (c0_s_axi_bid),
     .axi_wd_bresp                     (c0_s_axi_bresp),
     .axi_wd_bvalid                    (c0_s_axi_bvalid),
     .axi_wd_bready                    (c0_s_axi_bready),

// AXI read address channel signals
     .axi_rready                       (c0_s_axi_arready),
     .axi_rid                          (c0_s_axi_arid),
     .axi_raddr                        (c0_s_axi_araddr),
     .axi_rlen                         (c0_s_axi_arlen),
     .axi_rsize                        (c0_s_axi_arsize),
     .axi_rburst                       (c0_s_axi_arburst),
     .axi_rlock                        (c0_s_axi_arlock),
     .axi_rcache                       (c0_s_axi_arcache),
     .axi_rprot                        (c0_s_axi_arprot),
     .axi_rvalid                       (c0_s_axi_arvalid),

// AXI read data channel signals
     .axi_rd_bid                       (c0_s_axi_rid),
     .axi_rd_rresp                     (c0_s_axi_rresp),
     .axi_rd_rvalid                    (c0_s_axi_rvalid),
     .axi_rd_data                      (c0_s_axi_rdata),
     .axi_rd_last                      (c0_s_axi_rlast),
     .axi_rd_rready                    (c0_s_axi_rready),

// Error status signals
     .cmd_err                          (c0_cmd_err),
     .data_msmatch_err                 (c0_data_msmatch_err),
     .write_err                        (c0_write_err),
     .read_err                         (c0_read_err),
     .test_cmptd                       (c0_test_cmptd),
     .write_cmptd                      (c0_write_cmptd),
     .read_cmptd                       (c0_read_cmptd),
     .cmptd_one_wr_rd                  (c0_cmptd_one_wr_rd),

// Debug status signals
     .cmp_data_en                      (c0_cmp_data_valid),
     .cmp_data_o                       (c0_cmp_data),
     .rdata_cmp                        (c0_rdata_cmp),
     .dbg_wr_sts_vld                   (c0_dbg_wr_sts_vld),
     .dbg_wr_sts                       (c0_dbg_wr_sts),
     .dbg_rd_sts_vld                   (c0_dbg_rd_sts_vld),
     .dbg_rd_sts                       (c0_dbg_rd_sts)
);

      
//***************************************************************************
// The traffic generation module instantiated below drives traffic (patterns)
// on the application interface of the memory controller
//***************************************************************************

   always @(posedge c1_clk) begin
     c1_aresetn <= ~c1_rst;
   end

   mig_7series_v4_2_axi4_tg #(

     .C_AXI_ID_WIDTH                   (C1_C_S_AXI_ID_WIDTH),
     .C_AXI_ADDR_WIDTH                 (C1_C_S_AXI_ADDR_WIDTH),
     .C_AXI_DATA_WIDTH                 (C1_C_S_AXI_DATA_WIDTH),
     .C_AXI_NBURST_SUPPORT             (C1_C_AXI_NBURST_TEST),
     .C_EN_WRAP_TRANS                  (C1_C_EN_WRAP_TRANS),
     .C_BEGIN_ADDRESS                  (C1_BEGIN_ADDRESS),
     .C_END_ADDRESS                    (C1_END_ADDRESS),
     .PRBS_EADDR_MASK_POS              (C1_PRBS_EADDR_MASK_POS),
     .DBG_WR_STS_WIDTH                 (C1_DBG_WR_STS_WIDTH),
     .DBG_RD_STS_WIDTH                 (C1_DBG_RD_STS_WIDTH),
     .ENFORCE_RD_WR                    (C1_ENFORCE_RD_WR),
     .ENFORCE_RD_WR_CMD                (C1_ENFORCE_RD_WR_CMD),
     .EN_UPSIZER                       (C1_C_S_AXI_SUPPORTS_NARROW_BURST),
     .ENFORCE_RD_WR_PATTERN            (C1_ENFORCE_RD_WR_PATTERN)

   ) c1_u_axi4_tg_inst
   (
     .aclk                             (c1_clk),
     .aresetn                          (c1_aresetn),

// Input control signals
     .init_cmptd                       (c1_init_calib_complete),
     .init_test                        (1'b0),
     .wdog_mask                        (~c1_init_calib_complete),
     .wrap_en                          (1'b0),

// AXI write address channel signals
     .axi_wready                       (c1_s_axi_awready),
     .axi_wid                          (c1_s_axi_awid),
     .axi_waddr                        (c1_s_axi_awaddr),
     .axi_wlen                         (c1_s_axi_awlen),
     .axi_wsize                        (c1_s_axi_awsize),
     .axi_wburst                       (c1_s_axi_awburst),
     .axi_wlock                        (c1_s_axi_awlock),
     .axi_wcache                       (c1_s_axi_awcache),
     .axi_wprot                        (c1_s_axi_awprot),
     .axi_wvalid                       (c1_s_axi_awvalid),

// AXI write data channel signals
     .axi_wd_wready                    (c1_s_axi_wready),
     .axi_wd_wid                       (c1_s_axi_wid),
     .axi_wd_data                      (c1_s_axi_wdata),
     .axi_wd_strb                      (c1_s_axi_wstrb),
     .axi_wd_last                      (c1_s_axi_wlast),
     .axi_wd_valid                     (c1_s_axi_wvalid),

// AXI write response channel signals
     .axi_wd_bid                       (c1_s_axi_bid),
     .axi_wd_bresp                     (c1_s_axi_bresp),
     .axi_wd_bvalid                    (c1_s_axi_bvalid),
     .axi_wd_bready                    (c1_s_axi_bready),

// AXI read address channel signals
     .axi_rready                       (c1_s_axi_arready),
     .axi_rid                          (c1_s_axi_arid),
     .axi_raddr                        (c1_s_axi_araddr),
     .axi_rlen                         (c1_s_axi_arlen),
     .axi_rsize                        (c1_s_axi_arsize),
     .axi_rburst                       (c1_s_axi_arburst),
     .axi_rlock                        (c1_s_axi_arlock),
     .axi_rcache                       (c1_s_axi_arcache),
     .axi_rprot                        (c1_s_axi_arprot),
     .axi_rvalid                       (c1_s_axi_arvalid),

// AXI read data channel signals
     .axi_rd_bid                       (c1_s_axi_rid),
     .axi_rd_rresp                     (c1_s_axi_rresp),
     .axi_rd_rvalid                    (c1_s_axi_rvalid),
     .axi_rd_data                      (c1_s_axi_rdata),
     .axi_rd_last                      (c1_s_axi_rlast),
     .axi_rd_rready                    (c1_s_axi_rready),

// Error status signals
     .cmd_err                          (c1_cmd_err),
     .data_msmatch_err                 (c1_data_msmatch_err),
     .write_err                        (c1_write_err),
     .read_err                         (c1_read_err),
     .test_cmptd                       (c1_test_cmptd),
     .write_cmptd                      (c1_write_cmptd),
     .read_cmptd                       (c1_read_cmptd),
     .cmptd_one_wr_rd                  (c1_cmptd_one_wr_rd),

// Debug status signals
     .cmp_data_en                      (c1_cmp_data_valid),
     .cmp_data_o                       (c1_cmp_data),
     .rdata_cmp                        (c1_rdata_cmp),
     .dbg_wr_sts_vld                   (c1_dbg_wr_sts_vld),
     .dbg_wr_sts                       (c1_dbg_wr_sts),
     .dbg_rd_sts_vld                   (c1_dbg_rd_sts_vld),
     .dbg_rd_sts                       (c1_dbg_rd_sts)
);

      


   //*****************************************************************
   // Default values are assigned to the debug inputs
   //*****************************************************************
   assign c0_dbg_sel_pi_incdec       = 'b0;
   assign c0_dbg_sel_po_incdec       = 'b0;
   assign c0_dbg_pi_f_inc            = 'b0;
   assign c0_dbg_pi_f_dec            = 'b0;
   assign c0_dbg_po_f_inc            = 'b0;
   assign c0_dbg_po_f_dec            = 'b0;
   assign c0_dbg_po_f_stg23_sel      = 'b0;
   assign c0_po_win_tg_rst           = 'b0;
   assign c0_vio_tg_rst              = 'b0;
`ifdef SKIP_CALIB
  //***************************************************************************
  // Skip calib test logic
  //***************************************************************************

  reg[3*DQS_WIDTH-1:0]        po_coarse_tap;
  reg[6*DQS_WIDTH-1:0]        po_stg3_taps;
  reg[6*DQS_WIDTH-1:0]        po_stg2_taps;
  reg[6*DQS_WIDTH-1:0]        pi_stg2_taps;
  reg[5*DQS_WIDTH-1:0]        idelay_taps;
  reg[11:0]                   cal_device_temp;


  always @(posedge clk) begin
    // tap values from golden run (factory)
    po_coarse_tap   <= #TCQ 'h2;
    po_stg3_taps    <= #TCQ 'h0D;
    po_stg2_taps    <= #TCQ 'h1D;
    pi_stg2_taps    <= #TCQ 'h1E;
    idelay_taps     <= #TCQ 'h08;
        cal_device_temp <= #TCQ 'h000;
  end

  always @(posedge clk) begin
    if (rst)
      c0_calib_tap_load <= #TCQ 1'b0;
    else if (c0_calib_tap_req)
      c0_calib_tap_load <= #TCQ 1'b1;
  end

  always @(posedge clk) begin
    if (rst) begin
      c0_calib_tap_addr      <= #TCQ 'd0;
      c0_calib_tap_val       <= #TCQ po_coarse_tap[3*c0_calib_tap_addr[6:3]+:3]; //'d1;
      c0_calib_tap_load_done <= #TCQ 1'b0;
    end else if (c0_calib_tap_load) begin
      case (c0_calib_tap_addr[2:0])
        3'b000: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b001;
          c0_calib_tap_val       <= #TCQ po_stg3_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d19;
        end
        3'b001: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b010;
          c0_calib_tap_val       <= #TCQ po_stg2_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d45;
        end
        3'b010: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b011;
          c0_calib_tap_val       <= #TCQ pi_stg2_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d20;
        end
        3'b011: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b100;
          c0_calib_tap_val       <= #TCQ idelay_taps[5*c0_calib_tap_addr[6:3]+:5]; //'d1;
        end
        3'b100: begin
          if (c0_calib_tap_addr[6:3] < DQS_WIDTH-1) begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b000;
            c0_calib_tap_val       <= #TCQ po_coarse_tap[3*(c0_calib_tap_addr[6:3]+1)+:3]; //'d1;
            c0_calib_tap_addr[6:3] <= #TCQ c0_calib_tap_addr[6:3] + 1;
          end else begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b110;
            c0_calib_tap_val       <= #TCQ cal_device_temp[7:0];
            c0_calib_tap_addr[6:3] <= #TCQ 4'b1111;
          end
        end
        3'b110: begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b111;
            c0_calib_tap_val       <= #TCQ {4'h0,cal_device_temp[11:8]};
            c0_calib_tap_addr[6:3] <= #TCQ 4'b1111;
        end
        3'b111: begin
            c0_calib_tap_load_done <= #TCQ 1'b1;
        end
      endcase
    end
  end


//****************skip calib test logic end**********************************
`endif    
   //*****************************************************************
   // Default values are assigned to the debug inputs
   //*****************************************************************
   assign c1_dbg_sel_pi_incdec       = 'b0;
   assign c1_dbg_sel_po_incdec       = 'b0;
   assign c1_dbg_pi_f_inc            = 'b0;
   assign c1_dbg_pi_f_dec            = 'b0;
   assign c1_dbg_po_f_inc            = 'b0;
   assign c1_dbg_po_f_dec            = 'b0;
   assign c1_dbg_po_f_stg23_sel      = 'b0;
   assign c1_po_win_tg_rst           = 'b0;
   assign c1_vio_tg_rst              = 'b0;
`ifdef SKIP_CALIB
  //***************************************************************************
  // Skip calib test logic
  //***************************************************************************

  reg[3*DQS_WIDTH-1:0]        po_coarse_tap;
  reg[6*DQS_WIDTH-1:0]        po_stg3_taps;
  reg[6*DQS_WIDTH-1:0]        po_stg2_taps;
  reg[6*DQS_WIDTH-1:0]        pi_stg2_taps;
  reg[5*DQS_WIDTH-1:0]        idelay_taps;
  reg[11:0]                   cal_device_temp;


  always @(posedge clk) begin
    // tap values from golden run (factory)
    po_coarse_tap   <= #TCQ 'h2;
    po_stg3_taps    <= #TCQ 'h0D;
    po_stg2_taps    <= #TCQ 'h1D;
    pi_stg2_taps    <= #TCQ 'h1E;
    idelay_taps     <= #TCQ 'h08;
        cal_device_temp <= #TCQ 'h000;
  end

  always @(posedge clk) begin
    if (rst)
      c0_calib_tap_load <= #TCQ 1'b0;
    else if (c0_calib_tap_req)
      c0_calib_tap_load <= #TCQ 1'b1;
  end

  always @(posedge clk) begin
    if (rst) begin
      c0_calib_tap_addr      <= #TCQ 'd0;
      c0_calib_tap_val       <= #TCQ po_coarse_tap[3*c0_calib_tap_addr[6:3]+:3]; //'d1;
      c0_calib_tap_load_done <= #TCQ 1'b0;
    end else if (c0_calib_tap_load) begin
      case (c0_calib_tap_addr[2:0])
        3'b000: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b001;
          c0_calib_tap_val       <= #TCQ po_stg3_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d19;
        end
        3'b001: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b010;
          c0_calib_tap_val       <= #TCQ po_stg2_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d45;
        end
        3'b010: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b011;
          c0_calib_tap_val       <= #TCQ pi_stg2_taps[6*c0_calib_tap_addr[6:3]+:6]; //'d20;
        end
        3'b011: begin
          c0_calib_tap_addr[2:0] <= #TCQ 3'b100;
          c0_calib_tap_val       <= #TCQ idelay_taps[5*c0_calib_tap_addr[6:3]+:5]; //'d1;
        end
        3'b100: begin
          if (c0_calib_tap_addr[6:3] < DQS_WIDTH-1) begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b000;
            c0_calib_tap_val       <= #TCQ po_coarse_tap[3*(c0_calib_tap_addr[6:3]+1)+:3]; //'d1;
            c0_calib_tap_addr[6:3] <= #TCQ c0_calib_tap_addr[6:3] + 1;
          end else begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b110;
            c0_calib_tap_val       <= #TCQ cal_device_temp[7:0];
            c0_calib_tap_addr[6:3] <= #TCQ 4'b1111;
          end
        end
        3'b110: begin
            c0_calib_tap_addr[2:0] <= #TCQ 3'b111;
            c0_calib_tap_val       <= #TCQ {4'h0,cal_device_temp[11:8]};
            c0_calib_tap_addr[6:3] <= #TCQ 4'b1111;
        end
        3'b111: begin
            c0_calib_tap_load_done <= #TCQ 1'b1;
        end
      endcase
    end
  end


//****************skip calib test logic end**********************************
`endif    

endmodule


