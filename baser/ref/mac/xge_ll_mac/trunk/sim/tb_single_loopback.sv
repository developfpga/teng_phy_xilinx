///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-30
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module tb_single_loopback();

  logic clk;
  logic rst_n;

  logic           tx_start     ;
  logic   [63:0]  tx_data      ;
  logic   [ 7:0]  tx_data_valid;
  logic   [63:0]  xgmii_rxd    ;
  logic   [ 7:0]  xgmii_rxc    ;

  logic           tx_ack       ;
  logic           rx_bad_frame ;
  logic           rx_good_frame;
  logic   [63:0]  rx_data      ;
  logic   [ 7:0]  rx_data_valid;
  logic   [ 7:0]  xgmii_txc    ;
  logic   [63:0]  xgmii_txd    ;



  initial begin
    clk = 1'b0;
    forever
      clk = #3200 ~clk;
  end

  // Declare registers to drive reset helper block(s)
  // reg rst_n         = 1'b1;


  // Drive the helper block "reset all" input high, then low after some time
  initial begin
    rst_n = 1'b0;
    repeat (100)
      @(clk);
    rst_n = 1'b1;
  end


  assign  xgmii_rxd = xgmii_txd;
  assign  xgmii_rxc = xgmii_txc;


oc_mac u_oc_mac (
	.res_n          (rst_n),
	.clk            (clk),
	.tx_start       (tx_start     ),
	.tx_data        (tx_data      ),
	.tx_data_valid  (tx_data_valid),
	.xgmii_rxd      (xgmii_rxd    ),  
	.xgmii_rxc      (xgmii_rxc    ),

	.tx_ack         (tx_ack       ),
	.rx_bad_frame   (rx_bad_frame ),
	.rx_good_frame  (rx_good_frame),
	.rx_data        (rx_data      ),
	.rx_data_valid  (rx_data_valid),
	.xgmii_txc      (xgmii_txc    ),
	.xgmii_txd      (xgmii_txd    )
	);

  logic   [7:0] r_send_timer;
  always @(posedge clk) begin
    if(rst_n == 1'b0) begin
      r_send_timer  <= 8'b0;
    end else begin
      r_send_timer  <= r_send_timer + 1;
    end
  end

  always @(posedge clk) begin
    if(rst_n == 1'b0) begin
      tx_start      <= 1'b0;
      tx_data       <= 64'h0;
      tx_data_valid <= 8'b0;
    end else begin
      if(r_send_timer > 240) begin
        tx_start      <= 1'b1;
        tx_data       <= 64'h01020304_05060708;
        tx_data_valid <= 8'hff;
      end else begin
        tx_start      <= 1'b0;
        tx_data       <= 64'h0;
        tx_data_valid <= 8'b0;
      end
    end
  end



endmodule