//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Wed Jan  1 02:24:09 2025
//Host        : tiferking-Virtual-Machine running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target top_wrapper.bd
//Design      : top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module top_wrapper
   (DDR3_0_addr,
    DDR3_0_ba,
    DDR3_0_cas_n,
    DDR3_0_ck_n,
    DDR3_0_ck_p,
    DDR3_0_cke,
    DDR3_0_cs_n,
    DDR3_0_dq,
    DDR3_0_dqs_n,
    DDR3_0_dqs_p,
    DDR3_0_odt,
    DDR3_0_ras_n,
    DDR3_0_reset_n,
    DDR3_0_we_n,
    DDR3_1_addr,
    DDR3_1_ba,
    DDR3_1_cas_n,
    DDR3_1_ck_n,
    DDR3_1_ck_p,
    DDR3_1_cke,
    DDR3_1_cs_n,
    DDR3_1_dq,
    DDR3_1_dqs_n,
    DDR3_1_dqs_p,
    DDR3_1_odt,
    DDR3_1_ras_n,
    DDR3_1_reset_n,
    DDR3_1_we_n,
    DDR3_CLK_0_clk_n,
    DDR3_CLK_0_clk_p,
    DDR3_CLK_1_clk_n,
    DDR3_CLK_1_clk_p,
    SYS_CLK,
    SYS_RSTN,
    alert_lm73_tri_i,
    bpi_flash_addr,
    bpi_flash_adv_ldn,
    bpi_flash_ce_n,
    bpi_flash_dq_io,
    bpi_flash_oen,
    bpi_flash_wen,
    iic_lm73_scl_io,
    iic_lm73_sda_io,
    iic_pcie_scl_io,
    iic_pcie_sda_io,
    led_3bits_tri_o,
    pci_express_x8_rxn,
    pci_express_x8_rxp,
    pci_express_x8_txn,
    pci_express_x8_txp,
    pcie_perstn,
    pcie_refclk_clk_n,
    pcie_refclk_clk_p);
  output [14:0]DDR3_0_addr;
  output [2:0]DDR3_0_ba;
  output DDR3_0_cas_n;
  output [0:0]DDR3_0_ck_n;
  output [0:0]DDR3_0_ck_p;
  output [0:0]DDR3_0_cke;
  output [0:0]DDR3_0_cs_n;
  inout [71:0]DDR3_0_dq;
  inout [8:0]DDR3_0_dqs_n;
  inout [8:0]DDR3_0_dqs_p;
  output [0:0]DDR3_0_odt;
  output DDR3_0_ras_n;
  output DDR3_0_reset_n;
  output DDR3_0_we_n;
  output [14:0]DDR3_1_addr;
  output [2:0]DDR3_1_ba;
  output DDR3_1_cas_n;
  output [0:0]DDR3_1_ck_n;
  output [0:0]DDR3_1_ck_p;
  output [0:0]DDR3_1_cke;
  output [0:0]DDR3_1_cs_n;
  inout [71:0]DDR3_1_dq;
  inout [8:0]DDR3_1_dqs_n;
  inout [8:0]DDR3_1_dqs_p;
  output [0:0]DDR3_1_odt;
  output DDR3_1_ras_n;
  output DDR3_1_reset_n;
  output DDR3_1_we_n;
  input DDR3_CLK_0_clk_n;
  input DDR3_CLK_0_clk_p;
  input DDR3_CLK_1_clk_n;
  input DDR3_CLK_1_clk_p;
  input SYS_CLK;
  input SYS_RSTN;
  input alert_lm73_tri_i;
  output [25:1]bpi_flash_addr;
  output bpi_flash_adv_ldn;
  output bpi_flash_ce_n;
  inout [15:0]bpi_flash_dq_io;
  output bpi_flash_oen;
  output bpi_flash_wen;
  inout iic_lm73_scl_io;
  inout iic_lm73_sda_io;
  inout iic_pcie_scl_io;
  inout iic_pcie_sda_io;
  output [2:0]led_3bits_tri_o;
  input [7:0]pci_express_x8_rxn;
  input [7:0]pci_express_x8_rxp;
  output [7:0]pci_express_x8_txn;
  output [7:0]pci_express_x8_txp;
  input pcie_perstn;
  input pcie_refclk_clk_n;
  input pcie_refclk_clk_p;

  wire [14:0]DDR3_0_addr;
  wire [2:0]DDR3_0_ba;
  wire DDR3_0_cas_n;
  wire [0:0]DDR3_0_ck_n;
  wire [0:0]DDR3_0_ck_p;
  wire [0:0]DDR3_0_cke;
  wire [0:0]DDR3_0_cs_n;
  wire [71:0]DDR3_0_dq;
  wire [8:0]DDR3_0_dqs_n;
  wire [8:0]DDR3_0_dqs_p;
  wire [0:0]DDR3_0_odt;
  wire DDR3_0_ras_n;
  wire DDR3_0_reset_n;
  wire DDR3_0_we_n;
  wire [14:0]DDR3_1_addr;
  wire [2:0]DDR3_1_ba;
  wire DDR3_1_cas_n;
  wire [0:0]DDR3_1_ck_n;
  wire [0:0]DDR3_1_ck_p;
  wire [0:0]DDR3_1_cke;
  wire [0:0]DDR3_1_cs_n;
  wire [71:0]DDR3_1_dq;
  wire [8:0]DDR3_1_dqs_n;
  wire [8:0]DDR3_1_dqs_p;
  wire [0:0]DDR3_1_odt;
  wire DDR3_1_ras_n;
  wire DDR3_1_reset_n;
  wire DDR3_1_we_n;
  wire DDR3_CLK_0_clk_n;
  wire DDR3_CLK_0_clk_p;
  wire DDR3_CLK_1_clk_n;
  wire DDR3_CLK_1_clk_p;
  wire SYS_CLK;
  wire SYS_RSTN;
  wire alert_lm73_tri_i;
  wire [25:1]bpi_flash_addr;
  wire bpi_flash_adv_ldn;
  wire bpi_flash_ce_n;
  wire [0:0]bpi_flash_dq_i_0;
  wire [1:1]bpi_flash_dq_i_1;
  wire [10:10]bpi_flash_dq_i_10;
  wire [11:11]bpi_flash_dq_i_11;
  wire [12:12]bpi_flash_dq_i_12;
  wire [13:13]bpi_flash_dq_i_13;
  wire [14:14]bpi_flash_dq_i_14;
  wire [15:15]bpi_flash_dq_i_15;
  wire [2:2]bpi_flash_dq_i_2;
  wire [3:3]bpi_flash_dq_i_3;
  wire [4:4]bpi_flash_dq_i_4;
  wire [5:5]bpi_flash_dq_i_5;
  wire [6:6]bpi_flash_dq_i_6;
  wire [7:7]bpi_flash_dq_i_7;
  wire [8:8]bpi_flash_dq_i_8;
  wire [9:9]bpi_flash_dq_i_9;
  wire [0:0]bpi_flash_dq_io_0;
  wire [1:1]bpi_flash_dq_io_1;
  wire [10:10]bpi_flash_dq_io_10;
  wire [11:11]bpi_flash_dq_io_11;
  wire [12:12]bpi_flash_dq_io_12;
  wire [13:13]bpi_flash_dq_io_13;
  wire [14:14]bpi_flash_dq_io_14;
  wire [15:15]bpi_flash_dq_io_15;
  wire [2:2]bpi_flash_dq_io_2;
  wire [3:3]bpi_flash_dq_io_3;
  wire [4:4]bpi_flash_dq_io_4;
  wire [5:5]bpi_flash_dq_io_5;
  wire [6:6]bpi_flash_dq_io_6;
  wire [7:7]bpi_flash_dq_io_7;
  wire [8:8]bpi_flash_dq_io_8;
  wire [9:9]bpi_flash_dq_io_9;
  wire [0:0]bpi_flash_dq_o_0;
  wire [1:1]bpi_flash_dq_o_1;
  wire [10:10]bpi_flash_dq_o_10;
  wire [11:11]bpi_flash_dq_o_11;
  wire [12:12]bpi_flash_dq_o_12;
  wire [13:13]bpi_flash_dq_o_13;
  wire [14:14]bpi_flash_dq_o_14;
  wire [15:15]bpi_flash_dq_o_15;
  wire [2:2]bpi_flash_dq_o_2;
  wire [3:3]bpi_flash_dq_o_3;
  wire [4:4]bpi_flash_dq_o_4;
  wire [5:5]bpi_flash_dq_o_5;
  wire [6:6]bpi_flash_dq_o_6;
  wire [7:7]bpi_flash_dq_o_7;
  wire [8:8]bpi_flash_dq_o_8;
  wire [9:9]bpi_flash_dq_o_9;
  wire [0:0]bpi_flash_dq_t_0;
  wire [1:1]bpi_flash_dq_t_1;
  wire [10:10]bpi_flash_dq_t_10;
  wire [11:11]bpi_flash_dq_t_11;
  wire [12:12]bpi_flash_dq_t_12;
  wire [13:13]bpi_flash_dq_t_13;
  wire [14:14]bpi_flash_dq_t_14;
  wire [15:15]bpi_flash_dq_t_15;
  wire [2:2]bpi_flash_dq_t_2;
  wire [3:3]bpi_flash_dq_t_3;
  wire [4:4]bpi_flash_dq_t_4;
  wire [5:5]bpi_flash_dq_t_5;
  wire [6:6]bpi_flash_dq_t_6;
  wire [7:7]bpi_flash_dq_t_7;
  wire [8:8]bpi_flash_dq_t_8;
  wire [9:9]bpi_flash_dq_t_9;
  wire bpi_flash_oen;
  wire bpi_flash_wen;
  wire iic_lm73_scl_i;
  wire iic_lm73_scl_io;
  wire iic_lm73_scl_o;
  wire iic_lm73_scl_t;
  wire iic_lm73_sda_i;
  wire iic_lm73_sda_io;
  wire iic_lm73_sda_o;
  wire iic_lm73_sda_t;
  wire iic_pcie_scl_i;
  wire iic_pcie_scl_io;
  wire iic_pcie_scl_o;
  wire iic_pcie_scl_t;
  wire iic_pcie_sda_i;
  wire iic_pcie_sda_io;
  wire iic_pcie_sda_o;
  wire iic_pcie_sda_t;
  wire [2:0]led_3bits_tri_o;
  wire [7:0]pci_express_x8_rxn;
  wire [7:0]pci_express_x8_rxp;
  wire [7:0]pci_express_x8_txn;
  wire [7:0]pci_express_x8_txp;
  wire pcie_perstn;
  wire pcie_refclk_clk_n;
  wire pcie_refclk_clk_p;

  IOBUF bpi_flash_dq_iobuf_0
       (.I(bpi_flash_dq_o_0),
        .IO(bpi_flash_dq_io[0]),
        .O(bpi_flash_dq_i_0),
        .T(bpi_flash_dq_t_0));
  IOBUF bpi_flash_dq_iobuf_1
       (.I(bpi_flash_dq_o_1),
        .IO(bpi_flash_dq_io[1]),
        .O(bpi_flash_dq_i_1),
        .T(bpi_flash_dq_t_1));
  IOBUF bpi_flash_dq_iobuf_10
       (.I(bpi_flash_dq_o_10),
        .IO(bpi_flash_dq_io[10]),
        .O(bpi_flash_dq_i_10),
        .T(bpi_flash_dq_t_10));
  IOBUF bpi_flash_dq_iobuf_11
       (.I(bpi_flash_dq_o_11),
        .IO(bpi_flash_dq_io[11]),
        .O(bpi_flash_dq_i_11),
        .T(bpi_flash_dq_t_11));
  IOBUF bpi_flash_dq_iobuf_12
       (.I(bpi_flash_dq_o_12),
        .IO(bpi_flash_dq_io[12]),
        .O(bpi_flash_dq_i_12),
        .T(bpi_flash_dq_t_12));
  IOBUF bpi_flash_dq_iobuf_13
       (.I(bpi_flash_dq_o_13),
        .IO(bpi_flash_dq_io[13]),
        .O(bpi_flash_dq_i_13),
        .T(bpi_flash_dq_t_13));
  IOBUF bpi_flash_dq_iobuf_14
       (.I(bpi_flash_dq_o_14),
        .IO(bpi_flash_dq_io[14]),
        .O(bpi_flash_dq_i_14),
        .T(bpi_flash_dq_t_14));
  IOBUF bpi_flash_dq_iobuf_15
       (.I(bpi_flash_dq_o_15),
        .IO(bpi_flash_dq_io[15]),
        .O(bpi_flash_dq_i_15),
        .T(bpi_flash_dq_t_15));
  IOBUF bpi_flash_dq_iobuf_2
       (.I(bpi_flash_dq_o_2),
        .IO(bpi_flash_dq_io[2]),
        .O(bpi_flash_dq_i_2),
        .T(bpi_flash_dq_t_2));
  IOBUF bpi_flash_dq_iobuf_3
       (.I(bpi_flash_dq_o_3),
        .IO(bpi_flash_dq_io[3]),
        .O(bpi_flash_dq_i_3),
        .T(bpi_flash_dq_t_3));
  IOBUF bpi_flash_dq_iobuf_4
       (.I(bpi_flash_dq_o_4),
        .IO(bpi_flash_dq_io[4]),
        .O(bpi_flash_dq_i_4),
        .T(bpi_flash_dq_t_4));
  IOBUF bpi_flash_dq_iobuf_5
       (.I(bpi_flash_dq_o_5),
        .IO(bpi_flash_dq_io[5]),
        .O(bpi_flash_dq_i_5),
        .T(bpi_flash_dq_t_5));
  IOBUF bpi_flash_dq_iobuf_6
       (.I(bpi_flash_dq_o_6),
        .IO(bpi_flash_dq_io[6]),
        .O(bpi_flash_dq_i_6),
        .T(bpi_flash_dq_t_6));
  IOBUF bpi_flash_dq_iobuf_7
       (.I(bpi_flash_dq_o_7),
        .IO(bpi_flash_dq_io[7]),
        .O(bpi_flash_dq_i_7),
        .T(bpi_flash_dq_t_7));
  IOBUF bpi_flash_dq_iobuf_8
       (.I(bpi_flash_dq_o_8),
        .IO(bpi_flash_dq_io[8]),
        .O(bpi_flash_dq_i_8),
        .T(bpi_flash_dq_t_8));
  IOBUF bpi_flash_dq_iobuf_9
       (.I(bpi_flash_dq_o_9),
        .IO(bpi_flash_dq_io[9]),
        .O(bpi_flash_dq_i_9),
        .T(bpi_flash_dq_t_9));
  IOBUF iic_lm73_scl_iobuf
       (.I(iic_lm73_scl_o),
        .IO(iic_lm73_scl_io),
        .O(iic_lm73_scl_i),
        .T(iic_lm73_scl_t));
  IOBUF iic_lm73_sda_iobuf
       (.I(iic_lm73_sda_o),
        .IO(iic_lm73_sda_io),
        .O(iic_lm73_sda_i),
        .T(iic_lm73_sda_t));
  IOBUF iic_pcie_scl_iobuf
       (.I(iic_pcie_scl_o),
        .IO(iic_pcie_scl_io),
        .O(iic_pcie_scl_i),
        .T(iic_pcie_scl_t));
  IOBUF iic_pcie_sda_iobuf
       (.I(iic_pcie_sda_o),
        .IO(iic_pcie_sda_io),
        .O(iic_pcie_sda_i),
        .T(iic_pcie_sda_t));
  top top_i
       (.DDR3_0_addr(DDR3_0_addr),
        .DDR3_0_ba(DDR3_0_ba),
        .DDR3_0_cas_n(DDR3_0_cas_n),
        .DDR3_0_ck_n(DDR3_0_ck_n),
        .DDR3_0_ck_p(DDR3_0_ck_p),
        .DDR3_0_cke(DDR3_0_cke),
        .DDR3_0_cs_n(DDR3_0_cs_n),
        .DDR3_0_dq(DDR3_0_dq),
        .DDR3_0_dqs_n(DDR3_0_dqs_n),
        .DDR3_0_dqs_p(DDR3_0_dqs_p),
        .DDR3_0_odt(DDR3_0_odt),
        .DDR3_0_ras_n(DDR3_0_ras_n),
        .DDR3_0_reset_n(DDR3_0_reset_n),
        .DDR3_0_we_n(DDR3_0_we_n),
        .DDR3_1_addr(DDR3_1_addr),
        .DDR3_1_ba(DDR3_1_ba),
        .DDR3_1_cas_n(DDR3_1_cas_n),
        .DDR3_1_ck_n(DDR3_1_ck_n),
        .DDR3_1_ck_p(DDR3_1_ck_p),
        .DDR3_1_cke(DDR3_1_cke),
        .DDR3_1_cs_n(DDR3_1_cs_n),
        .DDR3_1_dq(DDR3_1_dq),
        .DDR3_1_dqs_n(DDR3_1_dqs_n),
        .DDR3_1_dqs_p(DDR3_1_dqs_p),
        .DDR3_1_odt(DDR3_1_odt),
        .DDR3_1_ras_n(DDR3_1_ras_n),
        .DDR3_1_reset_n(DDR3_1_reset_n),
        .DDR3_1_we_n(DDR3_1_we_n),
        .DDR3_CLK_0_clk_n(DDR3_CLK_0_clk_n),
        .DDR3_CLK_0_clk_p(DDR3_CLK_0_clk_p),
        .DDR3_CLK_1_clk_n(DDR3_CLK_1_clk_n),
        .DDR3_CLK_1_clk_p(DDR3_CLK_1_clk_p),
        .SYS_CLK(SYS_CLK),
        .SYS_RSTN(SYS_RSTN),
        .alert_lm73_tri_i(alert_lm73_tri_i),
        .bpi_flash_addr(bpi_flash_addr),
        .bpi_flash_adv_ldn(bpi_flash_adv_ldn),
        .bpi_flash_ce_n(bpi_flash_ce_n),
        .bpi_flash_dq_i({bpi_flash_dq_i_15,bpi_flash_dq_i_14,bpi_flash_dq_i_13,bpi_flash_dq_i_12,bpi_flash_dq_i_11,bpi_flash_dq_i_10,bpi_flash_dq_i_9,bpi_flash_dq_i_8,bpi_flash_dq_i_7,bpi_flash_dq_i_6,bpi_flash_dq_i_5,bpi_flash_dq_i_4,bpi_flash_dq_i_3,bpi_flash_dq_i_2,bpi_flash_dq_i_1,bpi_flash_dq_i_0}),
        .bpi_flash_dq_o({bpi_flash_dq_o_15,bpi_flash_dq_o_14,bpi_flash_dq_o_13,bpi_flash_dq_o_12,bpi_flash_dq_o_11,bpi_flash_dq_o_10,bpi_flash_dq_o_9,bpi_flash_dq_o_8,bpi_flash_dq_o_7,bpi_flash_dq_o_6,bpi_flash_dq_o_5,bpi_flash_dq_o_4,bpi_flash_dq_o_3,bpi_flash_dq_o_2,bpi_flash_dq_o_1,bpi_flash_dq_o_0}),
        .bpi_flash_dq_t({bpi_flash_dq_t_15,bpi_flash_dq_t_14,bpi_flash_dq_t_13,bpi_flash_dq_t_12,bpi_flash_dq_t_11,bpi_flash_dq_t_10,bpi_flash_dq_t_9,bpi_flash_dq_t_8,bpi_flash_dq_t_7,bpi_flash_dq_t_6,bpi_flash_dq_t_5,bpi_flash_dq_t_4,bpi_flash_dq_t_3,bpi_flash_dq_t_2,bpi_flash_dq_t_1,bpi_flash_dq_t_0}),
        .bpi_flash_oen(bpi_flash_oen),
        .bpi_flash_wen(bpi_flash_wen),
        .iic_lm73_scl_i(iic_lm73_scl_i),
        .iic_lm73_scl_o(iic_lm73_scl_o),
        .iic_lm73_scl_t(iic_lm73_scl_t),
        .iic_lm73_sda_i(iic_lm73_sda_i),
        .iic_lm73_sda_o(iic_lm73_sda_o),
        .iic_lm73_sda_t(iic_lm73_sda_t),
        .iic_pcie_scl_i(iic_pcie_scl_i),
        .iic_pcie_scl_o(iic_pcie_scl_o),
        .iic_pcie_scl_t(iic_pcie_scl_t),
        .iic_pcie_sda_i(iic_pcie_sda_i),
        .iic_pcie_sda_o(iic_pcie_sda_o),
        .iic_pcie_sda_t(iic_pcie_sda_t),
        .led_3bits_tri_o(led_3bits_tri_o),
        .pci_express_x8_rxn(pci_express_x8_rxn),
        .pci_express_x8_rxp(pci_express_x8_rxp),
        .pci_express_x8_txn(pci_express_x8_txn),
        .pci_express_x8_txp(pci_express_x8_txp),
        .pcie_perstn(pcie_perstn),
        .pcie_refclk_clk_n(pcie_refclk_clk_n),
        .pcie_refclk_clk_p(pcie_refclk_clk_p));
endmodule
