`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/03/19 19:53:33
// Design Name:
// Module Name: top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module top#
(
  parameter CHOOSE_REFCLK0                  = 1,
  parameter NUMBER_OF_LANES                 = 2,
  parameter MASTER_LANE_ID                  = 0,
  parameter SIM_GTRESET_SPEEDUP             = "TRUE",     // Simulation setting for GT SecureIP model
  parameter SIMULATION                      =  0,         // Set to 1 for simulation
  parameter STABLE_CLOCK_PERIOD             = 10,        //Period of the stable clock driving this state-machine, unit is [ns]

  parameter P_SCRAMBLE_LOOPBACK             = 1'b0,
  parameter P_GEARBOX_LOOPBACK              = 1'b0

) (

  input             refclk_n_i,
  input             refclk_p_i,
  input   [NUMBER_OF_LANES-1:0]     gthrxn_i,
  input   [NUMBER_OF_LANES-1:0]     gthrxp_i,
  output  [NUMBER_OF_LANES-1:0]     gthtxn_o,
  output  [NUMBER_OF_LANES-1:0]     gthtxp_o,

  inout [14:0]DDR_0_addr,
  inout [2:0]DDR_0_ba,
  inout DDR_0_cas_n,
  inout DDR_0_ck_n,
  inout DDR_0_ck_p,
  inout DDR_0_cke,
  inout DDR_0_cs_n,
  inout [3:0]DDR_0_dm,
  inout [31:0]DDR_0_dq,
  inout [3:0]DDR_0_dqs_n,
  inout [3:0]DDR_0_dqs_p,
  inout DDR_0_odt,
  inout DDR_0_ras_n,
  inout DDR_0_reset_n,
  inout DDR_0_we_n,
  inout FIXED_IO_0_ddr_vrn,
  inout FIXED_IO_0_ddr_vrp,
  inout [53:0]FIXED_IO_0_mio,
  inout FIXED_IO_0_ps_clk,
  inout FIXED_IO_0_ps_porb,
  inout FIXED_IO_0_ps_srstb,

  output            led1_o,
  output            led2_o,

  output  [NUMBER_OF_LANES-1:0]     tx_disable_o
);

  wire    [NUMBER_OF_LANES-1:0]     s_link_up;
  wire              FCLK_CLK0_0;
  wire              FCLK_RESET0_N_0;

assign  tx_disable_o = {NUMBER_OF_LANES{1'b0}};
prbs_test #(
  .CHOOSE_REFCLK0         (CHOOSE_REFCLK0      ),
  .NUMBER_OF_LANES        (NUMBER_OF_LANES     ),
  .MASTER_LANE_ID         (MASTER_LANE_ID      ),
  .SIM_GTRESET_SPEEDUP    (SIM_GTRESET_SPEEDUP ),
  .SIMULATION             (SIMULATION          ),
  .STABLE_CLOCK_PERIOD    (STABLE_CLOCK_PERIOD ),
  .P_SCRAMBLE_LOOPBACK    (P_SCRAMBLE_LOOPBACK ),
  .P_GEARBOX_LOOPBACK     (P_GEARBOX_LOOPBACK  )
)u_prbs_test (

  .ref_clk_n_i      (refclk_n_i),
  .ref_clk_p_i      (refclk_p_i),
  .debug_o          (led2_o   ),
  .gt_rxn_i         (gthrxn_i  ),
  .gt_rxp_i         (gthrxp_i  ),
  .gt_txn_o         (gthtxn_o  ),
  .gt_txp_o         (gthtxp_o  ),

  // User-provided ports for reset helper block(s)
  .sys_clk_i        (FCLK_CLK0_0),
  .sys_reset_i      (~FCLK_RESET0_N_0),
  .link_up_o        (s_link_up)
);
  assign  led1_o = &s_link_up;

design_1 design_1_i
  (.DDR_0_addr(DDR_0_addr),
  .DDR_0_ba(DDR_0_ba),
  .DDR_0_cas_n(DDR_0_cas_n),
  .DDR_0_ck_n(DDR_0_ck_n),
  .DDR_0_ck_p(DDR_0_ck_p),
  .DDR_0_cke(DDR_0_cke),
  .DDR_0_cs_n(DDR_0_cs_n),
  .DDR_0_dm(DDR_0_dm),
  .DDR_0_dq(DDR_0_dq),
  .DDR_0_dqs_n(DDR_0_dqs_n),
  .DDR_0_dqs_p(DDR_0_dqs_p),
  .DDR_0_odt(DDR_0_odt),
  .DDR_0_ras_n(DDR_0_ras_n),
  .DDR_0_reset_n(DDR_0_reset_n),
  .DDR_0_we_n(DDR_0_we_n),
  .FCLK_CLK0_0(FCLK_CLK0_0),
  .FCLK_RESET0_N_0(FCLK_RESET0_N_0),
  .FIXED_IO_0_ddr_vrn(FIXED_IO_0_ddr_vrn),
  .FIXED_IO_0_ddr_vrp(FIXED_IO_0_ddr_vrp),
  .FIXED_IO_0_mio(FIXED_IO_0_mio),
  .FIXED_IO_0_ps_clk(FIXED_IO_0_ps_clk),
  .FIXED_IO_0_ps_porb(FIXED_IO_0_ps_porb),
  .FIXED_IO_0_ps_srstb(FIXED_IO_0_ps_srstb));

endmodule
