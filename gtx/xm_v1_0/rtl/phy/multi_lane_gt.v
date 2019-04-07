//
//  By David
//
//  2019.3.28
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

//***************************** Entity Declaration ****************************
module multi_lane_gt #
(
    // Simulation attributes
  parameter GTREFCLKSEL                     = 3'b001,
  parameter NUMBER_OF_LANES                 = 2,
  parameter SIM_GTRESET_SPEEDUP             = "FALSE",     // Set to "TRUE" to speed up sim reset
  parameter RX_DFE_KL_CFG2_IN               = 32'h301148AC,
  parameter PMA_RSV_IN                      = 32'h001E7080
)
(
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
  output  [NUMBER_OF_LANES*8-1:0]   dmonitorout_o,
  //----------------------------- Loopback Ports -----------------------------
  input   [NUMBER_OF_LANES*3-1:0]   loopback_i,
  //--------------------------- PCI Express Ports ----------------------------
  input   [NUMBER_OF_LANES*3-1:0]   rxrate_i,
  //------------------- RX Initialization and Reset Ports --------------------
  input   [NUMBER_OF_LANES-1:0]     eyescanreset_i,
  input   [NUMBER_OF_LANES-1:0]     rxuserrdy_i,
  //------------------------ RX Margin Analysis Ports ------------------------
  output  [NUMBER_OF_LANES-1:0]     eyescandataerror_o,
  input   [NUMBER_OF_LANES-1:0]     eyescantrigger_i,
  //----------------------- Receive Ports - CDR Ports ------------------------
  input   [NUMBER_OF_LANES-1:0]     rxcdrhold_i,
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
  input   [NUMBER_OF_LANES-1:0]     rxbufreset_i,
  output  [NUMBER_OF_LANES*3-1:0]   rxbufstatus_o,
  input   [NUMBER_OF_LANES-1:0]     rxdlyen_i,
  input   [NUMBER_OF_LANES-1:0]     rxdlysreset_i,
  output  [NUMBER_OF_LANES-1:0]     rxdlysresetdone_o,
  input   [NUMBER_OF_LANES-1:0]     rxphalign_i,
  output  [NUMBER_OF_LANES-1:0]     rxphaligndone_o,
  input   [NUMBER_OF_LANES-1:0]     rxphalignen_i,
  input   [NUMBER_OF_LANES-1:0]     rxphdlyreset_i,
  output  [NUMBER_OF_LANES*5-1:0]   rxphmonitor_o,
  output  [NUMBER_OF_LANES*5-1:0]   rxphslipmonitor_o,
  //------------------- Receive Ports - RX Equalizer Ports -------------------
  input   [NUMBER_OF_LANES-1:0]     rxdfeagchold_i,
  input   [NUMBER_OF_LANES-1:0]     rxdfelfhold_i,
  input   [NUMBER_OF_LANES-1:0]     rxdfelpmreset_i,
  output  [NUMBER_OF_LANES*7-1:0]   rxmonitorout_o,
  input   [NUMBER_OF_LANES*2-1:0]   rxmonitorsel_i,
  //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
  output  [NUMBER_OF_LANES-1:0]     rxratedone_o,
  //------------- Receive Ports - RX Fabric Output Control Ports -------------
  output  [NUMBER_OF_LANES-1:0]     rxoutclk_o,
  output  [NUMBER_OF_LANES-1:0]     rxoutclkfabric_o,
  //----------- Receive Ports - RX Initialization and Reset Ports ------------
  input   [NUMBER_OF_LANES-1:0]     gtrxreset_i,
  input   [NUMBER_OF_LANES-1:0]     rxpcsreset_i,
  input   [NUMBER_OF_LANES-1:0]     rxpmareset_i,
  //---------------- Receive Ports - RX Margin Analysis ports ----------------
  input   [NUMBER_OF_LANES-1:0]     rxlpmen_i,
  //--------------- Receive Ports - RX Polarity Control Ports ----------------
  input   [NUMBER_OF_LANES-1:0]     rxpolarity_i,
  //------------ Receive Ports -RX Initialization and Reset Ports ------------
  output  [NUMBER_OF_LANES-1:0]     rxresetdone_o,
  //---------------------- TX Configurable Driver Ports ----------------------
  input   [NUMBER_OF_LANES*5-1:0]   txpostcursor_i,
  input   [NUMBER_OF_LANES*5-1:0]   txprecursor_i,
  //------------------- TX Initialization and Reset Ports --------------------
  input   [NUMBER_OF_LANES-1:0]     gttxreset_i,
  input   [NUMBER_OF_LANES-1:0]     txuserrdy_i,
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
  input   [NUMBER_OF_LANES-1:0]     txusrclk_i,
  input   [NUMBER_OF_LANES-1:0]     txusrclk2_i,
  //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
  input   [NUMBER_OF_LANES-1:0]     txdlyen_i,
  input   [NUMBER_OF_LANES-1:0]     txdlysreset_i,
  output  [NUMBER_OF_LANES-1:0]     txdlysresetdone_o,
  input   [NUMBER_OF_LANES-1:0]     txphalign_i,
  output  [NUMBER_OF_LANES-1:0]     txphaligndone_o,
  input   [NUMBER_OF_LANES-1:0]     txphalignen_i,
  input   [NUMBER_OF_LANES-1:0]     txphdlyreset_i,
  input   [NUMBER_OF_LANES-1:0]     txphinit_i,
  output  [NUMBER_OF_LANES-1:0]     txphinitdone_o,
  //-------------------- Transmit Ports - TX Buffer Ports --------------------
  output  [NUMBER_OF_LANES*2-1:0]   txbufstatus_o,
  //------------- Transmit Ports - TX Configurable Driver Ports --------------
  input   [NUMBER_OF_LANES*4-1:0]   txdiffctrl_i,
  input   [NUMBER_OF_LANES-1:0]     txinhibit_i,
  input   [NUMBER_OF_LANES*7-1:0]   txmaincursor_i,
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
  output  [NUMBER_OF_LANES-1:0]     txresetdone_o,
  //--------------- Transmit Ports - TX Polarity Control Ports ---------------
  input   [NUMBER_OF_LANES-1:0]     txpolarity_i,

  //____________________________COMMON PORTS________________________________
  input                         qplloutclk_i,
  input                         qplloutrefclk_i
);
//***************************** Parameter Declarations ************************
  localparam QPLL_FBDIV_TOP =  66;

  localparam QPLL_FBDIV_IN  =  (QPLL_FBDIV_TOP == 16)  ? 10'b0000100000 :
    (QPLL_FBDIV_TOP == 20)  ? 10'b0000110000 :
    (QPLL_FBDIV_TOP == 32)  ? 10'b0001100000 :
    (QPLL_FBDIV_TOP == 40)  ? 10'b0010000000 :
    (QPLL_FBDIV_TOP == 64)  ? 10'b0011100000 :
    (QPLL_FBDIV_TOP == 66)  ? 10'b0101000000 :
    (QPLL_FBDIV_TOP == 80)  ? 10'b0100100000 :
    (QPLL_FBDIV_TOP == 100) ? 10'b0101110000 : 10'b0000000000;

  localparam QPLL_FBDIV_RATIO = (QPLL_FBDIV_TOP == 16)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 20)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 32)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 40)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 64)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 66)  ? 1'b0 :
    (QPLL_FBDIV_TOP == 80)  ? 1'b1 :
    (QPLL_FBDIV_TOP == 100) ? 1'b1 : 1'b1;

//***************************** Wire Declarations *****************************

  // ground and vcc signals
  // wire            s_tied_to_ground;
  // wire    [63:0]  s_tied_to_ground_vec;
  // wire            s_tied_to_vcc;
  // wire    [63:0]  s_tied_to_vcc_vec;

  wire    [NUMBER_OF_LANES-1:0]         s_qpllclk;
  wire    [NUMBER_OF_LANES-1:0]         s_qpllrefclk;


//********************************* Main Body of Code**************************

  // localparam GTREFCLKSEL = CHOOSE_REFCLK0 ? 3'b001 : 3'b010;
  // assign s_tied_to_ground             = 1'b0;
  // assign s_tied_to_ground_vec         = 64'h0000000000000000;
  // assign s_tied_to_vcc                = 1'b1;
  // assign s_tied_to_vcc_vec            = 64'hffffffffffffffff;



//------------------------- GT Instances  -------------------------------
  generate
  genvar i;
  for(i = 0; i < NUMBER_OF_LANES; i = i+1) begin : g_gtx
    assign  s_qpllclk[i]    = qplloutclk_i;
    assign  s_qpllrefclk[i] = qplloutrefclk_i;
    single_lane_gt #
    (
      // Simulation attributes
      .GT_SIM_GTRESET_SPEEDUP         (SIM_GTRESET_SPEEDUP),
      .RX_DFE_KL_CFG2_IN              (RX_DFE_KL_CFG2_IN),
      .PCS_RSVD_ATTR_IN               (48'h000000000006),
      .SIM_CPLLREFCLK_SEL             (GTREFCLKSEL),
      .PMA_RSV_IN                     (PMA_RSV_IN)
    )
    u_lane
    (
      .cpllrefclksel_i                (GTREFCLKSEL),
      //-------------------------- Channel - DRP Ports  --------------------------
      .drpaddr_i                      (drpaddr_i[i*9 +: 9]),
      .drpclk_i                       (drpclk_i[i]),
      .drpdi_i                        (drpdi_i[i*16 +: 16]),
      .drpdo_o                        (drpdo_o[i*16 +: 16]),
      .drpen_i                        (drpen_i[i]),
      .drprdy_o                       (drprdy_o[i]),
      .drpwe_i                        (drpwe_i[i]),
      //----------------------------- Clocking Ports -----------------------------
      .qpllclk_i                      (s_qpllclk[i]),
      .qpllrefclk_i                   (s_qpllrefclk[i]),
      //------------------------- Digital Monitor Ports --------------------------
      .dmonitorout_o                  (dmonitorout_o[i*8 +: 8]),
      //----------------------------- Loopback Ports -----------------------------
      .loopback_i                     (loopback_i[i*3 +: 3]),
      //--------------------------- PCI Express Ports ----------------------------
      .rxrate_i                       (rxrate_i[i*3 +: 3]),
      //------------------- RX Initialization and Reset Ports --------------------
      .eyescanreset_i                 (eyescanreset_i[i]),
      .rxuserrdy_i                    (rxuserrdy_i[i]),
      //------------------------ RX Margin Analysis Ports ------------------------
      .eyescandataerror_o             (eyescandataerror_o[i]),
      .eyescantrigger_i               (eyescantrigger_i[i]),
      //----------------------- Receive Ports - CDR Ports ------------------------
      .rxcdrhold_i                    (rxcdrhold_i[i]),
      //---------------- Receive Ports - FPGA RX Interface Ports -----------------
      .rxusrclk_i                     (rxusrclk_i[i]),
      .rxusrclk2_i                    (rxusrclk2_i[i]),
      //---------------- Receive Ports - FPGA RX interface Ports -----------------
      .rxdata_o                       (rxdata_o[i*32 +: 32]),
      //------------------------- Receive Ports - RX AFE -------------------------
      .gtxrxp_i                       (gtxrxp_i[i]),
      //---------------------- Receive Ports - RX AFE Ports ----------------------
      .gtxrxn_i                       (gtxrxn_i[i]),
      //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
      .rxbufreset_i                   (rxbufreset_i[i]),
      .rxbufstatus_o                  (rxbufstatus_o[i*3 +: 3]),
      .rxdlyen_i                      (rxdlyen_i[i]),
      .rxdlysreset_i                  (rxdlysreset_i[i]),
      .rxdlysresetdone_o              (rxdlysresetdone_o[i]),
      .rxphalign_i                    (rxphalign_i[i]),
      .rxphaligndone_o                (rxphaligndone_o[i]),
      .rxphalignen_i                  (rxphalignen_i[i]),
      .rxphdlyreset_i                 (rxphdlyreset_i[i]),
      .rxphmonitor_o                  (rxphmonitor_o[i*5 +: 5]),
      .rxphslipmonitor_o              (rxphslipmonitor_o[i*5 +: 5]),
      //------------------- Receive Ports - RX Equalizer Ports -------------------
      .rxdfeagchold_i                 (rxdfeagchold_i[i]),
      .rxdfelfhold_i                  (rxdfelfhold_i[i]),
      .rxdfelpmreset_i                (rxdfelpmreset_i[i]),
      .rxmonitorout_o                 (rxmonitorout_o[i*7 +: 7]),
      .rxmonitorsel_i                 (rxmonitorsel_i[i*2 +: 2]),
      //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
      .rxratedone_o                   (rxratedone_o[i]),
      //------------- Receive Ports - RX Fabric Output Control Ports -------------
      .rxoutclk_o                     (rxoutclk_o[i]),
      .rxoutclkfabric_o               (rxoutclkfabric_o[i]),
      //----------- Receive Ports - RX Initialization and Reset Ports ------------
      .gtrxreset_i                    (gtrxreset_i[i]),
      .rxpcsreset_i                   (rxpcsreset_i[i]),
      .rxpmareset_i                   (rxpmareset_i[i]),
      //---------------- Receive Ports - RX Margin Analysis ports ----------------
      .rxlpmen_i                      (rxlpmen_i[i]),
      //--------------- Receive Ports - RX Polarity Control Ports ----------------
      .rxpolarity_i                   (rxpolarity_i[i]),
      //------------ Receive Ports -RX Initialization and Reset Ports ------------
      .rxresetdone_o                  (rxresetdone_o[i]),
      //---------------------- TX Configurable Driver Ports ----------------------
      .txpostcursor_i                 (txpostcursor_i[i*5 +: 5]),
      .txprecursor_i                  (txprecursor_i[i*5 +: 5]),
      //------------------- TX Initialization and Reset Ports --------------------
      .gttxreset_i                    (gttxreset_i[i]),
      .txuserrdy_i                    (txuserrdy_i[i]),
      //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
      .txusrclk_i                     (txusrclk_i[i]),
      .txusrclk2_i                    (txusrclk2_i[i]),
      //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
      .txdlyen_i                      (txdlyen_i[i]),
      .txdlysreset_i                  (txdlysreset_i[i]),
      .txdlysresetdone_o              (txdlysresetdone_o[i]),
      .txphalign_i                    (txphalign_i[i]),
      .txphaligndone_o                (txphaligndone_o[i]),
      .txphalignen_i                  (txphalignen_i[i]),
      .txphdlyreset_i                 (txphdlyreset_i[i]),
      .txphinit_i                     (txphinit_i[i]),
      .txphinitdone_o                 (txphinitdone_o[i]),
      //-------------------- Transmit Ports - TX Buffer Ports --------------------
      .txbufstatus_o                  (txbufstatus_o[i*2 +: 2]),
      //------------- Transmit Ports - TX Configurable Driver Ports --------------
      .txdiffctrl_i                   (txdiffctrl_i[i*4 +: 4]),
      .txinhibit_i                    (txinhibit_i[i]),
      .txmaincursor_i                 (txmaincursor_i[i*7 +: 7]),
      //---------------- Transmit Ports - TX Data Path interface -----------------
      .txdata_i                       (txdata_i[i*32 +: 32]),
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .gtxtxn_o                       (gtxtxn_o[i]),
      .gtxtxp_o                       (gtxtxp_o[i]),
      //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      .txoutclk_o                     (txoutclk_o[i]),
      .txoutclkfabric_o               (txoutclkfabric_o[i]),
      .txoutclkpcs_o                  (txoutclkpcs_o[i]),
      //----------- Transmit Ports - TX Initialization and Reset Ports -----------
      .txpcsreset_i                   (txpcsreset_i[i]),
      .txpmareset_i                   (txpmareset_i[i]),
      .txresetdone_o                  (txresetdone_o[i]),
      //--------------- Transmit Ports - TX Polarity Control Ports ---------------
      .txpolarity_i                   (txpolarity_i[i])

    );
    end
  endgenerate

endmodule

