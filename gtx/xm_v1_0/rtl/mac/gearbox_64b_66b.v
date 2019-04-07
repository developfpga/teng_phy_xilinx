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


  reg     [6:0]   r_count;
  reg     [6:0]   r_sft_count;// count up step 1
  reg     [6:0]   r_sft_count2;// count up step 2
  reg     [6:0]   r_sft_init;
  reg             r_see_slip;
  // reg     [31:0]  r_data_in;
  reg             r_slip;
  // reg             r_slip_d1;
  // reg             r_slip_d2;
  reg     [31:0]  r_data;
  reg     [95:0]  r_storage;
  wire    [95:0]  s_aligned_data_in;
  // reg     [30:0]  r_possible_align_bit;
  // reg     [4:0]   r_possible_align_pos;

  // integer j;
  // reg             r_get_possible_align_pos;

  // always @(posedge clk_i) begin
  //   if(rst_i) begin
  //     r_data_in   <= 32'b0;
  //   end else begin
  //     r_data_in   <= data_i;
  //   end
  // end
  // genvar i;
  // generate
  //   for (i = 0; i < 31; i = i + 1) begin : u_possible_align_bit
  //     always @(posedge clk_i) begin
  //       if(rst_i) begin
  //         r_possible_align_bit[i] <= 1'b0;
  //       end else begin
  //         r_possible_align_bit[i] <= r_data_in[i] != r_data_in[i+1];
  //       end
  //     end
  //   end
  // endgenerate

  // always @(posedge clk_i) begin
  //   if(rst_i) begin
  //     r_possible_align_pos  <= 'd0;
  //     // r_get_possible_align_pos  <= 1'b0;
  //   end else begin
  //     r_get_possible_align_pos  = 1'b0;
  //     r_possible_align_pos  <= 'd0;
  //     for(j = 0; j < 31; j = j + 1) begin
  //       if(~r_get_possible_align_pos & r_possible_align_bit[j]) begin
  //         r_possible_align_pos  <= j;
  //         r_get_possible_align_pos  = 1'b1;
  //       end
  //     end
  //   end
  // end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_data    <= 'b0;
    end else begin
      r_data    <= data_i;
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_slip    <= 1'b0;
      // r_slip_d1 <= 1'b0;
      // r_slip_d2 <= 1'b0;
    end else begin
      r_slip    <= slip_i;
      // r_slip_d1 <= slip_i & ~r_slip;
      // r_slip_d2 <= r_slip_d1;
    end
  end
  assign  s_aligned_data_in = ({64'h0, r_data} << r_sft_count2[5:0]);
  // assign  s_aligned_data_in = r_sft_count2[6] ? (data_i) : ({64'h0, data_i} << r_sft_count2[5:0]);

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_sft_init    <= 'd0;
      r_see_slip    <= 1'b0;
    end else begin
      if(r_count == 7'd65 && r_see_slip) begin
        if(r_sft_init == 7'd65) begin
          r_sft_init    <= 'd0;
        end else begin
          r_sft_init    <= r_sft_init + 7'd1;
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
      r_sft_count2    <= 'd0;
    end else begin
      if(r_count == 7'd65 && r_see_slip) begin
        // if(r_see_slip) begin
          r_sft_count2    <= r_sft_init + 7'd1;
        // end
      end else if(r_sft_count[0] != r_sft_count2[0]) begin
        if(r_sft_count2[6]) begin
          r_sft_count2    <= r_sft_count2[0];
        end else begin
          r_sft_count2    <= r_sft_count2 + 7'd2;
        end
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_sft_count   <= 'd0;
    end else begin
      if(r_count == 7'd65 && r_see_slip) begin
        r_sft_count   <= r_sft_init + 7'd1;
      end else begin
        if(r_sft_count == 7'd65) begin
          r_sft_count   <= 7'd0;
        end else begin
          r_sft_count   <= r_sft_count + 7'd1;
        end
      end
    end
  end
  always @(posedge clk_i) begin
    if(rst_i) begin
      r_count   <= 'd0;
    end else begin
      if(r_count == 7'd65) begin
        // if(r_see_slip) begin
        //   r_count   <= r_sft_init + 7'd1;
        // end else begin
        //   r_count   <= 7'd0;
        // end
        r_count   <= 7'd0;
      end else begin
        r_count   <= r_count + 7'd1;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_storage   <= 'd0;
    end else begin
      if(r_sft_count2[6] == 1'b1) begin
        if(r_sft_count2[0] == 1'b0) begin
          r_storage[63:0]   <= (r_storage[63:0] << 6'd32) | s_aligned_data_in;
        end else begin
          r_storage[64:0]   <= (r_storage[64:0] << 6'd32) | s_aligned_data_in;
        end
        // r_storage[63:0]   <= (r_storage[63:0] << 6'd32) | {32'h0, data_i};
      end else begin
        if(r_sft_count[0] == r_sft_count2[0]) begin
          // r_storage   <= (r_storage << 6'd34) | (s_aligned_data_in << 6'd2);
          r_storage   <= (r_storage << 6'd34) | (s_aligned_data_in << 6'd2);
        end else begin
          r_storage   <= (r_storage << 6'd32) | (s_aligned_data_in << 6'd2);
        end
      end
    end
  end

  assign  data_o  = (r_sft_count[0] == r_sft_count2[0]) ? r_storage[93:62] : r_storage[95:64];
  assign  head_o  = r_storage[95:94];
  assign  head_valid_o = (r_sft_count[0] == r_sft_count2[0]) & ~r_sft_count[6];

endmodule