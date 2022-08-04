WORK_DIR=$(cd $(dirname $0); pwd)

kubectl create namespace gitlab-system

# install by applying yaml from git
GL_OPERATOR_VERSION=0.6.3 # https://gitlab.com/gitlab-org/cloud-native/gitlab-operator/-/releases
PLATFORM=kubernetes # or "openshift"
kubectl apply -f https://gitlab.com/api/v4/projects/18899486/packages/generic/gitlab-operator/${GL_OPERATOR_VERSION}/gitlab-operator-${PLATFORM}-${GL_OPERATOR_VERSION}.yaml

# kubectl apply -k "${WORK_DIR}"/

# # install with helm 
# helm repo add gitlab-operator https://gitlab.com/api/v4/projects/18899486/packages/helm/stable
# helm repo update
# helm install gitlab-operator gitlab-operator/gitlab-operator --create-namespace --namespace gitlab-system