onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/clk_i
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/rst_i
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_i
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/head_i
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/sequence_i
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_o
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_sft_count
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_sft_data_in
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_align_head_data_in
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_align_data_in
add wave -noupdate -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/r_storage
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/clk_i
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/rst_i
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/data_o
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/head_o
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/head_valid_o
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/slip_i
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_o
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/data_i
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_count
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_count
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_count2
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_init
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_see_slip
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_slip
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_storage
add wave -noupdate -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/s_aligned_data_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gthrxn_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gthrxp_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gthtxn_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gthtxp_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_reset_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_srcclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_usrclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_usrclk2_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_active_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_rx_reset_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_rx_srcclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_rx_usrclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_rx_usrclk2_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_rx_active_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_tx_reset_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_tx_start_user_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_tx_done_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_tx_error_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_rx_reset_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_rx_start_user_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_rx_done_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_rx_error_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_clk_freerun_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_all_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_tx_pll_and_datapath_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_tx_datapath_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rx_pll_and_datapath_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rx_datapath_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rx_cdr_stable_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_tx_done_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rx_done_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userdata_tx_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userdata_rx_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtrefclk00_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0outclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0outrefclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1outclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1outrefclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtpowergood_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxpmaresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txpmaresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txprgdivresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txusrclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txusrclk2_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txoutclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxusrclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxusrclk2_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxoutclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphaligndone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphinitdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlysresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsyncout_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsyncdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphdlyreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphalign_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphalignen_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphdlypd_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphinit_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphovrden_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlysreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlybypass_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlyen_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlyovrden_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txphdlytstclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlyhold_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdlyupdown_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsyncmode_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsyncallin_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsyncin_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_tx_resetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphaligndone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdlysresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxsyncout_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxsyncdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphdlyreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphalign_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphalignen_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphdlypd_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxphovrden_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdlysreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdlybypass_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdlyen_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdlyovrden_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxsyncmode_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxsyncallin_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxsyncin_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_buffbypass_rx_resetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_userclk_tx_active_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_userclk_rx_active_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_plllock_tx_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_plllock_rx_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0lock_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtpowergood_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxcdrlock_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_gtpowergood_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rxcdrlock_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_txresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rxresetdone_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txresetdone_sync
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxresetdone_sync
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_pllreset_tx_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_txprogdivreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_gttxreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_txuserrdy_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_pllreset_rx_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rxprogdivreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_gtrxreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_reset_rxuserrdy_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0reset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txprogdivreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gttxreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txuserrdy_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxprogdivreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtrxreset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxuserrdy_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txdata_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdata_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtrefclk00_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0clk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0refclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtrefclk01_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1clk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1refclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1reset_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll1lock_int
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/refclk_p_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/refclk_n_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/gthrxn_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/gthrxp_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/gthtxn_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/gthtxp_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_clk_freerun_in
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_all_in
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/link_status_out
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_clk_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_rst_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_data_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_vldb_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_valid_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_ready_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_last_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_user_i
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_status_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/tx_rsp_valid_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_clk_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_rst_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_data_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_vldb_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_valid_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_last_o
add wave -noupdate -group pcs_top /tb_single_loopback/u_pcs_top/rx_user_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/clk_i
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/rst_i
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/good_frames_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/bad_frames_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_d_i
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_c_i
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_v_i
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tdata_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tvldb_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tvalid_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tlast_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tuser_o
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_xgmii_valid
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_state
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d1
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d1
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d1
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tlast_d1
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tuser_d1
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d2
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d2
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d2
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_d
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_c
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_d
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_c
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_3b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_2b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_1b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_4b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_3b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_2b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_1b
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_good_frames
add wave -noupdate -expand -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_bad_frames
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15916440 ps} 0} {{Cursor 2} {50049972 ps} 1}
quietly wave cursor active 2
configure wave -namecolwidth 237
configure wave -valuecolwidth 129
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
WaveRestoreZoom {49925571 ps} {50180780 ps}
