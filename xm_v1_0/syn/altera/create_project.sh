#!/bin/bash 
rm project -rf
mkdir project
cp prbs_* ./project
cd project
quartus prbs_test.qpf