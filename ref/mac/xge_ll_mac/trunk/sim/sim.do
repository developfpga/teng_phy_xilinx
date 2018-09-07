vlib work
vmap work work

# Compile verilog src
vlog +incdir+../rtl ../rtl/oc_mac.v
vlog +incdir+../rtl ../rtl/rx_control.v
vlog +incdir+../rtl ../rtl/rx_enqueue.v
vlog +incdir+../rtl ../rtl/tx_control.v
vlog +incdir+../rtl ../rtl/tx_dequeue.v
vlog -sv +incdir+../rtl ./tb_single_loopback.sv


# compile glbl module
vlog glbl.v

vsim -voptargs="+acc"  tb_single_loopback work.glbl

do {wave.do}

log -r *


run 20us
