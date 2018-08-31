///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-30
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module tb_single_loopback();

  // -------------------------------------------------------------------------------------------------------------------
  // Signal declarations and basic example design stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // Declare wires to loop back serial data ports for transceiver channel 0
  wire ch0_gthxn;
  wire ch0_gthxp;

  // Declare register to drive reference clock at location MGTREFCLK0_X0Y0
  reg mgtrefclk0_x0y0 = 1'b0;

  // Drive that reference clock at the appropriate frequency
  // NOTE: the following simulation reference clock period may be up to +/- 2ps from its nominal value, due to rounding
  // within Verilog timescale granularity, especially when transmitter and receiver reference clock frequencies differ
  initial begin
    mgtrefclk0_x0y0 = 1'b0;
    forever
      mgtrefclk0_x0y0 = #3200 ~mgtrefclk0_x0y0;
  end

  // Declare registers to drive reset helper block(s)
  reg hb_gtwiz_reset_clk_freerun = 1'b0;
  reg hb_gtwiz_reset_all         = 1'b1;

  // Drive the helper block free running clock
  initial begin
    hb_gtwiz_reset_clk_freerun = 1'b0;
    forever
      hb_gtwiz_reset_clk_freerun = #2000 ~hb_gtwiz_reset_clk_freerun;
  end

  // Drive the helper block "reset all" input high, then low after some time
  initial begin
    hb_gtwiz_reset_all = 1'b1;
    #5E6;
    repeat (100)
      @(hb_gtwiz_reset_clk_freerun);
    hb_gtwiz_reset_all = 1'b0;
  end

    wire          rx_user_clk;         // 156.25*2 clk 
    wire          rx_user_rst;         // sync to user_clk_o
    wire  [63:0]  xgmii_rxd;        // sync to user_clk_o
    wire  [ 7:0]  xgmii_rxc;        // 
    wire          xgmii_rxd_vld;

    wire          tx_user_clk;         // 156.25*2 clk 
    wire          tx_user_rst;         // sync to user_clk_o
    reg   [63:0]  xgmii_txd;        // sync to user_clk_o
    reg   [ 7:0]  xgmii_txc;
    reg           xgmii_txd_vld;     // xgmii txd valid

    pcs_top u_pcs_top(

        .gthrxp_i           (ch0_gthxp),
        .gthrxn_i           (ch0_gthxn),
        .gthtxp_o           (ch0_gthxp),
        .gthtxn_o           (ch0_gthxn),
        .gtrefclk00p_i      (mgtrefclk0_x0y0),
        .gtrefclk00n_i      (~mgtrefclk0_x0y0),
    
        // User-provided ports for reset helper block(s)
        .hb_gtwiz_reset_clk_freerun_in  (hb_gtwiz_reset_clk_freerun),
        .hb_gtwiz_reset_all_in          (hb_gtwiz_reset_all),

        .rx_user_clk_o      (rx_user_clk),         // 156.25*2 clk 
        .rx_user_rst_o      (rx_user_rst),         // sync to user_clk_o
        .xgmii_rxd_o        (xgmii_rxd),        // sync to user_clk_o
        .xgmii_rxc_o        (xgmii_rxc),        // 
        .xgmii_rxd_vld_o    (xgmii_rxd_vld),

        .tx_user_clk_o      (tx_user_clk),         // 156.25*2 clk 
        .tx_user_rst_o      (tx_user_rst),         // sync to user_clk_o
        .xgmii_txd_i        (xgmii_txd),        // sync to user_clk_o
        .xgmii_txc_i        (xgmii_txc),
        .xgmii_txd_vld_i    (xgmii_txd_vld)     // xgmii txd valid
    );

    always @(posedge tx_user_clk) begin
        if(tx_user_rst) begin
            xgmii_txd       <= 64'h07070707_07070707;
            xgmii_txc       <= 8'hff;
            xgmii_txd_vld   <= 1'b0; 
        end else begin
            xgmii_txd_vld   <= ~xgmii_txd_vld; 
            xgmii_txd       <= 64'h07070707_07070707;
            xgmii_txc       <= 8'hff;
        end
    end 

endmodule