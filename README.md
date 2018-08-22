# teng_phy_xilinx

10g low latency phy for xilinx ultra-scale device

Start from normal 10g baser config:
1, async gearbox for 64B/66B
2, user data width & internal data width are both 32 bit
3, enable buffer

first step, add xgmii interface support
second step, add mac stream interface support


TXC      TXD       Description PLS_DATA.request parameter
0    00 through FF Normal data transmission ZERO, ONE (eight bits)
1    00 through 05 Reserved —
1        06        Only valid on all four lanes simultaneously to request LPI No applicable parameter(normal interframe)
1        07        Idle No applicable parameter (Normal inter-frame)
1    08 through 9B Reserved —
1        9C        Sequence (only valid in lane 0) No applicable parameter (Inter-frame status signal)
1    9D through FA Reserved —
1        FB        Start (only valid in lane 0) No applicable parameter, replaces first eight ZERO, ONE of a frame (preamble octet)
1        FC        Reserved —
1        FD        Terminate DATA_COMPLETE
1        FE        Transmit error propagation No applicable parameter
1        FF        Reserved —
NOTE—Values in TXD column are in hexadecimal, most significant bit to least significant bit (i.e., <7:0>).