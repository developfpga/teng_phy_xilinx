//
//  By David
//
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module xgmii2axis32 (

  // clk_is and resets
  input                    clk_i,
  input                    rst_i,

  // Stats
  output       [31:0]      good_frames_o,
  output       [31:0]      bad_frames_o,

  // XGMII
  input        [31:0]      xgmii_d_i,
  input        [3:0]       xgmii_c_i,
  input                    xgmii_v_i,

  // AXIS
  output       [31:0]      tdata_o,
  output       [1:0]       tvldb_o,
  output                   tvalid_o,
  output                   tlast_o,
  output       [0:0]       tuser_o
  );

  `include "xgmii_includes.vh"
  // localparam
  localparam P_IDLE   = 3'b001;
  localparam P_START  = 3'b010;
  localparam P_DATA   = 3'b100;
  localparam    P_STATE_WIDTH = 3;


/******************************************************************************
//                              register
******************************************************************************/
  wire                     s_xgmii_valid;
  reg          [P_STATE_WIDTH-1:0]       r_state = P_IDLE;
  reg          [31:0]      r_tdata_d1;
  reg          [1:0]       r_tvldb_d1;
  reg                      r_tvalid_d1;
  reg                      r_tlast_d1;
  reg          [0:0]       r_tuser_d1;

  reg          [31:0]      r_tdata_d2;
  reg          [1:0]       r_tvldb_d2;
  reg                      r_tvalid_d2;
  // reg                      r_tlast_d2;
  // reg          [0:0]       r_tuser_d2;

  wire         [31:0]      s_d;
  wire         [3:0]       s_c;
  reg          [31:0]      r_d;
  reg          [3:0]       r_c;

  reg          [31:0]      r_crc_32;
  reg          [31:0]      r_crc_32_3b;
  reg          [31:0]      r_crc_32_2b;
  reg          [31:0]      r_crc_32_1b;
  wire         [31:0]      s_crc_32_4b;
  wire         [31:0]      s_crc_32_3b;
  wire         [31:0]      s_crc_32_2b;
  wire         [31:0]      s_crc_32_1b;

  reg          [31:0]      r_good_frames;
  reg          [31:0]      r_bad_frames;
/******************************************************************************
//                              rtl body
******************************************************************************/
  assign  s_d = xgmii_d_i;
  assign  s_c = xgmii_c_i;
  assign  s_xgmii_valid = xgmii_v_i;

  always @(posedge clk_i) begin
    if (rst_i) begin  // rst_i
      r_state     <= P_IDLE;
    end else begin  // not rst_i
      if(s_xgmii_valid) begin
        case (r_state)
          P_IDLE : begin
            if (sof_lane0_32(s_d,s_c)) begin
              // inbound_frame <= 1'b1;
              r_state     <= P_START;
            end
          end
          P_START : begin
            r_state     <= P_DATA;
          end
          P_DATA : begin
            case(s_c)
              4'b1111 : begin
                if(is_tchar(s_d[7:0])) begin
                  r_state     <= P_IDLE;
                end
              end
              4'b1110 : begin
                if(is_tchar(s_d[15:8])) begin
                  r_state     <= P_IDLE;
                end
              end
              4'b1100 : begin
                if(is_tchar(s_d[23:16])) begin
                  r_state     <= P_IDLE;
                end
              end
              4'b1000 : begin
                if(is_tchar(s_d[31:24])) begin
                  r_state     <= P_IDLE;
                end
              end
              default : r_state <= P_DATA;
            endcase
          end
          default : begin
            r_state     <= P_IDLE;
          end
        endcase
      end else begin
        r_state     <= r_state;
      end
    end     // not rst_i
  end  //always

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_good_frames <= 'b0;
      r_bad_frames <= 'b0;
    end else begin

      if (r_tvalid_d2 && r_tlast_d1 && r_tuser_d1[0]) begin
        r_good_frames <= r_good_frames + 1;
      end
      if (r_tvalid_d2 && r_tlast_d1 && ~r_tuser_d1[0]) begin
        r_bad_frames <= r_bad_frames + 1;
      end
    end
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      r_tdata_d1    <= 'd0;
      r_tvldb_d1    <= 'd0;
      r_tvalid_d1   <= 'd0;
      r_tlast_d1    <= 'd0;
      r_tuser_d1    <= 'd0;

      r_d           <= 'd0;
      r_c           <= 'd0;
    end else begin
      if(s_xgmii_valid) begin
        r_d           <= s_d;
        r_c           <= s_c;
        case(r_state)
          P_IDLE : begin
            r_tdata_d1    <= 'd0;
            r_tvldb_d1    <= 'd0;
            r_tvalid_d1   <= 'd0;
            r_tlast_d1    <= 'd0;
            r_tuser_d1    <= 'd0;
          end

          P_START : begin
            r_tdata_d1    <= 'd0;
            r_tvldb_d1    <= 'd0;
            r_tvalid_d1   <= 'd0;
            r_tlast_d1    <= 'd0;
            r_tuser_d1    <= 'd0;
          end

          P_DATA : begin
            r_tvalid_d1   <= 'd0;
            if(s_c == 4'h0) begin
              r_tvalid_d1   <= 1'd1;
              r_tlast_d1    <= 1'd0;
              r_tuser_d1    <= 1'd0;
              r_tdata_d1    <= s_d;
              r_tvldb_d1    <= 2'd3;
            end else begin
              r_tdata_d1    <= s_d;
              r_tuser_d1[0] <= 1'd0;
              case(s_c)
                4'b1111 : begin
                  r_tvalid_d1   <= 1'd0;
                  r_tvldb_d1    <= 2'd3;
                  if(is_tchar(s_d[7:0])) begin
                    r_tlast_d1    <= 1'd1;
                  end
                  if((s_crc_32_4b == r_d) && is_tchar(s_d[7:0])) begin
                    r_tuser_d1[0] <= 1'd1;
                  end

                end
                4'b1110 : begin
                  r_tvalid_d1   <= 1'd1;
                  r_tvldb_d1    <= 2'd0;
                  if(is_tchar(s_d[15:8])) begin
                    r_tlast_d1    <= 1'd1;
                  end
                  if((s_crc_32_3b == {s_d[7:0], r_d[31:8]}) && is_tchar(s_d[15:8])) begin
                    r_tuser_d1[0] <= 1'd1;
                  end
                end
                4'b1100 : begin
                  r_tvalid_d1   <= 1'd1;
                  r_tvldb_d1    <= 2'd1;
                  if(is_tchar(s_d[23:16])) begin
                    r_tlast_d1    <= 1'd1;
                  end
                  if((s_crc_32_2b == {s_d[15:0], r_d[31:16]}) && is_tchar(s_d[23:16])) begin
                    r_tuser_d1[0] <= 1'd1;
                  end
                end
                4'b1000 : begin
                  r_tvalid_d1   <= 1'd1;
                  r_tvldb_d1    <= 2'd2;
                  if(is_tchar(s_d[31:24])) begin
                    r_tlast_d1    <= 1'd1;
                  end
                  if((s_crc_32_1b == {s_d[23:0], r_d[31:24]}) && is_tchar(s_d[31:24])) begin
                    r_tuser_d1[0] <= 1'd1;
                  end
                end
                // todo err
                default : begin
                  r_tvalid_d1   <= 1'd1;
                  // r_tdata_d1    <= 32'h0;
                  r_tvldb_d1    <= 2'd3;
                  r_tlast_d1    <= 1'd0;
                end
              endcase
            end
          end

          default : begin
            r_tdata_d1    <= 'd0;
            r_tvldb_d1    <= 'd0;
            r_tvalid_d1   <= 'd0;
            r_tlast_d1    <= 'd0;
            r_tuser_d1    <= 'd0;
          end
        endcase
      end else begin
        r_tdata_d1    <= 'd0;
        r_tvldb_d1    <= 'd0;
        r_tvalid_d1   <= 'd0;
        r_tlast_d1    <= 'd0;
        r_tuser_d1    <= 'd0;
      end
    end
  end

  always @(posedge clk_i) begin

    if (rst_i) begin  // rst_i
      r_tdata_d2    <= 'd0;
      r_tvldb_d2    <= 'd0;
      r_tvalid_d2   <= 'd0;
    end else begin  // not rst_i
      r_tdata_d2    <= r_tdata_d1;
      r_tvldb_d2    <= r_tvldb_d1;
      if(r_tlast_d1 & r_tvalid_d1) begin
        r_tvalid_d2   <= 1'b0;
      end else begin
        r_tvalid_d2   <= r_tvalid_d1;
      end
    end     // not rst_i
  end  //always


  always @(posedge clk_i) begin
    if(rst_i) begin
      r_crc_32        <= 'd0;
      r_crc_32_3b     <= 'd0;
      r_crc_32_2b     <= 'd0;
      r_crc_32_1b     <= 'd0;
      // r_rcved_crc     <= 'd0;
      // r_calcted_crc   <= 'd0;
    end else begin
      if(r_state == P_IDLE) begin
        r_crc_32 <= CRC802_3_PRESET;
      end else if(r_state == P_DATA) begin
        r_crc_32 <= crc4B(r_crc_32,s_d);
        r_crc_32_3b <= crc3B(r_crc_32,s_d[23:0]);
        r_crc_32_2b <= crc2B(r_crc_32,s_d[15:0]);
        r_crc_32_1b <= crc1B(r_crc_32,s_d[ 7:0]);
      end
    end
  end
  
  assign  s_crc_32_4b = ~crc_rev(r_crc_32);
  assign  s_crc_32_3b = ~crc_rev(r_crc_32_3b);
  assign  s_crc_32_2b = ~crc_rev(r_crc_32_2b);
  assign  s_crc_32_1b = ~crc_rev(r_crc_32_1b);
/******************************************************************************
//                              output
******************************************************************************/
  assign  good_frames_o   = r_good_frames;
  assign  bad_frames_o    = r_bad_frames;

  assign  tdata_o   = r_tdata_d2;
  assign  tvldb_o   = r_tvldb_d1;
  assign  tvalid_o  = r_tvalid_d2;
  assign  tlast_o   = r_tlast_d1;
  assign  tuser_o   = r_tuser_d1;
endmodule // xgmii2axis32