//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module gearbox_64_66 (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  output       [31:0]      data_o,
  output       [1:0]       head_o,
  output                   head_valid_o,
  input                    slip_i,

  input        [31:0]      data_i
);

endmodule

