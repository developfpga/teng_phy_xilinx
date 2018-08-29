///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
// description:
//   connect to gtx
//   when got unknown block type field, send a 'decode_error_o' out with all
//   idle command to xgmii rx interface
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module 64b_66b_decode{
    input           clk_i,              // Freq = 156.25*2
    input           rst_i,

    input   [63:0]  decode_data_i,
    input   [ 1:0]  decode_head_i,
    input           decode_data_vld_i,  // decode data valid

    output  [63:0]  xgmii_rxd_o,
    output  [ 7:0]  xgmii_rxc_o,
    output          xgmii_vld_o,
    output          decode_error_o

};

///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    reg     [63:0]      r_rxd_d1;
    reg     [ 7:0]      r_rxc_d1;
    reg                 r_rxd_vld_d1;
    reg                 r_decode_error_d1;
///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////
    always @(posedge clk_i) begin
        if (rst_i == 1'b1) begin
            r_rxd_d1            <= 64'h0;
            r_rxc_d1            <= 8'h0;
            r_rxd_vld_d1        <= 1'b0;
            r_decode_error_d1   <= 1'b0;
        end else begin
            r_rxd_vld_d1        <= decode_data_vld_i;
            if(decode_data_vld_i == 1'b1 && (decode_head_i == 2'b00 || decode_head_i == 2'b11)) begin
                r_decode_error_d1   <= 1'b1;
            end 
            if(decode_data_vld_i == 1'b1) begin
                r_decode_error_d1   <= 1'b0;
                case(decode_head_i)
                    2'b01: begin
                        if(decode_data_i[7:0] == 8'h33) begin// start 4
                            r_rxd_d1            <= {decode_data_i[63:40], 8'hFB, 32'h07070707};
                            r_rxc_d1            <= 8'h1f;
                        end else if(decode_data_i[7:0] == 8'h78) begin// start 0
                            r_rxd_d1            <= {decode_data_i[63:8], 8'hfb};
                            r_rxc_d1            <= 8'h01;
                        end else if(decode_data_i[7:0] == 8'hff) begin// end 7
                            r_rxd_d1            <= {8'hfd, decode_data_i[63:8]};
                            r_rxc_d1            <= 8'h80;    
                        end else if(decode_data_i[7:0] == 8'he1) begin// end 6
                            r_rxd_d1            <= {8'h07, 8'hfd, decode_data_i[55:8]};
                            r_rxc_d1            <= 8'hC0;
                        end else if(decode_data_i[7:0] == 8'hd2) begin// end 5
                            r_rxd_d1            <= {8'h07, 8'h07, 8'hfd, decode_data_i[47:8]};
                            r_rxc_d1            <= 8'hE0;
                        end else if(decode_data_i[7:0] == 8'hcc) begin// end 4
                            r_rxd_d1            <= {8'h07, 8'h07, 8'h07, 8'hfd, decode_data_i[39:8]};
                            r_rxc_d1            <= 8'hF0;
                        end else if(decode_data_i[7:0] == 8'hd4) begin// end 3
                            r_rxd_d1            <= {8'h07, 8'h07, 8'h07, 8'h07, 8'hfd, decode_data_i[31:8]};
                            r_rxc_d1            <= 8'hF8;
                        end else if(decode_data_i[7:0] == 8'haa) begin// end 2
                            r_rxd_d1            <= {40'h0707070707, 8'hfd, decode_data_i[23:8]};
                            r_rxc_d1            <= 8'hFC;
                        end else if(decode_data_i[7:0] == 8'h99) begin// end 1
                            r_rxd_d1            <= {48'h070707070707, 8'hfd, decode_data_i[15:8]};
                            r_rxc_d1            <= 8'hFE;
                        end else if(decode_data_i[7:0] == 8'h87) begin// end 0
                            r_rxd_d1            <= {56'h07070707070707, 8'hfd};
                            r_rxc_d1            <= 8'hFF;
                        end else begin
                            r_rxd_d1            <= 64'h07070707_07070707;
                            r_rxc_d1            <= 8'hff;
                            r_decode_error_d1   <= 1'b1;
                        end 
                    end
                    2'b10: begin
                        r_rxd_d1            <= decode_data_i;
                        r_rxc_d1            <= 8'h0;
                    end
                    default: begin
                        r_rxd_d1            <= 64'h07070707_07070707;
                        r_rxc_d1            <= 8'hff;
                        r_decode_error_d1   <= 1'b1;
                    end
                endcase
            end
        end

      
    end 

    assign  xgmii_rxd_o = r_rxd_d1;
    assign  xgmii_rxc_o = r_rxc_d1;
    assign  xgmii_vld_o = r_rxd_vld_d1;
    assign  decode_error_o = r_decode_error_d1;
endmodule
