//
//  By David
//
//  2019.4.3
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`define DLY #1


//(* dont_touch = "yes" *)
module sync_block #(
  parameter INITIALISE = 6'b000000
)
(
  input        clk,              // clock to be sync'ed to
  input        data_in,          // Data to be 'synced'
  output       data_out          // synced data
);

  // Internal Signals
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire data_sync6;


  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
    .INIT (INITIALISE[0])
  ) data_sync_reg1 (
    .C  (clk),
    .D  (data_in),
    .Q  (data_sync1)
  );


  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
   .INIT (INITIALISE[1])
  ) data_sync_reg2 (
  .C  (clk),
  .D  (data_sync1),
  .Q  (data_sync2)
  );


  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
   .INIT (INITIALISE[2])
  ) data_sync_reg3 (
  .C  (clk),
  .D  (data_sync2),
  .Q  (data_sync3)
  );

  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
   .INIT (INITIALISE[3])
  ) data_sync_reg4 (
  .C  (clk),
  .D  (data_sync3),
  .Q  (data_sync4)
  );

  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
   .INIT (INITIALISE[4])
  ) data_sync_reg5 (
  .C  (clk),
  .D  (data_sync4),
  .Q  (data_sync5)
  );

  (* shreg_extract = "no", ASYNC_REG = "TRUE" *)
  FD #(
   .INIT (INITIALISE[5])
  ) data_sync_reg6 (
  .C  (clk),
  .D  (data_sync5),
  .Q  (data_sync6)
  );
  assign data_out = data_sync6;



endmodule
