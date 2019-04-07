//
//  By David
//
//  2019-03-26
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define DLY #0

//***********************************Entity Declaration************************
module gt_wrapper #
(
  parameter IS_MASTER_LANE                         = 1,
  parameter EXAMPLE_SIM_GTRESET_SPEEDUP            = "TRUE",     // Simulation setting for GT SecureIP model
  parameter EXAMPLE_SIMULATION                     =  0,         // Set to 1 for simulation
  parameter STABLE_CLOCK_PERIOD                    = 16,         //Period of the stable clock driving this state-machine, unit is [ns]
  parameter EXAMPLE_USE_CHIPSCOPE                  =  0          // Set to 1 to use Chipscope to drive resets

)
(
  input           sysclk_in,
  input           soft_reset_tx_in,
  input           soft_reset_rx_in,
  input           dont_reset_on_data_error_in,
  output          gt0_tx_fsm_reset_done_out,
  output          gt0_rx_fsm_reset_done_out,
  input           gt0_data_valid_in,
  input           gt0_tx_mmcm_lock_in,
  output          gt0_tx_mmcm_reset_out,

  //_________________________________________________________________________
  //GT0  (X1Y8)
  //____________________________CHANNEL PORTS________________________________
  //-------------------------- Channel - DRP Ports  --------------------------
  input   [8:0]   gt0_drpaddr_in,
  input           gt0_drpclk_in,
  input   [15:0]  gt0_drpdi_in,
  output  [15:0]  gt0_drpdo_out,
  input           gt0_drpen_in,
  output          gt0_drprdy_out,
  input           gt0_drpwe_in,
  //------------------------- Digital Monitor Ports --------------------------
  output  [7:0]   gt0_dmonitorout_out,
  //------------------- RX Initialization and Reset Ports --------------------
  input           gt0_eyescanreset_in,
  input           gt0_rxuserrdy_in,
  //------------------------ RX Margin Analysis Ports ------------------------
  output          gt0_eyescandataerror_out,
  input           gt0_eyescantrigger_in,
  //---------------- Receive Ports - FPGA RX Interface Ports -----------------
  input           gt0_rxusrclk_in,
  input           gt0_rxusrclk2_in,
  //---------------- Receive Ports - FPGA RX interface Ports -----------------
  output  [31:0]  gt0_rxdata_out,
  //------------------------- Receive Ports - RX AFE -------------------------
  input           gt0_gtxrxp_in,
  //---------------------- Receive Ports - RX AFE Ports ----------------------
  input           gt0_gtxrxn_in,
  //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
  output  [4:0]   gt0_rxphmonitor_out,
  output  [4:0]   gt0_rxphslipmonitor_out,
  //------------------- Receive Ports - RX Equalizer Ports -------------------
  input           gt0_rxdfelpmreset_in,
  output  [6:0]   gt0_rxmonitorout_out,
  input   [1:0]   gt0_rxmonitorsel_in,
  //------------- Receive Ports - RX Fabric Output Control Ports -------------
  output          gt0_rxoutclk_out,
  output          gt0_rxoutclkfabric_out,
  //----------- Receive Ports - RX Initialization and Reset Ports ------------
  input           gt0_gtrxreset_in,
  input           gt0_rxpmareset_in,
  //------------ Receive Ports -RX Initialization and Reset Ports ------------
  output          gt0_rxresetdone_out,
  //------------------- TX Initialization and Reset Ports --------------------
  input           gt0_gttxreset_in,
  input           gt0_txuserrdy_in,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  input           gt0_txusrclk_in,
  input           gt0_txusrclk2_in,
  //---------------- Transmit Ports - TX Data Path interface -----------------
  input   [31:0]  gt0_txdata_in,
  //-------------- Transmit Ports - TX Driver and OOB signaling --------------
  output          gt0_gtxtxn_out,
  output          gt0_gtxtxp_out,
  //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
  output          gt0_txoutclk_out,
  output          gt0_txoutclkfabric_out,
  output          gt0_txoutclkpcs_out,
  //----------- Transmit Ports - TX Initialization and Reset Ports -----------
  output          gt0_txresetdone_out,


  //____________________________COMMON PORTS________________________________
  input      gt0_qplllock_in,
  input      gt0_qpllrefclklost_in,
  output     gt0_qpllreset_out,
  input      gt0_qplloutclk_in,
  input      gt0_qplloutrefclk_in

);



//***********************************Parameter Declarations********************


  //Typical CDRLOCK Time is 50,000UI, as per DS183
  localparam RX_CDRLOCK_TIME      = (EXAMPLE_SIMULATION == 1) ? 1000 : 100000/10.3125;

  localparam integer   WAIT_TIME_CDRLOCK    = RX_CDRLOCK_TIME / STABLE_CLOCK_PERIOD;

//-------------------------- GT Wrapper Wires ------------------------------
  wire           gt0_rxpmaresetdone_i;
  wire           gt0_txpmaresetdone_i;
  wire           gt0_txresetdone_i;
  wire           gt0_txresetdone_ii;
  wire           gt0_rxresetdone_i;
  wire           gt0_rxresetdone_ii;
  wire           gt0_gttxreset_i;
  wire           gt0_gttxreset_t;
  wire           gt0_gtrxreset_i;
  wire           gt0_gtrxreset_t;
  wire           gt0_rxdfelpmreset_i;
  wire           gt0_txuserrdy_i;
  wire           gt0_txuserrdy_t;
  wire           gt0_rxuserrdy_i;
  wire           gt0_rxuserrdy_t;

  wire           gt0_rxdfeagchold_i;
  wire           gt0_rxdfelfhold_i;
  wire           gt0_rxlpmlfhold_i;
  wire           gt0_rxlpmhfhold_i;



  wire           gt0_qpllreset_i;
  wire           gt0_qpllreset_t;
  wire           gt0_qpllrefclklost_i;
  wire           gt0_qplllock_i;


//------------------------------- Global Signals -----------------------------
  wire          tied_to_ground_i;
  wire          tied_to_vcc_i;
  wire           gt0_txphaligndone_i;
  wire           gt0_txdlysreset_i;
  wire           gt0_txdlysresetdone_i;
  wire           gt0_txphdlyreset_i;
  wire           gt0_txphalignen_i;
  wire           gt0_txdlyen_i;
  wire           gt0_txphalign_i;
  wire           gt0_txphinit_i;
  wire           gt0_txphinitdone_i;
  wire           gt0_run_tx_phalignment_i;
  wire           gt0_rst_tx_phalignment_i;
  wire           gt0_tx_phalignment_done_i;

  wire           gt0_txoutclk_i;
  wire           gt0_rxoutclk_i;
  wire           gt0_rxoutclk_i2;
  wire           gt0_txoutclk_i2;
  wire           gt0_recclk_stable_i;
  reg            gt0_rx_cdrlocked;
  integer  gt0_rx_cdrlock_counter= 0;
  wire           gt0_rxphaligndone_i;
  wire           gt0_rxdlysreset_i;
  wire           gt0_rxdlysresetdone_i;
  wire           gt0_rxphdlyreset_i;
  wire           gt0_rxphalignen_i;
  wire           gt0_rxdlyen_i;
  wire           gt0_rxphalign_i;
  wire           gt0_run_rx_phalignment_i;
  wire           gt0_rst_rx_phalignment_i;
  wire           gt0_rx_phalignment_done_i;



//    --------------------------- TX Buffer Bypass Signals --------------------
  wire   mstr0_txsyncallin_i;
  wire  [0 : 0]        U0_TXDLYEN;
  wire  [0 : 0]        U0_TXDLYSRESET;
  wire  [0 : 0]        U0_TXDLYSRESETDONE;
  wire  [0 : 0]        U0_TXPHINIT;
  wire  [0 : 0]        U0_TXPHINITDONE;
  wire  [0 : 0]        U0_TXPHALIGN;
  wire  [0 : 0]        U0_TXPHALIGNDONE ;
  wire                                 U0_run_tx_phalignment_i;
  wire                                 U0_rst_tx_phalignment_i;


//    --------------------------- RX Buffer Bypass Signals --------------------
  wire   rxmstr0_rxsyncallin_i;
  wire  [0 : 0]        U0_RXDLYEN;
  wire  [0 : 0]        U0_RXDLYSRESET;
  wire  [0 : 0]        U0_RXDLYSRESETDONE;
  wire  [0 : 0]        U0_RXPHALIGN;
  wire  [0 : 0]        U0_RXPHALIGNDONE ;
  wire                                 U0_run_rx_phalignment_i;
  wire                                 U0_rst_rx_phalignment_i;

  reg              rx_cdrlocked;


//**************************** Main Body of Code *******************************
  //  Static signal Assigments
  assign  tied_to_ground_i                     =  1'b0;
  assign  tied_to_vcc_i                        =  1'b1;

//    ----------------------------- The GT Wrapper -----------------------------

  // Use the instantiation template in the example directory to add the GT wrapper to your design.
  // In this example, the wrapper is wired up for basic operation with a frame generator and frame
  // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is
  // enabled, bonding should occur after alignment.


  gtwizard_0_multi_gt #
  (
      .WRAPPER_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP)
  )
  gtwizard_0_i
  (

    //__  ___________________________________________________________________
    //_____________________________________________________________________
    //GT0  (X1Y8)

    //-------------------------- Channel - DRP Ports  --------------------------
    .gt0_drpaddr_in                 (gt0_drpaddr_in), // input wire [8:0] gt0_drpaddr_in
    .gt0_drpclk_in                  (gt0_drpclk_in), // input wire gt0_drpclk_in
    .gt0_drpdi_in                   (gt0_drpdi_in), // input wire [15:0] gt0_drpdi_in
    .gt0_drpdo_out                  (gt0_drpdo_out), // output wire [15:0] gt0_drpdo_out
    .gt0_drpen_in                   (gt0_drpen_in), // input wire gt0_drpen_in
    .gt0_drprdy_out                 (gt0_drprdy_out), // output wire gt0_drprdy_out
    .gt0_drpwe_in                   (gt0_drpwe_in), // input wire gt0_drpwe_in
    //------------------------- Digital Monitor Ports --------------------------
    .gt0_dmonitorout_out            (gt0_dmonitorout_out), // output wire [7:0] gt0_dmonitorout_out
    //------------------- RX Initialization and Reset Ports --------------------
    .gt0_eyescanreset_in            (gt0_eyescanreset_in), // input wire gt0_eyescanreset_in
    .gt0_rxuserrdy_in               (gt0_rxuserrdy_i), // input wire gt0_rxuserrdy_i
    //------------------------ RX Margin Analysis Ports ------------------------
    .gt0_eyescandataerror_out       (gt0_eyescandataerror_out), // output wire gt0_eyescandataerror_out
    .gt0_eyescantrigger_in          (gt0_eyescantrigger_in), // input wire gt0_eyescantrigger_in
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    .gt0_rxusrclk_in                (gt0_rxusrclk_in), // input wire gt0_rxusrclk_in
    .gt0_rxusrclk2_in               (gt0_rxusrclk2_in), // input wire gt0_rxusrclk2_in
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    .gt0_rxdata_out                 (gt0_rxdata_out), // output wire [31:0] gt0_rxdata_out
    //------------------------- Receive Ports - RX AFE -------------------------
    .gt0_gtxrxp_in                  (gt0_gtxrxp_in), // input wire gt0_gtxrxp_in
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    .gt0_gtxrxn_in                  (gt0_gtxrxn_in), // input wire gt0_gtxrxn_in
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    .gt0_rxdlyen_in                 (gt0_rxdlyen_i), // input wire gt0_rxdlyen_i
    .gt0_rxdlysreset_in             (gt0_rxdlysreset_i), // input wire gt0_rxdlysreset_i
    .gt0_rxdlysresetdone_out        (gt0_rxdlysresetdone_i), // output wire gt0_rxdlysresetdone_i
    .gt0_rxphalign_in               (gt0_rxphalign_i), // input wire gt0_rxphalign_i
    .gt0_rxphaligndone_out          (gt0_rxphaligndone_i), // output wire gt0_rxphaligndone_i
    .gt0_rxphalignen_in             (gt0_rxphalignen_i), // input wire gt0_rxphalignen_i
    .gt0_rxphdlyreset_in            (gt0_rxphdlyreset_i), // input wire gt0_rxphdlyreset_i
    .gt0_rxphmonitor_out            (gt0_rxphmonitor_out), // output wire [4:0] gt0_rxphmonitor_out
    .gt0_rxphslipmonitor_out        (gt0_rxphslipmonitor_out), // output wire [4:0] gt0_rxphslipmonitor_out
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    .gt0_rxdfeagchold_in            (gt0_rxdfeagchold_i), // input wire gt0_rxdfeagchold_i
    .gt0_rxdfelfhold_in             (gt0_rxdfelfhold_i), // input wire gt0_rxdfelfhold_i
    .gt0_rxdfelpmreset_in           (gt0_rxdfelpmreset_in), // input wire gt0_rxdfelpmreset_in
    .gt0_rxmonitorout_out           (gt0_rxmonitorout_out), // output wire [6:0] gt0_rxmonitorout_out
    .gt0_rxmonitorsel_in            (gt0_rxmonitorsel_in), // input wire [1:0] gt0_rxmonitorsel_in
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    .gt0_rxoutclk_out               (gt0_rxoutclk_i), // output wire gt0_rxoutclk_i
    .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_out), // output wire gt0_rxoutclkfabric_out
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    .gt0_gtrxreset_in               (gt0_gtrxreset_i), // input wire gt0_gtrxreset_i
    .gt0_rxpmareset_in              (gt0_rxpmareset_in), // input wire gt0_rxpmareset_in
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    .gt0_rxresetdone_out            (gt0_rxresetdone_i), // output wire gt0_rxresetdone_i
    //------------------- TX Initialization and Reset Ports --------------------
    .gt0_gttxreset_in               (gt0_gttxreset_i), // input wire gt0_gttxreset_i
    .gt0_txuserrdy_in               (gt0_txuserrdy_i), // input wire gt0_txuserrdy_i
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .gt0_txusrclk_in                (gt0_txusrclk_in), // input wire gt0_txusrclk_in
    .gt0_txusrclk2_in               (gt0_txusrclk2_in), // input wire gt0_txusrclk2_in
    //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
    .gt0_txdlyen_in                 (gt0_txdlyen_i), // input wire gt0_txdlyen_i
    .gt0_txdlysreset_in             (gt0_txdlysreset_i), // input wire gt0_txdlysreset_i
    .gt0_txdlysresetdone_out        (gt0_txdlysresetdone_i), // output wire gt0_txdlysresetdone_i
    .gt0_txphalign_in               (gt0_txphalign_i), // input wire gt0_txphalign_i
    .gt0_txphaligndone_out          (gt0_txphaligndone_i), // output wire gt0_txphaligndone_i
    .gt0_txphalignen_in             (gt0_txphalignen_i), // input wire gt0_txphalignen_i
    .gt0_txphdlyreset_in            (gt0_txphdlyreset_i), // input wire gt0_txphdlyreset_i
    .gt0_txphinit_in                (gt0_txphinit_i), // input wire gt0_txphinit_i
    .gt0_txphinitdone_out           (gt0_txphinitdone_i), // output wire gt0_txphinitdone_i
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .gt0_txdata_in                  (gt0_txdata_in), // input wire [31:0] gt0_txdata_in
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .gt0_gtxtxn_out                 (gt0_gtxtxn_out), // output wire gt0_gtxtxn_out
    .gt0_gtxtxp_out                 (gt0_gtxtxp_out), // output wire gt0_gtxtxp_out
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    .gt0_txoutclk_out               (gt0_txoutclk_i), // output wire gt0_txoutclk_i
    .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_out), // output wire gt0_txoutclkfabric_out
    .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_out), // output wire gt0_txoutclkpcs_out
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    .gt0_txresetdone_out            (gt0_txresetdone_i), // output wire gt0_txresetdone_i

  //____________________________COMMON PORTS________________________________
    .gt0_qplloutclk_in              (gt0_qplloutclk_in),
    .gt0_qplloutrefclk_in           (gt0_qplloutrefclk_in)

  );


  assign  gt0_rxdfelpmreset_i                  =  tied_to_ground_i;


  assign  gt0_txresetdone_out                  =  gt0_txresetdone_i;
  assign  gt0_rxresetdone_out                  =  gt0_rxresetdone_i;
  assign  gt0_rxoutclk_out                     =  gt0_rxoutclk_i;
  assign  gt0_txoutclk_out                     =  gt0_txoutclk_i;
  assign  gt0_qpllreset_out                    =  gt0_qpllreset_t;

  generate
  if (EXAMPLE_USE_CHIPSCOPE == 1)
  begin : chipscope
  assign  gt0_gttxreset_i                      =  gt0_gttxreset_in || gt0_gttxreset_t;
  assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_in || gt0_gtrxreset_t;
  assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_in && gt0_txuserrdy_t;
  assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_in && gt0_rxuserrdy_t;
  end
  endgenerate

  generate
  if (EXAMPLE_USE_CHIPSCOPE == 0)
  begin : no_chipscope
  assign  gt0_gttxreset_i                      =  gt0_gttxreset_t;
  assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_t;
  assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_t;
  assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_t;
  end
  endgenerate


  gtwizard_0_TX_STARTUP_FSM #
  (
    .EXAMPLE_SIMULATION       (EXAMPLE_SIMULATION),
    .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),           // Period of the stable clock driving this state-machine, unit is [ns]
    .RETRY_COUNTER_BITWIDTH   (8),
    .TX_QPLL_USED             ("TRUE"),                        // the TX and RX Reset FSMs must
    .RX_QPLL_USED             ("TRUE"),                        // share these two generic values
    .PHASE_ALIGNMENT_MANUAL   ("TRUE")               // Decision if a manual phase-alignment is necessary or the automatic
                                                                     // is enough. For single-lane applications the automatic alignment is
                                                                     // sufficient
  )
  gt0_txresetfsm_i
  (
    .STABLE_CLOCK                   (sysclk_in),
    .TXUSERCLK                      (gt0_txusrclk_in),
    .SOFT_RESET                     (soft_reset_tx_in),
    .QPLLREFCLKLOST                 (gt0_qpllrefclklost_in),
    .CPLLREFCLKLOST                 (tied_to_ground_i),
    .QPLLLOCK                       (gt0_qplllock_in),
    .CPLLLOCK                       (tied_to_vcc_i),
    .TXRESETDONE                    (gt0_txresetdone_i),
    .MMCM_LOCK                      (gt0_tx_mmcm_lock_in),
    .GTTXRESET                      (gt0_gttxreset_t),
    .MMCM_RESET                     (gt0_tx_mmcm_reset_out),
    .QPLL_RESET                     (gt0_qpllreset_t),
    .CPLL_RESET                     (),
    .TX_FSM_RESET_DONE              (gt0_tx_fsm_reset_done_out),
    .TXUSERRDY                      (gt0_txuserrdy_t),
    .RUN_PHALIGNMENT                (gt0_run_tx_phalignment_i),
    .RESET_PHALIGNMENT              (gt0_rst_tx_phalignment_i),
    .PHALIGNMENT_DONE               (gt0_tx_phalignment_done_i),
    .RETRY_COUNTER                  ()
  );

  gtwizard_0_RX_STARTUP_FSM  #
  (
    .EXAMPLE_SIMULATION       (EXAMPLE_SIMULATION),
    .EQ_MODE                  ("DFE"),                   //Rx Equalization Mode - Set to DFE or LPM
    .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),              //Period of the stable clock driving this state-machine, unit is [ns]
    .RETRY_COUNTER_BITWIDTH   (8),
    .TX_QPLL_USED             ("TRUE"),                           // the TX and RX Reset FSMs must
    .RX_QPLL_USED             ("TRUE"),                           // share these two generic values
    .PHASE_ALIGNMENT_MANUAL   ("FALSE")                 // Decision if a manual phase-alignment is necessary or the automatic
                                                                // is enough. For single-lane applications the automatic alignment is
                                                                // sufficient
    ) gt0_rxresetfsm_i
  (
    .STABLE_CLOCK                   (sysclk_in),
    .RXUSERCLK                      (gt0_rxusrclk_in),
    .SOFT_RESET                     (soft_reset_rx_in),
    .DONT_RESET_ON_DATA_ERROR       (dont_reset_on_data_error_in),
    .QPLLREFCLKLOST                 (gt0_qpllrefclklost_in),
    .CPLLREFCLKLOST                 (tied_to_ground_i),
    .QPLLLOCK                       (gt0_qplllock_in),
    .CPLLLOCK                       (tied_to_vcc_i),
    .RXRESETDONE                    (gt0_rxresetdone_i),
    .MMCM_LOCK                      (tied_to_vcc_i),
    .RECCLK_STABLE                  (gt0_recclk_stable_i),
    .RECCLK_MONITOR_RESTART         (tied_to_ground_i),
    .DATA_VALID                     (gt0_data_valid_in),
    .TXUSERRDY                      (tied_to_vcc_i),
    .GTRXRESET                      (gt0_gtrxreset_t),
    .MMCM_RESET                     (),
    .QPLL_RESET                     (),
    .CPLL_RESET                     (),
    .RX_FSM_RESET_DONE              (gt0_rx_fsm_reset_done_out),
    .RXUSERRDY                      (gt0_rxuserrdy_t),
    .RUN_PHALIGNMENT                (gt0_run_rx_phalignment_i),
    .RESET_PHALIGNMENT              (gt0_rst_rx_phalignment_i),
    .PHALIGNMENT_DONE               (gt0_rx_phalignment_done_i),
    .RXDFEAGCHOLD                   (gt0_rxdfeagchold_i),
    .RXDFELFHOLD                    (gt0_rxdfelfhold_i),
    .RXLPMLFHOLD                    (gt0_rxlpmlfhold_i),
    .RXLPMHFHOLD                    (gt0_rxlpmhfhold_i),
    .RETRY_COUNTER                  ()
  );

  always @(posedge sysclk_in)
  begin
    if(gt0_gtrxreset_i)
    begin
      gt0_rx_cdrlocked       <= `DLY    1'b0;
      gt0_rx_cdrlock_counter <= `DLY    0;
    end
    else if (gt0_rx_cdrlock_counter == WAIT_TIME_CDRLOCK)
    begin
      gt0_rx_cdrlocked       <= `DLY    1'b1;
      gt0_rx_cdrlock_counter <= `DLY    gt0_rx_cdrlock_counter;
    end
    else
      gt0_rx_cdrlock_counter <= `DLY    gt0_rx_cdrlock_counter + 1;
  end

  assign  gt0_recclk_stable_i                  =  gt0_rx_cdrlocked;



//   --------------------------- TX Buffer Bypass Logic --------------------
//   The TX SYNC Module drives the ports needed to Bypass the TX Buffer.
//   Include the TX SYNC module in your own design if TX Buffer is bypassed.


  // //Auto
  // assign  gt0_txphdlyreset_i                   =  tied_to_ground_i;
  // assign  gt0_txphalignen_i                    =  tied_to_ground_i;
  // assign  gt0_txdlyen_i                        =  tied_to_ground_i;
  // assign  gt0_txphalign_i                      =  tied_to_ground_i;
  // assign  gt0_txphinit_i                       =  tied_to_ground_i;

  // gtwizard_0_AUTO_PHASE_ALIGN
  // gt0_tx_auto_phase_align_i
  //   (
  //     .STABLE_CLOCK                   (sysclk_in),
  //     .RUN_PHALIGNMENT                (gt0_run_tx_phalignment_i),
  //     .PHASE_ALIGNMENT_DONE           (gt0_tx_phalignment_done_i),
  //     .PHALIGNDONE                    (gt0_txphaligndone_i),
  //     .DLYSRESET                      (gt0_txdlysreset_i),
  //     .DLYSRESETDONE                  (gt0_txdlysresetdone_i),
  //     .RECCLKSTABLE                   (tied_to_vcc_i)
  //   );

  // manual




//   --------------------------- RX Buffer Bypass Logic --------------------
//   The RX SYNC Module drives the ports needed to Bypass the RX Buffer.
//   Include the RX SYNC module in your own design if RX Buffer is bypassed.


// //Auto
//   assign  gt0_rxphdlyreset_i                   =  tied_to_ground_i;
//   assign  gt0_rxphalignen_i                    =  tied_to_ground_i;
//   assign  gt0_rxdlyen_i                        =  tied_to_ground_i;
//   assign  gt0_rxphalign_i                      =  tied_to_ground_i;


//   gtwizard_0_AUTO_PHASE_ALIGN
//   gt0_rx_auto_phase_align_i
//   (
//     .STABLE_CLOCK                   (sysclk_in),
//     .RUN_PHALIGNMENT                (gt0_run_rx_phalignment_i),
//     .PHASE_ALIGNMENT_DONE           (gt0_rx_phalignment_done_i),
//     .PHALIGNDONE                    (gt0_rxphaligndone_i),
//     .DLYSRESET                      (gt0_rxdlysreset_i),
//     .DLYSRESETDONE                  (gt0_rxdlysresetdone_i),
//     .RECCLKSTABLE                   (gt0_recclk_stable_i)
//   );



endmodule

