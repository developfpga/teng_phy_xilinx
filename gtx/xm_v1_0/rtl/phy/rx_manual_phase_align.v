//
//  By David
//
//  2019.4.1
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1

module rx_manual_phase_align  #
(
  parameter NUMBER_OF_LANES = 4,  // Number of lanes that are controlled using this FSM.
  parameter MASTER_LANE_ID  = 0   // Number of the lane which is considered the master
                                  // in manual phase-alignment
)
(
  input   wire                             stable_clk_i,              //Stable Clock, either a stable clock from the PCB
  input   wire                             reset_phalignment_i,
  input   wire                             run_phalignment_i,
  output  reg                              phase_alignment_done_o = 1'b0,      // Manual phase-alignment performed sucessfully
  output  reg     [NUMBER_OF_LANES-1:0]    rx_dly_sreset_o = {NUMBER_OF_LANES{1'b0}},
  input   wire    [NUMBER_OF_LANES-1:0]    rx_dly_sreset_done_i,
  output  reg     [NUMBER_OF_LANES-1:0]    rx_ph_align_o = {NUMBER_OF_LANES{1'b0}},
  input   wire    [NUMBER_OF_LANES-1:0]    rx_ph_align_done_i,
  output  reg     [NUMBER_OF_LANES-1:0]    rx_dly_en_o = {NUMBER_OF_LANES{1'b0}}
);


   genvar j;
   integer i;
   wire [NUMBER_OF_LANES-1:0] VCC_VEC = {NUMBER_OF_LANES{1'b1}};
   wire [NUMBER_OF_LANES-1:0] GND_VEC = {NUMBER_OF_LANES{1'b0}};

   localparam [2:0]
               INIT             = 3'b000,
               WAIT_DLYRST_DONE = 3'b001,
               M_PHALIGN        = 3'b010,
               M_DLYEN          = 3'b011,
               S_PHALIGN        = 3'b100,
               M_DLYEN2         = 3'b101,
               PHALIGN_DONE     = 3'b110;

  reg [2:0] rx_phalign_manual_state = INIT;


  reg  [NUMBER_OF_LANES-1:0] rxphaligndone_prev = {NUMBER_OF_LANES{1'b0}};
  wire [NUMBER_OF_LANES-1:0] rxphaligndone_ris_edge;
  reg  [NUMBER_OF_LANES-1:0] rxdlysresetdone_store= {NUMBER_OF_LANES{1'b0}};
  reg  [NUMBER_OF_LANES-1:0] rxphaligndone_store = {NUMBER_OF_LANES{1'b0}};
  reg                        rxdone_clear = 1'b0;
  wire [NUMBER_OF_LANES-1:0] rxphaligndone_sync;
  wire [NUMBER_OF_LANES-1:0] rxdlysresetdone_sync;


  //Clock Domain Crossing

  generate
    for (j = 0;j <= NUMBER_OF_LANES-1;j = j+1) begin

      sync_block sync_RXPHALIGNDONE
      (
        .clk             (stable_clk_i),
        .data_in         (rx_ph_align_done_i[j]),
        .data_out        (rxphaligndone_sync[j])
      );

      sync_block sync_RXDLYSRESETDONE
      (
        .clk             (stable_clk_i),
        .data_in         (rx_dly_sreset_done_i[j]),
        .data_out        (rxdlysresetdone_sync[j])
      );
    end
  endgenerate

  always @(posedge stable_clk_i)
  begin
      rxphaligndone_prev    <= `DLY  rxphaligndone_sync;
  end

 generate
   for (j = 0;j <=  NUMBER_OF_LANES-1;j = j+1)
   begin
    assign  rxphaligndone_ris_edge[j] = ((rxphaligndone_prev[j] == 1'b0) && (rxphaligndone_sync[j] == 1'b1))  ? 1'b1 : 1'b0;
   end
  endgenerate


  always @(posedge stable_clk_i)
  begin
      if (rxdone_clear)
      begin
        rxdlysresetdone_store <= `DLY  GND_VEC;
        rxphaligndone_store   <= `DLY  GND_VEC;
      end

      else
      begin
        for (i = 0; i <= NUMBER_OF_LANES-1; i = i+1)
        begin
          if (rxdlysresetdone_sync[i] == 1'b1)
            rxdlysresetdone_store[i] <= `DLY  1'b1;

          if (rxphaligndone_ris_edge[i] == 1'b1)
             rxphaligndone_store[i]  <= `DLY  1'b1;
        end
      end
  end




  always @(posedge stable_clk_i)
  begin
      if (reset_phalignment_i == 1)
      begin
        phase_alignment_done_o    <= `DLY  1'b0;
        rx_dly_sreset_o             <= `DLY  {NUMBER_OF_LANES{1'b0}};
        rx_ph_align_o               <= `DLY  {NUMBER_OF_LANES{1'b0}};
        rx_dly_en_o                 <= `DLY  {NUMBER_OF_LANES{1'b0}};
        rx_phalign_manual_state <= `DLY  INIT;
        rxdone_clear            <= `DLY  1'b1;

      end
      else
      begin
        case (rx_phalign_manual_state)
           INIT :
           begin
            phase_alignment_done_o <= `DLY  1'b0;
            rxdone_clear         <= `DLY  1'b1;

            if (run_phalignment_i)
            begin
              //Assert rx_dly_sreset_o for all lanes.
              rxdone_clear            <= `DLY  1'b0;
              rx_dly_sreset_o             <= `DLY  {NUMBER_OF_LANES{1'b1}};
              rx_phalign_manual_state <= `DLY  WAIT_DLYRST_DONE;
            end
           end

           WAIT_DLYRST_DONE :
           begin
            for (i = 0;i <= NUMBER_OF_LANES - 1;i = i+1)
            begin
              if (rxdlysresetdone_store[i] == 1)
                //Hold rx_dly_sreset_o High until rx_dly_sreset_done_i of the
                //respective lane is asserted.
                //Deassert rx_dly_sreset_o for the lane in which the
                //rx_dly_sreset_done_i is asserted.
                rx_dly_sreset_o[i] <= `DLY  0;
            end
            if (rxdlysresetdone_store == VCC_VEC)
            begin
              rx_phalign_manual_state   <= `DLY  M_PHALIGN;
            end
           end

           M_PHALIGN :
           begin
            //When rx_dly_sreset_o of all lanes are deasserted, assert
            //rx_ph_align_o for the master lane.
            rx_ph_align_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (rxphaligndone_ris_edge[MASTER_LANE_ID] == 1)
            begin
              //Hold this signal High until a rising edge on rx_ph_align_done_i
              //of the master lane is detected, then deassert rx_ph_align_o for
              //the master lane.
              rx_ph_align_o[MASTER_LANE_ID] <= `DLY  1'b0;
              rx_phalign_manual_state   <= `DLY  M_DLYEN;
            end
           end

           M_DLYEN :
           begin
            //Assert rx_dly_en_o for the master lane. This causes rx_ph_align_done_i
            //to be deasserted.
            rx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (rxphaligndone_ris_edge[MASTER_LANE_ID] == 1)
            begin
              //Hold rx_dly_en_o for the master lane High until a rising edge on
              //rx_ph_align_done_i of the master lane is detected, then deassert
              //rx_dly_en_o for the master lane.
              rx_dly_en_o[MASTER_LANE_ID]   <= `DLY  1'b0;
              rx_phalign_manual_state   <= `DLY  S_PHALIGN;
            end
           end

           S_PHALIGN :
           begin
            //Assert rx_ph_align_o for all slave lane(s). Hold this signal High until
            //a rising edge on rx_ph_align_done_i of the respective slave lane is detected.
            rx_ph_align_o                 <= `DLY  {NUMBER_OF_LANES{1'b1}};//\Assert only the PHINIT-signal of
            rx_ph_align_o[MASTER_LANE_ID] <= `DLY  0;          ///the slaves.
            for (i = 0;i <=  NUMBER_OF_LANES - 1;i = i+1)
            begin
              if (rxphaligndone_store[i] == 1)
                //When a rising edge on the respective lane is detected, rx_ph_align_o
                //of that lane is deasserted.
                rx_ph_align_o[i] <= `DLY  1'b0;
            end
           //The reason for checking of the occurance of at least one rising edge
            //is to avoid the potential direct move where rx_ph_align_done_i might not
            //be going low fast enough.
            if (rxphaligndone_store == VCC_VEC)
              rx_phalign_manual_state   <= `DLY  M_DLYEN2;
           end

           M_DLYEN2 :
           begin
            //When rx_ph_align_o for all slave lane(s) are deasserted, assert rx_dly_en_o
            //for the master lane. This causes rx_ph_align_done_i of the master lane
            //to be deasserted.
            rx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (rxphaligndone_ris_edge[MASTER_LANE_ID] == 1)
              //Wait until rx_ph_align_done_i of the master lane reasserts. Phase and
              //delay alignment for the multilane interface is complete.
              rx_phalign_manual_state   <= `DLY  PHALIGN_DONE;
           end

           PHALIGN_DONE :
           begin
            //Continue to hold rx_dly_en_o for the master lane High to adjust RXUSRCLK
            //to compensate for temperature and voltage variations.
            rx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            phase_alignment_done_o    <= `DLY  1'b1;
           end

           default:
              rx_phalign_manual_state <= `DLY  INIT;

        endcase
      end
    end


endmodule
