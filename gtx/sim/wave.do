onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/refclk_n_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/refclk_p_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthrxn_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthrxp_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthtxn_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthtxp_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_clk_freerun_in
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_all_in
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/link_status_out
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_clk_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_rst_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_vldb_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_valid_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_ready_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_last_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_status_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_rsp_valid_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_clk_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_rst_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_vldb_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_valid_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_last_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_o
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/soft_reset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/soft_reset_vio_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt_txfsmresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt_rxfsmresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt_txfsmresetdone_r
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt_txfsmresetdone_r2
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txfsmresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxfsmresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txfsmresetdone_r
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txfsmresetdone_r2
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxfsmresetdone_r
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxfsmresetdone_r2
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_r
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_r2
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_r3
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_vio_r
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_vio_r2
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_vio_r3
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/reset_counter
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/reset_pulse
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drpaddr_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drpdi_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drpdo_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drpen_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drprdy_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_drpwe_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_dmonitorout_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_eyescanreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxuserrdy_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_eyescandataerror_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_eyescantrigger_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdata_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtxrxp_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtxrxn_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdlysreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdlysresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxphaligndone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxphdlyreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxphmonitor_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxphslipmonitor_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdfelpmreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxmonitorout_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxmonitorsel_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxoutclk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxoutclkfabric_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtrxreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxpmareset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gttxreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txuserrdy_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdlyen_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdlysreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdlysresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphalign_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphaligndone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphalignen_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphdlyreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphinit_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txphinitdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdata_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtxtxn_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtxtxp_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txoutclk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txoutclkfabric_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txoutclkpcs_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txresetdone_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_gtrefclk1_common_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_qplllock_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_qpllrefclklost_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_qpllreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/DRPCLK_IN
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_tx_system_reset_c
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rx_system_reset_c
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tied_to_ground_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tied_to_ground_vec_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tied_to_vcc_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tied_to_vcc_vec_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/GTTXRESET_IN
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/GTRXRESET_IN
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/QPLLRESET_IN
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txusrclk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txusrclk2_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxusrclk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxusrclk2_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txmmcm_lock_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txmmcm_reset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/q2_clk1_refclk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_matchn_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txcharisk_float_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdata_float16_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txdata_float_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_block_sync_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_track_data_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_error_count_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_frame_check_reset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_inc_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_inc_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_unscrambled_data_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/reset_on_data_error_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/track_data_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxresetdone_vio_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_vio_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_vio_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/shared_vio_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ila_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/channel_drp_vio_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/common_drp_vio_control_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/shared_vio_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/shared_vio_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ila_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/channel_drp_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/channel_drp_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/channel_drp_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/channel_drp_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/common_drp_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/common_drp_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/common_drp_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/common_drp_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_tx_data_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_tx_data_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_tx_data_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_tx_data_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rx_data_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rx_data_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rx_data_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rx_data_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_ila_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_channel_drp_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_channel_drp_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_channel_drp_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_channel_drp_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_common_drp_vio_async_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_common_drp_vio_sync_in_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_common_drp_vio_async_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_common_drp_vio_sync_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gttxreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtrxreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/user_tx_reset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/user_rx_reset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_vio_clk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/tx_vio_clk_mux_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_vio_ila_clk_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rx_vio_ila_clk_mux_out_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/qpllreset_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/zero_vector_rx_80
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/zero_vector_rx_8
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdata_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxdatavalid_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxcharisk_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txmmcm_lock_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxmmcm_lock_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_rxresetdone_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gt0_txresetdone_ila
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/s_gt_rx_data
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/s_rx_data
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/s_rx_head
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/s_rx_head_valid
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxgearboxslip_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txdata_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txheader_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txsequence_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxdatavalid_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxdata_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxheader_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxheadervalid_int
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/clk_i
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/rst_i
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/data_i
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/head_i
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/head_valid_i
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/slip_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/tdata_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/tvldb_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/tvalid_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/tlast_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/tuser_o
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_lane_locked
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_data
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_head
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_data
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_head
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_data_rev
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_head_rev
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_rx_descrambled_valid
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_decode_data
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_decode_head
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_decode_data_vld
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_decode_error
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_xgmii_rxd_64
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_xgmii_rxc_64
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_xgmii_rxd_vld_64
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_xgmii_rxd_vld_64
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_xgmii_d_32
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_xgmii_c_32
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/r_xgmii_v_32
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84764211 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {87001776 ps}
