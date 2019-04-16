
`timescale 1 ps / 1 ps

module teng_phy(
  stable_clk_i,
  stable_reset_i,
  xcvr_ref_clk_i,//156.25M
  xcvr_ref_reset_i,//input pll
  xcvr_rx_i,
  xcvr_tx_o,

  pma_tx_clk_o,
  pma_tx_ready_o,
  pma_tx_data_i,
  pma_rx_clk_o,
  pma_rx_ready_o,
  pma_rx_data_o
);
  input             stable_clk_i;
  input             stable_reset_i;
  input             xcvr_ref_clk_i;
  input             xcvr_ref_reset_i;
  input             xcvr_rx_i;
  output            xcvr_tx_o;
  output            pma_tx_clk_o;
  output            pma_tx_ready_o;
  input   [31:0]    pma_tx_data_i;
  output            pma_rx_clk_o;
  output            pma_rx_ready_o;
  output  [31:0]    pma_rx_data_o;

  wire [0:0]    pll_powerdown;
  wire [0:0]    tx_analogreset;
  wire [0:0]    tx_digitalreset;
  wire [0:0]    tx_pll_refclk;
  wire [0:0]    tx_pma_clkout;
  wire [0:0]    tx_serial_data;
  wire [79:0]   tx_pma_parallel_data;
  wire [0:0]    pll_locked;
  wire [0:0]    rx_analogreset;
  wire [0:0]    rx_digitalreset;
  wire [0:0]    rx_cdr_refclk;
  wire [0:0]    rx_pma_clkout;
  wire [0:0]    rx_serial_data;
  wire [79:0]   rx_pma_parallel_data;
  wire [0:0]    rx_is_lockedtoref;
  wire [0:0]    rx_is_lockedtodata;
  wire [0:0]    tx_cal_busy;
  wire [0:0]    rx_cal_busy;
  wire [139:0]  reconfig_to_xcvr;
  wire [91:0]   reconfig_from_xcvr;

  wire          tx_ready;
  wire          rx_ready;
  wire          pll_select;
  wire          reconfig_busy;
  wire [6:0]    reconfig_mgmt_address;
  wire          reconfig_mgmt_read;
  wire [31:0]   reconfig_mgmt_readdata;
  wire          reconfig_mgmt_waitrequest;
  wire          reconfig_mgmt_write;
  wire [31:0]   reconfig_mgmt_writedata;

  wire          s_xcvr_ref_clk;

  assign  tx_pll_refclk = s_xcvr_ref_clk;
  assign  rx_cdr_refclk = s_xcvr_ref_clk;

  assign  tx_pma_parallel_data = {40'h0,2'b0,pma_tx_data_i[31:24],2'b0,pma_tx_data_i[23:16],2'b0,pma_tx_data_i[15:8],2'b0,pma_tx_data_i[7:0]};
  assign  pma_tx_clk_o = tx_pma_clkout;
  assign  pma_rx_clk_o = rx_pma_clkout;
  assign  pma_rx_data_o = {rx_pma_parallel_data[37:30],rx_pma_parallel_data[27:20],rx_pma_parallel_data[17:10],rx_pma_parallel_data[07:00]};
// 32 bits {[37:30], [27:20], [17:10], [7:0]}
  assign  xcvr_tx_o = tx_serial_data;
  assign  rx_serial_data = xcvr_rx_i;

	pll pll_inst (
		.refclk   (xcvr_ref_clk_i),   //  refclk.clk
		.rst      (xcvr_ref_reset_i),      //   reset.reset
		.outclk_0 (s_xcvr_ref_clk), // outclk0.clk
		.locked   ( )    //  locked.export
	);
//
//  assign  s_xcvr_ref_clk = xcvr_ref_clk_i;
nphy u_nphy (
		.        pll_powerdown(pll_powerdown),            //input  wire [0:0]   pll_powerdown,        //
		.       tx_analogreset(tx_analogreset),           //input  wire [0:0]   tx_analogreset,       //
		.      tx_digitalreset(tx_digitalreset),          //input  wire [0:0]   tx_digitalreset,      //
		.        tx_pll_refclk(tx_pll_refclk),            //input  wire [0:0]   tx_pll_refclk,        //
		.        tx_pma_clkout(tx_pma_clkout),            //output wire [0:0]   tx_pma_clkout,        //
		.       tx_serial_data(tx_serial_data),           //output wire [0:0]   tx_serial_data,       //
		. tx_pma_parallel_data(tx_pma_parallel_data),     //input  wire [79:0]  tx_pma_parallel_data, //
		.           pll_locked(pll_locked),               //output wire [0:0]   pll_locked,           //
		.       rx_analogreset(rx_analogreset),           //input  wire [0:0]   rx_analogreset,       //
		.      rx_digitalreset(rx_digitalreset),          //input  wire [0:0]   rx_digitalreset,      //
		.        rx_cdr_refclk(rx_cdr_refclk),            //input  wire [0:0]   rx_cdr_refclk,        //
		.        rx_pma_clkout(rx_pma_clkout),            //output wire [0:0]   rx_pma_clkout,        //
		.       rx_serial_data(rx_serial_data),           //input  wire [0:0]   rx_serial_data,       //
		. rx_pma_parallel_data(rx_pma_parallel_data),     //output wire [79:0]  rx_pma_parallel_data, //
		.    rx_is_lockedtoref(rx_is_lockedtoref),        //output wire [0:0]   rx_is_lockedtoref,    //
		.   rx_is_lockedtodata(rx_is_lockedtodata),       //output wire [0:0]   rx_is_lockedtodata,   //
		.          tx_cal_busy(tx_cal_busy),              //output wire [0:0]   tx_cal_busy,          //
		.          rx_cal_busy(rx_cal_busy),              //output wire [0:0]   rx_cal_busy,          //
		.     reconfig_to_xcvr(reconfig_to_xcvr),         //input  wire [139:0] reconfig_to_xcvr,     //
		.   reconfig_from_xcvr(reconfig_from_xcvr)        //output wire [91:0]  reconfig_from_xcvr    //
	);

assign  pll_select = 1'b0;
assign  pma_tx_ready_o = tx_ready;
assign  pma_rx_ready_o = rx_ready;

xcvr_reset u_xcvr_reset (
		.              clock(stable_clk_i),               //input  wire       clock,              //
		.              reset(stable_reset_i),             //input  wire       reset,              //
		.      pll_powerdown(pll_powerdown),              //output wire [0:0] pll_powerdown,      //
		.     tx_analogreset(tx_analogreset),             //output wire [0:0] tx_analogreset,     //
		.    tx_digitalreset(tx_digitalreset),            //output wire [0:0] tx_digitalreset,    //
		.           tx_ready(tx_ready),                   //output wire [0:0] tx_ready,           //
		.         pll_locked(pll_locked),                 //input  wire [0:0] pll_locked,         //
		.         pll_select(pll_select),                 //input  wire [0:0] pll_select,         //
		.        tx_cal_busy(tx_cal_busy),                //input  wire [0:0] tx_cal_busy,        //
		.     rx_analogreset(rx_analogreset),             //output wire [0:0] rx_analogreset,     //
		.    rx_digitalreset(rx_digitalreset),            //output wire [0:0] rx_digitalreset,    //
		.           rx_ready(rx_ready),                   //output wire [0:0] rx_ready,           //
		. rx_is_lockedtodata(rx_is_lockedtodata),         //input  wire [0:0] rx_is_lockedtodata, //
		.        rx_cal_busy(rx_cal_busy)                 //input  wire [0:0] rx_cal_busy         //
	);

xcvr_reconfig u_xcvr_reconfig (
		.            reconfig_busy(reconfig_busy),              //output wire         reconfig_busy,             //
		.             mgmt_clk_clk(stable_clk_i),               //input  wire         mgmt_clk_clk,              //
		.           mgmt_rst_reset(stable_reset_i),             //input  wire         mgmt_rst_reset,            //
		.    reconfig_mgmt_address(reconfig_mgmt_address),      //input  wire [6:0]   reconfig_mgmt_address,     //
		.       reconfig_mgmt_read(reconfig_mgmt_read),         //input  wire         reconfig_mgmt_read,        //
		.   reconfig_mgmt_readdata(reconfig_mgmt_readdata),     //output wire [31:0]  reconfig_mgmt_readdata,    //
		.reconfig_mgmt_waitrequest(reconfig_mgmt_waitrequest),  //output wire         reconfig_mgmt_waitrequest, //
		.      reconfig_mgmt_write(reconfig_mgmt_write),        //input  wire         reconfig_mgmt_write,       //
		.  reconfig_mgmt_writedata(reconfig_mgmt_writedata),    //input  wire [31:0]  reconfig_mgmt_writedata,   //
		.         reconfig_to_xcvr(reconfig_to_xcvr),           //output wire [139:0] reconfig_to_xcvr,          //
		.       reconfig_from_xcvr(reconfig_from_xcvr)          //input  wire [91:0]  reconfig_from_xcvr         //
	);

endmodule