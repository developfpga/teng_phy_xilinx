///////////////////////////////////////////////////////////////////////////////
//
// date : 2019-2-13
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module tb_system_across();

  // -------------------------------------------------------------------------------------------------------------------
  // Signal declarations and basic example design stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // Declare wires to loop back serial data ports for transceiver channel 0
  wire ch0_gthtxn;
  wire ch0_gthtxp;
  wire ch0_gthrxn;
  wire ch0_gthrxp;

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

  wire                tx_user_clk;         // 156.25*2 clk
  wire                tx_user_rst;         // sync to user_clk_o
  wire    [31:0]      s_tx_data;
  wire    [1:0]       s_tx_vldb;
  wire                s_tx_valid;
  wire                s_tx_ready;
  wire                s_tx_last;
  wire    [0:0]       s_tx_user;

  wire                rx_user_clk;         // 156.25*2 clk
  wire                rx_user_rst;         // sync to user_clk_o
  wire    [31:0]      s_rx_data;
  wire    [1:0]       s_rx_vldb;
  wire                s_rx_valid;
  wire                s_rx_last;
  wire    [0:0]       s_rx_user;


  pcs_top u_pcs_top(

    .gthrxp_i           (ch0_gthrxp),
    .gthrxn_i           (ch0_gthrxn),
    .gthtxp_o           (ch0_gthtxp),
    .gthtxn_o           (ch0_gthtxn),
    .refclk_p_i         (mgtrefclk0_x0y0),
    .refclk_n_i         (~mgtrefclk0_x0y0),

    // User-provided ports for reset helper block(s)
    .hb_gtwiz_reset_clk_freerun_in  (hb_gtwiz_reset_clk_freerun),
    .hb_gtwiz_reset_all_in          (hb_gtwiz_reset_all),

    .link_status_out    (),

    .tx_user_clk_o      (tx_user_clk),         // 156.25*2 clk
    .tx_user_rst_o      (tx_user_rst),        // sync to user_clk_o
    .tx_data_i          (s_tx_data),
    .tx_vldb_i          (s_tx_vldb),
    .tx_valid_i         (s_tx_valid),
    .tx_ready_o         (s_tx_ready),
    .tx_last_i          (s_tx_last),
    .tx_user_i          (s_tx_user),

    .tx_status_o        (),
    .tx_rsp_valid_o     (),

    .rx_user_clk_o      (rx_user_clk),         // 156.25*2 clk
    .rx_user_rst_o      (rx_user_rst),         // sync to user_clk_o
    .rx_data_o          (s_rx_data),
    .rx_vldb_o          (s_rx_vldb),
    .rx_valid_o         (s_rx_valid),
    .rx_last_o          (s_rx_last),
    .rx_user_o          (s_rx_user)
  );
	sim_stream_master #(
    .DATA_W             (32)
  )u_dut_stream_master(
		.clk_i				      (tx_user_clk),
		.rst_i				      (tx_user_rst),

		//stream master
		.m_axis_valid_o		  (s_tx_valid),
		.m_axis_data_o		  (s_tx_data),
		.m_axis_keep_o		  (),
		.m_axis_vldb_o		  (s_tx_vldb),
		.m_axis_sop_o		    (),
		.m_axis_eop_o		    (s_tx_last),
		.m_axis_err_o       (s_tx_user),
		.m_axis_ready_i		  (s_tx_ready)
	);

  wire    coreclk_out;
  wire    core_ready;
  wire    xilinx_txn;
  wire    xilinx_txp;
  wire    xilinx_rxn;
  wire    xilinx_rxp;
  wire     [63:0]   tx_axis_tdata;
  wire     [7:0]    tx_axis_tkeep;
  wire              tx_axis_tvalid;
  wire              tx_axis_tlast;
  wire              tx_axis_tready;
  wire     [63:0]   rx_axis_tdata;
  wire     [7:0]    rx_axis_tkeep;
  wire              rx_axis_tvalid;
  wire              rx_axis_tlast;
  wire              rx_axis_tready;

  reg               sysclk;
  reg               sim_speedup_control_pulse;
  initial                 // clock pretens to be SYSCK input to the MMCM of the example design
  begin
     sysclk <= 0;
     forever
     begin
        #1666;            // 300 MHz MMCM in CLK
        sysclk <= 1;
        #1667;
        sysclk <= 0;
     end
  end

 initial                 // stimulate sim_speedup_control port
  begin
     sim_speedup_control_pulse <= 0;
     forever
     begin
        #210000;
        sim_speedup_control_pulse <= 1;
     end
  end
  // assign  tx_axis_tdata = 'b0;
  // assign  tx_axis_tkeep = 'b0;
  // assign  tx_axis_tvalid = 1'b0;
  // assign  tx_axis_tlast = 1'b0;
  assign  rx_axis_tready = 1'b1;
  axi_10g_ethernet_0_wrapper xilinx
  (
    .reset                  (hb_gtwiz_reset_all),

    .refclk_p               (mgtrefclk0_x0y0),         // Transcevier reference clock source
    .refclk_n               (!mgtrefclk0_x0y0),
    .coreclk_out            (coreclk_out),

    .clk_in_p               (sysclk),         // Freerunning clock source
    .clk_in_n               (!sysclk),

    .enable_custom_preamble (1'b0),

    .pcs_loopback           (1'b0),

    .sim_speedup_control    (sim_speedup_control_pulse),
    .qplllock_out           (),
    .serialized_stats       (),
    .core_ready             (core_ready),

    .rx_axis_tdata              (rx_axis_tdata),
    .rx_axis_tkeep              (rx_axis_tkeep),
    .rx_axis_tvalid             (rx_axis_tvalid),
    .rx_axis_tlast              (rx_axis_tlast),
    .rx_axis_tready             (rx_axis_tready),
    .tx_axis_tdata              (tx_axis_tdata),
    .tx_axis_tkeep              (tx_axis_tkeep),
    .tx_axis_tvalid             (tx_axis_tvalid),
    .tx_axis_tlast              (tx_axis_tlast),
    .tx_axis_tready             (tx_axis_tready),
    
    .txp                    (xilinx_txp),
    .txn                    (xilinx_txn),
    .rxp                    (xilinx_rxp),
    .rxn                    (xilinx_rxn)
  );

  assign  ch0_gthrxn = ch0_gthtxn;
  assign  ch0_gthrxp = ch0_gthtxp;
  // assign  xilinx_rxn = ch0_gthtxn;
  // assign  xilinx_rxp = ch0_gthtxp;
  assign  xilinx_rxn = xilinx_txn;
  assign  xilinx_rxp = xilinx_txp;
	sim_stream_master #(
    .DATA_W             (64)
  )u_xilinx_stream_master(
		.clk_i				      (coreclk_out),
		.rst_i				      (tx_user_rst),

		//stream master
		.m_axis_valid_o		  (tx_axis_tvalid),
		.m_axis_data_o		  (tx_axis_tdata),
		.m_axis_keep_o		  (tx_axis_tkeep),
		.m_axis_vldb_o		  (),
		.m_axis_sop_o		    (),
		.m_axis_eop_o		    (tx_axis_tlast),
		.m_axis_err_o       (),
		.m_axis_ready_i		  (tx_axis_tready)
	);

	string packet = "";
  typedef logic [7:0] q_pkt_t[$];
	q_pkt_t stream;

	function q_pkt_t string2bq;
		input string string_in;
		automatic q_pkt_t q = {};
		automatic integer len = 0;
		automatic integer i = 0;
		begin
			len = string_in.len();
			if(string_in.len() % 2 != 0) begin
				$display("error : function string2bq input string is not even , len is %d", string_in.len() );
				return q;
			end
			while(i < len/2) begin
				q.push_back(string_in.substr(i*2,i*2+1).atohex());
				i = i + 1;
			end
			return q;
		end
	endfunction

	// assign  tx_axis_tuser = 1'b0;
	initial begin
		#50us;

		packet = "845b12625b9d8cec4b5af40008004500012e5681400080060000c0a8015865e2d32eecd601bba19249d153515dc1501800fffc310000";
		for(int i = 0; i < 30; i=i+1) begin
			packet = {packet,$psprintf("%02h",i%256)};
		end
		stream = string2bq(packet.substr(0,70*2+1));
    u_dut_stream_master.write(stream);
    u_xilinx_stream_master.write(stream);

    #10us;
    $stop;
	end
endmodule