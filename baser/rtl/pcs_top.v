///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-30
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module pcs_top(

    input           gthrxp_i,
    input           gthrxn_i,
    output          gthtxp_o,
    output          gthtxn_o,
    input           gtrefclk00p_i,
    input           gtrefclk00n_i,
  
    // User-provided ports for reset helper block(s)
    input           hb_gtwiz_reset_clk_freerun_in,
    input           hb_gtwiz_reset_all_in,

    output          rx_user_clk_o,         // 156.25*2 clk 
    output          rx_user_rst_o,         // sync to user_clk_o
    output  [63:0]  xgmii_rxd_o,        // sync to user_clk_o
    output  [ 7:0]  xgmii_rxc_o,        // 
    output          xgmii_rxd_vld_o,

    output          tx_user_clk_o,         // 156.25*2 clk 
    output          tx_user_rst_o,         // sync to user_clk_o
    input   [63:0]  xgmii_txd_i,        // sync to user_clk_o
    input   [ 7:0]  xgmii_txc_i,
    input           xgmii_txd_vld_i     // xgmii txd valid


);


///////////////////////////////////////////////////////////////////////////////
//                       parameter
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    wire            rx_user_clk;
    wire            rx_user_rst;
    wire            tx_user_clk;
    wire            tx_user_rst;
    wire            s_total_rst;
//rx side
    reg     [63:0]  r_rx_descrambled_data;
    reg     [ 1:0]  r_rx_descrambled_head;
    reg             r_rx_descrambled_valid;
    reg             r_rx_descrambled_valid_d1;
    wire    [63:0]  s_decode_data;
    wire    [ 1:0]  s_decode_head;
    wire            s_decode_data_vld;
    wire            s_decode_error;

    // wire    [31:0]  s_gtwiz_userdata_rx;
    // wire    [ 5:0]  s_rxheader;
    // wire    [ 1:0]  s_rxheadervalid;
    // wire            s_rxgearboxslip;
    wire            s_rx_lane_locked;
//tx side
    wire    [63:0]  s_encode_data;
    wire    [ 1:0]  s_encode_head;
    wire            s_encode_data_vld;
    wire            s_encode_error;
    wire    [63:0]  s_tx_scrambled_data;
    wire    [ 1:0]  s_tx_scrambled_head;
    wire            s_tx_scrambled_valid;

///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////

// ===================================================================================================================
// HELP BLOCKS
// ===================================================================================================================

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
    wire [0:0] gtwiz_userclk_tx_usrclk2_int;
    wire [0:0] hb0_gtwiz_userclk_tx_usrclk2_int;
    assign hb0_gtwiz_userclk_tx_usrclk2_int = gtwiz_userclk_tx_usrclk2_int[0:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_userclk_tx_active_int;
    wire [0:0] hb0_gtwiz_userclk_tx_active_int;
    assign hb0_gtwiz_userclk_tx_active_int = gtwiz_userclk_tx_active_int[0:0];

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
    wire [0:0] gtwiz_userclk_rx_usrclk2_int;
    wire [0:0] hb0_gtwiz_userclk_rx_usrclk2_int;
    assign hb0_gtwiz_userclk_rx_usrclk2_int = gtwiz_userclk_rx_usrclk2_int[0:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_userclk_rx_active_int;
    wire [0:0] hb0_gtwiz_userclk_rx_active_int;
    assign hb0_gtwiz_userclk_rx_active_int = gtwiz_userclk_rx_active_int[0:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_reset_clk_freerun_int;
    wire [0:0] hb0_gtwiz_reset_clk_freerun_int = 1'b0;
    assign gtwiz_reset_clk_freerun_int[0:0] = hb0_gtwiz_reset_clk_freerun_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_reset_all_int;
    wire [0:0] hb0_gtwiz_reset_all_int = 1'b0;
    assign gtwiz_reset_all_int[0:0] = hb0_gtwiz_reset_all_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_reset_tx_pll_and_datapath_int;
    wire [0:0] hb0_gtwiz_reset_tx_pll_and_datapath_int = 1'b0;
    assign gtwiz_reset_tx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_tx_pll_and_datapath_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] gtwiz_reset_tx_datapath_int;
    wire [0:0] hb0_gtwiz_reset_tx_datapath_int = 1'b0;
    assign gtwiz_reset_tx_datapath_int[0:0] = hb0_gtwiz_reset_tx_datapath_int;

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

    //--------------------------------------------------------------------------------------------------------------------
    wire [31:0] gtwiz_userdata_tx_int;
    wire [31:0] hb0_gtwiz_userdata_tx_int;
    assign gtwiz_userdata_tx_int[31:0] = hb0_gtwiz_userdata_tx_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [31:0] gtwiz_userdata_rx_int;
    wire [31:0] hb0_gtwiz_userdata_rx_int;
    assign hb0_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[31:0];

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

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] rxgearboxslip_int;
    wire [0:0] ch0_rxgearboxslip_int;
    assign rxgearboxslip_int[0:0] = ch0_rxgearboxslip_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [5:0] txheader_int;
    reg  [5:0] ch0_txheader_int;
    assign txheader_int[5:0] = ch0_txheader_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [6:0] txsequence_int;
    reg  [6:0] ch0_txsequence_int;
    assign txsequence_int[6:0] = ch0_txsequence_int;

    //--------------------------------------------------------------------------------------------------------------------
    wire [1:0] rxdatavalid_int;
    wire [1:0] ch0_rxdatavalid_int;
    assign ch0_rxdatavalid_int = rxdatavalid_int[1:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [5:0] rxheader_int;
    wire [5:0] ch0_rxheader_int;
    assign ch0_rxheader_int = rxheader_int[5:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [1:0] rxheadervalid_int;
    wire [1:0] ch0_rxheadervalid_int;
    assign ch0_rxheadervalid_int = rxheadervalid_int[1:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] rxpmaresetdone_int;
    wire [0:0] ch0_rxpmaresetdone_int;
    assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];

    //--------------------------------------------------------------------------------------------------------------------
    wire [0:0] rxprgdivresetdone_int;
    wire [0:0] ch0_rxprgdivresetdone_int;
    assign ch0_rxprgdivresetdone_int = rxprgdivresetdone_int[0:0];

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
    // USER CLOCKING RESETS
    // ===================================================================================================================

    // The TX user clocking helper block should be held in reset until the clock source of that block is known to be
    // stable. The following assignment is an example of how that stability can be determined, based on the selected TX
    // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
    assign hb0_gtwiz_userclk_tx_reset_int = ~(&txprgdivresetdone_int && &txpmaresetdone_int);

    // The RX user clocking helper block should be held in reset until the clock source of that block is known to be
    // stable. The following assignment is an example of how that stability can be determined, based on the selected RX
    // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
    assign hb0_gtwiz_userclk_rx_reset_int = ~(&rxprgdivresetdone_int && &rxpmaresetdone_int);
    
    // Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
    // initialization block as well as the VIO-sourced reset
    wire hb_gtwiz_reset_all_vio_int;
    wire hb_gtwiz_reset_all_buf_int;
    wire hb_gtwiz_reset_all_init_int;
    wire hb_gtwiz_reset_all_int;

    IBUF ibuf_hb_gtwiz_reset_all_inst (
        .I (hb_gtwiz_reset_all_in),
        .O (hb_gtwiz_reset_all_buf_int)
    );

    assign hb_gtwiz_reset_all_int = hb_gtwiz_reset_all_buf_int || hb_gtwiz_reset_all_init_int ;

    // Globally buffer the free-running input clock
    wire hb_gtwiz_reset_clk_freerun_buf_int;

    BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
    );

    IBUFDS_GTE3 #(
        .REFCLK_EN_TX_PATH  (1'b0),
        .REFCLK_HROW_CK_SEL (2'b00),
        .REFCLK_ICNTL_RX    (2'b00)
    ) IBUFDS_GTE3_MGTREFCLK0_X0Y0_INST (
        .I     (gtrefclk00p_i),
        .IB    (gtrefclk00n_i),
        .CEB   (1'b0),
        .O     (cm0_gtrefclk00_int),
        .ODIV2 ()
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
    gtwizard_0_example_init example_init_inst (
        .clk_freerun_in  (hb_gtwiz_reset_clk_freerun_buf_int),
        .reset_all_in    (hb_gtwiz_reset_all_int),
        .tx_init_done_in (gtwiz_reset_tx_done_int),
        .rx_init_done_in (gtwiz_reset_rx_done_int),
        .rx_data_good_in (s_rx_lane_locked),
        .reset_all_out   (hb_gtwiz_reset_all_init_int),
        .reset_rx_out    (hb_gtwiz_reset_rx_datapath_init_int),
        .init_done_out   (init_done_int),
        .retry_ctr_out   (init_retry_ctr_int)
    );

  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gtwizard_0_example_wrapper example_wrapper_inst (
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
   ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
   ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
   ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
   ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
   ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_int)
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
   ,.gtrefclk00_in                           (gtrefclk00_int)
   ,.qpll0outclk_out                         (qpll0outclk_int)
   ,.qpll0outrefclk_out                      (qpll0outrefclk_int)
   ,.rxgearboxslip_in                        (rxgearboxslip_int)
   ,.txheader_in                             (txheader_int)
   ,.txsequence_in                           (txsequence_int)
   ,.rxdatavalid_out                         (rxdatavalid_int)
   ,.rxheader_out                            (rxheader_int)
   ,.rxheadervalid_out                       (rxheadervalid_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
   ,.rxprgdivresetdone_out                   (rxprgdivresetdone_int)
   ,.rxstartofseq_out                        (rxstartofseq_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_int)
   ,.txprgdivresetdone_out                   (txprgdivresetdone_int)
);

// ===================================================================================================================
// CODE BLOCKS
// ===================================================================================================================

    assign  rx_user_clk = hb0_gtwiz_userclk_rx_usrclk2_int[0];
    assign  tx_user_clk = hb0_gtwiz_userclk_tx_usrclk2_int[0];
    assign  s_total_rst = hb_gtwiz_reset_all_int | ~hb0_gtwiz_reset_tx_done_int[0] | ~hb0_gtwiz_reset_rx_done_int[0];

    (* DONT_TOUCH = "TRUE" *)
    gtwizard_0_example_bit_synchronizer rx_rst (
        .clk_in (rx_user_clk),
        .i_in   (s_total_rst),
        .o_out  (rx_user_rst)
    );
    (* DONT_TOUCH = "TRUE" *)
    gtwizard_0_example_bit_synchronizer tx_rst (
        .clk_in (tx_user_clk),
        .i_in   (s_total_rst),
        .o_out  (tx_user_rst)
    );

    always @(posedge rx_user_clk) begin
        if(rx_user_rst)begin
            r_rx_descrambled_data   <= 64'h0;
            r_rx_descrambled_head   <= 2'b0;
            r_rx_descrambled_valid  <= 1'b0;
            r_rx_descrambled_valid_d1  <= 1'b0;
        end else begin
            if(ch0_rxheadervalid_int[0]) begin
                r_rx_descrambled_head   <= ch0_rxheader_int[1:0];
            end
            r_rx_descrambled_valid  <= ch0_rxheadervalid_int[0];
            r_rx_descrambled_valid_d1   <= r_rx_descrambled_valid;
            r_rx_descrambled_data   <= {gtwiz_userdata_rx_int, r_rx_descrambled_data[63:32]};
        end
    end

    descramble u_descramble(
        .clk_i              (rx_user_clk),              // Freq = 156.25*2
        .rst_i              (rx_user_rst),

        .data_i             (r_rx_descrambled_data),// [65:2] data, [1:0] head
        .head_i             (r_rx_descrambled_head),// [65:2] data, [1:0] head
        .data_vld_i         (r_rx_descrambled_valid_d1),// only valid data needs descramble
        .data_o             (s_decode_data),
        .head_o             (s_decode_head),
        .data_vld_o         (s_decode_data_vld) //

    );

    decode_64b_66b u_decode_64b_66b(
        .clk_i              (rx_user_clk),              // Freq = 156.25*2
        .rst_i              (rx_user_rst),

        .decode_data_i      (s_decode_data    ),
        .decode_head_i      (s_decode_head    ),
        .decode_data_vld_i  (s_decode_data_vld),  // decode data valid

        .xgmii_rxd_o        (xgmii_rxd_o    ),
        .xgmii_rxc_o        (xgmii_rxc_o    ),
        .xgmii_rxd_vld_o    (xgmii_rxd_vld_o),
        .decode_error_o     (s_decode_error )

    );

    rx_alignment u_rx_alignment(
        .clk_i              (rx_user_clk),              // Freq = 156.25*2
        .rst_i              (rx_user_rst),

        .gtwiz_userdata_rx_i(gtwiz_userdata_rx_int),
        .rxheader_i         (ch0_rxheader_int[1:0]),
        .rxheadervalid_i    (ch0_rxheadervalid_int[0]),

        .rxgearboxslip_o    (ch0_rxgearboxslip_int[0]),
        .locked             (s_rx_lane_locked)
    );


    encode_64b_66b u_encode_64b_66b(
        .clk_i              (tx_user_clk),              // Freq = 156.25*2
        .rst_i              (tx_user_rst),

        .xgmii_txd_i        (xgmii_txd_i),
        .xgmii_txc_i        (xgmii_txc_i),
        .xgmii_txd_vld_i    (xgmii_txd_vld_i),    // xgmii txd valid
        .encode_error_o     (s_encode_error),

        .encode_data_o      (s_encode_data),
        .encode_head_o      (s_encode_head),
        .encode_data_vld_o  (s_encode_data_vld) // encode data valid
    );

    scramble u_scramble(
        .clk_i              (tx_user_clk),              // Freq = 156.25*2
        .rst_i              (tx_user_rst),

        .data_i             (s_encode_data),         // [65:2] data, [1:0] head
        .head_i             (s_encode_head),         // [65:2] data, [1:0] head
        .data_vld_i         (s_encode_data_vld),     // only valid data needs scramble
        .data_o             (s_tx_scrambled_data),
        .head_o             (s_tx_scrambled_head),
        .data_vld_o         (s_tx_scrambled_valid)//

    );
    reg     [63:0]  ch0_txdata_int;
    always @(posedge tx_user_clk) begin
        if(tx_user_rst) begin
            ch0_txdata_int              <= 64'h0;
            ch0_txheader_int            <= 6'h0;
            ch0_txsequence_int          <= 7'h0;
        end else begin
            ch0_txheader_int[5:2]       <= 4'h0;
            ch0_txsequence_int[6:1]     <= 6'h0;
            if(s_tx_scrambled_valid) begin
                ch0_txheader_int[1:0]       <= s_tx_scrambled_head;
            end
            ch0_txsequence_int[0]           <= ~s_tx_scrambled_valid;
            if(s_tx_scrambled_valid) begin
                ch0_txdata_int              <= s_tx_scrambled_data;
            end else begin
                ch0_txdata_int              <= {32'h0,ch0_txdata_int[63:32]};
            end
        end
    end 
    assign  hb0_gtwiz_userdata_tx_int = ch0_txdata_int[31:0];

    assign  rx_user_clk_o = rx_user_clk;
    assign  rx_user_rst_o = rx_user_rst;
    assign  tx_user_clk_o = tx_user_clk;
    assign  tx_user_rst_o = tx_user_rst;

endmodule