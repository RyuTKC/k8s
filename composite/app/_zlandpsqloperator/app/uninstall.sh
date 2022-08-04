WORK_DIR=$(cd $(dirname $0); pwd)
NAMESPACE="z-postgres-operator"

# kubectl delete -k "${WORK_DIR}"/

helm uninstall postgres-operator -n "${NAMESPACE}"
helm uninstall postgres-operator-ui -n "${NAMESPACE}"

kubectl delete namespace "${NAMESPACE}"
# kubectl delete -f "${WORK_DIR}"/codes/pv.yml
