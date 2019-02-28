
`timescale 1ns/1ns
module tb_gearbox_prbs();

  logic   clk;
  logic   rst;

  logic       [31:0]      l_64_66_data_out;
  logic       [1:0]       l_64_66_head;
  logic                   l_64_66_head_valid;
  logic                   l_64_66_head_valid_d1;
  logic                   l_64_66_slip;
  logic       [31:0]      l_64_66_data_in;

  logic       [31:0]      l_66_64_data_in;
  logic       [5:0]       l_66_64_head;
  logic       [6:0]       l_66_64_sequence;
  logic       [31:0]      l_66_64_data_out;

  logic       [6:0]       txsequence_out;
  logic       [6:0]       txsequence_out_d1;

  initial begin
    clk = 1'b0;
    rst = 1'b1;

    #100;
    rst = 1'b0;
  end
  always #5 clk = ~clk;

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
  always @(posedge clk) begin
    if(rst) begin
      txsequence_out_d1 <= 'd0;
    end else begin
      txsequence_out_d1 <= txsequence_out;
    end
  end
  assign  l_66_64_sequence = (txsequence_out != txsequence_out_d1) ? (txsequence_out << 1) :
                             (txsequence_out << 1) + 1;
  gearbox_66b_64b u_gearbox_66b_64b (

    // Clks and resets
    .clk_i          (clk),
    .rst_i          (rst),

    .data_i         (l_66_64_data_in),
    .head_i         (l_66_64_head[1:0]),
    .sequence_i     (l_66_64_sequence),

    .data_o         (l_66_64_data_out)
  );

  always @(posedge clk) begin
    if(rst) begin
      l_64_66_head_valid_d1 <= 'd0;
    end else begin
      l_64_66_head_valid_d1 <= l_64_66_head_valid;
    end
  end
  assign  l_64_66_data_in = l_66_64_data_out;
  
  gtwizard_ultrascale_0_example_checking_64b66b u_check(
    .gtwiz_reset_all_in           (rst),
    .gtwiz_userclk_rx_usrclk2_in  (clk),
    .gtwiz_userclk_rx_active_in   (1'b1),
    .rxdatavalid_in               ({1'b0, l_64_66_head_valid|l_64_66_head_valid_d1}),
    .rxgearboxslip_out            (l_64_66_slip),
    .rxdata_in                    (l_64_66_data_out),
    .prbs_match_out               ()
  );
  gtwizard_ultrascale_0_example_stimulus_64b66b u_stimu(
    .gtwiz_reset_all_in           (rst),
    .gtwiz_userclk_tx_usrclk2_in  (clk),
    .gtwiz_userclk_tx_active_in   (1'b1),
    .txheader_out                 (l_66_64_head),
    .txsequence_out               (txsequence_out),
    .txdata_out                   (l_66_64_data_in)
  );


endmodule