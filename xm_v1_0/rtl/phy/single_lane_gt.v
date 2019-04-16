//
//  By David
//
//  2019.3.28
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1


//***************************** Entity Declaration ****************************

module single_lane_gt #
(
    // Simulation attributes
    parameter   GT_SIM_GTRESET_SPEEDUP   =   "FALSE",       // Set to "TRUE" to speed up sim reset;
    parameter   RX_DFE_KL_CFG2_IN        =   32'h301148AC,
    parameter   SIM_CPLLREFCLK_SEL       =   3'b001,
    parameter   PMA_RSV_IN               =   32'h001E7080,
    parameter   PCS_RSVD_ATTR_IN         =   48'h000000000000
)
(
    input [2:0]     cpllrefclksel_i,
    //-------------------------- Channel - DRP Ports  --------------------------
    input   [8:0]   drpaddr_i,
    input           drpclk_i,
    input   [15:0]  drpdi_i,
    output  [15:0]  drpdo_o,
    input           drpen_i,
    output          drprdy_o,
    input           drpwe_i,
    //----------------------------- Clocking Ports -----------------------------
    input           qpllclk_i,
    input           qpllrefclk_i,
    //------------------------- Digital Monitor Ports --------------------------
    output  [7:0]   dmonitorout_o,
    //----------------------------- Loopback Ports -----------------------------
    input   [2:0]   loopback_i,
    //--------------------------- PCI Express Ports ----------------------------
    input   [2:0]   rxrate_i,
    //------------------- RX Initialization and Reset Ports --------------------
    input           eyescanreset_i,
    input           rxuserrdy_i,
    //------------------------ RX Margin Analysis Ports ------------------------
    output          eyescandataerror_o,
    input           eyescantrigger_i,
    //----------------------- Receive Ports - CDR Ports ------------------------
    input           rxcdrhold_i,
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    input           rxusrclk_i,
    input           rxusrclk2_i,
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    output  [31:0]  rxdata_o,
    //------------------------- Receive Ports - RX AFE -------------------------
    input           gtxrxp_i,
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    input           gtxrxn_i,
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    input           rxbufreset_i,
    output  [2:0]   rxbufstatus_o,
    input           rxdlyen_i,
    input           rxdlysreset_i,
    output          rxdlysresetdone_o,
    input           rxphalign_i,
    output          rxphaligndone_o,
    input           rxphalignen_i,
    input           rxphdlyreset_i,
    output  [4:0]   rxphmonitor_o,
    output  [4:0]   rxphslipmonitor_o,
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    input           rxdfeagchold_i,
    input           rxdfelfhold_i,
    input           rxdfelpmreset_i,
    output  [6:0]   rxmonitorout_o,
    input   [1:0]   rxmonitorsel_i,
    //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
    output          rxratedone_o,
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    output          rxoutclk_o,
    output          rxoutclkfabric_o,
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    input           gtrxreset_i,
    input           rxpcsreset_i,
    input           rxpmareset_i,
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    input           rxlpmen_i,
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    input           rxpolarity_i,
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    output          rxresetdone_o,
    //---------------------- TX Configurable Driver Ports ----------------------
    input   [4:0]   txpostcursor_i,
    input   [4:0]   txprecursor_i,
    //------------------- TX Initialization and Reset Ports --------------------
    input           gttxreset_i,
    input           txuserrdy_i,
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    input           txusrclk_i,
    input           txusrclk2_i,
    //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
    input           txdlyen_i,
    input           txdlysreset_i,
    output          txdlysresetdone_o,
    input           txphalign_i,
    output          txphaligndone_o,
    input           txphalignen_i,
    input           txphdlyreset_i,
    input           txphinit_i,
    output          txphinitdone_o,
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    output  [1:0]   txbufstatus_o,
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    input   [3:0]   txdiffctrl_i,
    input           txinhibit_i,
    input   [6:0]   txmaincursor_i,
    //---------------- Transmit Ports - TX Data Path interface -----------------
    input   [31:0]  txdata_i,
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    output          gtxtxn_o,
    output          gtxtxp_o,
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    output          txoutclk_o,
    output          txoutclkfabric_o,
    output          txoutclkpcs_o,
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    input           txpcsreset_i,
    input           txpmareset_i,
    output          txresetdone_o,
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    input           txpolarity_i


);


//***************************** Wire Declarations *****************************

    // ground and vcc signals
wire            tied_to_ground_i;
wire    [63:0]  tied_to_ground_vec_i;
wire            tied_to_vcc_i;
wire    [63:0]  tied_to_vcc_vec_i;


    //RX Datapath signals
wire    [63:0]  s_rxdata;
wire    [3:0]   rxchariscomma_float_i;
wire    [3:0]   rxcharisk_float_i;
wire    [3:0]   rxdisperr_float_i;
wire    [3:0]   rxnotintable_float_i;
wire    [3:0]   rxrundisp_float_i;


    //TX Datapath signals
wire    [63:0]  s_txdata;
wire    [3:0]   txkerr_float_i;
wire    [3:0]   txrundisp_float_i;
wire            rxstartofseq_float_i;

//
//********************************* Main Body of Code**************************

    //-------------------------  Static signal Assigments ---------------------

    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 64'hffffffffffffffff;

    //-------------------  GT Datapath byte mapping  -----------------

    //The GT deserializes the rightmost parallel bit (LSb) first
    assign  rxdata_o    =   s_rxdata[31:0];

    //The GT serializes the rightmost parallel bit (LSb) first
    assign s_txdata =   {tied_to_ground_vec_i[31:0], txdata_i};




    //------------------------- GT Instantiations  --------------------------
        GTXE2_CHANNEL #
        (
            //_______________________ Simulation-Only Attributes __________________

            .SIM_RECEIVER_DETECT_PASS   ("TRUE"),
            .SIM_TX_EIDLE_DRIVE_LEVEL   ("X"),
            .SIM_RESET_SPEEDUP          (GT_SIM_GTRESET_SPEEDUP),
            .SIM_CPLLREFCLK_SEL         (SIM_CPLLREFCLK_SEL),
            .SIM_VERSION                ("4.0"),


           //----------------RX Byte and Word Alignment Attributes---------------
            .ALIGN_COMMA_DOUBLE                     ("FALSE"),
            .ALIGN_COMMA_ENABLE                     (10'b1111111111),
            .ALIGN_COMMA_WORD                       (1),
            .ALIGN_MCOMMA_DET                       ("FALSE"),
            .ALIGN_MCOMMA_VALUE                     (10'b1010000011),
            .ALIGN_PCOMMA_DET                       ("FALSE"),
            .ALIGN_PCOMMA_VALUE                     (10'b0101111100),
            .SHOW_REALIGN_COMMA                     ("TRUE"),
            .RXSLIDE_AUTO_WAIT                      (7),
            .RXSLIDE_MODE                           ("PCS"),
            .RX_SIG_VALID_DLY                       (10),

           //----------------RX 8B/10B Decoder Attributes---------------
            .RX_DISPERR_SEQ_MATCH                   ("FALSE"),
            .DEC_MCOMMA_DETECT                      ("FALSE"),
            .DEC_PCOMMA_DETECT                      ("FALSE"),
            .DEC_VALID_COMMA_ONLY                   ("FALSE"),

           //----------------------RX Clock Correction Attributes----------------------
            .CBCC_DATA_SOURCE_SEL                   ("ENCODED"),
            .CLK_COR_SEQ_2_USE                      ("FALSE"),
            .CLK_COR_KEEP_IDLE                      ("FALSE"),
            .CLK_COR_MAX_LAT                        (19),
            .CLK_COR_MIN_LAT                        (15),
            .CLK_COR_PRECEDENCE                     ("TRUE"),
            .CLK_COR_REPEAT_WAIT                    (0),
            .CLK_COR_SEQ_LEN                        (1),
            .CLK_COR_SEQ_1_ENABLE                   (4'b1111),
            .CLK_COR_SEQ_1_1                        (10'b0100000000),
            .CLK_COR_SEQ_1_2                        (10'b0000000000),
            .CLK_COR_SEQ_1_3                        (10'b0000000000),
            .CLK_COR_SEQ_1_4                        (10'b0000000000),
            .CLK_CORRECT_USE                        ("FALSE"),
            .CLK_COR_SEQ_2_ENABLE                   (4'b1111),
            .CLK_COR_SEQ_2_1                        (10'b0100000000),
            .CLK_COR_SEQ_2_2                        (10'b0000000000),
            .CLK_COR_SEQ_2_3                        (10'b0000000000),
            .CLK_COR_SEQ_2_4                        (10'b0000000000),

           //----------------------RX Channel Bonding Attributes----------------------
            .CHAN_BOND_KEEP_ALIGN                   ("FALSE"),
            .CHAN_BOND_MAX_SKEW                     (1),
            .CHAN_BOND_SEQ_LEN                      (1),
            .CHAN_BOND_SEQ_1_1                      (10'b0000000000),
            .CHAN_BOND_SEQ_1_2                      (10'b0000000000),
            .CHAN_BOND_SEQ_1_3                      (10'b0000000000),
            .CHAN_BOND_SEQ_1_4                      (10'b0000000000),
            .CHAN_BOND_SEQ_1_ENABLE                 (4'b1111),
            .CHAN_BOND_SEQ_2_1                      (10'b0000000000),
            .CHAN_BOND_SEQ_2_2                      (10'b0000000000),
            .CHAN_BOND_SEQ_2_3                      (10'b0000000000),
            .CHAN_BOND_SEQ_2_4                      (10'b0000000000),
            .CHAN_BOND_SEQ_2_ENABLE                 (4'b1111),
            .CHAN_BOND_SEQ_2_USE                    ("FALSE"),
            .FTS_DESKEW_SEQ_ENABLE                  (4'b1111),
            .FTS_LANE_DESKEW_CFG                    (4'b1111),
            .FTS_LANE_DESKEW_EN                     ("FALSE"),

           //-------------------------RX Margin Analysis Attributes----------------------------
            .ES_CONTROL                             (6'b000000),
            .ES_ERRDET_EN                           ("FALSE"),
            .ES_EYE_SCAN_EN                         ("TRUE"),
            .ES_HORZ_OFFSET                         (12'h000),
            .ES_PMA_CFG                             (10'b0000000000),
            .ES_PRESCALE                            (5'b00000),
            .ES_QUALIFIER                           (80'h00000000000000000000),
            .ES_QUAL_MASK                           (80'h00000000000000000000),
            .ES_SDATA_MASK                          (80'h00000000000000000000),
            .ES_VERT_OFFSET                         (9'b000000000),

           //-----------------------FPGA RX Interface Attributes-------------------------
            .RX_DATA_WIDTH                          (32),

           //-------------------------PMA Attributes----------------------------
            .OUTREFCLK_SEL_INV                      (2'b11),
            .PMA_RSV                                (PMA_RSV_IN),
            .PMA_RSV2                               (16'h2050),
            .PMA_RSV3                               (2'b00),
            .PMA_RSV4                               (32'h00000000),
            .RX_BIAS_CFG                            (12'b000000000100),
            .DMONITOR_CFG                           (24'h000A00),
            .RX_CM_SEL                              (2'b11),
            .RX_CM_TRIM                             (3'b010),
            .RX_DEBUG_CFG                           (12'b000000000000),
            .RX_OS_CFG                              (13'b0000010000000),
            .TERM_RCAL_CFG                          (5'b10000),
            .TERM_RCAL_OVRD                         (1'b0),
            .TST_RSV                                (32'h00000000),
            .RX_CLK25_DIV                           (7),
            .TX_CLK25_DIV                           (7),
            .UCODEER_CLR                            (1'b0),

           //-------------------------PCI Express Attributes----------------------------
            .PCS_PCIE_EN                            ("FALSE"),

           //-------------------------PCS Attributes----------------------------
            .PCS_RSVD_ATTR                          (PCS_RSVD_ATTR_IN),

           //-----------RX Buffer Attributes------------
            .RXBUF_ADDR_MODE                        ("FAST"),
            .RXBUF_EIDLE_HI_CNT                     (4'b1000),
            .RXBUF_EIDLE_LO_CNT                     (4'b0000),
            .RXBUF_EN                               ("FALSE"),
            .RX_BUFFER_CFG                          (6'b000000),
            .RXBUF_RESET_ON_CB_CHANGE               ("TRUE"),
            .RXBUF_RESET_ON_COMMAALIGN              ("FALSE"),
            .RXBUF_RESET_ON_EIDLE                   ("FALSE"),
            .RXBUF_RESET_ON_RATE_CHANGE             ("TRUE"),
            .RXBUFRESET_TIME                        (5'b00001),
            .RXBUF_THRESH_OVFLW                     (61),
            .RXBUF_THRESH_OVRD                      ("FALSE"),
            .RXBUF_THRESH_UNDFLW                    (4),
            .RXDLY_CFG                              (16'h001F),
            .RXDLY_LCFG                             (9'h030),
            .RXDLY_TAP_CFG                          (16'h0000),
            .RXPH_CFG                               (24'h000000),
            .RXPHDLY_CFG                            (24'h084020),
            .RXPH_MONITOR_SEL                       (5'b00000),
            .RX_XCLK_SEL                            ("RXUSR"),
            .RX_DDI_SEL                             (6'b000000),
            .RX_DEFER_RESET_BUF_EN                  ("TRUE"),

           //---------------------CDR Attributes-------------------------

           //For Display Port, HBR/RBR- set RXCDR_CFG=72'h0380008bff40200008

           //For Display Port, HBR2 -   set RXCDR_CFG=72'h038c008bff20200010

           //For SATA Gen1 GTX- set RXCDR_CFG=72'h03_8000_8BFF_4010_0008

           //For SATA Gen2 GTX- set RXCDR_CFG=72'h03_8800_8BFF_4020_0008

           //For SATA Gen3 GTX- set RXCDR_CFG=72'h03_8000_8BFF_1020_0010

           //For SATA Gen3 GTP- set RXCDR_CFG=83'h0_0000_87FE_2060_2444_1010

           //For SATA Gen2 GTP- set RXCDR_CFG=83'h0_0000_47FE_2060_2448_1010

           //For SATA Gen1 GTP- set RXCDR_CFG=83'h0_0000_47FE_1060_2448_1010
            .RXCDR_CFG                              (72'h0b000023ff10400020),
            .RXCDR_FR_RESET_ON_EIDLE                (1'b0),
            .RXCDR_HOLD_DURING_EIDLE                (1'b0),
            .RXCDR_PH_RESET_ON_EIDLE                (1'b0),
            .RXCDR_LOCK_CFG                         (6'b010101),

           //-----------------RX Initialization and Reset Attributes-------------------
            .RXCDRFREQRESET_TIME                    (5'b00001),
            .RXCDRPHRESET_TIME                      (5'b00001),
            .RXISCANRESET_TIME                      (5'b00001),
            .RXPCSRESET_TIME                        (5'b00001),
            .RXPMARESET_TIME                        (5'b00011),

           //-----------------RX OOB Signaling Attributes-------------------
            .RXOOB_CFG                              (7'b0000110),

           //-----------------------RX Gearbox Attributes---------------------------
            .RXGEARBOX_EN                           ("FALSE"),
            .GEARBOX_MODE                           (3'b000),

           //-----------------------PRBS Detection Attribute-----------------------
            .RXPRBS_ERR_LOOPBACK                    (1'b0),

           //-----------Power-Down Attributes----------
            .PD_TRANS_TIME_FROM_P2                  (12'h03c),
            .PD_TRANS_TIME_NONE_P2                  (8'h19),
            .PD_TRANS_TIME_TO_P2                    (8'h64),

           //-----------RX OOB Signaling Attributes----------
            .SAS_MAX_COM                            (64),
            .SAS_MIN_COM                            (36),
            .SATA_BURST_SEQ_LEN                     (4'b0101),
            .SATA_BURST_VAL                         (3'b100),
            .SATA_EIDLE_VAL                         (3'b100),
            .SATA_MAX_BURST                         (8),
            .SATA_MAX_INIT                          (21),
            .SATA_MAX_WAKE                          (7),
            .SATA_MIN_BURST                         (4),
            .SATA_MIN_INIT                          (12),
            .SATA_MIN_WAKE                          (4),

           //-----------RX Fabric Clock Output Control Attributes----------
            .TRANS_TIME_RATE                        (8'h0E),

           //------------TX Buffer Attributes----------------
            .TXBUF_EN                               ("FALSE"),
            .TXBUF_RESET_ON_RATE_CHANGE             ("TRUE"),
            .TXDLY_CFG                              (16'h001F),
            .TXDLY_LCFG                             (9'h030),
            .TXDLY_TAP_CFG                          (16'h0000),
            .TXPH_CFG                               (16'h0780),
            .TXPHDLY_CFG                            (24'h084020),
            .TXPH_MONITOR_SEL                       (5'b00000),
            .TX_XCLK_SEL                            ("TXUSR"),

           //-----------------------FPGA TX Interface Attributes-------------------------
            .TX_DATA_WIDTH                          (32),

           //-----------------------TX Configurable Driver Attributes-------------------------
            .TX_DEEMPH0                             (5'b00000),
            .TX_DEEMPH1                             (5'b00000),
            .TX_EIDLE_ASSERT_DELAY                  (3'b110),
            .TX_EIDLE_DEASSERT_DELAY                (3'b100),
            .TX_LOOPBACK_DRIVE_HIZ                  ("FALSE"),
            .TX_MAINCURSOR_SEL                      (1'b0),
            .TX_DRIVE_MODE                          ("DIRECT"),
            .TX_MARGIN_FULL_0                       (7'b1001110),
            .TX_MARGIN_FULL_1                       (7'b1001001),
            .TX_MARGIN_FULL_2                       (7'b1000101),
            .TX_MARGIN_FULL_3                       (7'b1000010),
            .TX_MARGIN_FULL_4                       (7'b1000000),
            .TX_MARGIN_LOW_0                        (7'b1000110),
            .TX_MARGIN_LOW_1                        (7'b1000100),
            .TX_MARGIN_LOW_2                        (7'b1000010),
            .TX_MARGIN_LOW_3                        (7'b1000000),
            .TX_MARGIN_LOW_4                        (7'b1000000),

           //-----------------------TX Gearbox Attributes--------------------------
            .TXGEARBOX_EN                           ("FALSE"),

           //-----------------------TX Initialization and Reset Attributes--------------------------
            .TXPCSRESET_TIME                        (5'b00001),
            .TXPMARESET_TIME                        (5'b00001),

           //-----------------------TX Receiver Detection Attributes--------------------------
            .TX_RXDETECT_CFG                        (14'h1832),
            .TX_RXDETECT_REF                        (3'b100),

           //--------------------------CPLL Attributes----------------------------
            .CPLL_CFG                               (24'hBC07DC),
            .CPLL_FBDIV                             (4),
            .CPLL_FBDIV_45                          (5),
            .CPLL_INIT_CFG                          (24'h00001E),
            .CPLL_LOCK_CFG                          (16'h01E8),
            .CPLL_REFCLK_DIV                        (1),
            .RXOUT_DIV                              (1),
            .TXOUT_DIV                              (1),
            .SATA_CPLL_CFG                          ("VCO_3000MHZ"),

           //------------RX Initialization and Reset Attributes-------------
            .RXDFELPMRESET_TIME                     (7'b0001111),

           //------------RX Equalizer Attributes-------------
            .RXLPM_HF_CFG                           (14'b00000011110000),
            .RXLPM_LF_CFG                           (14'b00000011110000),
            .RX_DFE_GAIN_CFG                        (23'h020FEA),
            .RX_DFE_H2_CFG                          (12'b000000000000),
            .RX_DFE_H3_CFG                          (12'b000001000000),
            .RX_DFE_H4_CFG                          (11'b00011110000),
            .RX_DFE_H5_CFG                          (11'b00011100000),
            .RX_DFE_KL_CFG                          (13'b0000011111110),
            .RX_DFE_LPM_CFG                         (16'h0954),
            .RX_DFE_LPM_HOLD_DURING_EIDLE           (1'b0),
            .RX_DFE_UT_CFG                          (17'b10001111000000000),
            .RX_DFE_VP_CFG                          (17'b00011111100000011),

           //-----------------------Power-Down Attributes-------------------------
            .RX_CLKMUX_PD                           (1'b1),
            .TX_CLKMUX_PD                           (1'b1),

           //-----------------------FPGA RX Interface Attribute-------------------------
            .RX_INT_DATAWIDTH                       (1),

           //-----------------------FPGA TX Interface Attribute-------------------------
            .TX_INT_DATAWIDTH                       (1),

           //----------------TX Configurable Driver Attributes---------------
            .TX_QPI_STATUS_EN                       (1'b0),

           //-----------------------RX Equalizer Attributes--------------------------
            .RX_DFE_KL_CFG2                         (RX_DFE_KL_CFG2_IN),
            .RX_DFE_XYD_CFG                         (13'b0000000000000),

           //-----------------------TX Configurable Driver Attributes--------------------------
            .TX_PREDRIVER_MODE                      (1'b0)


        )
        gtxe2_i
        (

        //------------------------------- CPLL Ports -------------------------------
        .CPLLFBCLKLOST                  (),
        .CPLLLOCK                       (),
        .CPLLLOCKDETCLK                 (tied_to_ground_i),
        .CPLLLOCKEN                     (tied_to_vcc_i),
        .CPLLPD                         (tied_to_vcc_i),
        .CPLLREFCLKLOST                 (),
        .CPLLREFCLKSEL                  (cpllrefclksel_i),
        .CPLLRESET                      (tied_to_ground_i),
        .GTRSVD                         (16'b0000000000000000),
        .PCSRSVDIN                      (16'b0000000000000000),
        .PCSRSVDIN2                     (5'b00000),
        .PMARSVDIN                      (5'b00000),
        .PMARSVDIN2                     (5'b00000),
        .TSTIN                          (20'b11111111111111111111),
        .TSTOUT                         (),
        //-------------------------------- Channel ---------------------------------
        .CLKRSVD                        (tied_to_ground_vec_i[3:0]),
        //------------------------ Channel - Clocking Ports ------------------------
        .GTGREFCLK                      (tied_to_ground_i),
        .GTNORTHREFCLK0                 (tied_to_ground_i),
        .GTNORTHREFCLK1                 (tied_to_ground_i),
        .GTREFCLK0                      (tied_to_ground_i),
        .GTREFCLK1                      (tied_to_ground_i),
        .GTSOUTHREFCLK0                 (tied_to_ground_i),
        .GTSOUTHREFCLK1                 (tied_to_ground_i),
        //-------------------------- Channel - DRP Ports  --------------------------
        .DRPADDR                        (drpaddr_i),
        .DRPCLK                         (drpclk_i),
        .DRPDI                          (drpdi_i),
        .DRPDO                          (drpdo_o),
        .DRPEN                          (drpen_i),
        .DRPRDY                         (drprdy_o),
        .DRPWE                          (drpwe_i),
        //----------------------------- Clocking Ports -----------------------------
        .GTREFCLKMONITOR                (),
        .QPLLCLK                        (qpllclk_i),
        .QPLLREFCLK                     (qpllrefclk_i),
        .RXSYSCLKSEL                    (2'b11),
        .TXSYSCLKSEL                    (2'b11),
        //------------------------- Digital Monitor Ports --------------------------
        .DMONITOROUT                    (dmonitorout_o),
        //--------------- FPGA TX Interface Datapath Configuration  ----------------
        .TX8B10BEN                      (tied_to_ground_i),
        //----------------------------- Loopback Ports -----------------------------
        .LOOPBACK                       (loopback_i),
        //--------------------------- PCI Express Ports ----------------------------
        .PHYSTATUS                      (),
        .RXRATE                         (rxrate_i),
        .RXVALID                        (),
        //---------------------------- Power-Down Ports ----------------------------
        .RXPD                           (2'b00),
        .TXPD                           (2'b00),
        //------------------------ RX 8B/10B Decoder Ports -------------------------
        .SETERRSTATUS                   (tied_to_ground_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .EYESCANRESET                   (eyescanreset_i),
        .RXUSERRDY                      (rxuserrdy_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .EYESCANDATAERROR               (eyescandataerror_o),
        .EYESCANMODE                    (tied_to_ground_i),
        .EYESCANTRIGGER                 (eyescantrigger_i),
        //----------------------- Receive Ports - CDR Ports ------------------------
        .RXCDRFREQRESET                 (tied_to_ground_i),
        .RXCDRHOLD                      (rxcdrhold_i),
        .RXCDRLOCK                      (),
        .RXCDROVRDEN                    (tied_to_ground_i),
        .RXCDRRESET                     (tied_to_ground_i),
        .RXCDRRESETRSV                  (tied_to_ground_i),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .RXCLKCORCNT                    (),
        //-------- Receive Ports - FPGA RX Interface Datapath Configuration --------
        .RX8B10BEN                      (tied_to_ground_i),
        //---------------- Receive Ports - FPGA RX Interface Ports -----------------
        .RXUSRCLK                       (rxusrclk_i),
        .RXUSRCLK2                      (rxusrclk2_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .RXDATA                         (s_rxdata),
        //----------------- Receive Ports - Pattern Checker Ports ------------------
        .RXPRBSERR                      (),
        .RXPRBSSEL                      (tied_to_ground_vec_i[2:0]),
        //----------------- Receive Ports - Pattern Checker ports ------------------
        .RXPRBSCNTRESET                 (tied_to_ground_i),
        //------------------ Receive Ports - RX  Equalizer Ports -------------------
        .RXDFEXYDEN                     (tied_to_vcc_i),
        .RXDFEXYDHOLD                   (tied_to_ground_i),
        .RXDFEXYDOVRDEN                 (tied_to_ground_i),
        //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .RXDISPERR                      (),
        .RXNOTINTABLE                   (),
        //------------------------- Receive Ports - RX AFE -------------------------
        .GTXRXP                         (gtxrxp_i),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .GTXRXN                         (gtxrxn_i),
        //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .RXBUFRESET                     (rxbufreset_i),
        .RXBUFSTATUS                    (rxbufstatus_o),
        .RXDDIEN                        (tied_to_vcc_i),
        .RXDLYBYPASS                    (tied_to_ground_i),
        .RXDLYEN                        (rxdlyen_i),
        .RXDLYOVRDEN                    (tied_to_ground_i),
        .RXDLYSRESET                    (rxdlysreset_i),
        .RXDLYSRESETDONE                (rxdlysresetdone_o),
        .RXPHALIGN                      (rxphalign_i),
        .RXPHALIGNDONE                  (rxphaligndone_o),
        .RXPHALIGNEN                    (rxphalignen_i),
        .RXPHDLYPD                      (tied_to_ground_i),
        .RXPHDLYRESET                   (rxphdlyreset_i),
        .RXPHMONITOR                    (rxphmonitor_o),
        .RXPHOVRDEN                     (tied_to_ground_i),
        .RXPHSLIPMONITOR                (rxphslipmonitor_o),
        .RXSTATUS                       (),
        //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
        .RXBYTEISALIGNED                (),
        .RXBYTEREALIGN                  (),
        .RXCOMMADET                     (),
        .RXCOMMADETEN                   (tied_to_ground_i),
        .RXMCOMMAALIGNEN                (tied_to_ground_i),
        .RXPCOMMAALIGNEN                (tied_to_ground_i),
        //---------------- Receive Ports - RX Channel Bonding Ports ----------------
        .RXCHANBONDSEQ                  (),
        .RXCHBONDEN                     (tied_to_ground_i),
        .RXCHBONDLEVEL                  (tied_to_ground_vec_i[2:0]),
        .RXCHBONDMASTER                 (tied_to_ground_i),
        .RXCHBONDO                      (),
        .RXCHBONDSLAVE                  (tied_to_ground_i),
        //--------------- Receive Ports - RX Channel Bonding Ports  ----------------
        .RXCHANISALIGNED                (),
        .RXCHANREALIGN                  (),
        //------------------ Receive Ports - RX Equailizer Ports -------------------
        .RXLPMHFHOLD                    (tied_to_ground_i),
        .RXLPMHFOVRDEN                  (tied_to_ground_i),
        .RXLPMLFHOLD                    (tied_to_ground_i),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .RXDFEAGCHOLD                   (rxdfeagchold_i),
        .RXDFEAGCOVRDEN                 (tied_to_ground_i),
        .RXDFECM1EN                     (tied_to_ground_i),
        .RXDFELFHOLD                    (rxdfelfhold_i),
        .RXDFELFOVRDEN                  (tied_to_vcc_i),
        .RXDFELPMRESET                  (rxdfelpmreset_i),
        .RXDFETAP2HOLD                  (tied_to_ground_i),
        .RXDFETAP2OVRDEN                (tied_to_ground_i),
        .RXDFETAP3HOLD                  (tied_to_ground_i),
        .RXDFETAP3OVRDEN                (tied_to_ground_i),
        .RXDFETAP4HOLD                  (tied_to_ground_i),
        .RXDFETAP4OVRDEN                (tied_to_ground_i),
        .RXDFETAP5HOLD                  (tied_to_ground_i),
        .RXDFETAP5OVRDEN                (tied_to_ground_i),
        .RXDFEUTHOLD                    (tied_to_ground_i),
        .RXDFEUTOVRDEN                  (tied_to_ground_i),
        .RXDFEVPHOLD                    (tied_to_ground_i),
        .RXDFEVPOVRDEN                  (tied_to_ground_i),
        .RXDFEVSEN                      (tied_to_ground_i),
        .RXLPMLFKLOVRDEN                (tied_to_ground_i),
        .RXMONITOROUT                   (rxmonitorout_o),
        .RXMONITORSEL                   (rxmonitorsel_i),
        .RXOSHOLD                       (tied_to_ground_i),
        .RXOSOVRDEN                     (tied_to_ground_i),
        //---------- Receive Ports - RX Fabric ClocK Output Control Ports ----------
        .RXRATEDONE                     (rxratedone_o),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .RXOUTCLK                       (rxoutclk_o),
        .RXOUTCLKFABRIC                 (rxoutclkfabric_o),
        .RXOUTCLKPCS                    (),
        .RXOUTCLKSEL                    (3'b010),
        //-------------------- Receive Ports - RX Gearbox Ports --------------------
        .RXDATAVALID                    (),
        .RXHEADER                       (),
        .RXHEADERVALID                  (),
        .RXSTARTOFSEQ                   (),
        //------------------- Receive Ports - RX Gearbox Ports  --------------------
        .RXGEARBOXSLIP                  (tied_to_ground_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .GTRXRESET                      (gtrxreset_i),
        .RXOOBRESET                     (tied_to_ground_i),
        .RXPCSRESET                     (rxpcsreset_i),
        .RXPMARESET                     (rxpmareset_i),
        //---------------- Receive Ports - RX Margin Analysis ports ----------------
        .RXLPMEN                        (rxlpmen_i),
        //----------------- Receive Ports - RX OOB Signaling ports -----------------
        .RXCOMSASDET                    (),
        .RXCOMWAKEDET                   (),
        //---------------- Receive Ports - RX OOB Signaling ports  -----------------
        .RXCOMINITDET                   (),
        //---------------- Receive Ports - RX OOB signalling Ports -----------------
        .RXELECIDLE                     (),
        .RXELECIDLEMODE                 (2'b11),
        //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .RXPOLARITY                     (rxpolarity_i),
        //-------------------- Receive Ports - RX gearbox ports --------------------
        .RXSLIDE                        (tied_to_ground_i),
        //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .RXCHARISCOMMA                  (),
        .RXCHARISK                      (),
        //---------------- Receive Ports - Rx Channel Bonding Ports ----------------
        .RXCHBONDI                      (5'b00000),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .RXRESETDONE                    (rxresetdone_o),
        //------------------------------ Rx AFE Ports ------------------------------
        .RXQPIEN                        (tied_to_ground_i),
        .RXQPISENN                      (),
        .RXQPISENP                      (),
        //------------------------- TX Buffer Bypass Ports -------------------------
        .TXPHDLYTSTCLK                  (tied_to_ground_i),
        //---------------------- TX Configurable Driver Ports ----------------------
        .TXPOSTCURSOR                   (txpostcursor_i),
        .TXPOSTCURSORINV                (tied_to_ground_i),
        .TXPRECURSOR                    (txprecursor_i),
        .TXPRECURSORINV                 (tied_to_ground_i),
        .TXQPIBIASEN                    (tied_to_ground_i),
        .TXQPISTRONGPDOWN               (tied_to_ground_i),
        .TXQPIWEAKPUP                   (tied_to_ground_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .CFGRESET                       (tied_to_ground_i),
        .GTTXRESET                      (gttxreset_i),
        .PCSRSVDOUT                     (),
        .TXUSERRDY                      (txuserrdy_i),
        //-------------------- Transceiver Reset Mode Operation --------------------
        .GTRESETSEL                     (tied_to_ground_i),
        .RESETOVRD                      (tied_to_ground_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .TXCHARDISPMODE                 (tied_to_ground_vec_i[7:0]),
        .TXCHARDISPVAL                  (tied_to_ground_vec_i[7:0]),
        //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
        .TXUSRCLK                       (txusrclk_i),
        .TXUSRCLK2                      (txusrclk2_i),
        //------------------- Transmit Ports - PCI Express Ports -------------------
        .TXELECIDLE                     (tied_to_ground_i),
        .TXMARGIN                       (tied_to_ground_vec_i[2:0]),
        .TXRATE                         (tied_to_ground_vec_i[2:0]),
        .TXSWING                        (tied_to_ground_i),
        //---------------- Transmit Ports - Pattern Generator Ports ----------------
        .TXPRBSFORCEERR                 (tied_to_ground_i),
        //---------------- Transmit Ports - TX Buffer Bypass Ports -----------------
        .TXDLYBYPASS                    (tied_to_ground_i),
        .TXDLYEN                        (txdlyen_i),
        .TXDLYHOLD                      (tied_to_ground_i),
        .TXDLYOVRDEN                    (tied_to_ground_i),
        .TXDLYSRESET                    (txdlysreset_i),
        .TXDLYSRESETDONE                (txdlysresetdone_o),
        .TXDLYUPDOWN                    (tied_to_ground_i),
        .TXPHALIGN                      (txphalign_i),
        .TXPHALIGNDONE                  (txphaligndone_o),
        .TXPHALIGNEN                    (txphalignen_i),
        .TXPHDLYPD                      (tied_to_ground_i),
        .TXPHDLYRESET                   (txphdlyreset_i),
        .TXPHINIT                       (txphinit_i),
        .TXPHINITDONE                   (txphinitdone_o),
        .TXPHOVRDEN                     (tied_to_ground_i),
        //-------------------- Transmit Ports - TX Buffer Ports --------------------
        .TXBUFSTATUS                    (txbufstatus_o),
        //------------- Transmit Ports - TX Configurable Driver Ports --------------
        .TXBUFDIFFCTRL                  (3'b100),
        .TXDEEMPH                       (tied_to_ground_i),
        .TXDIFFCTRL                     (txdiffctrl_i),
        .TXDIFFPD                       (tied_to_ground_i),
        .TXINHIBIT                      (txinhibit_i),
        .TXMAINCURSOR                   (txmaincursor_i),
        .TXPISOPD                       (tied_to_ground_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .TXDATA                         (s_txdata),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTXTXN                         (gtxtxn_o),
        .GTXTXP                         (gtxtxp_o),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .TXOUTCLK                       (txoutclk_o),
        .TXOUTCLKFABRIC                 (txoutclkfabric_o),
        .TXOUTCLKPCS                    (txoutclkpcs_o),
        .TXOUTCLKSEL                    (3'b011),
        .TXRATEDONE                     (),
        //------------------- Transmit Ports - TX Gearbox Ports --------------------
        .TXCHARISK                      (tied_to_ground_vec_i[7:0]),
        .TXGEARBOXREADY                 (),
        .TXHEADER                       (tied_to_ground_vec_i[2:0]),
        .TXSEQUENCE                     (tied_to_ground_vec_i[6:0]),
        .TXSTARTSEQ                     (tied_to_ground_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .TXPCSRESET                     (txpcsreset_i),
        .TXPMARESET                     (txpmareset_i),
        .TXRESETDONE                    (txresetdone_o),
        //---------------- Transmit Ports - TX OOB signalling Ports ----------------
        .TXCOMFINISH                    (),
        .TXCOMINIT                      (tied_to_ground_i),
        .TXCOMSAS                       (tied_to_ground_i),
        .TXCOMWAKE                      (tied_to_ground_i),
        .TXPDELECIDLEMODE               (tied_to_ground_i),
        //--------------- Transmit Ports - TX Polarity Control Ports ---------------
        .TXPOLARITY                     (txpolarity_i),
        //------------- Transmit Ports - TX Receiver Detection Ports  --------------
        .TXDETECTRX                     (tied_to_ground_i),
        //---------------- Transmit Ports - TX8b/10b Encoder Ports -----------------
        .TX8B10BBYPASS                  (tied_to_ground_vec_i[7:0]),
        //---------------- Transmit Ports - pattern Generator Ports ----------------
        .TXPRBSSEL                      (tied_to_ground_vec_i[2:0]),
        //--------------------- Tx Configurable Driver  Ports ----------------------
        .TXQPISENN                      (),
        .TXQPISENP                      ()

     );

endmodule

