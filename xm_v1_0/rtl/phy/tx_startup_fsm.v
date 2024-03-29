//
//  By David
//
//  2019.3.28
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1
`define CLOG2(x) \
   (x <= 2) ? 1 : \
   (x <= 4) ? 2 : \
   (x <= 8) ? 3 : \
   (x <= 16) ? 4 : \
   (x <= 32) ? 5 : \
   (x <= 64) ? 6 : \
   (x <= 128) ? 7 : \
   (x <= 256) ? 8 : \
   (x <= 512) ? 9 : \
   (x <= 1024) ? 10 : \
   (x <= 2048) ? 11 : \
   (x <= 4096) ? 12 : \
   (x <= 8192) ? 13 : \
   (x <= 16384) ? 14 : \
   (x <= 32768) ? 15 : \
   (x <= 65536) ? 16 : \
   (x <= 131072) ? 17 : \
   (x <= 262144) ? 18 : \
   (x <= 524288) ? 19 : \
   -1

module tx_startup_fsm  #
  (
    parameter     STABLE_CLOCK_PERIOD      = 8,        // Period of the stable clock driving this state-machine, unit is [ns]
    parameter     RETRY_COUNTER_BITWIDTH   = 8,
    parameter     SIMULATION       = 0,
    parameter     TX_QPLL_USED             = "FALSE",  // the TX and RX Reset FSMs must
    parameter     RX_QPLL_USED             = "FALSE",  // share these two generic values
    parameter     PHASE_ALIGNMENT_MANUAL   = "TRUE"    // Decision if a manual phase-alignment is necessary or the automatic
                                                        // is enough. For single-lane applications the automatic alignment is
                                                        // sufficient
  )
  (
    input  wire      stable_clk_i,             //Stable Clock, either a stable clock from the PCB
    input  wire      tx_user_clk_i,            //tx_user_clk_i as used in the design
    input  wire      soft_reset_i,             //User Reset, can be pulled any time
    input  wire      qpll_ref_clk_lost_i,      //QPLL Reference-clock for the GT is lost
    input  wire      cpll_ref_clk_lost_i,      //CPLL Reference-clock for the GT is lost
    input  wire      qpll_lock_i,              //Lock Detect from the QPLL of the GT
    input  wire      cpll_lock_i,              //Lock Detect from the CPLL of the GT
    input  wire      tx_reset_done_i,
    input  wire      mmcm_lock_i,
    output           gt_tx_reset_o,
    output reg       mmcm_reset_o = 1'b1,
    output reg       qpll_reset_o = 1'b0,        //Reset QPLL
    output reg       cpll_reset_o = 1'b0,        //Reset CPLL
    output           tx_fsm_reset_done_o,        //Reset-sequence has sucessfully been finished.
    output reg       tx_user_rdy_o = 1'b0 ,
    output           run_phalignment_o,
    output reg       reset_phalignment_o = 1'b0,
    input  wire      phalignment_done_i,

    output [RETRY_COUNTER_BITWIDTH-1:0] retry_count_o // Number of
                                                      // Retries it took to get the transceiver up and running
  );


//Interdependencies:
// * Timing depends on the frequency of the stable clock. Hence counters-sizes
//   are calculated at design-time based on the Generics
//
// * if either of the PLLs is reset during TX-startup, it does not need to be reset again by RX
//   => signal which PLL has been reset
// *


  localparam [3:0]
               INIT = 4'b0000,
               ASSERT_ALL_RESETS = 4'b0001,
               WAIT_FOR_PLL_LOCK = 4'b0010,
               RELEASE_PLL_RESET = 4'b0011,
               WAIT_FOR_TXOUTCLK = 4'b0100,
               RELEASE_MMCM_RESET = 4'b0101,
               WAIT_FOR_TXUSRCLK = 4'b0110,
               WAIT_RESET_DONE = 4'b0111,
               DO_PHASE_ALIGNMENT = 4'b1000,
               RESET_FSM_DONE = 4'b1001;

  reg [3:0] tx_state = INIT;


  localparam integer MMCM_LOCK_CNT_MAX = 256;
  localparam integer STARTUP_DELAY    = 500;//AR43482: Transceiver needs to wait for 500 ns after configuration
  localparam integer WAIT_CYCLES      = STARTUP_DELAY / STABLE_CLOCK_PERIOD; // Number of Clock-Cycles to wait after configuration
  localparam integer WAIT_MAX         = WAIT_CYCLES + 10;                    // 500 ns plus some additional margin

  localparam integer WAIT_TIMEOUT_2ms   = 2000000 / STABLE_CLOCK_PERIOD;//  2 ms time-out
  localparam integer WAIT_TLOCK_MAX     =  100000 / STABLE_CLOCK_PERIOD;//100 us time-out
  localparam integer WAIT_TIMEOUT_500us =  500000 / STABLE_CLOCK_PERIOD;//100 us time-out
  localparam integer WAIT_1us_CYCLES =  1000 / STABLE_CLOCK_PERIOD;//1 us time-out
  localparam integer WAIT_1us =  WAIT_1us_CYCLES+10; //1us plus additional margin
  localparam integer WAIT_TIME_MAX   = SIMULATION? 100 : 10000 / STABLE_CLOCK_PERIOD;
  localparam integer PORT_WIDTH   = `CLOG2(WAIT_TIMEOUT_2ms);

  reg     [7:0]   init_wait_count = 0;
  reg             init_wait_done = 1'b0;
  reg             pll_reset_asserted = 1'b0;


  reg             tx_fsm_reset_done_int    = 1'b0;
  wire            tx_fsm_reset_done_int_s2;
  reg             tx_fsm_reset_done_int_s3 = 1'b0;

  localparam integer MAX_RETRIES          = 2**RETRY_COUNTER_BITWIDTH-1;
  reg     [7:0]   retry_counter_int = 0;
  reg     [PORT_WIDTH-1:0] time_out_counter = 0;

  reg             reset_time_out = 1'b0;
  reg             time_out_2ms   = 1'b0;  //--\Flags that the various time-out points
  reg             time_tlock_max = 1'b0;  //--|have been reached.
  reg             time_out_500us = 1'b0;  //--/

  reg     [9:0]   mmcm_lock_count = 0;
  reg             mmcm_lock_int = 1'b0;
  wire            s_mmcm_lock;
  reg             mmcm_lock_reclocked = 1'b0;

  reg             run_phase_alignment_int = 1'b0;
  wire            run_phase_alignment_int_s2;
  reg             run_phase_alignment_int_s3 = 1'b0;
  localparam integer MAX_WAIT_BYPASS      = 75264;

  reg     [16:0]  wait_bypass_count = 0;
  reg             time_out_wait_bypass    = 1'b0;
  wire            time_out_wait_bypass_s2;
  reg             time_out_wait_bypass_s3 = 1'b0;

  wire            txresetdone_s2;
  reg             txresetdone_s3 = 1'b0;
  reg             gttxreset_i = 1'b0;
  reg             txpmaresetdone_i = 1'b0;
  wire            txpmaresetdone_sync;

  wire            refclk_lost;
  wire            cplllock_sync;
  wire            qplllock_sync;
  reg      [15:0] wait_time_cnt;
  wire            wait_time_done;

  //Alias section, signals used within this module mapped to output ports:
  assign retry_count_o     = retry_counter_int;
  assign run_phalignment_o   = run_phase_alignment_int;
  assign tx_fsm_reset_done_o = tx_fsm_reset_done_int;
  assign gt_tx_reset_o = gttxreset_i;

  always @(posedge stable_clk_i or posedge soft_reset_i)
  begin
    // The counter starts running when configuration has finished and
    // the clock is stable. When its maximum count-value has been reached,
    // the 500 ns from Answer Record 43482 have been passed.
    if(soft_reset_i)
    begin
        init_wait_count <= `DLY 8'h0;
        init_wait_done  <= `DLY 1'b0;
    end
    else if (init_wait_count == WAIT_MAX)
        init_wait_done <= `DLY  1'b1;
    else
      init_wait_count <= `DLY  init_wait_count + 1;
   end


  always @(posedge stable_clk_i)
  begin
    // One common large counter for generating three time-out signals.
    // Intermediate time-outs are derived from calculated values, based
    // on the period of the provided clock.
    if (reset_time_out == 1'b1)
    begin
      time_out_counter  <= `DLY  0;
      time_out_2ms      <= `DLY  1'b0;
      time_tlock_max    <= `DLY  1'b0;
      time_out_500us    <= `DLY  1'b0;
    end
    else
    begin
      if (time_out_counter == WAIT_TIMEOUT_2ms)
        time_out_2ms <= `DLY  1'b1;
      else
        time_out_counter <= `DLY  time_out_counter + 1;

      if (time_out_counter == WAIT_TLOCK_MAX)
        time_tlock_max <= `DLY  1'b1;

      if (time_out_counter == WAIT_TIMEOUT_500us)
        time_out_500us <= `DLY  1'b1;
    end
  end

  always @(posedge stable_clk_i)
  begin
    if (s_mmcm_lock == 1'b0)
    begin
      mmcm_lock_count <= `DLY  0;
      mmcm_lock_reclocked   <= `DLY  1'b0;
    end
    else
    begin
      if (mmcm_lock_count < MMCM_LOCK_CNT_MAX - 1)
        mmcm_lock_count <= `DLY  mmcm_lock_count + 1;
      else
        mmcm_lock_reclocked <= `DLY  1'b1;
    end
  end


  //Clock Domain Crossing
 sync_block sync_run_phase_alignment_int
        (
           .clk             (tx_user_clk_i),
           .data_in         (run_phase_alignment_int),
           .data_out        (run_phase_alignment_int_s2)
        );

 sync_block sync_tx_fsm_reset_done_int
        (
           .clk             (tx_user_clk_i),
           .data_in         (tx_fsm_reset_done_int),
           .data_out        (tx_fsm_reset_done_int_s2)
        );

  always @(posedge tx_user_clk_i)
  begin
     run_phase_alignment_int_s3 <= `DLY run_phase_alignment_int_s2;
     tx_fsm_reset_done_int_s3   <= `DLY tx_fsm_reset_done_int_s2;
  end

sync_block sync_time_out_wait_bypass
        (
           .clk             (stable_clk_i),
           .data_in         (time_out_wait_bypass),
           .data_out        (time_out_wait_bypass_s2)
        );

 sync_block sync_TXRESETDONE
        (
           .clk             (stable_clk_i),
           .data_in         (tx_reset_done_i),
           .data_out        (txresetdone_s2)
        );

 sync_block sync_mmcm_lock_reclocked
        (
           .clk             (stable_clk_i),
           .data_in         (mmcm_lock_i),
           .data_out        (s_mmcm_lock)
        );

 sync_block sync_cplllock
        (
           .clk             (stable_clk_i),
           .data_in         (cpll_lock_i),
           .data_out        (cplllock_sync)
        );

 sync_block sync_qplllock
        (
           .clk             (stable_clk_i),
           .data_in         (qpll_lock_i),
           .data_out        (qplllock_sync)
        );


  always @(posedge stable_clk_i)
  begin
     time_out_wait_bypass_s3   <= `DLY time_out_wait_bypass_s2;
     txresetdone_s3            <= `DLY txresetdone_s2;
  end


  always @(posedge tx_user_clk_i)
  begin
    if (run_phase_alignment_int_s3 == 1'b0)
    begin
      wait_bypass_count     <= `DLY  0;
      time_out_wait_bypass  <= `DLY  1'b0;
    end
    else if (run_phase_alignment_int_s3 == 1'b1 && tx_fsm_reset_done_int_s3 == 1'b0)
    begin
      if (wait_bypass_count == MAX_WAIT_BYPASS - 1)
        time_out_wait_bypass <= `DLY  1'b1;
      else
        wait_bypass_count <= `DLY  wait_bypass_count + 1;
    end
  end

  assign refclk_lost = ( TX_QPLL_USED == "TRUE"  && qpll_ref_clk_lost_i == 1'b1) ? 1'b1 :
                       ( TX_QPLL_USED == "FALSE" && cpll_ref_clk_lost_i == 1'b1) ? 1'b1 : 1'b0;


  always @(posedge stable_clk_i )
  begin
    if((tx_state == ASSERT_ALL_RESETS) |
       (tx_state == RELEASE_PLL_RESET) |
       (tx_state == RELEASE_MMCM_RESET))
    begin
      wait_time_cnt <= `DLY WAIT_TIME_MAX;
    end else if (wait_time_cnt != 16'h0)
    begin
      wait_time_cnt <= wait_time_cnt - 16'h1;
    end

  end

  assign wait_time_done = (wait_time_cnt == 16'h0);



  //FSM for resetting the GTX/GTH/GTP in the 7-series.
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //
  // Following steps are performed:
  // 1) Only for GTX - After configuration wait for approximately 500 ns as specified in
  //    answer-record 43482
  // 2) Assert all resets on the GT and on an MMCM potentially connected.
  //    After that wait until a reference-clock has been detected.
  // 3) Release the reset to the GT and wait until the GT-PLL has locked.
  // 4) Release the MMCM-reset and wait until the MMCM has signalled lock.
  //    Also signal to the RX-side which PLL has been reset.
  // 5) Wait for the RESET_DONE-signal from the GTX.
  // 6) Signal to start the phase-alignment procedure and wait for it to
  //    finish.
  // 7) Reset-sequence has successfully run through. Signal this to the
  //    rest of the design by asserting tx_fsm_reset_done_o.

  always @(posedge stable_clk_i)
  begin
    if (soft_reset_i == 1'b1)
    //if (soft_reset_i == 1'b1 || (tx_state != INIT && tx_state != ASSERT_ALL_RESETS && refclk_lost == 1'b1))
    begin
      tx_state                    <= `DLY  INIT;
      tx_user_rdy_o               <= `DLY  1'b0;
      gttxreset_i                 <= `DLY  1'b0;
      mmcm_reset_o                <= `DLY  1'b0;
      tx_fsm_reset_done_int       <= `DLY  1'b0;
      qpll_reset_o                <= `DLY  1'b0;
      cpll_reset_o                <= `DLY  1'b0;
      pll_reset_asserted          <= `DLY  1'b0;
      reset_time_out              <= `DLY  1'b0;
      retry_counter_int           <= `DLY   0;
      run_phase_alignment_int     <= `DLY  1'b0;
      reset_phalignment_o         <= `DLY  1'b1;
    end
    else
    begin
      case (tx_state)
          INIT :
          begin
          //Initial state after configuration. This state will be left after
          //approx. 500 ns and not be re-entered.
          if (init_wait_done == 1'b1)
            tx_state           <= `DLY  ASSERT_ALL_RESETS;
            reset_time_out     <= `DLY  1'b1;
          end

          ASSERT_ALL_RESETS :
          begin
          //This is the state into which the FSM will always jump back if any
          //time-outs will occur.
          //The number of retries is reported on the output retry_count_o. In
          //case the transceiver never comes up for some reason, this machine
          //will still continue its best and rerun until the FPGA is turned off
          //or the transceivers come up correctly.
          if (TX_QPLL_USED == "TRUE")
          begin
            if ((pll_reset_asserted == 1'b0 && refclk_lost == 1'b0))
            begin
              qpll_reset_o          <= `DLY  1'b1;
              pll_reset_asserted  <= `DLY  1'b1;
            end
            else
              qpll_reset_o          <= `DLY  1'b0;
          end
          else
          begin
            if ((pll_reset_asserted == 1'b0 && refclk_lost == 1'b0))
            begin
              cpll_reset_o <= `DLY  1'b1;
              pll_reset_asserted  <= `DLY  1'b1;
            end
            else
              cpll_reset_o          <= `DLY  1'b0;
          end
          tx_user_rdy_o               <= `DLY  1'b0;
          gttxreset_i             <= `DLY  1'b1;
          mmcm_reset_o              <= `DLY  1'b1;
          reset_time_out          <= `DLY  1'b1;
          run_phase_alignment_int <= `DLY  1'b0;
          reset_phalignment_o       <= `DLY  1'b1;

          if ((TX_QPLL_USED == "TRUE" && qplllock_sync == 1'b0 && pll_reset_asserted ) ||
              (TX_QPLL_USED == "FALSE" && cplllock_sync == 1'b0 && pll_reset_asserted ))
            tx_state  <= `DLY  WAIT_FOR_PLL_LOCK;

          end

          WAIT_FOR_PLL_LOCK :
          begin
            if(wait_time_done)
                tx_state        <= `DLY RELEASE_PLL_RESET;
          end

          RELEASE_PLL_RESET :
          begin
          //PLL-Reset of the GTX gets released and the time-out counter
          //starts running.
          pll_reset_asserted  <= `DLY  1'b0;
          reset_time_out  <= `DLY  1'b0;

          if ((TX_QPLL_USED == "TRUE" && qplllock_sync == 1'b1) ||
              (TX_QPLL_USED == "FALSE" && cplllock_sync == 1'b1))
          begin
            tx_state  <= `DLY  WAIT_FOR_TXOUTCLK;
            reset_time_out  <= `DLY  1'b1;
          end

          if (time_out_2ms == 1'b1)
          begin
              if (retry_counter_int == MAX_RETRIES)
              // If too many retries are performed compared to what is specified in
              // the generic, the counter simply wraps around.
              retry_counter_int <= `DLY  0;
              else
              retry_counter_int <= `DLY  retry_counter_int + 1;
            tx_state            <= `DLY  ASSERT_ALL_RESETS;
          end
          end

          WAIT_FOR_TXOUTCLK :
          begin
          gttxreset_i <= `DLY  1'b0;
            if(wait_time_done)
              tx_state <= `DLY RELEASE_MMCM_RESET;
          end


          RELEASE_MMCM_RESET :
          begin
          //Release of the MMCM-reset. Waiting for the MMCM to lock.
          mmcm_reset_o <= `DLY  1'b0;
          reset_time_out  <= `DLY  1'b0;

          if (mmcm_lock_reclocked == 1'b1)
          begin
            tx_state <= `DLY  WAIT_FOR_TXUSRCLK;
            reset_time_out  <= `DLY  1'b1;
          end

          if (time_tlock_max == 1'b1 && mmcm_lock_reclocked == 1'b0 && reset_time_out == 1'b0)
          begin
            if (retry_counter_int == MAX_RETRIES)
              // If too many retries are performed compared to what is specified in
              // the generic, the counter simply wraps around.
              retry_counter_int <= `DLY  0;
            else
              retry_counter_int <= `DLY  retry_counter_int + 1;
            tx_state            <= `DLY  ASSERT_ALL_RESETS;
          end
          end

          WAIT_FOR_TXUSRCLK :
          begin
            if(wait_time_done)
              tx_state <= `DLY WAIT_RESET_DONE;
          end

          WAIT_RESET_DONE :
          begin
          tx_user_rdy_o   <= `DLY  1'b1;
          reset_time_out  <= `DLY  1'b0;
          if (txresetdone_s3 == 1'b1)
          begin
            tx_state      <= `DLY  DO_PHASE_ALIGNMENT;
            reset_time_out  <= `DLY  1'b1;
          end

          if (time_out_500us == 1'b1 && reset_time_out == 1'b0)
          begin
            if (retry_counter_int == MAX_RETRIES)
              // If too many retries are performed compared to what is specified in
              // the generic, the counter simply wraps around.
              retry_counter_int <= `DLY  0;
            else
              retry_counter_int <= `DLY  retry_counter_int + 1;
            tx_state            <= `DLY  ASSERT_ALL_RESETS;
          end
          end

          DO_PHASE_ALIGNMENT :
          begin
          //The direct handling of the signals for the Phase Alignment is done outside
          //this state-machine.
          reset_phalignment_o       <= `DLY  1'b0;
          run_phase_alignment_int <= `DLY  1'b1;
          reset_time_out          <= `DLY  1'b0;

          if (phalignment_done_i == 1'b1)
            tx_state        <= `DLY  RESET_FSM_DONE;

          if (time_out_wait_bypass_s3 == 1'b1)
          begin
            if (retry_counter_int == MAX_RETRIES)
              // If too many retries are performed compared to what is specified in
              // the generic, the counter simply wraps around.
              retry_counter_int <= `DLY  0;
            else
              retry_counter_int <= `DLY   retry_counter_int + 1;
            tx_state            <= `DLY  ASSERT_ALL_RESETS;
          end
          end

          RESET_FSM_DONE :
          begin
          reset_time_out        <= `DLY  1'b1;
          tx_fsm_reset_done_int <= `DLY  1'b1;
          end

          default:
            tx_state            <= `DLY  INIT;

      endcase
    end
  end

endmodule
