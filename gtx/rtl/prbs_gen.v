//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module prbs_gen (
  input                    tx_user_clk_i,
  input                    tx_user_rst_i,
  output       [31:0]      tx_data_o,
  output       [1:0]       tx_vldb_o,
  output                   tx_valid_o,
  input                    tx_ready_i,
  output                   tx_last_o,
  output       [0:0]       tx_user_o
);

  reg     [7:0]   r_count;

  always @(posedge tx_user_clk_i) begin
    if(tx_user_rst_i) begin
      r_count   <= 'd0;
    end else begin
      if(tx_valid_o & tx_ready_i) begin
        if(r_count == 8'hff) begin
          r_count   <= 'd0;
        end else begin
          r_count   <= r_count + 8'h1;
        end
      end
    end
  end

  assign  tx_last_o   = r_count == 8'hff;
  assign  tx_valid_o  = 1'b1;
  assign  tx_vldb_o   = 2'b11;
  assign  tx_user_o   = 1'b0;


  // -------------------------------------------------------------------------------------------------------------------
  // PRBS generator block
  // -------------------------------------------------------------------------------------------------------------------

  // The prbs_any block, described in Xilinx Application Note 884 (XAPP884), "An Attribute-Programmable PRBS Generator
  // and Checker", generates or checks a parameterizable PRBS sequence. Instantiate and parameterize a prbs_any block
  // to generate a PRBS31 sequence with parallel data sized to the transmitter user data width.
  gtwizard_ultrascale_0_prbs_any # (
    .CHK_MODE    (0),
    .INV_PATTERN (1),
    .POLY_LENGHT (31),
    .POLY_TAP    (28),
    .NBITS       (32)
  ) prbs_any_gen_inst (
    .RST      (tx_user_rst_i),
    .CLK      (tx_user_clk_i),
    .DATA_IN  (32'b0),
    .EN       (tx_ready_i),
    .DATA_OUT (tx_data_o)
  );

endmodule
