#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

# # install by applying yaml from git
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

# install with helm 
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb -n metallb --create-namespace \
              # -f "${WORK_DIR}"/pool.yaml