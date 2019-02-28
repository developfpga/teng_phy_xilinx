vlib work
vmap work work

# Compile verilog src

vlog -work work ../rtl/gearbox_64b_66b.v
vlog -work work ../rtl/gearbox_66b_64b.v
vlog -work work ../../gth_no_buffer_with_gearbox/ref/gtwizard/imports/gtwizard_ultrascale_0_example_reset_sync.v
vlog -work work ../../gth_no_buffer_with_gearbox/ref/gtwizard/imports/gtwizard_ultrascale_0_example_checking_64b66b.v
vlog -work work ../../gth_no_buffer_with_gearbox/ref/gtwizard/imports/gtwizard_ultrascale_0_example_stimulus_64b66b.v
vlog -work work ../../gth_no_buffer_with_gearbox/ref/gtwizard/imports/gtwizard_ultrascale_0_prbs_any.v
vlog -sv -work work ./tb_gearbox_prbs.sv

# Generate wlf, ###### Change the test_bench
vsim -voptargs="+acc" -wlf test.wlf tb_gearbox_prbs

# Add wave #-depth 3
# add wave -recursive *
log -r *
do prbs_wave.do


run 0.3 ms
# run -all

# quit -sim