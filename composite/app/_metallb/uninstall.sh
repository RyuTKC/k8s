# # uninstall by applying yaml from git
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

# uninstall with helm 
helm uninstall metallb metallb/metallb -n metallb