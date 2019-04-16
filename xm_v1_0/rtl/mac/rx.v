//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module rx (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  // PCS
  input        [31:0]      data_i,
  input        [5:0]       head_i,
  input        [1:0]       head_valid_i,
  output                   slip_o,

  // AXIS
  output       [31:0]      tdata_o,
  output       [1:0]       tvldb_o,
  output                   tvalid_o,
  output                   tlast_o,
  output       [0:0]       tuser_o,

  output                   link_up_o
  );

`include "xgmii_includes.vh"
/******************************************************************************
//                              register
******************************************************************************/
  wire            s_rx_lane_locked;

  reg     [31:0]  r_data;
  reg     [ 5:0]  r_head;
  wire    [63:0]  s_rx_descrambled_data;
  wire    [ 1:0]  s_rx_descrambled_head;
  wire    [63:0]  s_rx_descrambled_data_rev;
  wire    [ 1:0]  s_rx_descrambled_head_rev;
  reg             r_rx_descrambled_valid;
  wire    [63:0]  s_decode_data;
  wire    [ 1:0]  s_decode_head;
  wire            s_decode_data_vld;
  wire            s_decode_error;

  wire    [63:0]  s_xgmii_rxd_64;
  wire    [ 7:0]  s_xgmii_rxc_64;
  wire            s_xgmii_rxd_vld_64;
  reg             r_xgmii_rxd_vld_64;

  reg     [31:0]  r_xgmii_d_32;
  reg     [3:0]   r_xgmii_c_32;
  reg             r_xgmii_v_32;
/******************************************************************************
//                              rtl body
******************************************************************************/

  rx_alignment #(
    .P_SLIP_GAP_WIDTH (8)
  )u_rx_alignment(
    .clk_i              (clk_i),              // Freq = 156.25*2
    .rst_i              (rst_i),

    .gtwiz_userdata_rx_i(32'd0),
    .rxheader_i         (head_i[1:0]),
    .rxheadervalid_i    (head_valid_i[0]),

    .rxgearboxslip_o    (slip_o),
    .locked             (s_rx_lane_locked)
  );
  assign  link_up_o = s_rx_lane_locked;

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data    <= 'd0;
      r_head    <= 'd0;
      r_rx_descrambled_valid  <= 'd0;
    end else begin
      r_data    <= data_i;
      r_head    <= head_i;
      r_rx_descrambled_valid  <= head_valid_i[0] & s_rx_lane_locked;
    end
  end
  assign  s_rx_descrambled_data   = {r_data, data_i};
  assign  s_rx_descrambled_head   = r_head[1:0];

  assign  s_rx_descrambled_data_rev = bit64_rev(s_rx_descrambled_data);
  assign  s_rx_descrambled_head_rev = bit2_rev(s_rx_descrambled_head);
  // assign  r_rx_descrambled_valid  = head_valid_i[0];
  descramble u_descramble(
    .clk_i              (clk_i),              // Freq = 156.25*2
    .rst_i              (rst_i),

    .data_i             (s_rx_descrambled_data_rev),// [65:2] data, [1:0] head
    .head_i             (s_rx_descrambled_head_rev),// [65:2] data, [1:0] head
    .data_vld_i         (r_rx_descrambled_valid),// only valid data needs descramble
    .data_o             (s_decode_data),
    .head_o             (s_decode_head),
    .data_vld_o         (s_decode_data_vld) //

  );

  decode_64b_66b u_decode_64b_66b(
    .clk_i              (clk_i),              // Freq = 156.25*2
    .rst_i              (rst_i),

    .decode_data_i      (s_decode_data    ),
    .decode_head_i      (s_decode_head    ),
    .decode_data_vld_i  (s_decode_data_vld),  // decode data valid

    .xgmii_rxd_o        (s_xgmii_rxd_64    ),
    .xgmii_rxc_o        (s_xgmii_rxc_64    ),
    .xgmii_rxd_vld_o    (s_xgmii_rxd_vld_64),
    .decode_error_o     (s_decode_error )

  );
  always @(posedge clk_i) begin
    if(rst_i) begin
      r_xgmii_rxd_vld_64  <= 1'b0;
      r_xgmii_d_32  <= 'd0;
      r_xgmii_c_32  <= 'd0;
      r_xgmii_v_32  <= 'd0;
    end else begin
      r_xgmii_rxd_vld_64  <= s_xgmii_rxd_vld_64;
      if(s_xgmii_rxd_vld_64) begin
        r_xgmii_d_32  <= s_xgmii_rxd_64[31:0];
        r_xgmii_c_32  <= s_xgmii_rxc_64[3:0];
      end else begin
        r_xgmii_d_32  <= s_xgmii_rxd_64[63:32];
        r_xgmii_c_32  <= s_xgmii_rxc_64[7:4];
      end
      r_xgmii_v_32  <= r_xgmii_rxd_vld_64 | s_xgmii_rxd_vld_64;
    end
  end


  xgmii2axis32 u_xgmii2axis32 (

    // clk_is and resets
    .clk_i          (clk_i),
    .rst_i          (rst_i),

    // Stats
    .good_frames_o  (),
    .bad_frames_o   (),

    // XGMII
    .xgmii_d_i      (r_xgmii_d_32),
    .xgmii_c_i      (r_xgmii_c_32),
    .xgmii_v_i      (r_xgmii_v_32),

    // AXIS
    .tdata_o        (tdata_o),
    .tvldb_o        (tvldb_o),
    .tvalid_o       (tvalid_o),
    .tlast_o        (tlast_o),
    .tuser_o        (tuser_o)
    );

/******************************************************************************
//                              output
******************************************************************************/


endmodule
