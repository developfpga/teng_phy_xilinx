
`timescale 1ns/1ns
module tb_gearbox_loopback();

  logic   clk;
  logic   rst;

  logic        [31:0]      l_64_66_data_out;
  logic        [1:0]       l_64_66_head;
  logic                    l_64_66_head_valid;
  logic                    l_64_66_slip;
  logic        [31:0]      l_64_66_data_in;

  logic        [31:0]      l_66_64_data_in;
  logic        [1:0]       l_66_64_head;
  logic        [6:0]       l_66_64_sequence;
  logic        [31:0]      l_66_64_data_out;

  logic        [6:0]       l_66_64_count;
  logic        [63:0]      l_66_64_output;

  logic                    r_rx_data_compare;
  logic                    r_rx_data_compare_d1;
  logic        [31:0]      r_rx_data_last32;
  logic        [63:0]      r_rx_data_last64;
  integer                  r_rx_data_right_cnt;

  gearbox_64b_66b u_gearbox_64b_66b (

    // Clks and resets
    .clk_i          (clk),
    .rst_i          (rst),

    .data_o         (l_64_66_data_out),
    .head_o         (l_64_66_head),
    .head_valid_o   (l_64_66_head_valid),
    .slip_i         (l_64_66_slip),
    // .slip_i         (1'b0),

    .data_i         (l_64_66_data_in)
  );

  gearbox_66b_64b u_gearbox_66b_64b (

    // Clks and resets
    .clk_i          (clk),
    .rst_i          (rst),

    .data_i         (l_66_64_data_in),
    .head_i         (l_66_64_head),
    .sequence_i     (l_66_64_sequence),

    .data_o         (l_66_64_data_out)
  );

  assign  l_64_66_data_in = l_66_64_data_out;

  wire  s_sequence_match;
  assign  s_sequence_match = (u_gearbox_64b_66b.r_count == u_gearbox_66b_64b.sequence_i);
	// sim_clock_reset #(
	// 	.CLOCK_PERIOD	(5),
	// 	.RESET_DURATION (100)
	// )u_sim_clock_reset(
	// 	.clk_o					(clk),
	// 	.rst_o          (rst)
	// );
  initial begin
    clk = 1'b0;
    rst = 1'b1;

    #100;
    rst = 1'b0;
  end
  always #5 clk = ~clk;
// tx
  always @(posedge clk) begin
    if(rst) begin
      l_66_64_count  <= 'd0;
    end else begin
      if(l_66_64_count == 7'd65) begin
        l_66_64_count  <= 7'd0;
      end else begin
        l_66_64_count  <= l_66_64_count + 7'd1;
      end
    end
  end

  always @(posedge clk) begin
    if(rst) begin
      l_66_64_output  <= 'd0;
    end else begin
      l_66_64_output  <= l_66_64_output + l_66_64_count[0];
    end
  end

  always @(posedge clk) begin
    if(rst) begin
      l_66_64_sequence  <= 'd0;
      l_66_64_data_in   <= 'd0;
      l_66_64_head      <= 'd0;
    end else begin
      l_66_64_sequence  <= l_66_64_count;
      if(l_66_64_count[0]) begin
        l_66_64_data_in   <= l_66_64_output[31:0];
        // l_66_64_data_in   <= 32'h00ff00ff;
      end else begin
        l_66_64_data_in   <= l_66_64_output[63:32];
        // l_66_64_data_in   <= 32'h00ff00ff;
      end
      l_66_64_head      <= 2'b01;
    end
  end

  always @(posedge clk) begin
    if(rst) begin

    end else begin

    end
  end
// rx
  rx_alignment #(
    .P_SLIP_GAP_WIDTH (8)
  )u_rx_alignment(
    .clk_i              (clk),              // Freq = 156.25*2
    .rst_i              (rst),

    .gtwiz_userdata_rx_i(l_64_66_data_out),
    .rxheader_i         (l_64_66_head[1:0]),
    .rxheadervalid_i    (l_64_66_head_valid),

    .rxgearboxslip_o    (l_64_66_slip),
    .locked             (s_rx_lane_locked)
  );

  always @(posedge clk) begin
    if(rst) begin
      r_rx_data_compare   <= 'd0;
      r_rx_data_compare_d1<= 'd0;
      r_rx_data_last32    <= 'd0;
      r_rx_data_last64    <= 'd0;
      r_rx_data_right_cnt <= 'd0;
    end else begin
      if(l_64_66_head_valid & s_rx_lane_locked) begin
        r_rx_data_compare   <= 1'b1;
      end
      r_rx_data_compare_d1<= r_rx_data_compare;
      if(r_rx_data_compare & ~s_rx_lane_locked) begin
        $error("rx lost data alignment");
      end
      // r_rx_lane_locked    <= s_rx_lane_locked;
      r_rx_data_last32    <= l_64_66_data_out;
      if(r_rx_data_compare & ~l_64_66_head_valid) begin
        r_rx_data_last64    <= {r_rx_data_last32, l_64_66_data_out};
      end
      // if(r_rx_data_compare & r_rx_data_compare_d1 & ~l_64_66_head_valid) begin
      //   if(r_rx_data_last64 != {r_rx_data_last32, l_64_66_data_out} + 64'h1) begin
      //     $error("rx data error, last data is %x, this data is %x", r_rx_data_last64, {r_rx_data_last32, l_64_66_data_out});
      //   end else begin
      //     r_rx_data_right_cnt <= r_rx_data_right_cnt + 'd1;
      //     if(r_rx_data_right_cnt == 10000) begin
      //       $display("test pass");
      //       $finish;
      //     end
      //   end
      // end
    end
  end


endmodule