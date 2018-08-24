///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
// description:
//   connect to gtx
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module 64b_66b_encode{
    input           clk_i,              // Freq = 156.25*2
    input           rst_n_i,

    input   [63:0]  xgmii_txd_i,
    input   [ 7:0]  xgmii_txc_i,
    input           xgmii_txd_vld_i,    // xgmii txd valid

    output  [31:0]  encode_data_o,
    output  [ 1:0]  encode_head_o,
    output          encode_data_vld_o   // encode data valid
};

endmodule
