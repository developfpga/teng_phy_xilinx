onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/clk
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/rst
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_data_out
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_head
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_head_valid
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_head_valid_d1
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_slip
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_64_66_data_in
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_66_64_data_in
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_66_64_head
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_66_64_sequence
add wave -noupdate -group tb_prbs /tb_gearbox_prbs/l_66_64_data_out
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/clk_i
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/rst_i
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/data_o
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/head_o
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/head_valid_o
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/slip_i
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/data_i
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_count
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_sft_count
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_sft_count2
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_sft_init
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_see_slip
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_slip
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/r_storage
add wave -noupdate -group gearbox_64b_66b /tb_gearbox_prbs/u_gearbox_64b_66b/s_aligned_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/clk_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/rst_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/data_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/head_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/sequence_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/data_o
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/s_sft_count
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/s_sft_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/s_align_head_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/s_align_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_prbs/u_gearbox_66b_64b/r_storage
add wave -noupdate -group check /tb_gearbox_prbs/u_check/gtwiz_reset_all_in
add wave -noupdate -group check /tb_gearbox_prbs/u_check/gtwiz_userclk_rx_usrclk2_in
add wave -noupdate -group check /tb_gearbox_prbs/u_check/gtwiz_userclk_rx_active_in
add wave -noupdate -group check -expand /tb_gearbox_prbs/u_check/rxdatavalid_in
add wave -noupdate -group check /tb_gearbox_prbs/u_check/rxgearboxslip_out
add wave -noupdate -group check /tb_gearbox_prbs/u_check/rxdata_in
add wave -noupdate -group check /tb_gearbox_prbs/u_check/prbs_match_out
add wave -noupdate -group check /tb_gearbox_prbs/u_check/example_checking_reset_int
add wave -noupdate -group check /tb_gearbox_prbs/u_check/example_checking_reset_sync
add wave -noupdate -group check /tb_gearbox_prbs/u_check/rxdata_int
add wave -noupdate -group check /tb_gearbox_prbs/u_check/prbs_any_chk_en_int
add wave -noupdate -group check /tb_gearbox_prbs/u_check/rxgearboxslip_ctr_int
add wave -noupdate -group check /tb_gearbox_prbs/u_check/prbs_any_chk_error_int
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/gtwiz_reset_all_in
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/gtwiz_userclk_tx_usrclk2_in
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/gtwiz_userclk_tx_active_in
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/txheader_out
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/txsequence_out
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/txdata_out
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/example_stimulus_reset_int
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/example_stimulus_reset_sync
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/txdata_int
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/txsequence_ctr_en_int
add wave -noupdate -group stimu /tb_gearbox_prbs/u_stimu/prbs_any_gen_en_int
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {179892857 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ps} {309387750 ps}
