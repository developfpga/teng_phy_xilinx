// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Tue Feb 12 20:03:16 2019
// Host        : DESKTOP-4CFPTTR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/jack/Desktop/tmp/project_1/project_1.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_1/bd_efdb_0_xpcs_0_stub.v
// Design      : bd_efdb_0_xpcs_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku035-fbva676-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ten_gig_eth_pcs_pma_v6_0_12,Vivado 2018.1" *)
module bd_efdb_0_xpcs_0(dclk, rxrecclk_out, coreclk, txusrclk, txusrclk2, 
  txoutclk, areset, areset_coreclk, gttxreset, gtrxreset, sim_speedup_control, txuserrdy, 
  qpll0lock, qpll0outclk, qpll0outrefclk, qpll0reset, reset_tx_bufg_gt, reset_counter_done, 
  xgmii_txd, xgmii_txc, xgmii_rxd, xgmii_rxc, txp, txn, rxp, rxn, configuration_vector, 
  status_vector, core_status, tx_resetdone, rx_resetdone, signal_detect, tx_fault, drp_req, 
  drp_gnt, core_to_gt_drpen, core_to_gt_drpwe, core_to_gt_drpaddr, core_to_gt_drpdi, 
  gt_drprdy, gt_drpdo, gt_drpen, gt_drpwe, gt_drpaddr, gt_drpdi, core_to_gt_drprdy, 
  core_to_gt_drpdo, pma_pmd_type, tx_disable)
/* synthesis syn_black_box black_box_pad_pin="dclk,rxrecclk_out,coreclk,txusrclk,txusrclk2,txoutclk,areset,areset_coreclk,gttxreset,gtrxreset,sim_speedup_control,txuserrdy,qpll0lock,qpll0outclk,qpll0outrefclk,qpll0reset,reset_tx_bufg_gt,reset_counter_done,xgmii_txd[63:0],xgmii_txc[7:0],xgmii_rxd[63:0],xgmii_rxc[7:0],txp,txn,rxp,rxn,configuration_vector[535:0],status_vector[447:0],core_status[7:0],tx_resetdone,rx_resetdone,signal_detect,tx_fault,drp_req,drp_gnt,core_to_gt_drpen,core_to_gt_drpwe,core_to_gt_drpaddr[15:0],core_to_gt_drpdi[15:0],gt_drprdy,gt_drpdo[15:0],gt_drpen,gt_drpwe,gt_drpaddr[15:0],gt_drpdi[15:0],core_to_gt_drprdy,core_to_gt_drpdo[15:0],pma_pmd_type[2:0],tx_disable" */;
  input dclk;
  output rxrecclk_out;
  input coreclk;
  input txusrclk;
  input txusrclk2;
  output txoutclk;
  input areset;
  input areset_coreclk;
  input gttxreset;
  input gtrxreset;
  input sim_speedup_control;
  input txuserrdy;
  input qpll0lock;
  input qpll0outclk;
  input qpll0outrefclk;
  output qpll0reset;
  output reset_tx_bufg_gt;
  input reset_counter_done;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output txp;
  output txn;
  input rxp;
  input rxn;
  input [535:0]configuration_vector;
  output [447:0]status_vector;
  output [7:0]core_status;
  output tx_resetdone;
  output rx_resetdone;
  input signal_detect;
  input tx_fault;
  output drp_req;
  input drp_gnt;
  output core_to_gt_drpen;
  output core_to_gt_drpwe;
  output [15:0]core_to_gt_drpaddr;
  output [15:0]core_to_gt_drpdi;
  output gt_drprdy;
  output [15:0]gt_drpdo;
  input gt_drpen;
  input gt_drpwe;
  input [15:0]gt_drpaddr;
  input [15:0]gt_drpdi;
  input core_to_gt_drprdy;
  input [15:0]core_to_gt_drpdo;
  input [2:0]pma_pmd_type;
  output tx_disable;
endmodule
