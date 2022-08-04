#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace -n rook-ceph rook-ceph-cluster \
     rook-release/rook-ceph-cluster -f "${WORK_DIR}"/ceph-values.yaml