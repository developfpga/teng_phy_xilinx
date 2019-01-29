//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module tx (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  // XGMII
  output       [31:0]      data_o,
  output       [5:0]       head_o,
  output       [6:0]       sequence_o,

  // AXIS
  input        [31:0]      tdata_i,
  input        [1:0]       tvldb_i,
  input                    tvalid_i,
  output                   tready_o,
  input                    tlast_i,
  input        [0:0]       tuser_i,

  output                   tx_status_o,
  output                   tx_rsp_valid_o
  );

/******************************************************************************
//                              register
******************************************************************************/
  wire    [31:0]      s_xgmii_d;
  wire    [3:0]       s_xgmii_c;
  reg     [31:0]      r_xgmii_d;
  reg     [3:0]       r_xgmii_c;

  wire    [63:0]      s_xgmii_txd_64;
  wire    [ 7:0]      s_xgmii_txc_64;
  wire                s_xgmii_txd_vld_64;

  wire    [63:0]      s_encode_data;
  wire    [ 1:0]      s_encode_head;
  wire                s_encode_data_vld;
  wire                s_encode_error;
  wire    [63:0]      s_tx_scrambled_data;
  wire    [ 1:0]      s_tx_scrambled_head;
  wire                s_tx_scrambled_valid;

  wire    [ 6:0]      s_sequence;
  reg     [ 6:0]      r_sequence_d1;
  reg     [ 6:0]      r_sequence_d2;
  reg     [ 6:0]      r_sequence_d3;
  reg     [ 6:0]      r_sequence_d4;
  reg     [ 6:0]      r_sequence_d5;
  reg     [63:0]      r_data;
  reg     [ 1:0]      r_head;

/******************************************************************************
//                              rtl body
******************************************************************************/
  axis2xgmii32 u_axis2xgmii32 (

    // Clks and resets
    .clk_i          (clk_i),
    .rst_i          (rst_i),

    // XGMII
    .xgmii_d_o      (s_xgmii_d),
    .xgmii_c_o      (s_xgmii_c),
    .sequence_o     (s_sequence),

    // AXIS
    .tdata_i        (tdata_i),
    .tvldb_i        (tvldb_i),
    .tvalid_i       (tvalid_i),
    .tready_o       (tready_o),
    .tlast_i        (tlast_i),
    .tuser_i        (tuser_i),

    .tx_status_o    (tx_status_o),
    .tx_rsp_valid_o (tx_rsp_valid_o)
    );

  always @(posedge clk_i) begin
    r_xgmii_d   <= s_xgmii_d;
    r_xgmii_c   <= s_xgmii_c;
  end
  assign  s_xgmii_txd_vld_64 = s_sequence[0] & ~s_sequence[6];
  assign  s_xgmii_txd_64 = {s_xgmii_d, r_xgmii_d};
  assign  s_xgmii_txc_64 = {s_xgmii_c, r_xgmii_c};
  encode_64b_66b u_encode_64b_66b(
    .clk_i              (clk_i),              // Freq = 156.25*2
    .rst_i              (rst_i),

    .xgmii_txd_i        (s_xgmii_txd_64),
    .xgmii_txc_i        (s_xgmii_txc_64),
    .xgmii_txd_vld_i    (s_xgmii_txd_vld_64),    // xgmii txd valid
    .encode_error_o     (s_encode_error),

    .encode_data_o      (s_encode_data),
    .encode_head_o      (s_encode_head),
    .encode_data_vld_o  (s_encode_data_vld) // encode data valid
  );

  scramble u_scramble(
    .clk_i              (clk_i),              // Freq = 156.25*2
    .rst_i              (rst_i),

    .data_i             (s_encode_data),         // [65:2] data, [1:0] head
    .head_i             (s_encode_head),         // [65:2] data, [1:0] head
    .data_vld_i         (s_encode_data_vld),     // only valid data needs scramble
    .data_o             (s_tx_scrambled_data),
    .head_o             (s_tx_scrambled_head),
    .data_vld_o         (s_tx_scrambled_valid)//

  );

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_sequence_d1   <= 'd0;
      r_sequence_d2   <= 'd0;
      r_sequence_d3   <= 'd0;
      r_sequence_d4   <= 'd0;
      r_sequence_d5   <= 'd0;
    end else begin
      r_sequence_d1   <= s_sequence;
      r_sequence_d2   <= r_sequence_d1;
      r_sequence_d3   <= r_sequence_d2;
      r_sequence_d4   <= r_sequence_d3;
      r_sequence_d5   <= r_sequence_d4;
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data    <= 'd0;
      r_head    <= 'd0;
    end else begin
      if(s_tx_scrambled_valid) begin
        r_data    <= s_tx_scrambled_data;
        r_head    <= s_tx_scrambled_head;
      end else begin
        r_data    <= {32'h0, r_data[63:32]};
      end
    end
  end

/******************************************************************************
//                              output
******************************************************************************/
  assign  data_o = r_data[31:0];
  assign  head_o = {4'b0, r_head};
  assign  sequence_o = {1'b0, r_sequence_d5[6:1]};

endmodule
