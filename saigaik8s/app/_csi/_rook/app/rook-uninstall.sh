#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm ls --namespace rook-ceph
helm delete -n rook-ceph rook-ceph


for CRD in $(kubectl get crd -n rook-ceph | awk '/ceph.rook.io/ {print $1}'); do
    kubectl get -n rook-ceph "$CRD" -o name | \
    xargs -I {} kubectl patch -n rook-ceph {} --type merge -p '{"metadata":{"finalizers": [null]}}'
done