//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module prbs_check (
  input                   rx_user_clk_i,
  input                   rx_user_rst_i,
  input       [31:0]      rx_data_i,
  input       [1:0]       rx_vldb_i,
  input                   rx_valid_i,
  input                   rx_last_i,
  input       [0:0]       rx_user_i,
  output                  err_o
);

  reg     [7:0]   r_count;
  wire    [31:0]  s_rx_prbs_check;

  reg     [7:0]   r_err1_cnt;
  reg     [7:0]   r_err2_cnt;
  reg     [7:0]   r_err3_cnt;

  assign  err_o = (|r_err1_cnt) | (|r_err2_cnt) | (|r_err3_cnt);
  always @(posedge rx_user_clk_i) begin
    if(rx_user_rst_i) begin
      r_count   <= 'd0;
    end else begin
      if(rx_valid_i) begin
        if(r_count == 8'hff || rx_last_i) begin
          r_count   <= 'd0;
        end else begin
          r_count   <= r_count + 8'h1;
        end
      end
    end
  end

  // r_err1_cnt
  // 包长错误
  always @(posedge rx_user_clk_i) begin
    if(rx_user_rst_i) begin
      r_err1_cnt    <= 'd0;
    end else begin
      if(rx_valid_i) begin
        if(r_count == 8'hff && ~rx_last_i) begin
          r_err1_cnt    <= r_err1_cnt + 8'd1;
        end
      end
    end
  end

  // r_err2_cnt
  // vldb 错误
  always @(posedge rx_user_clk_i) begin
    if(rx_user_rst_i) begin
      r_err2_cnt    <= 'd0;
    end else begin
      if(rx_valid_i) begin
        if(rx_vldb_i != 2'b11) begin
          r_err2_cnt    <= r_err2_cnt + 8'd1;
        end
      end
    end
  end

  // r_err3_cnt
  // 数据错误
  always @(posedge rx_user_clk_i) begin
    if(rx_user_rst_i) begin
      r_err3_cnt    <= 'd0;
    end else begin
      if(|s_rx_prbs_check) begin
        r_err3_cnt    <= r_err3_cnt + 8'd1;
      end
    end
  end
  // -------------------------------------------------------------------------------------------------------------------
  // PRBS checker block
  // -------------------------------------------------------------------------------------------------------------------

  // The prbs_any block, described in Xilinx Application Note 884 (XAPP884), "An Attribute-Programmable PRBS Generator
  // and Checker", generates or checks a parameterizable PRBS sequence. Instantiate and parameterize a prbs_any block
  // to check a PRBS31 sequence with parallel data sized to the receiver user data width.

  gtwizard_ultrascale_0_prbs_any # (
    .CHK_MODE    (1),
    .INV_PATTERN (1),
    .POLY_LENGHT (31),
    .POLY_TAP    (28),
    .NBITS       (32)
  ) prbs_any_gen_inst (
    .RST      (rx_user_rst_i),
    .CLK      (rx_user_clk_i),
    .DATA_IN  (rx_data_i),
    .EN       (rx_valid_i),
    .DATA_OUT (s_rx_prbs_check)
  );


endmodule
