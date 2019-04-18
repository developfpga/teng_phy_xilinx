
package stream_pkg;
  import normal_pkg::*;

  class StreamMasterBfm #(int DATA_WIDTH = 64);
    virtual stream.master #(DATA_WIDTH) tx_ck;

    function new(virtual stream.master #(DATA_WIDTH) tx_ck);
      this.tx_ck = tx_ck;
    endfunction

    task write(input q_pkt_t q_payload);
      logic   [DATA_WIDTH-1:0] buf_data;
      integer length;

      // $display("%t, mac tx start", $time);
      length = q_payload.size();
      if(length <= 0) begin
        return;
      end
      // @(posedge tx_ck.clk);
      @(this.tx_ck.driver_cb) begin
        if(length > DATA_WIDTH/8) begin
          for(int i = 0; i < DATA_WIDTH/8 ; i = i + 1) begin
            buf_data[i*8 +: 8] = q_payload[i];
          end
          // ##0
            tx_ck.driver_cb.valid <= 1'b1;
            tx_ck.driver_cb.data  <= buf_data;
            tx_ck.driver_cb.vldb  <= DATA_WIDTH/8-1;
            tx_ck.driver_cb.sop   <= 1'b1;
            tx_ck.driver_cb.eop   <= 1'b0;
        end else begin
          buf_data = 64'h0;
          for(int i = 0; i < length ; i = i + 1) begin
            buf_data[i*8 +: 8] = q_payload[i];
          end
          // ##0
            tx_ck.driver_cb.valid <= 1'b1;
            tx_ck.driver_cb.data  <= buf_data;
            tx_ck.driver_cb.vldb  <= length - 1;
            tx_ck.driver_cb.sop   <= 1'b1;
            tx_ck.driver_cb.eop   <= 1'b1;
        end
      end
      while(length > 0) begin
        // do
        //   @(this.tx_ck.driver_cb);
        // while(!tx_ck.driver_cb.ready);
        @(this.tx_ck.driver_cb) begin
          if(tx_ck.driver_cb.ready) begin
            // tx_ck.driver_cb.valid <= 1'b0;
            // if(($random%100) > 50) begin
            //   @(this.tx_ck.driver_cb);
            // end
            if(length > DATA_WIDTH/8) begin
              repeat(DATA_WIDTH/8) begin
                q_payload.pop_front();
              end
              length -= DATA_WIDTH/8;
            end else begin
              q_payload.delete();
              length = 0;
              break;
            end
            if(length > DATA_WIDTH/8) begin
              for(int i = 0; i < DATA_WIDTH/8 ; i = i + 1) begin
                buf_data[i*8 +: 8] = q_payload[i];
              end
              // ##0
              tx_ck.driver_cb.valid <= 1'b1;
              tx_ck.driver_cb.data  <= buf_data;
              tx_ck.driver_cb.vldb  <= DATA_WIDTH/8-1;
              tx_ck.driver_cb.sop   <= 1'b0;
              tx_ck.driver_cb.eop   <= 1'b0;
            end else begin
              buf_data = 64'h0102030405060708;
              for(int i = 0; i < length ; i = i + 1) begin
                buf_data[i*8 +: 8] = q_payload[i];
              end
              // ##0
              tx_ck.driver_cb.valid <= 1'b1;
              tx_ck.driver_cb.data  <= buf_data;
              tx_ck.driver_cb.vldb  <= length - 1;
              tx_ck.driver_cb.sop   <= 1'b0;
              tx_ck.driver_cb.eop   <= 1'b1;
            end
          end
        end
      end
      tx_ck.driver_cb.valid <= 1'b0;
      tx_ck.driver_cb.data  <= 'b0;
      tx_ck.driver_cb.vldb  <= 'b0;
      tx_ck.driver_cb.sop   <= 1'b0;
      tx_ck.driver_cb.eop   <= 1'b0;
      // $display("%t, mac tx end", $time);
    endtask //write

    task init();
      tx_ck.driver_cb.valid <= 1'b0;
      tx_ck.driver_cb.data  <= 'b0;
      tx_ck.driver_cb.vldb  <= 'b0;
      tx_ck.driver_cb.sop   <= 1'b0;
      tx_ck.driver_cb.eop   <= 1'b0;
      tx_ck.driver_cb.user  <= 1'b0;
    endtask //init

    task idle(int unsigned cycles);
      repeat(cycles)
        @(this.tx_ck.driver_cb);
    endtask //idle
  endclass

  class StreamSlaveBfm #(int DATA_WIDTH = 64);
    virtual stream.slave #(DATA_WIDTH) rx_ck;

    function new(virtual stream.slave #(DATA_WIDTH) rx_ck);
      this.rx_ck = rx_ck;
    endfunction

    task read(output q_pkt_t q_payload);
      q_pkt_t   this_packet_q;
      @(this.rx_ck.mon_cb);
      rx_ck.mon_cb.ready <= 1'b1;
      while(1) begin
        // ## 1;
        @(this.rx_ck.mon_cb) begin
          if(rx_ck.mon_cb.valid) begin
          // if(rx_ck.mon_cb.valid & rx_ck.mon_cb.ready) begin
            if(rx_ck.mon_cb.sop) begin
              this_packet_q     = {};
            end else begin
            end
            for(int i = 0; i <= rx_ck.mon_cb.vldb; i = i + 1) begin
              this_packet_q.push_back(rx_ck.mon_cb.data[i*8 +: 8]);
            end
            if(rx_ck.mon_cb.eop) begin
              q_payload = this_packet_q;
              rx_ck.mon_cb.ready <= 1'b0;
              break;
            end
          end
        end
      end
    endtask //read

    task init();
      rx_ck.mon_cb.ready <= 1'b0;
    endtask //init

    task idle(int unsigned cycles);
      repeat(cycles)
        @(this.rx_ck.mon_cb);
    endtask //idle
  endclass

endpackage

interface stream #(parameter  DATA_WIDTH = 64)
  (input bit clk);
  import normal_pkg::*;
  // parameter  DATA_WIDTH = 64;
  localparam DATA_BE_BIT = clog2(DATA_WIDTH/8 - 1);
  // localparam DATA_BE_BIT = `_bit_width(DATA_WIDTH/8 - 1);
  wire valid;
  wire [DATA_WIDTH-1:0] data;
  wire [DATA_BE_BIT-1:0] vldb;
  wire sop;
  wire eop;
  wire user;
  wire ready;

  clocking driver_cb @(posedge clk);
    output valid, data, vldb, sop, eop, user;
    input ready;
  endclocking

  clocking mon_cb @(posedge clk);
    input valid, data, vldb, sop, eop, user;
    output ready;
  endclocking

  modport slave(
    // input valid, data, vldb, sop, eop, clk,
    // output ready
    clocking mon_cb
  );

  modport master(
    // output valid, data, vldb, sop, eop, clk,
    // input ready
    clocking driver_cb
  );


  // MacContreteBfm bfm = new;
endinterface //stream