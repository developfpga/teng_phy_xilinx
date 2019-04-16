
create_clock -period 6.400 -name gtx_ref_clk [get_ports ref_clk_p_i]
create_clock -period 10.000 -name sys_clk [get_ports sys_clk_i]
#create_clock -period "322.265625MHz"     [get_ports { ref_clk_p_i }]

derive_pll_clocks -create_base_clocks