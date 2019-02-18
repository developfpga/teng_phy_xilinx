onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb_system_across /tb_system_across/ch0_gthtxn
add wave -noupdate -group tb_system_across /tb_system_across/ch0_gthtxp
add wave -noupdate -group tb_system_across /tb_system_across/ch0_gthrxn
add wave -noupdate -group tb_system_across /tb_system_across/ch0_gthrxp
add wave -noupdate -group tb_system_across /tb_system_across/mgtrefclk0_x0y0
add wave -noupdate -group tb_system_across /tb_system_across/hb_gtwiz_reset_clk_freerun
add wave -noupdate -group tb_system_across /tb_system_across/hb_gtwiz_reset_all
add wave -noupdate -group tb_system_across /tb_system_across/tx_user_clk
add wave -noupdate -group tb_system_across /tb_system_across/tx_user_rst
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_data
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_vldb
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_valid
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_ready
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_last
add wave -noupdate -group tb_system_across /tb_system_across/s_tx_user
add wave -noupdate -group tb_system_across /tb_system_across/rx_user_clk
add wave -noupdate -group tb_system_across /tb_system_across/rx_user_rst
add wave -noupdate -group tb_system_across /tb_system_across/s_rx_data
add wave -noupdate -group tb_system_across /tb_system_across/s_rx_vldb
add wave -noupdate -group tb_system_across /tb_system_across/s_rx_valid
add wave -noupdate -group tb_system_across /tb_system_across/s_rx_last
add wave -noupdate -group tb_system_across /tb_system_across/s_rx_user
add wave -noupdate -group tb_system_across /tb_system_across/coreclk_out
add wave -noupdate -group tb_system_across /tb_system_across/core_ready
add wave -noupdate -group tb_system_across /tb_system_across/xilinx_txn
add wave -noupdate -group tb_system_across /tb_system_across/xilinx_txp
add wave -noupdate -group tb_system_across /tb_system_across/xilinx_rxn
add wave -noupdate -group tb_system_across /tb_system_across/xilinx_rxp
add wave -noupdate -group tb_system_across /tb_system_across/tx_axis_tdata
add wave -noupdate -group tb_system_across /tb_system_across/tx_axis_tkeep
add wave -noupdate -group tb_system_across /tb_system_across/tx_axis_tvalid
add wave -noupdate -group tb_system_across /tb_system_across/tx_axis_tlast
add wave -noupdate -group tb_system_across /tb_system_across/tx_axis_tready
add wave -noupdate -group tb_system_across /tb_system_across/rx_axis_tdata
add wave -noupdate -group tb_system_across /tb_system_across/rx_axis_tkeep
add wave -noupdate -group tb_system_across /tb_system_across/rx_axis_tvalid
add wave -noupdate -group tb_system_across /tb_system_across/rx_axis_tlast
add wave -noupdate -group tb_system_across /tb_system_across/rx_axis_tready
add wave -noupdate -group dut /tb_system_across/u_pcs_top/refclk_p_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/refclk_n_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthrxn_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthrxp_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthtxn_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthtxp_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_clk_freerun_in
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_all_in
add wave -noupdate -group dut /tb_system_across/u_pcs_top/link_status_out
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_user_clk_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_user_rst_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_data_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_vldb_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_valid_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_ready_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_last_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_user_i
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_status_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/tx_rsp_valid_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_user_clk_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_user_rst_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_data_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_vldb_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_valid_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_last_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rx_user_o
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthrxn_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthrxp_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthtxn_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gthtxp_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_tx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_tx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_tx_srcclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_tx_srcclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_tx_usrclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_tx_usrclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_rx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_rx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_rx_srcclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_rx_srcclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_rx_usrclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_userclk_rx_usrclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_tx_start_user_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_buffbypass_tx_start_user_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_tx_error_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_buffbypass_tx_error_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_rx_start_user_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_buffbypass_rx_start_user_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_rx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_buffbypass_rx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_rx_error_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_buffbypass_rx_error_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_clk_freerun_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_clk_freerun_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_all_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_all_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_tx_pll_and_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_tx_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_rx_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_rx_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_rx_cdr_stable_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_rx_cdr_stable_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_tx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_tx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_reset_rx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb0_gtwiz_reset_rx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userdata_tx_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userdata_rx_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtrefclk00_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/cm0_gtrefclk00_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/qpll0outclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/cm0_qpll0outclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/qpll0outrefclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/cm0_qpll0outrefclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxgearboxslip_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/txheader_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/txsequence_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtpowergood_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/ch0_gtpowergood_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxdatavalid_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxheader_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxheadervalid_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxpmaresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/ch0_rxpmaresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/rxstartofseq_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/ch0_rxstartofseq_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/txpmaresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/ch0_txpmaresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/txprgdivresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/ch0_txprgdivresetdone_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_all_buf_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_all_init_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_all_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_clk_freerun_buf_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/refclk_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_tx_usrclk2_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_tx_active_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_tx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_rx_usrclk2_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_userclk_rx_active_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_tx_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/gtwiz_buffbypass_rx_reset_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/r_rxheadervalid_d1
add wave -noupdate -group dut /tb_system_across/u_pcs_top/r_rx_valid_mismatch
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_rx_datapath_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/init_done_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/init_retry_ctr_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/hb_gtwiz_reset_rx_datapath_init_int
add wave -noupdate -group dut /tb_system_across/u_pcs_top/sm_link
add wave -noupdate -group xilinx /tb_system_across/xilinx/clk_in_p
add wave -noupdate -group xilinx /tb_system_across/xilinx/clk_in_n
add wave -noupdate -group xilinx /tb_system_across/xilinx/refclk_p
add wave -noupdate -group xilinx /tb_system_across/xilinx/refclk_n
add wave -noupdate -group xilinx /tb_system_across/xilinx/coreclk_out
add wave -noupdate -group xilinx /tb_system_across/xilinx/pcs_loopback
add wave -noupdate -group xilinx /tb_system_across/xilinx/reset
add wave -noupdate -group xilinx /tb_system_across/xilinx/serialized_stats
add wave -noupdate -group xilinx /tb_system_across/xilinx/sim_speedup_control
add wave -noupdate -group xilinx /tb_system_across/xilinx/enable_custom_preamble
add wave -noupdate -group xilinx /tb_system_across/xilinx/core_ready
add wave -noupdate -group xilinx /tb_system_across/xilinx/qplllock_out
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_tdata
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_tkeep
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_tvalid
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_tlast
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_tready
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_tdata
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_tkeep
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_tvalid
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_tlast
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_tready
add wave -noupdate -group xilinx /tb_system_across/xilinx/txp
add wave -noupdate -group xilinx /tb_system_across/xilinx/txn
add wave -noupdate -group xilinx /tb_system_across/xilinx/rxp
add wave -noupdate -group xilinx /tb_system_across/xilinx/rxn
add wave -noupdate -group xilinx /tb_system_across/xilinx/enable_vlan
add wave -noupdate -group xilinx /tb_system_across/xilinx/coreclk
add wave -noupdate -group xilinx /tb_system_across/xilinx/block_lock
add wave -noupdate -group xilinx /tb_system_across/xilinx/rxrecclk
add wave -noupdate -group xilinx /tb_system_across/xilinx/s_axi_aclk
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_dcm_locked
add wave -noupdate -group xilinx /tb_system_across/xilinx/no_remote_and_local_faults
add wave -noupdate -group xilinx /tb_system_across/xilinx/mac_tx_configuration_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/mac_rx_configuration_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/mac_status_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/pcs_pma_configuration_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/pcs_pma_status_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_statistics_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_statistics_vector
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_statistics_vector_int
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_statistics_valid_int
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_statistics_valid
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_statistics_shift
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_statistics_vector_int
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_statistics_valid_int
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_statistics_valid
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_statistics_shift
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_reset
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_reset
add wave -noupdate -group xilinx /tb_system_across/xilinx/tx_axis_aresetn
add wave -noupdate -group xilinx /tb_system_across/xilinx/rx_axis_aresetn
add wave -noupdate -group xilinx /tb_system_across/xilinx/resetdone_out
add wave -noupdate -group xilinx /tb_system_across/xilinx/resetdone_out_rising_edge
add wave -noupdate -group xilinx /tb_system_across/xilinx/resetdone_out_reg
add wave -noupdate -group xilinx /tb_system_across/xilinx/resetdone_out_count
add wave -noupdate -group xilinx /tb_system_across/xilinx/pcspma_status
add wave -noupdate -group xilinx /tb_system_across/xilinx/pcs_loopback_sync
add wave -noupdate -group xilinx /tb_system_across/xilinx/enable_custom_preamble_coreclk_sync
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/clk_i
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/rst_i
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/data_i
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/head_i
add wave -noupdate -group dut_rx -expand /tb_system_across/u_pcs_top/u_rx/head_valid_i
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/slip_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/tdata_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/tvldb_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/tvalid_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/tlast_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/tuser_o
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_rx_lane_locked
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_data
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_head
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_rx_descrambled_data
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_rx_descrambled_head
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_rx_descrambled_valid
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_decode_data
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_decode_head
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_decode_data_vld
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_decode_error
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_xgmii_rxd_64
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_xgmii_rxc_64
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/s_xgmii_rxd_vld_64
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_xgmii_rxd_vld_64
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_xgmii_d_32
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_xgmii_c_32
add wave -noupdate -group dut_rx /tb_system_across/u_pcs_top/u_rx/r_xgmii_v_32
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/clk_i
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/rst_i
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/gtwiz_userdata_rx_i
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/rxheader_i
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/rxheadervalid_i
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/rxgearboxslip_o
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/locked
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/r_aligned_count
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/r_rxgearboxslip
add wave -noupdate -group dut_rx_alignment /tb_system_across/u_pcs_top/u_rx/u_rx_alignment/r_sleep
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_userclk_tx_active_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_userclk_rx_active_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_clk_freerun_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_all_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_tx_pll_and_datapath_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_tx_datapath_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_rx_pll_and_datapath_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_rx_datapath_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_qpll0lock_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_rx_cdr_stable_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_tx_done_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_rx_done_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtwiz_reset_qpll0reset_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/cpllpd_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpaddr_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpdi_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpen_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpwe_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/eyescanreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/eyescantrigger_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gthrxn_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gthrxp_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/loopback_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/pcsrsvdin_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/qpll0clk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/qpll0refclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/qpll1clk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/qpll1refclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxbufreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxcdrhold_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxdfelpmreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxgearboxslip_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxlatclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxlpmen_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxpcsreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxpd_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxpmareset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxpolarity_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxprbscntreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxprbssel_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxrate_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxusrclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxusrclk2_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txdata_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txdiffctrl_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txelecidle_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txheader_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txinhibit_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txlatclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txoutclksel_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpcsreset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpd_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpdelecidlemode_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpmareset_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpolarity_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpostcursor_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txprbsforceerr_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txprbssel_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txprecursor_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txsequence_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txusrclk_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txusrclk2_in
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/dmonitorout_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drpdo_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/drprdy_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/eyescandataerror_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gthtxn_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gthtxp_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/gtpowergood_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxbufstatus_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxcdrlock_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxdata_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxdatavalid_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxheader_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxheadervalid_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxoutclk_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxpmaresetdone_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxprbserr_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxprbslocked_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxprgdivresetdone_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/rxstartofseq_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txbufstatus_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txoutclk_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txpmaresetdone_out
add wave -noupdate -expand -group xilinx_pcs /tb_system_across/xilinx/fifo_block_i/support_layer_i/ethernet_core_i/inst/xpcs/inst/bd_efdb_0_xpcs_0_gt_i/txprgdivresetdone_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50321656 ps} 0} {{Cursor 2} {50318456 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 251
configure wave -valuecolwidth 139
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
WaveRestoreZoom {50294928 ps} {50364225 ps}
