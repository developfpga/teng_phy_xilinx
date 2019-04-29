//
//  By David
//
//  2019.4.17
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

import normal_pkg::*;
import stream_pkg::*;

module tb_mac_loopback();

  parameter SIM_NUM_OF_PACKETS              = 100;

  parameter NUMBER_OF_LANES                 = 1;
  parameter P_SCRAMBLE_LOOPBACK             = 1'b0;
  parameter P_GEARBOX_LOOPBACK              = 1'b0;

  logic               s_user_clk;         // 156.25*2 clk
  logic               s_user_ready;
  logic   [31:0]      s_pma_rx_data;
  logic   [31:0]      s_pma_tx_data;

  logic   [ 0:0]      s_link_up;
  logic   [ 0:0]      s_tx_status;
  logic   [ 0:0]      s_tx_rsp_valid;

  logic               s_tx_user_rst;         // sync to user_clk_o
  logic               s_rx_user_rst;         // sync to user_clk_o


  stream #(32) mac_tx(s_user_clk);
  stream #(32) mac_rx(s_user_clk);

  teng_mac #(
    .NUMBER_OF_LANES                (NUMBER_OF_LANES     ),
    .P_SCRAMBLE_LOOPBACK            (P_SCRAMBLE_LOOPBACK ),
    .P_GEARBOX_LOOPBACK             (P_GEARBOX_LOOPBACK  )
  )u_teng_mac(
    .rx_user_clk_i                  (s_user_clk),
    .rx_ready_i                     (s_user_ready),
    .rx_data_i                      (s_pma_rx_data),
  //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    .tx_user_clk_i                  (s_user_clk),
    .tx_ready_i                     (s_user_ready),
    .tx_data_o                      (s_pma_tx_data),

    .link_up_o                      (s_link_up),
  // AXIS tx
  // input                             tx_user_clk_i,
    .tx_user_rst_o                  (s_tx_user_rst),
    .tx_data_i                      (mac_tx.data),
    .tx_vldb_i                      (mac_tx.vldb),
    .tx_valid_i                     (mac_tx.valid),
    .tx_ready_o                     (mac_tx.ready),
    .tx_last_i                      (mac_tx.eop),
    .tx_user_i                      (mac_tx.user),

    .tx_status_o                    (s_tx_status),
    .tx_rsp_valid_o                 (s_tx_rsp_valid),
  // AXIS rx
  // input                             rx_user_clk_i,
    .rx_user_rst_o                  (s_rx_user_rst),
    .rx_data_o                      (mac_rx.data),
    .rx_vldb_o                      (mac_rx.vldb),
    .rx_valid_o                     (mac_rx.valid),
    .rx_last_o                      (mac_rx.eop),
    .rx_user_o                      (mac_rx.user)
  );


  assign  mac_rx.ready = 1'b1;

  initial begin
    s_user_clk = 1'b0;
    s_user_ready = 1'b0;
    #100;
    s_user_ready = 1'b1;
  end
  always #5 s_user_clk = ~s_user_clk;

  assign  s_pma_rx_data = s_pma_tx_data;

  reg     r_global_rst;
  always @(posedge s_user_clk) begin
    if(s_tx_user_rst | s_rx_user_rst | ~s_link_up) begin
      r_global_rst <= 1'b1;
    end else begin
      r_global_rst <= 1'b0;
    end
  end

  reg r_mac_rx_sop;
  always @(posedge s_user_clk) begin
    if(s_rx_user_rst) begin
      r_mac_rx_sop  <= 1'b1;
    end else begin
      if(mac_rx.valid) begin
        if(mac_rx.eop) begin
          r_mac_rx_sop  <= 1'b1;
        end else begin
          r_mac_rx_sop  <= 1'b0;
        end
      end
    end
  end
  assign  mac_rx.sop = r_mac_rx_sop;

  StreamMasterBfm #(32) mac_master;
  StreamSlaveBfm  #(32) mac_slave;

  q_pkt_t q_check_bytes;
  q_int_t q_check_len;


  initial begin
    mac_master = new(mac_tx);
    mac_slave = new(mac_rx);

    mac_master.init();
    mac_slave.init();
    #100;
    @(negedge r_global_rst);
    #1us;

    fork
      // begin : tx
      //   q_pkt_t q_packet;
      //   int packet_len;
      //   packet_len = 59;
      //   repeat(SIM_NUM_OF_PACKETS) begin
      //     // packet_len = packet_len + 1;
      //     packet_len = random_between(60, 1514);

      //     q_packet = {};
      //     repeat(packet_len) begin
      //       q_packet.push_back(ramdom_bytes());
      //     end

      //     q_check_bytes = {q_check_bytes, q_packet};
      //     q_check_len.push_back(q_packet.size());
      //     mac_master.write(q_packet);

      //   end
      // end
      begin : tx
        q_pkt_t q_packet;
        int packet_len;
        packet_len = 59;
        repeat(SIM_NUM_OF_PACKETS) begin
          packet_len = packet_len + 1;
          if(packet_len == 1515) begin
            packet_len  = 60;
          end
          // packet_len = random_between(60, 1514);

          q_packet = {};
          repeat(packet_len) begin
            q_packet.push_back(ramdom_bytes());
          end

          q_check_bytes = {q_check_bytes, q_packet};
          q_check_len.push_back(q_packet.size());
          mac_master.write(q_packet);

        end
      end

      begin : rx
        q_pkt_t q_packet;
        int packet_len;
        int check_len;
        logic   [7:0] expect_bytes;
        logic   [7:0] actual_bytes;
        for(int j = 0; j < SIM_NUM_OF_PACKETS; j = j + 1) begin
          mac_slave.read(q_packet);
          packet_len = q_packet.size();
          check_len = q_check_len.pop_front();
          assert(packet_len == check_len)
          else begin
            $error("receive packet length error, packet is %x, expect is %x, actual is %x", j, check_len, packet_len);
            $stop;
          end
          for(int i = 0; i < packet_len; i = i + 1) begin
            expect_bytes = q_check_bytes.pop_front();
            actual_bytes = q_packet.pop_front();
            assert (expect_bytes == actual_bytes)
            else begin
              $error("receive bytes error, packet is %x, offset is %x, expect is %x, actual is %x", j, i, expect_bytes, actual_bytes);
              $stop;
            end
          end
        end
      end
    join

    assert(mac_slave.crc_error_cnt == 0)
    else $error("receive error packets : %d", mac_slave.crc_error_cnt);
    #5us;
    $display("sim done");
    $stop;
  end

endmodule