#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)
NAMESPACE_OP="z-postgres-operator"
NAMESPACE_DBS="z-postgres"


# kubectl delete -k "${WORK_DIR}"/

helm uninstall postgres-operator -n "${NAMESPACE_OP}"
helm uninstall postgres-operator-ui -n "${NAMESPACE_OP}"

kubectl delete namespace "${NAMESPACE_OP}"
kubectl delete namespace "${NAMESPACE_DBS}"
# kubectl delete -f "${WORK_DIR}"/codes/pv.yml
