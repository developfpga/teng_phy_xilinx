
########## LED CONSTRAINTS FOR the MIZ7035 BOARD ##########
#LD4
set_property PACKAGE_PIN B9 [get_ports {led1_o}]
##LD3
set_property PACKAGE_PIN K10 [get_ports {led2_o}]
##LD2
#set_property PACKAGE_PIN H11 [get_ports {led[2]}]
##LD1
#set_property PACKAGE_PIN G9 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led*}]

set_property PACKAGE_PIN T4 [get_ports gthrxp_i[0]]
set_property PACKAGE_PIN V4 [get_ports gthrxp_i[1]]



########## GTX CONSTRAINTS FOR the MIZ7035 BOARD ##########
set_property PACKAGE_PIN R5 [get_ports refclk_n_i]
set_property PACKAGE_PIN R6 [get_ports refclk_p_i]
create_clock -period 6.400 -name gtx_ref_clk [get_ports refclk_p_i]

########## --------- SFP ------------##########
set_property PACKAGE_PIN G10 [get_ports tx_disable_o[0]]
set_property PACKAGE_PIN D10 [get_ports {tx_disable_o[1]}]
#set_property PACKAGE_PIN A14 [get_ports {tx_disable_o[2]}]
#set_property PACKAGE_PIN D13 [get_ports {tx_disable_o[3]}]

set_property IOSTANDARD LVCMOS18 [get_ports tx_disable_o[*]]
