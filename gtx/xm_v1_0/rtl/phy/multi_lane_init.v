//
//  By David
//
//  2019.3.28
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1
//***********************************Entity Declaration************************
module multi_lane_init #
(
  parameter GTREFCLKSEL                     = 3'b001,
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
  input                             dont_reset_on_data_error_i,
  output  [NUMBER_OF_LANES-1:0]     tx_fsm_reset_done_o,
  output  [NUMBER_OF_LANES-1:0]     rx_fsm_reset_done_o,
  input   [NUMBER_OF_LANES-1:0]     data_valid_i,//rx数据稳定，在100us之内不稳定，且DONT_RESET_ON_DATA_ERROR为0会整体复位
  input   [NUMBER_OF_LANES-1:0]     tx_mmcm_lock_i,
  output  [NUMBER_OF_LANES-1:0]     tx_mmcm_reset_o,

  //____________________________CHANNEL PORTS________________________________
  //-------------------------- Channel - DRP Ports  --------------------------
  input   [NUMBER_OF_LANES*9-1:0]   drpaddr_i,
  input   [NUMBER_OF_LANES-1:0]     drpclk_i,
  input   [16*NUMBER_OF_LANES-1:0]  drpdi_i,
  output  [16*NUMBER_OF_LANES-1:0]  drpdo_o,
  input   [NUMBER_OF_LANES-1:0]     drpen_i,
  output  [NUMBER_OF_LANES-1:0]     drprdy_o,
  input   [NUMBER_OF_LANES-1:0]     drpwe_i,
  //------------------------- Digital Monitor Ports --------------------------
  output  [NUMBER_OF_LANES*8-1:0]   dmonitorout_o,//不知道有什么用
  //----------------------------- Loopback Ports -----------------------------
  input   [NUMBER_OF_LANES*3-1:0]   loopback_i,//不知道有什么用
  //--------------------------- PCI Express Ports ----------------------------
  input   [NUMBER_OF_LANES*3-1:0]   rxrate_i,//不知道有什么用
  //------------------- RX Initialization and Reset Ports --------------------
  input   [NUMBER_OF_LANES-1:0]     eyescanreset_i,//不知道有什么用
  // input   [NUMBER_OF_LANES-1:0]     rx_user_rdy_o,
  //------------------------ RX Margin Analysis Ports ------------------------
  output  [NUMBER_OF_LANES-1:0]     eyescandataerror_o,//不知道有什么用
  input   [NUMBER_OF_LANES-1:0]     eyescantrigger_i,//不知道有什么用
  //----------------------- Receive Ports - CDR Ports ------------------------
  input   [NUMBER_OF_LANES-1:0]     rxcdrhold_i,//不知道有什么用
  //---------------- Receive Ports - FPGA RX Interface Ports -----------------
  input   [NUMBER_OF_LANES-1:0]     rxusrclk_i,
  input   [NUMBER_OF_LANES-1:0]     rxusrclk2_i,
  //---------------- Receive Ports - FPGA RX interface Ports -----------------
  output  [NUMBER_OF_LANES*32-1:0]  rxdata_o,
  //------------------------- Receive Ports - RX AFE -------------------------
  input   [NUMBER_OF_LANES-1:0]     gtxrxp_i,
  //---------------------- Receive Ports - RX AFE Ports ----------------------
  input   [NUMBER_OF_LANES-1:0]     gtxrxn_i,
  //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
  input   [NUMBER_OF_LANES-1:0]     rxbufreset_i,//不知道有什么用
  output  [NUMBER_OF_LANES*3-1:0]   rxbufstatus_o,//不知道有什么用
  // input   [NUMBER_OF_LANES-1:0]     rxdlyen_i,
  // input   [NUMBER_OF_LANES-1:0]     rxdlysreset_i,
  // output  [NUMBER_OF_LANES-1:0]     rxdlysresetdone_o,
  // input   [NUMBER_OF_LANES-1:0]     rxphalign_i,
  // output  [NUMBER_OF_LANES-1:0]     rxphaligndone_o,
  // input   [NUMBER_OF_LANES-1:0]     rxphalignen_i,
  // input   [NUMBER_OF_LANES-1:0]     rxphdlyreset_i,
  output  [NUMBER_OF_LANES*5-1:0]   rxphmonitor_o,//不知道有什么用
  output  [NUMBER_OF_LANES*5-1:0]   rxphslipmonitor_o,//不知道有什么用
  //------------------- Receive Ports - RX Equalizer Ports -------------------
  // input   [NUMBER_OF_LANES-1:0]     rxdfeagchold_i,
  // input   [NUMBER_OF_LANES-1:0]     rxdfelfhold_i,
  input   [NUMBER_OF_LANES-1:0]     rxdfelpmreset_i,//不知道有什么用
  output  [NUMBER_OF_LANES*7-1:0]   rxmonitorout_o,//不知道有什么用
  input   [NUMBER_OF_LANES*2-1:0]   rxmonitorsel_i,//不知道有什么用
  //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
  output  [NUMBER_OF_LANES-1:0]     rxratedone_o,//不知道有什么用
  //------------- Receive Ports - RX Fabric Output Control Ports -------------
  output  [NUMBER_OF_LANES-1:0]     rxoutclk_o,
  output  [NUMBER_OF_LANES-1:0]     rxoutclkfabric_o,
  //----------- Receive Ports - RX Initialization and Reset Ports ------------
  // input   [NUMBER_OF_LANES-1:0]     gtrxreset_i,
  input   [NUMBER_OF_LANES-1:0]     rxpcsreset_i,
  input   [NUMBER_OF_LANES-1:0]     rxpmareset_i,
  //---------------- Receive Ports - RX Margin Analysis ports ----------------
  input   [NUMBER_OF_LANES-1:0]     rxlpmen_i,//不知道有什么用
  //--------------- Receive Ports - RX Polarity Control Ports ----------------
  input   [NUMBER_OF_LANES-1:0]     rxpolarity_i,//不知道有什么用
  //------------ Receive Ports -RX Initialization and Reset Ports ------------
  // output  [NUMBER_OF_LANES-1:0]     rxresetdone_o,
  //---------------------- TX Configurable Driver Ports ----------------------
  input   [NUMBER_OF_LANES*5-1:0]   txpostcursor_i,//不知道有什么用
  input   [NUMBER_OF_LANES*5-1:0]   txprecursor_i,//不知道有什么用
  //------------------- TX Initialization and Reset Ports --------------------
  // input   [NUMBER_OF_LANES-1:0]     gttxreset_i,
  // input   [NUMBER_OF_LANES-1:0]     txuserrdy_i,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  input   [NUMBER_OF_LANES-1:0]     txusrclk_i,
  input   [NUMBER_OF_LANES-1:0]     txusrclk2_i,
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
  output  [NUMBER_OF_LANES*2-1:0]   txbufstatus_o,//不知道有什么用
  //------------- Transmit Ports - TX Configurable Driver Ports --------------
  input   [NUMBER_OF_LANES*4-1:0]   txdiffctrl_i,//不知道有什么用
  input   [NUMBER_OF_LANES-1:0]     txinhibit_i,//不知道有什么用
  input   [NUMBER_OF_LANES*7-1:0]   txmaincursor_i,//不知道有什么用
  //---------------- Transmit Ports - TX Data Path interface -----------------
  input   [NUMBER_OF_LANES*32-1:0]  txdata_i,
  //-------------- Transmit Ports - TX Driver and OOB signaling --------------
  output  [NUMBER_OF_LANES-1:0]     gtxtxn_o,
  output  [NUMBER_OF_LANES-1:0]     gtxtxp_o,
  //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
  output  [NUMBER_OF_LANES-1:0]     txoutclk_o,
  output  [NUMBER_OF_LANES-1:0]     txoutclkfabric_o,
  output  [NUMBER_OF_LANES-1:0]     txoutclkpcs_o,
  //----------- Transmit Ports - TX Initialization and Reset Ports -----------
  input   [NUMBER_OF_LANES-1:0]     txpcsreset_i,
  input   [NUMBER_OF_LANES-1:0]     txpmareset_i,
  // output  [NUMBER_OF_LANES-1:0]     txresetdone_o,
  //--------------- Transmit Ports - TX Polarity Control Ports ---------------
  input   [NUMBER_OF_LANES-1:0]     txpolarity_i,//不知道有什么用

  //____________________________COMMON PORTS________________________________
  input                             qplllock_i,
  input                             qpllrefclklost_i,
  output                            qpllreset_o,
  input                             qplloutclk_i,
  input                             qplloutrefclk_i

);



//***********************************Parameter Declarations********************


  //Typical CDRLOCK Time is 50,000UI, as per DS183
  localparam RX_CDRLOCK_TIME      = (SIMULATION == 1) ? 1000 : 100000/10.3125;

  localparam integer   WAIT_TIME_CDRLOCK    = RX_CDRLOCK_TIME / STABLE_CLOCK_PERIOD;

//-------------------------- GT Wrapper Wires ------------------------------
  // wire           rxpmaresetdone_i;
  // wire           txpmaresetdone_i;
  wire   [NUMBER_OF_LANES-1:0]     s_tx_reset_done;
  wire   [NUMBER_OF_LANES-1:0]     s_rx_reset_done;
  // wire           txresetdone_ii;
  // wire           s_rx_reset_done;
  // wire           rxresetdone_ii;
  // wire           gttxreset_i;
  wire   [NUMBER_OF_LANES-1:0]     s_gt_tx_reset;
  // wire           gtrxreset_i;
  wire   [NUMBER_OF_LANES-1:0]     s_gt_rx_reset;
  // wire           txpcsreset_i;
  // wire           rxpcsreset_i;
  // wire           txpmareset_i;
  // wire           rxdfelpmreset_i;
  // wire           txuserrdy_i;
  wire   [NUMBER_OF_LANES-1:0]     s_tx_user_rdy;
  wire   [NUMBER_OF_LANES-1:0]     s_rx_user_rdy;
  // wire           rxuserrdy_t;

  wire   [NUMBER_OF_LANES-1:0]     s_rx_dfe_agc_hold;
  wire   [NUMBER_OF_LANES-1:0]     s_rx_dfe_lf_hold;
  wire   [NUMBER_OF_LANES-1:0]     s_rx_lpm_lf_hold;
  wire   [NUMBER_OF_LANES-1:0]     s_rx_lpm_hf_hold;

  // wire           qpllreset_i;
  wire   [NUMBER_OF_LANES-1:0]     s_qpll_reset;
  // wire           qpllrefclklost_i;
  // wire            qplllock_i;


//------------------------------- Global Signals -----------------------------
  wire              s_tied_to_ground;
  wire              s_tied_to_vcc;
  wire   [NUMBER_OF_LANES-1:0]     s_run_tx_phalignment;
  wire   [NUMBER_OF_LANES-1:0]     s_rst_tx_phalignment;
  wire           s_tx_phalignment_done;


  wire   [NUMBER_OF_LANES-1:0]     s_run_rx_phalignment;
  wire   [NUMBER_OF_LANES-1:0]     s_rst_rx_phalignment;
  wire           s_rx_phalignment_done;


//    --------------------------- TX Buffer Bypass Signals --------------------
  wire    [NUMBER_OF_LANES-1:0]   s_tx_dly_sreset;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_dly_sreset_done;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_init;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_init_done;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_align;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_align_done;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_dly_en;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_align_en;
  wire    [NUMBER_OF_LANES-1:0]   s_tx_ph_dly_reset;


//    --------------------------- RX Buffer Bypass Signals --------------------
  wire    [NUMBER_OF_LANES-1:0]   s_rx_dly_sreset;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_dly_sreset_done;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_ph_align;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_ph_align_done;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_dly_en;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_ph_align_en;
  wire    [NUMBER_OF_LANES-1:0]   s_rx_ph_dly_reset;


//**************************** Main Body of Code *******************************
//  Static signal Assigments
  assign  s_tied_to_ground                     =  1'b0;
  assign  s_tied_to_vcc                        =  1'b1;

//    ----------------------------- The GT Wrapper -----------------------------

  // Use the instantiation template in the example directory to add the GT wrapper to your design.
  // In this example, the wrapper is wired up for basic operation with a frame generator and frame
  // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is
  // enabled, bonding should occur after alignment.


  multi_lane_gt #
  (
    .GTREFCLKSEL                      (GTREFCLKSEL),
    .NUMBER_OF_LANES                  (NUMBER_OF_LANES),
    .SIM_GTRESET_SPEEDUP              (SIM_GTRESET_SPEEDUP)     // Set to "TRUE" to speed up sim reset
  )
  u_multi_lane_gt
  (

    //_____________________________________________________________________
    //_____________________________________________________________________
    //GT0  (X1Y8)

    //-------------------------- Channel - DRP Ports  --------------------------
    .drpaddr_i                  (drpaddr_i), // input wire [8:0] drpaddr_i
    .drpclk_i                   (drpclk_i), // input wire drpclk_i
    .drpdi_i                    (drpdi_i), // input wire [15:0] drpdi_i
    .drpdo_o                    (drpdo_o), // output wire [15:0] drpdo_o
    .drpen_i                    (drpen_i), // input wire drpen_i
    .drprdy_o                   (drprdy_o), // output wire drprdy_o
    .drpwe_i                    (drpwe_i), // input wire drpwe_i
    //------------------------- Digital Monitor Ports --------------------------
    .dmonitorout_o              (dmonitorout_o), // output wire [7:0] dmonitorout_o
    //----------------------------- Loopback Ports -----------------------------
    .loopback_i                 (loopback_i), // input wire [2:0] loopback_i
    //--------------------------- PCI Express Ports ----------------------------
    .rxrate_i                   (rxrate_i), // input wire [2:0] rxrate_i
    //------------------- RX Initialization and Reset Ports --------------------
    .eyescanreset_i             (eyescanreset_i), // input wire eyescanreset_i
    .rxuserrdy_i                (s_rx_user_rdy), // input wire rx_user_rdy_o
    //------------------------ RX Margin Analysis Ports ------------------------
    .eyescandataerror_o         (eyescandataerror_o), // output wire eyescandataerror_o
    .eyescantrigger_i           (eyescantrigger_i), // input wire eyescantrigger_i
    //----------------------- Receive Ports - CDR Ports ------------------------
    .rxcdrhold_i                (rxcdrhold_i), // input wire rxcdrhold_i
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .rxusrclk_i                 (rxusrclk_i), // input wire rxusrclk_i
    .rxusrclk2_i                (rxusrclk2_i), // input wire rxusrclk2_i
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .rxdata_o                   (rxdata_o), // output wire [31:0] rxdata_o
    //------------------------- Receive Ports - RX AFE -------------------------
    .gtxrxp_i                   (gtxrxp_i), // input wire gtxrxp_i
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gtxrxn_i                   (gtxrxn_i), // input wire gtxrxn_i
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .rxbufreset_i               (rxbufreset_i), // input wire rxbufreset_i
    .rxbufstatus_o              (rxbufstatus_o), // output wire [2:0] rxbufstatus_o
    .rxdlyen_i                  (s_rx_dly_en), // input wire rxdlyen_i
    .rxdlysreset_i              (s_rx_dly_sreset), // input wire rxdlysreset_i
    .rxdlysresetdone_o          (s_rx_dly_sreset_done), // output wire rxdlysresetdone_i
    .rxphalign_i                (s_rx_ph_align), // input wire rxphalign_i
    .rxphaligndone_o            (s_rx_ph_align_done), // output wire rxphaligndone_i
    .rxphalignen_i              (s_rx_ph_align_en), // input wire rxphalignen_i
    .rxphdlyreset_i             (s_rx_ph_dly_reset), // input wire rxphdlyreset_i
    .rxphmonitor_o              (rxphmonitor_o), // output wire [4:0] rxphmonitor_o
    .rxphslipmonitor_o          (rxphslipmonitor_o), // output wire [4:0] rxphslipmonitor_o
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .rxdfeagchold_i             (s_rx_dfe_agc_hold), // input wire rxdfeagchold_i
    .rxdfelfhold_i              (s_rx_dfe_lf_hold), // input wire rxdfelfhold_i
    .rxdfelpmreset_i            (rxdfelpmreset_i), // input wire rxdfelpmreset_i
    .rxmonitorout_o             (rxmonitorout_o), // output wire [6:0] rxmonitorout_o
    .rxmonitorsel_i             (rxmonitorsel_i), // input wire [1:0] rxmonitorsel_i
    //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
    .rxratedone_o               (rxratedone_o), // output wire rxratedone_o
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .rxoutclk_o                 (rxoutclk_o), // output wire rxoutclk_i
    .rxoutclkfabric_o           (rxoutclkfabric_o), // output wire rxoutclkfabric_o
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gtrxreset_i                (s_gt_rx_reset), // input wire gtrxreset_i
    .rxpcsreset_i               (rxpcsreset_i), // input wire rxpcsreset_i
    .rxpmareset_i               (rxpmareset_i), // input wire rxpmareset_i
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    .rxlpmen_i                  (rxlpmen_i), // input wire rxlpmen_i
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    .rxpolarity_i               (rxpolarity_i), // input wire rxpolarity_i
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .rxresetdone_o              (s_rx_reset_done), // output wire s_rx_reset_done
    //---------------------- TX Configurable Driver Ports ----------------------
    .txpostcursor_i             (txpostcursor_i), // input wire [4:0] txpostcursor_i
    .txprecursor_i              (txprecursor_i), // input wire [4:0] txprecursor_i
    //------------------- TX Initialization and Reset Ports --------------------
    .gttxreset_i                (s_gt_tx_reset), // input wire gttxreset_i
    .txuserrdy_i                (s_tx_user_rdy), // input wire txuserrdy_i
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .txusrclk_i                 (txusrclk_i), // input wire txusrclk_i
    .txusrclk2_i                (txusrclk2_i), // input wire txusrclk2_i
    //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
    .txdlyen_i                  (s_tx_dly_en), // input wire txdlyen_i
    .txdlysreset_i              (s_tx_dly_sreset), // input wire txdlysreset_i
    .txdlysresetdone_o          (s_tx_dly_sreset_done), // output wire txdlysresetdone_i
    .txphalign_i                (s_tx_ph_align), // input wire txphalign_i
    .txphaligndone_o            (s_tx_ph_align_done), // output wire txphaligndone_i
    .txphalignen_i              (s_tx_ph_align_en), // input wire txphalignen_i
    .txphdlyreset_i             (s_tx_ph_dly_reset), // input wire txphdlyreset_i
    .txphinit_i                 (s_tx_ph_init), // input wire txphinit_i
    .txphinitdone_o             (s_tx_ph_init_done), // output wire txphinitdone_i
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    .txbufstatus_o              (txbufstatus_o), // output wire [1:0] txbufstatus_o
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    .txdiffctrl_i               (txdiffctrl_i), // input wire [3:0] txdiffctrl_i
    .txinhibit_i                (txinhibit_i), // input wire txinhibit_i
    .txmaincursor_i             (txmaincursor_i), // input wire [6:0] txmaincursor_i
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .txdata_i                   (txdata_i), // input wire [31:0] txdata_i
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gtxtxn_o                   (gtxtxn_o), // output wire gtxtxn_o
    .gtxtxp_o                   (gtxtxp_o), // output wire gtxtxp_o
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .txoutclk_o                 (txoutclk_o), // output wire txoutclk_i
    .txoutclkfabric_o           (txoutclkfabric_o), // output wire txoutclkfabric_o
    .txoutclkpcs_o              (txoutclkpcs_o), // output wire txoutclkpcs_o
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .txpcsreset_i               (txpcsreset_i), // input wire txpcsreset_i
    .txpmareset_i               (txpmareset_i), // input wire txpmareset_i
    .txresetdone_o              (s_tx_reset_done), // output wire txresetdone_i
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    .txpolarity_i               (txpolarity_i), // input wire txpolarity_i
//____________________________COMMON PORTS________________________________
    .qplloutclk_i               (qplloutclk_i),
    .qplloutrefclk_i            (qplloutrefclk_i)

  );

  // assign  rxpcsreset_i                      =  s_tied_to_ground;
  // assign  txpcsreset_i                      =  s_tied_to_ground;
  // assign  gt1_rxpcsreset_i                     =  s_tied_to_ground;
  // assign  gt1_txpcsreset_i                     =  s_tied_to_ground;

  // assign  rxdfelpmreset_i                   =  s_tied_to_ground;
  // assign  txpmareset_i                      =  s_tied_to_ground;
  // assign  gt1_rxdfelpmreset_i                  =  s_tied_to_ground;
  // assign  gt1_txpmareset_i                     =  s_tied_to_ground;


  // assign  txresetdone_o                     =  s_tx_reset_done;
  // assign  rxresetdone_o                     =  rxresetdone_i;
  // assign  rxoutclk_o                        =  rxoutclk_i;
  // assign  txoutclk_o                        =  txoutclk_i;

  assign  qpllreset_o                       =  s_qpll_reset[0];



  // assign  gttxreset_i                       =  s_gt_tx_reset;
  // assign  gtrxreset_i                       =  s_gt_rx_reset;
  // assign  txuserrdy_i                       =  s_tx_user_rdy;
  // assign  rx_user_rdy_o                       =  rxuserrdy_t;



  generate
  genvar i;
  for(i = 0; i < NUMBER_OF_LANES; i = i + 1) begin : g_init
    tx_startup_fsm #
      (
      .SIMULATION                     (SIMULATION),
      .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD),           // Period of the stable clock driving this state-machine, unit is [ns]
      .RETRY_COUNTER_BITWIDTH         (8),
      .TX_QPLL_USED                   ("TRUE"),                        // the TX and RX Reset FSMs must
      .RX_QPLL_USED                   ("TRUE"),                        // share these two generic values
      .PHASE_ALIGNMENT_MANUAL         ("TRUE")               // Decision if a manual phase-alignment is necessary or the automatic
                                                                // is enough. For single-lane applications the automatic alignment is
                                                                // sufficient
    ) u_tx_startup_fsm (
      .stable_clk_i                   (sys_clk_i),
      .tx_user_clk_i                  (txusrclk_i[i]),
      .soft_reset_i                   (soft_reset_tx_i),
      .qpll_ref_clk_lost_i            (qpllrefclklost_i),
      .cpll_ref_clk_lost_i            (s_tied_to_ground),
      .qpll_lock_i                    (qplllock_i),
      .cpll_lock_i                    (s_tied_to_vcc),
      .tx_reset_done_i                (s_tx_reset_done[i]),
      .mmcm_lock_i                    (tx_mmcm_lock_i[i]),
      .gt_tx_reset_o                  (s_gt_tx_reset[i]),
      .mmcm_reset_o                   (tx_mmcm_reset_o[i]),
      .qpll_reset_o                   (s_qpll_reset[i]),
      .cpll_reset_o                   (),
      .tx_fsm_reset_done_o            (tx_fsm_reset_done_o[i]),
      .tx_user_rdy_o                  (s_tx_user_rdy[i]),
      .run_phalignment_o              (s_run_tx_phalignment[i]),
      .reset_phalignment_o            (s_rst_tx_phalignment[i]),
      .phalignment_done_i             (s_tx_phalignment_done),
      .retry_count_o                  ()
    );
    wire        s_rec_clk_stable;
    reg         rx_cdrlocked;
    integer     rx_cdrlock_counter= 0;

    always @(posedge sys_clk_i)
    begin
      if(s_gt_rx_reset[i])
      begin
        rx_cdrlocked       <= `DLY    1'b0;
        rx_cdrlock_counter <= `DLY    0;
      end
      else if (rx_cdrlock_counter == WAIT_TIME_CDRLOCK)
      begin
        rx_cdrlocked       <= `DLY    1'b1;
        rx_cdrlock_counter <= `DLY    rx_cdrlock_counter;
      end
      else
        rx_cdrlock_counter <= `DLY    rx_cdrlock_counter + 1;
    end
    assign  s_rec_clk_stable                  =  rx_cdrlocked;
    rx_startup_fsm  #
    (
      .SIMULATION                     (SIMULATION),
      .EQ_MODE                        ("DFE"),                   //Rx Equalization Mode - Set to DFE or LPM
      .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD),              //Period of the stable clock driving this state-machine, unit is [ns]
      .RETRY_COUNTER_BITWIDTH         (8),
      .TX_QPLL_USED                   ("TRUE"),                           // the TX and RX Reset FSMs must
      .RX_QPLL_USED                   ("TRUE"),                           // share these two generic values
      .PHASE_ALIGNMENT_MANUAL         ("TRUE")                 // Decision if a manual phase-alignment is necessary or the automatic
                                                                    // is enough. For single-lane applications the automatic alignment is
                                                                    // sufficient
    ) u_rx_startup_fsm (
      .stable_clk_i                   (sys_clk_i),
      .rx_user_clk_i                  (rxusrclk_i[i]),
      .soft_reset_i                   (soft_reset_rx_i),
      .dont_reset_on_data_error_i     (dont_reset_on_data_error_i),
      .qpll_ref_clk_lost_i            (qpllrefclklost_i),
      .cpll_ref_clk_lost_i            (s_tied_to_ground),
      .qpll_lock_i                    (qplllock_i),
      .cpll_lock_i                    (s_tied_to_vcc),
      .rx_reset_done_i                (s_rx_reset_done[i]),
      .mmcm_lock_i                    (s_tied_to_vcc),
      .rec_clk_stable_i               (s_rec_clk_stable),
      .rec_clk_monitor_restart_i      (s_tied_to_ground),
      .data_valid_i                   (data_valid_i[i]),
      .tx_user_rdy_i                  (s_tied_to_vcc),
      .gt_rx_reset_o                  (s_gt_rx_reset[i]),
      .mmcm_reset_o                   (),
      .qpll_reset_o                   (),
      .cpll_reset_o                   (),
      .rx_fsm_reset_done_o            (rx_fsm_reset_done_o[i]),
      .rx_user_rdy_o                  (s_rx_user_rdy[i]),
      .run_phalignment_o              (s_run_rx_phalignment[i]),
      .reset_phalignment_o            (s_rst_rx_phalignment[i]),
      .phalignment_done_i             (s_rx_phalignment_done),
      .rx_dfe_agc_hold_o              (s_rx_dfe_agc_hold[i]),
      .rx_dfe_lf_hold_o               (s_rx_dfe_lf_hold[i]),
      .rx_lpm_lf_hold_o               (s_rx_lpm_lf_hold[i]),//no use
      .rx_lpm_hf_hold_o               (s_rx_lpm_hf_hold[i]),//no use
      .retry_count_o                  ()
    );

  end
  endgenerate


//   --------------------------- TX Buffer Bypass Logic --------------------
//   The TX SYNC Module drives the ports needed to Bypass the TX Buffer.
//   Include the TX SYNC module in your own design if TX Buffer is bypassed.

//Manual
   tx_manual_phase_align #
   (
     .NUMBER_OF_LANES	      (NUMBER_OF_LANES),
     .MASTER_LANE_ID        (MASTER_LANE_ID)
   )
   u_tx_manual_phase_align
   (
    .stable_clk_i                   (sys_clk_i),
    .reset_phalignment_i            (|s_rst_tx_phalignment),
    .run_phalignment_i              (&s_run_tx_phalignment),
    .phase_alignment_done_o         (s_tx_phalignment_done),
    .tx_dly_sreset_o                (s_tx_dly_sreset),
    .tx_dly_sreset_done_i           (s_tx_dly_sreset_done),
    .tx_ph_init_o                   (s_tx_ph_init),
    .tx_ph_init_done_i              (s_tx_ph_init_done),
    .tx_ph_align_o                  (s_tx_ph_align),
    .tx_ph_align_done_i             (s_tx_ph_align_done),
    .tx_dly_en_o                    (s_tx_dly_en)
   );

  assign  s_tx_ph_dly_reset                   =  {NUMBER_OF_LANES{s_tied_to_ground}};
  assign  s_tx_ph_align_en                    =  {NUMBER_OF_LANES{s_tied_to_vcc}};


//   --------------------------- RX Buffer Bypass Logic --------------------
//   The RX SYNC Module drives the ports needed to Bypass the RX Buffer.
//   Include the RX SYNC module in your own design if RX Buffer is bypassed.

//Manual
   rx_manual_phase_align #
   (
     .NUMBER_OF_LANES	      (NUMBER_OF_LANES),
     .MASTER_LANE_ID        (MASTER_LANE_ID)
   )
   u_rx_manual_phase_align
   (
      .stable_clk_i                 (sys_clk_i),
      .reset_phalignment_i          (|s_rst_rx_phalignment),
      .run_phalignment_i            (&s_run_rx_phalignment),
      .phase_alignment_done_o       (s_rx_phalignment_done),
      .rx_dly_sreset_o              (s_rx_dly_sreset),
      .rx_dly_sreset_done_i         (s_rx_dly_sreset_done),
      .rx_ph_align_o                (s_rx_ph_align),
      .rx_ph_align_done_i           (s_rx_ph_align_done),
      .rx_dly_en_o                  (s_rx_dly_en)
   );
  assign  s_rx_ph_dly_reset                   =  {NUMBER_OF_LANES{s_tied_to_ground}};
  assign  s_rx_ph_align_en                    =  {NUMBER_OF_LANES{s_tied_to_vcc}};


endmodule


