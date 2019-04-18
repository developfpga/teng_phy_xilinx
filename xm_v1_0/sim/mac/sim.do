##
##  By David
##
##  2019.4.17
##////////////////////////////////////////////////////////////////////////////

vlib work
vmap work work

vlog -work work +incdir+../../rtl/include ../../rtl/mac/teng_mac.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/decode_64b_66b.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/descramble.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/encode_64b_66b.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/scramble.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/rx_alignment.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/axis2xgmii32.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/xgmii2axis32.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/rx.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/tx.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/gearbox_64b_66b.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/gearbox_66b_64b.v
vlog -work work +incdir+../../rtl/include ../../rtl/mac/loopback.v

vlog -sv -work work ../normal_pkg.sv
vlog -sv -work work ../stream_pkg.sv
vlog -sv -work work ./tb_mac_loopback.sv


vsim -voptargs="+acc" -lib work work.tb_mac_loopback

do wave.do

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

view wave
view structure
view signals

run -a
