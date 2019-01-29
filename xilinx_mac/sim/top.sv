`timescale 1ns / 100ps
module top;


	logic                         tx_clk0;
	logic                         reset;
	logic                         tx_axis_aresetn;
	logic [63 : 0]                tx_axis_tdata;
	logic [7:0]                   tx_axis_tkeep;
	logic                         tx_axis_tvalid;
	logic                         tx_axis_tlast;
	logic                         tx_axis_tuser;
	logic [7:0]                   tx_ifg_delay;
	logic                         tx_axis_tready;
	logic [25 : 0]                tx_statistics_vector;
	logic                         tx_statistics_valid;
	logic [15 : 0]                pause_val;
	logic                         pause_req;
	logic                         rx_axis_aresetn;
	logic [63 : 0]                rx_axis_tdata;
	logic [7 : 0]                 rx_axis_tkeep;
	logic                         rx_axis_tvalid;
	logic                         rx_axis_tuser;
	logic                         rx_axis_tlast;
	logic [29 : 0]                rx_statistics_vector;
	logic                         rx_statistics_valid;
	logic [79: 0]                 tx_configuration_vector;
	logic [79 : 0]                rx_configuration_vector;
	logic [2 : 0]                 status_vector;
	logic                         tx_dcm_locked;
	logic [63 : 0]                xgmii_txd;
	logic [7 : 0]                 xgmii_txc;
	logic                         rx_clk0;
	logic                         rx_dcm_locked;
	logic [63 : 0]                xgmii_rxd;
	logic [7 : 0]                 xgmii_rxc;

	always #5 tx_clk0 = ~tx_clk0;
	always #5 rx_clk0 = ~rx_clk0;
	assign  pause_req = 1'b0;
	assign  pause_val = 0;
	assign  tx_ifg_delay = 0;
	initial begin
		tx_clk0	= 1'b0;
		rx_clk0	= 1'b0;
		tx_axis_aresetn = 1'b0;
		rx_axis_aresetn = 1'b0;
		reset = 1'b1;
		tx_dcm_locked = 1'b0;
		rx_dcm_locked = 1'b0;
	    tx_configuration_vector = 80'h0605040302da00000022;
	    rx_configuration_vector = 80'h0605040302da00000022;
		#1000;
		reset = 1'b0;
		tx_axis_aresetn = 1'b1;
		rx_axis_aresetn = 1'b1;
	    tx_configuration_vector = 80'h0605040302da00000023;
	    rx_configuration_vector = 80'h0605040302da00000023;
		#1000;
		tx_dcm_locked = 1'b1;
		rx_dcm_locked = 1'b1;
		#1000;
	    tx_configuration_vector = 80'h0605040302da00000022;
	    rx_configuration_vector = 80'h0605040302da00000022;
		
	end
	assign  xgmii_rxc = xgmii_txc;
	assign  xgmii_rxd = xgmii_txd;
	
ten_gig_eth_mac_0 xgmac_i (
	.reset                              (reset),
	.tx_axis_aresetn                    (tx_axis_aresetn),
	// .tx_axis_tdata                      ({tx_axis_tdata[7:0],tx_axis_tdata[15:8],tx_axis_tdata[23:16],tx_axis_tdata[31:24],tx_axis_tdata[39:32],tx_axis_tdata[47:40],tx_axis_tdata[55:48],tx_axis_tdata[63:56]}),
	.tx_axis_tdata                      (tx_axis_tdata),
	.tx_axis_tvalid                     (tx_axis_tvalid),
	.tx_axis_tlast                      (tx_axis_tlast),
	.tx_axis_tuser                      (tx_axis_tuser),
	.tx_ifg_delay                       (tx_ifg_delay),
	.tx_axis_tkeep                      (tx_axis_tkeep),
	.tx_axis_tready                     (tx_axis_tready),
	.tx_statistics_vector               (tx_statistics_vector),
	.tx_statistics_valid                (tx_statistics_valid),
	.pause_val                          (pause_val),
	.pause_req                          (pause_req),
	.rx_axis_aresetn                    (rx_axis_aresetn),
	.rx_axis_tdata                      (rx_axis_tdata),
	.rx_axis_tkeep                      (rx_axis_tkeep),
	.rx_axis_tvalid                     (rx_axis_tvalid),
	.rx_axis_tuser                      (rx_axis_tuser),
	.rx_axis_tlast                      (rx_axis_tlast),
	.rx_statistics_vector               (rx_statistics_vector),
	.rx_statistics_valid                (rx_statistics_valid),
	.tx_configuration_vector            (tx_configuration_vector),
	.rx_configuration_vector            (rx_configuration_vector),
	.status_vector                      (status_vector),
	.tx_clk0                            (tx_clk0),
	.tx_dcm_locked                      (tx_dcm_locked),
	.xgmii_txd                          (xgmii_txd),
	.xgmii_txc                          (xgmii_txc),
	.rx_clk0                            (rx_clk0),
	.rx_dcm_locked                      (rx_dcm_locked),
	.xgmii_rxd                          (xgmii_rxd),
	.xgmii_rxc                          (xgmii_rxc));
   
	sim_stream_master u_sim_stream_master(
		.clk_i				(tx_clk0),
		.rst_i				(reset),

		//stream master
		.m_axis_valid_o		(tx_axis_tvalid),
		.m_axis_data_o		(tx_axis_tdata),
		.m_axis_keep_o		(tx_axis_tkeep),
		.m_axis_vldb_o		(),
		.m_axis_sop_o		(),
		.m_axis_eop_o		(tx_axis_tlast),
		.m_axis_err_o       (tx_axis_tuser),
		.m_axis_ready_i		(tx_axis_tready)
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
		#4000;
		
		packet = "845b12625b9d8cec4b5af40008004500012e5681400080060000c0a8015865e2d32eecd601bba19249d153515dc1501800fffc310000";
		for(int i = 0; i < 30; i=i+1) begin
			packet = {packet,$psprintf("%02h",i%256)};
		end
		stream = string2bq(packet.substr(0,60*2+1));
        u_sim_stream_master.write(stream);

	end
	// initial begin
		// tx_axis_tdata	<= 'd0;
		// tx_axis_tvalid  <= 'd0;
		// tx_axis_tlast   <= 'd0;
		// tx_axis_tuser   <= 'd0;
		// tx_axis_tkeep   <= 'd0;
		
		// #4000;
		// repeat(10) begin
			// @(posedge tx_clk0) begin
				// tx_axis_tdata	<= 64'h0045000304054500;
				// tx_axis_tvalid  <= 1'd1;
				// tx_axis_tlast   <= 1'd0;
				// tx_axis_tuser   <= 1'd0;
				// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
			// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 64'h02020304050607;
			// tx_axis_tvalid  <= 1'd1;
			// tx_axis_tlast   <= 1'd1;
			// tx_axis_tuser   <= 1'd0;
			// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 'd0;
			// tx_axis_tvalid  <= 'd0;
			// tx_axis_tlast   <= 'd0;
			// tx_axis_tuser   <= 'd0;
			// tx_axis_tkeep   <= 'd0;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// #100;
		// repeat(10) begin
			// @(posedge tx_clk0) begin
				// tx_axis_tdata	<= 64'h01020304050607;
				// tx_axis_tvalid  <= 1'd1;
				// tx_axis_tlast   <= 1'd0;
				// tx_axis_tuser   <= 1'd0;
				// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
			// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 64'h02020304050607;
			// tx_axis_tvalid  <= 1'd1;
			// tx_axis_tlast   <= 1'd1;
			// tx_axis_tuser   <= 1'd1;
			// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 'd0;
			// tx_axis_tvalid  <= 'd0;
			// tx_axis_tlast   <= 'd0;
			// tx_axis_tuser   <= 'd0;
			// tx_axis_tkeep   <= 'd0;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// #100;
		// repeat(10) begin
			// @(posedge tx_clk0) begin
				// tx_axis_tdata	<= 64'h01020304050607;
				// tx_axis_tvalid  <= 1'd1;
				// tx_axis_tlast   <= 1'd0;
				// tx_axis_tuser   <= 1'd0;
				// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
			// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 64'h02020304050607;
			// tx_axis_tvalid  <= 1'd1;
			// tx_axis_tlast   <= 1'd0;
			// tx_axis_tuser   <= 1'd1;
			// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 64'h03020304050607;
			// tx_axis_tvalid  <= 1'd1;
			// tx_axis_tlast   <= 1'd1;
			// tx_axis_tuser   <= 1'd0;
			// tx_axis_tkeep   <= 8'hff;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		// @(posedge tx_clk0) begin
			// tx_axis_tdata	<= 'd0;
			// tx_axis_tvalid  <= 'd0;
			// tx_axis_tlast   <= 'd0;
			// tx_axis_tuser   <= 'd0;
			// tx_axis_tkeep   <= 'd0;
				// while(~tx_axis_tready) begin
					// @(posedge tx_clk0);
				// end
		// end
		
	// end
endmodule