WORK_DIR=$(cd $(dirname $0); pwd)

helm upgrade metallb metallb/metallb -n metallb \
  -f "${WORK_DIR}"/pool.yaml