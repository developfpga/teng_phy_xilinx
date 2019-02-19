//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module gearbox_66_64 (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  input        [31:0]      data_i,
  input        [5:0]       head_i,
  input        [6:0]       sequence_i,

  output       [31:0]      data_o
);

endmodule

