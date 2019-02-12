//-----------------------------------------------------------------------------
// Title      : Core level wrapper
// Project    : 10GBASE-R
//-----------------------------------------------------------------------------
// File       : bd_efdb_0_xpcs_0.v
//-----------------------------------------------------------------------------
// Description: This file is a wrapper for the 10GBASE-R core.
//-----------------------------------------------------------------------------
// (c) Copyright 2009 - 2014 Xilinx, Inc. All rights reserved.
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

`timescale 1ps / 1ps

(* CORE_GENERATION_INFO = "bd_efdb_0_xpcs_0,ten_gig_eth_pcs_pma_v6_0_12,{x_ipProduct=Vivado 2018.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ten_gig_eth_pcs_pma,x_ipVersion=6.0,x_ipCoreRevision=12,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,x_ipLicense=ten_gig_eth_pcs_pma_basekr@2015.04(design_linking),c_family=kintexu,c_component_name=bd_efdb_0_xpcs_0,c_has_mdio=false,c_has_fec=false,c_has_an=false,c_is_kr=false,c_is_32bit=false,c_no_ebuff=false,c_gttype=2,c_1588=0,c_gtif_width=64,c_speed10_25=10,c_sub_core_name=bd_efdb_0_xpcs_0_gt,c_gt_loc=X0Y0,c_refclk=clk0,c_refclkrate=156,c_dclkrate=100.00}" *)
(* X_CORE_INFO = "ten_gig_eth_pcs_pma_v6_0_12,Vivado 2018.1" *)
(* DowngradeIPIdentifiedWarnings="yes" *)
module bd_efdb_0_xpcs_0
  (
  input           dclk,
  output          rxrecclk_out,
  input           coreclk,
  input           txusrclk,
  input           txusrclk2,
  output          txoutclk,
  input           areset,
  input           areset_coreclk,
  input           gttxreset,
  input           gtrxreset,
  input           sim_speedup_control,
  input           txuserrdy,
  input           qpll0lock,
  input           qpll0outclk,
  input           qpll0outrefclk,
  output          qpll0reset,
  output          reset_tx_bufg_gt,
  input           reset_counter_done,
  input  [63:0]   xgmii_txd,
  input  [7:0]    xgmii_txc,
  output [63:0]   xgmii_rxd,
  output [7:0]    xgmii_rxc,
  output          txp,
  output          txn,
  input           rxp,
  input           rxn,
  input  [535 : 0] configuration_vector,
  output [447 : 0]  status_vector,
  output [7 : 0]  core_status,
  output          tx_resetdone,
  output          rx_resetdone,
  input           signal_detect,
  input           tx_fault,
  output          drp_req,
  input           drp_gnt,
  output          core_to_gt_drpen,
  output          core_to_gt_drpwe,
  output [15 : 0] core_to_gt_drpaddr,
  output [15 : 0] core_to_gt_drpdi,
  output          gt_drprdy,
  output [15 : 0] gt_drpdo,
  input           gt_drpen,
  input           gt_drpwe,
  input  [15 : 0] gt_drpaddr,
  input  [15 : 0] gt_drpdi,
  input           core_to_gt_drprdy,
  input  [15 : 0] core_to_gt_drpdo,
  input [2:0]     pma_pmd_type,
  output          tx_disable);
//
// Instantiate the 10Gig PCS/PMA core
//

    bd_efdb_0_xpcs_0_block inst (
      .coreclk(coreclk),
      .dclk(dclk),
      .rxrecclk_out(rxrecclk_out),
      .txusrclk(txusrclk),
      .txusrclk2(txusrclk2),
      .txoutclk(txoutclk),
      .areset(areset),
      .areset_coreclk(areset_coreclk),
      .gttxreset(gttxreset),
      .gtrxreset(gtrxreset),
      .sim_speedup_control(sim_speedup_control),
      .txuserrdy(txuserrdy),
      .qpll0lock(qpll0lock),
      .qpll0outclk(qpll0outclk),
      .qpll0outrefclk(qpll0outrefclk),
      .qpll0reset(qpll0reset),
      .reset_tx_bufg_gt(reset_tx_bufg_gt),
      .reset_counter_done(reset_counter_done),
      .xgmii_txd(xgmii_txd),
      .xgmii_txc(xgmii_txc),
      .xgmii_rxd(xgmii_rxd),
      .xgmii_rxc(xgmii_rxc),
      .txp(txp),
      .txn(txn),
      .rxp(rxp),
      .rxn(rxn),
       .configuration_vector(configuration_vector),
       .status_vector(status_vector),
      .core_status(core_status),
      .tx_resetdone(tx_resetdone),
      .rx_resetdone(rx_resetdone),
      .signal_detect(signal_detect),
      .tx_fault(tx_fault),
      .drp_req(drp_req),
      .drp_gnt(drp_gnt),
      .core_to_gt_drpen(core_to_gt_drpen),
      .core_to_gt_drpwe(core_to_gt_drpwe),
      .core_to_gt_drpaddr(core_to_gt_drpaddr),
      .core_to_gt_drpdi(core_to_gt_drpdi),
      .gt_drprdy(gt_drprdy),
      .gt_drpdo(gt_drpdo),
      .gt_drpen(gt_drpen),
      .gt_drpwe(gt_drpwe),
      .gt_drpaddr(gt_drpaddr),
      .gt_drpdi(gt_drpdi),
      .core_to_gt_drprdy(core_to_gt_drprdy),
      .core_to_gt_drpdo(core_to_gt_drpdo),
      .pma_pmd_type(pma_pmd_type),
      .tx_disable(tx_disable)
      );
endmodule



