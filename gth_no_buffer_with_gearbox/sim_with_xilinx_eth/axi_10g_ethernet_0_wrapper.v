// ----------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// ----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Title      : Example Design top level
// Project    : 10G Gigabit Ethernet
//-----------------------------------------------------------------------------
// File       : axi_10g_ethernet_0_wrapper.v
// Author     : Xilinx Inc.
//-----------------------------------------------------------------------------
// Description: This is the example design top level code for the 10G
//              Gigabit Ethernet IP.  It contains the FIFO block of the example
//              design along with a frame pattern generator and checker.
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module axi_10g_ethernet_0_wrapper
  (
   // Clock inputs
   input             clk_in_p,       // Freerunning clock source
   input             clk_in_n,
   input             refclk_p,       // Transceiver reference clock source
   input             refclk_n,
   output            coreclk_out,

   // Example design control inputs
   input             pcs_loopback,
   input             reset,
   // input             reset_error,
   // input             insert_error,
   // input             enable_pat_gen,
   // input             enable_pat_check,
   output            serialized_stats,
   input             sim_speedup_control,
   input             enable_custom_preamble,

   // Example design status outputs
   // output            frame_error,
   // output            gen_active_flash,
   // output            check_active_flash,
   output            core_ready,
   output            qplllock_out,

   input     [63:0]  tx_axis_tdata,
   input     [7:0]   tx_axis_tkeep,
   input             tx_axis_tvalid,
   input             tx_axis_tlast,
   output            tx_axis_tready,
   output     [63:0] rx_axis_tdata,
   output     [7:0]  rx_axis_tkeep,
   output            rx_axis_tvalid,
   output            rx_axis_tlast,
   input             rx_axis_tready,
   // Serial I/O from/to transceiver
   output            txp,
   output            txn,
   input             rxp,
   input             rxn
   );
/*-------------------------------------------------------------------------*/


   // Set FIFO memory size
   localparam        FIFO_SIZE  = 1024;


   // Signal declarations
   wire              enable_vlan;
   // wire              reset_error_sync;

   wire              coreclk;
   wire              block_lock;
   wire              rxrecclk;
   wire              s_axi_aclk;

   wire              tx_dcm_locked;
   wire              no_remote_and_local_faults;
   wire    [79 : 0]  mac_tx_configuration_vector;
   wire    [79 : 0]  mac_rx_configuration_vector;
   wire   [2 : 0]    mac_status_vector;
   wire   [535 : 0]  pcs_pma_configuration_vector;
   wire   [447 : 0]  pcs_pma_status_vector;

   wire              tx_statistics_vector;
   wire              rx_statistics_vector;
   wire     [25:0]   tx_statistics_vector_int;
   wire              tx_statistics_valid_int;
   reg               tx_statistics_valid;
   reg      [27:0]   tx_statistics_shift = 0;
   wire     [29:0]   rx_statistics_vector_int;
   wire              rx_statistics_valid_int;
   reg               rx_statistics_valid;
   reg      [31:0]   rx_statistics_shift = 0;

   wire              tx_reset;
   wire              rx_reset;

   wire              tx_axis_aresetn;
   wire              rx_axis_aresetn;

   // wire              pat_gen_start;

   wire              resetdone_out;
   wire              resetdone_out_rising_edge;
   reg               resetdone_out_reg;
   reg       [1:0]   resetdone_out_count = 2'b0;
   wire      [7:0]   pcspma_status;

   wire              pcs_loopback_sync;
   wire              enable_custom_preamble_coreclk_sync;
   // wire              insert_error_sync;


   assign coreclk_out = coreclk;

   // Enable or disable VLAN mode
   assign enable_vlan = 0;

   // Synchronise example design inputs into the applicable clock domain
   // axi_10g_ethernet_0_sync_block sync_insert_error (
   //    .data_in                         (insert_error),
   //    .clk                             (coreclk),
   //    .data_out                        (insert_error_sync)
   // );

   axi_10g_ethernet_0_sync_block sync_coreclk_enable_custom_preamble (
      .data_in                         (enable_custom_preamble),
      .clk                             (coreclk),
      .data_out                        (enable_custom_preamble_coreclk_sync)
   );


   axi_10g_ethernet_0_sync_block sync_pcs_loopback (
      .data_in                         (pcs_loopback),
      .clk                             (coreclk),
      .data_out                        (pcs_loopback_sync)
   );

   // Assign the configuration settings to the configuration vectors
   assign mac_rx_configuration_vector = {72'd0,enable_custom_preamble_coreclk_sync,4'd0,enable_vlan,2'b10};
   assign mac_tx_configuration_vector = {72'd0,enable_custom_preamble_coreclk_sync,4'd0,enable_vlan,2'b10};

   assign pcs_pma_configuration_vector = {425'd0,pcs_loopback_sync,110'd0};
   assign block_lock = pcspma_status[0];
   assign no_remote_and_local_faults = !mac_status_vector[0] && !mac_status_vector[1] ;
   assign core_ready = block_lock && no_remote_and_local_faults && resetdone_out_count[1];
   
   assign resetdone_out_rising_edge  = resetdone_out & !resetdone_out_reg;

   always @(posedge coreclk)
   begin
     resetdone_out_reg <= resetdone_out;
   end

   always @(posedge coreclk)
   begin
      if (reset) begin
         resetdone_out_count <= 0;
      end
      else if (resetdone_out_rising_edge) begin
         resetdone_out_count <= resetdone_out_count + 1;
      end
   end
   // assign core_ready = block_lock && no_remote_and_local_faults;

   // Combine reset sources
   assign tx_axis_aresetn  = ~reset;
   assign rx_axis_aresetn  = ~reset;

   // assign pat_gen_start = enable_pat_gen && no_remote_and_local_faults && (pcs_loopback_sync || (block_lock && !pcs_loopback_sync));

   // The serialized statistics vector output is intended to only prevent logic stripping
   assign serialized_stats = tx_statistics_vector || rx_statistics_vector;

   assign tx_reset  = reset;
   assign rx_reset  = reset;



    //--------------------------------------------------------------------------
    // Instantiate a module containing the Ethernet core and an example FIFO
    //--------------------------------------------------------------------------
    axi_10g_ethernet_0_fifo_block #(
      .FIFO_SIZE                       (FIFO_SIZE)
    ) fifo_block_i (
      .refclk_p                        (refclk_p),
      .refclk_n                        (refclk_n),
      .coreclk_out                     (coreclk),
      .rxrecclk_out                    (rxrecclk),
      .dclk                            (s_axi_aclk),

      .reset                           (reset),

      .tx_ifg_delay                    (8'd0),

      .tx_statistics_vector            (tx_statistics_vector_int),
      .tx_statistics_valid             (tx_statistics_valid_int),
      .rx_statistics_vector            (rx_statistics_vector_int),
      .rx_statistics_valid             (rx_statistics_valid_int),

      .pause_val                       (16'b0),
      .pause_req                       (1'b0),

      .rx_axis_fifo_aresetn            (rx_axis_aresetn),
      .rx_axis_mac_aresetn             (rx_axis_aresetn),
      .rx_axis_fifo_tdata              (rx_axis_tdata),
      .rx_axis_fifo_tkeep              (rx_axis_tkeep),
      .rx_axis_fifo_tvalid             (rx_axis_tvalid),
      .rx_axis_fifo_tlast              (rx_axis_tlast),
      .rx_axis_fifo_tready             (rx_axis_tready),
      .tx_axis_mac_aresetn             (tx_axis_aresetn),
      .tx_axis_fifo_aresetn            (tx_axis_aresetn),
      .tx_axis_fifo_tdata              (tx_axis_tdata),
      .tx_axis_fifo_tkeep              (tx_axis_tkeep),
      .tx_axis_fifo_tvalid             (tx_axis_tvalid),
      .tx_axis_fifo_tlast              (tx_axis_tlast),
      .tx_axis_fifo_tready             (tx_axis_tready),

      .mac_tx_configuration_vector     (mac_tx_configuration_vector),
      .mac_rx_configuration_vector     (mac_rx_configuration_vector),
      .mac_status_vector               (mac_status_vector),
      .pcs_pma_configuration_vector    (pcs_pma_configuration_vector),
      .pcs_pma_status_vector           (pcs_pma_status_vector),

      .txp                             (txp),
      .txn                             (txn),
      .rxp                             (rxp),
      .rxn                             (rxn),

      .signal_detect                   (1'b1),
      .tx_fault                        (1'b0),
      .sim_speedup_control             (sim_speedup_control),
      .pcspma_status                   (pcspma_status),
      .resetdone_out                   (resetdone_out),
      .qplllock_out                    (qplllock_out)
      );


    //--------------------------------------------------------------------------
    // Instantiate the AXI-LITE/DRPCLK Clock source module
    //--------------------------------------------------------------------------

    axi_10g_ethernet_0_clocking axi_lite_clocking_i (
      .clk_in_p                        (clk_in_p),
      .clk_in_n                        (clk_in_n),
      .s_axi_aclk                      (s_axi_aclk),
      .tx_mmcm_reset                   (tx_reset),
      .tx_mmcm_locked                  (tx_dcm_locked)
    );



   //  axi_10g_ethernet_0_sync_block reset_error_sync_reg (
   //    .clk                             (coreclk),
   //    .data_in                         (reset_error),
   //    .data_out                        (reset_error_sync)
   //    );

    //--------------------------------------------------------------------------
    // Instantiate the pattern generator / pattern checker and loopback module
    //--------------------------------------------------------------------------

   //  axi_10g_ethernet_0_gen_check_wrapper pattern_generator (
      // .dest_addr                       (48'hda0102030405),
      // .src_addr                        (48'h5a0102030405),
      // .max_size                        (15'd300),
      // .min_size                        (15'd066),
      // .enable_vlan                     (enable_vlan),
      // .vlan_id                         (12'h002),
      // .vlan_priority                   (3'b010),
      // .preamble_data                   (56'hD55555567555FB),
      // .enable_custom_preamble          (enable_custom_preamble_coreclk_sync),

      // .aclk                            (coreclk),

      // .aresetn                         (tx_axis_aresetn),
      // .enable_pat_gen                  (pat_gen_start),
      // .reset_error                     (reset_error_sync),
      // .insert_error                    (insert_error_sync),
      // .enable_pat_check                (enable_pat_check),
      // .enable_loopback                 (!pat_gen_start),
      // .frame_error                     (frame_error),
      // .gen_active_flash                (gen_active_flash),
      // .check_active_flash              (check_active_flash),

      // .tx_axis_tdata                   (tx_axis_tdata),
      // .tx_axis_tkeep                   (tx_axis_tkeep),
      // .tx_axis_tvalid                  (tx_axis_tvalid),
      // .tx_axis_tlast                   (tx_axis_tlast),
      // .tx_axis_tready                  (tx_axis_tready),
      // .rx_axis_tdata                   (rx_axis_tdata),
      // .rx_axis_tkeep                   (rx_axis_tkeep),
      // .rx_axis_tvalid                  (rx_axis_tvalid),
      // .rx_axis_tlast                   (rx_axis_tlast),
      // .rx_axis_tready                  (rx_axis_tready)
   // );


   //--------------------------------------------------------------------------
   // serialise the stats vector output to ensure logic isn't stripped during
   // synthesis and to reduce the IO required by the example design
   //--------------------------------------------------------------------------
   always @(posedge coreclk)
   begin
     tx_statistics_valid               <= tx_statistics_valid_int;
     if (tx_statistics_valid_int & !tx_statistics_valid) begin
        tx_statistics_shift            <= {2'b01,tx_statistics_vector_int};
     end
     else begin
        tx_statistics_shift            <= {tx_statistics_shift[26:0], 1'b0};
     end
   end

   assign tx_statistics_vector         = tx_statistics_shift[27];

   always @(posedge coreclk)
   begin
     rx_statistics_valid               <= rx_statistics_valid_int;
     if (rx_statistics_valid_int & !rx_statistics_valid) begin
        rx_statistics_shift            <= {2'b01, rx_statistics_vector_int};
     end
     else begin
        rx_statistics_shift            <= {rx_statistics_shift[30:0], 1'b0};
     end
   end

   assign rx_statistics_vector         = rx_statistics_shift[31];


endmodule
