WORK_DIR=$(cd $(dirname $0); pwd)

helm uninstall awx-operator awx-operator/awx-operator

kubectl delete -k "${WORK_DIR}"/