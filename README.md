# teng_phy_xilinx

10g low latency phy for xilinx ultra-scale device

Start from normal 10g baser config:<br>
1, async gearbox for 64B/66B<br>
2, user data width & internal data width are both 32 bit<br>
3, enable buffer<br>

first step,    add xgmii interface support<br>
second step, add mac stream interface support<br>


TXC      TXD       Description PLS_DATA.request parameter<br>
0    00 through FF Normal data transmission ZERO, ONE (eight bits)<br>
1    00 through 05 Reserved —<br>
1        06        Only valid on all four lanes simultaneously to request LPI No applicable parameter(normal interframe)<br>
1        07        Idle No applicable parameter (Normal inter-frame)<br>
1    08 through 9B Reserved —<br>
1        9C        Sequence (only valid in lane 0) No applicable parameter (Inter-frame status signal)<br>
1    9D through FA Reserved —<br>
1        FB        Start (only valid in lane 0) No applicable parameter, replaces first eight ZERO, ONE of a frame (preamble octet)<br>
1        FC        Reserved —<br>
1        FD        Terminate DATA_COMPLETE<br>
1        FE        Transmit error propagation No applicable parameter<br>
1        FF        Reserved —<br>
NOTE—Values in TXD column are in hexadecimal, most significant bit to least significant bit (i.e., <7:0>).<br>