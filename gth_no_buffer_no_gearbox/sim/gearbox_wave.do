onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/clk_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/rst_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/data_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/head_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/sequence_i
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/data_o
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/s_sft_count
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/s_sft_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/s_align_head_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/s_align_data_in
add wave -noupdate -group gearbox_66b_64b /tb_gearbox_loopback/u_gearbox_66b_64b/r_storage
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/clk_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/rst_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/data_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/head_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/head_valid_o
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/slip_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/data_i
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_count
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_sft_count
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_sft_count2
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_sft_init
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_see_slip
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_slip
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/r_storage
add wave -noupdate -expand -group gearbox_64b_66b /tb_gearbox_loopback/u_gearbox_64b_66b/s_aligned_data_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1411329 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 203
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
WaveRestoreZoom {1376110 ps} {1495778 ps}
