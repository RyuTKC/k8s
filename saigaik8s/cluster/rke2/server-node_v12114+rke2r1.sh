curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.21.14+rke2r1 sh -

mkdir -p /etc/rancher/rke2/
cp config.yaml /etc/rancher/rke2/config.yaml

systemctl enable rke2-server.service
systemctl start rke2-server.service


# slave-server-node
mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml