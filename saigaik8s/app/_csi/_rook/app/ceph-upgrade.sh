#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm upgrade rook-ceph-cluster rook-release/rook-ceph-cluster -n rook-ceph \
     -f "${WORK_DIR}"/ceph-values.yaml