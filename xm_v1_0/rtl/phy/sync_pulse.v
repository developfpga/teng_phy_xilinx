//
//  By David
//
//  2019.4.3
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1


module sync_pulse #(
  parameter   C_NUM_SRETCH_REGS = 3,
  parameter   C_NUM_SYNC_REGS = 3
)

(
  // User Interface
  output reg      pulse_o = 0,

  // GT Interface
  input           pulse_i,

  // Clock and Reset
  input           CLK
);

// ---------------------------------------------------------------------------
// Wire and Register Declaration
// ---------------------------------------------------------------------------
reg  [C_NUM_SRETCH_REGS-1:0]  stretch_r = {C_NUM_SRETCH_REGS{1'b0}};
(* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg  [C_NUM_SYNC_REGS-1:0]    sync1_r = {C_NUM_SYNC_REGS{1'b0}};
(* shreg_extract = "no", ASYNC_REG = "TRUE" *) reg  [C_NUM_SYNC_REGS-1:0]    sync2_r = {C_NUM_SYNC_REGS{1'b0}};


//----------------------------------------------------------------------------
// Stretch pulse_i Signal
//----------------------------------------------------------------------------
always @(posedge CLK or negedge pulse_i) begin
  if (~pulse_i)
    stretch_r <= {C_NUM_SRETCH_REGS{1'b0}};
  else
    stretch_r <= {1'b1, stretch_r[C_NUM_SRETCH_REGS-1:1]};
end

//----------------------------------------------------------------------------
// Synchronizers
//----------------------------------------------------------------------------
always @(posedge CLK) begin
  sync1_r <= {stretch_r[0], sync1_r[C_NUM_SYNC_REGS-1:1]};
end

always @(posedge CLK) begin
  sync2_r <= {pulse_i, sync2_r[C_NUM_SYNC_REGS-1:1]};
end

//----------------------------------------------------------------------------
// Final Flop Stage with AND of both synchronizers - keeps pulse_o low
// when input is low for many cycles...
//----------------------------------------------------------------------------
always @(posedge CLK) begin
  pulse_o <= sync1_r[0] & sync2_r[0];
end

endmodule

