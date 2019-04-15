
# (C) 2001-2019 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 17.1 590 win32 2019.04.10.22:15:49

# ----------------------------------------
# vcs - auto-generated simulation script

# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     xcvr_reconfig
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level shell script that compiles Altera simulation libraries
# and the Quartus-generated IP in your project, along with your design and
# testbench files, follow the guidelines below.
# 
# 1) Copy the shell script text from the TOP-LEVEL TEMPLATE section
# below into a new file, e.g. named "vcs_sim.sh".
# 
# 2) Copy the text from the DESIGN FILE LIST & OPTIONS TEMPLATE section into
# a separate file, e.g. named "filelist.f".
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # TOP_LEVEL_NAME is used in the Quartus-generated IP simulation script to
# # set the top-level simulation or testbench module/entity name.
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# # Source the Quartus-generated IP simulation script and do the following:
# # - Compile the Quartus EDA simulation library and IP simulation files.
# # - Specify TOP_LEVEL_NAME and QSYS_SIMDIR.
# # - Compile the design and top-level simulation module/entity using
# #   information specified in "filelist.f".
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# # - Run the simulation.
# #
# source <script generation output directory>/synopsys/vcs/vcs_setup.sh \
# TOP_LEVEL_NAME=<simulation top> \
# QSYS_SIMDIR=<script generation output directory> \
# USER_DEFINED_ELAB_OPTIONS="\"-f filelist.f\"" \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# ----------------------------------------
# # DESIGN FILE LIST & OPTIONS TEMPLATE - BEGIN
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the Quartus-generated IP simulation script)
# #
# +systemverilogext+.sv
# <design and testbench files, compile-time options, elaboration options>
# #
# # DESIGN FILE LIST & OPTIONS TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If xcvr_reconfig is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 17.1 590 win32 2019.04.10.22:15:49
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="xcvr_reconfig"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="E:/intelfpga/17.1/quartus/"
SKIP_FILE_COPY=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"
# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# copy RAM/ROM files to simulation directory

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_hssi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_hssi_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_pcie_hip_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_pcie_hip_atoms.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_xcvr_functions.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_h.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_resync.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_h.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_dfe_cal_sweep_h.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cal_seq.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_cif.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_uif.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_basic_acq.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_analog.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_analog_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_datactrl.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_rmw.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_ctrlsm.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_ctrl_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_ber_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/ber_reader_dcfifo.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/step_to_mon_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/mon_to_step_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_reg_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sweep_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sweep_datapath_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_oc_cal_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_pi_phase_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_step_to_mon_en_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_adapt_tap_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_ctrl_mux_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_local_reset_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sim_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_adapt_tap_sim_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce_datactrl_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_sv.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_cal.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_control.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_datapath.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_pll_reset.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_eye_width.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_align_clk.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_get_sum.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_cal_sim_model.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_mif.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif_ctrl.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif_avmm.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_pll.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_pll.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_pll_ctrl.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_soc.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_ram.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_direct.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_addr.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_ch.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_rom.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_lif_csr.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_lif.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_basic.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_arbiter_acq.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_basic.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_arbiter.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_m2s.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_wait_generate.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_csr_selector.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/sv_reconfig_bundle_to_basic.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_reconfig_cpu.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_reconfig_cpu_test_bench.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_irq_mapper.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_reset_controller.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_master_translator.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_master_agent.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_slave_agent.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_burst_uncompressor.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_avalon_sc_fifo.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_001.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_002.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_003.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux_001.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_arbitrator.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux_001.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux_001.sv \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter.v \
  $QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv \
  $QSYS_SIMDIR/xcvr_reconfig.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
