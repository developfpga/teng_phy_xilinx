onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/clk_i
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/rst_i
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_i
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/head_i
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/sequence_i
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_o
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_sft_count
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_sft_data_in
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_align_head_data_in
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/s_align_data_in
add wave -noupdate -expand -group gearbox_66b_64b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/r_storage
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/clk_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/rst_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/data_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/head_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/head_valid_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/slip_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_66_64/data_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/data_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_count
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_count
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_count2
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_sft_init
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_see_slip
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_slip
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/r_storage
add wave -noupdate -expand -group gearbox_64b_66b /tb_single_loopback/u_pcs_top/u_gearbox_64_66/s_aligned_data_in
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15916440 ps} 1} {{Cursor 2} {15920660 ps} 0}
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
WaveRestoreZoom {15888424 ps} {15935641 ps}
