`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/02/20 10:38:27
// Design Name:
// Module Name: gearbox_64_66
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
// sequence 0, 1, 2, 3, 4, ... ,62,63,64,65, 0, 1, 2, 3
// shift    2, 2, 4, 4, 6, ... ,64,64, 0, 0, 2, 2, 4, 4
// head     h0,   h1,   h2,... ,h31,         h0,   h1
// data     d0,d1,d2,d3,d4,....,d62d63,xxxxx,d0,d1,d2,d3
// sequence 64 与 d0相对应
//////////////////////////////////////////////////////////////////////////////////


module gearbox_64b_66b (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  output       [31:0]      data_o,
  output       [1:0]       head_o,
  output                   head_valid_o,
  input                    slip_i,

  input        [31:0]      data_i
);

  wire    [63:0]    s_data_in_con;
  reg     [31:0]    r_data;
  reg     [31:0]    r_data_d1;
  reg     [63:0]    r_storage;
  reg               r_slip;
  reg               r_see_slip;
  reg     [ 4:0]    r_shift;
  reg     [31:0]    r_data_shift;
  wire    [95:0]    s_storage;

  reg     [ 6:0]    r_count;
  wire    [ 6:0]    s_count;
  reg     [31:0]    r_data_out;
  reg     [1:0]     r_head_out;
  reg               r_head_valid_out;

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_slip    <= 1'b0;
    end else begin
      r_slip    <= slip_i;
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_shift       <= 'd0;
      r_see_slip    <= 1'b0;
    end else begin
      if(r_count == 7'd65 && r_see_slip) begin
        if(r_shift == 5'd31) begin
          r_shift    <= 'd0;
        end else begin
          r_shift    <= r_shift + 5'd1;
        end
      end
      if(slip_i & ~r_slip) begin
        r_see_slip    <= 1'b1;
      end else if(r_count == 7'd65 && r_see_slip) begin
        r_see_slip    <= 1'b0;
      end

    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data    <= 'b0;
      r_data_d1 <= 'b0;
    end else begin
      r_data    <= data_i;
      r_data_d1 <= r_data;
    end
  end
  assign  s_data_in_con = {r_data_d1, r_data};

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data_shift  <= 'd0;
      r_storage     <= 'b0;
    end else begin
      r_data_shift  <= s_data_in_con[r_shift +: 32];
      r_storage     <= {r_storage[31:0], r_data_shift};
    end
  end
  assign  s_storage = {r_storage, r_data_shift};
  always @(posedge clk_i) begin
    if(rst_i) begin
      r_count   <= 'd0;
    end else begin
      if(r_count == 7'd65) begin
        r_count   <= 7'd0;
      end else begin
        r_count   <= r_count + 7'd1;
      end
    end
  end
  assign  s_count = {r_count[6:1], 1'b0};
  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data_out        <= 'd0;
      r_head_out        <= 'b0;
      r_head_valid_out  <= 'd0;
    end else begin
      r_head_valid_out  <= ~r_count[0] & ~r_count[6];
      // r_head_out        <= s_storage[94 - s_count +: 2];
      // r_data_out        <= s_storage[62 - s_count +: 32];
      case(r_count[5:1])
        5'd0 : begin r_head_out <= s_storage[94 - 2*5'd0  +: 2]; r_data_out <= s_storage[62 - 2*5'd0  +: 32]; end
        5'd1 : begin r_head_out <= s_storage[94 - 2*5'd1  +: 2]; r_data_out <= s_storage[62 - 2*5'd1  +: 32]; end
        5'd2 : begin r_head_out <= s_storage[94 - 2*5'd2  +: 2]; r_data_out <= s_storage[62 - 2*5'd2  +: 32]; end
        5'd3 : begin r_head_out <= s_storage[94 - 2*5'd3  +: 2]; r_data_out <= s_storage[62 - 2*5'd3  +: 32]; end
        5'd4 : begin r_head_out <= s_storage[94 - 2*5'd4  +: 2]; r_data_out <= s_storage[62 - 2*5'd4  +: 32]; end
        5'd5 : begin r_head_out <= s_storage[94 - 2*5'd5  +: 2]; r_data_out <= s_storage[62 - 2*5'd5  +: 32]; end
        5'd6 : begin r_head_out <= s_storage[94 - 2*5'd6  +: 2]; r_data_out <= s_storage[62 - 2*5'd6  +: 32]; end
        5'd7 : begin r_head_out <= s_storage[94 - 2*5'd7  +: 2]; r_data_out <= s_storage[62 - 2*5'd7  +: 32]; end
        5'd8 : begin r_head_out <= s_storage[94 - 2*5'd8  +: 2]; r_data_out <= s_storage[62 - 2*5'd8  +: 32]; end
        5'd9 : begin r_head_out <= s_storage[94 - 2*5'd9  +: 2]; r_data_out <= s_storage[62 - 2*5'd9  +: 32]; end
        5'd10: begin r_head_out <= s_storage[94 - 2*5'd10 +: 2]; r_data_out <= s_storage[62 - 2*5'd10 +: 32]; end
        5'd11: begin r_head_out <= s_storage[94 - 2*5'd11 +: 2]; r_data_out <= s_storage[62 - 2*5'd11 +: 32]; end
        5'd12: begin r_head_out <= s_storage[94 - 2*5'd12 +: 2]; r_data_out <= s_storage[62 - 2*5'd12 +: 32]; end
        5'd13: begin r_head_out <= s_storage[94 - 2*5'd13 +: 2]; r_data_out <= s_storage[62 - 2*5'd13 +: 32]; end
        5'd14: begin r_head_out <= s_storage[94 - 2*5'd14 +: 2]; r_data_out <= s_storage[62 - 2*5'd14 +: 32]; end
        5'd15: begin r_head_out <= s_storage[94 - 2*5'd15 +: 2]; r_data_out <= s_storage[62 - 2*5'd15 +: 32]; end
        5'd16: begin r_head_out <= s_storage[94 - 2*5'd16 +: 2]; r_data_out <= s_storage[62 - 2*5'd16 +: 32]; end
        5'd17: begin r_head_out <= s_storage[94 - 2*5'd17 +: 2]; r_data_out <= s_storage[62 - 2*5'd17 +: 32]; end
        5'd18: begin r_head_out <= s_storage[94 - 2*5'd18 +: 2]; r_data_out <= s_storage[62 - 2*5'd18 +: 32]; end
        5'd19: begin r_head_out <= s_storage[94 - 2*5'd19 +: 2]; r_data_out <= s_storage[62 - 2*5'd19 +: 32]; end
        5'd20: begin r_head_out <= s_storage[94 - 2*5'd20 +: 2]; r_data_out <= s_storage[62 - 2*5'd20 +: 32]; end
        5'd21: begin r_head_out <= s_storage[94 - 2*5'd21 +: 2]; r_data_out <= s_storage[62 - 2*5'd21 +: 32]; end
        5'd22: begin r_head_out <= s_storage[94 - 2*5'd22 +: 2]; r_data_out <= s_storage[62 - 2*5'd22 +: 32]; end
        5'd23: begin r_head_out <= s_storage[94 - 2*5'd23 +: 2]; r_data_out <= s_storage[62 - 2*5'd23 +: 32]; end
        5'd24: begin r_head_out <= s_storage[94 - 2*5'd24 +: 2]; r_data_out <= s_storage[62 - 2*5'd24 +: 32]; end
        5'd25: begin r_head_out <= s_storage[94 - 2*5'd25 +: 2]; r_data_out <= s_storage[62 - 2*5'd25 +: 32]; end
        5'd26: begin r_head_out <= s_storage[94 - 2*5'd26 +: 2]; r_data_out <= s_storage[62 - 2*5'd26 +: 32]; end
        5'd27: begin r_head_out <= s_storage[94 - 2*5'd27 +: 2]; r_data_out <= s_storage[62 - 2*5'd27 +: 32]; end
        5'd28: begin r_head_out <= s_storage[94 - 2*5'd28 +: 2]; r_data_out <= s_storage[62 - 2*5'd28 +: 32]; end
        5'd29: begin r_head_out <= s_storage[94 - 2*5'd29 +: 2]; r_data_out <= s_storage[62 - 2*5'd29 +: 32]; end
        5'd30: begin r_head_out <= s_storage[94 - 2*5'd30 +: 2]; r_data_out <= s_storage[62 - 2*5'd30 +: 32]; end
        5'd31: begin r_head_out <= s_storage[94 - 2*5'd31 +: 2]; r_data_out <= s_storage[62 - 2*5'd31 +: 32]; end
        default : begin
          r_data_out        <= 'd0;
          r_head_out        <= 'b0; end
      endcase
    end
  end

  assign  data_o  = r_data_out;
  assign  head_o  = r_head_out;
  assign  head_valid_o = r_head_valid_out;
endmodule