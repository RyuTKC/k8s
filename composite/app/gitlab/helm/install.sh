WORK_DIR=$(cd $(dirname $0); pwd)

kubectl apply -k "${WORK_DIR}"/
# kubectl create secret generic gitlab-postgresql-password \
#       --namespace gitlab-helm \
#       --from-literal postgresql-password='gitlab-123' \
#       --from-literal postgresql-postgres-password='gitlab-123'


# # install with helm 
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab-helm gitlab/gitlab \
  --timeout 600s \
  --namespace gitlab-helm \
  --values "${WORK_DIR}"/original.yml
