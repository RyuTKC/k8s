REGISTRY_HOST="registry.saigai-ansible.com"
# x.509自己証明書
openssl req -x509 \
            # 暗号化なし、10年
            -nodes -days 3650 \
            # 暗号化方式
            -newkey rsa:2048 \
            # 証明書、秘密鍵出力
            -out ./tls.crt -keyout ./tls.key \
            # 主体者・組織名、主体者別名
            -subj "/CN=${REGISTRY_HOST}/O=${REGISTRY_HOST}" -addext "subjectAltName = DNS:${REGISTRY_HOST}"

#dnsで登録のプロセスを行わないなら、/etc/hostsに以下を書き込むこと
# 192.168.122.2 registry.saigai-ansible.com

sudo tee /etc/docker/daemon.json <<EOF
{
  "insecure-registries" : ["${REGISTRY_HOST}"]
}
EOF
sudo systemctl restart docker