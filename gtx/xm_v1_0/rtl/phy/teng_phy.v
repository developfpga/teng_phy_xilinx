//
//  By David
//
//  2019.4.3
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

module teng_phy #
(
  parameter CHOOSE_REFCLK0                  = 1,
  parameter NUMBER_OF_LANES                 = 2,
  parameter MASTER_LANE_ID                  = 0,
  parameter SIM_GTRESET_SPEEDUP             = "TRUE",     // Simulation setting for GT SecureIP model
  parameter SIMULATION                      =  0,         // Set to 1 for simulation
  parameter STABLE_CLOCK_PERIOD             = 10         //Period of the stable clock driving this state-machine, unit is [ns]

)
(
  input                             sys_clk_i,
  input                             soft_reset_tx_i,
  input                             soft_reset_rx_i,
  input                             gt_ref_clk_pad_n_i,
  input                             gt_ref_clk_pad_p_i,
  input                             dont_reset_on_data_error_i,
  input   [NUMBER_OF_LANES-1:0]     data_valid_i,//rx数据稳定，在100us之内不稳定，且DONT_RESET_ON_DATA_ERROR为0会整体复位
  // input   [NUMBER_OF_LANES-1:0]     tx_mmcm_lock_i,
  // output  [NUMBER_OF_LANES-1:0]     tx_mmcm_reset_o,
  //---------------- Receive Ports - FPGA RX interface Ports -----------------
  output                            rx_user_clk_o,
  output                            rx_fsm_reset_done_o,
  output  [NUMBER_OF_LANES*32-1:0]  rx_data_o,
  input   [NUMBER_OF_LANES-1:0]     gtx_rxp_i,
  input   [NUMBER_OF_LANES-1:0]     gtx_rxn_i,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  output                            tx_user_clk_o,
  output                            tx_fsm_reset_done_o,
  input   [NUMBER_OF_LANES*32-1:0]  tx_data_i,
  output  [NUMBER_OF_LANES-1:0]     gtx_txp_o,
  output  [NUMBER_OF_LANES-1:0]     gtx_txn_o

);
  localparam GTREFCLKSEL = CHOOSE_REFCLK0 ? 3'b001 : 3'b010;

//**************************** Main Body of Code *******************************
  wire    [NUMBER_OF_LANES-1:0]   s_tx_usr_clk;//TXUSRCLK_OUT,
  wire    [NUMBER_OF_LANES-1:0]   s_tx_usr_clk2;//TXUSRCLK2_OUT,
  wire    [NUMBER_OF_LANES-1:0]   s_tx_out_clk;//TXOUTCLK_IN,
  wire    [NUMBER_OF_LANES-1:0]   s_tx_clk_lock;//TXCLK_LOCK_OUT,
  wire    [NUMBER_OF_LANES-1:0]   s_tx_mmcm_reset;//TX_MMCM_RESET_IN,
  wire    [NUMBER_OF_LANES-1:0]   s_rx_usr_clk;//RXUSRCLK_OUT,
  wire    [NUMBER_OF_LANES-1:0]   s_rx_usr_clk2;//RXUSRCLK2_OUT,
  wire    [NUMBER_OF_LANES-1:0]   s_rx_out_clk;//RXOUTCLK_IN,
  wire    s_qpll_lock;
  wire    s_qpll_ref_clk_lost;
  wire    s_gt_qpll_reset;
  wire    s_qpll_out_clk;
  wire    s_qpll_out_ref_clk;
  wire    s_common_reset;

  wire    [NUMBER_OF_LANES-1:0]   s_tx_fsm_reset_done;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_fsm_reset_done;
  // wire    [NUMBER_OF_LANES-1:0]   s_rx_usr_clk;
  // wire    [NUMBER_OF_LANES-1:0]   s_rx_usr_clk2;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_pcs_reset;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_pma_reset;
  // wire    [NUMBER_OF_LANES-1:0]   s_tx_usr_clk;
  // wire    [NUMBER_OF_LANES-1:0]   s_tx_usr_clk2;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_pcs_reset;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_pma_reset;
  //  Static signal Assigments
  assign  s_tied_to_ground             = 1'b0;
  assign  s_tied_to_ground_vec64       = 64'h0000000000000000;
  assign  s_tied_to_vcc                = 1'b1;
  assign  s_tied_to_vcc_vec8           = 8'hff;


  gt_usr_clk_source #(
    .NUMBER_OF_LANES                  (NUMBER_OF_LANES),
    .MASTER_LANE_ID                   (MASTER_LANE_ID)
  )
  u_gt_usr_clk_source(
    .tx_usr_clk_o                     (s_tx_usr_clk   ),//TXUSRCLK_OUT,
    .tx_usr_clk2_o                    (s_tx_usr_clk2  ),//TXUSRCLK2_OUT,
    .tx_out_clk_i                     (s_tx_out_clk   ),//TXOUTCLK_IN,
    .tx_clk_lock_o                    (s_tx_clk_lock  ),//TXCLK_LOCK_OUT,
    .tx_mmcm_reset_i                  (s_tx_mmcm_reset),//TX_MMCM_RESET_IN,
    .rx_usr_clk_o                     (s_rx_usr_clk   ),//RXUSRCLK_OUT,
    .rx_usr_clk2_o                    (s_rx_usr_clk2  ),//RXUSRCLK2_OUT,
    .rx_out_clk_i                     (s_rx_out_clk   ),//RXOUTCLK_IN,

    .gt_ref_clk_pad_n_i               (gt_ref_clk_pad_n_i),
    .gt_ref_clk_pad_p_i               (gt_ref_clk_pad_p_i),
    .gt_ref_clk_o                     (s_gt_ref_clk)

  );
  assign  rx_user_clk_o = s_rx_usr_clk2[MASTER_LANE_ID];
  assign  tx_user_clk_o = s_tx_usr_clk2[MASTER_LANE_ID];

  gt_common #
  (
   .WRAPPER_SIM_GTRESET_SPEEDUP(SIM_GTRESET_SPEEDUP),
   .SIM_QPLLREFCLK_SEL(GTREFCLKSEL)
  )
  u_common
  (
    .qpll_ref_clk_sel_i(GTREFCLKSEL),
    .gt_ref_clk0_i(s_gt_ref_clk),
    .gt_ref_clk1_i(s_tied_to_ground),
    .qpll_lock_o(s_qpll_lock),
    .qpll_lock_det_clk_i(sys_clk_i),
    .qpll_out_clk_o(s_qpll_out_clk),
    .qpll_out_ref_clk_o(s_qpll_out_ref_clk),
    .qpll_ref_clk_lost_o(s_qpll_ref_clk_lost),
    .qpll_reset_i(s_qpll_reset)

  );
  assign  s_qpll_reset = s_gt_qpll_reset|s_common_reset;
  gt_common_reset #
  (
    .STABLE_CLOCK_PERIOD (STABLE_CLOCK_PERIOD)        // Period of the stable clock driving this state-machine, unit is [ns]
  )
  u_common_reset
  (
    .stable_clk_i(sys_clk_i),             //Stable Clock, either a stable clock from the PCB
    .soft_reset_i(soft_reset_tx_i),               //User Reset, can be pulled any time
    .common_reset_o(s_common_reset)              //Reset QPLL
  );



assign  s_rx_pcs_reset                     =  {NUMBER_OF_LANES{s_tied_to_ground}};
assign  s_rx_pma_reset                     =  {NUMBER_OF_LANES{s_tied_to_ground}};
assign  s_tx_pcs_reset                     =  {NUMBER_OF_LANES{s_tied_to_ground}};
assign  s_tx_pma_reset                     =  {NUMBER_OF_LANES{s_tied_to_ground}};

assign  tx_fsm_reset_done_o = s_tx_fsm_reset_done;
assign  rx_fsm_reset_done_o = s_rx_fsm_reset_done;

multi_lane_init  #
(
  .GTREFCLKSEL                      (GTREFCLKSEL        ),
  .NUMBER_OF_LANES                  (NUMBER_OF_LANES    ),
  .MASTER_LANE_ID                   (MASTER_LANE_ID     ),
  .SIM_GTRESET_SPEEDUP              (SIM_GTRESET_SPEEDUP),    // Simulation setting for GT SecureIP model
  .SIMULATION                       (SIMULATION         ),    // Set to 1 for simulation
  .STABLE_CLOCK_PERIOD              (STABLE_CLOCK_PERIOD)    //Period of the stable clock driving this state-machine, unit is [ns]

) u_multi_lane_init
(
  .sys_clk_i                        (sys_clk_i                  ),
  .soft_reset_tx_i                  (soft_reset_tx_i            ),
  .soft_reset_rx_i                  (soft_reset_rx_i            ),
  .dont_reset_on_data_error_i       (dont_reset_on_data_error_i ),
  .tx_fsm_reset_done_o              (s_tx_fsm_reset_done        ),
  .rx_fsm_reset_done_o              (s_rx_fsm_reset_done        ),
  .data_valid_i                     (data_valid_i               ),//rx数据稳定，在100us之内不稳定，且DONT_RESET_ON_DATA_ERROR为0会整体复位
  .tx_mmcm_lock_i                   (s_tx_clk_lock              ),
  .tx_mmcm_reset_o                  (s_tx_mmcm_reset            ),

  //____________________________CHANNEL PORTS________________________________
  //-------------------------- Channel - DRP Ports  --------------------------
  .drpaddr_i                        ({NUMBER_OF_LANES{9'b0}}),
  .drpclk_i                         ({NUMBER_OF_LANES{sys_clk_i}}),
  .drpdi_i                          ({NUMBER_OF_LANES{16'b0}}),
  .drpdo_o                          (),
  .drpen_i                          ({NUMBER_OF_LANES{1'b0}}),
  .drprdy_o                         (),
  .drpwe_i                          ({NUMBER_OF_LANES{1'b0}}),
  //------------------------- Digital Monitor Ports --------------------------
  .dmonitorout_o                    (),//不知道有什么用
  //----------------------------- Loopback Ports -----------------------------
  .loopback_i                       ({NUMBER_OF_LANES{3'b0}}),//不知道有什么用
  //--------------------------- PCI Express Ports ----------------------------
  .rxrate_i                         ({NUMBER_OF_LANES{3'b0}}),//不知道有什么用
  //------------------- RX Initialization and Reset Ports --------------------
  .eyescanreset_i                   ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  // input   [NUMBER_OF_LANES-1:0]     rx_user_rdy_o,
  //------------------------ RX Margin Analysis Ports ------------------------
  .eyescandataerror_o               (),//不知道有什么用
  .eyescantrigger_i                 ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  //----------------------- Receive Ports - CDR Ports ------------------------
  .rxcdrhold_i                      ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  //---------------- Receive Ports - FPGA RX Interface Ports -----------------
  .rxusrclk_i                       (s_rx_usr_clk),
  .rxusrclk2_i                      (s_rx_usr_clk2),
  //---------------- Receive Ports - FPGA RX interface Ports -----------------
  .rxdata_o                         (rx_data_o),
  //------------------------- Receive Ports - RX AFE -------------------------
  .gtxrxp_i                         (gtx_rxp_i),
  .gtxrxn_i                         (gtx_rxn_i),
  //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
  .rxbufreset_i                     ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  .rxbufstatus_o                    (),//不知道有什么用
  // input   [NUMBER_OF_LANES-1:0]     rxdlyen_i,
  // input   [NUMBER_OF_LANES-1:0]     rxdlysreset_i,
  // output  [NUMBER_OF_LANES-1:0]     rxdlysresetdone_o,
  // input   [NUMBER_OF_LANES-1:0]     rxphalign_i,
  // output  [NUMBER_OF_LANES-1:0]     rxphaligndone_o,
  // input   [NUMBER_OF_LANES-1:0]     rxphalignen_i,
  // input   [NUMBER_OF_LANES-1:0]     rxphdlyreset_i,
  .rxphmonitor_o                    (),//不知道有什么用
  .rxphslipmonitor_o                (),//不知道有什么用
  //------------------- Receive Ports - RX Equalizer Ports -------------------
  // input   [NUMBER_OF_LANES-1:0]     rxdfeagchold_i,
  // input   [NUMBER_OF_LANES-1:0]     rxdfelfhold_i,
  .rxdfelpmreset_i                  ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  .rxmonitorout_o                   (),//不知道有什么用
  .rxmonitorsel_i                   ({NUMBER_OF_LANES{2'b0}}),//不知道有什么用
  //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
  .rxratedone_o                     (),//不知道有什么用
  //------------- Receive Ports - RX Fabric Output Control Ports -------------
  .rxoutclk_o                       (s_rx_out_clk),
  .rxoutclkfabric_o                 (),
  //----------- Receive Ports - RX Initialization and Reset Ports ------------
  // input   [NUMBER_OF_LANES-1:0]     gtrxreset_i,
  .rxpcsreset_i                     (s_rx_pcs_reset),
  .rxpmareset_i                     (s_rx_pma_reset),
  //---------------- Receive Ports - RX Margin Analysis ports ----------------
  .rxlpmen_i                        ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  //--------------- Receive Ports - RX Polarity Control Ports ----------------
  .rxpolarity_i                     ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  //------------ Receive Ports -RX Initialization and Reset Ports ------------
  // output  [NUMBER_OF_LANES-1:0]     rxresetdone_o,
  //---------------------- TX Configurable Driver Ports ----------------------
  .txpostcursor_i                   ({NUMBER_OF_LANES{5'b0}}),//不知道有什么用
  .txprecursor_i                    ({NUMBER_OF_LANES{5'b0}}),//不知道有什么用
  //------------------- TX Initialization and Reset Ports --------------------
  // input   [NUMBER_OF_LANES-1:0]     gttxreset_i,
  // input   [NUMBER_OF_LANES-1:0]     txuserrdy_i,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  .txusrclk_i                       (s_tx_usr_clk),
  .txusrclk2_i                      (s_tx_usr_clk2),
  //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
  // input   [NUMBER_OF_LANES-1:0]     txdlyen_i,
  // input   [NUMBER_OF_LANES-1:0]     txdlysreset_i,
  // output  [NUMBER_OF_LANES-1:0]     txdlysresetdone_o,
  // input   [NUMBER_OF_LANES-1:0]     txphalign_i,
  // output  [NUMBER_OF_LANES-1:0]     txphaligndone_o,
  // input   [NUMBER_OF_LANES-1:0]     txphalignen_i,
  // input   [NUMBER_OF_LANES-1:0]     txphdlyreset_i,
  // input   [NUMBER_OF_LANES-1:0]     txphinit_i,
  // output  [NUMBER_OF_LANES-1:0]     txphinitdone_o,
  //-------------------- Transmit Ports - TX Buffer Ports --------------------
  .txbufstatus_o                    (),//不知道有什么用
  //------------- Transmit Ports - TX Configurable Driver Ports --------------
  .txdiffctrl_i                     ({NUMBER_OF_LANES{4'b0}}),//不知道有什么用
  .txinhibit_i                      ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用
  .txmaincursor_i                   ({NUMBER_OF_LANES{7'b0}}),//不知道有什么用
  //---------------- Transmit Ports - TX Data Path interface -----------------
  .txdata_i                         (tx_data_i),
  //-------------- Transmit Ports - TX Driver and OOB signaling --------------
  .gtxtxn_o                         (gtx_txn_o),
  .gtxtxp_o                         (gtx_txp_o),
  //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
  .txoutclk_o                       (s_tx_out_clk),
  .txoutclkfabric_o                 (),
  .txoutclkpcs_o                    (),
  //----------- Transmit Ports - TX Initialization and Reset Ports -----------
  .txpcsreset_i                     (s_tx_pcs_reset),
  .txpmareset_i                     (s_tx_pma_reset),
  // output  [NUMBER_OF_LANES-1:0]     txresetdone_o,
  //--------------- Transmit Ports - TX Polarity Control Ports ---------------
  .txpolarity_i                     ({NUMBER_OF_LANES{1'b0}}),//不知道有什么用

  //____________________________COMMON PORTS________________________________
  .qplllock_i                       (s_qpll_lock),
  .qpllrefclklost_i                 (s_qpll_ref_clk_lost),
  .qpllreset_o                      (s_gt_qpll_reset),
  .qplloutclk_i                     (s_qpll_out_clk),
  .qplloutrefclk_i                  (s_qpll_out_ref_clk)

);

endmodule



