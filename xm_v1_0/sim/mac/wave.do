onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_user_clk_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_ready_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_data_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_user_clk_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_ready_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_data_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/link_up_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_user_rst_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_data_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_vldb_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_valid_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_ready_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_last_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_user_i
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_status_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/tx_rsp_valid_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_user_rst_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_data_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_vldb_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_valid_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_last_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/rx_user_o
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/r_tx_ready_d
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/r_tx_ready_d2
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/r_rx_ready_d
add wave -noupdate -group mac /tb_mac_loopback/u_teng_mac/r_rx_ready_d2
add wave -noupdate -group tb_top /tb_mac_loopback/s_user_clk
add wave -noupdate -group tb_top /tb_mac_loopback/s_user_ready
add wave -noupdate -group tb_top /tb_mac_loopback/s_pma_rx_data
add wave -noupdate -group tb_top /tb_mac_loopback/s_pma_tx_data
add wave -noupdate -group tb_top /tb_mac_loopback/s_link_up
add wave -noupdate -group tb_top /tb_mac_loopback/s_tx_status
add wave -noupdate -group tb_top /tb_mac_loopback/s_tx_rsp_valid
add wave -noupdate -group tb_top /tb_mac_loopback/s_tx_user_rst
add wave -noupdate -group tb_top /tb_mac_loopback/s_rx_user_rst
add wave -noupdate -group tb_top /tb_mac_loopback/r_global_rst
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/clk_i}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/rst_i}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/data_i}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/head_i}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/head_valid_i}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/slip_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/tdata_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/tvldb_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/tvalid_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/tlast_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/tuser_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/link_up_o}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_rx_lane_locked}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_data}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_head}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_rx_descrambled_data}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_rx_descrambled_head}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_rx_descrambled_data_rev}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_rx_descrambled_head_rev}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_rx_descrambled_valid}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_decode_data}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_decode_head}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_decode_data_vld}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_decode_error}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_xgmii_rxd_64}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_xgmii_rxc_64}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/s_xgmii_rxd_vld_64}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_xgmii_rxd_vld_64}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_xgmii_d_32}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_xgmii_c_32}
add wave -noupdate -group rx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/r_xgmii_v_32}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/clk_i}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/rst_i}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/good_frames_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/bad_frames_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/xgmii_d_i}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/xgmii_c_i}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/xgmii_v_i}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/tdata_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/tvldb_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/tvalid_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/tlast_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/tuser_o}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_xgmii_valid}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_state}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tdata_d1}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tvldb_d1}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tvalid_d1}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tlast_d1}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tuser_d1}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_first_byte_tchar}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tdata_d2}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tvldb_d2}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_tvalid_d2}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_d}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_c}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_d}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_c}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_crc_32}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_crc_32_3b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_crc_32_2b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_crc_32_1b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_crc_32_4b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_crc_32_3b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_crc_32_2b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/s_crc_32_1b}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_good_frames}
add wave -noupdate -group xgmii2axi32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_xgmii2axis32/r_bad_frames}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/clk_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/rst_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/xgmii_d_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/xgmii_c_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/sequence_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tdata_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tvldb_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tvalid_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tready_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tlast_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tuser_i}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tx_status_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/tx_rsp_valid_o}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_66count}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_66b64b_ready}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_start_ready}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_state}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_state_ready}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_ready}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_input_count}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_ipg_count}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_tdata_d1}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_tvldb_d1}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_tdata_d2}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_tvldb_d2}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_left}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_d}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_c}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_final}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_32_4b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_32_3b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_32_2b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/r_crc_32_1b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_crc_final}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_crc_32_4b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_crc_32_3b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_crc_32_2b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/s_crc_32_1b}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/xgmii_d}
add wave -noupdate -group axis2xgmii32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_axis2xgmii32/xgmii_c}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/clk_i}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/rst_i}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/data_i}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/head_i}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/sequence_i}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/data_o}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/head_o}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/sequence_o}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_data_in}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_head_in}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_sequence_in}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_sequence_in_d1}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_sequence_in_d2}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scramble_part}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scramble_register}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/s_data_in}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/s_head_in}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/s_scrambled_data}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_data_in_buf}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scrambled_data_d2}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scrambled_head_d2}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scrambled_data_vld_d1}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/r_scrambled_data_vld_d2}
add wave -noupdate -group scramble32 {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble_32/i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/clk_i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/rst_i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/xgmii_txd_i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/xgmii_txc_i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/xgmii_txd_vld_i}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/encode_error_o}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/encode_data_o}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/encode_head_o}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/encode_data_vld_o}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/r_encode_data_d1}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/r_encode_head_d1}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/r_encode_vld_d1}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/r_encode_error_d1}
add wave -noupdate -group encode_64b_66b {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_encode_64b_66b/r_debug}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/clk_i}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/rst_i}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/data_i}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/head_i}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/data_vld_i}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/data_o}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/head_o}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/data_vld_o}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/r_scramble_register}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/s_data_in}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/s_head_in}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/s_scrambled_data}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/r_data_in_buf}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/r_scrambled_data_d2}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/r_scrambled_data_vld_d1}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/r_scrambled_data_vld_d2}
add wave -noupdate -group scramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/u_scramble/i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/clk_i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/rst_i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/data_i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/head_i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/data_vld_i}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/data_o}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/head_o}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/data_vld_o}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/r_descramble_register}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/s_data_in}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/s_head_in}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/r_data_in_buf}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/s_descrambled_data}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/r_descrambled_data_d2}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/r_descrambled_data_vld_d1}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/r_descrambled_data_vld_d2}
add wave -noupdate -group descramble {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_rx/u_descramble/i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/clk_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/rst_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/data_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/head_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/sequence_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tdata_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tvldb_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tvalid_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tready_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tlast_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tuser_i}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tx_status_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/tx_rsp_valid_o}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_xgmii_d}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_xgmii_c}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_xgmii_d}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_xgmii_c}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_xgmii_txd_64}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_xgmii_txc_64}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_xgmii_txd_vld_64}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_encode_data}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_encode_head}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_encode_data_vld}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_encode_error}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_tx_scrambled_data}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_tx_scrambled_head}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_tx_scrambled_valid}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_scramble_in}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_sequence}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d1}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d2}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d3}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d4}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d5}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_sequence_d6}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_data}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/r_head}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_scramble_data}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_scramble_head}
add wave -noupdate -expand -group tx {/tb_mac_loopback/u_teng_mac/g_mac[0]/u_tx/s_scramble_seq}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161163 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 199
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
WaveRestoreZoom {129145 ps} {236989 ps}
