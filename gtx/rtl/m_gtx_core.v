//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module m_gtx_core #
(
  parameter CHOOSE_REFCLK0              = 1,
  parameter NUM_OF_LANE                 = 1,
  parameter MASTER_LANE                 = 0, // 0 - NUM_OF_LANE-1
  parameter SIM_GTRESET_SPEEDUP         = "TRUE",    // simulation setting for GT SecureIP model
  parameter STABLE_CLOCK_PERIOD         = 10
)(
  input                           clk0_gt_ref_clk_pad_n_i,// clk0 ref clk
  input                           clk0_gt_ref_clk_pad_p_i,// clk0 ref clk
  input                           clk1_gt_ref_clk_pad_n_i,// clk1 ref clk
  input                           clk1_gt_ref_clk_pad_p_i,// clk1 ref clk
  input                           soft_reset_i,//soft reset
  output                          tx_usr_clk2_o,// tx user clk
  output                          tx_usr_reset_o,// tx user reset
  output                          rx_usr_clk2_o,// rx user clk
  output                          rx_usr_reset_o,// tx user reset
  input                           stable_clk_i,//动态配置时钟兼初始化时钟
  output  [NUM_OF_LANE*32-1:0]    rx_data_o,//rx parallel output
  input   [NUM_OF_LANE*1-1:0]     gt_rxp_i,//gt rxp
  input   [NUM_OF_LANE*1-1:0]     gt_rxn_i,//gt rxn
  input   [NUM_OF_LANE*32-1:0]    tx_data_i,//tx parallel input
  output  [NUM_OF_LANE*1-1:0]     gt_txp_o,//gt txp
  output  [NUM_OF_LANE*1-1:0]     gt_txn_o //gt txn

  // input           soft_reset_tx_i,// soft reset
  // input           soft_reset_rx_i,// soft reset
  // input           dont_reset_on_data_error_i,
  // output          tx_mmcm_lock_o,
  // output          tx_fsm_reset_done_o,
  // output          rx_fsm_reset_done_o,
  // input           data_valid_i,

  // output          txusrclk_o,//
  // output          rxusrclk_o,

  //____________________________CHANNEL PORTS________________________________
  //-------------------------- Channel - DRP Ports  --------------------------
  // input   [8:0]   drpaddr_i,
  // input   [15:0]  drpdi_i,
  // output  [15:0]  drpdo_o,
  // input           drpen_i,
  // output          drprdy_o,
  // input           drpwe_i,
  //------------------------- Digital Monitor Ports --------------------------
  // output  [7:0]   dmonitorout_o,
  //------------------- RX Initialization and Reset Ports --------------------
  // input           eyescanreset_i,
  // input           rxuserrdy_i,
  //------------------------ RX Margin Analysis Ports ------------------------
  // output          eyescandataerror_o,
  // input           eyescantrigger_i,
  //---------------- Receive Ports - FPGA RX interface Ports -----------------
  //------------------------- Receive Ports - RX AFE -------------------------
  //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
  // output  [4:0]   rxphmonitor_o,
  // output  [4:0]   rxphslipmonitor_o,
  //------------------- Receive Ports - RX Equalizer Ports -------------------
  // input           rxdfelpmreset_i,
  // output  [6:0]   rxmonitorout_o,
  // input   [1:0]   rxmonitorsel_i,
  //------------- Receive Ports - RX Fabric Output Control Ports -------------
  // output          rxoutclkfabric_o,
  //----------- Receive Ports - RX Initialization and Reset Ports ------------
  // input           gtrxreset_i,
  // input           rxpmareset_i,
  //------------ Receive Ports -RX Initialization and Reset Ports ------------
  // output          rxresetdone_o,
  //------------------- TX Initialization and Reset Ports --------------------
  // input           gttxreset_i,
  // input           txuserrdy_i,
  //---------------- Transmit Ports - TX Data Path interface -----------------
  //-------------- Transmit Ports - TX Driver and OOB signaling --------------
  //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
  // output          txoutclkfabric_o,
  // output          txoutclkpcs_o,
  //----------- Transmit Ports - TX Initialization and Reset Ports -----------
  // output          txresetdone_o,

  //____________________________COMMON PORTS________________________________
  // output          qplllock_o,
  // output          qpllrefclklost_o,
  // output          qplloutclk_o,
  // output          qplloutrefclk_o
);


//*****************************************************************************
//                  GTX COMMON
//*****************************************************************************
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

  localparam GTREFCLKSEL = CHOOSE_REFCLK0 ? 3'b001 : 3'b010;
  // gt ref clk
  wire                        clk0_gt_ref_clk;
  wire                        clk1_gt_ref_clk;
  // ground and vcc signals
  wire                        s_tied_to_ground_0;
  wire    [63:0]              s_tied_to_ground_vec64;
  wire                        s_tied_to_vcc_0;
  wire    [63:0]              s_tied_to_vcc_vec_64;
  // qpll clk
  wire                        s_qpll_out_clk;
  wire                        s_qpll_out_ref_clk;
  wire                        s_qpll_lock;
  wire                        s_qpll_lock_det_clk;
  wire                        s_qpll_ref_clk_lost;
  wire                        s_qpll_reset;

  // reset
  wire                        s_common_clk_reset;
  wire    [NUM_OF_LANE-1:0]   gt_rxoutclk;
  wire    [NUM_OF_LANE-1:0]   gt_rxoutclk_buf;
  wire    [NUM_OF_LANE-1:0]   gt_rxresetdone_out;
  wire    [NUM_OF_LANE-1:0]   gt_rx_fsm_reset_done_out;
  wire                        gt_txusrclk;
  wire                        gt_txusrclk2;
  wire    [NUM_OF_LANE-1:0]   gt_txresetdone_out;
  wire    [NUM_OF_LANE-1:0]   gt_tx_fsm_reset_done_out;

  wire                        gt_rxfsmresetdone_r;
  wire                        gt_rxfsmresetdone_r2;
  wire                        gt_txfsmresetdone_r;
  wire                        gt_txfsmresetdone_r2;

  assign s_tied_to_ground_0             = 1'b0;
  assign s_tied_to_ground_vec64         = 64'h0000000000000000;
  assign s_tied_to_vcc_0                = 1'b1;
  assign s_tied_to_vcc_vec_64           = 64'hffffffffffffffff;

  generate
  if(CHOOSE_REFCLK0 == 1) : begin g_refclk0
    //IBUFDS_GTE2
    IBUFDS_GTE2 ibufds_instclk0
    (
        .O               (clk0_gt_ref_clk),
        .ODIV2           (),
        .CEB             (s_tied_to_ground_0),
        .I               (clk0_gt_ref_clk_pad_p_i),
        .IB              (clk0_gt_ref_clk_pad_n_i)
    );
  end else begin : g_refclk1
    IBUFDS_GTE2 ibufds_instclk1
    (
        .O               (clk1_gt_ref_clk),
        .ODIV2           (),
        .CEB             (s_tied_to_ground_0),
        .I               (clk1_gt_ref_clk_pad_p_i),
        .IB              (clk1_gt_ref_clk_pad_n_i)
    );
  end
  endgenerate
  //_________________________________________________________________________
  //_________________________________________________________________________
  //_________________________GTXE2_COMMON____________________________________
  parameter SIM_QPLLREFCLK_SEL = 3'b010;
  GTXE2_COMMON #
  (
    // Simulation attributes
    .SIM_RESET_SPEEDUP                (SIM_GTRESET_SPEEDUP),
    .SIM_QPLLREFCLK_SEL               (GTREFCLKSEL),
    .SIM_VERSION                      ("4.0"),
    //----------------COMMON BLOCK Attributes---------------
    .BIAS_CFG                         (64'h0000040000001000),
    .COMMON_CFG                       (32'h00000000),
    .QPLL_CFG                         (27'h0680181),
    .QPLL_CLKOUT_CFG                  (4'b0000),
    .QPLL_COARSE_FREQ_OVRD            (6'b010000),
    .QPLL_COARSE_FREQ_OVRD_EN         (1'b0),
    .QPLL_CP                          (10'b0000011111),
    .QPLL_CP_MONITOR_EN               (1'b0),
    .QPLL_DMONITOR_SEL                (1'b0),
    .QPLL_FBDIV                       (QPLL_FBDIV_IN),
    .QPLL_FBDIV_MONITOR_EN            (1'b0),
    .QPLL_FBDIV_RATIO                 (QPLL_FBDIV_RATIO),
    .QPLL_INIT_CFG                    (24'h000006),
    .QPLL_LOCK_CFG                    (16'h21E8),
    .QPLL_LPF                         (4'b1111),
    .QPLL_REFCLK_DIV                  (1)
  ) gtxe2_common_i (
    //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
    .DRPADDR                          (s_tied_to_ground_vec64[7:0]),
    .DRPCLK                           (s_tied_to_ground_0),
    .DRPDI                            (s_tied_to_ground_vec64[15:0]),
    .DRPDO                            (),
    .DRPEN                            (s_tied_to_ground_0),
    .DRPRDY                           (),
    .DRPWE                            (s_tied_to_ground_0),
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    .GTGREFCLK                        (s_tied_to_ground_0),
    .GTNORTHREFCLK0                   (s_tied_to_ground_0),
    .GTNORTHREFCLK1                   (s_tied_to_ground_0),
    .gtrefclk0                        (clk0_gt_ref_clk),
    .gtrefclk1                        (clk1_gt_ref_clk),
    .GTSOUTHREFCLK0                   (s_tied_to_ground_0),
    .GTSOUTHREFCLK1                   (s_tied_to_ground_0),
    //----------------------- Common Block -  QPLL Ports -----------------------
    .QPLLDMONITOR                     (),
    //--------------------- Common Block - Clocking Ports ----------------------
    .QPLLOUTCLK                       (s_qpll_out_clk),
    .QPLLOUTREFCLK                    (s_qpll_out_ref_clk),
    .REFCLKOUTMONITOR                 (),
    //----------------------- Common Block - QPLL Ports ------------------------
    .QPLLFBCLKLOST                    (),
    .QPLLLOCK                         (s_qpll_lock),
    .QPLLLOCKDETCLK                   (s_qpll_lock_det_clk),
    .QPLLLOCKEN                       (s_tied_to_vcc_0),
    .QPLLOUTRESET                     (s_tied_to_ground_0),
    .QPLLPD                           (s_tied_to_ground_0),
    .QPLLREFCLKLOST                   (s_qpll_ref_clk_lost),
    .QPLLREFCLKSEL                    (GTREFCLKSEL),
    .QPLLRESET                        (s_qpll_reset),
    .QPLLRSVD1                        (16'b0000000000000000),
    .QPLLRSVD2                        (5'b11111),
    //------------------------------- QPLL Ports -------------------------------
    .BGBYPASSB                        (s_tied_to_vcc_0),
    .BGMONITORENB                     (s_tied_to_vcc_0),
    .BGPDB                            (s_tied_to_vcc_0),
    .BGRCALOVRD                       (5'b11111),
    .PMARSVD                          (8'b00000000),
    .RCALENB                          (s_tied_to_vcc_0)

  );


  common_reset #(
    .STABLE_CLOCK_PERIOD (STABLE_CLOCK_PERIOD)        // Period of the stable clock driving this state-machine, unit is [ns]
  ) u_common_reset (
    .STABLE_CLOCK   (stable_clk_i     ),              //Stable Clock, either a stable clock from the PCB
    .SOFT_RESET     (soft_reset_i     ),              //User Reset, can be pulled any time
    .COMMON_RESET   (s_common_clk_reset   )               //Reset QPLL
  );
  assign  s_qpll_reset = |gt_qpllreset | s_common_clk_reset;
  gtwizard_0_CLOCK_MODULE #
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
      .CLK0_OUT                       (gt_txusrclk),
      .CLK1_OUT                       (),
      .CLK2_OUT                       (),
      .CLK3_OUT                       (),
      .CLK_IN                         (gt_txoutclk[0]),
      .MMCM_LOCKED_OUT                (gt_txoutclk_mmcm0_locked_i),
      .MMCM_RESET_IN                  (|gt_txoutclk_mmcm0_reset)
  );
  assign  gt_txusrclk2 = gt_txusrclk;
  assign  tx_usr_clk2_o = gt_txusrclk;

  BUFG rxoutclk_bufg1_i
  (
    .I                              (gt_rxoutclk[0]),
    .O                              (gt_rxoutclk_buf[0])
  );
  assign  gt_rxusrclk = gt_rxoutclk_buf[0];
  assign  gt_rxusrclk2 = gt_rxoutclk_buf[0];
  assign  rx_usr_clk2_o = gt_rxoutclk_buf[0];

  generate
  genvar i;
  for(i = 0, i < NUM_OF_LANE; i = i + 1) begin : g_gtx
    gtwizard_0 gtwizard_0_init_i
    (
      .sysclk_in                      (stable_clk_i),
      .soft_reset_tx_in               (soft_reset_i),
      .soft_reset_rx_in               (soft_reset_i),
      .dont_reset_on_data_error_in    (s_tied_to_ground_0),
      .gt0_tx_mmcm_lock_in            (gt_txoutclk_mmcm0_locked_i),
      .gt0_tx_mmcm_reset_out          (gt_txoutclk_mmcm0_reset[i]),
      .gt0_tx_fsm_reset_done_out      (gt_tx_fsm_reset_done_out[i]),
      .gt0_rx_fsm_reset_done_out      (gt_rx_fsm_reset_done_out[i]),
      .gt0_data_valid_in              (1'b0),//给rx fsm，还未仔细研究用途，应该是有用的，但是以前都是悬空的，仿真能过

      //_____________________________________________________________________
      //_____________________________________________________________________
      //GT0  (X1Y8)

      //-------------------------- Channel - DRP Ports  --------------------------
      .gt0_drpaddr_in                 (gt_drpaddr_in[i*9 +: 9]), // input wire [8:0] gt0_drpaddr_in
      .gt0_drpclk_in                  (stable_clk_i), // input wire sysclk_in_i
      .gt0_drpdi_in                   (gt_drpdi_in[i*16 +: 16]), // input wire [15:0] gt0_drpdi_in
      .gt0_drpdo_out                  (gt_drpdo_out[i*16 +: 16]), // output wire [15:0] gt0_drpdo_out
      .gt0_drpen_in                   (gt_drpen_in[i]), // input wire gt0_drpen_in
      .gt0_drprdy_out                 (gt_drprdy_out[i]), // output wire gt0_drprdy_out
      .gt0_drpwe_in                   (gt_drpwe_in[i]), // input wire gt0_drpwe_in
      //------------------------- Digital Monitor Ports --------------------------
      .gt0_dmonitorout_out            (), // output wire [7:0] gt0_dmonitorout_out 悬空不用
      //------------------- RX Initialization and Reset Ports --------------------
      .gt0_eyescanreset_in            (s_tied_to_ground_0), // input wire gt0_eyescanreset_in
      .gt0_rxuserrdy_in               (s_tied_to_vcc_0), // input wire gt0_rxuserrdy_in
      //------------------------ RX Margin Analysis Ports ------------------------
      .gt0_eyescandataerror_out       (), // output wire gt0_eyescandataerror_out
      .gt0_eyescantrigger_in          (s_tied_to_ground_0), // input wire gt0_eyescantrigger_in
      //---------------- Receive Ports - FPGA RX Interface Ports -----------------
      .gt0_rxusrclk_in                (gt_rxusrclk), // input wire gt0_rxusrclk_i
      .gt0_rxusrclk2_in               (gt_rxusrclk2), // input wire gt0_rxusrclk2_i
      //---------------- Receive Ports - FPGA RX interface Ports -----------------
      .gt0_rxdata_out                 (rx_data_o[i]), // output wire [31:0] gt0_rxdata_out
      //------------------------- Receive Ports - RX AFE -------------------------
      .gt0_gtxrxp_in                  (gt_rxp_i[i]), // input wire gt0_gtxrxp_in
      //---------------------- Receive Ports - RX AFE Ports ----------------------
      .gt0_gtxrxn_in                  (gt_rxn_i[i]), // input wire gt0_gtxrxn_in
      //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
      .gt0_rxphmonitor_out            (), // output wire [4:0] gt0_rxphmonitor_out
      .gt0_rxphslipmonitor_out        (), // output wire [4:0] gt0_rxphslipmonitor_out
      //------------------- Receive Ports - RX Equalizer Ports -------------------
      .gt0_rxdfelpmreset_in           (s_tied_to_ground_0), // input wire gt0_rxdfelpmreset_in
      .gt0_rxmonitorout_out           (), // output wire [6:0] gt0_rxmonitorout_out
      .gt0_rxmonitorsel_in            (2'b00), // input wire [1:0] gt0_rxmonitorsel_in
      //------------- Receive Ports - RX Fabric Output Control Ports -------------
      .gt0_rxoutclk_out               (gt_rxoutclk[i]), // output wire gt0_rxoutclk_i
      .gt0_rxoutclkfabric_out         (), // output wire gt0_rxoutclkfabric_out
      //----------- Receive Ports - RX Initialization and Reset Ports ------------
      .gt0_gtrxreset_in               (s_tied_to_ground_0), // input wire gt0_gtrxreset_in
      .gt0_rxpmareset_in              (s_tied_to_ground_0), // input wire gt0_rxpmareset_in
      //------------ Receive Ports -RX Initialization and Reset Ports ------------
      .gt0_rxresetdone_out            (gt_rxresetdone_out[i]), // output wire gt0_rxresetdone_out
      //------------------- TX Initialization and Reset Ports --------------------
      .gt0_gttxreset_in               (s_tied_to_ground_0), // input wire gt0_gttxreset_in
      .gt0_txuserrdy_in               (s_tied_to_vcc_0), // input wire gt0_txuserrdy_in
      //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
      .gt0_txusrclk_in                (gt_txusrclk), // input wire gt0_txusrclk_i
      .gt0_txusrclk2_in               (gt_txusrclk2), // input wire gt0_txusrclk2_i
      //---------------- Transmit Ports - TX Data Path interface -----------------
      .gt0_txdata_in                  (tx_data_i[i]), // input wire [31:0] gt0_txdata_in
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .gt0_gtxtxn_out                 (gt_txn_o[i]), // output wire gt0_gtxtxn_out
      .gt0_gtxtxp_out                 (gt_txp_o[i]), // output wire gt0_gtxtxp_out
      //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
      .gt0_txoutclk_out               (gt_txoutclk[i]), // output wire gt0_txoutclk_i
      .gt0_txoutclkfabric_out         (), // output wire gt0_txoutclkfabric_out
      .gt0_txoutclkpcs_out            (), // output wire gt0_txoutclkpcs_out
      //----------- Transmit Ports - TX Initialization and Reset Ports -----------
      .gt0_txresetdone_out            (gt_txresetdone_out[i]), // output wire gt0_txresetdone_out

      //qpll
      .gt0_qplllock_in                (s_qpll_lock),
      .gt0_qpllrefclklost_in          (s_qpll_ref_clk_lost),
      .gt0_qpllreset_out              (gt_qpllreset[i]),
      .gt0_qplloutclk_in              (s_qpll_out_clk),
      .gt0_qplloutrefclk_in           (s_qpll_out_ref_clk)
      );
  end
  endgenerate

  always @(posedge gt_txusrclk)
  begin
    if (~(gt_tx_fsm_reset_done_out[MASTER_LANE]))
    begin
      gt_txfsmresetdone_r    <= 1'b0;
      gt_txfsmresetdone_r2   <= 1'b0;
    end
    else
    begin
      gt_txfsmresetdone_r    <= 1'b1;
      gt_txfsmresetdone_r2   <= gt_txfsmresetdone_r;
    end
  end
  assign  tx_usr_reset_o = ~gt_txfsmresetdone_r2;

  always @(posedge gt_rxoutclk_buf[0])
  begin
    if (~(gt_rx_fsm_reset_done_out[MASTER_LANE]))
    begin
      gt_rxfsmresetdone_r    <= 1'b0;
      gt_rxfsmresetdone_r2   <= 1'b0;
    end
    else
    begin
      gt_rxfsmresetdone_r    <= 1'b1;
      gt_rxfsmresetdone_r2   <= gt_rxfsmresetdone_r;
    end
  end
  assign  rx_usr_reset_o = ~gt_rxfsmresetdone_r2;


endmodule