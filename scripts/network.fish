#!/bin/fish

if ip link show enp2s0f1 | grep DOWN
  sudo ip link set up enp2s0f1 &> /dev/null && sudo dhcpcd &> /dev/null
end
