///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
// description:
//   connect to gtx
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module 64b_66b_decode{
    input           clk_i,              // Freq = 156.25*2
    input           rst_n_i,

    input   [63:0]  decode_data_i,
    input   [ 1:0]  decode_head_i,
    input           decode_data_vld_i,  // decode data valid

    output  [31:0]  xgmii_rxd_o,
    output  [ 7:0]  xgmii_rxc_o,
    output          xgmii_rxd_vld_o,    // xgmii rxd valid
    output          decode_error_o

};

endmodule
