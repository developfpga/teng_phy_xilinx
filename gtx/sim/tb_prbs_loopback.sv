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
  // parameter                 P_XGMII_LOOPBACK = 1'b0;
  parameter                 P_SCRAMBLE_LOOPBACK = 1'b1;
  parameter                 P_GEARBOX_LOOPBACK = 1'b0;

  // -------------------------------------------------------------------------------------------------------------------
  // Signal declarations and basic example design stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // Declare wires to loop back serial data ports for transceiver channel 0
  wire gthxn;
  wire gthxp;

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
      free_clk = #2000 ~free_clk;
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
    .P_SCRAMBLE_LOOPBACK    (P_SCRAMBLE_LOOPBACK),
    .P_GEARBOX_LOOPBACK     (P_GEARBOX_LOOPBACK)
  ) u_prbs_test (

    .refclk_n_i     (~ref_clk),
    .refclk_p_i     (ref_clk),
    .debug_o        (),
    .gthrxn_i       (gthxn),
    .gthrxp_i       (gthxp),
    .gthtxn_o       (gthxn),
    .gthtxp_o       (gthxp),
    
    // User-provided ports for reset helper block(s)
    .free_clk_i     (free_clk),
    .rst_i          (reset_all),
    .link_status_out()
  );
  
  initial begin
    #100us;
    $stop;
  end
endmodule