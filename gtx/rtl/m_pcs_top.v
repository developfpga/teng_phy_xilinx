//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define DLY #1

//(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
//(* CORE_GENERATION_INFO = "gtwizard_0,gtwizard_v3_6_9,{protocol_file=Start_from_scratch}" *)
module m_pcs_top #
(
  parameter NUM_OF_LANE                 = 1,
  parameter SIM_GTRESET_SPEEDUP         =   "TRUE",    // simulation setting for GT SecureIP model
  parameter STABLE_CLOCK_PERIOD         = 16,

  parameter P_SCRAMBLE_LOOPBACK         = 1'b0,
  parameter P_GEARBOX_LOOPBACK          = 1'b0

)
(
  input                           refclk_n_i,
  input                           refclk_p_i,
  input   [NUM_OF_LANE*1-1:0]     gthrxn_i,
  input   [NUM_OF_LANE*1-1:0]     gthrxp_i,
  output  [NUM_OF_LANE*1-1:0]     gthtxn_o,
  output  [NUM_OF_LANE*1-1:0]     gthtxp_o,

  // User-provided ports for reset helper block(s)
  input                           drp_clk_i,
  input                           areset_i,
  output  [NUM_OF_LANE*1-1:0]     linkup_o,
  // AXIS tx
  output  [NUM_OF_LANE*1-1:0]     tx_user_clk_o,
  output  [NUM_OF_LANE*1-1:0]     tx_user_rst_o,
  input   [NUM_OF_LANE*31-1:0]    tx_data_i,
  input   [NUM_OF_LANE*2-1:0]     tx_vldb_i,
  input   [NUM_OF_LANE*1-1:0]     tx_valid_i,
  output  [NUM_OF_LANE*1-1:0]     tx_ready_o,
  input   [NUM_OF_LANE*1-1:0]     tx_last_i,
  input   [NUM_OF_LANE*1-1:0]     tx_user_i,

  output  [NUM_OF_LANE*1-1:0]     tx_status_o,
  output  [NUM_OF_LANE*1-1:0]     tx_rsp_valid_o,
  // AXIS rx
  output  [NUM_OF_LANE*1-1:0]     rx_user_clk_o,
  output  [NUM_OF_LANE*1-1:0]     rx_user_rst_o,
  output  [NUM_OF_LANE*31-1:0]    rx_data_o,
  output  [NUM_OF_LANE*2-1:0]     rx_vldb_o,
  output  [NUM_OF_LANE*1-1:0]     rx_valid_o,
  output  [NUM_OF_LANE*1-1:0]     rx_last_o,
  output  [NUM_OF_LANE*1-1:0]     rx_user_o

);
  `include "xgmii_includes.vh"
  // ===========================================================================
  //         Parameter
  // ===========================================================================

  wire s_soft_reset;

//************************** Register Declarations ****************************

    wire            gt_txfsmresetdone_i;
    wire            gt_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r2;
    wire            gt0_txfsmresetdone_i;
    wire            gt0_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r3;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_vio_r3;

    reg [5:0] reset_counter = 0;
    reg     [3:0]   reset_pulse;

//**************************** Wire Declarations ******************************//
    //------------------------ GT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GT0  (X1Y8)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt0_drpaddr_i;
    wire    [15:0]  gt0_drpdi_i;
    wire    [15:0]  gt0_drpdo_i;
    wire            gt0_drpen_i;
    wire            gt0_drprdy_i;
    wire            gt0_drpwe_i;
    //------------------------- Digital Monitor Ports --------------------------
    wire    [7:0]   gt0_dmonitorout_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt0_eyescanreset_i;
    wire            gt0_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt0_eyescandataerror_i;
    wire            gt0_eyescantrigger_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [31:0]  gt0_rxdata_i;
    //------------------------- Receive Ports - RX AFE -------------------------
    wire            gt0_gtxrxp_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt0_gtxrxn_i;
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    wire            gt0_rxdlysreset_i;
    wire            gt0_rxdlysresetdone_i;
    wire            gt0_rxphaligndone_i;
    wire            gt0_rxphdlyreset_i;
    wire    [4:0]   gt0_rxphmonitor_i;
    wire    [4:0]   gt0_rxphslipmonitor_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt0_rxdfelpmreset_i;
    wire    [6:0]   gt0_rxmonitorout_i;
    wire    [1:0]   gt0_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt0_rxoutclk_i;
    wire            gt0_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt0_gtrxreset_i;
    wire            gt0_rxpmareset_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt0_rxresetdone_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt0_gttxreset_i;
    wire            gt0_txuserrdy_i;
    //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
    wire            gt0_txdlyen_i;
    wire            gt0_txdlysreset_i;
    wire            gt0_txdlysresetdone_i;
    wire            gt0_txphalign_i;
    wire            gt0_txphaligndone_i;
    wire            gt0_txphalignen_i;
    wire            gt0_txphdlyreset_i;
    wire            gt0_txphinit_i;
    wire            gt0_txphinitdone_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [31:0]  gt0_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt0_gtxtxn_i;
    wire            gt0_gtxtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt0_txoutclk_i;
    wire            gt0_txoutclkfabric_i;
    wire            gt0_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt0_txresetdone_i;

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt0_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt0_qplllock_i;
    wire            gt0_qpllrefclklost_i;
    wire            gt0_qpllreset_i;


    //----------------------------- Global Signals -----------------------------

    wire            DRPCLK_IN;
    wire            gt0_tx_system_reset_c;
    wire            gt0_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            GTTXRESET_IN;
    wire            GTRXRESET_IN;
    wire            QPLLRESET_IN;

     //--------------------------- User Clocks ---------------------------------
     wire            gt0_txusrclk_i;
     wire            gt0_txusrclk2_i;
     wire            gt0_rxusrclk_i;
     wire            gt0_rxusrclk2_i;
    wire            gt0_txmmcm_lock_i;
    wire            gt0_txmmcm_reset_i;

    //--------------------------- Reference Clocks ----------------------------

    wire            q2_clk1_refclk_i;


    //--------------------- Frame check/gen Module Signals --------------------
    wire            gt0_matchn_i;

    wire    [3:0]   gt0_txcharisk_float_i;

    wire    [15:0]  gt0_txdata_float16_i;
    wire    [31:0]  gt0_txdata_float_i;


    wire            gt0_block_sync_i;
    wire            gt0_track_data_i;
    wire    [7:0]   gt0_error_count_i;
    wire            gt0_inc_in_i;
    wire            gt0_inc_out_i;
    wire    [31:0]  gt0_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;


    //--------------------- Chipscope Signals ---------------------------------
    (*mark_debug = "TRUE" *)wire   rxresetdone_vio_i;
    wire    [35:0]  tx_data_vio_control_i;
    wire    [35:0]  rx_data_vio_control_i;
    wire    [35:0]  shared_vio_control_i;
    wire    [35:0]  ila_control_i;
    wire    [35:0]  channel_drp_vio_control_i;
    wire    [35:0]  common_drp_vio_control_i;
    wire    [31:0]  tx_data_vio_async_in_i;
    wire    [31:0]  tx_data_vio_sync_in_i;
    wire    [31:0]  tx_data_vio_async_out_i;
    wire    [31:0]  tx_data_vio_sync_out_i;
    wire    [31:0]  rx_data_vio_async_in_i;
    wire    [31:0]  rx_data_vio_sync_in_i;
    wire    [31:0]  rx_data_vio_async_out_i;
    wire    [31:0]  rx_data_vio_sync_out_i;
    wire    [31:0]  shared_vio_in_i;
    wire    [31:0]  shared_vio_out_i;
    wire    [163:0] ila_in_i;
    wire    [31:0]  channel_drp_vio_async_in_i;
    wire    [31:0]  channel_drp_vio_sync_in_i;
    wire    [31:0]  channel_drp_vio_async_out_i;
    wire    [31:0]  channel_drp_vio_sync_out_i;
    wire    [31:0]  common_drp_vio_async_in_i;
    wire    [31:0]  common_drp_vio_sync_in_i;
    wire    [31:0]  common_drp_vio_async_out_i;
    wire    [31:0]  common_drp_vio_sync_out_i;

    wire    [31:0]  gt0_tx_data_vio_async_in_i;
    wire    [31:0]  gt0_tx_data_vio_sync_in_i;
    wire    [31:0]  gt0_tx_data_vio_async_out_i;
    wire    [31:0]  gt0_tx_data_vio_sync_out_i;
    wire    [31:0]  gt0_rx_data_vio_async_in_i;
    wire    [31:0]  gt0_rx_data_vio_sync_in_i;
    wire    [31:0]  gt0_rx_data_vio_async_out_i;
    wire    [31:0]  gt0_rx_data_vio_sync_out_i;
    wire    [163:0] gt0_ila_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_in_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_out_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_out_i;
    wire    [31:0]  gt0_common_drp_vio_async_in_i;
    wire    [31:0]  gt0_common_drp_vio_sync_in_i;
    wire    [31:0]  gt0_common_drp_vio_async_out_i;
    wire    [31:0]  gt0_common_drp_vio_sync_out_i;


    wire            gttxreset_i;
    wire            gtrxreset_i;

    wire            user_tx_reset_i;
    wire            user_rx_reset_i;
    wire            tx_vio_clk_i;
    wire            tx_vio_clk_mux_out_i;
    wire            rx_vio_ila_clk_i;
    wire            rx_vio_ila_clk_mux_out_i;

    wire            qpllreset_i;



  wire [(80 -32) -1:0] zero_vector_rx_80 ;
  wire [(8 -4) -1:0] zero_vector_rx_8 ;
  wire [79:0] gt0_rxdata_ila ;
  wire [1:0]  gt0_rxdatavalid_ila;
  wire [7:0]  gt0_rxcharisk_ila ;
  wire gt0_txmmcm_lock_ila ;
  wire gt0_rxmmcm_lock_ila ;
  wire gt0_rxresetdone_ila ;
  wire gt0_txresetdone_ila ;
  // ===========================================================================
  //         register & wire
  // ===========================================================================
  wire          [31:0]      s_gt_rx_data;
  wire          [31:0]      s_rx_data;
  wire          [ 5:0]      s_rx_head;
  wire          [ 1:0]      s_rx_head_valid;

  wire [0:0] rxgearboxslip_int;
  wire [31:0] txdata_int;
  wire [5:0] txheader_int;
  wire [6:0] txsequence_int;

  wire [1:0] rxdatavalid_int;
  wire [31:0] rxdata_int;
  wire [1:0] rxheader_int;
  wire       rxheadervalid_int;
//**************************** Main Body of Code *******************************

    //  Static signal Assigments
    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 8'hff;

    assign zero_vector_rx_80 = 0;
    assign zero_vector_rx_8 = 0;


assign  q2_clk1_refclk_i                     =  1'b0;

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
  if(P_SCRAMBLE_LOOPBACK == 0 && P_GEARBOX_LOOPBACK == 0) begin : g_gtwizard_on
    gtwizard_0_support #
    (
      .SIM_GTRESET_SPEEDUP            (SIM_GTRESET_SPEEDUP),
      .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD)
    )
    gtwizard_0_support_i
    (
      .soft_reset_tx_in               (s_soft_reset),
      .soft_reset_rx_in               (s_soft_reset),
      .dont_reset_on_data_error_in    (tied_to_ground_i),
      .q2_clk1_gtrefclk_pad_n_in      (refclk_n_i),
      .q2_clk1_gtrefclk_pad_p_in      (refclk_p_i),
      .gt0_tx_mmcm_lock_out           (gt0_txmmcm_lock_i),
      .gt0_tx_fsm_reset_done_out      (gt0_txfsmresetdone_i),
      .gt0_rx_fsm_reset_done_out      (gt0_rxfsmresetdone_i),
      .gt0_data_valid_in              (gt0_track_data_i),

      .gt0_txusrclk_out               (gt0_txusrclk_i),
      .gt0_txusrclk2_out              (gt0_txusrclk2_i),
      .gt0_rxusrclk_out               (gt0_rxusrclk_i),
      .gt0_rxusrclk2_out              (gt0_rxusrclk2_i),


      //_____________________________________________________________________
      //_____________________________________________________________________
      //GT0  (X1Y8)

      //-------------------------- Channel - DRP Ports  --------------------------
      .gt0_drpaddr_in                 (gt0_drpaddr_i),
      .gt0_drpdi_in                   (gt0_drpdi_i),
      .gt0_drpdo_out                  (gt0_drpdo_i),
      .gt0_drpen_in                   (gt0_drpen_i),
      .gt0_drprdy_out                 (gt0_drprdy_i),
      .gt0_drpwe_in                   (gt0_drpwe_i),
      //------------------------- Digital Monitor Ports --------------------------
      .gt0_dmonitorout_out            (gt0_dmonitorout_i),
      //------------------- RX Initialization and Reset Ports --------------------
      .gt0_eyescanreset_in            (tied_to_ground_i),
      .gt0_rxuserrdy_in               (tied_to_vcc_i),
      //------------------------ RX Margin Analysis Ports ------------------------
      .gt0_eyescandataerror_out       (gt0_eyescandataerror_i),
      .gt0_eyescantrigger_in          (tied_to_ground_i),
      //---------------- Receive Ports - FPGA RX interface Ports -----------------
      .gt0_rxdata_out                 (gt0_rxdata_i),
      //------------------------- Receive Ports - RX AFE -------------------------
      .gt0_gtxrxp_in                  (gthrxp_i),
      //---------------------- Receive Ports - RX AFE Ports ----------------------
      .gt0_gtxrxn_in                  (gthrxn_i),
      //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
      .gt0_rxphmonitor_out            (gt0_rxphmonitor_i),
      .gt0_rxphslipmonitor_out        (gt0_rxphslipmonitor_i),
      //------------------- Receive Ports - RX Equalizer Ports -------------------
      .gt0_rxdfelpmreset_in           (tied_to_ground_i),
      .gt0_rxmonitorout_out           (gt0_rxmonitorout_i),
      .gt0_rxmonitorsel_in            (2'b00),
      //------------- Receive Ports - RX Fabric Output Control Ports -------------
      .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_i),
      //----------- Receive Ports - RX Initialization and Reset Ports ------------
      .gt0_gtrxreset_in               (tied_to_ground_i),
      .gt0_rxpmareset_in              (gt0_rxpmareset_i),
      //------------ Receive Ports -RX Initialization and Reset Ports ------------
      .gt0_rxresetdone_out            (gt0_rxresetdone_i),
      //------------------- TX Initialization and Reset Ports --------------------
      .gt0_gttxreset_in               (tied_to_ground_i),
      .gt0_txuserrdy_in               (tied_to_vcc_i),
      //---------------- Transmit Ports - TX Data Path interface -----------------
      .gt0_txdata_in                  (bit32_rev(gt0_txdata_i)),
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .gt0_gtxtxn_out                 (gthtxn_o),
      .gt0_gtxtxp_out                 (gthtxp_o),
      //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i),
      .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i),
      //----------- Transmit Ports - TX Initialization and Reset Ports -----------
      .gt0_txresetdone_out            (gt0_txresetdone_i),


      //____________________________COMMON PORTS________________________________
      .gt0_qplllock_out               (),
      .gt0_qpllrefclklost_out         (),
      .gt0_qplloutclk_out             (),
      .gt0_qplloutrefclk_out          (),
      .sysclk_in                      (drp_clk_i)
      );

  end else begin : g_gtwizard_off
    gtwizard_0_support #
    (
      .SIM_GTRESET_SPEEDUP            (SIM_GTRESET_SPEEDUP),
      .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD)
    )
    gtwizard_0_support_i
    (
      .soft_reset_tx_in               (s_soft_reset),
      .soft_reset_rx_in               (s_soft_reset),
      .dont_reset_on_data_error_in    (tied_to_ground_i),
      .q2_clk1_gtrefclk_pad_n_in      (refclk_n_i),
      .q2_clk1_gtrefclk_pad_p_in      (refclk_p_i),
      .gt0_tx_mmcm_lock_out           (gt0_txmmcm_lock_i),
      .gt0_tx_fsm_reset_done_out      (),
      .gt0_rx_fsm_reset_done_out      (),
      .gt0_data_valid_in              (gt0_track_data_i),

      .gt0_txusrclk_out               (gt0_txusrclk_i),
      .gt0_txusrclk2_out              (gt0_txusrclk2_i),
      .gt0_rxusrclk_out               (gt0_rxusrclk_i),
      .gt0_rxusrclk2_out              (),


      //_____________________________________________________________________
      //_____________________________________________________________________
      //GT0  (X1Y8)

      //-------------------------- Channel - DRP Ports  --------------------------
      .gt0_drpaddr_in                 (gt0_drpaddr_i),
      .gt0_drpdi_in                   (gt0_drpdi_i),
      .gt0_drpdo_out                  (gt0_drpdo_i),
      .gt0_drpen_in                   (gt0_drpen_i),
      .gt0_drprdy_out                 (gt0_drprdy_i),
      .gt0_drpwe_in                   (gt0_drpwe_i),
      //------------------------- Digital Monitor Ports --------------------------
      .gt0_dmonitorout_out            (gt0_dmonitorout_i),
      //------------------- RX Initialization and Reset Ports --------------------
      .gt0_eyescanreset_in            (tied_to_ground_i),
      .gt0_rxuserrdy_in               (tied_to_vcc_i),
      //------------------------ RX Margin Analysis Ports ------------------------
      .gt0_eyescandataerror_out       (gt0_eyescandataerror_i),
      .gt0_eyescantrigger_in          (tied_to_ground_i),
      //---------------- Receive Ports - FPGA RX interface Ports -----------------
      .gt0_rxdata_out                 (gt0_rxdata_i),
      //------------------------- Receive Ports - RX AFE -------------------------
      .gt0_gtxrxp_in                  (gthrxp_i),
      //---------------------- Receive Ports - RX AFE Ports ----------------------
      .gt0_gtxrxn_in                  (gthrxn_i),
      //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
      .gt0_rxphmonitor_out            (gt0_rxphmonitor_i),
      .gt0_rxphslipmonitor_out        (gt0_rxphslipmonitor_i),
      //------------------- Receive Ports - RX Equalizer Ports -------------------
      .gt0_rxdfelpmreset_in           (tied_to_ground_i),
      .gt0_rxmonitorout_out           (gt0_rxmonitorout_i),
      .gt0_rxmonitorsel_in            (2'b00),
      //------------- Receive Ports - RX Fabric Output Control Ports -------------
      .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_i),
      //----------- Receive Ports - RX Initialization and Reset Ports ------------
      .gt0_gtrxreset_in               (tied_to_ground_i),
      .gt0_rxpmareset_in              (gt0_rxpmareset_i),
      //------------ Receive Ports -RX Initialization and Reset Ports ------------
      .gt0_rxresetdone_out            (),
      //------------------- TX Initialization and Reset Ports --------------------
      .gt0_gttxreset_in               (tied_to_ground_i),
      .gt0_txuserrdy_in               (tied_to_vcc_i),
      //---------------- Transmit Ports - TX Data Path interface -----------------
      .gt0_txdata_in                  (bit32_rev(gt0_txdata_i)),
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .gt0_gtxtxn_out                 (gthtxn_o),
      .gt0_gtxtxp_out                 (gthtxp_o),
      //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i),
      .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i),
      //----------- Transmit Ports - TX Initialization and Reset Ports -----------
      .gt0_txresetdone_out            (),


      //____________________________COMMON PORTS________________________________
      .gt0_qplllock_out               (),
      .gt0_qpllrefclklost_out         (),
      .gt0_qplloutclk_out             (),
      .gt0_qplloutrefclk_out          (),
      .sysclk_in                      (drp_clk_i)
      );
    reg [7:0] rx_clk_count = 'd0;
    reg [7:0] tx_clk_count = 'd0;

    assign  gt0_rxusrclk2_i = gt0_txusrclk2_i;
    always @(posedge gt0_rxusrclk2_i) begin
      if(~rx_clk_count[7]) begin
        rx_clk_count  <= rx_clk_count + 8'd1;
      end
    end

    always @(posedge gt0_txusrclk2_i) begin
      if(~tx_clk_count[7]) begin
        tx_clk_count  <= tx_clk_count + 8'd1;
      end
    end
    assign  gt0_rxfsmresetdone_i  = rx_clk_count[7];
    assign  gt0_txfsmresetdone_i  = tx_clk_count[7];
    assign  gt0_rxresetdone_i     = rx_clk_count[7];
    assign  gt0_txresetdone_i     = tx_clk_count[7];
  end
  endgenerate


    //***********************************************************************//
    //                                                                       //
    //--------------------------- User Module Resets-------------------------//
    //                                                                       //
    //***********************************************************************//
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high.
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected
    // to the reset of the modules

always @(posedge gt0_rxusrclk2_i or negedge gt0_rxresetdone_i)

    begin
        if (!gt0_rxresetdone_i)
        begin
            gt0_rxresetdone_r    <=   `DLY 1'b0;
            gt0_rxresetdone_r2   <=   `DLY 1'b0;
            gt0_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_rxresetdone_r    <=   `DLY gt0_rxresetdone_i;
            gt0_rxresetdone_r2   <=   `DLY gt0_rxresetdone_r;
            gt0_rxresetdone_r3   <=   `DLY gt0_rxresetdone_r2;
        end
    end

always @(posedge  gt0_rxusrclk2_i or negedge gt0_rxfsmresetdone_i)

    begin
        if (!gt0_rxfsmresetdone_i)
        begin
            gt0_rxfsmresetdone_r    <=   `DLY 1'b0;
            gt0_rxfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_rxfsmresetdone_r    <=   `DLY gt0_rxfsmresetdone_i;
            gt0_rxfsmresetdone_r2   <=   `DLY gt0_rxfsmresetdone_r;
        end
    end



always @(posedge  gt0_txusrclk2_i or negedge gt0_txfsmresetdone_i)

    begin
        if (!gt0_txfsmresetdone_i)
        begin
            gt0_txfsmresetdone_r    <=   `DLY 1'b0;
            gt0_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_txfsmresetdone_r    <=   `DLY gt0_txfsmresetdone_i;
            gt0_txfsmresetdone_r2   <=   `DLY gt0_txfsmresetdone_r;
        end
    end


    // gt0_frame_check0 is always connected to the lane with the start of char
    // and this lane starts off the data checking on all the other lanes. The INC_IN port is tied off
    assign gt0_inc_in_i = 1'b0;

//-------------------------------------------------------------------------------------

  assign  tx_user_clk_o = gt0_txusrclk2_i;
  assign  tx_user_rst_o = ~gt0_txfsmresetdone_r2;

  tx u_tx (
    // Clks and resets
    .clk_i          (gt0_txusrclk2_i),
    .rst_i          (~gt0_txfsmresetdone_r2),

    // XGMII
    .data_o         (txdata_int),
    .head_o         (txheader_int),
    .sequence_o     (txsequence_int),

    // AXIS
    .tdata_i        (tx_data_i),
    .tvldb_i        (tx_vldb_i),
    .tvalid_i       (tx_valid_i),
    .tready_o       (tx_ready_o),
    .tlast_i        (tx_last_i),
    .tuser_i        (tx_user_i),

    .tx_status_o    (tx_status_o   ),
    .tx_rsp_valid_o (tx_rsp_valid_o)
  );
  gearbox_66b_64b u_gearbox_66_64 (

    // Clks and resets
    .clk_i          (gt0_txusrclk2_i),
    .rst_i          (~gt0_txfsmresetdone_r2),

    .data_i         (txdata_int),
    .head_i         (txheader_int[1:0]),
    .sequence_i     (txsequence_int),

    .data_o         (gt0_txdata_i)
  );


  generate
    if(P_GEARBOX_LOOPBACK == 1) begin : g_gearbox_loopback_on
      assign  s_gt_rx_data = gt0_txdata_i;
    end else begin : g_gearbox_loopback_off
      assign  s_gt_rx_data = bit32_rev(gt0_rxdata_i);
    end
  endgenerate

  assign  rx_user_clk_o = gt0_rxusrclk2_i;
  assign  rx_user_rst_o = ~gt0_rxfsmresetdone_r2;
  gearbox_64b_66b u_gearbox_64_66 (

    // Clks and resets
    .clk_i          (gt0_rxusrclk2_i),
    .rst_i          (~gt0_rxfsmresetdone_r2),

    .data_o         (rxdata_int),
    .head_o         (rxheader_int),
    .head_valid_o   (rxheadervalid_int),
    .slip_i         (rxgearboxslip_int),

    .data_i         (s_gt_rx_data)
    // .data_i         (gtwiz_userdata_tx_int)
  );

  generate
    if(P_SCRAMBLE_LOOPBACK == 1) begin : g_scramble_loopback_on
      assign  s_rx_data         = txdata_int;
      assign  s_rx_head         = txheader_int;
      assign  s_rx_head_valid   = {1'b0, ~txsequence_int[0] & ~txsequence_int[6]};
    end else begin : g_scramble_loopback_off
      assign  s_rx_data         = rxdata_int;
      assign  s_rx_head         = {4'b0, rxheader_int};
      assign  s_rx_head_valid   = {1'b0, rxheadervalid_int};
    end
  endgenerate



  rx u_rx (
    // Clks and resets
    .clk_i          (gt0_rxusrclk2_i),
    .rst_i          (~gt0_rxfsmresetdone_r2),

    // PCS
    .data_i         (s_rx_data),
    .head_i         (s_rx_head),
    .head_valid_i   (s_rx_head_valid),
    .slip_o         (rxgearboxslip_int),

    // AXIS
    .tdata_o        (rx_data_o),
    .tvldb_o        (rx_vldb_o),
    .tvalid_o       (rx_valid_o),
    .tlast_o        (rx_last_o),
    .tuser_o        (rx_user_o)
  );



//-------------------------Debug Signals assignment--------------------

//------------ optional Ports assignments --------------
//------GTH/GTP
  assign  gt0_rxdfelpmreset_i                  =  tied_to_ground_i;
  assign  gt0_rxpmareset_i                     =  tied_to_ground_i;
//------------------------------------------------------
  // assign resets for frame_gen modules
  assign  gt0_tx_system_reset_c = !gt0_txfsmresetdone_r2;

  // assign resets for frame_check modules
  assign  gt0_rx_system_reset_c = !gt0_rxfsmresetdone_r2;

  assign gt0_drpaddr_i = 9'd0;
  assign gt0_drpdi_i = 16'd0;
  assign gt0_drpen_i = 1'b0;
  assign gt0_drpwe_i = 1'b0;
  assign s_soft_reset = areset_i;

endmodule


