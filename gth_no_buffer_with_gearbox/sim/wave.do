onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb_top /tb_single_loopback/ch0_gthxn
add wave -noupdate -group tb_top /tb_single_loopback/ch0_gthxp
add wave -noupdate -group tb_top /tb_single_loopback/mgtrefclk0_x0y0
add wave -noupdate -group tb_top /tb_single_loopback/hb_gtwiz_reset_clk_freerun
add wave -noupdate -group tb_top /tb_single_loopback/hb_gtwiz_reset_all
add wave -noupdate -group tb_top /tb_single_loopback/tx_user_clk
add wave -noupdate -group tb_top /tb_single_loopback/tx_user_rst
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_data
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_vldb
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_valid
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_ready
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_last
add wave -noupdate -group tb_top /tb_single_loopback/s_tx_user
add wave -noupdate -group tb_top /tb_single_loopback/rx_user_clk
add wave -noupdate -group tb_top /tb_single_loopback/rx_user_rst
add wave -noupdate -group tb_top /tb_single_loopback/s_rx_data
add wave -noupdate -group tb_top /tb_single_loopback/s_rx_vldb
add wave -noupdate -group tb_top /tb_single_loopback/s_rx_valid
add wave -noupdate -group tb_top /tb_single_loopback/s_rx_last
add wave -noupdate -group tb_top /tb_single_loopback/s_rx_user
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/refclk_p_i
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/refclk_n_i
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
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthrxn_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthrxp_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthtxn_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gthtxp_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_tx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_tx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_tx_srcclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_tx_srcclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_tx_usrclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_tx_usrclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_rx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_rx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_rx_srcclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_rx_srcclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_rx_usrclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_userclk_rx_usrclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_tx_start_user_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_buffbypass_tx_start_user_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_tx_error_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_buffbypass_tx_error_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_rx_start_user_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_buffbypass_rx_start_user_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_rx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_buffbypass_rx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_rx_error_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_buffbypass_rx_error_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_clk_freerun_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_clk_freerun_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_all_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_all_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_tx_pll_and_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_tx_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_rx_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_rx_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_rx_cdr_stable_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_rx_cdr_stable_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_tx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_tx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_reset_rx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb0_gtwiz_reset_rx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userdata_tx_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userdata_rx_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtrefclk00_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/cm0_gtrefclk00_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/qpll0outclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/cm0_qpll0outclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/qpll0outrefclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/cm0_qpll0outrefclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxgearboxslip_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txheader_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txsequence_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtpowergood_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ch0_gtpowergood_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxdatavalid_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxheader_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxheadervalid_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxpmaresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ch0_rxpmaresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/rxstartofseq_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ch0_rxstartofseq_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txpmaresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ch0_txpmaresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/txprgdivresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/ch0_txprgdivresetdone_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_all_buf_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_all_init_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_all_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_clk_freerun_buf_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/refclk_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_tx_usrclk2_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_tx_active_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_tx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_rx_usrclk2_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_userclk_rx_active_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_tx_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/gtwiz_buffbypass_rx_reset_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/r_rxheadervalid_d1
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/r_rx_valid_mismatch
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_rx_pll_and_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_rx_datapath_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/init_done_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/init_retry_ctr_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/hb_gtwiz_reset_rx_datapath_init_int
add wave -noupdate -expand -group pcs_top /tb_single_loopback/u_pcs_top/sm_link
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/clk_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/rst_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/data_o
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/head_o
add wave -noupdate -group tx -radix decimal /tb_single_loopback/u_pcs_top/u_tx/sequence_o
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tdata_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tvldb_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tvalid_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tready_o
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tlast_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tuser_i
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tx_status_o
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/tx_rsp_valid_o
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_xgmii_d
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_xgmii_c
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/r_xgmii_d
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/r_xgmii_c
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_xgmii_txd_64
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_xgmii_txc_64
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_xgmii_txd_vld_64
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_encode_data
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_encode_head
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_encode_data_vld
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_encode_error
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_tx_scrambled_data
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_tx_scrambled_head
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/s_tx_scrambled_valid
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/s_sequence
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/r_sequence_d1
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/r_sequence_d2
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/r_sequence_d3
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/r_sequence_d4
add wave -noupdate -group tx -radix unsigned /tb_single_loopback/u_pcs_top/u_tx/r_sequence_d5
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/r_data
add wave -noupdate -group tx /tb_single_loopback/u_pcs_top/u_tx/r_head
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
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userdata_rx_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtrefclk00_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0outclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/qpll0outrefclk_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxgearboxslip_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userdata_tx_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txheader_in
add wave -noupdate -group example_wrapper -radix decimal /tb_single_loopback/u_pcs_top/example_wrapper_inst/txsequence_in
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtwiz_userclk_tx_usrclk2_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtpowergood_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxdatavalid_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxheader_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxheadervalid_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxpmaresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxstartofseq_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txpmaresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txprgdivresetdone_out
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txusrclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txusrclk2_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/txoutclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxusrclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxusrclk2_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/rxoutclk_int
add wave -noupdate -group example_wrapper /tb_single_loopback/u_pcs_top/example_wrapper_inst/gtpowergood_int
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
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_data
add wave -noupdate -group rx /tb_single_loopback/u_pcs_top/u_rx/s_rx_descrambled_head
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
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/clk_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/rst_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_d_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_c_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/sequence_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tdata_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tvldb_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tvalid_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tready_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tlast_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tuser_i
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tx_status_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/tx_rsp_valid_o
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_66count
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_66b64b_ready
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_state
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_state_ready
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_ready
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_input_count
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_ipg_count
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_tdata_d1
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_tvldb_d1
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_tdata_d2
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_tvldb_d2
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_left
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_d
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_c
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_final
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_4b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_3b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_2b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_1b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_final
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_4b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_3b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_2b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_1b
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_d
add wave -noupdate -group axis2xgmii32 /tb_single_loopback/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_c
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/clk_i
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/rst_i
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/good_frames_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/bad_frames_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_d_i
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_c_i
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_v_i
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tdata_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tvldb_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tvalid_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tlast_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/tuser_o
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_xgmii_valid
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_state
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d1
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d1
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d1
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tlast_d1
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tuser_d1
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d2
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d2
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d2
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_d
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/s_c
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_d
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_c
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_3b
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_2b
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_1b
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_good_frames
add wave -noupdate -group xgmii2axis32 /tb_single_loopback/u_pcs_top/u_rx/u_xgmii2axis32/r_bad_frames
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50087078 ps} 1} {{Cursor 2} {50000348 ps} 1} {{Cursor 3} {50068410 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 202
configure wave -valuecolwidth 130
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
WaveRestoreZoom {49989155 ps} {50154030 ps}
