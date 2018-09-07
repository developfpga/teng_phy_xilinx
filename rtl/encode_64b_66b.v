///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
// description:
//   connect to gtx
//   when got unknown xgmii_txc from xgmii, report 'encode_error_o' back,
//   and send all idle to phy
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module encode_64b_66b(
    input           clk_i,              // Freq = 156.25*2
    input           rst_i,

    input   [63:0]  xgmii_txd_i,
    input   [ 7:0]  xgmii_txc_i,
    input           xgmii_txd_vld_i,    // xgmii txd valid
    output          encode_error_o,

    output  [63:0]  encode_data_o,
    output  [ 1:0]  encode_head_o,
    output          encode_data_vld_o   // encode data valid
);

///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    reg     [63:0]      r_encode_data_d1;
    reg     [ 1:0]      r_encode_head_d1;
    reg                 r_encode_vld_d1;
    reg                 r_encode_error_d1;
    reg                 r_debug;
///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////
    always @(posedge clk_i) begin
        if(rst_i == 1'b1) begin
            r_encode_data_d1        <= 64'h0;
            r_encode_head_d1        <= 2'h0;
            r_encode_vld_d1         <= 1'b0;
            r_encode_error_d1       <= 1'b0;
            r_debug                 <= 1'b0;
        end else begin
            r_encode_vld_d1         <= xgmii_txd_vld_i;
            if(xgmii_txd_vld_i) begin
                r_encode_error_d1       <= 1'b0;
                if(&xgmii_txc_i && xgmii_txd_i[7:0] != 8'hfd) begin// column of idles
                    
                    // if(r_debug) begin
                    //     r_encode_data_d1        <= 64'h0102030405060708;
                    //     r_debug                 <= 1'b0;
                    // end else begin
                    //     r_encode_data_d1        <= 64'h00000000ffffffff;
                    //     r_debug                 <= 1'b1;
                    // end
                    r_encode_data_d1        <= 64'h00000000_0000001E;
                    r_encode_head_d1        <= 2'b01;
                end else if(|xgmii_txc_i) begin
                    r_encode_head_d1        <= 2'b01;
                    if(xgmii_txc_i == 8'h01) begin// start code
                        r_encode_data_d1[7:0]   <= 8'h78;
                        r_encode_data_d1[63:8]  <= xgmii_txd_i[63:8];
                    end else if(xgmii_txc_i == 8'h1f) begin // start code
                        r_encode_data_d1[7:0]   <= 8'h33;
                        r_encode_data_d1[39:8]  <= 32'h0;
                        r_encode_data_d1[63:40] <= xgmii_txd_i[63:40];
                    end else if(xgmii_txc_i == 8'h80) begin // end code 7
                        r_encode_data_d1[7:0]   <= 8'hff;
                        r_encode_data_d1[63:8]  <= xgmii_txd_i[55:0];
                    end else if(xgmii_txc_i == 8'hc0) begin // end code 6
                        r_encode_data_d1[7:0]   <= 8'he1;
                        r_encode_data_d1[63:8]  <= {8'h00, xgmii_txd_i[47:0]};
                    end else if(xgmii_txc_i == 8'he0) begin // end code 5
                        r_encode_data_d1[7:0]   <= 8'hd2;
                        r_encode_data_d1[63:8]  <= {16'h00, xgmii_txd_i[39:0]};
                    end else if(xgmii_txc_i == 8'hf0) begin // end code 4
                        r_encode_data_d1[7:0]   <= 8'hcc;
                        r_encode_data_d1[63:8]  <= {24'h00, xgmii_txd_i[31:0]};
                    end else if(xgmii_txc_i == 8'hf8) begin // end code 3
                        r_encode_data_d1[7:0]   <= 8'hb4;
                        r_encode_data_d1[63:8]  <= {32'h00, xgmii_txd_i[23:0]};
                    end else if(xgmii_txc_i == 8'hfc) begin // end code 2
                        r_encode_data_d1[7:0]   <= 8'haa;
                        r_encode_data_d1[63:8]  <= {40'h00, xgmii_txd_i[15:0]};
                    end else if(xgmii_txc_i == 8'hfe) begin // end code 1
                        r_encode_data_d1[7:0]   <= 8'h99;
                        r_encode_data_d1[63:8]  <= {48'h00, xgmii_txd_i[7:0]};
                    end else if(xgmii_txc_i == 8'hff) begin // end code 0
                        r_encode_data_d1[7:0]   <= 8'h87;
                        r_encode_data_d1[63:8]  <= {56'h00};
                    end else begin
                        r_encode_error_d1       <= 1'b1;
                        r_encode_data_d1        <= 64'h00000000001E;
                        r_encode_head_d1        <= 2'b01;
                    end
                end else begin
                    r_encode_head_d1        <= 2'b10;
                    r_encode_data_d1        <= xgmii_txd_i;
                end
            end
        end
    end

    assign  encode_data_o   = r_encode_data_d1;
    assign  encode_head_o   = r_encode_head_d1;
    assign  encode_data_vld_o   = r_encode_vld_d1;
    assign  encode_error_o  = r_encode_error_d1;

endmodule
