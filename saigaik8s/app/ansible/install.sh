WORK_DIR=$(cd $(dirname $0); pwd)

helm repo add awx-operator https://ansible.github.io/awx-operator/
helm repo update
helm install awx-operator awx-operator/awx-operator

kubectl apply -k "${WORK_DIR}"/