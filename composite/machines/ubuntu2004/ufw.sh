ufw allow in from 192.168.125.0/24 port 2376,2379,2380,9099,10250 proto tcp
ufw allow in from 192.168.125.0/24 port 8472 proto udp

ufw allow in from 192.168.125.0/24 port 80,443,2376,6443,9099,10250,10254,30000:32767 proto tcp
ufw allow in from 192.168.125.0/24 port 8472,30000:32767 proto udp

ufw allow in from 192.168.125.0/24 port 22,3389,80,443,2376,9099,10250,10254 proto tcp
ufw allow in from 192.168.125.0/24 port 8472,30000:32767 proto udp