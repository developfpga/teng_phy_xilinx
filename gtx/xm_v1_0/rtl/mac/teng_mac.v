//
//  By David
//
//  2019.4.3
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

module teng_mac #(
  parameter NUMBER_OF_LANES                 = 2,
  parameter P_SCRAMBLE_LOOPBACK             = 1'b0,
  parameter P_GEARBOX_LOOPBACK              = 1'b0
  )(
  input                             rx_user_clk_i,
  input                             rx_fsm_reset_done_i,
  input   [NUMBER_OF_LANES*32-1:0]  rx_data_i,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  input                             tx_user_clk_i,
  input                             tx_fsm_reset_done_i,
  output  [NUMBER_OF_LANES*32-1:0]  tx_data_o,

  output  [NUMBER_OF_LANES-1:0]     link_up_o,
  // AXIS tx
  // input                             tx_user_clk_i,
  output                            tx_user_rst_o,
  input   [NUMBER_OF_LANES*32-1:0]  tx_data_i,
  input   [NUMBER_OF_LANES*2-1:0]   tx_vldb_i,
  input   [NUMBER_OF_LANES-1:0]     tx_valid_i,
  output  [NUMBER_OF_LANES-1:0]     tx_ready_o,
  input   [NUMBER_OF_LANES-1:0]     tx_last_i,
  input   [NUMBER_OF_LANES-1:0]     tx_user_i,

  output  [NUMBER_OF_LANES-1:0]     tx_status_o,
  output  [NUMBER_OF_LANES-1:0]     tx_rsp_valid_o,
  // AXIS rx
  // input                             rx_user_clk_i,
  output                            rx_user_rst_o,
  output  [NUMBER_OF_LANES*32-1:0]  rx_data_o,
  output  [NUMBER_OF_LANES*2-1:0]   rx_vldb_o,
  output  [NUMBER_OF_LANES-1:0]     rx_valid_o,
  output  [NUMBER_OF_LANES-1:0]     rx_last_o,
  output  [NUMBER_OF_LANES-1:0]     rx_user_o
);
  `include "xgmii_includes.vh"
//************************** Register Declarations ****************************

  (* ASYNC_REG = "TRUE" *)reg             r_tx_fsm_reset_done_d;
  (* ASYNC_REG = "TRUE" *)reg             r_tx_fsm_reset_done_d2;
  (* ASYNC_REG = "TRUE" *)reg             r_rx_fsm_reset_done_d;
  (* ASYNC_REG = "TRUE" *)reg             r_rx_fsm_reset_done_d2;
  // ===========================================================================
  //         register & wire
  // ===========================================================================
  // wire    [NUMBER_OF_LANES*32-1:0]  s_gt_rx_data;
  // wire    [NUMBER_OF_LANES*32-1:0]  s_rx_data;
  // wire    [NUMBER_OF_LANES*6-1:0]   s_rx_head;
  // wire    [NUMBER_OF_LANES*2-1:0]   s_rx_head_valid;

  // wire    [NUMBER_OF_LANES*1-1:0]   s_rx_gearbox_slip;
  // wire    [NUMBER_OF_LANES*32-1:0]  s_tx_data;
  // wire    [NUMBER_OF_LANES*6-1:0]   s_tx_header;
  // wire    [NUMBER_OF_LANES*7-1:0]   s_tx_sequence;

  // wire    [NUMBER_OF_LANES*2-1:0]   s_rx_data_valid;
  // wire    [NUMBER_OF_LANES*32-1:0]  s_rx_data;
  // wire    [NUMBER_OF_LANES*2-1:0]   s_rx_header;
  // wire    [NUMBER_OF_LANES*1-1:0]   s_rx_header_valid;


  always @(posedge  rx_user_clk_i or negedge rx_fsm_reset_done_i) begin
    if (!rx_fsm_reset_done_i) begin
      r_rx_fsm_reset_done_d    <=   `DLY 1'b0;
      r_rx_fsm_reset_done_d2   <=   `DLY 1'b0;
    end else begin
      r_rx_fsm_reset_done_d    <=   `DLY rx_fsm_reset_done_i;
      r_rx_fsm_reset_done_d2   <=   `DLY r_rx_fsm_reset_done_d;
    end
  end

  always @(posedge  tx_user_clk_i or negedge tx_fsm_reset_done_i) begin
    if (!tx_fsm_reset_done_i) begin
      r_tx_fsm_reset_done_d    <=   `DLY 1'b0;
      r_tx_fsm_reset_done_d2   <=   `DLY 1'b0;
    end else begin
      r_tx_fsm_reset_done_d    <=   `DLY tx_fsm_reset_done_i;
      r_tx_fsm_reset_done_d2   <=   `DLY r_tx_fsm_reset_done_d;
    end
  end

  assign  rx_user_rst_o = ~r_rx_fsm_reset_done_d2;
  assign  tx_user_rst_o = ~r_tx_fsm_reset_done_d2;

  // assign  tx_user_clk_o = tx_user_clk_i;
  // assign  tx_user_rst_o = ~r_tx_fsm_reset_done_d2;

  generate
  genvar i;
  for(i = 0; i < NUMBER_OF_LANES; i = i + 1) begin : g_mac
    wire    [31:0]      s_gt_rx_data;

    wire    [31:0]      s_gb_rx_data;
    wire    [ 1:0]      s_gb_rx_head;
    wire                s_gb_rx_head_valid;

    wire    [31:0]      s_rx_data;
    wire    [ 5:0]      s_rx_head;
    wire    [ 1:0]      s_rx_head_valid;

    wire    [0:0]       s_rx_gearbox_slip;
    wire    [31:0]      s_tx_data;
    wire    [5:0]       s_tx_header;
    wire    [6:0]       s_tx_sequence;


    wire    [31:0]      s_gb_data_out;
    tx u_tx (
      // Clks and resets
      .clk_i          (tx_user_clk_i),
      .rst_i          (~r_tx_fsm_reset_done_d2),

      // XGMII
      .data_o         (s_tx_data),
      .head_o         (s_tx_header),
      .sequence_o     (s_tx_sequence),

      // AXIS
      .tdata_i        (tx_data_i[i*32 +: 32]),
      .tvldb_i        (tx_vldb_i[i*2 +: 2]),
      .tvalid_i       (tx_valid_i[i]),
      .tready_o       (tx_ready_o[i]),
      .tlast_i        (tx_last_i[i]),
      .tuser_i        (tx_user_i[i]),

      .tx_status_o    (tx_status_o[i]   ),
      .tx_rsp_valid_o (tx_rsp_valid_o[i])
    );
    gearbox_66b_64b u_gearbox_66_64 (

      // Clks and resets
      .clk_i          (tx_user_clk_i),
      .rst_i          (~r_tx_fsm_reset_done_d2),

      .data_i         (s_tx_data),
      .head_i         (s_tx_header[1:0]),
      .sequence_i     (s_tx_sequence),

      .data_o         (s_gb_data_out)
    );
    assign  tx_data_o[i*32 +: 32] = bit32_rev(s_gb_data_out);

    // generate
    //   if(P_GEARBOX_LOOPBACK == 1) begin : g_gearbox_loopback_on
    //     assign  s_gt_rx_data = s_gb_data_out;
    //   end else begin : g_gearbox_loopback_off
    //     assign  s_gt_rx_data = bit32_rev(rx_data_i);
    //   end
    // endgenerate

    // assign  rx_user_clk_o = rx_user_clk_i;
    // assign  rx_user_rst_o = ~r_rx_fsm_reset_done_d2;
    gearbox_64b_66b u_gearbox_64_66 (

      // Clks and resets
      .clk_i          (rx_user_clk_i),
      .rst_i          (~r_rx_fsm_reset_done_d2),

      .data_o         (s_gb_rx_data),
      .head_o         (s_gb_rx_head),
      .head_valid_o   (s_gb_rx_head_valid),
      .slip_i         (s_rx_gearbox_slip),

      .data_i         (s_gt_rx_data)
      // .data_i         (gtwiz_userdata_tx_int)
    );
    loopback #(
      .P_SCRAMBLE_LOOPBACK          (P_SCRAMBLE_LOOPBACK),
      .P_GEARBOX_LOOPBACK           (P_GEARBOX_LOOPBACK )
    )u_loopback(
      .gt_rx_data_o                 (s_gt_rx_data),
      .gb_data_out_i                (s_gb_data_out),
      .rx_data_i                    (bit32_rev(rx_data_i)),

      .gb_rx_data_i                 (s_gb_rx_data),
      .gb_rx_head_i                 (s_gb_rx_head),
      .gb_rx_head_valid_i           (s_gb_rx_head_valid),

      .tx_data_i                    (s_tx_data),
      .tx_header_i                  (s_tx_header),
      .tx_sequence_i                (s_tx_sequence),

      .rx_data_o                    (s_rx_data),
      .rx_head_o                    (s_rx_head),
      .rx_head_valid_o              (s_rx_head_valid)

    );
    // generate
    //   if(P_SCRAMBLE_LOOPBACK == 1) begin : g_scramble_loopback_on
    //     assign  s_rx_data         = s_tx_data;
    //     assign  s_rx_head         = s_tx_header;
    //     assign  s_rx_head_valid   = {1'b0, ~s_tx_sequence[0] & ~s_tx_sequence[6]};
    //   end else begin : g_scramble_loopback_off
    //     assign  s_rx_data         = s_gb_rx_data;
    //     assign  s_rx_head         = {4'b0, s_gb_rx_head};
    //     assign  s_rx_head_valid   = {1'b0, s_gb_rx_head_valid};
    //   end
    // endgenerate

    rx u_rx (
      // Clks and resets
      .clk_i          (rx_user_clk_i),
      .rst_i          (~r_rx_fsm_reset_done_d2),

      // PCS
      .data_i         (s_rx_data),
      .head_i         (s_rx_head),
      .head_valid_i   (s_rx_head_valid),
      .slip_o         (s_rx_gearbox_slip),

      // AXIS
      .tdata_o        (rx_data_o[i*32 +: 32]),
      .tvldb_o        (rx_vldb_o[i*2 +: 2]),
      .tvalid_o       (rx_valid_o[i]),
      .tlast_o        (rx_last_o[i]),
      .tuser_o        (rx_user_o[i]),
      .link_up_o      (link_up_o[i])
    );
  end
  endgenerate

endmodule