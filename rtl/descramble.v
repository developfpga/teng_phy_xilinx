///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module descramble{
    input           clk_i,          // Freq = 156.25*2
    input           rst_n_i,

    input   [65:0]  data_i,         //[65:2] data, [1:0] head
    input           data_vld_i,     // only valid data needs descramble
    output  [65:0]  data_o,
    output          data_vld_o      //

};

endmodule
