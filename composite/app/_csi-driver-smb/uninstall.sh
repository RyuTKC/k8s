# # uninstall by applying yaml from git
# curl -skSL https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/deploy/uninstall-driver.sh | bash -s --

# install with helm 
helm uninstall csi-driver-smb -n kube-system