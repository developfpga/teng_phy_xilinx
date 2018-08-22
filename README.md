# teng_phy_xilinx

10g low latency phy for xilinx ultra-scale device

Start from normal 10g baser config:<br>
1, async gearbox for 64B/66B<br>
2, user data width & internal data width are both 32 bit<br>
3, enable buffer<br>

first step,    add xgmii interface support<br>
second step, add mac stream interface support<br>

![](https://gitlab.com/developfpga/teng_phy_xilinx/raw/master/doc/xgmii_txc_txd_decode.PNG)
![](https://gitlab.com/developfpga/teng_phy_xilinx/raw/master/doc/64b_66b_coding.PNG)
