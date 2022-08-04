WORK_DIR=$(cd $(dirname $0); pwd)

# uninstall by applying yaml from git
kubectl delete -k "${WORK_DIR}"/

GL_OPERATOR_VERSION=0.6.3 # https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/-/releases
PLATFORM=kubernetes # or "openshift"
kubectl delete -f https://gitlab.com/api/v4/projects/18899486/packages/generic/gitlab-operator/${GL_OPERATOR_VERSION}/gitlab-operator-${PLATFORM}-${GL_OPERATOR_VERSION}.yaml

kubectl delete namespace gitlab-system

# # install with helm 
# helm repo add jetstack https://charts.jetstack.io
# helm repo update
# kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
# helm install \
#   cert-manager jetstack/cert-manager \
#   --namespace cert-manager \
#   --create-namespace \
#   --version v1.8.0 \