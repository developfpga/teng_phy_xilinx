///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module scramble(
    input           clk_i,          // Freq = 156.25*2
    input           rst_i,

    input   [63:0]  data_i,         // [65:2] data, [1:0] head
    input   [ 1:0]  head_i,         // [65:2] data, [1:0] head
    input           data_vld_i,     // only valid data needs scramble
    output  [63:0]  data_o,
    output  [ 1:0]  head_o,
    output          data_vld_o      //

);

///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    reg     [57:0]      r_scramble_register;
    wire    [63:0]      s_data_in;
    wire    [ 1:0]      s_head_in;
    wire    [63:0]      s_scrambled_data;
    reg     [65:0]      r_data_in_buf;
    reg     [65:0]      r_scrambled_data_d2;
    reg                 r_scrambled_data_vld_d1;
    reg                 r_scrambled_data_vld_d2;
///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////
    assign  s_data_in = r_data_in_buf[65:2];
    assign  s_head_in = r_data_in_buf[1:0];
// Scramble the TxEnc_Data before applying to rxn/p
    assign s_scrambled_data[0] = s_data_in[0]^r_scramble_register[38]^r_scramble_register[57];
    assign s_scrambled_data[1] = s_data_in[1]^r_scramble_register[37]^r_scramble_register[56];
    assign s_scrambled_data[2] = s_data_in[2]^r_scramble_register[36]^r_scramble_register[55];
    assign s_scrambled_data[3] = s_data_in[3]^r_scramble_register[35]^r_scramble_register[54];
    assign s_scrambled_data[4] = s_data_in[4]^r_scramble_register[34]^r_scramble_register[53];
    assign s_scrambled_data[5] = s_data_in[5]^r_scramble_register[33]^r_scramble_register[52];
    assign s_scrambled_data[6] = s_data_in[6]^r_scramble_register[32]^r_scramble_register[51];
    assign s_scrambled_data[7] = s_data_in[7]^r_scramble_register[31]^r_scramble_register[50];

    assign s_scrambled_data[8] = s_data_in[8]^r_scramble_register[30]^r_scramble_register[49];
    assign s_scrambled_data[9] = s_data_in[9]^r_scramble_register[29]^r_scramble_register[48];
    assign s_scrambled_data[10] = s_data_in[10]^r_scramble_register[28]^r_scramble_register[47];
    assign s_scrambled_data[11] = s_data_in[11]^r_scramble_register[27]^r_scramble_register[46];
    assign s_scrambled_data[12] = s_data_in[12]^r_scramble_register[26]^r_scramble_register[45];
    assign s_scrambled_data[13] = s_data_in[13]^r_scramble_register[25]^r_scramble_register[44];
    assign s_scrambled_data[14] = s_data_in[14]^r_scramble_register[24]^r_scramble_register[43];
    assign s_scrambled_data[15] = s_data_in[15]^r_scramble_register[23]^r_scramble_register[42];

    assign s_scrambled_data[16] = s_data_in[16]^r_scramble_register[22]^r_scramble_register[41];
    assign s_scrambled_data[17] = s_data_in[17]^r_scramble_register[21]^r_scramble_register[40];
    assign s_scrambled_data[18] = s_data_in[18]^r_scramble_register[20]^r_scramble_register[39];
    assign s_scrambled_data[19] = s_data_in[19]^r_scramble_register[19]^r_scramble_register[38];
    assign s_scrambled_data[20] = s_data_in[20]^r_scramble_register[18]^r_scramble_register[37];
    assign s_scrambled_data[21] = s_data_in[21]^r_scramble_register[17]^r_scramble_register[36];
    assign s_scrambled_data[22] = s_data_in[22]^r_scramble_register[16]^r_scramble_register[35];
    assign s_scrambled_data[23] = s_data_in[23]^r_scramble_register[15]^r_scramble_register[34];

    assign s_scrambled_data[24] = s_data_in[24]^r_scramble_register[14]^r_scramble_register[33];
    assign s_scrambled_data[25] = s_data_in[25]^r_scramble_register[13]^r_scramble_register[32];
    assign s_scrambled_data[26] = s_data_in[26]^r_scramble_register[12]^r_scramble_register[31];
    assign s_scrambled_data[27] = s_data_in[27]^r_scramble_register[11]^r_scramble_register[30];
    assign s_scrambled_data[28] = s_data_in[28]^r_scramble_register[10]^r_scramble_register[29];
    assign s_scrambled_data[29] = s_data_in[29]^r_scramble_register[9]^r_scramble_register[28];
    assign s_scrambled_data[30] = s_data_in[30]^r_scramble_register[8]^r_scramble_register[27];
    assign s_scrambled_data[31] = s_data_in[31]^r_scramble_register[7]^r_scramble_register[26];

    assign s_scrambled_data[32] = s_data_in[32]^r_scramble_register[6]^r_scramble_register[25];
    assign s_scrambled_data[33] = s_data_in[33]^r_scramble_register[5]^r_scramble_register[24];
    assign s_scrambled_data[34] = s_data_in[34]^r_scramble_register[4]^r_scramble_register[23];
    assign s_scrambled_data[35] = s_data_in[35]^r_scramble_register[3]^r_scramble_register[22];
    assign s_scrambled_data[36] = s_data_in[36]^r_scramble_register[2]^r_scramble_register[21];
    assign s_scrambled_data[37] = s_data_in[37]^r_scramble_register[1]^r_scramble_register[20];
    assign s_scrambled_data[38] = s_data_in[38]^r_scramble_register[0]^r_scramble_register[19];
    assign s_scrambled_data[39] = s_data_in[39]^s_data_in[0]^r_scramble_register[38]^r_scramble_register[57]^r_scramble_register[18];
    assign s_scrambled_data[40] = s_data_in[40]^(s_data_in[1]^r_scramble_register[37]^r_scramble_register[56])^r_scramble_register[17];
    assign s_scrambled_data[41] = s_data_in[41]^(s_data_in[2]^r_scramble_register[36]^r_scramble_register[55])^r_scramble_register[16];
    assign s_scrambled_data[42] = s_data_in[42]^(s_data_in[3]^r_scramble_register[35]^r_scramble_register[54])^r_scramble_register[15];
    assign s_scrambled_data[43] = s_data_in[43]^(s_data_in[4]^r_scramble_register[34]^r_scramble_register[53])^r_scramble_register[14];
    assign s_scrambled_data[44] = s_data_in[44]^(s_data_in[5]^r_scramble_register[33]^r_scramble_register[52])^r_scramble_register[13];
    assign s_scrambled_data[45] = s_data_in[45]^(s_data_in[6]^r_scramble_register[32]^r_scramble_register[51])^r_scramble_register[12];
    assign s_scrambled_data[46] = s_data_in[46]^(s_data_in[7]^r_scramble_register[31]^r_scramble_register[50])^r_scramble_register[11];
    assign s_scrambled_data[47] = s_data_in[47]^(s_data_in[8]^r_scramble_register[30]^r_scramble_register[49])^r_scramble_register[10];

    assign s_scrambled_data[48] = s_data_in[48]^(s_data_in[9]^r_scramble_register[29]^r_scramble_register[48])^r_scramble_register[9];
    assign s_scrambled_data[49] = s_data_in[49]^(s_data_in[10]^r_scramble_register[28]^r_scramble_register[47])^r_scramble_register[8];
    assign s_scrambled_data[50] = s_data_in[50]^(s_data_in[11]^r_scramble_register[27]^r_scramble_register[46])^r_scramble_register[7];
    assign s_scrambled_data[51] = s_data_in[51]^(s_data_in[12]^r_scramble_register[26]^r_scramble_register[45])^r_scramble_register[6];
    assign s_scrambled_data[52] = s_data_in[52]^(s_data_in[13]^r_scramble_register[25]^r_scramble_register[44])^r_scramble_register[5];
    assign s_scrambled_data[53] = s_data_in[53]^(s_data_in[14]^r_scramble_register[24]^r_scramble_register[43])^r_scramble_register[4];
    assign s_scrambled_data[54] = s_data_in[54]^(s_data_in[15]^r_scramble_register[23]^r_scramble_register[42])^r_scramble_register[3];
    assign s_scrambled_data[55] = s_data_in[55]^(s_data_in[16]^r_scramble_register[22]^r_scramble_register[41])^r_scramble_register[2];

    assign s_scrambled_data[56] = s_data_in[56]^(s_data_in[17]^r_scramble_register[21]^r_scramble_register[40])^r_scramble_register[1];
    assign s_scrambled_data[57] = s_data_in[57]^(s_data_in[18]^r_scramble_register[20]^r_scramble_register[39])^r_scramble_register[0];
    assign s_scrambled_data[58] = s_data_in[58]^(s_data_in[19]^r_scramble_register[19]^r_scramble_register[38])^(s_data_in[0]^r_scramble_register[38]^r_scramble_register[57]);
    assign s_scrambled_data[59] = s_data_in[59]^(s_data_in[20]^r_scramble_register[18]^r_scramble_register[37])^(s_data_in[1]^r_scramble_register[37]^r_scramble_register[56]);
    assign s_scrambled_data[60] = s_data_in[60]^(s_data_in[21]^r_scramble_register[17]^r_scramble_register[36])^(s_data_in[2]^r_scramble_register[36]^r_scramble_register[55]);
    assign s_scrambled_data[61] = s_data_in[61]^(s_data_in[22]^r_scramble_register[16]^r_scramble_register[35])^(s_data_in[3]^r_scramble_register[35]^r_scramble_register[54]);
    assign s_scrambled_data[62] = s_data_in[62]^(s_data_in[23]^r_scramble_register[15]^r_scramble_register[34])^(s_data_in[4]^r_scramble_register[34]^r_scramble_register[53]);
    assign s_scrambled_data[63] = s_data_in[63]^(s_data_in[24]^r_scramble_register[14]^r_scramble_register[33])^(s_data_in[5]^r_scramble_register[33]^r_scramble_register[52]);

    integer i;
    always @(posedge clk_i) begin
        if (rst_i == 1'b1) begin
            r_scramble_register     <= 58'h3;
            r_data_in_buf           <= 66'h2;
            r_scrambled_data_d2     <= 66'h0;
            r_scrambled_data_vld_d1 <= 1'b0;
            r_scrambled_data_vld_d2 <= 1'b0;
        end else begin
            r_scrambled_data_vld_d1 <= data_vld_i;
            r_data_in_buf           <= {data_i, head_i};
            r_scrambled_data_vld_d2 <= r_scrambled_data_vld_d1;
            r_scrambled_data_d2     <= {s_scrambled_data[63:0], s_head_in[1:0]};
            if(data_vld_i) begin
                for (i=0; i<58; i=i+1) begin
                    r_scramble_register[i] <= s_scrambled_data[63-i];
                end
            end
        end
    end
 
///////////////////////////////////////////////////////////////////////////////
//                         output
///////////////////////////////////////////////////////////////////////////////   
    assign  data_o  = r_scrambled_data_d2[65:2];
    assign  head_o  = r_scrambled_data_d2[1:0];
    assign  data_vld_o = r_scrambled_data_vld_d2;
    // assign  data_o  = data_i;
    // assign  head_o  = head_i;
    // assign  data_vld_o = data_vld_i;

endmodule
