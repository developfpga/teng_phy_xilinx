# PART is kintexu xcku035fbva676-2


#######################################################
# Clock/period constraints                            #
#######################################################
# Main transmit clock/period constraints

create_clock -period 5.000 [get_ports clk_in_p]
set_input_jitter clk_in_p 0.050
create_clock -period 6.400 [get_ports refclk_p]

#######################################################
# Synchronizer False paths
#######################################################
set_false_path -to [get_pins -hierarchical -filter {NAME =~ resetdone_out_reg_reg/D}]
set_false_path -to [get_pins -hierarchical -filter {NAME =~ resetdone_out_count_reg[*]/CE}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ pattern_generator*sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ reset_error_sync_reg*sync1_r_reg[0]}]
set_false_path -to [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *shared_clock_reset_block*sync1_r_reg[*]}] -filter {NAME =~ *PRE}]

#######################################################
# FIFO level constraints
#######################################################

set_false_path -from [get_cells fifo_block_i/ethernet_mac_fifo_i/*/wr_store_frame_tog_reg] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
set_max_delay 6.4000 -datapath_only  -from [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/rd_addr_gray_reg_reg[*]}] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
set_false_path -to [get_pins -filter {NAME =~ */PRE} -of_objects [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/*/reset_async*_reg}]]

#######################################################
# I/O constraints                                     #
#######################################################

# These inputs can be connected to dip switches or push buttons on an
# appropriate board.

set_false_path -from [get_ports reset]
set_false_path -from [get_ports reset_error]
set_false_path -from [get_ports insert_error]
set_false_path -from [get_ports pcs_loopback]
set_false_path -from [get_ports enable_pat_gen]
set_false_path -from [get_ports enable_pat_check]
set_false_path -from [get_ports enable_custom_preamble]
set_case_analysis 0  [get_ports sim_speedup_control]

# These outputs can be connected to LED's or headers on an
# appropriate board.

set_false_path -to [get_ports core_ready]
set_false_path -to [get_ports coreclk_out]
set_false_path -to [get_ports qplllock_out]
set_false_path -to [get_ports frame_error]
set_false_path -to [get_ports gen_active_flash]
set_false_path -to [get_ports check_active_flash]
set_false_path -to [get_ports serialized_stats]


#######################################################
# Transcevier Refclk placement constraints            #
#######################################################

# GTHE3_CHANNEL_X0Y0 was selected for use from the customization GUI.  This transcevier is located in the GT Quad GTHE3_COMMON_X0Y0

# The following reference clock source to the GTHE3_COMMON_X0Y0 is as selected from the IP customization GUI.
set_property LOC GTHE3_COMMON_X0Y0  [get_cells -hier -filter {NAME=~  *shared_clocking_wrapper*ibufds_inst}]
