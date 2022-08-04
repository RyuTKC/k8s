curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -

mkdir /etc/rancher/rke2 -p
cp config.yaml /etc/rancher/rke2/config.yaml

systemctl enable rke2-agent.service
systemctl start rke2-agent.service