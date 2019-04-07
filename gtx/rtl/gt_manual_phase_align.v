//
//  By David
//
//  2019-03-26
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define DLY #0


module gt_manual_phase_align #(
  parameter IS_MASTER_LANE                         = 1
)(
  stable_clk_i,             //Stable Clock, either a stable clock from the PCB
                            //or reference-clock present at startup.
  run_phalignment_i,        //Signal from the main Reset-FSM to run the auto phase-alignment procedure
  phase_alignment_done_o,   // Auto phase-alignment performed sucessfully
  phaligndone_i,            //\ Phase-alignment signals from and to the
  dlysreset_o,              // |transceiver.
  dlysresetdone_i,          ///
  phalign_o,
  dlyen_i,
  m2s_phaligndone_o,        // slave tell master phase alignment is done
  s2m_phaligndone_i,        // and slave start to phase align, finally slave tell master phase alignment is done
  recclkstable_i            //on the RX-side.
);


  input   wire   stable_clk_i;
  input   wire   run_phalignment_i;
  output  reg    phase_alignment_done_o;
  input   wire   phaligndone_i;
  output  reg    dlysreset_o;
  input   wire   dlysresetdone_i;
  output  reg    phalign_o;
  input   wire   dlyen_i;
  output  reg    m2s_phaligndone_o;
  input   wire   s2m_phaligndone_i;
  input   wire   recclkstable_i;


   localparam [1:0]
               INIT = 2'b00,
               WAIT_PHRST_DONE = 2'b01,
               COUNT_PHALIGN_DONE = 2'b10,
               PHALIGN_DONE = 2'b11;


  reg [1:0] phalign_state;
  reg       phaligndone_i_prev;
  wire      phaligndone_i_ris_edge;
  wire      phaligndone_i_sync;
  wire      dlysresetdone_sync;

  reg [1:0] count_phalign_edges;


  //Clock Domain Crossing
  gtwizard_0_sync_block sync_phaligndone_i
  (
    .clk             (stable_clk_i),
    .data_in         (phaligndone_i),
    .data_out        (phaligndone_i_sync)
  );

  gtwizard_0_sync_block sync_DLYSRESETDONE
  (
    .clk             (stable_clk_i),
    .data_in         (dlysresetdone_i),
    .data_out        (dlysresetdone_sync)
  );


  //The logic below implements the procedure to do automatic phase-alignment on the
  //7-series GTX as described in ug476pdf, version 1.3, Chapters "Using the TX Phase
  //Alignment to Bypass the TX Buffer" and "Using the RX Phase Alignment to Bypass
  //the RX Elastic Buffer"
  //Should the logic below differ from what is described in a later version of the
  //user-guide, you are using an auto-alignment block, which is out of date and needs
  //to be updated for safe operation.


  always @(posedge stable_clk_i)
  begin
    phaligndone_i_prev <= `DLY phaligndone_i_sync;
  end

  assign phaligndone_i_ris_edge = ((phaligndone_i_prev == 0) && (phaligndone_i_sync == 1)) ? 1'b1 : 1'b0;

  always @(posedge stable_clk_i)
  begin
    if ((run_phalignment_i == 1'b0) || (recclkstable_i == 1'b0))
    begin
      dlysreset_o             <= `DLY 1'b0;
      count_phalign_edges   <= `DLY 2'b00;
      phase_alignment_done_o  <= `DLY 1'b0;
      phalign_state         <= `DLY INIT;
    end

    else
    begin
      if (phaligndone_i_ris_edge == 1)
      begin
        if (count_phalign_edges < 3)
          count_phalign_edges <= `DLY count_phalign_edges + 1'b1;
      end
      dlysreset_o   <= `DLY 1'b0;

      case (phalign_state)
        INIT :
        begin
          phase_alignment_done_o <= `DLY 1'b0;
          if ((run_phalignment_i == 1'b1) && (recclkstable_i == 1'b1))
          begin
            //dlysreset_o is toggled to '1'
            dlysreset_o     <= `DLY 1'b1;
            phalign_state <= `DLY WAIT_PHRST_DONE;
          end
        end

        WAIT_PHRST_DONE :
        begin
        if (dlysresetdone_sync == 1'b1)
          phalign_state <= `DLY COUNT_PHALIGN_DONE;
        end
        //No timeout-check here as that is done in the main FSM

        COUNT_PHALIGN_DONE :
        begin
        if (count_phalign_edges == 2'b10)

          //For GTX: Only on the second edge of the phaligndone_i-signal the
          //         phase-alignment is completed
          //For GTH, GTP: TXSYNCDONE indicates the completion of Phase Alignment
          phalign_state <= `DLY PHALIGN_DONE;
        end

        PHALIGN_DONE :
        begin
        phase_alignment_done_o <= `DLY 1'b1;
        end

        default:
          phalign_state      <= `DLY INIT;

      endcase
    end
  end

  endmodule
