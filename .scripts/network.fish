#!/bin/fish

sudo ip link set up enp2s0f1 &> /dev/null
sudo dhcpcd &> /dev/null

