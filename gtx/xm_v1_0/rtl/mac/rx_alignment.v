///////////////////////////////////////////////////////////////////////////////
//
// date : 2018-8-24
// description:
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module rx_alignment(

    input           clk_i,              // Freq = 156.25*2
    input           rst_i,

    input   [31:0]  gtwiz_userdata_rx_i,
    input   [ 1:0]  rxheader_i,
    input           rxheadervalid_i,

    output          rxgearboxslip_o,
    output          locked
);

///////////////////////////////////////////////////////////////////////////////
//                       parameter
///////////////////////////////////////////////////////////////////////////////
    localparam      P_LOCK_COUNT_WIDTH = 10;
    parameter       P_SLIP_GAP_WIDTH = 4;
    localparam      P_SLIP_GAP_MASK = (1 << P_SLIP_GAP_WIDTH) - 1;
///////////////////////////////////////////////////////////////////////////////
//                       register
///////////////////////////////////////////////////////////////////////////////
    reg     [ P_LOCK_COUNT_WIDTH-1:0]  r_aligned_count;
    reg             r_rxgearboxslip;
    reg     [P_SLIP_GAP_WIDTH-1:0]   r_sleep;


///////////////////////////////////////////////////////////////////////////////
//                         body
///////////////////////////////////////////////////////////////////////////////
    always @(posedge clk_i) begin
        if(rst_i) begin
            r_aligned_count     <= 'd0;
            r_rxgearboxslip     <= 1'b0;
            r_sleep             <= 'd0;
        end else begin
            r_rxgearboxslip     <= 1'b0;
            if(rxheadervalid_i) begin
                if (rxheader_i[0] == rxheader_i[1] && r_sleep[P_SLIP_GAP_WIDTH-1] == 1'b0) begin
                    r_rxgearboxslip     <= 1'b1;
                    r_sleep             <= P_SLIP_GAP_MASK;
                end else if(r_sleep[P_SLIP_GAP_WIDTH-1] == 1'b1) begin
                    r_sleep             <= r_sleep - 1'b1;
                end


                if (rxheader_i[0] != rxheader_i[1]) begin
                    if(r_aligned_count[P_LOCK_COUNT_WIDTH-1] == 1'b0) begin
                        r_aligned_count     <= r_aligned_count + 'd1;
                    end
                end else begin
                    r_aligned_count     <= 'd0;
                end
            end
        end
    end
    assign  locked = r_aligned_count[P_LOCK_COUNT_WIDTH-1];
    assign  rxgearboxslip_o = r_rxgearboxslip;


endmodule
