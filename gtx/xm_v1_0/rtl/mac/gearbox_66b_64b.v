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
  wire    [ 5:0]    s_sft_count;
  wire    [95:0]    s_sft_data_in;
  wire    [95:0]    s_align_head_data_in;
  wire    [95:0]    s_align_data_in;
  reg     [95:0]    r_storage;

  assign  s_sft_count = {sequence_i[5:1], 1'b0};
  assign  s_sft_data_in = {head_i, data_i, 62'h0};
  assign  s_align_head_data_in = sequence_i[6] ? {64'h0} : (s_sft_data_in >> s_sft_count);
  assign  s_align_data_in = sequence_i[6] ? {64'h0} : (({2'h0, data_i, 62'h0}) >> s_sft_count);
  always @(posedge clk_i) begin
    if(rst_i) begin
      r_storage   <= 64'd0;
    end else begin
      if(~sequence_i[0]) begin
        r_storage   <= (r_storage << 6'd32) | s_align_head_data_in;
      end else begin
        r_storage   <= (r_storage << 6'd32) | s_align_data_in;
      end

    end
  end
  assign  data_o = r_storage[95:64];

  // always @(posedge clk_i) begin
  //   if(rst_i) begin

  //   end else begin

  //   end
  // end

  // always @(posedge clk_i) begin
  //   if(rst_i) begin

  //   end else begin

  //   end
  // end
endmodule