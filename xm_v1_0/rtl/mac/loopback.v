//
//  By David
//
//  2019.4.6
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

module loopback #(
  parameter P_SCRAMBLE_LOOPBACK             = 1'b0,
  parameter P_GEARBOX_LOOPBACK              = 1'b0
)(
  output  [31:0]  gt_rx_data_o,
  input   [31:0]  gb_data_out_i,
  input   [31:0]  rx_data_i,

  input   [31:0]  gb_rx_data_i,
  input   [ 1:0]  gb_rx_head_i,
  input           gb_rx_head_valid_i,

  input   [31:0]  tx_data_i,
  input   [5:0]   tx_header_i,
  input   [6:0]   tx_sequence_i,

  output  [31:0]  rx_data_o,
  output  [ 5:0]  rx_head_o,
  output  [ 1:0]  rx_head_valid_o

);
  generate
    if(P_GEARBOX_LOOPBACK == 1) begin : g_gearbox_loopback_on
      assign  gt_rx_data_o = gb_data_out_i;
    end else begin : g_gearbox_loopback_off
      assign  gt_rx_data_o = rx_data_i;
    end
  endgenerate

  generate
    if(P_SCRAMBLE_LOOPBACK == 1) begin : g_scramble_loopback_on
      assign  rx_data_o         = tx_data_i;
      assign  rx_head_o         = tx_header_i;
      assign  rx_head_valid_o   = {1'b0, ~tx_sequence_i[0] & ~tx_sequence_i[6]};
    end else begin : g_scramble_loopback_off
      assign  rx_data_o         = gb_rx_data_i;
      assign  rx_head_o         = {4'b0, gb_rx_head_i};
      assign  rx_head_valid_o   = {1'b0, gb_rx_head_valid_i};
    end
  endgenerate

endmodule