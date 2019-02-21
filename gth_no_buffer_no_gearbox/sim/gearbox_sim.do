vlib work
vmap work work

# Compile verilog src

vlog -work work ../rtl/gearbox_64b_66b.v
vlog -work work ../rtl/gearbox_66b_64b.v
vlog -work work ../../baser/rtl/rx_alignment.v
vlog -sv -work work ./tb_gearbox_loopback.sv

# Generate wlf, ###### Change the test_bench
vsim -voptargs="+acc" -wlf test.wlf tb_gearbox_loopback

# Add wave #-depth 3
# add wave -recursive *
log -r *
do gearbox_wave.do


run 0.3 ms
# run -all

# quit -sim