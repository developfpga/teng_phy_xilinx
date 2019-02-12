-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Tue Feb 12 20:02:39 2019
-- Host        : DESKTOP-4CFPTTR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/jack/Desktop/tmp/project_1/project_1.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_2/bd_efdb_0_dcm_locked_driver_0_stub.vhdl
-- Design      : bd_efdb_0_dcm_locked_driver_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku035-fbva676-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_efdb_0_dcm_locked_driver_0 is
  Port ( 
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end bd_efdb_0_dcm_locked_driver_0;

architecture stub of bd_efdb_0_dcm_locked_driver_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "dout[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xlconstant_v1_1_4_xlconstant,Vivado 2018.1";
begin
end;
