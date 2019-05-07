`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/02/20 10:38:27
// Design Name:
// Module Name: gearbox_66_64
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module gearbox_66b_64b (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  input        [31:0]      data_i,
  input        [1:0]       head_i,
  input        [6:0]       sequence_i,

  output       [31:0]      data_o
);
  // wire    [ 5:0]    s_sft_count;
  // wire    [95:0]    s_sft_data_in;
  // wire    [95:0]    s_align_head_data_in;
  // wire    [95:0]    s_align_data_in;
  // reg     [95:0]    r_storage;

  // assign  s_sft_count = {sequence_i[5:1], 1'b0};
  // assign  s_sft_data_in = {head_i, data_i, 62'h0};
  // assign  s_align_head_data_in = sequence_i[6] ? {64'h0} : (s_sft_data_in >> s_sft_count);
  // assign  s_align_data_in = sequence_i[6] ? {64'h0} : (({2'h0, data_i, 62'h0}) >> s_sft_count);
  // always @(posedge clk_i) begin
  //   if(rst_i) begin
  //     r_storage   <= 64'd0;
  //   end else begin
  //     if(~sequence_i[0]) begin
  //       r_storage   <= (r_storage << 6'd32) | s_align_head_data_in;
  //     end else begin
  //       r_storage   <= (r_storage << 6'd32) | s_align_data_in;
  //     end

  //   end
  // end
  // assign  data_o = r_storage[95:64];
  // reg     [ 6:0]    r_sequence;
  // wire    [ 5:0]    s_sft_count;
  // wire    [95:0]    s_sft_data_in;
  // wire    [95:0]    s_align_head_data_in;
  // wire    [95:0]    s_align_data_in;

  reg     [95:0]    r_align_head_data_in;
  // reg     [95:0]    r_align_data_in;
  reg     [95:0]    r_storage;

  // assign  s_sft_count = {sequence_i[5:1], 1'b0};
  // assign  s_sft_data_in = {head_i, data_i, 62'h0};
  // assign  s_align_head_data_in = s_sft_data_in >> s_sft_count;
  // assign  s_align_head_data_in = sequence_i[6] ? {64'h0} : (s_sft_data_in >> s_sft_count);
  // assign  s_align_data_in = sequence_i[6] ? {64'h0} : (({2'h0, data_i, 62'h0}) >> s_sft_count);

  // always @(posedge clk_i) begin
  //   if(rst_i) begin
  //     r_sequence  <= 'd0;
  //   end else begin
  //     r_sequence  <= sequence_i;
  //   end
  // end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_align_head_data_in  <= 'd0;
      // r_align_data_in       <= 'd0;
    end else begin
      // r_align_head_data_in  <= s_align_head_data_in;
      case(sequence_i[5:1])
        5'd0 : begin r_align_head_data_in <= {head_i, data_i, 62'h0}; end
        5'd1 : begin r_align_head_data_in <= { 2'b0, head_i, data_i, 60'h0}; end
        5'd2 : begin r_align_head_data_in <= { 4'b0, head_i, data_i, 58'h0}; end
        5'd3 : begin r_align_head_data_in <= { 6'b0, head_i, data_i, 56'h0}; end
        5'd4 : begin r_align_head_data_in <= { 8'b0, head_i, data_i, 54'h0}; end
        5'd5 : begin r_align_head_data_in <= {10'b0, head_i, data_i, 52'h0}; end
        5'd6 : begin r_align_head_data_in <= {12'b0, head_i, data_i, 50'h0}; end
        5'd7 : begin r_align_head_data_in <= {14'b0, head_i, data_i, 48'h0}; end
        5'd8 : begin r_align_head_data_in <= {16'b0, head_i, data_i, 46'h0}; end
        5'd9 : begin r_align_head_data_in <= {18'b0, head_i, data_i, 44'h0}; end
        5'd10: begin r_align_head_data_in <= {20'b0, head_i, data_i, 42'h0}; end
        5'd11: begin r_align_head_data_in <= {22'b0, head_i, data_i, 40'h0}; end
        5'd12: begin r_align_head_data_in <= {24'b0, head_i, data_i, 38'h0}; end
        5'd13: begin r_align_head_data_in <= {26'b0, head_i, data_i, 36'h0}; end
        5'd14: begin r_align_head_data_in <= {28'b0, head_i, data_i, 34'h0}; end
        5'd15: begin r_align_head_data_in <= {30'b0, head_i, data_i, 32'h0}; end
        5'd16: begin r_align_head_data_in <= {32'b0, head_i, data_i, 30'h0}; end
        5'd17: begin r_align_head_data_in <= {34'b0, head_i, data_i, 28'h0}; end
        5'd18: begin r_align_head_data_in <= {36'b0, head_i, data_i, 26'h0}; end
        5'd19: begin r_align_head_data_in <= {38'b0, head_i, data_i, 24'h0}; end
        5'd20: begin r_align_head_data_in <= {40'b0, head_i, data_i, 22'h0}; end
        5'd21: begin r_align_head_data_in <= {42'b0, head_i, data_i, 20'h0}; end
        5'd22: begin r_align_head_data_in <= {44'b0, head_i, data_i, 18'h0}; end
        5'd23: begin r_align_head_data_in <= {46'b0, head_i, data_i, 16'h0}; end
        5'd24: begin r_align_head_data_in <= {48'b0, head_i, data_i, 14'h0}; end
        5'd25: begin r_align_head_data_in <= {50'b0, head_i, data_i, 12'h0}; end
        5'd26: begin r_align_head_data_in <= {52'b0, head_i, data_i, 10'h0}; end
        5'd27: begin r_align_head_data_in <= {54'b0, head_i, data_i, 08'h0}; end
        5'd28: begin r_align_head_data_in <= {56'b0, head_i, data_i, 06'h0}; end
        5'd29: begin r_align_head_data_in <= {58'b0, head_i, data_i, 04'h0}; end
        5'd30: begin r_align_head_data_in <= {60'b0, head_i, data_i, 02'h0}; end
        5'd31: begin r_align_head_data_in <= {62'b0, head_i, data_i}; end
        default : begin r_align_head_data_in  <= 'd0; end
      endcase
      // r_align_data_in       <= s_align_data_in     ;
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_storage   <= 64'd0;
    end else begin
      // if(~r_sequence[0]) begin
      //   r_storage   <= (r_storage << 6'd32) | r_align_head_data_in;
      // end else begin
      //   r_storage   <= (r_storage << 6'd32) | r_align_data_in;
      // end
      r_storage   <= (r_storage << 6'd32) | r_align_head_data_in;
    end
  end
  assign  data_o = r_storage[95:64];


endmodule