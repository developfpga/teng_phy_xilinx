onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/refclk_n_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/refclk_p_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/debug_o
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/gthrxn_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/gthrxp_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/gthtxn_o
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/gthtxp_o
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/free_clk_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/rst_i
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/link_status_out
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_user_clk
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_user_rst
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_data
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_vldb
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_valid
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_ready
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_last
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_user
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_status
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_tx_rsp_valid
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_user_clk
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_user_rst
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_data
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_vldb
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_valid
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_last
add wave -noupdate -group prbs_test /tb_prbs_loopback/u_prbs_test/s_rx_user
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_clk_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_rst_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_data_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_vldb_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_valid_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_last_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_i
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_count
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/s_rx_prbs_check
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err1_cnt
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err2_cnt
add wave -noupdate -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err3_cnt
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_clk_i
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_rst_i
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_data_o
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_vldb_o
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_valid_o
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_ready_i
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_last_o
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_o
add wave -noupdate -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/r_count
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/clk_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/rst_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_d_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_c_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/sequence_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tdata_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tvldb_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tvalid_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tready_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tlast_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tuser_i
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tx_status_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/tx_rsp_valid_o
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_66count
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_66b64b_ready
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_state
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_state_ready
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_ready
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_input_count
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_ipg_count
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_tdata_d1
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_tvldb_d1
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_tdata_d2
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_tvldb_d2
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_left
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_d
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_c
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_sequence
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_sequence_d1
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_sequence_d2
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_sequence_d3
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_final
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_4b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_3b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_2b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/r_crc_32_1b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_final
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_4b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_3b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_2b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/s_crc_32_1b
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_d
add wave -noupdate -group axi2xgmii32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_tx/u_axis2xgmii32/xgmii_c
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/clk_i
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/rst_i
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/good_frames_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/bad_frames_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_d_i
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_c_i
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/xgmii_v_i
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/tdata_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/tvldb_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/tvalid_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/tlast_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/tuser_o
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_xgmii_valid
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_state
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d1
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d1
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d1
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tlast_d1
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tuser_d1
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_first_byte_tchar
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tdata_d2
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tvldb_d2
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_tvalid_d2
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_d
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_c
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_d
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_c
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_3b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_2b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_crc_32_1b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_4b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_3b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_2b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/s_crc_32_1b
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_good_frames
add wave -noupdate -group xgmii2axi32 /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_xgmii2axis32/r_bad_frames
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/clk_i
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/rst_i
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/data_i
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/head_i
add wave -noupdate -expand -group rx -expand /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/head_valid_i
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/slip_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/tdata_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/tvldb_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/tvalid_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/tlast_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/tuser_o
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_rx_lane_locked
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_data
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_head
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_rx_descrambled_data
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_rx_descrambled_head
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_rx_descrambled_data_rev
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_rx_descrambled_head_rev
add wave -noupdate -expand -group rx {/tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/head_valid_i[0]}
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_rx_descrambled_valid
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_decode_data
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_decode_head
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_decode_data_vld
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_decode_error
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_xgmii_rxd_64
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_xgmii_rxc_64
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/s_xgmii_rxd_vld_64
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_xgmii_rxd_vld_64
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_xgmii_d_32
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_xgmii_c_32
add wave -noupdate -expand -group rx /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/r_xgmii_v_32
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/clk_i
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/rst_i
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/data_i
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/head_i
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/data_vld_i
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/data_o
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/head_o
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/data_vld_o
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/r_descramble_register
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/s_data_in
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/s_head_in
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/r_data_in_buf
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/s_descrambled_data
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/r_descrambled_data_d2
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/r_descrambled_data_vld_d1
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/r_descrambled_data_vld_d2
add wave -noupdate -group descramble /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_descramble/i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/clk_i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/rst_i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/decode_data_i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/decode_head_i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/decode_data_vld_i
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/xgmii_rxd_o
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/xgmii_rxc_o
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/xgmii_rxd_vld_o
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/decode_error_o
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/r_rxd_d1
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/r_rxc_d1
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/r_rxd_vld_d1
add wave -noupdate -expand -group decode_64b_66b /tb_prbs_loopback/u_prbs_test/u_pcs_top/u_rx/u_decode_64b_66b/r_decode_error_d1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22640478 ps} 0} {{Cursor 2} {95828166 ps} 1}
quietly wave cursor active 1
configure wave -namecolwidth 224
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
WaveRestoreZoom {22612266 ps} {22638002 ps}
