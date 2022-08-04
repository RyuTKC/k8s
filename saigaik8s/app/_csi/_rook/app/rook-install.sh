#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm repo add rook-release https://charts.rook.io/release
helm install \
      -n rook-ceph --create-namespace \
      rook-ceph rook-release/rook-ceph \
      -f "${WORK_DIR}"/rook-values.yaml