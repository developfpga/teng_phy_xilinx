-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Tue Feb 12 20:02:39 2019
-- Host        : DESKTOP-4CFPTTR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/jack/Desktop/tmp/project_1/project_1.srcs/sources_1/ip/axi_10g_ethernet_0/bd_0/ip/ip_2/bd_efdb_0_dcm_locked_driver_0_sim_netlist.vhdl
-- Design      : bd_efdb_0_dcm_locked_driver_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku035-fbva676-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_efdb_0_dcm_locked_driver_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bd_efdb_0_dcm_locked_driver_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bd_efdb_0_dcm_locked_driver_0 : entity is "bd_efdb_0_dcm_locked_driver_0,xlconstant_v1_1_4_xlconstant,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of bd_efdb_0_dcm_locked_driver_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of bd_efdb_0_dcm_locked_driver_0 : entity is "xlconstant_v1_1_4_xlconstant,Vivado 2018.1";
end bd_efdb_0_dcm_locked_driver_0;

architecture STRUCTURE of bd_efdb_0_dcm_locked_driver_0 is
  signal \<const1>\ : STD_LOGIC;
begin
  dout(0) <= \<const1>\;
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
end STRUCTURE;
