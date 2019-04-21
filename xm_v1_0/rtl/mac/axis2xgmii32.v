//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module axis2xgmii32 (

  // Clks and resets
  input                    clk_i,
  input                    rst_i,

  // XGMII
  output       [31:0]      xgmii_d_o,
  output       [3:0]       xgmii_c_o,
  output       [6:0]       sequence_o,

  // AXIS
  input        [31:0]      tdata_i,
  input        [1:0]       tvldb_i,
  input                    tvalid_i,
  output                   tready_o,
  input                    tlast_i,
  input        [0:0]       tuser_i,

  output                   tx_status_o,
  output                   tx_rsp_valid_o
  );
/******************************************************************************
//                              parameter
******************************************************************************/
  `include "xgmii_includes.vh"
  localparam    P_IDLE    = 8'b0000_0001;
  localparam    P_START   = 8'b0000_0010;
  localparam    P_DATA    = 8'b0000_0100;
  localparam    P_PADDING = 8'b0000_1000;
  localparam    P_END     = 8'b0001_0000;
  localparam    P_CRC     = 8'b0010_0000;
  localparam    P_CRC_1   = 8'b0100_0000;
  localparam    P_IPG     = 8'b1000_0000;
  localparam    P_STATE_WIDTH = 8;

  localparam    P_IPG_COUNT = 3;
/******************************************************************************
//                              register
******************************************************************************/
  reg          [6:0]       r_66count;
  reg                      r_66b64b_ready;
  reg                      r_start_ready;

  reg          [P_STATE_WIDTH-1:0]      r_state = P_IDLE;
  reg                      r_state_ready;
  wire                     s_ready;

  reg          [6:0]       r_input_count;
  reg          [1:0]       r_ipg_count;

  reg          [31:0]      r_tdata_d1;
  reg          [1:0]       r_tvldb_d1;
  reg                      r_tvalid_d1;
  reg          [31:0]      r_tdata_d2;
  reg          [1:0]       r_tvldb_d2;
  reg          [1:0]       r_crc_left;
  reg          [31:0]      r_d;
  reg          [3:0]       r_c;
  // reg          [ 6:0]      r_sequence;
  // reg          [ 6:0]      r_sequence_d1;
  // reg          [ 6:0]      r_sequence_d2;
  // reg          [ 6:0]      r_sequence_d3;

  reg          [31:0]      r_crc_final;
  reg          [31:0]      r_crc_32_4b;
  reg          [31:0]      r_crc_32_3b;
  reg          [31:0]      r_crc_32_2b;
  reg          [31:0]      r_crc_32_1b;
  wire         [31:0]      s_crc_final;
  wire         [31:0]      s_crc_32_4b;
  wire         [31:0]      s_crc_32_3b;
  wire         [31:0]      s_crc_32_2b;
  wire         [31:0]      s_crc_32_1b;

/******************************************************************************
//                              rtl body
******************************************************************************/
  assign xgmii_d = r_d;
  assign xgmii_c = r_c;

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_66count       <= 'd0;
      // r_sequence      <= 'd0;
      // r_sequence_d1   <= 'd0;
      // r_sequence_d2   <= 'd0;
      // r_sequence_d3   <= 'd0;
      r_66b64b_ready  <= 1'b1;
      r_start_ready   <= 1'b0;
    end else begin
      if(r_66count == 7'd65) begin
        r_66count   <= 'd0;
      end else begin
        r_66count   <= r_66count + 'd1;
      end
      // r_sequence  <= r_66count;
      // r_sequence_d1   <= r_sequence;
      // r_sequence_d2   <= r_sequence_d1;
      // r_sequence_d3   <= r_sequence_d2;

      if(r_state == P_IDLE) begin
        if(tvalid_i && (r_66count == 7'd63 || r_66count == 7'd64)) begin
          r_66b64b_ready  <= 1'b0;
        end
      end else begin
        r_66b64b_ready  <= (r_66count != 7'd63 && r_66count != 7'd64);
        if(r_state == P_IPG && r_66b64b_ready && (r_ipg_count == P_IPG_COUNT-1)) begin
          r_66b64b_ready  <= 1'b1;
        end
      end
      // if(r_66count >= 62 && r_66count <= 63) begin
      //   r_start_ready   <= 1'b0;
      // end else begin
      //   r_start_ready   <= 1'b1;
      // end
    end
  end
  // assign  s_ready = (r_66b64b_ready & r_state_ready & (r_state != P_IDLE)) | (r_state_ready & r_start_ready & r_state == P_IDLE);
  assign  s_ready = r_66b64b_ready & r_state_ready;

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_state     <= P_IDLE;
    end else begin
      // if(r_66b64b_ready) begin
        case(r_state)
          P_IDLE : begin
            if(tvalid_i & ~tlast_i & r_66b64b_ready) begin
              r_state     <= P_START;
            end
          end
          P_START : begin
            if(r_66b64b_ready == 1'b1) begin
              if(tlast_i == 1) begin
                r_state     <= P_PADDING;
              end else begin
                r_state     <= P_DATA;
              end
            end
          end
          P_DATA : begin
            if(r_66b64b_ready) begin
              if(tlast_i == 1) begin
                if(r_input_count >= 56) begin
                  r_state     <= P_END;
                end else begin
                  r_state     <= P_PADDING;
                end
              end
            end
          end
          P_PADDING : begin
            if(r_66b64b_ready) begin
              if(r_input_count  >= 56) begin
                r_state     <= P_CRC;
              end
            end
          end
          P_END : begin
            if(r_66b64b_ready) begin
              r_state     <= P_CRC;
            end
          end
          P_CRC : begin
            if(r_66b64b_ready) begin
              r_state     <= P_CRC_1;
            end
          end
          P_CRC_1 : begin
            if(r_66b64b_ready) begin
              r_state     <= P_IPG;
            end
          end
          P_IPG : begin
            if(r_66b64b_ready) begin
              if(r_ipg_count == P_IPG_COUNT-1) begin
                r_state     <= P_IDLE;
              end
            end
          end
          default : begin
            r_state     <= P_IDLE;
          end
        endcase
      // end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_input_count   <= 'd0;
    end else begin
      if(r_state == P_IDLE && tvalid_i && s_ready && ~tlast_i) begin
        r_input_count   <= 'd4;
      end else if(r_state == P_START || r_state == P_DATA || r_state == P_PADDING) begin
        if(tvalid_i && s_ready) begin
          if(r_input_count < 56) begin
            r_input_count   <= r_input_count + 'd4;
          end
        end
      end else begin
        r_input_count   <= 'd0;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_ipg_count   <= 'd0;
    end else begin
      if(r_state == P_IPG) begin
        r_ipg_count   <= r_ipg_count + 'd1;
      end else begin
        r_ipg_count   <= 'd0;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_state_ready   <= 'd0;
    end else begin
      if(tvalid_i && tlast_i && s_ready && r_state != P_IDLE) begin
        r_state_ready   <= 1'b0;
      end else if(r_state == P_IPG && r_ipg_count == P_IPG_COUNT-1 && r_66b64b_ready) begin
        r_state_ready   <= 1'b1;
      end else if(r_state == P_IDLE) begin
        r_state_ready   <= 1'b1;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_tdata_d1    <= 'd0;
      r_tvldb_d1    <= 'd0;
      r_tvalid_d1   <= 1'b0;
    end else begin
      r_tvalid_d1   <= tvalid_i && s_ready;
      if(tvalid_i && s_ready) begin
        if(tlast_i) begin
          r_tdata_d1    <= tdata_i;
          r_tvldb_d1    <= tvldb_i;
          // if(r_input_count >= 60) begin
          //   r_tdata_d1    <= tdata_i;
          //   r_tvldb_d1    <= tvldb_i;
          // end else begin
          //   r_tvldb_d1    <= 2'd3;
          //   case(tvldb_i)
          //     2'd0: r_tdata_d1  <= {24'h0, tdata_i[7:0]};
          //     2'd1: r_tdata_d1  <= {16'h0, tdata_i[15:0]};
          //     2'd2: r_tdata_d1  <= { 8'h0, tdata_i[23:0]};
          //     2'd3: r_tdata_d1  <= tdata_i[31:0];
          //     default : r_tdata_d1  <= 'd0;
          //   endcase
          // end
        end else begin
          r_tdata_d1    <= tdata_i;
          r_tvldb_d1    <= 2'd3;
        end
      // end else begin
      //   r_tdata_d1    <= 'd0;
      //   r_tvldb_d1    <= 2'd3;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_tdata_d2    <= 'd0;
      r_tvldb_d2    <= 'd0;
      r_crc_left    <= 'd0;
    end else begin
      if(r_66b64b_ready) begin
        r_tdata_d2    <= r_tdata_d1;
        r_tvldb_d2    <= r_tvldb_d1;
      end
      if(r_state == P_CRC) begin
        r_crc_left    <= r_tvldb_d2;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_crc_32_4b   <= 'd0;
      r_crc_32_3b   <= 'd0;
      r_crc_32_2b   <= 'd0;
      r_crc_32_1b   <= 'd0;
      r_crc_final   <= 'd0;
    end else begin
      if(r_tvalid_d1) begin
        if(r_state == P_START) begin
          r_crc_32_4b   <= crc4B(CRC802_3_PRESET,r_tdata_d1[31:0]);
        end else begin
          r_crc_32_4b   <= crc4B(r_crc_32_4b,r_tdata_d1[31:0]);
        end
        r_crc_32_3b   <= crc3B(r_crc_32_4b,r_tdata_d1[23:0]);
        r_crc_32_2b   <= crc2B(r_crc_32_4b,r_tdata_d1[15:0]);
        r_crc_32_1b   <= crc1B(r_crc_32_4b,r_tdata_d1[7:0]);
      end
      if(r_state == P_CRC) begin
        case(r_tvldb_d2)
          2'd0: r_crc_final <= {24'h0,s_crc_32_1b[31:24]};
          2'd1: r_crc_final <= {16'h0,s_crc_32_2b[31:16]};
          2'd2: r_crc_final <= {8'h0,s_crc_32_3b[31:8]};
          default: r_crc_final <= s_crc_32_4b;
        endcase
      end
    end
  end
  assign  s_crc_final = r_crc_final;
  assign  s_crc_32_4b = ~crc_rev(r_crc_32_4b);
  assign  s_crc_32_3b = ~crc_rev(r_crc_32_3b);
  assign  s_crc_32_2b = ~crc_rev(r_crc_32_2b);
  assign  s_crc_32_1b = ~crc_rev(r_crc_32_1b);


  always @(posedge clk_i) begin
    if(rst_i) begin
      r_d   <= 'd0;
      r_c   <= 'd0;
    end else begin
      if(r_66b64b_ready) begin
        case(r_state)
          P_IDLE : begin
            if(tvalid_i & ~tlast_i) begin
              r_d   <= PREAMBLE_LANE0_D[31:0];
              r_c   <= PREAMBLE_LANE0_C[3:0];
            end else begin
              r_d   <= {4{I}};
              r_c   <= 4'hf;
            end
          end
          P_START : begin
            r_d   <= PREAMBLE_LANE0_D[63:32];
            r_c   <= PREAMBLE_LANE0_C[7:4];
          end
          P_DATA : begin
            r_d   <= r_tdata_d2;
            r_c   <= 4'h0;
          end
          P_PADDING : begin
            r_d   <= r_tdata_d2;
            r_c   <= 4'h0;
          end
          P_END : begin
            r_d   <= r_tdata_d2;
            r_c   <= 4'h0;
          end
          P_CRC : begin
            r_c   <= 4'h0;
            case(r_tvldb_d2)
              2'd0: r_d <= {s_crc_32_1b[23:0],r_tdata_d2[7:0]};
              2'd1: r_d <= {s_crc_32_2b[15:0],r_tdata_d2[15:0]};
              2'd2: r_d <= {s_crc_32_3b[7:0],r_tdata_d2[23:0]};
              default: r_d <= r_tdata_d2[31:0];
            endcase
          end
          P_CRC_1 : begin
            // r_d   <= s_crc_final;
            case(r_crc_left)
              2'd0 : begin r_d <= {{2{I}},T,s_crc_final[7:0]}; r_c <= 4'b1110; end
              2'd1 : begin r_d <= {{{I}},T,s_crc_final[15:0]}; r_c <= 4'b1100; end
              2'd2 : begin r_d <= {T,s_crc_final[23:0]}; r_c <= 4'b1000; end
              default : begin r_d <= {s_crc_final[31:0]}; r_c <= 4'b0000; end
            endcase
            // r_state     <= P_IPG;
          end
          P_IPG : begin
            r_c   <= 4'hf;
            if(r_ipg_count == 0 && r_crc_left == 2'd3) begin
              r_d   <= {{3{I}},T};
            end else begin
              r_d   <= {4{I}};
            end
          end
          default : begin
            r_d   <= {4{I}};
            r_c   <= 4'hf;
          end
        endcase
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin

    end else begin

    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin

    end else begin

    end
  end

/******************************************************************************
//                              output
******************************************************************************/
  assign  tready_o = s_ready;
  assign  xgmii_d_o = r_d;
  assign  xgmii_c_o = r_c;
  assign  sequence_o = r_66count;

endmodule // axis2xgmii32

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////