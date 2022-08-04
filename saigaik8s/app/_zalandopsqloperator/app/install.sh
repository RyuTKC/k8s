#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)
NAMESPACE_OP="z-postgres-operator"
NAMESPACE_DBS="z-postgres"

kubectl create namespace "${NAMESPACE_OP}"
kubectl create namespace "${NAMESPACE_DBS}"

# add repo for postgres-operator
helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator
# install the postgres-operator
helm upgrade --install postgres-operator postgres-operator-charts/postgres-operator \
    -n "${NAMESPACE_OP}"

# add repo for postgres-operator-ui
helm repo add postgres-operator-ui-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator-ui
# install the postgres-operator-ui
helm upgrade --install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui \
    -n "${NAMESPACE_OP}" \
    --values "${WORK_DIR}"/values.yml
