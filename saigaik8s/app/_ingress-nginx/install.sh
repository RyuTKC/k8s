#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

# # install by applying yaml from git
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/baremetal/deploy.yaml

# install with helm 
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  -f "${WORK_DIR}"/values.yaml