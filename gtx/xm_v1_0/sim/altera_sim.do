######################################################################
#
# File name : sim.do
# Created on: 2019-04-11
#
######################################################################
vlib work
vmap work work

vlog -work work ../rtl/altera_phy/ip//nphy/nphy.v
vlog -work work ../rtl/altera_phy/ip/xcvr_reset/xcvr_reset.v
vlog -work work ../rtl/altera_phy/ip/xcvr_reconfig/xcvr_reconfig.v
vlog -work work ../rtl/altera_phy/ip/pll/pll.v
vlog -work work ../rtl/altera_phy/ip/pll/pll/pll_0002.v
vlog -work work ../rtl/altera_phy/teng_phy.v

vlog -work work ../rtl/phy/loopback.v
vlog -work work +incdir+../rtl/include ../rtl/mac/teng_mac.v
vlog -work work +incdir+../rtl/include ../rtl/mac/decode_64b_66b.v
vlog -work work +incdir+../rtl/include ../rtl/mac/descramble.v
vlog -work work +incdir+../rtl/include ../rtl/mac/encode_64b_66b.v
vlog -work work +incdir+../rtl/include ../rtl/mac/scramble.v
vlog -work work +incdir+../rtl/include ../rtl/mac/rx_alignment.v
vlog -work work +incdir+../rtl/include ../rtl/mac/axis2xgmii32.v
vlog -work work +incdir+../rtl/include ../rtl/mac/xgmii2axis32.v
vlog -work work +incdir+../rtl/include ../rtl/mac/rx.v
vlog -work work +incdir+../rtl/include ../rtl/mac/tx.v
vlog -work work +incdir+../rtl/include ../rtl/mac/gearbox_64b_66b.v
vlog -work work +incdir+../rtl/include ../rtl/mac/gearbox_66b_64b.v
vlog -work work +incdir+../rtl/include ../rtl/mac/prbs_gen.v
vlog -work work +incdir+../rtl/include ../rtl/mac/prbs_check.v
vlog -work work +incdir+../rtl/include ../rtl/mac/prbs_test.v
vlog -work work +incdir+../rtl/include ../rtl/mac/prbs_any.v
vlog -work work +incdir+../rtl/include ../rtl/altera_xm_top.v

vlog -sv -work work ./sim_stream_master.sv
vlog -sv -work work ./tb_prbs_loopback.sv

# compile glbl module

vsim -voptargs="+acc" -L work -L work -L nphy -L xcvr_reconfig -L xcvr_reset -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixv_ver -L stratixv_hssi_ver tb_prbs_loopback
do altera_wave.do

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

view wave
view structure
view signals

run 1000ns
