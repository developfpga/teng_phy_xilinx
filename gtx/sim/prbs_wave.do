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
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_clk_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_rst_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_data_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_vldb_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_valid_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_last_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/rx_user_i
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_count
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/s_rx_prbs_check
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err1_cnt
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err2_cnt
add wave -noupdate -expand -group prbs_check /tb_prbs_loopback/u_prbs_test/u_prbs_check/r_err3_cnt
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_clk_i
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_rst_i
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_data_o
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_vldb_o
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_valid_o
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_ready_i
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_last_o
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/tx_user_o
add wave -noupdate -expand -group prbs_gen /tb_prbs_loopback/u_prbs_test/u_prbs_gen/r_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95929203 ps} 0} {{Cursor 2} {95828166 ps} 1}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {95818031 ps} {96089639 ps}
