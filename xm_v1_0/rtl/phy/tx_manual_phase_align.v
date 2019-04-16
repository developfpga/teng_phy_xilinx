//
//  By David
//
//  2019.4.1
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1


module tx_manual_phase_align  #
(
  parameter NUMBER_OF_LANES         = 4,  // Number of lanes that are controlled using this FSM.
  parameter MASTER_LANE_ID          = 0   // Number of the lane which is considered the master in manual phase-alignment
)
(
  input     wire                        stable_clk_i,              //Stable Clock, either a stable clock from the PCB
                                                                    //or reference-clock present at startup.
  input     wire                        reset_phalignment_i,
  input     wire                        run_phalignment_i,
  output    reg                         phase_alignment_done_o = 1'b0,       // Manual phase-alignment performed sucessfully
  output    reg  [NUMBER_OF_LANES-1:0]  tx_dly_sreset_o = {NUMBER_OF_LANES{1'b0}},
  input     wire [NUMBER_OF_LANES-1:0]  tx_dly_sreset_done_i,
  output    reg  [NUMBER_OF_LANES-1:0]  tx_ph_init_o = {NUMBER_OF_LANES{1'b0}},
  input     wire [NUMBER_OF_LANES-1:0]  tx_ph_init_done_i,
  output    reg  [NUMBER_OF_LANES-1:0]  tx_ph_align_o = {NUMBER_OF_LANES{1'b0}},
  input     wire [NUMBER_OF_LANES-1:0]  tx_ph_align_done_i,
  output    reg  [NUMBER_OF_LANES-1:0]  tx_dly_en_o = {NUMBER_OF_LANES{1'b0}}
);


  genvar j;
  wire [NUMBER_OF_LANES-1:0] VCC_VEC = {NUMBER_OF_LANES{1'b1}};
  wire [NUMBER_OF_LANES-1:0] GND_VEC = {NUMBER_OF_LANES{1'b0}};

  reg  [NUMBER_OF_LANES-1:0] txphaligndone_prev = {NUMBER_OF_LANES{1'b0}};
  wire [NUMBER_OF_LANES-1:0] txphaligndone_sync;
  wire [NUMBER_OF_LANES-1:0] txphinitdone_sync;
  wire [NUMBER_OF_LANES-1:0] txdlysresetdone_sync;
  wire [NUMBER_OF_LANES-1:0] txphaligndone_ris_edge;
  reg  [NUMBER_OF_LANES-1:0] txphinitdone_prev = {NUMBER_OF_LANES{1'b0}};
  wire [NUMBER_OF_LANES-1:0] txphinitdone_ris_edge;
  reg  [NUMBER_OF_LANES-1:0] txphinitdone_store_edge= {NUMBER_OF_LANES{1'b0}};
  reg  [NUMBER_OF_LANES-1:0] txdlysresetdone_store= {NUMBER_OF_LANES{1'b0}};
  reg  [NUMBER_OF_LANES-1:0] txphaligndone_store = {NUMBER_OF_LANES{1'b0}};
  reg                        txdone_clear = 1'b0;
  reg                        txphinitdone_clear_slave = 1'b0;

  integer i;

  localparam [3:0]
        INIT            = 4'b0000,
        WAIT_PHRST_DONE = 4'b0001,
        M_PHINIT        = 4'b0010,
        M_PHALIGN       = 4'b0011,
        M_DLYEN         = 4'b0100,
        S_PHINIT        = 4'b0101,
        S_PHALIGN       = 4'b0110,
        M_DLYEN2        = 4'b0111,
        PHALIGN_DONE    = 4'b1000;

  reg [3:0] tx_phalign_manual_state = INIT;


  //Clock Domain Crossing

  generate
    for (j = 0;j <= NUMBER_OF_LANES-1;j = j+1)
    begin : cdc

      sync_block sync_TXPHALIGNDONE
      (
        .clk             (stable_clk_i),
        .data_in         (tx_ph_align_done_i[j]),
        .data_out        (txphaligndone_sync[j])
      );

      sync_block sync_TXDLYSRESETDONE
      (
        .clk             (stable_clk_i),
        .data_in         (tx_dly_sreset_done_i[j]),
        .data_out        (txdlysresetdone_sync[j])
      );

      sync_pulse sync_TXPHINITDONE
      (
        .CLK             (stable_clk_i),
        .pulse_i         (tx_ph_init_done_i[j]),
        .pulse_o         (txphinitdone_sync[j])
      );

    end //cdc
  endgenerate

  always @(posedge stable_clk_i)
  begin
      txphaligndone_prev  <= `DLY  txphaligndone_sync;
      txphinitdone_prev   <= `DLY  txphinitdone_sync;
  end

 generate
  for (j = 0;j <= NUMBER_OF_LANES-1;j = j+1)
 begin : rising_edge_detect
  assign txphaligndone_ris_edge[j] = ((txphaligndone_prev[j] == 0) && (txphaligndone_sync[j] == 1))  ? 1'b1 : 1'b0;
  assign txphinitdone_ris_edge[j]  = ((txphinitdone_prev[j] == 0) && (txphinitdone_sync[j] == 1))  ? 1'b1 : 1'b0;
  end //rising_edge_detect
 endgenerate

  always @(posedge stable_clk_i)
  begin
      if (txdone_clear)
      begin
        txdlysresetdone_store <= `DLY  GND_VEC;
        txphaligndone_store   <= `DLY  GND_VEC;
      end

      else
      begin
        for (i = 0; i <= NUMBER_OF_LANES-1; i = i+1)
        begin
          if (txdlysresetdone_sync[i] == 1'b1)
            txdlysresetdone_store[i] <= `DLY  1'b1;

          if (txphaligndone_ris_edge[i] == 1'b1)
             txphaligndone_store[i]  <= `DLY  1'b1;
        end
      end
  end


  always @(posedge stable_clk_i)
  begin
      if (txphinitdone_clear_slave == 1'b1)
      begin
        //Only clear the tx_ph_init_done_i-storage from the slaves.
        txphinitdone_store_edge                 <= `DLY  GND_VEC;
        //The information stored on the MASTER_LANE_ID is used differently. The way txphinitdone_store_edge
        //is coded, it will be optimised away afterwards. It is only for simplicity of the code on the checks
        //that the master-lane is "recorded" too.
        txphinitdone_store_edge[MASTER_LANE_ID] <= `DLY  1'b1;
      end

      else
      begin
        for (i = 0; i <= NUMBER_OF_LANES-1; i = i+1)
        begin
          if (txphinitdone_ris_edge[i] == 1'b1)
            txphinitdone_store_edge[i] <= `DLY  1'b1;
        end
      end
  end


  always @(posedge stable_clk_i)
  begin
      if (reset_phalignment_i)
      begin
        phase_alignment_done_o    <= `DLY  0;
        tx_dly_sreset_o             <= `DLY  {NUMBER_OF_LANES{1'b0}};
        tx_ph_init_o                <= `DLY  {NUMBER_OF_LANES{1'b0}};
        tx_ph_align_o               <= `DLY  {NUMBER_OF_LANES{1'b0}};
        tx_dly_en_o                 <= `DLY  {NUMBER_OF_LANES{1'b0}};
        tx_phalign_manual_state <= `DLY  INIT;
        txphinitdone_clear_slave  <= `DLY  1'b1;
        txdone_clear              <= `DLY  1'b1;

      end
      else
      begin
        case (tx_phalign_manual_state)
           INIT :
          begin
            phase_alignment_done_o      <= `DLY  1'b0;
            txphinitdone_clear_slave  <= `DLY  1'b1;
            txdone_clear              <= `DLY  1'b1;
            if (run_phalignment_i)
            begin
              //tx_dly_sreset_o is toggled to '1'
              tx_dly_sreset_o               <= `DLY  {NUMBER_OF_LANES{1'b1}};
              txphinitdone_clear_slave  <= `DLY  1'b0;
              txdone_clear              <= `DLY  1'b0;
              tx_phalign_manual_state   <= `DLY  WAIT_PHRST_DONE;
            end
          end
           WAIT_PHRST_DONE :
          begin
            //Assert tx_dly_sreset_o for all lanes, hold high until
            //tx_dly_sreset_done_i of the respective lane is asserted.
            for (i = 0; i <= NUMBER_OF_LANES-1; i = i+1)
            begin
              if (txdlysresetdone_store[i])
                //Deassert tx_dly_sreset_o for the lane in which
                //the tx_dly_sreset_done_i is asserted:
                tx_dly_sreset_o[i] <= `DLY  1'b0;
            end
            if (txdlysresetdone_store == VCC_VEC) begin
              //When all tx_dly_sreset_done_i-signals are asserted, move
              //to the next state.
              tx_phalign_manual_state   <= `DLY  M_PHINIT;
          end
          end
           M_PHINIT :
           begin
            //Assert tx_ph_init_o on the master and hold high until a
            //rising edge on tx_ph_init_done_i is detected:
            tx_ph_init_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (txphinitdone_ris_edge[MASTER_LANE_ID])
            begin
              //Then deassert tx_ph_init_o and move to the next state.
              tx_ph_init_o[MASTER_LANE_ID]  <= `DLY  1'b0;
              tx_phalign_manual_state   <= `DLY  M_PHALIGN;
            end
           end
           M_PHALIGN :
           begin
            //Assert tx_ph_align_o on the master and hold high until a
            //rising edge on tx_ph_align_done_i is detected:
            tx_ph_align_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (txphaligndone_ris_edge[MASTER_LANE_ID])
            begin
              //Then dassert tx_ph_align_o and move to the next state.
              tx_ph_align_o[MASTER_LANE_ID] <= `DLY  1'b0;
              tx_phalign_manual_state   <= `DLY  M_DLYEN;
            end
           end
           M_DLYEN :
           begin
            //Assert tx_dly_en_o on the master and hold high until a
            //rising edge on tx_ph_align_done_i is detected.
            tx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (txphaligndone_ris_edge[MASTER_LANE_ID])
            begin
              if(NUMBER_OF_LANES >1)
              begin
                //Then deassert tx_dly_en_o and move to the next state.
                tx_dly_en_o[MASTER_LANE_ID]   <= `DLY  1'b0;
                tx_phalign_manual_state   <= `DLY S_PHINIT;
              end
              else
                tx_phalign_manual_state   <= `DLY PHALIGN_DONE;
            end
           end
           S_PHINIT :
           begin
            //Assert tx_ph_init_o for all slave lane(s). Hold this
            //signal High until tx_ph_init_done_i of the respective
            //slave lane is asserted.
            tx_ph_init_o       <= `DLY  {NUMBER_OF_LANES{1'b1}}; //--\Assert only the PHINIT-signal
            tx_ph_init_o[MASTER_LANE_ID] <= `DLY  1'b0;          //--/the slaves.

            for (i = 0;i <= NUMBER_OF_LANES-1;i = i+1)
            begin
              if (txphinitdone_store_edge[i])
                //Deassert tx_ph_init_o for the slave lane in which
                //the tx_ph_init_done_i is asserted.
                tx_ph_init_o[i] <= `DLY  1'b0;
            end
            if (txphinitdone_store_edge == VCC_VEC)
            begin
              //When all tx_ph_init_done_i-signals are high and at least one rising edge
              //has been detected, move to the next state.
              //The reason for checking of the occurance of at least one rising edge
              //is to avoid the potential direct move where tx_ph_init_done_i might not
              //be going low fast enough.
              tx_phalign_manual_state   <= `DLY  S_PHALIGN;

            end
           end
           S_PHALIGN :
           begin
            //Assert tx_ph_align_o for all slave lane(s). Hold this signal High
            //until tx_ph_align_done_i of the respective slave lane is asserted.
               tx_ph_align_o                 <= `DLY  {NUMBER_OF_LANES{1'b1}};//again only assertion for slave
               tx_ph_align_o[MASTER_LANE_ID] <= `DLY  1'b0;                   //but not for master

            for (i = 0;i <= NUMBER_OF_LANES-1;i = i+1)
            begin
              if (txphaligndone_store[i])
                //Deassert tx_ph_align_o for the slave lane in which the
                //tx_ph_align_done_i is asserted.
                tx_ph_align_o[i] <= `DLY  1'b0;
            end
            if (txphaligndone_store == VCC_VEC)
              //When all tx_ph_align_done_i-signals are asserted high, move to the next
              //state.
              tx_phalign_manual_state   <= `DLY  M_DLYEN2;
            end
           M_DLYEN2 :
           begin
            //Assert tx_dly_en_o for the master lane. This causes tx_ph_align_done_i of
            //the master lane to be deasserted.
            tx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            if (txphaligndone_ris_edge[MASTER_LANE_ID])
              //Wait until tx_ph_align_done_i of the master lane reasserts. Phase
              //and delay alignment for the multilane interface is complete.
              tx_phalign_manual_state   <= `DLY  PHALIGN_DONE;
           end
           PHALIGN_DONE :
           begin
            //Continue to hold tx_dly_en_o for the master lane High to adjust
            //TXUSRCLK to compensate for temperature and voltage variations.
            tx_dly_en_o[MASTER_LANE_ID] <= `DLY  1'b1;
            phase_alignment_done_o    <= `DLY  1'b1;
           end

           default:
             tx_phalign_manual_state <= `DLY  INIT;

        endcase
      end
    end

endmodule

