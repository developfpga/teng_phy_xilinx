///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-30
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module pcs_top(

    input           gthrxn_i,
    input           gthrxp_i,
    output          gthtxn_o,
    output          gthtxp_o,
    input           gtrefclk00_i,

    output          user_clk_o,         // 156.25*2 clk 
    output          user_rst_o,         // sync to user_clk_o

    output  [63:0]  xgmii_rxd_o,        // sync to user_clk_o
    output  [ 7:0]  xgmii_rxc_o,        // 
    output          xgmii_rxd_vld_o,

    input   [63:0]  xgmii_txd_i,        // sync to user_clk_o
    input   [ 7:0]  xgmii_txc_i,
    input           xgmii_txd_vld_i,    // xgmii txd valid


);


///////////////////////////////////////////////////////////////////////////////
//                       parameter
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    wire            user_clk;
    wire            user_rst;
//rx side
    wire    [65:0]  s_rx_descrambled_data;
    wire            s_rx_descrambled_valid;
    wire    [63:0]  s_decode_data;
    wire    [ 1:0]  s_decode_head;
    wire            s_decode_data_vld;
    wire            s_decode_error;

    wire    [31:0]  s_gtwiz_userdata_rx;
    wire    [ 5:0]  s_rxheader;
    wire    [ 1:0]  s_rxheadervalid;
    wire            s_rxgearboxslip;
    wire            s_rx_lane_locked;
//tx side
    wire    [63:0]  s_encode_data;
    wire    [ 1:0]  s_encode_head;
    wire            s_encode_data_vld;
    wire            s_encode_error;
    wire    [65:0]  s_tx_scrambled_data;
    wire            s_tx_scrambled_valid;

///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////

descramble u_descramble(
    .clk_i              (user_clk),              // Freq = 156.25*2
    .rst_i              (user_rst),

    .data_i             (s_rx_descrambled_data),// [65:2] data, [1:0] head
    .data_vld_i         (s_rx_descrambled_valid),// only valid data needs descramble
    .data_o             ({s_decode_data, s_decode_head}),
    .data_vld_o         (s_decode_data_vld) //

);

64b_66b_decode u_64b_66b_decode(
    .clk_i              (user_clk),              // Freq = 156.25*2
    .rst_i              (user_rst),

    .decode_data_i      (s_decode_data    ),
    .decode_head_i      (s_decode_head    ),
    .decode_data_vld_i  (s_decode_data_vld),  // decode data valid

    .xgmii_rxd_o        (xgmii_rxd_o    ),
    .xgmii_rxc_o        (xgmii_rxc_o    ),
    .xgmii_rxd_vld_o    (xgmii_rxd_vld_o),
    .decode_error_o     (s_decode_error )

);

rx_alignment u_rx_alignment(
    .clk_i              (user_clk),              // Freq = 156.25*2
    .rst_i              (user_rst),

    .gtwiz_userdata_rx_i(s_gtwiz_userdata_rx),
    .rxheader_i         (s_rxheader[1:0]),
    .rxheadervalid_i    (s_rxheadervalid[0]),

    .rxgearboxslip_o    (s_rxgearboxslip),
    .locked             (s_rx_lane_locked)
);


64b_66b_encode u_64b_66b_encode(
    .clk_i              (user_clk),              // Freq = 156.25*2
    .rst_i              (user_rst),

    .xgmii_txd_i        (xgmii_txd_i),
    .xgmii_txc_i        (xgmii_txc_i),
    .xgmii_txd_vld_i    (xgmii_txd_vld_i),    // xgmii txd valid
    .encode_error_o     (s_encode_error),

    .encode_data_o      (s_encode_data),
    .encode_head_o      (s_encode_head),
    .encode_data_vld_o  (s_encode_data_vld) // encode data valid
);



scramble u_scramble(
    .clk_i              (user_clk),              // Freq = 156.25*2
    .rst_i              (user_rst),

    .data_i             ({s_encode_data,s_encode_head}),         // [65:2] data, [1:0] head
    .data_vld_i         (s_encode_data_vld),     // only valid data needs scramble
    .data_o             (s_tx_scrambled_data),
    .data_vld_o         (s_tx_scrambled_valid)//

);


module gtwizard_ultrascale_0_example_wrapper (
  input  wire [0:0] gthrxn_in
 ,input  wire [0:0] gthrxp_in
 ,output wire [0:0] gthtxn_out
 ,output wire [0:0] gthtxp_out
 ,input  wire [0:0] gtwiz_userclk_tx_reset_in
 ,output wire [0:0] gtwiz_userclk_tx_srcclk_out
 ,output wire [0:0] gtwiz_userclk_tx_usrclk_out
 ,output wire [0:0] gtwiz_userclk_tx_usrclk2_out
 ,output wire [0:0] gtwiz_userclk_tx_active_out
 ,input  wire [0:0] gtwiz_userclk_rx_reset_in
 ,output wire [0:0] gtwiz_userclk_rx_srcclk_out
 ,output wire [0:0] gtwiz_userclk_rx_usrclk_out
 ,output wire [0:0] gtwiz_userclk_rx_usrclk2_out
 ,output wire [0:0] gtwiz_userclk_rx_active_out
 ,input  wire [0:0] gtwiz_reset_clk_freerun_in
 ,input  wire [0:0] gtwiz_reset_all_in
 ,input  wire [0:0] gtwiz_reset_tx_pll_and_datapath_in
 ,input  wire [0:0] gtwiz_reset_tx_datapath_in
 ,input  wire [0:0] gtwiz_reset_rx_pll_and_datapath_in
 ,input  wire [0:0] gtwiz_reset_rx_datapath_in
 ,output wire [0:0] gtwiz_reset_rx_cdr_stable_out
 ,output wire [0:0] gtwiz_reset_tx_done_out
 ,output wire [0:0] gtwiz_reset_rx_done_out
 ,input  wire [31:0] gtwiz_userdata_tx_in
 ,output wire [31:0] gtwiz_userdata_rx_out
 ,input  wire [0:0] gtrefclk00_in
 ,output wire [0:0] qpll0outclk_out
 ,output wire [0:0] qpll0outrefclk_out
 ,input  wire [0:0] rxgearboxslip_in
 ,input  wire [5:0] txheader_in
 ,input  wire [6:0] txsequence_in
 ,output wire [0:0] gtpowergood_out
 ,output wire [1:0] rxdatavalid_out
 ,output wire [5:0] rxheader_out
 ,output wire [1:0] rxheadervalid_out
 ,output wire [0:0] rxpmaresetdone_out
 ,output wire [0:0] rxprgdivresetdone_out
 ,output wire [1:0] rxstartofseq_out
 ,output wire [0:0] txpmaresetdone_out
 ,output wire [0:0] txprgdivresetdone_out
);


endmodule