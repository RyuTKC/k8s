# # uninstall by applying yaml from git
# kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/baremetal/deploy.yaml

# uninstall with helm 
helm uninstall ingress-nginx -n ingress-nginx