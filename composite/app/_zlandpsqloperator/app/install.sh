WORK_DIR=$(cd $(dirname $0); pwd)
NAMESPACE="z-postgres-operator"

kubectl create namespace "${NAMESPACE}"

# add repo for postgres-operator
helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator
# install the postgres-operator
helm upgrade --install postgres-operator postgres-operator-charts/postgres-operator \
    -n "${NAMESPACE}"

# add repo for postgres-operator-ui
helm repo add postgres-operator-ui-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator-ui
# install the postgres-operator-ui
helm upgrade --install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui \
    -n "${NAMESPACE}" \
    --values "${WORK_DIR}"/values.yml