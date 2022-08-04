WORK_DIR=$(cd $(dirname $0); pwd)

# uninstall by applying yaml from git
# kubectl delete -k "${WORK_DIR}"/

helm uninstall gitlab-helm -n gitlab-helm

# kubectl delete secret/gitlab-postgresql-password -n gitlab-helm
kubectl delete -k "${WORK_DIR}"/
