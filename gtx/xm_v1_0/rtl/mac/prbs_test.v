//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module prbs_test #
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

  input                             ref_clk_n_i,
  input                             ref_clk_p_i,
  output                            debug_o,
  input   [NUMBER_OF_LANES-1:0]     gt_rxn_i,
  input   [NUMBER_OF_LANES-1:0]     gt_rxp_i,
  output  [NUMBER_OF_LANES-1:0]     gt_txn_o,
  output  [NUMBER_OF_LANES-1:0]     gt_txp_o,

  // User-provided ports for reset helper block(s)
  input                             sys_clk_i,
  input                             sys_reset_i,
  output  [NUMBER_OF_LANES-1:0]     link_up_o
);
  // ===========================================================================
  //         Parameter
  // ===========================================================================

  // AXIS tx
  wire                              s_tx_user_clk;
  wire                              s_tx_user_rst;
  wire    [NUMBER_OF_LANES*32-1:0]  s_tx_data;
  wire    [NUMBER_OF_LANES*2-1:0]   s_tx_vldb;
  wire    [NUMBER_OF_LANES-1:0]     s_tx_valid;
  wire    [NUMBER_OF_LANES-1:0]     s_tx_ready;
  wire    [NUMBER_OF_LANES-1:0]     s_tx_last;
  wire    [NUMBER_OF_LANES-1:0]     s_tx_user;

  wire    [NUMBER_OF_LANES-1:0]     s_tx_status;
  wire    [NUMBER_OF_LANES-1:0]     s_tx_rsp_valid;
  // AXIS rx
  wire                              s_rx_user_clk;
  wire                              s_rx_user_rst;
  wire    [NUMBER_OF_LANES*32-1:0]  s_rx_data;
  wire    [NUMBER_OF_LANES*2-1:0]   s_rx_vldb;
  wire    [NUMBER_OF_LANES-1:0]     s_rx_valid;
  wire    [NUMBER_OF_LANES-1:0]     s_rx_last;
  wire    [NUMBER_OF_LANES-1:0]     s_rx_user;
  wire    [NUMBER_OF_LANES-1:0]     s_debug_out;

  xm_top #(
    .CHOOSE_REFCLK0         (CHOOSE_REFCLK0      ),
    .NUMBER_OF_LANES        (NUMBER_OF_LANES     ),
    .MASTER_LANE_ID         (MASTER_LANE_ID      ),
    .SIM_GTRESET_SPEEDUP    (SIM_GTRESET_SPEEDUP ),
    .SIMULATION             (SIMULATION          ),
    .STABLE_CLOCK_PERIOD    (STABLE_CLOCK_PERIOD ),

    .P_SCRAMBLE_LOOPBACK    (P_SCRAMBLE_LOOPBACK),
    .P_GEARBOX_LOOPBACK     (P_GEARBOX_LOOPBACK)
  )u_xm_top
  (
    .ref_clk_n_i                      (ref_clk_n_i),
    .ref_clk_p_i                      (ref_clk_p_i),

    .gt_rxn_i                         (gt_rxn_i),
    .gt_rxp_i                         (gt_rxp_i),
    .gt_txn_o                         (gt_txn_o),
    .gt_txp_o                         (gt_txp_o),

    // User-provided ports for reset helper block(s)
    .sys_clk_i                        (sys_clk_i),
    .sys_reset_i                      (sys_reset_i),
    .link_up_o                        (link_up_o),
    // AXIS tx
    .tx_user_clk_o                    (s_tx_user_clk),
    .tx_user_rst_o                    (s_tx_user_rst),
    .tx_data_i                        (s_tx_data),
    .tx_vldb_i                        (s_tx_vldb),
    .tx_valid_i                       (s_tx_valid),
    .tx_ready_o                       (s_tx_ready),
    .tx_last_i                        (s_tx_last),
    .tx_user_i                        (s_tx_user),

    .tx_status_o                      (s_tx_status),
    .tx_rsp_valid_o                   (s_tx_rsp_valid),
    // AXIS rx
    .rx_user_clk_o                    (s_rx_user_clk),
    .rx_user_rst_o                    (s_rx_user_rst),
    .rx_data_o                        (s_rx_data),
    .rx_vldb_o                        (s_rx_vldb),
    .rx_valid_o                       (s_rx_valid),
    .rx_last_o                        (s_rx_last),
    .rx_user_o                        (s_rx_user)

  );

  generate
  genvar i;
  for(i = 0; i < NUMBER_OF_LANES; i = i + 1) begin : g_prbs
    prbs_gen u_prbs_gen (
      .tx_user_clk_i    (s_tx_user_clk),
      .tx_user_rst_i    (s_tx_user_rst),
      .tx_data_o        (s_tx_data[i*32 +: 32]),
      .tx_vldb_o        (s_tx_vldb[i*2 +: 2]),
      .tx_valid_o       (s_tx_valid[i]),
      .tx_ready_i       (s_tx_ready[i]),
      .tx_last_o        (s_tx_last[i]),
      .tx_user_o        (s_tx_user[i])
    );

    prbs_check u_prbs_check (
      .rx_user_clk_i    (s_rx_user_clk),
      .rx_user_rst_i    (s_rx_user_rst),
      .rx_data_i        (s_rx_data[i*32 +: 32]),
      .rx_vldb_i        (s_rx_vldb[i*2 +: 2]),
      .rx_valid_i       (s_rx_valid[i]),
      .rx_last_i        (s_rx_last[i]),
      .rx_user_i        (s_rx_user[i]),
      .err_o            (s_debug_out[i])
    );
  end
  endgenerate

  assign  debug_o = |s_debug_out;


endmodule
