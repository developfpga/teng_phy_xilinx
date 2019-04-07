//
//  By David
//
//  2019.4.5
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration*******************************

module gt_usr_clk_source #(
  parameter NUMBER_OF_LANES                 = 2,
  parameter MASTER_LANE_ID                  = 0
)
(
  output  [NUMBER_OF_LANES-1:0]   tx_usr_clk_o,//TXUSRCLK_OUT,
  output  [NUMBER_OF_LANES-1:0]   tx_usr_clk2_o,//TXUSRCLK2_OUT,
  input   [NUMBER_OF_LANES-1:0]   tx_out_clk_i,//TXOUTCLK_IN,
  output  [NUMBER_OF_LANES-1:0]   tx_clk_lock_o,//TXCLK_LOCK_OUT,
  input   [NUMBER_OF_LANES-1:0]   tx_mmcm_reset_i,//TX_MMCM_RESET_IN,
  output  [NUMBER_OF_LANES-1:0]   rx_usr_clk_o,//RXUSRCLK_OUT,
  output  [NUMBER_OF_LANES-1:0]   rx_usr_clk2_o,//RXUSRCLK2_OUT,
  input   [NUMBER_OF_LANES-1:0]   rx_out_clk_i,//RXOUTCLK_IN,

  input  wire     gt_ref_clk_pad_n_i,
  input  wire     gt_ref_clk_pad_p_i,
  output wire     gt_ref_clk_o

);


//*********************************Wire Declarations**********************************
  wire            tied_to_ground_i;
  wire            tied_to_vcc_i;


  wire            s_gt_ref_clk_buf /*synthesis syn_noclockbuf=1*/;
  wire            s_rx_usr_clk_buf;
  wire            s_tx_usr_clk_buf;
  wire            s_tx_out_clk_mmcm_locked;


//*********************************** Beginning of Code *******************************

  //  Static signal Assigments
  assign tied_to_ground_i             = 1'b0;
  assign tied_to_vcc_i                = 1'b1;

  assign gt_ref_clk_o = s_gt_ref_clk_buf;

  //IBUFDS_GTE2
  IBUFDS_GTE2 ibufds_instQ2_CLK0
  (
      .O               (s_gt_ref_clk_buf),
      .ODIV2           (),
      .CEB             (tied_to_ground_i),
      .I               (gt_ref_clk_pad_p_i),
      .IB              (gt_ref_clk_pad_n_i)
  );



  // Instantiate a MMCM module to divide the reference clock. Uses internal feedback
  // for improved jitter performance, and to avoid consuming an additional BUFG

  gt_clock_module #
  (
    .MULT                           (33.0),
    .DIVIDE                         (8),
    .CLK_PERIOD                     (6.4),
    .OUT0_DIVIDE                    (2.0),
    .OUT1_DIVIDE                    (1),
    .OUT2_DIVIDE                    (1),
    .OUT3_DIVIDE                    (1)
  )
  txoutclk_mmcm0_i
  (
    .CLK0_OUT                       (s_tx_usr_clk_buf),
    .CLK1_OUT                       (),
    .CLK2_OUT                       (),
    .CLK3_OUT                       (),
    .CLK_IN                         (tx_out_clk_i[MASTER_LANE_ID]),
    .MMCM_LOCKED_OUT                (s_tx_out_clk_mmcm_locked),
    .MMCM_RESET_IN                  (tx_mmcm_reset_i[MASTER_LANE_ID])
  );


  BUFG rxoutclk_bufg1_i
  (
    .I                              (rx_out_clk_i[MASTER_LANE_ID]),
    .O                              (s_rx_usr_clk_buf)
  );

  generate
  genvar i;
  for(i = 0; i < NUMBER_OF_LANES; i = i + 1) begin : g_cb //clk buffer
    assign  tx_usr_clk_o[i]    = s_tx_usr_clk_buf;
    assign  tx_usr_clk2_o[i]   = s_tx_usr_clk_buf;
    assign  tx_clk_lock_o[i]   = s_tx_out_clk_mmcm_locked;
    assign  rx_usr_clk_o[i]    = s_rx_usr_clk_buf;
    assign  rx_usr_clk2_o[i]   = s_rx_usr_clk_buf;
  end
  endgenerate

endmodule
