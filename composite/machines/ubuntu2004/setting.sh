user=swagger
mysetdir=/etc/mysettings
userdir=/home/${user}
mkdir -p $mysetdir

# 社内プロキシ設定
echo -e "\n## proxy setting"  >> $userdir/.bashrc
echo 'export http_proxy="http://proxy1.is.fujimic.com"' >> $userdir/.bashrc
echo 'export https_proxy=$http_proxy' >> $userdir/.bashrc

cp ~/FUJIMIC-CA.crt /usr/share/ca-certificates
"FUJIMIC-CA.crt" >> /etc/ca-certificates.conf
update-ca-cerfificates

# 125セグメントへのルート追加
ip addr add 192.168.122.10/24 dev enp1s0
ip addr add 192.168.125.10/24 dev enp6s0
ip route add 192.168.125.0/24 via 192.168.125.1

# rancher-node-inboundチェインを作成
## - tcpプロトコルでの受信ポート（destination port）80, 443へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N rancher-node-inbound
iptables -A rancher-node-inbound -m multiport -p tcp --dport 80,443 -j ACCEPT

# etcd-node-inboundチェインを作成
## - tcpプロトコルでの受信ポート（destination port）2376,2379,2380,9099,10250へのパケットアクセスを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの受信ポート（destination port）8472へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N etcd-node-inbound
iptables -A etcd-node-inbound -m multiport -p tcp --dport 2376,2379,2380,9099,10250 -j ACCEPT
iptables -A etcd-node-inbound -p udp --dport 8472 -j ACCEPT

# etcd-node-outboundチェインを作成
## - tcpプロトコルでの宛先ポート（destination port）443,2379,2380,6443,8472,9099へのパケットを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの宛先ポート（destination port）8472へのパケットを許可（ACCEPTターゲットを付加）
iptables -N etcd-node-outbound
iptables -A etcd-node-outbound -m multiport -p tcp --dport 443,2379,2380,6443,8472,9099 -j ACCEPT
iptables -A etcd-node-outbound -p udp --dport 8472 -j ACCEPT

# controlplane-node-inboundチェインを作成
## - tcpプロトコルでの受信ポート（destination port）80,443,2376,6443,9099,10250,10254,30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの受信ポート（destination port）8472,30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N controlplane-node-inbound
iptables -A controlplane-node-inbound -m multiport -p tcp --dport 80,443,2376,6443,9099,10250,10254,30000:32767 -j ACCEPT
iptables -A controlplane-node-inbound -m multiport -p udp --dport 8472,30000:32767 -j ACCEPT

# controlplane-node-outboundチェインを作成
## - tcpプロトコルでの宛先ポート（destination port）443,2379,2380,9099,10250,10254へのパケットアクセスを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの宛先ポート（destination port）8472へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N controlplane-node-outbound
iptables -A controlplane-node-outbound -m multiport -p tcp --dport 443,2379,2380,9099,10250,10254 -j ACCEPT
iptables -A controlplane-node-outbound -m multiport -p udp --dport 8472 -j ACCEPT

# worker-node-inboundチェインを作成
## - tcpプロトコルでの受信ポート（destination port）80,443,2376,9099,10250,10254,30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの受信ポート（destination port）30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N worker-node-inbound
iptables -A worker-node-inbound -m multiport -p tcp --dport 80,443,2376,9099,10250,10254,30000:32767 -j ACCEPT
iptables -A worker-node-inbound -m multiport -p udp --dport 8472,30000:32767 -j ACCEPT

# worker-node-outboundチェインを作成
## - tcpプロトコルでの宛先ポート（destination port）80,443,2376,9099,10250,10254,30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
## - udpプロトコルでの宛先ポート（destination port）30000~32767へのパケットアクセスを許可（ACCEPTターゲットを付加）
iptables -N worker-node-outbound
iptables -A worker-node-outbound -m multiport -p tcp --dport 443,6443,9099,10254 -j ACCEPT
iptables -A worker-node-outbound -m multiport -p udp --dport 8472 -j ACCEPT

# worker-internalチェインを作成
## - 複数ポートにおいて、10.0.0.0/8からのパケットアクセスを許可（ACCEPTターゲットを付加）
## - 複数ポートにおいて、172.16.0.0/12からのパケットアクセスを許可（ACCEPTターゲットを付加）
## - 複数ポートにおいて、192.168.0.0/16からのパケットアクセスを許可（ACCEPTターゲットを付加）
## - 複数ポートにおいて、<Worker Node IP>からのパケットアクセスを許可（ACCEPTターゲットを付加）
## - 複数ポートにおいて、<Worker Node IP>からのパケットアクセスを許可（ACCEPTターゲットを付加）
## ...
iptables -N worker-internal
iptables -A worker-internal --source 192.168.125.0/24 -j ACCEPT

# INPUTチェインに順番に各inboundチェインを追加
iptables -I INPUT 1 -j rancher-node-inbound
iptables -I INPUT 2 -j etcd-node-inbound
iptables -I INPUT 3 -j controlplane-node-inbound
iptables -I INPUT 4 -j worker-node-inbound
iptables -I INPUT 5 -j worker-internal

# OUTPUTチェインに順番に各outboundチェインを追加
iptables -I OUTPUT 1 -j etcd-node-outbound
iptables -I OUTPUT 2 -j controlplane-node-outbound
iptables -I OUTPUT 3 -j worker-node-outbound

iptables-save
iptables-save > $mysetdir/iptables.rule
echo "iptables-restore < {$mysetdir}/iptables.rule" >> ~/.bashrc