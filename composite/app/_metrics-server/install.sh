# install by applying yaml from git
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# install by applying yaml from git (HA mode)
# kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability.yaml

# # install with helm 
# helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
# helm upgrade --install metrics-server metrics-server/metrics-server