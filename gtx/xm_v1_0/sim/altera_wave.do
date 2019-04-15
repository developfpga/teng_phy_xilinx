onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/stable_clk_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/stable_reset_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/xcvr_ref_clk_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/xcvr_ref_reset_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/xcvr_rx_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/xcvr_tx_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_tx_clk_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_tx_ready_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_tx_data_i
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_rx_clk_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_rx_ready_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pma_rx_data_o
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pll_powerdown
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_analogreset
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_digitalreset
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_pll_refclk
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_pma_clkout
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_serial_data
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_pma_parallel_data
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pll_locked
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_analogreset
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_digitalreset
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_cdr_refclk
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_pma_clkout
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_serial_data
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_pma_parallel_data
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_is_lockedtoref
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_is_lockedtodata
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_cal_busy
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_cal_busy
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_to_xcvr
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_from_xcvr
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/tx_ready
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/rx_ready
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/pll_select
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_busy
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_address
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_read
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_readdata
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_waitrequest
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_write
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/reconfig_mgmt_writedata
add wave -noupdate -group teng_phy /tb_prbs_loopback/u_prbs_test/u_xm_top/g_gt_on/u_teng_phy/s_xcvr_ref_clk
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_user_clk_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_fsm_reset_done_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_data_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_user_clk_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_fsm_reset_done_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_data_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/link_up_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_user_rst_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_data_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_vldb_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_valid_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_ready_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_last_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_user_i
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_status_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_rsp_valid_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_user_rst_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_data_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_vldb_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_valid_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_last_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/rx_user_o
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/r_tx_fsm_reset_done_d
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/r_tx_fsm_reset_done_d2
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/r_rx_fsm_reset_done_d
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/r_rx_fsm_reset_done_d2
add wave -noupdate -expand -group teng_mac /tb_prbs_loopback/u_prbs_test/u_xm_top/u_teng_mac/tx_user_clk_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55848242000 fs} 0} {{Cursor 2} {55918882000 fs} 1}
quietly wave cursor active 1
configure wave -namecolwidth 215
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
WaveRestoreZoom {55807936548 fs} {56017235824 fs}
