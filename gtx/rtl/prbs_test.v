//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module prbs_test (

  input             refclk_n_i,
  input             refclk_p_i,
  output            debug_o,
  input             gthrxn_i,
  input             gthrxp_i,
  output            gthtxn_o,
  output            gthtxp_o,

  // User-provided ports for reset helper block(s)
  input             free_clk_i,
  input             rst_i,
  output            link_status_out
);
  // ===========================================================================
  //         Parameter
  // ===========================================================================
  // parameter                 P_XGMII_LOOPBACK = 1'b0;
  parameter                 P_SCRAMBLE_LOOPBACK = 1'b0;
  parameter                 P_GEARBOX_LOOPBACK = 1'b0;

    // AXIS tx
    wire                s_tx_user_clk;
    wire                s_tx_user_rst;
    wire    [31:0]      s_tx_data;
    wire    [1:0]       s_tx_vldb;
    wire                s_tx_valid;
    wire                s_tx_ready;
    wire                s_tx_last;
    wire    [0:0]       s_tx_user;

    wire                s_tx_status;
    wire                s_tx_rsp_valid;
    // AXIS rx
    wire                s_rx_user_clk;
    wire                s_rx_user_rst;
    wire     [31:0]     s_rx_data;
    wire     [1:0]      s_rx_vldb;
    wire                s_rx_valid;
    wire                s_rx_last;
    wire     [0:0]      s_rx_user;

  pcs_top #(
    .P_SCRAMBLE_LOOPBACK    (P_SCRAMBLE_LOOPBACK),
    .P_GEARBOX_LOOPBACK     (P_GEARBOX_LOOPBACK)
  )u_pcs_top
  (
    .refclk_n_i                       (refclk_n_i),
    .refclk_p_i                       (refclk_p_i),

    .gthrxn_i                         (gthrxn_i),
    .gthrxp_i                         (gthrxp_i),
    .gthtxn_o                         (gthtxn_o),
    .gthtxp_o                         (gthtxp_o),

    // User-provided ports for reset helper block(s)
    .hb_gtwiz_reset_clk_freerun_in    (free_clk_i),
    .hb_gtwiz_reset_all_in            (rst_i),
    .link_status_out                  (link_status_out),
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

  prbs_gen u_prbs_gen (
    .tx_user_clk_i    (s_tx_user_clk),
    .tx_user_rst_i    (s_tx_user_rst),
    .tx_data_o        (s_tx_data),
    .tx_vldb_o        (s_tx_vldb),
    .tx_valid_o       (s_tx_valid),
    .tx_ready_i       (s_tx_ready),
    .tx_last_o        (s_tx_last),
    .tx_user_o        (s_tx_user)
  );

  prbs_check u_prbs_check (
    .rx_user_clk_i    (s_rx_user_clk),
    .rx_user_rst_i    (s_rx_user_rst),
    .rx_data_i        (s_rx_data),
    .rx_vldb_i        (s_rx_vldb),
    .rx_valid_i       (s_rx_valid),
    .rx_last_i        (s_rx_last),
    .rx_user_i        (s_rx_user),
    .err_o            (debug_o)
  );


endmodule
