//
//  By David
//
//  2019.4.3
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

module xm_top #
(
  parameter CHOOSE_REFCLK0                  = 1,
  parameter NUMBER_OF_LANES                 = 2,
  parameter MASTER_LANE_ID                  = 0,
  parameter SIM_GTRESET_SPEEDUP             = "TRUE",     // Simulation setting for GT SecureIP model
  parameter SIMULATION                      =  0,         // Set to 1 for simulation
  parameter STABLE_CLOCK_PERIOD             = 10,        //Period of the stable clock driving this state-machine, unit is [ns]

  parameter P_SCRAMBLE_LOOPBACK             = 1'b0,
  parameter P_GEARBOX_LOOPBACK              = 1'b0

)
(
  input                             ref_clk_n_i,
  input                             ref_clk_p_i,

  input   [NUMBER_OF_LANES-1:0]     gt_rxn_i,
  input   [NUMBER_OF_LANES-1:0]     gt_rxp_i,
  output  [NUMBER_OF_LANES-1:0]     gt_txn_o,
  output  [NUMBER_OF_LANES-1:0]     gt_txp_o,

  // User-provided ports for reset helper block(s)
  input                             sys_clk_i,
  input                             sys_reset_i,
  output  [NUMBER_OF_LANES-1:0]     link_up_o,
  // AXIS tx
  output                            tx_user_clk_o,
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
  output                            rx_user_clk_o,
  output                            rx_user_rst_o,
  output  [NUMBER_OF_LANES*32-1:0]  rx_data_o,
  output  [NUMBER_OF_LANES*2-1:0]   rx_vldb_o,
  output  [NUMBER_OF_LANES-1:0]     rx_valid_o,
  output  [NUMBER_OF_LANES-1:0]     rx_last_o,
  output  [NUMBER_OF_LANES-1:0]     rx_user_o

);
  `include "xgmii_includes.vh"
  // ===========================================================================
  //         Parameter
  // ===========================================================================


//************************** Register Declarations ****************************
  wire    s_rx_fsm_reset_done;
  wire    s_tx_fsm_reset_done;
  wire    [NUMBER_OF_LANES-1:0]     s_link_up;
  wire    [NUMBER_OF_LANES*32-1:0]  s_gt_rx_data;
  wire    [NUMBER_OF_LANES*32-1:0]  s_gt_tx_data;

//**************************** Main Body of Code *******************************


  //***********************************************************************//
  //                                                                       //
  //--------------------------- The GT Wrapper ----------------------------//
  //                                                                       //
  //***********************************************************************//

  // Use the instantiation template in the example directory to add the GT wrapper to your design.
  // In this example, the wrapper is wired up for basic operation with a frame generator and frame
  // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is
  // enabled, bonding should occur after alignment.
  // While connecting the GT TX/RX Reset ports below, please add a delay of
  // minimum 500ns as mentioned in AR 43482.

  generate
  if(P_SCRAMBLE_LOOPBACK == 0 && P_GEARBOX_LOOPBACK == 0) begin : g_gt_on
    teng_phy # (
      .CHOOSE_REFCLK0                   (CHOOSE_REFCLK0      ),
      .NUMBER_OF_LANES                  (NUMBER_OF_LANES     ),
      .MASTER_LANE_ID                   (MASTER_LANE_ID      ),
      .SIM_GTRESET_SPEEDUP              (SIM_GTRESET_SPEEDUP ),    // Simulation setting for GT SecureIP model
      .SIMULATION                       (SIMULATION          ),    // Set to 1 for simulation
      .STABLE_CLOCK_PERIOD              (STABLE_CLOCK_PERIOD )    //Period of the stable clock driving this state-machine, unit is [ns]

    ) u_teng_phy(
      .sys_clk_i                        (sys_clk_i),
      .soft_reset_tx_i                  (sys_reset_i),
      .soft_reset_rx_i                  (sys_reset_i),
      .gt_ref_clk_pad_n_i               (ref_clk_n_i),
      .gt_ref_clk_pad_p_i               (ref_clk_p_i),
      .dont_reset_on_data_error_i       (1'b1),
      .data_valid_i                     (s_link_up),//rx数据稳定，在100us之内不稳定，且DONT_RESET_ON_DATA_ERROR为0会整体复位
      //---------------- Receive Ports - FPGA RX interface Ports -----------------
      .rx_user_clk_o                    (rx_user_clk_o),
      .rx_fsm_reset_done_o              (s_rx_fsm_reset_done),
      .rx_data_o                        (s_gt_rx_data),
      .gtx_rxp_i                        (gt_rxp_i),
      .gtx_rxn_i                        (gt_rxn_i),
      //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
      .tx_user_clk_o                    (tx_user_clk_o),
      .tx_fsm_reset_done_o              (s_tx_fsm_reset_done),
      .tx_data_i                        (s_gt_tx_data),
      .gtx_txp_o                        (gt_txp_o),
      .gtx_txn_o                        (gt_txn_o)
    );

  // end else begin : g_gtwizard_off
  //       teng_phy # (
  //     .CHOOSE_REFCLK0                   (CHOOSE_REFCLK0      ),
  //     .NUMBER_OF_LANES                  (NUMBER_OF_LANES     ),
  //     .MASTER_LANE_ID                   (MASTER_LANE_ID      ),
  //     .SIM_GTRESET_SPEEDUP              (SIM_GTRESET_SPEEDUP ),    // Simulation setting for GT SecureIP model
  //     .SIMULATION                       (SIMULATION          ),    // Set to 1 for simulation
  //     .STABLE_CLOCK_PERIOD              (STABLE_CLOCK_PERIOD )    //Period of the stable clock driving this state-machine, unit is [ns]

  //   ) u_teng_phy(
  //     .sys_clk_i                        (sys_clk_i),
  //     .soft_reset_tx_i                  (sys_reset_i),
  //     .soft_reset_rx_i                  (sys_reset_i),
  //     .gt_ref_clk_pad_n_i               (ref_clk_n_i),
  //     .gt_ref_clk_pad_p_i               (ref_clk_p_i),
  //     .dont_reset_on_data_error_i       (1'b1),
  //     .data_valid_i                     (s_rx_data_lock),//rx数据稳定，在100us之内不稳定，且DONT_RESET_ON_DATA_ERROR为0会整体复位
  //     //---------------- Receive Ports - FPGA RX interface Ports -----------------
  //     .rx_user_clk_o                    (rx_user_clk_o),
  //     .rx_fsm_reset_done_o              (),
  //     .rx_data_o                        (rx_data_o),
  //     .gtx_rxp_i                        (gt_rxp_i),
  //     .gtx_rxn_i                        (gt_rxn_i),
  //     //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  //     .tx_user_clk_o                    (tx_user_clk_o),
  //     .tx_fsm_reset_done_o              (),
  //     .tx_data_i                        (tx_data_i),
  //     .gtx_txp_o                        (gt_txp_o),
  //     .gtx_txn_o                        (gt_txn_o)
  //   );
  //   reg [7:0] rx_clk_count = 'd0;
  //   reg [7:0] tx_clk_count = 'd0;

  //   assign  gt0_rxusrclk2_i = gt0_txusrclk2_i;
  //   always @(posedge gt0_rxusrclk2_i) begin
  //     if(~rx_clk_count[7]) begin
  //       rx_clk_count  <= rx_clk_count + 8'd1;
  //     end
  //   end

  //   always @(posedge gt0_txusrclk2_i) begin
  //     if(~tx_clk_count[7]) begin
  //       tx_clk_count  <= tx_clk_count + 8'd1;
  //     end
  //   end
  //   assign  s_rx_fsm_reset_done = rx_clk_count[7];
  //   assign  s_tx_fsm_reset_done = tx_clk_count[7];
  //   assign  gt0_rxresetdone_i = rx_clk_count[7];
  //   assign  gt0_txresetdone_i = tx_clk_count[7];
  end
  endgenerate

  teng_mac #(
    .NUMBER_OF_LANES                  (NUMBER_OF_LANES),
    .P_SCRAMBLE_LOOPBACK              (P_SCRAMBLE_LOOPBACK),
    .P_GEARBOX_LOOPBACK               (P_GEARBOX_LOOPBACK)
  )u_teng_mac(
    //---------------- Receive Ports - FPGA RX Interface Ports ----------------
    .rx_user_clk_i                    (rx_user_clk_o),
    .rx_fsm_reset_done_i              (s_rx_fsm_reset_done),
    .rx_data_i                        (s_gt_rx_data),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .tx_user_clk_i                    (tx_user_clk_o),
    .tx_fsm_reset_done_i              (s_tx_fsm_reset_done),
    .tx_data_o                        (s_gt_tx_data),

    .link_up_o                        (s_link_up),
    // AXIS tx
    .tx_user_rst_o                    (tx_user_rst_o),
    .tx_data_i                        (tx_data_i),
    .tx_vldb_i                        (tx_vldb_i),
    .tx_valid_i                       (tx_valid_i),
    .tx_ready_o                       (tx_ready_o),
    .tx_last_i                        (tx_last_i),
    .tx_user_i                        (tx_user_i),

    .tx_status_o                      (tx_status_o),
    .tx_rsp_valid_o                   (tx_rsp_valid_o),
    // AXIS rx
    .rx_user_rst_o                    (rx_user_rst_o),
    .rx_data_o                        (rx_data_o),
    .rx_vldb_o                        (rx_vldb_o),
    .rx_valid_o                       (rx_valid_o),
    .rx_last_o                        (rx_last_o),
    .rx_user_o                        (rx_user_o)
  );

endmodule

