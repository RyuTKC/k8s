#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm upgrade rook-ceph rook-release/rook-ceph -n rook-ceph \
      -f "${WORK_DIR}"/rook-values.yaml