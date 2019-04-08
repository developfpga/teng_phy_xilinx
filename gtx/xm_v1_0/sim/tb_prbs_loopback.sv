//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps

module tb_prbs_loopback();

  // ===========================================================================
  //         Parameter
  // ===========================================================================
  parameter CHOOSE_REFCLK0                  = 1;
  parameter NUMBER_OF_LANES                 = 2;
  parameter MASTER_LANE_ID                  = 0;
  parameter SIM_GTRESET_SPEEDUP             = "TRUE";     // Simulation setting for GT SecureIP model
  parameter SIMULATION                      =  0;         // Set to 1 for simulation
  parameter STABLE_CLOCK_PERIOD             = 10;        //Period of the stable clock driving this state-machine, unit is [ns]

  parameter P_SCRAMBLE_LOOPBACK             = 1'b0;
  parameter P_GEARBOX_LOOPBACK              = 1'b0;

  // -------------------------------------------------------------------------------------------------------------------
  // Signal declarations and basic example design stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // Declare wires to loop back serial data ports for transceiver channel 0
  wire    [NUMBER_OF_LANES-1:0] gthxn;
  wire    [NUMBER_OF_LANES-1:0] gthxp;

  // Declare register to drive reference clock at location ref_clk
  reg ref_clk = 1'b0;

  // Drive that reference clock at the appropriate frequency
  // NOTE: the following simulation reference clock period may be up to +/- 2ps from its nominal value, due to rounding
  // within Verilog timescale granularity, especially when transmitter and receiver reference clock frequencies differ
  initial begin
    ref_clk = 1'b0;
    forever
      ref_clk = #3200 ~ref_clk;
  end

  // Declare registers to drive reset helper block(s)
  reg free_clk    = 1'b0;
  reg reset_all   = 1'b1;

  // Drive the helper block free running clock
  initial begin
    free_clk = 1'b0;
    forever
      free_clk = #5000 ~free_clk;
  end

  // Drive the helper block "reset all" input high, then low after some time
  initial begin
    reset_all = 1'b1;
    #5E6;
    repeat (100)
      @(free_clk);
    reset_all = 1'b0;
  end

  prbs_test #(
    .CHOOSE_REFCLK0         (CHOOSE_REFCLK0      ),
    .NUMBER_OF_LANES        (NUMBER_OF_LANES     ),
    .MASTER_LANE_ID         (MASTER_LANE_ID      ),
    .SIM_GTRESET_SPEEDUP    (SIM_GTRESET_SPEEDUP ),
    .SIMULATION             (SIMULATION          ),
    .STABLE_CLOCK_PERIOD    (STABLE_CLOCK_PERIOD ),
    .P_SCRAMBLE_LOOPBACK    (P_SCRAMBLE_LOOPBACK),
    .P_GEARBOX_LOOPBACK     (P_GEARBOX_LOOPBACK)
  ) u_prbs_test (

    .ref_clk_n_i    (~ref_clk),
    .ref_clk_p_i    (ref_clk),
    .debug_o        (),
    .gt_rxn_i       (gthxn),
    .gt_rxp_i       (gthxp),
    .gt_txn_o       (gthxn),
    .gt_txp_o       (gthxp),

    // User-provided ports for reset helper block(s)
    .sys_clk_i      (free_clk),
    .sys_reset_i    (reset_all),
    .link_up_o      ()
  );

  initial begin
    #100us;
    $stop;
  end
endmodule