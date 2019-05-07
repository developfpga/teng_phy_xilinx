
create_clock -period 6.400 -name gtx_ref_clk [get_ports ref_clk_p_i]
create_clock -period 10.000 -name sys_clk [get_ports sys_clk_i]
#create_clock -period "322.265625MHz"     [get_ports { ref_clk_p_i }]

derive_pll_clocks -create_base_clocks
#
#set_false_path to *u_xm_top.u_teng_mac.r_tx_ready_d*
#set_false_path to *u_xm_top.u_teng_mac.r_rx_ready_d*

set_false_path -to [get_registers {*r_tx_ready_d*}]
set_false_path -to [get_registers {*r_rx_ready_d*}]