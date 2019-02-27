//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module pcs_top (

  // Differential reference clock inputs
  input  wire refclk_p_i,
  input  wire refclk_n_i,

  // Serial data ports for transceiver channel 0
  input  wire gthrxn_i,
  input  wire gthrxp_i,
  output wire gthtxn_o,
  output wire gthtxp_o,

  // User-provided ports for reset helper block(s)
  input  wire hb_gtwiz_reset_clk_freerun_in,
  input  wire hb_gtwiz_reset_all_in,

  output wire link_status_out,
  // AXIS tx
  output                   tx_user_clk_o,
  output                   tx_user_rst_o,
  input        [31:0]      tx_data_i,
  input        [1:0]       tx_vldb_i,
  input                    tx_valid_i,
  output                   tx_ready_o,
  input                    tx_last_i,
  input        [0:0]       tx_user_i,

  output                   tx_status_o,
  output                   tx_rsp_valid_o,
  // AXIS rx
  output                   rx_user_clk_o,
  output                   rx_user_rst_o,
  output       [31:0]      rx_data_o,
  output       [1:0]       rx_vldb_o,
  output                   rx_valid_o,
  output                   rx_last_o,
  output       [0:0]       rx_user_o

);

  `include "xgmii_includes.vh"
  // ===================================================================================================================
  // PER-CHANNEL SIGNAL ASSIGNMENTS
  // ===================================================================================================================

  // The core and example design wrapper vectorize ports across all enabled transceiver channel and common instances for
  // simplicity and compactness. This example design top module assigns slices of each vector to individual, per-channel
  // signal vectors for use if desired. Signals which connect to helper blocks are prefixed "hb#", signals which connect
  // to transceiver common primitives are prefixed "cm#", and signals which connect to transceiver channel primitives
  // are prefixed "ch#", where "#" is the sequential resource number.

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gthrxn_int;
  assign gthrxn_int[0:0] = gthrxn_i;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gthrxp_int;
  assign gthrxp_int[0:0] = gthrxp_i;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gthtxn_int;
  assign gthtxn_o = gthtxn_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gthtxp_int;
  assign gthtxp_o = gthtxp_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_tx_reset_int;
  assign gtwiz_userclk_tx_reset_int[0:0] = hb0_gtwiz_userclk_tx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_srcclk_int;
  assign hb0_gtwiz_userclk_tx_srcclk_int = gtwiz_userclk_tx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk_int;
  assign hb0_gtwiz_userclk_tx_usrclk_int = gtwiz_userclk_tx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_rx_reset_int;
  assign gtwiz_userclk_rx_reset_int[0:0] = hb0_gtwiz_userclk_rx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_srcclk_int;
  assign hb0_gtwiz_userclk_rx_srcclk_int = gtwiz_userclk_rx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk_int;
  assign hb0_gtwiz_userclk_rx_usrclk_int = gtwiz_userclk_rx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_buffbypass_tx_start_user_int;
  wire [0:0] hb0_gtwiz_buffbypass_tx_start_user_int = 1'b0;
  assign gtwiz_buffbypass_tx_start_user_int[0:0] = hb0_gtwiz_buffbypass_tx_start_user_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_buffbypass_tx_error_int;
  wire [0:0] hb0_gtwiz_buffbypass_tx_error_int;
  assign hb0_gtwiz_buffbypass_tx_error_int = gtwiz_buffbypass_tx_error_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_buffbypass_rx_start_user_int;
  wire [0:0] hb0_gtwiz_buffbypass_rx_start_user_int = 1'b0;
  assign gtwiz_buffbypass_rx_start_user_int[0:0] = hb0_gtwiz_buffbypass_rx_start_user_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_buffbypass_rx_done_int;
  wire [0:0] hb0_gtwiz_buffbypass_rx_done_int;
  assign hb0_gtwiz_buffbypass_rx_done_int = gtwiz_buffbypass_rx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_buffbypass_rx_error_int;
  wire [0:0] hb0_gtwiz_buffbypass_rx_error_int;
  assign hb0_gtwiz_buffbypass_rx_error_int = gtwiz_buffbypass_rx_error_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_clk_freerun_int;
  wire [0:0] hb0_gtwiz_reset_clk_freerun_int = 1'b0;
  assign gtwiz_reset_clk_freerun_int[0:0] = hb0_gtwiz_reset_clk_freerun_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_all_int;
  wire [0:0] hb0_gtwiz_reset_all_int = 1'b0;
  assign gtwiz_reset_all_int[0:0] = hb0_gtwiz_reset_all_int;

  wire [0:0] gtwiz_reset_tx_pll_and_datapath_int;
  wire [0:0] gtwiz_reset_tx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  assign gtwiz_reset_rx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_rx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_datapath_int = 1'b0;
  assign gtwiz_reset_rx_datapath_int[0:0] = hb0_gtwiz_reset_rx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_cdr_stable_int;
  wire [0:0] hb0_gtwiz_reset_rx_cdr_stable_int;
  assign hb0_gtwiz_reset_rx_cdr_stable_int = gtwiz_reset_rx_cdr_stable_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_done_int;
  wire [0:0] hb0_gtwiz_reset_tx_done_int;
  assign hb0_gtwiz_reset_tx_done_int = gtwiz_reset_tx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_done_int;
  wire [0:0] hb0_gtwiz_reset_rx_done_int;
  assign hb0_gtwiz_reset_rx_done_int = gtwiz_reset_rx_done_int[0:0];

  wire [31:0] gtwiz_userdata_tx_int;
  wire [31:0] gtwiz_userdata_rx_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtrefclk00_int;
  wire [0:0] cm0_gtrefclk00_int;
  assign gtrefclk00_int[0:0] = cm0_gtrefclk00_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outclk_int;
  wire [0:0] cm0_qpll0outclk_int;
  assign cm0_qpll0outclk_int = qpll0outclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outrefclk_int;
  wire [0:0] cm0_qpll0outrefclk_int;
  assign cm0_qpll0outrefclk_int = qpll0outrefclk_int[0:0];

  wire [0:0] rxgearboxslip_int;
  wire [31:0] txdata_int;
  wire [5:0] txheader_int;
  wire [6:0] txsequence_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtpowergood_int;
  wire [0:0] ch0_gtpowergood_int;
  assign ch0_gtpowergood_int = gtpowergood_int[0:0];

  wire [1:0] rxdatavalid_int;
  wire [31:0] rxdata_int;
  wire [1:0] rxheader_int;
  wire       rxheadervalid_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxpmaresetdone_int;
  wire [0:0] ch0_rxpmaresetdone_int;
  assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [1:0] rxstartofseq_int;
  wire [1:0] ch0_rxstartofseq_int;
  assign ch0_rxstartofseq_int = rxstartofseq_int[1:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txpmaresetdone_int;
  wire [0:0] ch0_txpmaresetdone_int;
  assign ch0_txpmaresetdone_int = txpmaresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txprgdivresetdone_int;
  wire [0:0] ch0_txprgdivresetdone_int;
  assign ch0_txprgdivresetdone_int = txprgdivresetdone_int[0:0];


  // ===================================================================================================================
  // BUFFERS
  // ===================================================================================================================

  // Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
  wire hb_gtwiz_reset_all_buf_int;
  wire hb_gtwiz_reset_all_init_int;
  wire hb_gtwiz_reset_all_int;

  IBUF ibuf_hb_gtwiz_reset_all_inst (
    .I (hb_gtwiz_reset_all_in),
    .O (hb_gtwiz_reset_all_buf_int)
  );

  assign hb_gtwiz_reset_all_int = hb_gtwiz_reset_all_buf_int || hb_gtwiz_reset_all_init_int;

  // Globally buffer the free-running input clock
  wire hb_gtwiz_reset_clk_freerun_buf_int;

  BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
  );

  // Instantiate a differential reference clock buffer for each reference clock differential pair in this configuration,
  // and assign the single-ended output of each differential reference clock buffer to the appropriate PLL input signal

  // Differential reference clock buffer for refclk
  wire refclk_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_refclk_INST (
    .I     (refclk_p_i),
    .IB    (refclk_n_i),
    .CEB   (1'b0),
    .O     (refclk_int),
    .ODIV2 ()
  );

  assign cm0_gtrefclk00_int = refclk_int;


  // ===================================================================================================================
  // USER CLOCKING RESETS
  // ===================================================================================================================

  // The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_tx_reset_int = ~(&txprgdivresetdone_int && &txpmaresetdone_int);

  // The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_rx_reset_int = ~(&rxpmaresetdone_int);


  // ===================================================================================================================
  // BUFFER BYPASS CONTROLLER RESETS
  // ===================================================================================================================

  // The TX buffer bypass controller helper block should be held in reset until the TX user clocking network helper
  // block which drives it is active
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_1_example_reset_synchronizer reset_synchronizer_gtwiz_buffbypass_tx_reset_inst (
    .clk_in  (gtwiz_userclk_tx_usrclk2_int),
    .rst_in  (~gtwiz_userclk_tx_active_int),
    .rst_out (gtwiz_buffbypass_tx_reset_int)
  );

  // The RX buffer bypass controller helper block should be held in reset until the RX user clocking network helper
  // block which drives it is active and the TX buffer bypass sequence has completed for this loopback configuration
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_1_example_reset_synchronizer reset_synchronizer_gtwiz_buffbypass_rx_reset_inst (
    .clk_in  (gtwiz_userclk_rx_usrclk2_int),
    .rst_in  (~gtwiz_userclk_rx_active_int || ~gtwiz_buffbypass_tx_done_int),
    .rst_out (gtwiz_buffbypass_rx_reset_int)
  );

  assign  tx_user_clk_o = gtwiz_userclk_tx_usrclk2_int;
  assign  tx_user_rst_o = ~gtwiz_reset_tx_done_int;

  tx u_tx (
    // Clks and resets
    .clk_i          (gtwiz_userclk_tx_usrclk2_int),
    .rst_i          (~gtwiz_reset_tx_done_int),

    // XGMII
    .data_o         (txdata_int),
    .head_o         (txheader_int),
    .sequence_o     (txsequence_int),

    // AXIS
    .tdata_i        (tx_data_i),
    .tvldb_i        (tx_vldb_i),
    .tvalid_i       (tx_valid_i),
    .tready_o       (tx_ready_o),
    .tlast_i        (tx_last_i),
    .tuser_i        (tx_user_i),

    .tx_status_o    (tx_status_o   ),
    .tx_rsp_valid_o (tx_rsp_valid_o)
  );
  gearbox_66b_64b u_gearbox_66_64 (

    // Clks and resets
    .clk_i          (gtwiz_userclk_tx_usrclk2_int),
    .rst_i          (~gtwiz_reset_tx_done_int),

    .data_i         (txdata_int),
    .head_i         (txheader_int[1:0]),
    .sequence_i     (txsequence_int),

    .data_o         (gtwiz_userdata_tx_int)
  );

  // reg     r_rxheadervalid_d1;
  // reg     r_rx_valid_mismatch;
  // always @(posedge gtwiz_userclk_rx_usrclk2_int) begin
  //   r_rxheadervalid_d1  <= rxheadervalid_int;
  //   if(rxdatavalid_int != (r_rxheadervalid_d1|rxheadervalid_int)) begin
  //     r_rx_valid_mismatch <= 1'b1;
  //   end else begin
  //     r_rx_valid_mismatch <= 1'b0;
  //   end
  // end

  assign  rx_user_clk_o = gtwiz_userclk_rx_usrclk2_int;
  assign  rx_user_rst_o = ~gtwiz_reset_rx_done_int;
  gearbox_64b_66b u_gearbox_64_66 (

    // Clks and resets
    .clk_i          (gtwiz_userclk_rx_usrclk2_int),
    .rst_i          (~gtwiz_reset_rx_done_int),

    .data_o         (rxdata_int),
    .head_o         (rxheader_int),
    .head_valid_o   (rxheadervalid_int),
    .slip_i         (rxgearboxslip_int),

    .data_i         (bit32_rev(gtwiz_userdata_rx_int))
    // .data_i         (gtwiz_userdata_tx_int)
  );

  rx u_rx (
    // Clks and resets
    .clk_i          (gtwiz_userclk_rx_usrclk2_int),
    .rst_i          (~gtwiz_reset_rx_done_int),

    // PCS
    .data_i         (rxdata_int),
    .head_i         ({4'b0, rxheader_int}),
    .head_valid_i   ({1'b0, rxheadervalid_int}),
    .slip_o         (rxgearboxslip_int),

    // AXIS
    .tdata_o        (rx_data_o),
    .tvldb_o        (rx_vldb_o),
    .tvalid_o       (rx_valid_o),
    .tlast_o        (rx_last_o),
    .tuser_o        (rx_user_o)
  );

  // ===================================================================================================================
  // INITIALIZATION
  // ===================================================================================================================

  // Declare the receiver reset signals that interface to the reset controller helper block. For this configuration,
  // which uses the same PLL type for transmitter and receiver, the "reset RX PLL and datapath" feature is not used.
  wire hb_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  wire hb_gtwiz_reset_rx_datapath_int;

  // Declare signals which connect the VIO instance to the initialization module for debug purposes
  wire       init_done_int;
  wire [3:0] init_retry_ctr_int;

  // Combine the receiver reset signals form the initialization module and the VIO to drive the appropriate reset
  // controller helper block reset input
  wire hb_gtwiz_reset_rx_datapath_init_int;

  assign hb_gtwiz_reset_rx_datapath_int = hb_gtwiz_reset_rx_datapath_init_int;

  // The example initialization module interacts with the reset controller helper block and other example design logic
  // to retry failed reset attempts in order to mitigate bring-up issues such as initially-unavilable reference clocks
  // or data connections. It also resets the receiver in the event of link loss in an attempt to regain link, so please
  // note the possibility that this behavior can have the effect of overriding or disturbing user-provided inputs that
  // destabilize the data stream. It is a demonstration only and can be modified to suit your system needs.
  gtwizard_ultrascale_1_example_init example_init_inst (
    .clk_freerun_in  (hb_gtwiz_reset_clk_freerun_buf_int),
    .reset_all_in    (hb_gtwiz_reset_all_int),
    .tx_init_done_in (gtwiz_reset_tx_done_int && gtwiz_buffbypass_tx_done_int),
    .rx_init_done_in (gtwiz_reset_rx_done_int && gtwiz_buffbypass_rx_done_int),
    .rx_data_good_in (sm_link),
    .reset_all_out   (hb_gtwiz_reset_all_init_int),
    .reset_rx_out    (hb_gtwiz_reset_rx_datapath_init_int),
    .init_done_out   (init_done_int),
    .retry_ctr_out   (init_retry_ctr_int)
  );

  assign  gtwiz_reset_tx_pll_and_datapath_int = 1'b0;
  assign  gtwiz_reset_tx_datapath_int = 1'b0;

  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gtwizard_ultrascale_1_example_wrapper example_wrapper_inst (
    .gthrxn_in                               (gthrxn_int)
   ,.gthrxp_in                               (gthrxp_int)
   ,.gthtxn_out                              (gthtxn_int)
   ,.gthtxp_out                              (gthtxp_int)
   ,.gtwiz_userclk_tx_reset_in               (gtwiz_userclk_tx_reset_int)
   ,.gtwiz_userclk_tx_srcclk_out             (gtwiz_userclk_tx_srcclk_int)
   ,.gtwiz_userclk_tx_usrclk_out             (gtwiz_userclk_tx_usrclk_int)
   ,.gtwiz_userclk_tx_usrclk2_out            (gtwiz_userclk_tx_usrclk2_int)
   ,.gtwiz_userclk_tx_active_out             (gtwiz_userclk_tx_active_int)
   ,.gtwiz_userclk_rx_reset_in               (gtwiz_userclk_rx_reset_int)
   ,.gtwiz_userclk_rx_srcclk_out             (gtwiz_userclk_rx_srcclk_int)
   ,.gtwiz_userclk_rx_usrclk_out             (gtwiz_userclk_rx_usrclk_int)
   ,.gtwiz_userclk_rx_usrclk2_out            (gtwiz_userclk_rx_usrclk2_int)
   ,.gtwiz_userclk_rx_active_out             (gtwiz_userclk_rx_active_int)
   ,.gtwiz_buffbypass_tx_reset_in            (gtwiz_buffbypass_tx_reset_int)
   ,.gtwiz_buffbypass_tx_start_user_in       (gtwiz_buffbypass_tx_start_user_int)
   ,.gtwiz_buffbypass_tx_done_out            (gtwiz_buffbypass_tx_done_int)
   ,.gtwiz_buffbypass_tx_error_out           (gtwiz_buffbypass_tx_error_int)
   ,.gtwiz_buffbypass_rx_reset_in            (gtwiz_buffbypass_rx_reset_int)
   ,.gtwiz_buffbypass_rx_start_user_in       (gtwiz_buffbypass_rx_start_user_int)
   ,.gtwiz_buffbypass_rx_done_out            (gtwiz_buffbypass_rx_done_int)
   ,.gtwiz_buffbypass_rx_error_out           (gtwiz_buffbypass_rx_error_int)
   ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
   ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
   ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
   ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
   ,.gtwiz_userdata_tx_in                    (bit32_rev(gtwiz_userdata_tx_int))
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
   ,.gtrefclk00_in                           (gtrefclk00_int)
   ,.qpll0outclk_out                         (qpll0outclk_int)
   ,.qpll0outrefclk_out                      (qpll0outrefclk_int)
  //  ,.rxgearboxslip_in                        (rxgearboxslip_int)
  //  ,.txheader_in                             (txheader_int)
  //  ,.txsequence_in                           (txsequence_int)
   ,.gtpowergood_out                         (gtpowergood_int)
  //  ,.rxdatavalid_out                         (rxdatavalid_int)
  //  ,.rxheader_out                            (rxheader_int)
  //  ,.rxheadervalid_out                       (rxheadervalid_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
  //  ,.rxstartofseq_out                        (rxstartofseq_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_int)
   ,.txprgdivresetdone_out                   (txprgdivresetdone_int)
);

//   // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
//   // resources as appropriate
//   gtwizard_ultrascale_1_example_wrapper example_wrapper_inst (
//     .gthrxn_in                               (gthrxn_int)
//    ,.gthrxp_in                               (gthrxp_int)
//    ,.gthtxn_out                              (gthtxn_int)
//    ,.gthtxp_out                              (gthtxp_int)
//    ,.gtwiz_userclk_tx_reset_in               (gtwiz_userclk_tx_reset_int)
//    ,.gtwiz_userclk_tx_srcclk_out             (gtwiz_userclk_tx_srcclk_int)
//    ,.gtwiz_userclk_tx_usrclk_out             (gtwiz_userclk_tx_usrclk_int)
//    ,.gtwiz_userclk_tx_usrclk2_out            (gtwiz_userclk_tx_usrclk2_int)
//    ,.gtwiz_userclk_tx_active_out             (gtwiz_userclk_tx_active_int)
//    ,.gtwiz_userclk_rx_reset_in               (gtwiz_userclk_rx_reset_int)
//    ,.gtwiz_userclk_rx_srcclk_out             (gtwiz_userclk_rx_srcclk_int)
//    ,.gtwiz_userclk_rx_usrclk_out             (gtwiz_userclk_rx_usrclk_int)
//    ,.gtwiz_userclk_rx_usrclk2_out            (gtwiz_userclk_rx_usrclk2_int)
//    ,.gtwiz_userclk_rx_active_out             (gtwiz_userclk_rx_active_int)
//    ,.gtwiz_buffbypass_tx_reset_in            (gtwiz_buffbypass_tx_reset_int)
//    ,.gtwiz_buffbypass_tx_start_user_in       (gtwiz_buffbypass_tx_start_user_int)
//    ,.gtwiz_buffbypass_tx_done_out            (gtwiz_buffbypass_tx_done_int)
//    ,.gtwiz_buffbypass_tx_error_out           (gtwiz_buffbypass_tx_error_int)
//    ,.gtwiz_buffbypass_rx_reset_in            (gtwiz_buffbypass_rx_reset_int)
//    ,.gtwiz_buffbypass_rx_start_user_in       (gtwiz_buffbypass_rx_start_user_int)
//    ,.gtwiz_buffbypass_rx_done_out            (gtwiz_buffbypass_rx_done_int)
//    ,.gtwiz_buffbypass_rx_error_out           (gtwiz_buffbypass_rx_error_int)
//    ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
//    ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
//    ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
//    ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
//    ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
//    ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
//    ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
//    ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
//    ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
//    ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_int)
//    ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
//    ,.gtrefclk00_in                           (gtrefclk00_int)
//    ,.qpll0outclk_out                         (qpll0outclk_int)
//    ,.qpll0outrefclk_out                      (qpll0outrefclk_int)
//    ,.qpll1outclk_out                         (qpll1outclk_int)
//    ,.qpll1outrefclk_out                      (qpll1outrefclk_int)
//    ,.gtpowergood_out                         (gtpowergood_int)
//    ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
//    ,.txpmaresetdone_out                      (txpmaresetdone_int)
//    ,.txprgdivresetdone_out                   (txprgdivresetdone_int)
// );

endmodule
