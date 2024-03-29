
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
# ncsim - auto-generated simulation script

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
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "ncsim.sh", and modify text as directed.
# 
# You can also modify the simulation flow to suit your needs. Set the
# following variables to 1 to disable their corresponding processes:
# - SKIP_FILE_COPY: skip copying ROM/RAM initialization files
# - SKIP_DEV_COM: skip compiling the Quartus EDA simulation library
# - SKIP_COM: skip compiling Quartus-generated IP simulation files
# - SKIP_ELAB and SKIP_SIM: skip elaboration and simulation
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator. In this case, you must also copy the generated files
# # "cds.lib" and "hdl.var" - plus the directory "cds_libs" if generated - 
# # into the location from which you launch the simulator, or incorporate
# # into any existing library setup.
# #
# # Run Quartus-generated IP simulation script once to compile Quartus EDA
# # simulation libraries and Quartus-generated IP simulation files, and copy
# # any ROM/RAM initialization files to the simulation directory.
# # - If necessary, specify any compilation options:
# #   USER_DEFINED_COMPILE_OPTIONS
# #   USER_DEFINED_VHDL_COMPILE_OPTIONS applied to vhdl compiler
# #   USER_DEFINED_VERILOG_COMPILE_OPTIONS applied to verilog compiler
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1 \
# USER_DEFINED_COMPILE_OPTIONS=<compilation options for your design> \
# USER_DEFINED_VHDL_COMPILE_OPTIONS=<VHDL compilation options for your design> \
# USER_DEFINED_VERILOG_COMPILE_OPTIONS=<Verilog compilation options for your design> \
# QSYS_SIMDIR=<script generation output directory>
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the IP script)
# #
# ncvlog <compilation options> <design and testbench files>
# #
# # TOP_LEVEL_NAME is used in this script to set the top-level simulation or
# # testbench module/entity name.
# #
# # Run the IP script again to elaborate and simulate the top level:
# # - Specify TOP_LEVEL_NAME and USER_DEFINED_ELAB_OPTIONS.
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME=<simulation top> \
# USER_DEFINED_ELAB_OPTIONS=<elaboration options for your design> \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
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
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="E:/intelfpga/17.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

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
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/xcvr_reconfig/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/stratixv_ver/
mkdir -p ./libraries/stratixv_hssi_ver/
mkdir -p ./libraries/stratixv_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                      -work altera_ver           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                               -work lpm_ver              
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                  -work sgate_ver            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                              -work altera_mf_ver        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                          -work altera_lnsim_ver     
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_atoms_ncrypt.v"          -work stratixv_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_atoms.v"                         -work stratixv_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_hssi_atoms_ncrypt.v"     -work stratixv_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_hssi_atoms.v"                    -work stratixv_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_pcie_hip_atoms_ncrypt.v" -work stratixv_pcie_hip_ver
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_pcie_hip_atoms.v"                -work stratixv_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_xcvr_functions.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_h.sv"                                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_resync.sv"                                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_h.sv"                                                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_dfe_cal_sweep_h.sv"                                                   -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig.sv"                                                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_sv.sv"                                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cal_seq.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_cif.sv"                                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_uif.sv"                                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_basic_acq.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_analog.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_analog_sv.sv"                                               -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_datactrl.sv"                                               -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_rmw.sv"                                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xreconf_analog_ctrlsm.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation.sv"                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation_sv.sv"                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_sv.sv"                                               -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_ctrl_sv.sv"                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon_ber_sv.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/ber_reader_dcfifo.v"                                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/step_to_mon_sv.sv"                                                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/mon_to_step_sv.sv"                                                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_sv.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_reg_sv.sv"                                              -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sv.sv"                                              -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sweep_sv.sv"                                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sweep_datapath_sv.sv"                               -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_oc_cal_sv.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_pi_phase_sv.sv"                                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_step_to_mon_en_sv.sv"                                   -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_adapt_tap_sv.sv"                                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_ctrl_mux_sv.sv"                                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_local_reset_sv.sv"                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_cal_sim_sv.sv"                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe_adapt_tap_sim_sv.sv"                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce.sv"                                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce_sv.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_adce_datactrl_sv.sv"                                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_sv.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_cal.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_control.sv"                                             -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_datapath.sv"                                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_pll_reset.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_eye_width.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_align_clk.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_get_sum.sv"                                             -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_cal_sim_model.sv"                                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_mif.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif.sv"                                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif_ctrl.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_mif_avmm.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_pll.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_pll.sv"                                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_pll_ctrl.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_soc.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_ram.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_direct.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_addr.sv"                                                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_ch.sv"                                                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_l2p_rom.sv"                                                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_lif_csr.sv"                                                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xrbasic_lif.sv"                                                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_xcvr_reconfig_basic.sv"                                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_arbiter_acq.sv"                                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_basic.sv"                                                   -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_arbiter.sv"                                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_m2s.sv"                                                              -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_wait_generate.v"                                                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_csr_selector.sv"                                                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/sv_reconfig_bundle_to_basic.sv"                                               -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu.v"                                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_reconfig_cpu.v"                                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_reconfig_cpu_test_bench.v"                              -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0.v"                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_irq_mapper.sv"                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_reset_controller.v"                                                    -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_reset_synchronizer.v"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_master_translator.sv"                                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_slave_translator.sv"                                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_master_agent.sv"                                                -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_slave_agent.sv"                                                 -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_burst_uncompressor.sv"                                          -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_avalon_sc_fifo.v"                                                      -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router.sv"                            -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_001.sv"                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_002.sv"                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_003.sv"                        -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux.sv"                         -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux_001.sv"                     -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux.sv"                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/altera_merlin_arbitrator.sv"                                                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux_001.sv"                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux.sv"                           -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux_001.sv"                       -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter.v"                  -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv" -work xcvr_reconfig -cdslib ./cds_libs/xcvr_reconfig.cds.lib
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/xcvr_reconfig.v"                                                                                                                                            
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  export GENERIC_PARAM_COMPAT_CHECK=1
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
